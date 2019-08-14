Imports System.Data
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.IO

Partial Class OPHCore_api_msg_download
    Inherits cl_base

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        loadAccount()

        Dim curODBC = contentOfdbODBC
        Dim curHostGUID = Session("hostGUID")
        Dim curUserGUID = Session("userGUID")

        Dim tGUID As String = getQueryVar("GUID")
        Dim code As String = getQueryVar("code")
        Dim fieldAttachment As String = getQueryVar("fieldAttachment")
        Dim imageName As String = getQueryVar("imageName")

        'Dim fieldKey As String = getQueryVar("fieldKey")

        Dim ocode = code 'Left(code, 1) & "a" & code.Substring(2, Len(code) - 2)
        'remarked andre
        'Dim acctdbse = "select accountDBGUID from modl where ModuleId='" & code & "'"
        'acctdbse = runSQLwithResult(acctdbse, curODBC)
        'Dim con = "select odbc from acctdbse where accountDBGUID ='" & acctdbse & "'"
        'con = runSQLwithResult(con, contentOfsequoiaCon)

        'added andre
        Dim con = contentOfdbODBC
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

            If File.Exists(path & filename) Then
                download(path, filename)
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

                            Using graphics As Graphics = graphics.FromImage(target)
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

End Class
