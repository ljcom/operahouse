Imports System.IO
Imports System.Net
'Imports System.Net

Partial Class OPHCore_API_default
    Inherits cl_base
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If getQueryVar("hostGUID") <> "" Then
            getAccount(getQueryVar("hostGUID"), getQueryVar("env"), getQueryVar("code"), getQueryVar("GUID"))
        Else
            loadAccount(getQueryVar("env"), getQueryVar("code"), getQueryVar("GUID"))
        End If



        Dim curODBC = contentOfdbODBC
        Dim DBCore = contentOfsqDB
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

        Dim code = ""
        If getQueryVar("code") <> "" Then code = "" & getQueryVar("code") & ""
        If code = "" Then
            code = Request.Form("code")
        End If

        Dim GUID = "null"
        If getQueryVar("GUID") <> "" And getQueryVar("GUID") <> "undefined" Then GUID = "'" & getQueryVar("GUID") & "'"

        'showonedataonly - moved to loadaccount
        'If mode = "browse" Then
        '    sqlstr = "select iif(infovalue='accountGUID', m.accountguid, iif(infovalue='userGUID', '" & curUserGUID & "', '')) from modl m inner join modlinfo i on m.moduleguid=i.moduleguid where m.moduleid='" & code & "' and i.infokey='showOneDataOnly'"
        '    GUID = runSQLwithResult(sqlstr)
        '    If GUID <> "" Then
        '        GUID = "'" & GUID & "'"
        '        mode = "form"
        '    End If
        'End If

        Select Case mode
            Case "account"
                isSingle = False

                xmlstr = "<sqroot><hostGUID>" & curHostGUID & "</hostGUID><code>" & contentOfCode & "</code><env>" & contentOfEnv & "</env>" &
                        "<themeFolder>" & contentOfthemeFolder & "</themeFolder><themePage>" & contentOfthemePage & "</themePage><needLogin>" &
                        contentofNeedLogin & "</needLogin><signInPage>" & contentofsignInPage & "</signInPage><GUID>" & contentOfGUID & "</GUID><userName>" & contentofUserName & "</userName></sqroot>"
            Case "master"
                sqlstr = "exec [api].[theme] '" & curHostGUID & "', '" & code & "', " & GUID
                writeLog("mode master: " & sqlstr)
            Case "browse"
                Dim sqlfilter = getQueryVar("sqlFilter")

                Dim sortOrder = getQueryVar("sortOrder")
                Dim stateid = getQueryVar("stateid")
                Dim bpage = getQueryVar("bPageNo")
                Dim searchText = getQueryVar("bSearchText")

                If sortOrder = "" Or sortOrder = "," Then sortOrder = ""
                If stateid = "" Or stateid = "" Or stateid = "," Or stateid = "null" Then
                    sqlstr = "select c.StateID from modl a inner join msta b on a.ModuleStatusGUID=b.ModuleStatusGUID inner join mstastat c on b.ModuleStatusGUID=c.ModuleStatusGUID and c.isDefault=1 where moduleid='" & code & "'"
                    stateid = runSQLwithResult(sqlstr, curODBC)
                End If

                If searchText = "null" Or searchText = "search" Then searchText = ""
                searchText = searchText.Replace("%2B", "+")
                If bpage = "" Then bpage = 1
                If code <> "" Then
                    Dim rpp = IIf(code.Length() > 6 And String.IsNullOrWhiteSpace(sqlfilter) = False, 10, 20)

                    'add showpage untuk frontend
                    Dim showpage = getQueryVar("showpage")
                    If showpage <> "" Then
                        rpp = showpage
                    End If

                    sqlstr = "exec [api].[theme_browse] '" & curHostGUID & "', '" & code & "', '" & sqlfilter.Replace("'", "''") & "', '" & searchText.Replace("'", "''") & "', " & bpage & ", " & rpp & ", '" & sortOrder & "', '" & stateid & "'"
                    writeLog("mode browse: " & sqlstr)
                    'isSingle = False
                    'xmlstr = getXML(sqlstr, curODBC)
                End If
            Case "view", "form"
                sqlstr = "exec [api].[theme_form] '" & curHostGUID & "', '" & code & "', " & GUID '& ", " & editMode
                writeLog("mode form : " & sqlstr)

            Case "save", "preview"
                isSingle = False
                Dim preview = getQueryVar("flag")
                'GUID = getQueryVar("guid")
                'GUID = System.Guid.NewGuid().ToString()
                GUID = Request.Form("cfunctionlist")
                Dim randGUID = ""

                Dim fieldAttachment As New List(Of String)
                'Dim fileAttachment As New List(Of String)
                Dim f As String
                For Each f In Request.Files
                    Dim path As String = Server.MapPath("~/OPHContent/documents")
                    Dim theDate As DateTime = DateTime.Now
                    Dim szFilename = Year(theDate) & "\" & Month(theDate)
                    Dim curField = "", fileName = ""
                    For Each n In Request.Form
                        'If Request.Form(n) = Request.Files(f).FileName Or Request.Form(n).indexof(Request.Files(f).FileName) > 0 Then
                        If Request.Form(n) = Request.Files(f).FileName Or Request.Files(f).FileName.IndexOf(Request.Form(n).ToString()) > 0 Or Request.Form(n).indexof(Request.Files(f).FileName) > 0 Then
                            curField = n
                            randGUID = System.Guid.NewGuid().ToString()

                            fileName = Trim(IIf(Request.Form(n).Equals(""), Request.Files(f).FileName, Request.Form(n).split(",")(0)))
                            fieldAttachment.Add(curField)
                            'fileAttachment.Add(fileName)

                            Dim fxn As String = path & "\" & contentOfaccountId & "\" & code & "_" & curField & "\" & szFilename & "\" & randGUID.Replace("'", "") & "_" & fileName
                            Dim checkDir = path & "\" & contentOfaccountId & "\" & code & "_" & curField & "\" & szFilename & "\"
                            If Not Directory.Exists(checkDir) Then Directory.CreateDirectory(checkDir)
                            If Directory.Exists(checkDir) Then
                                writeLog("upload_attachment: " & fxn)
                                If fxn <> "" Then
                                    Request.Files(f).SaveAs(fxn)
                                    sqlstr = "exec gen.addFile '" & curHostGUID & "', '" & fxn & "'"
                                    Dim newFile = runSQLwithResult(sqlstr)
                                End If
                            End If
                            'Exit For
                        End If
                    Next


                Next

                sqlstr = populateSaveXML(1, code, preview, fieldAttachment, randGUID)
                sqlstr = sqlstr.Replace("#95#", "_").Replace("%2F", "/").Replace("%2C", "")
                sqlstr = sqlstr & ", @preview=" & IIf(preview = "", 0, preview)
                writeLog(sqlstr)

                xmlstr = runSQLwithResult(sqlstr, curODBC)

                If Not xmlstr.Contains("<sqroot>") Or xmlstr.Contains("<root>") Then
                    xmlstr = xmlstr.Replace("<root>", "")
                    xmlstr = xmlstr.Replace("</root>", "")
                    xmlstr = xmlstr.Replace("<row>", "")
                    xmlstr = xmlstr.Replace("</row>", "")
                    xmlstr = "<messages><message>" & xmlstr & "</message></messages>"
                End If
            Case "function"
                Dim functionName = IIf(String.IsNullOrWhiteSpace(Request.Form("cfunction")), getQueryVar("cfunction"), Request.Form("cfunction"))
                Dim functionlist = IIf(String.IsNullOrWhiteSpace(Request.Form("cfunctionlist")), getQueryVar("cfunctionlist"), Request.Form("cfunctionlist"))
                Dim approvaluserguid = IIf(String.IsNullOrWhiteSpace(Request.Form("approvaluserguid")), getQueryVar("approvaluserguid"), Request.Form("approvaluserguid"))
                Dim pwd = IIf(String.IsNullOrWhiteSpace(Request.Form("pwd")), getQueryVar("pwd"), Request.Form("pwd"))
                Dim comment = getQueryVar("comment")

                If approvaluserguid = "undefined" Or approvaluserguid = "null" Then approvaluserguid = "NULL" Else approvaluserguid = "'" & approvaluserguid & "'"
                If pwd = "undefined" Then pwd = "NULL" Else pwd = "'" & pwd & "'"

                Dim fl = functionlist.Split(",")
                For Each f In fl
                    If f = "" Then f = "null" Else f = "'" & f & "'"
                    'add approvaluserguid and pwd
                    sqlstr = "exec api.[function] @hostGUID='" & curHostGUID & "', @mode='" & functionName & "', @code='" & code & "', @GUID=" & f & ", @comment='" & comment & "'" & IIf(approvaluserguid = "NULL", "", ", @approvaluserguid=" & approvaluserguid & ", @pwd= " & pwd & " ")
                    xmlstr &= runSQLwithResult(sqlstr, curODBC)
                    writeLog("function " & functionName & " : " & sqlstr)
                Next
                Dim msg = xmlstr
                xmlstr = "<messages><message>" & xmlstr & "</message></messages>"
                isSingle = False
            Case "talk"
                Dim comment As String = getQueryVar("comment")
                sqlstr = "exec gen.submitTalk '" & curHostGUID & "', " & GUID & ", '" & comment & "'"
            Case "widget"
                Dim stateid = getQueryVar("stateid")
                sqlstr = "exec [api].[theme_widget] '" & curHostGUID & "', '" & code & "'"
            Case "data"
                Dim data = getQueryVar("data")
                Dim sqlFilter = getQueryVar("sqlFilter")
                sqlstr = "exec [api].[getData] '" & curHostGUID & "', '" & data & "', '" & sqlFilter & "'"
                xmlstr = runSQLwithResult(sqlstr, curODBC)
                isSingle = False
                writeLog("data : " & sqlstr)
            Case "export"
                sqlstr = "exec [api].[theme_export] '" & curHostGUID & "', '" & code & "'"
                xmlstr &= runSQLwithResult(sqlstr, curODBC)
            Case "upload"
                Dim fieldattachment As New List(Of String)
                Dim header As Boolean
                If getQueryVar("header") <> "" Then
                    header = getQueryVar("header")
                End If

                Dim f As String
                For Each f In Request.Files
                    Dim path = Server.MapPath("~/OPHContent/documents/temp")
                    Dim ranGUID = System.Guid.NewGuid().ToString()
                    Dim ParentGUID = getQueryVar("parentGUID")
                    Dim fxn As String = path & "\" & contentOfaccountId & "\" & code & "_" & ranGUID.Replace("'", "") & "_" & Request.Files(f).FileName
                    Dim checkDir = path & "\" & contentOfaccountId & "\"
                    If Not Directory.Exists(checkDir) Then Directory.CreateDirectory(checkDir)
                    If Directory.Exists(checkDir) Then
                        If fxn <> "" Then Request.Files(f).SaveAs(fxn)
                    End If

                    If header = True Then
                        Dim exportMode = getQueryVar("exportMode")
                        Dim xmlParameter = getQueryVar("xmlParameter")
                        xmlParameter = xmlParameter.Replace("ss3css", "<").Replace("ss3ess", ">").Replace("ss3dss", "=").Replace("ss2fss", "/").Replace("ss84ss", """")
                        sqlstr = "exec gen.uploadModule '" & curHostGUID & "', '" & code & "', " & exportMode & ", '" & fxn & "', '" & xmlParameter & "'"
                    Else
                        sqlstr = "exec gen.uploadChild '" & curHostGUID & "', '" & code & "', '" & ParentGUID & "', '" & fxn & "'"
                    End If
                    WriteLog(sqlstr)
                    xmlstr = getXML(sqlstr, curODBC)
                Next
                isSingle = False

            Case "report"
                sqlstr = "exec [api].[theme_report] '" & curHostGUID & "', '" & code & "'"
                xmlstr = runSQLwithResult(sqlstr, curODBC)


            Case "codeSearch"
                Dim searchValue As String = getQueryVar("searchValue")
                sqlstr = "exec api.code_search '" & curHostGUID & "', '" & searchValue & "'"
                isSingle = True
            Case "signout"
                sqlstr = "exec [api].[signout] '" & curHostGUID & "'"
                runSQL(sqlstr, curODBC)
                Response.Cookies("guestID").Value = ""
                Response.Cookies("sqlFilter").Value = ""
                Session.Clear()
                Session.RemoveAll()
                Session.Abandon()
                noxml = True
                isSingle = False
            Case "revokeDelegation"
                sqlstr = "exec [api].[revoke_delegation] '" & curHostGUID & "', '" & code & "'"
                xmlstr = runSQLwithResult(sqlstr, curODBC)
                xmlstr = "<sqroot><message>" & xmlstr & "</message></sqroot>"
                isSingle = False
            Case "saveProfile"
                Dim fieldattachment As New List(Of String)
                Dim f As String
                For Each f In Request.Files
                    Dim path As String
                    path = Server.MapPath("~/OPHContent/documents")

                    Dim curField = ""
                    For Each n In Request.Form
                        If Request.Form(n) = Request.Files(f).FileName Then
                            curField = n
                            fieldattachment.Add(curField)
                            Exit For
                        End If
                    Next
                    Dim theDate As DateTime = DateTime.Now

                    Dim szFilename = Year(theDate) & "\" & Month(theDate)
                    GUID = System.Guid.NewGuid().ToString()
                    GUID = Left(GUID, 8)
                    Dim fxn As String = path & "\" & contentOfaccountId & "\" & code & "_" & curField & "\" & szFilename & "\" & GUID.Replace("'", "") & "_" & Request.Files(f).FileName

                    Dim checkDir = path & "\" & contentOfaccountId & "\" & code & "_" & curField & "\" & szFilename & "\"
                    If Not Directory.Exists(checkDir) Then Directory.CreateDirectory(checkDir)
                    If Directory.Exists(checkDir) Then
                        If fxn <> "" Then Request.Files(f).SaveAs(fxn)
                    End If
                Next

                sqlstr = populateSaveXML(1, code, 0, fieldattachment, GUID)
                sqlstr = sqlstr.Replace("#95#", "_")
                sqlstr = sqlstr.Replace("[save]", "[save_profile]")
                xmlstr = runSQLwithResult(sqlstr, curODBC)
                xmlstr = "<sqroot><message>" & xmlstr & "</message></sqroot>"
                isSingle = False
            Case "changePassword"
                Dim curPass = Request.Form("curpass")
                Dim newPass = Request.Form("newpass")

                sqlstr = "exec gen.changePassword '" & curHostGUID & "', '" & curPass & "', '" & newPass & "'"
                xmlstr = runSQLwithResult(sqlstr, curODBC)
                xmlstr = "<sqroot><message>" & xmlstr & "</message></sqroot>"
                isSingle = False
            Case "forgotpwd"
                code = getQueryVar("code")
                Dim steps = getQueryVar("step")
                Dim email = getQueryVar("email")
                Dim verifycode = getQueryVar("verifycode")
                If steps = "sendemail" Then
                    sqlstr = "exec api.forgotPwdMail '" & steps & "','" & code & "', '" & email & "' , '" & verifycode & "'"
                    xmlstr = "<sqroot><message>" & runSQLwithResult(sqlstr) & "</message></sqroot>"
                    isSingle = False
                End If
                If steps = "verifycode" Then
                    sqlstr = "exec api.forgotPwdMail '" & steps & "','" & code & "', '" & email & "' , '" & verifycode & "'"
                    xmlstr = getXML(sqlstr)
                    isSingle = False
                End If
            Case "gConnect"
                Dim tokenid = getQueryVar("gid")
                'Dim tokenid = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImFjMmI2M2ZhZWZjZjgzNjJmNGM1MjhlN2M3ODQzMzg3OTM4NzAxNmIifQ.eyJhenAiOiIyMzQ4MTgyMzE2NDQtajRmZXFwYzZjM2dnMGlrczk1ODA4ZWc1bnV0bGZxdXUuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIyMzQ4MTgyMzE2NDQtajRmZXFwYzZjM2dnMGlrczk1ODA4ZWc1bnV0bGZxdXUuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDA4MzQyMDY2MjE0NDc2ODk1OTUiLCJlbWFpbCI6InNhbXVlbC5zdXJ5YUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6IkdnVDhXWlZpaTBKZXlSQm5BRUY0eVEiLCJleHAiOjE1MjA0MjA2ODcsImlzcyI6ImFjY291bnRzLmdvb2dsZS5jb20iLCJqdGkiOiI1M2YyOGY3NWUyM2EwOWU4NjcxOGRjNTIxNjQ5N2YxMmZmNWNkN2FiIiwiaWF0IjoxNTIwNDE3MDg3LCJuYW1lIjoiU2FtdWVsIFN1cnlhIiwicGljdHVyZSI6Imh0dHBzOi8vbGg2Lmdvb2dsZXVzZXJjb250ZW50LmNvbS8tYTk2ckZuRUpOVUkvQUFBQUFBQUFBQUkvQUFBQUFBQUFWRkkvUXhleU1YNndxc3cvczk2LWMvcGhvdG8uanBnIiwiZ2l2ZW5fbmFtZSI6IlNhbXVlbCIsImZhbWlseV9uYW1lIjoiU3VyeWEiLCJsb2NhbGUiOiJlbiJ9.Rcml4KiTJ-znmGTYsjlCLdumbuSF-TD1dwju6ORQmETQx44T7hdJer5FSS-a9-EDzzqzY0nLDktMPvhh5n6hoxdYS2Tn4liNPsrsdGFSIE2M3KyrHNYut6QyCuQ1M0NgKDCLQ2Yp8XK6AWry3wMaJ-64fMMnvsx2ozDpNzeVMIXV6NHT718wFnOywW-mTb6YbfIjEOajRhhAPu6nvGM7vtmTUKlvRe8q2VlYU_QbC2TS8Ppn_arCbCOqd_Zmk9GaN8twsMcTapCxwZWzNAGcM5o68KErfYkxswgF678hzUBADeKM3YBPR0sfFTsb59XvPs89tQpsRGqtbvHBrkEgBQ"
                Dim client As WebClient = New WebClient()
                Dim url = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=" & tokenid
                Dim result As String = client.DownloadString(url)
                Dim userid = "", pwd = "12345678"
                For Each rx In result.Split(",")
                    If rx.Split(":")(0).IndexOf("email""") > 0 Then
                        userid = rx.Split(":")(1).Replace("""", "").Replace(" ", "")
                    End If
                Next
                sqlstr = "exec api.verifyPassword '" & curHostGUID & "', '" & userid & "', '" & pwd & "', " & 1
                xmlstr = getXML(sqlstr, curODBC)
                If xmlstr IsNot Nothing And xmlstr <> "" Then
                    curUserGUID = XDocument.Parse(xmlstr).Element("sqroot").Element("userGUID").Value
                    Session("userGUID") = curUserGUID
                    'Response.Cookies("hostGUID").Value = curHostGUID
                    Response.Cookies("isLogin").Value = 1
                End If
                'Case "signoff"
                '    Session.Abandon()
            Case Else 'signin
                Dim bypass = 0
                Dim userid as string= ""
                Dim pwd As String = ""
                If Request.Form("autologin") = "1" And Request.ServerVariables(5) <> "" Then
                    bypass = 1
                    userid = Request.ServerVariables(5)
                Else
                    userid = Request.Form("userid")
                    pwd = Request.Form("pwd")

                End If
                'Dim withCaptcha = getQueryVar("withCaptcha")
                Dim withcaptcha = Not contentofwhiteAddress
                'withcaptcha = IIf(String.IsNullOrWhiteSpace(withCaptcha), 0, withCaptcha)
                Dim captcha = Request.Form("g-recaptcha-response")
                Dim source As String = getQueryVar("source")
                If userid = "" And (pwd = "" Or bypass = 0) And captcha = "" Then
                    reloadURL("index.aspx?")
                Else
                    If withcaptcha = 0 Or (withcaptcha = 1 And captcha <> "" And IsGoogleCaptchaValid()) Then 'Or (source.ToLower.IndexOf("localhost") > 0) Then
                        'If checkWinLogin(userid, pwd) Then
                        '    bypass = 1
                        '    sqlstr = "select infovalue from acctinfo a inner join acct b on a.accountguid=b.accountguid where infokey='masterPassword' and accountid='" & contentOfaccountId & "'"
                        '    pwd = runSQLwithResult(sqlstr, contentOfsequoiaCon)
                        'End If
                        sqlstr = "exec api.verifyPassword '" & curHostGUID & "', '" & userid & "', '" & pwd & "', " & bypass
                        writeLog(sqlstr)
                        xmlstr = getXML(sqlstr, curODBC)
                        If xmlstr IsNot Nothing And xmlstr <> "" Then
                            'Session.Clear()
                            curUserGUID = XDocument.Parse(xmlstr).Element("sqroot").Element("userGUID").Value
                            Session("userGUID") = curUserGUID
                            'Response.Cookies("hostGUID").Value = curHostGUID
                            Response.Cookies("isLogin").Value = 1
                        Else
                            If bypass = 1 Then
                                xmlstr = "<sqroot><message>You don't have the authorization.</message></sqroot>"
                            ElseIf String.IsNullOrWhiteSpace(errorCaptcha) Then
                                xmlstr = "<sqroot><message>Incorrect Password!</message></sqroot>"
                            Else
                                xmlstr = "<sqroot><message>" + errorCaptcha + "</message></sqroot>"
                            End If
                        End If
                        '--!
                        Dim cartID = getQueryVar("cartID")
                        If cartID <> "" Then
                            sqlstr = "exec dbo.checkToPCSO '" & curHostGUID & "', '" & cartID & "'"
                            Dim xmlstr2 = runSQLwithResult(sqlstr, curODBC)
                        End If

                    Else
                        If String.IsNullOrWhiteSpace(errorCaptcha) Then
                            xmlstr = "<sqroot><message>Please authorize CAPTCHA!</message></sqroot>"
                        Else
                            xmlstr = "<sqroot><message>" + errorCaptcha + "</message></sqroot>"
                        End If
                    End If
                    '--!
                    isSingle = False

                End If
        End Select
        If isSingle Then xmlstr = getXML(sqlstr, curODBC)

        If xmlstr <> "" Then
            xmlstr1 = xmlstr.Substring(1, 6)
        End If
        If xmlstr1 <> "sqroot" Then
            isSingle = False
        End If
        If Not noxml Then
            'If Len(xmlstr) > 50 Then
            If xmlstr <> "" Then
                Response.ContentType = "text/xml"
                Response.Write("<?xml version=""1.0"" encoding=""utf-8""?>")
                Response.Write(xmlstr)
            Else
                writeLog("mode " & mode & " : " & sqlstr)
            End If
        Else
            Response.Write("ok")
        End If
    End Sub

End Class
