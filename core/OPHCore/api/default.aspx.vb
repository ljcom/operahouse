Imports System.IO

Partial Class OPHCore_API_default
    Inherits cl_base_view

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim sqlstr = ""
        loadAccount()
        Dim curODBC = contentOfdbODBC
        Dim DBCore = contentOfsqDB

        Dim noxml = False
        Dim hGUID = Session("hostGUID")
        Dim isValid = False
        Dim appSettings = ConfigurationManager.AppSettings

        If (Request.QueryString("login") = "true") Then
            Dim acct = Request.QueryString("acct")
            Dim uid = Request.QueryString("uid")
            Dim ups = Request.QueryString("ups")
            Dim conn = appSettings.Item("Connection")

            If (acct IsNot Nothing And uid IsNot Nothing And ups IsNot Nothing) Then
                isValid = GetConnect(acct, acct, uid, ups, "", conn)
            End If

            If isValid Then
                hGUID = Request.QueryString("hostGUID")
                reloadURL("../index.aspx?mode=view&tablename=caUPWD&GUID=" & Session("UserGUID"))
            End If
        End If

        If hGUID Is Nothing Then
            hGUID = ""
            'Exit Sub
        Else
            sqlstr = "exec api.verifyhost '" & Session("hostGUID") & "'"
            hGUID = runSQLwithResult(sqlstr, curODBC)
            If hGUID = "" And Not Session("hostGUID") Is Nothing Then
                'Response.Cookies("lastPar").Value = Request.Url.PathAndQuery
                Session("hostGUID") = Nothing
                Response.Write("<script>window.location='" & Session("lastPar") & "';</script>")
                Exit Sub
            End If
        End If

        'If hGUID = "" Then
        'SignOff()
        'Response.Write("<script>" & contentofSignOff & "</script>")
        'Else
        Dim isSingle = True
        Dim xmlstr = ""
        Dim xmlstr1 = ""
        'End If

        'Dim editMode = Request.QueryString("editMode")
        'If editMode Is Nothing Then editMode = ""
        Dim mode = Request.QueryString("mode")
        If mode Is Nothing Or mode = "" Then
            mode = Request.Form("mode")
        End If

        Dim curHostGUID = "null"
        If Not IsNothing(Session("hostGUID")) Then curHostGUID = "'" & Session("hostGUID") & "'"

        Dim code = ""
        If Not IsNothing(Request.QueryString("code")) Then code = "" & Request.QueryString("code") & ""
        If code Is Nothing Or code = "" Then
            code = Request.Form("code")
        End If
        'Dim pathpage = Request.QueryString("firstpage") + "&tablename=" & code & ""
        'If pathpage Is Nothing Then pathpage = ""

        Dim GUID = "null"
        If Not IsNothing(Request.QueryString("GUID")) And Request.QueryString("GUID") <> "undefined" Then GUID = "'" & Request.QueryString("GUID") & "'"

        Select Case mode
            Case "master"
                Dim stateid = Request.QueryString("stateid")
                sqlstr = "exec [api].[theme] '" & contentOfaccountId & "', '" & DBCore & "', " & curHostGUID & ", '" & code & "', " & GUID & ", '" & Session("env") & "'"
            Case "browse"
                Dim sqlfilter = Request.QueryString("sqlFilter")
                Dim sortOrder = Request.QueryString("sortOrder")
                Dim stateid = Request.QueryString("stateid")
                Dim bpage = Request.QueryString("bPageNo")
                Dim searchText = Request.QueryString("bSearchText")
                'Dim initialT As String
                'initialT = code.Substring(0, 1).ToUpper

                If sqlfilter Is Nothing Then sqlfilter = ""
                If sortOrder Is Nothing Or sortOrder = "," Then sortOrder = ""
                If stateid Is Nothing Or stateid = "" Or stateid = "," Then stateid = "null"
                If searchText Is Nothing Or searchText = "search" Then searchText = ""
                If bpage Is Nothing Then bpage = 1

                Dim rpp = 20 'IIf(code.Length() > 6 And String.IsNullOrWhiteSpace(sqlfilter) = False, 10, 20)
                'add showpage untuk frontend
                Dim showpage = Request.QueryString("showpage")
                If Not showpage Is Nothing Then
                    rpp = showpage
                End If
                sqlstr = "exec [api].[theme_browse] '" & contentOfaccountId & "', '" & DBCore & "', " & curHostGUID & ", '" & code & "', '" & sqlfilter.Replace("'", "''") & "', '" & searchText.Replace("'", "''") & "', " & bpage & ", " & rpp & ", '" & sortOrder & "', " & stateid & ""

                isSingle = False
                xmlstr = getXML(sqlstr, curODBC)
                If xmlstr <> "" Then
                    xmlstr1 = xmlstr.Substring(1, 6)
                End If
                '"You dont have authority!!!"
                If xmlstr1 <> "sqroot" Then
                    xmlstr = runSQLwithResult(sqlstr, curODBC)
                    xmlstr = "<messages><message>" & xmlstr & "</message></messages>"
                    isSingle = False
                End If
            Case "view", "form"
                'editmode=Request.QueryString("editmode")
                sqlstr = "exec [api].[theme_form] '" & contentOfaccountId & "', '" & DBCore & "', " & curHostGUID & ", '" & code & "', " & GUID '& ", " & editMode
            'Case "approval"
            '    sqlstr = "exec [xml].[view_approval] " & curHostGUID & ", '" & code & "', " & GUID '& ", " & editMode
            'Case "child"
            '    sqlstr = "exec [xml].[view_child] " & curHostGUID & ", '" & code & "', " & GUID '& ", " & editMode
            'Case "doctalk"
            '    sqlstr = "exec gen.xml_browse_block_talk " & curHostGUID & ", " & GUID '& ""
            'Case "talk"
            '    Dim comment = Request.QueryString("comment")
            '    sqlstr = "exec oph.caTALK_save NULL, " & curHostGUID & ", " & GUID & ", '" & comment & "'"
            '    runSQLwithResult(sqlstr, curODBC)
            '    sqlstr = "exec gen.xml_browse_block_talk " & curHostGUID & ", " & GUID & ""
            'Case "header"
            '    Dim crtr = Left(code, 1).ToLower
            '    If crtr <> "t" Then
            '        sqlstr = "exec [xml].[view_header_master] " & curHostGUID & ", '" & code & "', " & GUID '& ", " & editMode
            '    Else
            '        sqlstr = "exec [xml].[view_header_trx] " & curHostGUID & ", '" & code & "', " & GUID '& ", " & editMode
            '        runSQLwithResult(sqlstr, curODBC)
            '    End If
            'Case "childheader"
            '    Dim isUpload = Request.QueryString("isUpload")
            '    If isUpload = 1 Then
            '        sqlstr = "exec [xml].[view_header_Upload] " & curHostGUID & ", '" & code & "', " & GUID '& ", " & editMode & ", 1"
            '    Else
            '        sqlstr = "exec [xml].[view_header_child] " & curHostGUID & ", '" & code & "', " & GUID '& ", " & editMode & ", 1"
            '    End If

            'Case "status"
            '    Dim functionName = Request.Form("cfunction")
            '    sqlstr = "exec [xml].[view_status1] " & curHostGUID & ", '" & code & "', " & GUID '& ", " & editMode
            '    xmlstr &= runSQLwithResult(sqlstr, curODBC)
            'Case "menu"
            '    Dim fn = Request.QueryString("formnow")
            '    Dim caption = Request.QueryString("caption")
            '    If fn = "null" Then fn = "00000000-0000-0000-0000-000000000000"
            '    sqlstr = "exec [xml].[menu] " & curHostGUID & ", '" & caption & "', '" & fn & "', '" & code & "'"

            Case "save", "preview"
                isSingle = False
                Dim preview = Request.QueryString("flag")

                sqlstr = populateSaveXML(1, code, preview)
                sqlstr = sqlstr.Replace("#95#", "_")
                sqlstr = sqlstr & ", @preview=" & IIf(preview = "", 0, preview)
                xmlstr = runSQLwithResult(sqlstr, curODBC)
                GUID = xmlstr

                'Dim attachmentFolder = Session("document") & Session("documentFolder") & "/temp/"
                Dim f As String
                For Each f In Request.Files
                    Dim sqlstr1 = "exec core.info_acct '" & contentOfaccountId & "', 'documentFolder'"
                    Dim path2 As String = runSQLwithResult(sqlstr1, contentOfsequoiaCon)
                    sqlstr1 = "exec core.info_acct '" & contentOfaccountId & "', 'uploadFolder'"
                    Dim path As String = runSQLwithResult(sqlstr1, contentOfsequoiaCon)

                    Dim curField = ""
                    For Each n In Request.Form
                        If Request.Form(n) = Request.Files(f).FileName Then
                            curField = n
                            Exit For
                        End If
                    Next
                    Dim fxn As String = path & "\" & path2 & "\" & contentOfaccountId & "\" & code & "_" & curField & "\" & GUID.Replace("'", "") & "_" & Request.Files(f).FileName

                    Dim theDate As DateTime = DateTime.Now.ToString("yyyy-MM")

                    Dim checkDir = path & "\" & path2 & "\" & contentOfaccountId & "\" & code & "_" & curField & "\" & theDate
                    If Not Directory.Exists(checkDir) Then Directory.CreateDirectory(checkDir)
                    If Directory.Exists(checkDir) Then
                        If fxn <> "" Then Request.Files(f).SaveAs(fxn)
                    End If
                Next
                If Not xmlstr.Contains("sqroot") Or xmlstr.Contains("root") Then
                    xmlstr = xmlstr.Replace("<root>", "")
                    xmlstr = xmlstr.Replace("</root>", "")
                    xmlstr = xmlstr.Replace("<row>", "")
                    xmlstr = xmlstr.Replace("</row>", "")
                    xmlstr = "<messages><message>" & xmlstr & "</message></messages>"
                End If
                'If xmlstr <> "" Then
                '    xmlstr = xmlstr.Replace("<root>", "")
                '    xmlstr = xmlstr.Replace("</root>", "")
                '    xmlstr = xmlstr.Replace("<row>", "")
                '    xmlstr = xmlstr.Replace("</row>", "")
                'End If

                'xmlstr = "<messages><message>" & xmlstr & "</message></messages>"

            'Case "preview"
            '    isSingle = False
            '    'Dim attachmentFolder = Session("document") & Session("documentFolder") & "/temp/"
            '    Dim preview = Request.QueryString("flag")
            '    sqlstr = populateSaveXML(1, code, 1)
            '    sqlstr = sqlstr.Replace("#95#", "_")
            '    sqlstr = sqlstr & "," & preview
            '    xmlstr = getXML(sqlstr, curODBC)
            '    If xmlstr <> "" Then
            '        xmlstr = xmlstr.Replace("<root>", "")
            '        xmlstr = xmlstr.Replace("</root>", "")
            '        xmlstr = xmlstr.Replace("<row>", "")
            '        xmlstr = xmlstr.Replace("</row>", "")
            '    End If
            '    xmlstr = "<messages><message>" & xmlstr & "</message></messages>"

            Case "upload"
                Dim flag = Request.QueryString("flag")
                Dim UploadFolder = Server.MapPath(Replace(Request.QueryString("UploadFolder"), "|", "\"))
                Dim QuerySQL = Request.QueryString("QuerySQL")
                Dim Separation = Request.QueryString("Separation")
                Dim Id = Request.QueryString("Id")
                Dim QueryCode = Request.QueryString("QueryCode")

                Dim f = Request.Files
                For nx = 0 To f.Count - 1
                    Dim slashindex As Integer = f.Item(nx).FileName.LastIndexOf("\")
                    Dim dotindex As Integer = f.Item(nx).FileName.LastIndexOf(".")
                    Dim GetFileName As String = f.Item(nx).FileName.Substring(slashindex + 1, Len(f.Item(nx).FileName) - slashindex - 1)
                    If GUID = "null" Then
                        GUID = Id
                    End If
                    'Dim fxn As String = Server.MapPath("../../../document/temp") & "\" & GUID.Replace("'", "") & "_" & f.Item(nx).FileName
                    Dim fxn As String = Server.MapPath("../../../document/temp") & "\" & GUID.Replace("'", "") & "_" & GetFileName
                    f.Item(nx).SaveAs(fxn)
                    If flag = "isUpload" Then
                        Dim sqlstr1 As String
                        sqlstr1 = "exec CaUPLD_save '" & Id.Replace("'", "") & "', " & curHostGUID & ",'" & Id.Replace("'", "") & "','" & fxn & "','" & QueryCode & "'"
                        runSQL(sqlstr1, curODBC)

                        Dim odbc = runSQLwithResult("select c.odbc from coQURY a inner join comodg b on a.modulegroupguid=b.modulegroupguid inner join coacctdbse c on b.accountdbguid=c.accountdbguid where a.queryCode='" & QueryCode & "'", curODBC)
                        'FileCopy(Server.MapPath("../../../document/temp") & "\" & GUID.Replace("'", "") & "_" & GetFileName, UploadFolder & "\" & GUID.Replace("'", "") & "_" & GetFileName)
                        sqlstr = "exec " & QuerySQL & " '" & fxn & "'" & "," & "'" & Separation & "'" & "," & "'" & Id.Replace("'", "") & "'"
                        runSQL(sqlstr, odbc)
                    Else
                        Dim filepath As String = Server.MapPath("../../../document/temp") & "\"
                        Dim filename As String = GUID.Replace("'", "") & "_" & GetFileName
                        Dim fullpath As String = "" & filepath & " " & filename & ""
                        If code <> "" Then
                            sqlstr = "exec gen.upload_select '" & GUID.Replace("'", "") & "', " & curHostGUID & ", '" & code & "', '" & filename & "', '" & filepath & "'"
                            runSQL(sqlstr, curODBC)
                        End If
                    End If
                Next
                noxml = True
                isSingle = False

            Case "function"
                Dim functionName = IIf(String.IsNullOrWhiteSpace(Request.Form("cfunction")), Request.QueryString("cfunction"), Request.Form("cfunction"))
                Dim functionlist = IIf(String.IsNullOrWhiteSpace(Request.Form("cfunctionlist")), Request.QueryString("cfunctionlist"), Request.Form("cfunctionlist"))
                Dim comment = Request.QueryString("comment")

                Dim fl = functionlist.Split(",")
                For Each f In fl
                    If f = "" Then f = "null" Else f = "'" & f & "'"
                    sqlstr = "exec api.[function] @accountid='" & contentOfaccountId & "',  @dbcore='" & DBCore & "', @hostGUID='" & Session("HostGUID").ToString & "', @mode='" & functionName & "', @code='" & code & "', @GUID=" & f & ", @comment='" & comment & "'"
                    xmlstr &= runSQLwithResult(sqlstr, curODBC)
                Next
                Dim msg = xmlstr
                xmlstr = "<messages><message>" & xmlstr & "</message></messages>"
                isSingle = False
            Case "report"
                sqlstr = "exec [api].[theme_report] '" & contentOfaccountId & "', '" & DBCore & "', " & curHostGUID & ", '" & code & "'"
                xmlstr &= runSQLwithResult(sqlstr, curODBC)
            Case "date"
                Dim field = Request.QueryString("FieldName")
                sqlstr = "select '" & field & "' from '" & code & "'"
                xmlstr &= runSQLwithResult(sqlstr, curODBC)
            'Case "uploader"
            '    Dim QueryCode = Request.QueryString("QueryCode")
            '    If QueryCode = "" Then
            '        contentofError = "No tablename found"
            '        Response.Redirect(Back())
            '        Exit Sub
            '    End If
            '    sqlstr = "exec [xml].[Uploader] " & curHostGUID & ", '" & code & "', '" & QueryCode & "'"
            '    xmlstr &= runSQLwithResult(sqlstr, curODBC)
            'Case "switch"
                'xmlstr = changeUser(Request.QueryString("GUID"))
                'xmlstr = "" & "You act as yourself." & ""
                'isSingle = False
            'Case "page"
            '    Dim curPage = Request.QueryString("CurPage")
            '    curPage = Right(curPage, curPage.Length - curPage.IndexOf("OPH") - 4)
            '    curPage = curPage.Replace("*", "&")
            '    sqlstr = "update coUSER set firstPage='" & curPage & "' where userGUID='" & Session("userGUID") & "'"
            '    runSQL(sqlstr, curODBC)
            Case "calculate"
                sqlstr = "exec [xml].[browsecount]  '" & code & "'," & curHostGUID & ""
            Case "countnew"
                sqlstr = "exec [xml].[countnew]  " & curHostGUID & ",'" & Request.QueryString("caption") & "','" & Request.QueryString("formnow") & "'"
            'Case "sidebar"
            '    sqlstr = "exec [api].[sidebar] " & curHostGUID & ", '" & code & "', " & GUID
            Case "signout"
                Response.Cookies("hostGUID").Value = ""
                Session.Clear()
                Session.RemoveAll()
                Session.Abandon()
                Response.Cookies("isLogin").Value = 0
                'reloadURL("../../index.aspx")
                Response.Redirect("../../?")
                Response.Write("<script>top.window.location='../../?';</script>")
            Case "forgotpwd"
                code = Request.QueryString("code")
                Dim steps = Request.QueryString("step")
                Dim email = Request.QueryString("email")
                Dim verifycode = Request.QueryString("verifycode")
                If verifycode Is Nothing Then
                    verifycode = ""
                End If
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
            Case Else 'signin
                'Dim ACCOUNTID = appSettings.Item("accountid")
                Dim userid = Request.QueryString("userid")
                Dim pwd = Request.QueryString("pwd")
                If userid Is Nothing And pwd Is Nothing Then
                    reloadURL("?")
                Else
                    Dim bypass = 0
                    If checkWinLogin(userid, pwd) Then
                        bypass = 1
                        sqlstr = "select infovalue from acctinfo a inner join acct b on a.accountguid=b.accountguid where infokey='masterPassword' and accountid='" & contentOfaccountId & "'"
                        pwd = runSQLwithResult(sqlstr, curODBC)
                    End If
                    sqlstr = "exec api.verifyPassword '" & contentOfaccountId & "', '" & DBCore & "', '" & userid & "', '" & pwd & "', " & bypass
                    xmlstr = getXML(sqlstr, curODBC)

                    If xmlstr IsNot Nothing And xmlstr <> "" Then
                        curHostGUID = XDocument.Parse(xmlstr).Element("sqroot").Element("hostGUID").Value
                        Session("hostGUID") = curHostGUID
                        'Session("ODBC") = XDocument.Parse(xmlstr).Element("sqroot").Element("odbc").Value
                        'Session("ODBC2") = XDocument.Parse(xmlstr).Element("sqroot").Element("odbc2").Value
                        'Session("themeFolder") = XDocument.Parse(xmlstr).Element("sqroot").Element("themefolder").Value
                        'Session("documentFolder") = XDocument.Parse(xmlstr).Element("sqroot").Element("documentfolder").Value
                        'Session("uploadFolder") = XDocument.Parse(xmlstr).Element("sqroot").Element("uploadfolder").Value
                        'Session("reportFolder") = XDocument.Parse(xmlstr).Element("sqroot").Element("reportfolder").Value
                        'Session("signinPage") = XDocument.Parse(xmlstr).Element("sqroot").Element("signinpage").Value
                        'Session("frontPage") = XDocument.Parse(xmlstr).Element("sqroot").Element("frontpage").Value
                        Response.Cookies("hostGUID").Value = curHostGUID
                        Response.Cookies("isLogin").Value = 1
                    Else
                        xmlstr = "<sqroot><message>Incorrect Password!</message></sqroot>"
                    End If
                    '--!
                    Dim cartID = Request.QueryString("cartID")
                    If Not cartID Is Nothing Then
                        sqlstr = "exec dbo.checkToPCSO '" & curHostGUID & "', '" & cartID & "'"
                        Dim xmlstr2 = runSQLwithResult(sqlstr, curODBC)
                    End If
                    '--!
                    isSingle = False

                End If
        End Select
        If isSingle Then xmlstr = getXML(sqlstr, curODBC)


        If Not noxml Then
            'If Len(xmlstr) > 50 Then
            Response.ContentType = "text/xml"
                Response.Write("<?xml version=""1.0"" encoding=""utf-8""?>")
                Response.Write(xmlstr)
            'Else
            'Response.Write("message")
            'End If
        Else
            Response.Write("ok")
        End If
    End Sub
    'Function changeUser(GUID As String) As String
    '    Dim sqlstr As String = "update coUSERHOST set hostGUID=newid(), delegateUserGUID=null, updatedDate=getdate() where userGUID='" & Session("UserGUID") & "'"
    '    Dim r As Boolean = runSQL(sqlstr, curodbc)
    '    If GUID.ToLower <> Session("OriginalUserGUID").ToString.ToLower Then
    '        sqlstr = "update coUSERHOST set hostGUID='" & Session("hostGUID") & "', delegateUserGUID='" & Session("OriginalUserGUID") & "', updatedDate=getdate() where userGUID='" & GUID.ToLower & "'"
    '    Else
    '        sqlstr = "update coUSERHOST set hostGUID='" & Session("hostGUID") & "', updatedDate=getdate() where userGUID='" & GUID.ToLower & "';update coUSERHOST set delegateUserGUID=null where delegateUserGUID='" & GUID.ToLower & "'"
    '    End If
    '    r = runSQL(sqlstr, curodbc)
    '    sqlstr = "select username from coUSER where userGUID= '" & GUID.ToLower & "'"
    '    Dim rx As String = runSQLwithResult(sqlstr)

    '    sqlstr = "select userid from coUSER where userGUID= '" & GUID.ToLower & "'"
    '    Dim rxid As String = runSQLwithResult(sqlstr)

    '    If Session("OriginalUserGUID").ToString.ToLower = GUID.ToString.ToLower Then
    '        Session("DelegateUserGUID") = ""
    '        Session("DelegateUserName") = ""
    '        Session("UserGUID") = Session("OriginalUserGUID")
    '        Session("UserName") = Session("OriginalUserName")
    '    Else
    '        Session("DelegateUserGUID") = GUID.ToLower
    '        Session("DelegateUserName") = rx
    '        Session("UserGUID") = GUID.ToLower
    '        Session("UserName") = rx
    '    End If

    '    Dim MyCookie As New HttpCookie("OPH_UserId")
    '    MyCookie.Value = rxid
    '    MyCookie.Expires = Now.AddMonths(1)
    '    Response.Cookies.Add(MyCookie)

    '    'ds.Tables(0).Rows(0).Item("UserGUID").ToString

    '    Dim MyCookie3 As New HttpCookie("OPH_UserGUID")
    '    MyCookie3.Value = Session("UserGUID")
    '    MyCookie3.Expires = Now.AddMonths(1)
    '    Response.Cookies.Add(MyCookie3)

    '    'MsgBox("Password has been changed", MsgBoxStyle.Information)
    '    'Return ""
    '    Return "<script>window.location='account/main.aspx';</script>"
    'End Function
End Class
