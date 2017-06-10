Imports System.IO

Partial Class OPHCore_API_default
    Inherits cl_base_view

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        loadAccount()
        Dim curODBC = contentOfdbODBC
        Dim DBCore = contentOfsqDB
        Dim curHostGUID = Session("hostGUID")
        Dim curUserGUID = Session("userGUID")

        Dim sqlstr = ""
        Dim noxml = False
        'Dim isValid = False
        Dim appSettings = ConfigurationManager.AppSettings

        'If (getQueryVar("login") = "true") Then
        '    Dim acct = getQueryVar("acct")
        '    Dim uid = getQueryVar("uid")
        '    Dim ups = getQueryVar("ups")
        '    Dim conn = appSettings.Item("Connection")

        '    If (acct <> "" And uid <> "" And ups <> "") Then
        '        isValid = GetConnect(acct, acct, uid, ups, "", conn)
        '    End If

        '    If isValid Then
        '        hGUID = getQueryVar("hostGUID")
        '        reloadURL("../index.aspx?mode=view&tablename=caUPWD&GUID=" & Session("UserGUID"))
        '    End If
        'End If


        'If hGUID = "" Then
        'SignOff()
        'Response.Write("<script>" & contentofSignOff & "</script>")
        'Else
        Dim isSingle = True
        Dim xmlstr = ""
        Dim xmlstr1 = ""
        'End If

        Dim mode = getQueryVar("mode")
        If mode = "" Then
            mode = Request.Form("mode")
        End If

        Dim code = ""
        If getQueryVar("code") <> "" Then code = "" & getQueryVar("code") & ""
        If code = "" Then
            code = Request.Form("code")
        End If
        'Dim pathpage = getQueryVar("firstpage") + "&tablename=" & code & ""
        'If pathpage Is Nothing Then pathpage = ""
        Dim GUID = "null"
        If getQueryVar("GUID") <> "" And getQueryVar("GUID") <> "undefined" Then GUID = "'" & getQueryVar("GUID") & "'"

        Select Case mode
            Case "master"
                Dim stateid = getQueryVar("stateid")

                sqlstr = "exec [api].[theme] '" & curHostGUID & "', '" & code & "', " & GUID
            Case "browse"
                Dim sqlfilter = getQueryVar("sqlFilter")
                Dim sortOrder = getQueryVar("sortOrder")
                Dim stateid = getQueryVar("stateid")
                Dim bpage = getQueryVar("bPageNo")
                Dim searchText = getQueryVar("bSearchText")
                'Dim initialT As String
                'initialT = code.Substring(0, 1).ToUpper

                'If sqlfilter = "" Then sqlfilter = ""
                If sortOrder = "" Or sortOrder = "," Then sortOrder = ""
                If stateid = "" Or stateid = "" Or stateid = "," Then
                    sqlstr = "select c.StateID from modl a inner join msta b on a.ModuleStatusGUID=b.ModuleStatusGUID inner join mstastat c on b.ModuleStatusGUID=c.ModuleStatusGUID and c.isDefault=1 where moduleid='" & code & "'"
                    stateid = runSQLwithResult(sqlstr, curODBC)
                    'stateid = "null"
                End If
                If searchText = "" Or searchText = "search" Then searchText = ""
                If bpage = "" Then bpage = 1

                Dim rpp = 20 'IIf(code.Length() > 6 And String.IsNullOrWhiteSpace(sqlfilter) = False, 10, 20)
                'add showpage untuk frontend
                Dim showpage = getQueryVar("showpage")
                If showpage <> "" Then
                    rpp = showpage
                End If
                sqlstr = "exec [api].[theme_browse] '" & curHostGUID & "', '" & code & "', '" & sqlfilter.Replace("'", "''") & "', '" & searchText.Replace("'", "''") & "', " & bpage & ", " & rpp & ", '" & sortOrder & "', '" & stateid & "'"

                isSingle = False
                xmlstr = getXML(sqlstr, curODBC)
                If xmlstr <> "" Then
                    xmlstr1 = xmlstr.Substring(1, 6)
                Else
                    writeLog("browse : " & sqlstr)
                    'Stop
                End If
                '"You dont have authority!!!"
                If xmlstr1 <> "sqroot" Then
                    xmlstr = runSQLwithResult(sqlstr, curODBC)
                    xmlstr = "<messages><message>" & xmlstr & "</message></messages>"
                    isSingle = False
                End If
            Case "view", "form"
                'editmode=getQueryVar("editmode")
                sqlstr = "exec [api].[theme_form] '" & curHostGUID & "', '" & code & "', " & GUID '& ", " & editMode
            'Case "approval"
            '    sqlstr = "exec [xml].[view_approval] " & curHostGUID & ", '" & code & "', " & GUID '& ", " & editMode
            'Case "doctalk"
            '    sqlstr = "exec gen.xml_browse_block_talk " & curHostGUID & ", " & GUID '& ""
            'Case "talk"
            '    Dim comment = getQueryVar("comment")
            '    sqlstr = "exec oph.caTALK_save NULL, " & curHostGUID & ", " & GUID & ", '" & comment & "'"
            '    runSQLwithResult(sqlstr, curODBC)
            '    sqlstr = "exec gen.xml_browse_block_talk " & curHostGUID & ", " & GUID & ""
            Case "save", "preview"
                isSingle = False
                Dim preview = getQueryVar("flag")
                GUID = System.Guid.NewGuid().ToString()

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

                    Dim fxn As String = path & "\" & contentOfaccountId & "\" & code & "_" & curField & "\" & szFilename & "\" & GUID.Replace("'", "") & "_" & Request.Files(f).FileName

                    Dim checkDir = path & "\" & contentOfaccountId & "\" & code & "_" & curField & "\" & szFilename & "\"
                    If Not Directory.Exists(checkDir) Then Directory.CreateDirectory(checkDir)
                    If Directory.Exists(checkDir) Then
                        If fxn <> "" Then Request.Files(f).SaveAs(fxn)
                    End If
                Next

                sqlstr = populateSaveXML(1, code, preview, fieldattachment, GUID)
                sqlstr = sqlstr.Replace("#95#", "_")
                sqlstr = sqlstr & ", @preview=" & IIf(preview = "", 0, preview)
                xmlstr = runSQLwithResult(sqlstr, curODBC)

                If Not xmlstr.Contains("<sqroot>") Or xmlstr.Contains("<root>") Then
                    xmlstr = xmlstr.Replace("<root>", "")
                    xmlstr = xmlstr.Replace("</root>", "")
                    xmlstr = xmlstr.Replace("<row>", "")
                    xmlstr = xmlstr.Replace("</row>", "")
                    xmlstr = "<messages><message>" & xmlstr & "</message></messages>"
                End If

            Case "upload"
                Dim flag = getQueryVar("flag")
                Dim UploadFolder = Server.MapPath(Replace(getQueryVar("UploadFolder"), "|", "\"))
                Dim QuerySQL = getQueryVar("QuerySQL")
                Dim Separation = getQueryVar("Separation")
                Dim Id = getQueryVar("Id")
                Dim QueryCode = getQueryVar("QueryCode")

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
                        sqlstr1 = "exec CaUPLD_save '" & Id.Replace("'", "") & "', '" & curHostGUID & "','" & Id.Replace("'", "") & "','" & fxn & "','" & QueryCode & "'"
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
                            sqlstr = "exec gen.upload_select '" & GUID.Replace("'", "") & "', '" & curHostGUID & "', '" & code & "', '" & filename & "', '" & filepath & "'"
                            runSQL(sqlstr, curODBC)
                        End If
                    End If
                Next
                noxml = True
                isSingle = False

            Case "function"
                Dim functionName = IIf(String.IsNullOrWhiteSpace(Request.Form("cfunction")), getQueryVar("cfunction"), Request.Form("cfunction"))
                Dim functionlist = IIf(String.IsNullOrWhiteSpace(Request.Form("cfunctionlist")), getQueryVar("cfunctionlist"), Request.Form("cfunctionlist"))
                Dim comment = getQueryVar("comment")

                Dim fl = functionlist.Split(",")
                For Each f In fl
                    If f = "" Then f = "null" Else f = "'" & f & "'"
                    sqlstr = "exec api.[function] @hostGUID='" & curHostGUID & "', @mode='" & functionName & "', @code='" & code & "', @GUID=" & f & ", @comment='" & comment & "'"
                    xmlstr &= runSQLwithResult(sqlstr, curODBC)
                Next
                Dim msg = xmlstr
                xmlstr = "<messages><message>" & xmlstr & "</message></messages>"
                isSingle = False
            Case "report"
                sqlstr = "exec [api].[theme_report] '" & curHostGUID & "', '" & code & "'"
                xmlstr &= runSQLwithResult(sqlstr, curODBC)
            'Case "date"
            '    Dim field = getQueryVar("FieldName")
            '    sqlstr = "select '" & field & "' from '" & code & "'"
            '    xmlstr &= runSQLwithResult(sqlstr, curODBC)
                'Case "uploader"
                '    Dim QueryCode = getQueryVar("QueryCode")
                '    If QueryCode = "" Then
                '        contentofError = "No tablename found"
                '        Response.Redirect(Back())
                '        Exit Sub
                '    End If
                '    sqlstr = "exec [xml].[Uploader] " & curHostGUID & ", '" & code & "', '" & QueryCode & "'"
                '    xmlstr &= runSQLwithResult(sqlstr, curODBC)
                'Case "switch"
                'xmlstr = changeUser(getQueryVar("GUID"))
                'xmlstr = "" & "You act as yourself." & ""
                'isSingle = False
                'Case "page"
                '    Dim curPage = getQueryVar("CurPage")
                '    curPage = Right(curPage, curPage.Length - curPage.IndexOf("OPH") - 4)
                '    curPage = curPage.Replace("*", "&")
                '    sqlstr = "update coUSER set firstPage='" & curPage & "' where userGUID='" & Session("userGUID") & "'"
                '    runSQL(sqlstr, curODBC)
                'Case "calculate"
                '    sqlstr = "exec [xml].[browsecount]  '" & code & "'," & curHostGUID & ""
                'Case "countnew"
            '    sqlstr = "exec [xml].[countnew]  " & curHostGUID & ",'" & getQueryVar("caption") & "','" & getQueryVar("formnow") & "'"
            'Case "sidebar"
            '    sqlstr = "exec [api].[sidebar] " & curHostGUID & ", '" & code & "', " & GUID
            Case "signout"
                Response.Cookies("guestID").Value = ""
                Session.Clear()
                Session.RemoveAll()
                Session.Abandon()
                noxml = True
                isSingle = False
                'Response.Cookies("isLogin").Value = 0
                'reloadURL("../../index.aspx")
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
            Case Else 'signin
                'Dim ACCOUNTID = appSettings.Item("accountid")
                Dim userid = getQueryVar("userid")
                Dim pwd = getQueryVar("pwd")
                If userid = "" And pwd = "" Then
                    reloadURL("index.aspx?")
                Else
                    Dim bypass = 0
                    If checkWinLogin(userid, pwd) Then
                        bypass = 1
                        sqlstr = "select infovalue from acctinfo a inner join acct b on a.accountguid=b.accountguid where infokey='masterPassword' and accountid='" & contentOfaccountId & "'"
                        pwd = runSQLwithResult(sqlstr, contentOfsequoiaCon)
                    End If
                    sqlstr = "exec api.verifyPassword '" & curHostGUID & "', '" & userid & "', '" & pwd & "', " & bypass
                    xmlstr = getXML(sqlstr, curODBC)

                    If xmlstr IsNot Nothing And xmlstr <> "" Then
                        curUserGUID = XDocument.Parse(xmlstr).Element("sqroot").Element("userGUID").Value
                        Session("userGUID") = curUserGUID
                        'Response.Cookies("hostGUID").Value = curHostGUID
                        Response.Cookies("isLogin").Value = 1
                    Else
                        xmlstr = "<sqroot><message>Incorrect Password!</message></sqroot>"
                    End If
                    '--!
                    Dim cartID = getQueryVar("cartID")
                    If cartID <> "" Then
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
