Imports System.Data
Imports System.IO
Imports System
Imports ceTe.DynamicPDF
Imports ceTe.DynamicPDF.ReportWriter
Imports ceTe.DynamicPDF.ReportWriter.Data.ParameterType
Imports System.Xml
Imports System.Text
Imports System.Drawing
Imports GemBox.Spreadsheet
Imports System.Data.SqlClient

Partial Class OPHCore_api_msg_rptDialog
    Inherits cl_base
    Protected ReportName As String
    Protected printerpath As String
    Protected PathName As String
    Protected ReportGUID As String
    Protected status As String = 0
    Protected isPrintOnly As String = 0
    Dim sqlstr As String = ""
    Dim hostGUID As String = "NULL"

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Request.QueryString("code") Is Nothing Or Session("hostGUID") Is Nothing Then
            'SignOff()
            'Response.Write("<script>" & contentofSignOff & "</script>")
        Else
            loadAccount()

            isPrintOnly = Request.QueryString("isPrintOnly")
            Dim code = Request.QueryString("code")
            Dim query = Request.QueryString("query")
            Dim outputType = Request.QueryString("outputType")
            Dim dplx = Request.QueryString("dplx")
            Dim gbox = Request.QueryString("gbox")
            Dim reportName = Request.QueryString("reportName")

            If Not Session("hostGUID") Is Nothing Then
                hostGUID = "''" & Session("hostGUID") & "''"
            End If

            Dim g = System.Guid.NewGuid().ToString
            Dim Connections As String = contentOfdbODBC
            If runSQLwithResult("select OBJECT_ID('" & query & "')", Connections) = "" Then
                Dim dbName = runSQLwithResult("declare @db varchar(20); exec gen.getdbinfo '" & contentOfaccountId & "', '" & contentOfsqDB & "', '" & code & "', @db=@db OUTPUT; select @db", Connections)
                Dim lfCtl = Left(contentOfdbODBC, (contentOfdbODBC.ToLower().IndexOf("catalog") + 8))
                Dim rtCtl = Right(contentOfdbODBC, (contentOfdbODBC.Length - lfCtl.Length))
                rtCtl = Right(rtCtl, (rtCtl.Length - rtCtl.IndexOf(";")))

                Dim newConnection = lfCtl & dbName & rtCtl
                If runSQLwithResult("select OBJECT_ID('" & query & "')", newConnection) = "" Then
                    Response.Write("<script>alert('Invalid object_id(" & query & ")')</script>")
                Else
                    Connections = newConnection
                End If
            End If

            Dim parameterid As String = Request.QueryString("Parameter")
            If parameterid = "" Then
                parameterid = "hostGUID:" & hostGUID
            Else
                parameterid = "hostGUID:" & hostGUID & "," & parameterid
            End If

            If dplx = 1 Then
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

                Try
                    Dim reportDocument As DocumentLayout = New DocumentLayout(pathDPLX)
                    Dim q As Long = 1
                    Do While True
                        Dim rpQuery As ceTe.DynamicPDF.ReportWriter.Data.StoredProcedureQuery = CType(reportDocument.GetQueryById("Query" & q), ceTe.DynamicPDF.ReportWriter.Data.StoredProcedureQuery)
                        If Not rpQuery Is Nothing Then
                            rpQuery.ConnectionString = Connections
                            q += 1
                        Else
                            Exit Do
                        End If
                    Loop

                    Dim MyDocument As Document = reportDocument.Run(Parameters)
                    Dim savesPath As String = Request.PhysicalApplicationPath & "document\temp" & g & "_" & reportName & ".pdf"
                    If Request.QueryString("dontdelete") = 1 Then
                        Response.Write(savesPath)
                        MyDocument.Draw(savesPath)
                    Else
                        Response.ClearHeaders()
                        Response.AddHeader("Cache-Control", " no-store, no-cache ")
                        Response.ContentType = "application/pdf"
                        Response.AddHeader("Content-Disposition", "attachment; filename=" & reportName & ".pdf")

                        MyDocument.DrawToWeb(savesPath)
                    End If
                Catch ex As Exception
                    Response.Write("<script>alert('" & ex.Message.Replace("'", "/'") & "')</script>")
                End Try
            ElseIf gbox = 1 Then
                SpreadsheetInfo.SetLicense("ESWM-UQ6R-26SR-4WB1")
                Dim Parameters As ParameterDictionary = New ParameterDictionary
                Dim gfile As String = "", gext As String = ""
                Dim gpath As String = Server.MapPath("~/OPHContent/reports/" & contentOfaccountId & "/temp")
                If Not Directory.Exists(gpath) Then Directory.CreateDirectory(gpath)

                If outputType = 3 Then
                    Dim ParentGUID As String = Request.QueryString("ParentGUID").ToString
                    gext = Right(reportName, reportName.Length - InStr(reportName, "."))
                    If reportName = "" Then reportName = code
                    If gext = "txt" Then
                        gfile = g & "_" & reportName & ".csv"
                    Else
                        gfile = g & "_" & reportName & ".xls"
                    End If

                    sqlstr = "exec gen.download_select '" & code & "','" & ParentGUID & "','" & hostGUID & "' "
                Else
                    If InStr(reportName, ".") = 0 Then reportName = reportName & ".xls"
                    gext = LCase(Right(reportName, reportName.Length - InStr(reportName, ".")))

                    Select Case gext
                        Case "txt"
                            gfile = g & "_" & reportName & ".csv"
                        Case Else
                            gfile = g & "_" & reportName
                    End Select
                End If

                Dim pathGBOX As String = gpath & gfile

                If outputType <> 3 Then
                    parameterid = parameterid.Replace(":", "=").Replace(":null", "=null").Replace("''", "")

                    sqlstr = "exec " & query & " "
                    Dim p = parameterid.Split(",")

                    Dim n = 1
                    For Each px In p
                        If px <> "" Then
                            Dim pp = px.Split("=")
                            If pp(1) <> "null" Then
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

                        ws.Columns.Item(0).AutoFit()
                        ef.Save(pathGBOX)
                        If Not Request.QueryString("output") Is Nothing Then
                            If Dir(Request.QueryString("output")) <> "" Then Kill(Request.QueryString("output"))
                            If gext = "txt" Then
                                Dim latin1 As Encoding = Encoding.GetEncoding(28591)
                                Dim text As String = File.ReadAllText(pathGBOX, latin1)
                                File.WriteAllText(Request.QueryString("output"), text, Encoding.ASCII)
                            Else
                                FileCopy(pathGBOX, Request.QueryString("output"))
                            End If
                        End If
                        If gext = "txt" Then
                            Rename(pathGBOX, Left(pathGBOX, pathGBOX.Length - 4))
                            gfile = Left(gfile, Len(gfile) - 4)
                            pathGBOX = Left(pathGBOX, Len(pathGBOX) - 4)
                        End If

                        If Request.QueryString("dontdelete") = 1 Then
                            If Not Request.QueryString("output") Is Nothing Then
                                Response.Write(Request.QueryString("output"))
                            Else
                                Response.Write(pathGBOX)
                            End If
                        Else
                            Dim bytes() As Byte
                            Dim finfo As New FileInfo(pathGBOX)
                            Dim numBytes As Long = finfo.Length
                            Dim fstream As New FileStream(pathGBOX, FileMode.Open, FileAccess.Read)
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
                    Response.Write("<script>alert('" & ex.Message.Replace("'", "\'") & "')</script>")
                End Try
            End If
        End If

    End Sub
    Function parValId(ByVal par As ParameterDictionary, ByVal pp0 As String, ByVal pp1 As String) As String
        Dim x As Integer = Len(pp1)
        If x = 36 Then
            Dim Gdt As Guid = New Guid(pp1)
            par.Add(pp0, Gdt)
        ElseIf pp1 = "null" Then
            Dim Gdt As Guid = New Guid("00000000-0000-0000-0000-000000000000")
            par.Add(pp0, Gdt)
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