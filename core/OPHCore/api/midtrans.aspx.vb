Imports System.IO
Imports System.Net
Imports System.Net.WebRequest
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Imports System.Xml
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient

Partial Class OPHCore_API_midtrans

    Inherits cl_base

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        if getQueryVar("hostguid")<>"" then Session("hostGUID")=getQueryVar("hostguid")
		writeLog(Session("hostGUID"))
        loadAccount()

        Dim curODBC = session("ODBC")

        'Dim curODBC = Session("ODBC")
        'Dim DBCore = contentOfsqDB
        Dim curHostGUID = Session("hostGUID")
        Dim curUserGUID = Session("userGUID")

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
            Case "payment"
                Dim code = getQueryVar("code")
                Dim GUID = getQueryVar("GUID")
                sqlstr = "exec api.[function] @hostguid='" & curHostGUID & "', @mode='payment2', @code='" & code & "', @guid='" & GUID & "', @comment=''"
                'xmlstr = runSQLwithResult(sqlstr)
                'xmlstr = "{""transaction_details"": {""order_id"": ""SO001"",""gross_amount"": 11000}, ""item_details"": [{""id"": ""00000"", ""price"": 10000, ""name"": ""Item 1"", ""quantity"": 1},{""id"": ""00001"", ""price"": 1000, ""name"": ""PPN 10%"", ""quantity"": 1}], ""enabled_payments"": [""credit_card""], ""credit_card"": {""secure"":true},""customer_details"": {""first_name"": ""Customer"", ""email"": ""customer@gmail.com""}}"
                Dim url As String = ""
                Dim json As String = ""
                Dim serverkey As String = ""
				response.write(curODBC)
				response.write(sqlstr)
                Dim ds As DataSet = SelectSqlSrvRows(sqlstr, curODBC)
                If ds.tables.count > 0 AndAlso ds.Tables(0).Rows.Count > 0 Then
					response.write("d")
                    url = ds.Tables(0).Rows(0).Item(0).ToString
                    serverkey = ds.Tables(0).Rows(0).Item(1).ToString
                    json = ds.Tables(0).Rows(0).Item(2).ToString
                    response.write(url)
                    response.write(json)
                    'reloadURL(url, True, 1)

					ServicePointManager.Expect100Continue = True
					ServicePointManager.SecurityProtocol = 3072

					Dim cli = New WebClient()
					'cli.Proxy = New WebProxy("10.112.20.80", 8080)
					cli.Headers(HttpRequestHeader.ContentType) = "application/json"
					cli.Headers(HttpRequestHeader.Accept) = "application/json"

					'Dim serverkey = "SB-Mid-server-Q8A5YgsHLF-DbCKaa9m9CHNA" 'liberty
					'Dim serverkey = "SB-Mid-server-hKaSAFBUgsTTshZxn8PK2g1Q" 'sandbox
					'Dim serverkey = serverkey	'"SB-Mid-server-XX_e6bZIOCwKrbwT_fFeWd-u" 'sandbox liberty
					'Dim serverkey = "Mid-server-Iyid57b2P0ckq2v60T8Dacf1"
					Dim username = serverkey
					Dim password = ""

					Dim base64Decoded As String = username + ":" + password
					Dim base64Encoded As String

					Dim data As Byte()
					data = System.Text.ASCIIEncoding.ASCII.GetBytes(base64Decoded)
					base64Encoded = System.Convert.ToBase64String(data)

					cli.Headers(HttpRequestHeader.Authorization) = String.Format("Basic {0}", base64Encoded)
					cli.Encoding = Encoding.UTF8

					Dim postarray As Byte() = Encoding.ASCII.GetBytes(json)
					Try

						Dim responseArray As Byte() = cli.UploadData(url, postarray) 'sandbox
						Dim jsonResp As String = Encoding.ASCII.GetString(responseArray)
						Dim ser As JObject = JObject.Parse(jsonResp)
						Dim jsonRespdata As List(Of JToken) = ser.Children().ToList
						Dim output As String = ""
						Dim Token As String = ""
						Dim RedirectURL As String = ""
						For Each item As JProperty In jsonRespdata
							item.CreateReader()
							Select Case item.Name
								Case "Token"
									Token = item.Value
								Case "redirect_url"
									RedirectURL = item.Value

							End Select
						Next
						xmlstr = "<script>window.location='" & RedirectURL & "';</script>"
						Response.Write(xmlstr)

					Catch exp As Exception
						xmlstr = "<sqroot><message>" & exp.Message & "</message></sqroot>"
						Response.Write(xmlstr)
					End Try
                Else response.write("400 Bad Request")
                End If

            Case "gettransaction"
                Dim code = getQueryVar("code")
                Dim GUID = getQueryVar("GUID")
                sqlstr = "exec api.checkdata '" & curHostGUID & "','" & code & "', '" & GUID & "'"
                xmlstr = runSQLwithResult(sqlstr)


                If xmlstr.Contains("message") Then
                    Response.Write(xmlstr)
                Else
                    xmlstr = "<sqroot><transaction>" + xmlstr + "</transaction></sqroot>"
                    Response.Write(xmlstr)
                End If

            Case "checkdatatest"
                Dim code = getQueryVar("code")
                Dim GUID = getQueryVar("GUID")
				dim urlx=""
                sqlstr = "exec api.checkdata '" & curHostGUID & "','" & code & "', '" & GUID & "'"
                xmlstr = runSQLwithResult(sqlstr)

                Dim cli = New WebClient()
                cli.Proxy = New WebProxy("10.112.20.80", 8080)
                cli.Headers(HttpRequestHeader.ContentType) = "application/json"
                cli.Headers(HttpRequestHeader.Accept) = "application/json"

                'Dim serverkey = "SB-Mid-server-Q8A5YgsHLF-DbCKaa9m9CHNA" 'liberty
                Dim serverkey = "SB-Mid-server-hKaSAFBUgsTTshZxn8PK2g1Q" 'sandbox
                'Dim serverkey = "Mid-server-Iyid57b2P0ckq2v60T8Dacf1"
                Dim username = serverkey
                Dim password = ""

                Dim base64Decoded As String = username + ":" + password
                Dim base64Encoded As String

                Dim data As Byte()
                data = System.Text.ASCIIEncoding.ASCII.GetBytes(base64Decoded)
                base64Encoded = System.Convert.ToBase64String(data)

                cli.Headers(HttpRequestHeader.Authorization) = String.Format("Basic {0}", base64Encoded)
                cli.Encoding = Encoding.UTF8

                Dim json = xmlstr
                'System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3
                'json = "{'transaction_details':  {'order_id': '0000001','gross_amount': 490000}}" 'simple json
                If xmlstr.Contains("message") Then
                    Response.Write(xmlstr)
                Else

                    Dim postarray As Byte() = Encoding.ASCII.GetBytes(json)
                    Try
                        Dim responseArray As Byte() = cli.UploadData(urlx, postarray) 'sandbox
                        Dim jsonResp As String = Encoding.ASCII.GetString(responseArray)
                        Dim ser As JObject = JObject.Parse(jsonResp)
                        Dim jsonRespdata As List(Of JToken) = ser.Children().ToList
                        Dim output As String = ""
                        Dim Token As String = ""
                        Dim RedirectURL As String = ""
                        For Each item As JProperty In jsonRespdata
                            item.CreateReader()
                            Select Case item.Name
                                Case "token"
                                    Token = item.Value
                                Case "redirect_url"
                                    RedirectURL = item.Value
                                    'output += "Comments:" + vbCrLf
                                    'For Each comment As JObject In item.Values
                                    '    Dim u As String = comment("user")
                                    '    Dim d As String = comment("date")
                                    '    Dim c As String = comment("comment")
                                    '    output += u + vbTab + d + vbTab + c + vbCrLf
                                    'Next



                            End Select
                        Next
                        xmlstr = "<sqroot><newurl>" + RedirectURL + "</newurl><token>" + Token + "</token><transaction>" + xmlstr + "</transaction></sqroot>"
                        Response.Write(xmlstr)

                    Catch exp As Exception
                        xmlstr = "<sqroot><message>" & exp.Message & "</message></sqroot>"
                        Response.Write(xmlstr)
                    End Try
                End If
            Case "verify"
                Response.Write("Continue")
            Case "unfinish"
                Response.Write("transaction Unfinished")
            Case "finish"
                Dim GUID = getQueryVar("order_id")
                Dim statuscode = getQueryVar("status_code")

                If statuscode = 200 Then 'success
                    sqlstr = "exec doc.after_midtrans '" & curHostGUID & "','" & GUID & "'"


                    xmlstr = runSQLwithResult(sqlstr)
                    setCookie("cartID", "", 0)
                    If xmlstr.Contains("success") Then
                        Response.Redirect("../../index.aspx?code=tapcs3")
                    Else
                        Dim urlx = "../../index.aspx?code=tapcs2&GUID=" & GUID
                        Response.Redirect(urlx)
                    End If
                ElseIf statuscode = 201 Then 'pending
                    Dim urlx = "../../index.aspx?code=tapcs3"
                    Response.Redirect(urlx)
                ElseIf statuscode >= 400 And statuscode <= 500 Then 'error
                    Dim urlx = "../../index.aspx?code=tapcs2&GUID=" & GUID
                    Response.Redirect(urlx)
                End If

            Case Else

        End Select

    End Sub

End Class
