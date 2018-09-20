Imports System.Data
Imports System.IO

Imports ceTe.DynamicPDF
Imports ceTe.DynamicPDF.ReportWriter
Imports GemBox.Spreadsheet

Partial Class OPHCore_api_msg_rptDialog
    Inherits cl_base
    'Protected ReportName As String
    'Protected printerpath As String
    'Protected PathName As String
    'Protected ReportGUID As String
    'Protected status As String = 0
    'Protected isPrintOnly As String = 0
    'Dim sqlstr As String = ""
    'Dim hostGUID As String = "NULL"
    Protected pdfFile As String = ""

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        loadAccount()

        Dim curHostGUID = Session("hostGUID")
        Dim curUserGUID = Session("userGUID")
        If IsNothing(curHostGUID) Then
            curHostGUID = "null"
        Else
            curHostGUID = "'" & curHostGUID & "'"
        End If
        'If getQueryVar("code") Is Nothing Then
        'SignOff()
        'Response.Write("<script>" & contentofSignOff & "</script>")
        'Else
        'mode=0 pdf
        'mode=1 xls/csv
        'mode=2 txt


        'isPrintOnly = getQueryVar("isPrintOnly") '--> to be hidden
        Dim code = getQueryVar("code")  'code
        'Dim query = getQueryVar("query")    'querySQL --> to be hidden -- untuk xls/csv only
        'If query<>"" And code="" then 
        Dim mode = getQueryVar("mode")
        'Dim dplx = getQueryVar("dplx") '--> to be hidden
        'Dim gbox = getQueryVar("gbox") '--> to be hidden
        Dim reportName = "" 'getQueryVar("reportName") '--> to be hidden
        'Dim parXML As String = getQueryVar("parXML")
        Dim parameterid As String = "" 'getQueryVar("Parameter")
        Dim fieldattachment As List(Of String) = Nothing

        Dim sqlstr = ""
        If mode = "xls" Or mode = "pdf" Then
            Dim parXML = writeXMLFromRequestForm("sqroot", fieldattachment, "")
            sqlstr = "exec [api].[getReport] " & curHostGUID & ", '" & code & "', '" & parXML & "'"
            Dim ds1 = SelectSqlSrvRows(sqlstr)
            If ds1.Tables.Count > 0 Then
                If ds1.Tables(0).Rows.Count > 0 Then
                    parameterid = ds1.Tables(0).Rows(0).Item("parameters").replace("%2F", "/")
                    reportName = ds1.Tables(0).Rows(0).Item("reportName")
                End If
            End If
        End If


        Dim Connections As String = contentOfdbODBC

        If parameterid = "" Then
            parameterid = "hostGUID:" & Session("hostGUID")
        Else
            parameterid = "hostGUID:" & Session("hostGUID") & "," & parameterid
        End If

        If mode = "pdf" Then
            Dim appSettings As NameValueCollection = ConfigurationManager.AppSettings
            Dim cete = appSettings.Item("ceTe.LicenseKey").ToString
            Document.AddLicense(cete)
            Dim Parameters As ParameterDictionary = New ParameterDictionary
            Dim pathDPLX As String = Server.MapPath("~/OPHContent/reports/" & contentOfaccountId & "/" & reportName & ".dplx")

            parameterid = parameterid.Replace(":", "=").Replace(":null", "=null").Replace("''", "")
            parameterid = parameterid.Replace("/", "-")
            Dim p = parameterid.Split(",")
            Dim n = 1
            For Each px In p
                Dim pp = px.Split("=")
                parValId(Parameters, pp(0), pp(1))
                n += 1
            Next
            Dim q As Long = 1
            Dim query = "" 'runSQLwithResult("select infovalue from modl a inner join modlinfo b on a.moduleguid=b.moduleguid where moduleid='YoDailySalesByCustomer' and InfoKey='querysql_" & q & "'")
            Dim errReport = False
            Try
                Dim reportDocument As DocumentLayout = New DocumentLayout(pathDPLX)

                Do While True
                    query = runSQLwithResult("select infovalue from modl a inner join modlinfo b on a.moduleguid=b.moduleguid where moduleid='" & code & "' and InfoKey='querysql_" & q & "'")

                    Dim rpQuery As ceTe.DynamicPDF.ReportWriter.Data.StoredProcedureQuery = CType(reportDocument.GetQueryById("Query" & q), ceTe.DynamicPDF.ReportWriter.Data.StoredProcedureQuery)
                    If Not rpQuery Is Nothing Then
                        If query IsNot Nothing And query <> "" Then
                            If runSQLwithResult("select OBJECT_ID('" & query & "')", Connections) = "" Then
                                Dim dbName = runSQLwithResult("declare @db varchar(20); exec gen.getdbinfo '" & curHostGUID & "', '" & code & "', @db=@db OUTPUT; select @db", Connections)
                                Dim lfCtl = Left(contentOfdbODBC, (contentOfdbODBC.ToLower().IndexOf("catalog") + 8))
                                Dim rtCtl = Right(contentOfdbODBC, (contentOfdbODBC.Length - lfCtl.Length))
                                rtCtl = Right(rtCtl, (rtCtl.Length - rtCtl.IndexOf(";")))

                                Dim newConnection = lfCtl & dbName & rtCtl
                                If runSQLwithResult("select OBJECT_ID('" & query & "')", newConnection) = "" Then
                                    Response.Write("<script>alert('Invalid object_id(" & query & ")')</script>")
                                    writeLog("Invalid object_id(" & query & ")")
                                    errReport = True
                                    Exit Do
                                Else
                                    Connections = newConnection
                                End If
                            End If
                        End If
                        rpQuery.ConnectionString = Connections
                        q += 1
                    Else
                        Exit Do
                    End If
                Loop
                If Not errReport Then

                    Dim MyDocument As Document = reportDocument.Run(Parameters)
                    Dim g = System.Guid.NewGuid().ToString
                    Dim savesPath As String = Request.PhysicalApplicationPath & "documents\temp\" & g & "_" & reportName & ".pdf"
                    savesPath = savesPath.Replace("core\", "")
                    If getQueryVar("dontdelete") = "1" Then
                        Response.Write(savesPath)
                        MyDocument.Draw(savesPath)
                    Else
                        'Response.ClearHeaders()
                        'Response.AddHeader("Cache-Control", " no-store, no-cache ")
                        'Response.ContentType = "application/pdf"
                        'Response.AddHeader("Content-Disposition", "attachment; filename=" & reportName & ".pdf")

                        pdfFile = Request.Url.AbsoluteUri.Replace("msg_rptDialog.aspx", "") & "../../OPHContent/documents/temp/" & g & "_" & reportName & ".pdf"
                        MyDocument.Draw(savesPath)

                    End If
                End If

            Catch ex As Exception
                Response.ContentType = "text/html"
                Response.AddHeader("Cache-Control", " no-store, no-cache ")
                Response.Write("<script>alert('" & ex.Message.Replace("'", "\'") & "')</script>")
                writeLog(ex.Message.Replace("'", "\'"))
            Finally


            End Try
        ElseIf mode = "xls" Or mode = "child" Or mode = "parent" Then

            Dim appSettings As NameValueCollection = ConfigurationManager.AppSettings
            SpreadsheetInfo.SetLicense(appSettings.Item("gBox.LicenseKey").ToString)

            Dim g = System.Guid.NewGuid().ToString
            Dim Parameters As ParameterDictionary = New ParameterDictionary
            Dim gfile As String = "", gext As String = ""
            Dim gpath As String = Server.MapPath("~/OPHContent/reports/" & contentOfaccountId & "/temp/")
            If Not Directory.Exists(gpath) Then Directory.CreateDirectory(gpath)
            Dim exportMode = getQueryVar("exportMode").ToString()
            'default exportMode=1
            exportMode = IIf(Not exportMode = "0", "1", "0")

            'output 0 = download Report XLS & CSV
            'output 1 = download Module 
            'output 2 = ???
            'output 3 = download Child

            If mode = "parent" Then  'xls/csv/txt
                If reportName = "" Then reportName = code
                gext = Right(reportName, reportName.Length - InStr(reportName, "."))
                If gext = "txt" Then
                    gfile = g & "_" & reportName & ".csv"
                Else
                    gfile = g & "_" & reportName & ".xls"
                End If
                sqlstr = "exec gen.downloadModule " & curHostGUID & ", '" & code & "', " & exportMode.ToString
            ElseIf mode = "child" Then
                Dim ParentGUID As String = getQueryVar("ParentGUID").ToString

                If reportName = "" Then reportName = code
                gext = Right(reportName, reportName.Length - InStr(reportName, "."))
                If gext = "txt" Then
                    gfile = g & "_" & reportName & ".csv"
                Else
                    gfile = g & "_" & reportName & ".xls"
                End If

                sqlstr = "exec gen.downloadChild '" & curHostGUID & "', '" & code & "','" & ParentGUID & "'"
            Else
                If InStr(reportName, ".") = 0 Then reportName = reportName & ".xls"
                gext = LCase(Right(reportName, reportName.Length - InStr(reportName, ".")))

                Select Case gext
                    Case "txt"
                        gfile = g & "_" & reportName & ".csv"
                    Case Else
                        gfile = g & "_" & reportName
                End Select

                parameterid = parameterid.Replace(":", "=").Replace(":null", "=null").Replace("''", "")
                Dim q As Long = 1
                Dim query = runSQLwithResult("select infovalue from modl a inner join modlinfo b on a.moduleguid=b.moduleguid where moduleid='" & code & "' and InfoKey='querysql_" & q & "'")

                sqlstr = "exec " & query & " "
                Dim p = parameterid.Split(",")

                Dim n = 1
                For Each px In p
                    If px <> "" Then
                        Dim pp = px.Split("=")
                        If pp(1).ToLower <> "null" Then
                            sqlstr = sqlstr & "'" & pp(1) & "'"
                        Else
                            sqlstr = sqlstr & "null"
                        End If

                        If n < p.Length Then
                            sqlstr = sqlstr & ", "
                        End If
                    End If
                    n += 1
                Next
            End If
            sqlstr = sqlstr.replace("''", "null")

            Dim pathGBOX As String = gpath & gfile
            Try
                Dim ef As ExcelFile = New ExcelFile
                Dim ws As ExcelWorksheet = ef.Worksheets.Add(code)
                Dim rows As Integer = 0
                Dim ds = SelectSqlSrvRows(sqlstr, Connections)

                If ds.Tables.Count > 0 And ds.Tables(0).Rows.Count > 0 Then
                    Dim cols As Integer = 0
                    If gext <> "txt" Then
                        If gext <> "csv" Then
                            For Each head In ds.Tables(0).Columns
                                ws.Cells(rows, cols).Value = head.ToString
                                cols = cols + 1
                            Next
                            ws.Rows(rows).Hidden = IIf(mode = "xls" Or exportMode = 0, False, True)
                            rows = rows + 1
                        End If
                    End If
                    Dim cl = ds.Tables(0).Columns.Count
                    For Each r In ds.Tables(0).Rows
                        Dim rx = DirectCast(r, DataRow)
                        For n = 0 To cl - 1
                            ws.Cells(rows, n).Value = rx.Item(n).ToString
                        Next
                        rows = rows + 1
                    Next

                    For n = 0 To ds.Tables(0).Columns.Count - 1
                        ws.Columns.Item(n).AutoFit()
                    Next
                    ws.Columns(0).Hidden = IIf(mode = "xls" Or exportMode = 0, False, True)
                    ws.Columns.Item(0).AutoFit()
                    ef.Save(pathGBOX)
                    If getQueryVar("output") <> "" Then
                        If Dir(getQueryVar("output")) <> "" Then Kill(getQueryVar("output"))
                        If gext = "txt" Then
                            Dim latin1 As Encoding = Encoding.GetEncoding(28591)
                            Dim text As String = File.ReadAllText(pathGBOX, latin1)
                            File.WriteAllText(getQueryVar("output"), text, Encoding.ASCII)
                        Else
                            FileCopy(pathGBOX, getQueryVar("output"))
                        End If
                    End If
                    If gext = "txt" Then
                        Rename(pathGBOX, Left(pathGBOX, pathGBOX.Length - 4))
                        gfile = Left(gfile, Len(gfile) - 4)
                        pathGBOX = Left(pathGBOX, Len(pathGBOX) - 4)
                    End If

                    If getQueryVar("dontdelete") = "1" Then
                        If Not getQueryVar("output") Is Nothing Then
                            Response.Write(getQueryVar("output"))
                        Else
                            Response.Write(pathGBOX)
                        End If
                    Else
                        Dim bytes() As Byte
                        Dim finfo As New FileInfo(pathGBOX)
                        Dim numBytes As Long = finfo.Length
                        Dim fstream As New FileStream(pathGBOX, FileMode.Open, FileAccess.Read)
                        writeLog(pathGBOX)
                        Dim br As New BinaryReader(fstream)
                        bytes = br.ReadBytes(CInt(numBytes))

                        Dim context1 As HttpContext = HttpContext.Current
                        context1.Response.Cache.SetCacheability(HttpCacheability.NoCache)
                        If Right(pathGBOX, 3) = "xls" Or Right(pathGBOX, 4) = "xlsx" Then
                            context1.Response.ContentType = "application/vnd.ms-excel"
                        Else
                            If Right(pathGBOX, 3) = "txt" Then context1.Response.ContentType = "text/plain"
                        End If

                        context1.Response.ClearHeaders()
                        context1.Response.AddHeader("content-disposition", "attachment;filename=" & gfile)
                        context1.Response.BinaryWrite(bytes)
                        context1.Response.Flush()
                        fstream.Close()
                        fstream.Dispose()
                        finfo.Delete()
                    End If
                Else
                    Response.Write("<script>alert('Theres is No Data to be Shown!');window.close();</script>")
                End If
            Catch ex As Exception
                writeLog(ex.Message)
                Response.Write("<script>alert('" & ex.Message.Replace("'", "\'") & "')</script>")
            End Try
        End If

    End Sub
    Function parValId(ByVal par As ParameterDictionary, ByVal pp0 As String, ByVal pp1 As String) As String
        Dim x As Integer = Len(pp1)
        If x = 36 Then
            Dim Gdt As Guid = New Guid(pp1)
            par.Add(pp0, Gdt)
        ElseIf pp1.ToLower = "null" Then
            'Dim Gdt As Guid = New Guid("00000000-0000-0000-0000-000000000000")
            'par.Add(pp0, Gdt)
            par.Add(pp0, System.Guid.Empty)
        ElseIf x = 0 Then
            par.Add(pp0, System.Guid.Empty)
        Else
            par.Add(pp0, pp1)
        End If
        Return True
    End Function
    Protected Function download(path As String, f1 As String) As Boolean
        Dim bytes() As Byte
        Dim fInfo As New FileInfo(Server.MapPath(path) & f1)
        Dim numBytes As Long = fInfo.Length
        Dim fStream As New FileStream(Server.MapPath(path) & f1, FileMode.Open, FileAccess.Read)
        Dim br As New BinaryReader(fStream)
        bytes = br.ReadBytes(CInt(numBytes))

        Response.Buffer = True
        Response.Charset = ""
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.AddHeader("content-disposition", "attachment;filename=" & f1)
        Response.BinaryWrite(bytes)
        Response.Flush()
        Response.End()
        Return True
    End Function
End Class