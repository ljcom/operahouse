Imports System.IO
Imports System.Net
Imports System.Xml
Imports System.Data
Imports System.Data.SqlClient

Partial Class OPHCore_API_link

    Inherits cl_base

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        if getQueryVar("hostguid")<>"" then Session("hostGUID")=getQueryVar("hostguid")
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
			case "dld"
				Dim code = getQueryVar("code")
                'Dim GUID = getQueryVar("GUID")
				sqlstr = "exec api.[function] @hostguid='" & curHostGUID & "', @mode='dld', @code='" & code & "', @guid=null, @comment=''"
				writeLog(sqlstr)
				Dim url=""
				dim ds as DataSet = SelectSqlSrvRows(sqlstr)
				if ds.tables.count>0 AndAlso ds.Tables(0).Rows.Count > 0 Then
					dim urlx=ds.Tables(0).Rows(0).Item(0).ToString
					response.write(url)
					reloadURL(url, true, 1)
				else response.write("400 Bad Request")
				end if
			case "itm"
				Dim code = getQueryVar("code")
                Dim GUID = getQueryVar("GUID")
				sqlstr = "exec api.[function] @hostguid='" & curHostGUID & "', @mode='itm', @code='" & code & "', @guid="&GUID&", @comment=''"
				writeLog(sqlstr)
				Dim url=""
				dim ds as DataSet = SelectSqlSrvRows(sqlstr)
				if ds.tables.count>0 AndAlso ds.Tables(0).Rows.Count > 0 Then
					dim urlx=ds.Tables(0).Rows(0).Item(0).ToString
					response.write(url)
					reloadURL(url, true, 1)
				else response.write("400 Bad Request")
				end if
        End Select

    End Sub

End Class
