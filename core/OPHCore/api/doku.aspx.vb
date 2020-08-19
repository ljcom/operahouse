Imports System.IO
Imports System.Net
Imports System.Xml
Imports System.Data
Imports System.Data.SqlClient

Partial Class OPHCore_API_doku

    Inherits cl_base

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        writeLog(Session("hostGUID"))
        loadAccount()

        Dim curODBC = session("ODBC")
        'Dim DBCore = contentOfsqDB
        'Dim curHostGUID = Session("hostGUID")
        Dim curUserGUID = Session("userGUID")
		Dim curHostGUID = getSession()
        writeLog(Session("hostGUID"))

        Dim sqlstr = ""
        Dim noxml = False
        'Dim isValid = False
        Dim appSettings = ConfigurationManager.AppSettings

        Dim isSingle = True
        Dim xmlstr = ""
        Dim xmlstr1 = ""

        Dim mode = getQueryVar("mode")
        If mode = "" Then
            mode = Request.Form("mode")
        End If

        Select Case mode
			case "payment"
				Dim code = getQueryVar("code")
                Dim GUID = getQueryVar("GUID")
				sqlstr = "exec api.[function] @hostguid='" & curHostGUID & "', @mode='payment', @code='" & code & "', @guid='" & GUID & "', @comment=''"
				writeLog(sqlstr)
				 Dim url=""
				dim ds as DataSet = SelectSqlSrvRows(sqlstr)
				if ds.tables.count>0 AndAlso ds.Tables(0).Rows.Count > 0 Then
					dim basket="BASKET="+ds.Tables(0).Rows(0).Item(0).ToString
					dim amount="&AMOUNT="+ds.Tables(0).Rows(0).Item(1).ToString
					dim purchaseamount="&PURCHASEAMOUNT="+ds.Tables(0).Rows(0).Item(2).ToString
					dim mallid="&MALLID="+ds.Tables(0).Rows(0).Item(3).ToString
					dim chainmerchant="&CHAINMERCHANT="+ds.Tables(0).Rows(0).Item(4).ToString
					dim words="&WORDS="+ds.Tables(0).Rows(0).Item(5).ToString
					dim xcurrency="&CURRENCY="+ds.Tables(0).Rows(0).Item(6).ToString
					dim purchasecurrency="&PURCHASECURRENCY="+ds.Tables(0).Rows(0).Item(7).ToString
					dim transidmerchant="&TRANSIDMERCHANT="+ds.Tables(0).Rows(0).Item(8).ToString
					dim PAYMENTCHANNEL="&PAYMENTCHANNEL="+ds.Tables(0).Rows(0).Item(9).ToString
					dim requestdatetime="&REQUESTDATETIME="+ds.Tables(0).Rows(0).Item(10).ToString
					dim sid="&SESSIONID="&curHostGUID
					dim EMAIL="&EMAIL="+ds.Tables(0).Rows(0).Item(11).ToString
					dim NAME="&NAME="+ds.Tables(0).Rows(0).Item(12).ToString
					dim urlx=ds.Tables(0).Rows(0).Item(13).ToString
					url=urlx & basket & amount & purchaseamount & xCURRENCY & PURCHASECURRENCY & mallid & chainmerchant & TRANSIDMERCHANT & WORDS & REQUESTDATETIME & sid & PAYMENTCHANNEL & EMAIL & NAME
					response.write(url)
					reloadURL(url, true, 1)
				else response.write("400 Bad Request")
				end if
				
				
            Case "notify"
                Dim statuscode = Request.Form("RESPONSECODE")
                Dim paymentcode = Request.Form("PAYMENTCODE")
                Dim paymentchannel = Request.Form("PAYMENTCHANNEL")
                Dim transid = Request.Form("TRANSIDMERCHANT")
                Dim approvalcode = Request.Form("APPROVALCODE")
                Dim resultmsg = Request.Form("RESULTMSG")
                Dim paymentdate = Request.Form("PAYMENTDATETIME")
                writeLog(statuscode)
                writeLog(paymentcode)
                writeLog(paymentchannel)
                writeLog("t:" & transid)
                writeLog("a:" & approvalcode)
                writeLog("r:" & resultmsg)
                writeLog("d:" & paymentdate)

                sqlstr = ""

                'credit card
				'if curHostGUID="" then curHostGUID="null"
				'else curHostGUID="'" & curHostGUID & "'"
                
				If paymentchannel = "15" And resultmsg = "SUCCESS" Then 'credit card success
                    setCookie("cartID", "", 0)
                    sqlstr = "exec doc.after_midtrans '" & transid & "'"
                    writeLog("mode doku credit card finish orderid_id (" & transid & ") status (" & statuscode & ") : " & sqlstr)
                    xmlstr = runSQLwithResult(sqlstr)
                    Response.Write("CONTINUE")
                ElseIf paymentchannel = "15" And resultmsg = "FAILED" Then 'credit card failed
                    writeLog("mode doku credit card failed orderid_id (" & transid & ") status (" & statuscode & ") : " & sqlstr)
                    Response.Write("STOP")
                ElseIf paymentchannel = "36" Then 'Bank Transfer Virtual Account
                    setCookie("cartID", "", 0)
                    sqlstr = "exec doc.after_midtrans '" & transid & "'"
                    writeLog("mode doku bank transfer orderid_id (" & transid & ") status (" & statuscode & ") : " & sqlstr)
                    xmlstr = runSQLwithResult(sqlstr)
                    Response.Write("CONTINUE")
                Else
                    Response.Write("CONTINUE")
                End If
            Case "redirect"
                Dim statuscode = Request.Form("STATUSCODE")
                Dim paymentcode = Request.Form("PAYMENTCODE")

                'paymentchannel: 15 creditcard, 36 Virtual Account
                Dim paymentchannel = Request.Form("PAYMENTCHANNEL")

                Dim transid = getQueryVar("TRANSIDMERCHANT")
                If transid = "" Then
                    transid = Request.Form("TRANSIDMERCHANT")
                End If
                writeLog(statuscode)
                writeLog(paymentchannel)
                writeLog("t:" & transid)
                writeLog("odbc:" & curODBC)
                writeLog(Session("hostGUID"))
                Dim hGUID = Session("hostGUID")

                If transid <> "" Then
                    'ssesion lost after back from doku. get the last one
                    sqlstr = "exec doc.tapcso_getHost '" & transid & "'"
                    hGUID = runSQLwithResult(sqlstr, curODBC)
                    hGUID = "&hostguid=" & hGUID

                    If statuscode = "0000" Then 'success
                        setCookie("cartID", "", 0)
                        writeLog("../../index.aspx?code=tapcs3" & hGUID)
                        Response.Redirect("../../index.aspx?code=tapcs3" & hGUID)
                        'ElseIf paymentchannel <> "15" Then
                        'setCookie("cartID", "", 0)
                        'writeLog("../../index.aspx?code=account" & hGUID)
                        'Response.Redirect("../../index.aspx?code=account" & hGUID)
                    Else
                        Dim r As String = ""
                        If transid <> "" Then
                            sqlstr = "exec gen.getGUID '" & transid & "'"
                            writeLog(sqlstr)
                            r = runSQLwithResult(sqlstr, curODBC)
                        End If
                        If r <> "" Then
                            writeLog("../../index.aspx?code=tapcs2&GUID=" & r & hGUID)
                            Response.Redirect("../../index.aspx?code=tapcs2&GUID=" & r & hGUID)
                        Else
                            writeLog("../../index.aspx?code=account&hostguid=" & hGUID)
                            Response.Redirect("../../index.aspx?code=account" & hGUID)
                        End If
                    End If


                Else
                    Response.Redirect("../../index.aspx")
                End If

        End Select

    End Sub

End Class
