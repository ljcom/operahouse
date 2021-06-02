Imports System.Data
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.IO
Imports System.Security.AccessControl

Partial Class OPHCore_api_msg_download
    Inherits cl_base

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        'loadAccount()


        Dim curHostGUID = getSession() 'Session("hostGUID")
        'If curHostGUID = "" Or Session("ODBC") = "" Or Session("baseAccount") = "" Then 
		loadAccount()
		'end if
        If contentOfaccountId Is Nothing Or contentOfaccountId = "" Then
            contentOfaccountId = Session("baseAccount")
            contentOfaccountId = getCookie(contentOfaccountId & "_accountid")
        End If
        Dim curUserGUID = Session("userGUID")
        Dim curODBC = Session("ODBC")

        If getQueryVar("hostguid") <> "" Then curHostGUID = getQueryVar("hostguid")

        Dim tGUID As String = getQueryVar("GUID")
        Dim code As String = getQueryVar("code")
        Dim mode As String = getQueryVar("mode")
        Dim filepath As String = getQueryVar("file")
        Dim fieldAttachment As String = getQueryVar("fieldAttachment")
        Dim imageName As String = getQueryVar("imageName")
		di pagepdf as string= getQueryVar("page")

        'Dim fieldKey As String = getQueryVar("fieldKey")

        Dim ocode = code 'Left(code, 1) & "a" & code.Substring(2, Len(code) - 2)
        'remarked andre
        'Dim acctdbse = "select accountDBGUID from modl where ModuleId='" & code & "'"
        'acctdbse = runSQLwithResult(acctdbse, curODBC)
        'Dim con = "select odbc from acctdbse where accountDBGUID ='" & acctdbse & "'"
        'con = runSQLwithResult(con, contentOfsequoiaCon)

        'added andre
        Dim con = Session("ODBC")
        'Dim curODBC = runSQLwithResult("select ACCTDBSE.ODBC from MODL inner join ACCTDBSE on MODL.accountDBGUID=ACCTDBSE.accountDBGUID where MODL.ModuleId='" & code & "'")
        'Dim con = runSQLwithResult("select ODBC from CoMODL where ModuleId='" & code & "'")

        'remarked andre
        'Dim sqlstr1 = "select colname from gen.coTABLFIEL a inner join gen.coTABL b on a.tableGUID=b.TableGUID where tablename='" & ocode & "' and colorder=10"
        ' Dim fieldKey As String = runSQLwithResult(sqlstr1, con)
        Dim fieldKey As String = "docGUID"

        'Dim path As String = getQueryVar("path")
        'If getQueryVar("dontdelete") = 1 Then
        'Dim path As String = Server.MapPath(Session("DocumentFolder") & "\temp\").ToString
        'Else
        'Dim path As String = Session("document") & Session("documentFolder") & "/" & Left(code, 1) & "a" & Mid(code, 3, Len(code) - 2) & "_" & fieldAttachment & "/"
        'Dim hostguid = Session("hostguid")
        'sqlstr1 = "select infovalue from acctinfo a 	inner join acct b 		on a.accountguid=b.accountguid	inner join [user] d		on d.accountguid = b.AccountGUID	inner join userhost c 		on c.UserGUID = d.userguid where infokey='documentFolder' and c.hostguid='" & hostguid & "'"

        'Dim path As String = runSQLwithResult(sqlstr1)
        Dim path As String = Server.MapPath("~/OPHContent/documents") & "\" & contentOfaccountId & "\"
        'path=path & ocode & ""
        'End If




        If fieldAttachment <> "" Or imageName <> "" Then
            'Dim con = Session("odbc")
            Dim filename = ""
            If fieldAttachment <> "" Then
                Dim sqlstr = "Select " & fieldAttachment & " From doc." & ocode & " Where " & fieldKey & " ='" & tGUID & "'"
                Dim dt = SelectSqlSrvRows(sqlstr, con)
                'path = path
                If dt.Tables(0).Rows.Count > 0 Then
                    filename = dt.Tables(0).Rows(0)(fieldAttachment).ToString()
                End If
                If filename <> "" Then
                    Dim revfilename = StrReverse(filename).Replace("/", "\")
                    Dim lengthfile = revfilename.IndexOf("\")

                    'If lengthfile = 0 Then lengthfile = Len(revfilename)
                    'path = path & Left(filename, Len(filename) - lengthfile)
                    'filename = Right(filename, lengthfile)

                    If lengthfile = -1 Then lengthfile = Len(filename)
                    path = path & Left(filename, Len(filename) - lengthfile).Replace("/", "\")
                    filename = filename.Substring(Len(filename) - lengthfile, lengthfile)
                End If

            Else
                filename = Server.MapPath("~/" & imageName.Replace("\", "/").Replace(Request.Url.Authority, ""))

                Dim revfilename = StrReverse(filename).Replace("/", "\")
                Dim lengthfile = revfilename.IndexOf("\")
                path = Left(filename, Len(filename) - lengthfile)
                filename = Right(filename, lengthfile)
            End If
            'Dim fSecurity As FileSecurity = File.GetAccessControl(path & filename)
            If File.Exists(path & filename) Then
                If mode = "range" Then
                    RangeDownload(path & filename, Context)
                else if mode="pdf" then
					Dim addsplit As String = filename.Replace(Mid$(filename, InStrRev(filename, "/") + 1), "split/" & Mid$(filename, InStrRev(filename, "/") + 1))
                    Dim finale As String = addsplit.Replace(".pdf", "_" & pagepdf & ".pdf")
                    download(path, finale)
				Else
                    download(path, filename)
                End If
				'after	
				Dim sqlstr = "exec api.download_after null, ''"& ocode &"'', ''"& tGUID &"''"
				'Select " & fieldAttachment & " From doc." & ocode & " Where " & fieldKey & " ='" & tGUID & "'"
                Dim dt = run(sqlstr, con)

            Else
                'Response.Write("File is not exists.")
                Response.TrySkipIisCustomErrors = True
                Response.StatusCode = 404
                Response.StatusDescription = "Page not found"
            End If

        ElseIf getQueryVar("querysql") <> "" Then
            ''''' harusnya masuk ke report  '''''
            Dim querysql As String = getQueryVar("querysql")
            Dim sqlexec = "exec " & querysql & " '" & curHostGUID & "', '" & tGUID & "' ,1"
            runSQL(sqlexec, con)
            Dim sqlTXT = "exec gen.downloadTXT '" & tGUID & "_" & code & "'"
            Dim dt = SelectSqlSrvRows(con, sqlTXT) 'hasil harus tXTFIle berupa filepath dan BLOB 
            'download(dt.Tables(0), "TXTFile", path)
        Else
            Response.TrySkipIisCustomErrors = True
            Response.StatusCode = 404
            Response.StatusDescription = "Page not found"
        End If

    End Sub

    Protected Function download(ByVal path As String, ByVal filename As String) As Boolean
        Dim sizeImage As Integer = Val(getQueryVar("size"))
        If sizeImage = 0 Then sizeImage = 300

        Dim bytes() As Byte = Nothing
        path = path '& filename
        If Directory.Exists(path) Then
            Dim f As String
            f = path & filename
            'Else
            'f = Server.MapPath(path) & LTrim(dt.Rows(0)(f1).ToString())
            'End If
            Dim fInfo As New FileInfo(f)

            If fInfo.Exists = True Then
                Dim isBitmap = False
                Dim ms As Stream = New MemoryStream()
                If fInfo.Extension = ".jpg" Or fInfo.Extension = ".png" Then
                    'check size
                    Dim bmp As New Bitmap(fInfo.FullName)
                    Dim w = bmp.Width
                    Dim h = bmp.Height
                    If w > sizeImage Or h > sizeImage Then
                        'resize if too 
                        Dim ratio As Decimal = IIf(sizeImage / w < sizeImage / h, sizeImage / w, sizeImage / h)
                        Dim nw As Integer = w * ratio
                        Dim nh As Integer = h * ratio

                        Dim newf = System.Threading.Thread.GetDomain().DynamicDirectory & "\" & fInfo.Name.Replace(fInfo.Extension, "").TrimEnd & "_" & nh & "_" & nw & "2" & fInfo.Extension
                        If Not File.Exists(newf) Then
                            'File.Delete(newf)


                            Dim target As New Bitmap(nw, nh, PixelFormat.Format24bppRgb)

                            Using graphics As Graphics = Graphics.FromImage(target)
                                'graphics.Clear(Color.Transparent)
                                'graphics.InterpolationMode = InterpolationMode.HighQualityBicubic

                                graphics.DrawImage(bmp,
                                    New Rectangle(0, 0, nw, nh),
                                    New Rectangle(0, 0, bmp.Width, bmp.Height),
                                    GraphicsUnit.Pixel)
                                'graphics.DrawImage(bmp, New Size(nw, nh))
                            End Using
                            'target.Save(ms, ImageFormat.Png)
                            'Dim nm As Long = ms.Length
                            'Dim br As New BinaryReader(ms)
                            'bytes = br.ReadBytes(CInt(nm))
                            target.Save(newf, IIf(fInfo.Extension = ".jpg", ImageFormat.Jpeg, ImageFormat.Png))
                        End If
                        isBitmap = True
                        f = newf
                    End If
                End If

                Dim fInfo1 As New FileInfo(f)
                'Dim ms As MemoryStream
                'If Not isBitmap Then
                Dim numBytes As Long = fInfo1.Length
                Dim fStream As New FileStream(f, FileMode.Open, FileAccess.Read)
                Dim br As New BinaryReader(fStream)
                bytes = br.ReadBytes(CInt(numBytes))

                'End If

                If getQueryVar("dontdelete") = "1" Then
                    Response.Write(f)
                Else
                    Response.Buffer = True
                    Response.Charset = ""

                    If isBitmap Then Response.ContentType = "image/png"

                    Response.Cache.SetCacheability(HttpCacheability.NoCache)
                    'Response.ContentType = dt.Rows(0)(f2).ToString()
                    Response.AddHeader("content-disposition", "attachment;filename=" & fInfo1.Name)
                    Response.BinaryWrite(bytes)
                    Response.Flush()
                    Response.End()
                End If
            Else
                Response.Write("File not found.")
                Response.End()
            End If
        Else
            Response.Write("File not found.")
            Response.End()
        End If

        Return True

    End Function

    Protected Sub RangeDownload(ByVal fullpath As String, ByVal context As HttpContext)
        Dim size, start, [end], length As Long, fp As Long = 0

        Using reader As StreamReader = New StreamReader(fullpath)
            size = reader.BaseStream.Length
            'size = 200000
            start = 0
            [end] = size - 1
            length = size
            context.Response.AddHeader("Accept-Ranges", "0-" & size)

            If Not String.IsNullOrEmpty(context.Request.ServerVariables("HTTP_RANGE")) Then
                Dim anotherStart As Long = start
                Dim anotherEnd As Long = [end]
                Dim arr_split As String() = context.Request.ServerVariables("HTTP_RANGE").Split(New Char() {Convert.ToChar("=")})
                Dim range As String = arr_split(1)

                If range.IndexOf(",") > -1 Then
                    context.Response.AddHeader("Content-Range", "bytes " & start & "-" & [end] & "/" & size)
                    Throw New HttpException(416, "Requested Range Not Satisfiable")
                End If

                If range.StartsWith("-") Then
                    anotherStart = size - Convert.ToInt64(range.Substring(1))
                Else
                    arr_split = range.Split(New Char() {Convert.ToChar("-")})
                    anotherStart = Convert.ToInt64(arr_split(0))
                    Dim temp As Long = 0
                    anotherEnd = If((arr_split.Length > 1 AndAlso Int64.TryParse(arr_split(1).ToString(), temp)), Convert.ToInt64(arr_split(1)), size)
                End If

                anotherEnd = If((anotherEnd > [end]), [end], anotherEnd)

                If anotherStart > anotherEnd OrElse anotherStart > size - 1 OrElse anotherEnd >= size Then
                    context.Response.AddHeader("Content-Range", "bytes " & start & "-" & [end] & "/" & size)
                    Throw New HttpException(416, "Requested Range Not Satisfiable")
                End If

                start = anotherStart
                If (anotherEnd > anotherStart + 100000) Then
                    [end] = anotherStart + 100000
                Else
                    [end] = anotherEnd

                End If
                length = [end] - start + 1
                fp = reader.BaseStream.Seek(start, SeekOrigin.Begin)
                context.Response.StatusCode = 206

                context.Response.AddHeader("Content-Range", "bytes " & start & "-" & [end] & "/" & size)
                context.Response.AddHeader("Content-Length", length.ToString())
                context.Response.WriteFile(fullpath, fp, length)
                context.Response.[End]()
            Else
                context.Response.StatusCode = 404
            End If
        End Using


    End Sub
End Class
