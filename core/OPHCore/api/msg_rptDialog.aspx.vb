Imports System.Data
Imports System.IO

Imports ceTe.DynamicPDF
Imports ceTe.DynamicPDF.ReportWriter
Imports GemBox.Spreadsheet

Partial Class OPHCore_api_msg_rptDialog
    Inherits cl_base
    Protected pdfFile As String = ""

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ''parameter: hostguid, code 
        '' mode=xls;pdf;txt;csv;htm, job=1, dontdelete=1, parameter, pop=1, outputtype=0, output?
        '' mode xlstemplate: exportmode=1;0, 
        '' mode parent: withdata=1;0, exportmode=1;0, 
        '' mode child: parentguid

        'Page.Server.ScriptTimeout = 30 * 60 '30 minutes
        Page.Server.ScriptTimeout = 10 * 60

        Dim curHostGUID = getSession() 'Session("hostGUID")

        If curHostGUID = "" Or Session("ODBC") = "" Or Session("baseAccount") = "" Then loadAccount()
        If contentOfaccountId Is Nothing Or contentOfaccountId = "" Then contentOfaccountId = Session("baseAccount")

        Dim curUserGUID = Session("userGUID")
        If getQueryVar("hostguid") <> "" Then curHostGUID = getQueryVar("hostguid")

        If IsNothing(curHostGUID) Then
            curHostGUID = "null"
        Else
            curHostGUID = "'" & curHostGUID & "'"
        End If

        Dim code = getQueryVar("code")  'code
        Dim mode = getQueryVar("mode")
        Dim job = getQueryVar("job")
        Dim pop = getQueryVar("pop")
        Dim dontdel = getQueryVar("dontdelete")

        Dim reportName = "" 'getQueryVar("reportName") '--> to be hidden
        Dim XLSTemplate = ""
        Dim parameterid As String = "" 'getQueryVar("Parameter")
        Dim parTxt As String = ""
        Dim getparameterid As String = getQueryVar("Parameter")
        writeLog(getparameterid)
        Dim fieldattachment As List(Of String) = Nothing
        Dim parXML = writeXMLFromRequestForm("sqroot", fieldattachment, "")

        Dim sqlstr = ""

        If mode = "htm" Or mode = "xls" Or mode = "pdf" Or mode = "xlstemplate" Then
            sqlstr = "exec [api].[getReport] " & curHostGUID & ", '" & code & "', '" & parXML & "'"
            writeLog("getReport : " & sqlstr)
            Dim ds1 = SelectSqlSrvRows(sqlstr)
            If ds1.Tables.Count > 0 Then
                If ds1.Tables(0).Rows.Count > 0 Then
                    If ds1.Tables(0).Rows(0).Item("parameters").ToString <> "" Then
                        parameterid = ds1.Tables(0).Rows(0).Item("parameters").replace("%2F", "/")
                        parTxt = parameterid
                    End If
                    reportName = ds1.Tables(0).Rows(0).Item("reportName").ToString
                    XLSTemplate = ds1.Tables(0).Rows(0).Item("XLSTemplate").ToString
                End If
            End If

            If getparameterid <> "" Then
                parameterid = getparameterid
                parTxt = parameterid
                writeLog("par:" + parTxt)
            End If
        End If

        If pop <> "1" And dontdel <> "1" And 1 = 0 Then 'remark
            sqlstr = "exec api.reportJob " & curHostGUID & ", '" & code & "', '" & mode & "', '" & parameterid & "'"
            writeLog(sqlstr)
            runSQL(sqlstr)
        Else
            'Dim xguid = getQueryVar("guid")
            'If Session("process" & xguid) <> "1" Then
            'Session("process" & xguid) = "1"


            Dim Connections As String = Session("ODBC")
            'Dim hGUID = getSession()
            If parameterid = "" Then
                parameterid = "hostGUID:" & curHostGUID
            Else
                parameterid = "hostGUID:" & curHostGUID & "," & parameterid
                parameterid = parameterid.Replace("'", "")
            End If

            If mode = "pdf" Then
                Dim appSettings As NameValueCollection = ConfigurationManager.AppSettings
                Dim cete = appSettings.Item("ceTe.LicenseKey").ToString
                Document.AddLicense(cete)
                Dim Parameters As ParameterDictionary = New ParameterDictionary

                Dim queryDPLX As String
                queryDPLX = runSQLwithResult("select infovalue from modl a inner join modlinfo b on a.moduleguid=b.moduleguid where moduleid='" & code & "' and InfoKey='dplx_rpt'")

                'store dplx to folder temp
                'If contentOfaccountId <> "" Then contentOfaccountId = Session("baseAccount")

                Dim path As String = Server.MapPath("~/OPHContent/reports/" & contentOfaccountId & "/temp/")
                If queryDPLX <> "" Then
                    writeFile(path, reportName & ".dplx", queryDPLX, False)
                End If
                Dim pathDPLX As String = Server.MapPath("~/OPHContent/reports/" & contentOfaccountId & "/temp/" & reportName & ".dplx")

                parameterid = parameterid.Replace(":", "=").Replace(":null", "=null").Replace("''", "")
                parameterid = parameterid.Replace("/", "-")
                Dim p = parameterid.Split(",")
                writeLog(parameterid)

                Dim n = 1
                For Each px In p
                    Dim pp = px.Split("=")
                    If pp(1) = "" Then pp(1) = "null"
                    parValId(Parameters, Trim(pp(0)), pp(1))
                    n += 1
                Next
                Dim q As Long = 1
                Dim query = "" 'runSQLwithResult("Select infovalue from modl a inner join modlinfo b On a.moduleguid=b.moduleguid where moduleid='YoDailySalesByCustomer' and InfoKey='querysql_" & q & "'")
                Dim errReport = False
                Try
                    Dim reportDocument As DocumentLayout = New DocumentLayout(pathDPLX)

                    Do While True
                        query = runSQLwithResult("select infovalue from modl a inner join modlinfo b on a.moduleguid=b.moduleguid where moduleid='" & code & "' and InfoKey='querysql_" & q & "'")
                        writeLog(query)
                        Dim rpQuery As ceTe.DynamicPDF.ReportWriter.Data.StoredProcedureQuery = CType(reportDocument.GetQueryById("Query" & q), ceTe.DynamicPDF.ReportWriter.Data.StoredProcedureQuery)
                        If Not rpQuery Is Nothing Then
                            If query IsNot Nothing And query <> "" Then
                                If runSQLwithResult("select OBJECT_ID('doc." & query & "')", Connections) = "" Then
                                    Dim dbName = runSQLwithResult("declare @db varchar(20); exec gen.getdbinfo '" & curHostGUID & "', '" & code & "', @db=@db OUTPUT; select @db", Connections)
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
                        Dim savesPath As String = Server.MapPath("~/OPHContent/documents/temp/") & g & "_" & reportName & ".pdf"
                        If dontdel = "1" Then
                            Response.Write(savesPath)
                            MyDocument.Draw(savesPath)
                        Else

                            pdfFile = Request.Url.LocalPath.Replace("msg_rptDialog.aspx", "") & "../../OPHContent/documents/temp/" & g & "_" & reportName & ".pdf"
                            If Request.UrlReferrer.Scheme = "https" Then
                                pdfFile = pdfFile.Replace("http", "https")
                            End If

                            If pop = "1" Then
                                Response.Write("<html><head><title>Printing...</title></head><script src=""../../OPHContent/cdn/printjs/print.min.js""></script><body><script>printJS('" & pdfFile & "');window.onfocus=function(){ window.close();}</script></body></html>")

                            Else
                                runSQLwithResult("exec gen.evnt_save " & curHostGUID & ", '" & code & "', null, @comment='<strong>Parameters:</strong> " & parTxt & ". <strong>Result:</strong> Please click <a href=''" & pdfFile & "''>here</a>.', @type=5")
                                ''
                            End If
                            MyDocument.Draw(savesPath)
                        End If
                    End If

                Catch ex As Exception
                    Response.ContentType = "text/html"
                    Response.AddHeader("Cache-Control", " no-store, no-cache ")
                    If pop = "1" Then
                        Response.Write("<script>alert('" & ex.Message.Replace("'", "\'").Replace("\", "\\") & "')</script>")
                    End If
                    writeLog(ex.Message.Replace("'", "\'").Replace("\", "\\"))
                Finally


                End Try
            ElseIf mode = "xls" Or mode = "htm" Or mode = "child" Or mode = "parent" Then

                Dim appSettings As NameValueCollection = ConfigurationManager.AppSettings
                SpreadsheetInfo.SetLicense(appSettings.Item("gBox.LicenseKey").ToString)

                Dim g = System.Guid.NewGuid().ToString
                Dim d = Format(Date.Now, "yyyyMMddhhmm").ToString()
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
                        gfile = g & "_" & reportName & ".xlsx"
                    End If
                    Dim withdata = getQueryVar("withdata")
                    sqlstr = "exec gen.downloadModule " & curHostGUID & ", '" & code & "', " & exportMode.ToString & ", " + IIf(withdata = "1", "1", "0")
                ElseIf mode = "child" Then
                    Dim ParentGUID As String = getQueryVar("ParentGUID").ToString

                    If reportName = "" Then reportName = code
                    gext = Right(reportName, reportName.Length - InStr(reportName, "."))
                    If gext = "txt" Then
                        gfile = g & "_" & reportName & ".csv"
                    Else
                        gfile = g & "_" & reportName & ".xlsx"
                    End If

                    sqlstr = "exec gen.downloadChild " & curHostGUID & ", '" & code & "','" & ParentGUID & "'"
                Else
                    If InStr(reportName, ".") = 0 Then reportName = reportName & "_" & d & ".xlsx"
                    gext = LCase(Right(reportName, reportName.Length - InStr(reportName, ".")))

                    Select Case gext
                        Case "txt"
                            gfile = g & "_" & reportName & ".csv"
                        Case Else
                            gfile = g & "_" & reportName
                    End Select

                    parameterid = parameterid.Replace(":", "=").Replace("''", "")
                    Dim q As Long = 1
                    Dim query = runSQLwithResult("select infovalue from modl a inner join modlinfo b on a.moduleguid=b.moduleguid where moduleid='" & code & "' and InfoKey='querysql_" & q & "'")

                    sqlstr = "exec " & query & " "
                    Dim p = parameterid.Split(",")

                    Dim n = 1
                    For Each px In p
                        If px <> "" Then
                            Dim pp = px.Split("=")
                            If pp(1).ToLower <> "null" And pp(1).ToLower <> "" Then
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
                    sqlstr = sqlstr.Replace("''", "'")
                End If
                writeLog("downloadXLS : " & sqlstr)

                Dim pathGBOX As String = gpath & gfile
                Dim pathGBOX1 = pathGBOX.Replace(Server.MapPath("~/OPHContent/reports"), "OPHContent/reports").Replace("\", "/")

                Try

                    'Dim sqlstr3 = "exec gen.evnt_save " & curHostGUID & ", '" & code & "', null, @comment='<strong>Parameters:</strong> " & parTxt & ". Generating... Please wait.', @type=5"
                    If mode = "xls" Then
                        Dim sqlstr3 = "exec gen.evnt_save " & curHostGUID & ", '" & code & "', null, @comment='<strong>Parameters:</strong> " & parTxt & ". <strong>Result:</strong> Please click <a href=''" & pathGBOX1 & "''>here</a>.', @type=5"
                        'writeLog(sqlstr3)
                        runSQLwithResult(sqlstr3)
                    End If

                    Dim ef As ExcelFile = New ExcelFile
                    Dim ws As ExcelWorksheet = ef.Worksheets.Add(code)
                    Dim rows As Integer = 0
                    writeLog(sqlstr)
                    Dim ds = SelectSqlSrvRows(sqlstr, Connections)
                    Dim json As String = ""
                    Dim jsonCols As String = ""
                    Dim jsonAlign As String = ""
                    If ds.Tables.Count > 0 And ds.Tables(0).Rows.Count > 0 Then
                        Dim cols As Integer = 0
                        If gext <> "txt" Then
                            If gext <> "csv" Then
                                For Each head In ds.Tables(0).Columns
                                    If mode = "xls" Or mode = "parent" Or mode = "child" Then
                                        ws.Cells(rows, cols).SetValue(head.ToString)
                                    End If
                                    Dim type = "text"
                                    If head.ToString.IndexOf("#num#") Then type = "numeric"
                                    jsonCols &= "{type:'" & type & "',title:'" & head.ToString.Replace("#num#", "") & "',width:200},"
                                    jsonAlign &= IIf(jsonAlign = "", "", ",") & "'left'"
                                    cols = cols + 1
                                Next
                                ws.Rows(rows).Hidden = IIf(mode = "xls" Or exportMode = 0, False, True)
                                rows = rows + 1
                            End If
                        End If
                        Dim cl = ds.Tables(0).Columns.Count
                        Dim rc = 0
                        For rc = 0 To ds.Tables(0).Rows.Count - 1
                            'For Each r In ds.Tables(0).Rows
                            '    ['Civic', 'Honda', '2018-07-11', '', true, '$ 4.000,01', '#007777'],

                            Dim jsonRow = "[#content#,]"
                            Dim rx = DirectCast(ds.Tables(0).Rows(rc), DataRow)
                            Dim number As Double
                            For n = 0 To cl - 1
                                If mode = "xls" Or mode = "parent" Or mode = "child" Then
                                    If IsDBNull(rx.Item(n)) Then
                                    ElseIf Double.TryParse(rx.Item(n).ToString, number) Then
                                        ws.Cells(rows + rc, n).SetValue(number)
                                        'writeLog("excel set value")
                                        'isvisited=true
                                    Else
                                        ws.Cells(rows + rc, n).SetValue(rx.Item(n).ToString)
                                        'writeLog("excel string")
                                    End If
                                End If
                                'ws.Cells(rows, n).Value = rx.Item(n).ToString
                                jsonRow = Replace(jsonRow, "#content#,", "'" & rx.Item(n).ToString & "',#content#,")
                            Next
                            'rows = rows + 1
                            json = json & IIf(json = "", "", ",") & Replace(jsonRow, "#content#,", "")
                        Next

                        'For n = 0 To ds.Tables(0).Columns.Count - 1
                        'ws.Columns.Item(n).AutoFit()
                        'Next
                        ws.Columns(0).Hidden = IIf(mode = "xls" Or exportMode = 0, False, True)
                        'ws.Columns.Item(0).AutoFit()
                        ef.Save(pathGBOX)
                        'kok bisa tahu pathnya?
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
                        If mode = "htm" Then
                            'writeLog("html:")
                            'ConvertToHTML(pathGBOX, replace(pathGBOX, ".xlsx", ".html"))
                            pathGBOX = Replace(pathGBOX, ".xlsx", ".html")
                            'pathGBOX=replace(pathGBOX, ".html","_files/sheet001.html")
                            gfile = Replace(gfile, "xlsx", "html")
                            Dim html = ConvertToJSONXLS(jsonCols, json, jsonAlign)
                            'If File.Exists(gfile) Then
                            'File.AppendAllText(gfile, html)
                            'Else
                            File.AppendAllText(pathGBOX, html)
                            'End If
                        ElseIf gext = "txt" Then
                            Rename(pathGBOX, Left(pathGBOX, pathGBOX.Length - 4))
                            gfile = Left(gfile, Len(gfile) - 4)
                            pathGBOX = Left(pathGBOX, Len(pathGBOX) - 4)
                        End If

                        'If mode = "htm" Then
                        'response.write(ConvertToJSONXLS(jsonCols, json))
                        If dontdel = "1" Then
                            If getQueryVar("outputType") = "0" Then 'file
                                Response.Write(pathGBOX)
                            ElseIf getQueryVar("outputType") = "1" Then 'http
                                Response.Write(pathGBOX1)
                            ElseIf Not getQueryVar("output") Is Nothing Then
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
                            If Right(pathGBOX, 3) = "xls" Then
                                context1.Response.ContentType = "application/vnd.ms-excel"
                            ElseIf Right(pathGBOX, 4) = "xlsx" Then
                                context1.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                            ElseIf Right(pathGBOX, 3) = "txt" Then
                                context1.Response.ContentType = "text/plain"
                            ElseIf mode = "htm" Then
                                context1.Response.ContentType = "text/html"
                            End If

                            context1.Response.ClearHeaders()
                            Dim disposition = IIf(mode = "htm", "inline", "attachment") & ";filename=" & gfile
                            context1.Response.AddHeader("content-disposition", disposition)
                            context1.Response.BinaryWrite(bytes)
                            context1.Response.Flush()
                            fstream.Close()
                            fstream.Dispose()



                            'finfo.Delete()

                            pathGBOX = pathGBOX.Replace(Server.MapPath("~/OPHContent/reports"), "OPHContent/reports").Replace("\", "/")
                            writeLog(pathGBOX)
                            'xls lwt
                            'sqlstr = "update evnt set comment='<strong>Parameters:</strong> " & parTxt & ". <strong>Result:</strong> Please click <a href=''" & pathGBOX & "''>here</a>.' where eventguid='" & rguid & "'"
                            'sqlstr = "exec gen.evnt_save " & curHostGUID & ", '" & code & "', null, @comment='<strong>Parameters:</strong> " & parTxt & ". <strong>Result:</strong> Please click <a href=''" & pathGBOX & "''>here</a>.', @type=5"
                            'runSQLwithResult(sqlstr)
                        End If
                    Else
                        If pop = "1" Then
                            Response.Write("<script>alert('Theres is No Data to be Shown!');window.close();</script>")
                        End If
                    End If
                Catch ex As Exception
                    writeLog(ex.Message)
                    If pop = "1" Then
                        Response.Write("<script>alert('" & ex.Message.Replace("'", "\'") & "')</script>")
                    End If
                End Try
            ElseIf mode = "xlstemplate" Then

                Dim appSettings As NameValueCollection = ConfigurationManager.AppSettings
                SpreadsheetInfo.SetLicense(appSettings.Item("gBox.LicenseKey").ToString)

                Dim g = System.Guid.NewGuid().ToString
                Dim Parameters As ParameterDictionary = New ParameterDictionary
                Dim gfile As String = "", gext As String = ""
                Dim gpath As String = Server.MapPath("../../reports/" & contentOfaccountId & "/temp/")
                Dim rpath As String = Server.MapPath("../../reports/" & contentOfaccountId & "/")
                gpath = gpath.Replace("core\", "")
                rpath = rpath.Replace("core\", "")

                If Not Directory.Exists(gpath) Then Directory.CreateDirectory(gpath)
                Dim exportMode = getQueryVar("exportMode").ToString()
                'default exportMode=1
                exportMode = IIf(Not exportMode = "0", "1", "0")

                If InStr(reportName, ".") = 0 Then reportName = reportName & ".xlsx"
                gext = LCase(Right(reportName, reportName.Length - InStr(reportName, ".")))

                gfile = g & "_" & reportName

                Dim pathGBOX As String = gpath & gfile
                Dim template As String = rpath & XLSTemplate

                parameterid = parameterid.Replace(":", "=").Replace(":null", "=null").Replace("''", "")
                Dim q As Long = 1
                Try
                    Dim ef As ExcelFile = ExcelFile.Load(template)
                    Dim ws As ExcelWorksheet = ef.Worksheets(0)
                    Dim isvisited As Boolean = False

                    Do While True
                        Dim query = runSQLwithResult("select infovalue from modl a inner join modlinfo b on a.moduleguid=b.moduleguid where moduleid='" & code & "' and InfoKey='querysql_" & q & "'")
                        'Dim queryupdate = runSQLwithResult("select infovalue from modl a inner join modlinfo b on a.moduleguid=b.moduleguid where moduleid='" & code & "' and InfoKey='querysqlupdate_" & q & "'")
                        Dim rows As Integer '= 12
                        Dim cols As Integer
                        Dim col As Integer
                        Dim getcol As String

                        If query IsNot Nothing And query <> "" Then
                            rows = runSQLwithResult("select isnull(infovalue,0) infovalue from modl a inner join modlinfo b on a.moduleguid=b.moduleguid where moduleid='" & code & "' and InfoKey='rowquerysql_" & q & "'")
                            getcol = runSQLwithResult("select isnull(infovalue,0) infovalue from modl a inner join modlinfo b on a.moduleguid=b.moduleguid where moduleid='" & code & "' and InfoKey='colquerysql_" & q & "'")

                            If getcol IsNot Nothing And getcol <> "" Then
                                col = getcol
                            Else
                                col = 0
                            End If

                            sqlstr = query
                            Dim p = parameterid.Split(",")

                            Dim n = 1
                            For Each px In p
                                If px <> "" Then
                                    Dim pp = px.Split("=")
                                    If pp(1).ToLower <> "null" Then
                                        sqlstr = sqlstr & " " & "'" & pp(1) & "'"
                                    Else
                                        sqlstr = sqlstr & "null"
                                    End If

                                    If n < p.Length Then
                                        sqlstr = sqlstr & ", "
                                    End If
                                End If
                                n += 1
                            Next
                            sqlstr = sqlstr.Replace("''", "null")
                            writeLog("downloadXLS : " & sqlstr)


                            Dim ds = SelectSqlSrvRows(sqlstr, Connections)

                            If ds.Tables.Count > 0 And ds.Tables(0).Rows.Count > 0 Then

                                'Dim rowcol As Integer = 0
                                'For Each head In ds.Tables(0).Columns
                                '    ws.Cells(head.ToString).Value = ds.Tables(0).Rows(0).ItemArray(rowcol).ToString()

                                'Next
                                Dim totalrow As Int32 = ds.Tables(0).Rows.Count
                                If totalrow > 1 Then
                                    ws.Rows(rows).InsertCopy(totalrow - 1, ws.Rows(rows))
                                End If

                                Dim cl = ds.Tables(0).Columns.Count
                                For Each r In ds.Tables(0).Rows
                                    cols = col
                                    Dim rx = DirectCast(r, DataRow)
                                    Dim number As Double

                                    For n = 1 To cl - 1
                                        'ws.Cells(rows, n).Value = rx.Item(n).ToString
                                        If IsDBNull(rx.Item(n)) Then
                                        ElseIf Double.TryParse(rx.Item(n), number) Then
                                            ws.Cells(rows, cols).SetValue(number)
                                            'writeLog("excel set value")
                                            isvisited = True
                                        Else
                                            ws.Cells(rows, cols).SetValue(rx.Item(n).ToString)
                                            'writeLog("excel string")
                                        End If
                                        cols = cols + 1
                                    Next

                                    rows = rows + 1
                                Next
                            End If
                        Else
                            Exit Do

                        End If
                        q += 1

                    Loop
                    If isvisited Then
                        writeLog("visited")
                    Else
                        writeLog("notvisited")
                    End If
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

                    If dontdel = "1" Then
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
                        If Right(pathGBOX, 3) = "xls" Then
                            context1.Response.ContentType = "application/vnd.ms-excel"
                        ElseIf Right(pathGBOX, 4) = "xlsx" Then
                            context1.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                        ElseIf Right(pathGBOX, 3) = "txt" Then
                            context1.Response.ContentType = "text/plain"
                        ElseIf Right(pathGBOX, 3) = "html" Then
                            context1.Response.ContentType = "text/html"

                        End If

                        context1.Response.ClearHeaders()
                        context1.Response.AddHeader("content-disposition", "attachment;filename=" & gfile)
                        context1.Response.BinaryWrite(bytes)
                        context1.Response.Flush()
                        fstream.Close()
                        fstream.Dispose()
                        'finfo.Delete()
                        'pathGBOX = Request.Url.OriginalString.ToString().ToLower().Substring(0, Request.Url.OriginalString.ToString().ToLower().IndexOf("ophcore")) & "ophcontent/reports/" & contentOfaccountId & "/temp/" & finfo.Name
                        pathGBOX = pathGBOX.Replace(Server.MapPath("~/OPHContent/reports"), "OPHContent/reports").Replace("\", "/")
                        sqlstr = "exec gen.evnt_save " & curHostGUID & ", '" & code & "', null, @comment='<strong>Parameters:</strong> " & parTxt & ". <strong>Result:</strong> Please click <a href=''" & pathGBOX & "''>here</a>.', @type=5"
                        runSQLwithResult(sqlstr)
                    End If



                Catch ex As Exception
                    writeLog(ex.Message)
                    If pop = "1" Then
                        Response.Write("<script>alert('" & ex.Message.Replace("'", "\'") & "')</script>")
                    End If
                End Try
            End If
            'End If
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

    Function ConvertToJSONXLS(col As String, json As String, jsonAlign As String)

        Dim html As String = "<html>" &
            "<script src=""https://bossanova.uk/jexcel/v3/jexcel.js""></script>" &
            "<link rel=""stylesheet"" href=""https://bossanova.uk/jexcel/v3/jexcel.css"" type=""text/css"" />" &
            "<script src=""https://bossanova.uk/jsuites/v2/jsuites.js""></script>" &
            "<link rel=""stylesheet"" href=""https://bossanova.uk/jsuites/v2/jsuites.css"" type=""text/css"" />" &
            "<style>" &
                "body {margin:0 0 0 0;}" &
            "</style>" &
            "<div id=""spreadsheet"" style=""overflow:scroll;height:100%;width:100%;overflow:auto""></div>" &
            "<script>" &
            "var data = [" & json & "];" &
            "jexcel(document.getElementById('spreadsheet'), {" &
            "   tableOverflow : true," &
            "   tableWidth: ""100%""," &
            "   tableHeight: ""100%""," &
            "   defaultColWidth: [" & jsonAlign & "]," &
            "	data:data," &
            "	columns: [" & col & "" &
            "	 ]" &
            "});" &
            "</script>" &
            "</html>"
        'writeLog(html)
        Return html
    End Function

End Class