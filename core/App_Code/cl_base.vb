'Imports Microsoft.VisualBasic
Imports System
Imports System.Diagnostics
Imports System.DirectoryServices.AccountManagement
Imports System.DirectoryServices.ActiveDirectory.Domain

Imports System.IO
Imports System.IO.Compression

Imports System.Data
Imports System.Data.SqlClient

Imports System.Xml

Public Class cl_base
    Inherits System.Web.UI.Page

    Protected contentOfsequoiaCon As String
    Protected contentOfaccountId As String
    Protected contentOfaccountGUID As String

    Protected contentOfthemeFolder As String
    Protected contentOfthemePage As String
    Protected contentOfdbODBC As String
    Protected contentOfsqDB As String
    Protected contentOfCode As String
    Protected contentOfGUID As String
    Protected contentOfEnv As String
    Protected contentofNeedLogin As Boolean
    Protected contentofsignInPage As String
    Protected contentofwhiteAddress As Boolean
    Protected contentofManifest As String
    Protected contentofLastVer As String
    Protected errorCaptcha As String
    Protected contentofOfflineCode As String
    Protected wordofWindowOnLoad As String = ""

    Protected contentOfScripts As String
    Protected contentofError As String = ""

    Protected isOnDelegation As Boolean = False
    Protected contentofHostGUID As String = ""
    Protected contentofUserGUID As String = ""
    Protected contentofSaveString As String = ""
    Protected contentofUserName As String = ""

#Region "Properties Section"
    'Public Property headTitle() As String
    '    Get
    '        Return wordofHeadTitle
    '    End Get
    '    Set(ByVal value As String)
    '        wordofHeadTitle = value
    '    End Set
    'End Property
    'Public Property headLinkHRef() As String
    '    Get
    '        Return "<link rel=""stylesheet"" href=""" & wordofHeadLinkHRef & """ type=""text/css"" />"
    '    End Get
    '    Set(ByVal value As String)
    '        wordofHeadLinkHRef = value
    '    End Set
    'End Property
    'Public Property headScript() As String
    '    Get
    '        Return contentofHeadScript
    '    End Get
    '    Set(ByVal value As String)
    '        contentofHeadScript = contentofHeadScript & value
    '    End Set
    'End Property
    'Public Property BodyOnLoad() As String
    '    Get
    '        Return wordofBodyOnLoad
    '    End Get
    '    Set(ByVal value As String)
    '        If wordofBodyOnLoad = "" And value <> "" Then
    '            wordofBodyOnLoad = "javascript:" & value
    '        Else
    '            wordofBodyOnLoad = wordofBodyOnLoad & value
    '        End If
    '    End Set
    'End Property
    Public Property WindowOnLoad() As String
        Get
            Return wordofWindowOnLoad
        End Get
        Set(ByVal value As String)
            If wordofWindowOnLoad = "" And value <> "" Then
                wordofWindowOnLoad = "" & value & vbCrLf
            Else
                wordofWindowOnLoad = wordofWindowOnLoad & value
            End If
        End Set

    End Property

    'Public Property BodyContextMenu() As String
    '    Get
    '        Return wordofBodyContextMenu
    '    End Get
    '    Set(ByVal value As String)
    '        If wordofBodyContextMenu = "" And value <> "" Then
    '            wordofBodyContextMenu = "javascript:" & value
    '        Else
    '            wordofBodyContextMenu = wordofBodyContextMenu & value
    '        End If
    '    End Set
    'End Property
    'Public Property BodyCaption() As String
    '    Get
    '        Return contentofBodyCaption
    '    End Get
    '    Set(ByVal value As String)
    '        'If contentofBodyCaption = "" And value <> "" Then
    '        contentofBodyCaption = ""
    '        'ElseIf contentofBodyCaption <> "" Then
    '        'contentofBodyCaption &= "<span class=""bodySubCaption"">"
    '        'contentofBodyCaption = Left(contentofBodyCaption, Len(contentofBodyCaption) - 7)
    '        'End If
    '        contentofBodyCaption = contentofBodyCaption & value
    '    End Set
    'End Property
    'Public ReadOnly Property freeText() As String
    '    Get
    '        Return contentofFreeText.Replace("##text##", "").Replace("##hidden##", "").Replace("##button##", "")
    '    End Get
    '    'Set(ByVal value As String,)
    '    'contentofFreeText = value
    '    'End Set
    'End Property


#End Region
#Region "Utility"
    Function nz(obj As Object) As Object
        If obj Is Nothing Then
            Return ""
        ElseIf IsDBNull(obj) Then
            Return ""
        Else
            Return obj
        End If
    End Function
    Sub reloadURL(url As String)
        Dim x = Request.ApplicationPath
        'writeLog(x)
        'writeLog(url)
        Dim newURL = url.Substring(InStr(url, "?"))

        Dim par = newURL.Split("&")
        Dim env As String = "", code As String = "", guid As String = "", otherpars As String = ""
        For Each p In par
            If p <> "" AndAlso p.Split("=")(1) <> "" Then

                If p.Split("=")(0) = "env" Then
                    env = p.Split("=")(1)
                ElseIf p.Split("=")(0) = "code" Then
                    code = p.Split("=")(1)
                ElseIf p.Split("=")(0) = "guid" Then
                    guid = p.Split("=")(1)
                Else
                    otherpars &= p.Split("=")(0) & "=" & p.Split("=")(1) & "&"
                End If
            End If
        Next
        'rewrite
        'newURL = "index.aspx" & IIf(env <> "", env & "/", "") & IIf(code <> "", code & "/", "") & IIf(guid <> "", guid & "/", "") & otherpars
        newURL = "index.aspx?" & IIf(env <> "", "env=" & env & "&", "") & IIf(code <> "", "code=" & code & "&", "") & IIf(guid <> "", "guid=" & guid & "&", "") & otherpars
        newURL = IIf(Right(newURL, 2) = "/?", Replace(newURL, "/?", ""), newURL)
        newURL = IIf(Right(newURL, 1) = "&", newURL.Substring(0, Len(newURL) - 1), newURL)

        Response.Redirect(newURL)

    End Sub

    Sub loadManifest(themeFolder As String, cdnLocation As String, Optional isOffline As Boolean = False)
        'themeFolder = IIf(themeFolder = "", contentOfthemeFolder, themeFolder)
        'cdnLocation = IIf(cdnLocation = "", "OPHContent/cdn", "")
        Dim path = Server.MapPath("~/")
        contentOfScripts = ""
        'core
        path = path.Substring(0, Len(path) - 5) & "core\OPHCore"
        Dim manifestPath = path & "\manifest.xml"
        Dim manifest As String = "", lastVer As String = ""
        contentOfScripts = loadManifestFile(manifestPath, manifest, lastVer, cdnLocation)

        'selected theme
        path = Server.MapPath("~/")
        path = path.Substring(0, Len(path) - 5) & "themes\" & themeFolder
        manifestPath = path & "\manifest.xml"
        contentOfScripts &= loadManifestFile(manifestPath, manifest, lastVer, cdnLocation)

        'If isOffline Then

        'End If

        If lastVer > Session("latestCache") Then
            Session("latestCache") = lastVer
            Session("cacheManifest") = manifest
            contentofLastVer = lastVer
            contentofManifest = manifest
        End If

    End Sub
    Function loadOfflineData(code As String, guid As String) As String
        Dim path = Server.MapPath("~/OPHContent/themes")
        Dim sqlstr = "select moduleid, tp.pageURL, t.ThemeCode from modl m inner join thmepage tp on m.ThemePageGUID=tp.themepageguid inner join thme t on tp.ThemeGUID=t.ThemeGUID where m.parentmoduleguid is null and m.moduleid='" & code & "'"
        Dim scripts = ""
        Dim ds As DataSet = SelectSqlSrvRows(sqlstr)
        If ds.Tables.Count > 0 Then
            Dim r As DataRow
            For Each r In ds.Tables(0).Rows
                If scripts <> "" Then scripts &= ", " & vbCrLf
                scripts &= "'index.aspx?code=" & r.Item(0) & "'," & vbCrLf
                If File.Exists(path & "\" & r.Item(2) & "\xslt\" & r.Item(1) & ".xslt") Then
                    scripts &= "'OPHContent/themes/" & r.Item(2) & "/xslt/" & r.Item(1) & ".xslt'," & vbCrLf
                End If
                If File.Exists(path & "\" & r.Item(2) & "\xslt\" & r.Item(1) & "_browse.xslt") Then
                    scripts &= "'OPHContent/themes/" & r.Item(2) & "/xslt/" & r.Item(1) & "_browse.xslt'," & vbCrLf
                End If
                If File.Exists(path & "\" & r.Item(2) & "\xslt\" & r.Item(1) & "_browse_sidebar.xslt") Then
                    scripts &= "'OPHContent/themes/" & r.Item(2) & "/xslt/" & r.Item(1) & "_browse_sidebar.xslt'," & vbCrLf
                End If
                scripts &= "'OPHCore/api/default.aspx?mode=master&code=" & r.Item(0) & "'," & vbCrLf
                scripts &= "'OPHCore/api/default.aspx?mode=browse&code=" & r.Item(0) & "&stateid=0'," & vbCrLf
                scripts &= "'OPHCore/api/default.aspx?mode=form&code=" & r.Item(0) & "&GUID=00000000-0000-0000-0000-000000000000'"


            Next
        End If
        Return scripts
    End Function
    Function loadManifestFile(path As String, ByRef manifest As String, ByRef latestVer As String, cdnLocation As String) As String
        Dim str As String = "" ', manstr As String = ""
        If cdnLocation = "" Then cdnLocation = "OPHContent/cdn"
        If System.IO.File.Exists(path) Then
            Dim lastMod = System.IO.File.GetLastWriteTime(path).ToString("yyyyMMddhhmmss")
            If lastMod > latestVer Then latestVer = lastMod
            If Session("manifest" & path.Replace("/", "").Replace("\", "").Replace(".", "").Replace(":", "") & lastMod) Is Nothing Then
                Dim doc As XmlDocument = New XmlDocument()
                doc.Load(path)

                Dim jsFile As XmlNode
                Dim cssFile As XmlNode

                Dim sqroot As XmlNode = doc.DocumentElement

                For Each cssFile In doc.SelectNodes("//cssFile")
                    'jsFile.InnerText = (jsFile.InnerText)
                    'contentOfScripts = jsFile.InnerText
                    'str &= "<link rel=""stylesheet"" href=""" & cssFile.InnerText.Replace("OPHContent/cdn", cdnLocation) & "?unique=" & Format(lastMod, "yyyyMMddhhmmss") & """ type=""text/css"" />" & vbCrLf
                    str &= "<link rel=""stylesheet"" href=""" & cssFile.InnerText.Replace("OPHContent/cdn", cdnLocation) & """ type=""text/css"" />" & vbCrLf
                    manifest &= cssFile.InnerText.Replace("OPHContent/cdn", cdnLocation) & vbCrLf
                Next


                For Each jsFile In doc.SelectNodes("//jsFile")
                    'jsFile.InnerText = (jsFile.InnerText)
                    'contentOfScripts = jsFile.InnerText
                    'str &= "<script type=""text/javascript"" src=""" & jsFile.InnerText.Replace("OPHContent/cdn", cdnLocation) & "?unique=" & Format(lastMod, "yyyyMMddhhmmss") & """></script>" & vbCrLf
                    str &= "<script type=""text/javascript"" src=""" & jsFile.InnerText.Replace("OPHContent/cdn", cdnLocation) & """></script>" & vbCrLf
                    manifest &= jsFile.InnerText.Replace("OPHContent/cdn", cdnLocation) & vbCrLf
                Next
                'Session("manifestCache") = manstr
                'If manifest.Substring(0, 1) = "," Then
                'manifest = manifest.Substring(1, Len(manifest) - 1)
                'End If
                Session("manifest" & path.Replace("/", "").Replace("\", "").Replace(".", "").Replace(":", "") & lastMod) = str

            Else
                str = Session("manifest" & path.Replace("/", "").Replace("\", "").Replace(".", "").Replace(":", "") & lastMod)
            End If

        End If

        Return str
    End Function
    'unremark if you need this, not compatible for ophbox - please find solution to download ref imports
    'Function checkWinLogin(username As String, userpass As String) As Boolean
    '    Dim success = False

    '    Try
    '        Dim domains = GetCurrentDomain.Name.ToString
    '        If InStr(username, "\") > 0 Then
    '            domains = Left(username, InStr(username, "\") - 1)
    '            username = username.Replace(domains & "\", "")
    '        End If

    '        'username = "superuser"
    '        'userpass = "ljcom2x"
    '        'Dim domains = "libertyjayaone.local"
    '        Dim domainContext As PrincipalContext = New PrincipalContext(ContextType.Domain, domains)
    '        success = domainContext.ValidateCredentials(username, userpass)
    '        'Else
    '        ' Return False
    '        ' End If
    '    Catch ex As Exception
    '        Debug.Print(ex.Message)
    '    End Try
    '    Return success  'changePassword(username, userpass, "ljcomljcom")

    'End Function
    'Function changePassword(username As String, oldpassword As String, newpassword As String) As Boolean
    '    Dim domains = GetCurrentDomain.Name.ToString
    '    If InStr(username, "\") > 0 Then
    '        domains = Left(username, InStr(username, "\") - 1)
    '        username = username.Replace(domains & "\", "")
    '    End If

    'username = "superuser"
    'userpass = "ljcom2x"
    'Dim domains = "libertyjayaone.local"
    '    Dim domainContext As PrincipalContext = New PrincipalContext(ContextType.Domain, domains)
    '    Dim user As UserPrincipal = UserPrincipal.FindByIdentity(domainContext, username)
    '    Dim success = False
    '    Try
    '        user.ChangePassword(oldpassword, newpassword)
    '        success = True
    '    Catch ex As Exception
    '        'Stop
    '    End Try

    '    Return success
    'End Function
#End Region
#Region "Form Control"
    Function Fn_Global(ByVal number As String, ByVal mode As String, ByVal digit As Long) As String
        Dim jmldigit, jmlkoma, index, result, number1, isdecimal, decimalmode, separatormode, isminus As String
        index = 1
        isminus = ""
        isdecimal = 0
        If number.IndexOf("-") > -1 Then
            isminus = "-"
            number = number.Substring(1, number.Length - 1)
        End If
        If mode = "ID" Then
            decimalmode = ","
            separatormode = "."

        Else
            decimalmode = "."
            separatormode = ","
        End If
        result = ""
        number1 = number

        If number.IndexOf(".") > 0 Then
            number = number.Substring(0, number.IndexOf("."))

            isdecimal = 1
        End If

        jmldigit = number.Length()
        jmlkoma = jmldigit / 3
        If jmlkoma < 1 Then
            result = number


        Else
            While (jmldigit > 0)

                result += number.Substring(index - 1, 1)
                jmldigit -= 1

                If jmldigit Mod 3 = 0 And jmlkoma > 1 Then
                    result += separatormode
                    jmlkoma -= 1
                End If

                index += 1


            End While
        End If
        If isdecimal = 1 Then
            If digit.ToString = "" Then
                digit = number1.Length - number1.IndexOf(".") - 1
            End If
            If digit > 0 Then
                result += decimalmode + number1.Substring(number1.IndexOf(".") + 1, digit)
            End If
            result = isminus + result
        End If
        Return result
    End Function


    Function CheckBox(ByVal id As String, Optional ByVal inputValue As String = "", Optional ByVal EditMode As Long = 1, Optional ByVal size As String = "20", Optional ByVal align As String = "Left", Optional ByVal linkedfield As String = "") As String
        Dim retval As String
        Dim checked As String
        If inputValue = "True" Then
            checked = "checked"
        Else
            checked = " "
        End If
        If EditMode = 0 Then
            retval = "<INPUT name=""" & id & """ type=""Checkbox"" onclick=""javascript:activateField('" & linkedfield & "','" & id & "')"" value=""1"" style=text-align:" & align & " id=""" & id & """  size=" & size & " " & checked & " disabled>"
        Else
            retval = "<INPUT name=""" & id & """ type=""Checkbox"" onclick=""javascript:activateField('" & linkedfield & "','" & id & "')"" value=""1"" style=text-align:" & align & " id=""" & id & """  size=" & size & " " & checked & ">"
        End If
        Return retval
    End Function

    Function TextBox(ByVal id As String, Optional ByVal type As String = "text", Optional ByVal inputValue As String = "",
        Optional ByVal EditMode As Long = 1, Optional ByVal size As String = "20",
        Optional ByVal align As String = "Left", Optional ByVal datatype As String = "", Optional ByVal NumberSetting As String = "EN", Optional ByVal digitMode As String = "0",
        Optional className As String = "") As String

        Dim retval As String, rows As Long, cols As Long
        Select Case datatype
            Case 48, 52, 56, 59, 62, 106, 108, 122, 127, 262
                inputValue = Fn_Global(inputValue, NumberSetting, digitMode)
            Case 60, 257, 263
                inputValue = Fn_Global(inputValue, NumberSetting, digitMode)
        End Select
        If size = "" Then size = 10
        If size > 50 Then
            rows = size \ 50
            If rows > 6 Then rows = 6
            cols = 50
            If type <> "hidden" And type <> "combo" Then
                type = "textarea"
            End If

        End If
        If type = "textarea" Then
            If EditMode = 0 Then
                retval = "<TEXTAREA id=""" & id & """ name=""" & id & """ rows=2 cols=" & cols & " maxlength=" & size & " class=""" & IIf(className <> "", className, "textBoxClearBorder") & """ onkeyup=""javascript:autogrow(this);"" title=""" & inputValue & """ readonly>" & inputValue & "</textarea>"
            ElseIf EditMode = 2 Then
                retval = "<TEXTAREA id=""" & id & """ name=""" & id & """ rows=2 cols=" & cols & " maxlength=" & size & " class=""" & IIf(className <> "", className, "textBoxClearBorder") & """ onkeyup=""javascript:autogrow(this);"" title=""" & inputValue & """ readonly>" & inputValue & "</textarea>"
            Else
                retval = "<TEXTAREA id=""" & id & """ name=""" & id & """ rows=2 cols=" & cols & " maxlength=" & size & " class=""" & IIf(className <> "", className, "textBoxStandard") & """ onkeyup=""javascript:autogrow(this);"" onkeypress=""cekinput('" & datatype & "','" & id & "')"" onkeyup=""cektanda('" & datatype & "','" & id & "')"" title=""" & inputValue & """>" & inputValue & "</textarea>"

            End If
        ElseIf type = "checkbox" Then
            Dim checked As String
            If inputValue = "True" Or inputValue = "Yes" Or inputValue = "1" Or inputValue = "-1" Then
                checked = "checked"
            Else
                checked = " "
            End If
            If EditMode = 0 Then
                If size = 0 Then
                    retval = "<INPUT id=""" & id & """ name=""" & id & """ type=""" & type & """ value =1 style=""display:none;text-align:" & align & """ size=" & size & " " & checked & ">"
                Else
                    retval = "<INPUT id=""" & id & """ name=""" & id & """ type=""" & type & """ value =1 style=text-align:" & align & " size=" & size & " " & checked & " disabled>"
                End If
            ElseIf EditMode = 2 Then
                If size = 0 Then
                    retval = "<INPUT id=""" & id & """ name=""" & id & """ type=""" & type & """ value =1 style=""display:none;text-align:" & align & """ size=" & size & " " & checked & " disabled>"
                Else

                    retval = "<INPUT id=""" & id & """ name=""" & id & """ type=""" & type & """ value =1 style=text-align:" & align & " size=" & size & " " & checked & " disabled>"
                End If
                'retval = "<span class=labelStandard>" & inputValue & "</span>"
            Else
                If size = 0 Then
                    retval = "<INPUT id=""" & id & """ name=""" & id & """ type=""" & type & """ value =1 style=display:none;text-align:" & align & " size=" & size & " " & checked & ">"
                Else
                    retval = "<INPUT id=""" & id & """ name=""" & id & """ type=""" & type & """ value =1 style=text-align:" & align & " size=" & size & " " & checked & ">"
                End If
            End If
        ElseIf type = "combo" Then    'combo
            If EditMode = 0 Then
                retval = "<div id=""" & id & "_div"" class=""" & IIf(className <> "", className, "textBoxClearBorder") & """ style=""white-space: nowrap""><INPUT id=""" & id & """ name=""" & id & """ type=""" & type & """ value = """ & inputValue & """ style=text-align:" & align & " class=""" & IIf(className <> "", className, "textBoxHiddenBorder") & """ size=" & size & " maxlength=" & size & " onkeypress=""cekinput('" & datatype & "','" & id & "')"" readonly></div>"
            ElseIf EditMode = 2 Then
                retval = "<div id=""" & id & "_div"" class=""" & IIf(className <> "", className, "textBoxClearBorder") & """ style=""white-space: nowrap""><INPUT id=""" & id & """ name=""" & id & """ type=""" & type & """ value = """ & inputValue & """ style=text-align:" & align & " class=""" & IIf(className <> "", className, "textBoxHiddenBorder") & """ size=" & size & " maxlength=" & size & " onkeypress=""cekinput('" & datatype & "','" & id & "')"" readonly></div>"
                'retval = "<span class=labelStandard>" & inputValue & "</span>"
            Else
                retval = "<div id=""" & id & "_div"" class=""" & IIf(className <> "", className, "textBoxBorder") & """ style=""white-space: nowrap""><INPUT id=""" & id & """ name=""" & id & """ type=""" & type & """ value = """ & inputValue & """ style=text-align:" & align & "  class=""" & IIf(className <> "", className, "textBoxHiddenBorder") & """ size=" & size & " maxlength=" & size & " onkeypress=""cekinput('" & datatype & "','" & id & "')"" onkeyup=""cektanda('" & datatype & "','" & id & "')""><img id=""" & id & "_button"" class=""comboImg"" src=""OPHContent/themes/" & Session("skinFolder") & "/images/select.gif"" title=""you can type the keyword to show the selected list or <blank> to show all list."" /></div>"
            End If

        Else    'textbox
            If EditMode = 0 Then

                retval = "<INPUT id=""" & id & """ name=""" & id & """ type=""" & type & """ value = """ & inputValue & """ style=text-align:" & align & " class=""" & IIf(className <> "", className, "textBoxClearBorder") & """ size=" & size & " maxlength=" & size & " onkeypress=""cekinput('" & datatype & "','" & id & "')"" readonly>"
            ElseIf EditMode = 2 Then
                retval = "<INPUT id=""" & id & """ name=""" & id & """ type=""" & type & """ value = """ & inputValue & """ style=text-align:" & align & " class=""" & IIf(className <> "", className, "textBoxClearBorder") & """ size=" & size & " maxlength=" & size & " onkeypress=""cekinput('" & datatype & "','" & id & "')"" readonly>"
                'retval = "<span class=labelStandard>" & inputValue & "</span>"
            Else
                retval = "<INPUT id=""" & id & """ name=""" & id & """ type=""" & type & """ value = """ & inputValue & """ style=text-align:" & align & " class=""" & IIf(className <> "", className, "textBoxStandard") & """ size=" & size & " maxlength=" & size & " onkeypress=""cekinput('" & datatype & "','" & id & "')"" onkeyup=""cektanda('" & datatype & "','" & id & "')"">"
            End If
        End If
        Return retval
    End Function

    Function TextCaption(ByVal caption As String, Optional ByVal isBold As Boolean = False, Optional ByVal isRequired As Boolean = False, Optional ByVal isNApproved As Boolean = False, Optional ByVal fieldname As String = "") As String
        Dim retval As String
        Dim cap As String = ""
        If fieldname <> "" Then cap = "id=""cap_" & fieldname & """"
        If isBold Then
            retval = "<span " & cap & " class=labelStandard><b>" & IIf(isNApproved, "<i>", "") & caption & IIf(isNApproved, "</i>", "") & "</b></span>"
        ElseIf isRequired Then
            retval = "<span " & cap & " class=labelStandard>" & IIf(isNApproved, "<i>", "") & caption & IIf(isNApproved, "</i>", "") & "</span>"
        Else
            retval = "<span " & cap & " class=labelStandard><font color=""#808080"">" & IIf(isNApproved, "<i>", "") & caption & IIf(isNApproved, "</i>", "") & "</font></span>"

        End If
        Return retval
    End Function

    Function findProperty(ByVal dss As DataSet, ByVal columnName As String, ByVal Prop As String) As String

        Dim r As DataRow
        Dim x As String = ""
        For Each r In dss.Tables(0).Rows
            If UCase(r.Item("ColName")) = UCase(columnName) Then
                x = r.Item(Prop).ToString
                Exit For
            End If
        Next
        Return x
    End Function

    Sub setCookie(cookieName As String, cookieValue As String, cookieDay As Long)
        'response.Cookies(cookiename)
        If Response.Cookies(cookieName) Is Nothing Then
            Dim MyCookie As New HttpCookie(cookieName)
            MyCookie.Value = cookieValue
            MyCookie.Expires = Now.AddDays(cookieDay)
            Response.Cookies.Add(MyCookie)
        Else
            Response.Cookies(cookieName).Value = cookieValue
        End If
    End Sub
    Sub writeLog(logMessage As String) ', ByVal Optional accountName As String = "")
        'Dim w As TextWriter
        Dim accountName = ""
        If contentOfaccountId <> "" Then accountName = contentOfaccountId
        If logMessage <> "" Then
            Dim path = Server.MapPath("~/OPHContent/log")
            path = path & "\" '& "OPHContent\log\"
            Dim logFilepath = path & DateTime.Now().Year & "\" & Right("0" & DateTime.Now().Month, 2) & "\" & IIf(accountName <> "", accountName & "_", "") & Right("0" & DateTime.Now().Day, 2) & ".txt"
            Dim logPath = path & DateTime.Now().Year & "\" & Right("0" & DateTime.Now().Month, 2) & "\"

            If (Not System.IO.Directory.Exists(logPath)) Then
                System.IO.Directory.CreateDirectory(logPath)
            End If
            Try
                Using w As StreamWriter = File.AppendText(logFilepath)
                    w.Write(vbCrLf + "Log Entry : ")
                    w.WriteLine("{0} {1}: " + vbCrLf + "{2}", DateTime.Now.ToLongTimeString(), DateTime.Now.ToLongDateString(), logMessage)
                    'w.WriteLine("  :{0}", logMessage)
                End Using

            Catch ex As Exception
                Debug.Write(ex.Message.ToString)
            End Try
        End If
    End Sub
    Sub writeFile(path As String, filename As String, content As String, Optional isOverwrite As Boolean = True)

        If (Not System.IO.Directory.Exists(path)) Then
            System.IO.Directory.CreateDirectory(path)
        End If
        Dim saveFile = filename
        If isOverwrite And File.Exists(path & saveFile) Then
            File.Delete(path & saveFile)
        End If

        Try
            Using w As StreamWriter = File.AppendText(path & saveFile)
                w.Write(content)
            End Using

        Catch ex As Exception
            Debug.Write(ex.Message.ToString)
        End Try


    End Sub
    'Function zipFiles(path As String, filename As String, Optional isOverwrite As Boolean)
    '    --zip
    '    If isOverwrite And File.Exists(path & filename) Then
    '        File.Delete(path & filename)
    '    End If
    '    Dim startPath As String = @"c:\example\start"
    '    Dim zipPath As String = @"c:\example\result.zip"
    '        Dim extractPath As String = @"c:\example\extract"

    '        ZipFile.CreateFromDirectory(startPath, zipPath)

    '    zipFile.ExtractToDirectory(zipPath, extractPath)

    'End Function
    Function getQueryVar(key As String) As String
        Dim r = ""

        'replace this:' " ( ) ; , | < > - \ + & $ @
        If Not IsNothing(Request.QueryString(key)) Then
            r = Request.QueryString(key).ToString()
        ElseIf Not IsNothing(Request.Form(key)) Then
            r = Request.Form(key).ToString()
        End If
        Dim old_r = r

        If r <> "" Then
            If key.ToLower = "sqlfilter" Then
                r = r.Replace("--", "").Replace("+", "").Replace(";", "").Replace("<", "").Replace(">", "")
            Else
                r = r.Replace(" Then ", "").Replace("'", "").Replace("--", "").Replace("+", "").Replace(";", "").Replace("""", "").Replace("<", "").Replace(">", "")
                If r <> old_r Then
                    writeLog(key & "from :" & Request.QueryString(key) & "to :" & r)
                End If
            End If
        End If

        Return r
    End Function
    Public Function IsGoogleCaptchaValid() As Boolean
        Dim appSettings As NameValueCollection = ConfigurationManager.AppSettings
        'dynamic account
        Dim secret = appSettings.Item("reCAPTCHAsecret")
        Try
            Dim recaptchaResponse As String = Request.Form("g-recaptcha-response")
            If Not String.IsNullOrEmpty(recaptchaResponse) Then
                Dim url = "https://www.google.com/recaptcha/api/siteverify?secret=" & secret & "&response=" + recaptchaResponse
                Dim request As Net.WebRequest = Net.WebRequest.Create(url)
                writeLog(url)

                request.Method = "POST"
                request.ContentType = "application/json; charset=utf-8"
                Dim postData As String = ""

                'get a reference to the request-stream, and write the postData to it
                Using s As IO.Stream = request.GetRequestStream()
                    Using sw As New IO.StreamWriter(s)
                        sw.Write(postData)
                    End Using
                End Using

                ''get response-stream, and use a streamReader to read the content
                Using s As IO.Stream = request.GetResponse().GetResponseStream()
                    Using sr As New IO.StreamReader(s)
                        'decode jsonData with javascript serializer
                        Dim jsonData = sr.ReadToEnd()
                        If jsonData.IndexOf("""success"": true") > 0 Then
                            Return True
                        End If
                    End Using
                End Using
            End If
        Catch ex As Exception
            errorCaptcha = "Your Server is unable to connect Internet | " + ex.Message.ToString
            'Dont show the error
        End Try
        Return False
    End Function
    Function writeXMLFromRequestForm(root As String, Optional fieldattachment As List(Of String) = Nothing, Optional randGUID As String = "", Optional code As String = "") As String
        Dim info = "<" & root & ">#element#</" & root & ">"
        Dim theDate As DateTime = DateTime.Now
        Dim szFilename = Year(theDate) & "/" & Month(theDate)

        For x = 0 To Request.Form.Count - 1
            Dim colName As String = Request.Form.Keys(x)
            'Dim ix As Integer

            'for Radio Button
            'ix = colName.ToLower().IndexOf("_radio")
            'If ix > 0 Then colName = Left(colName, ix)

            If Not fieldattachment Is Nothing AndAlso fieldattachment.Contains(Request.Form.Keys(x)) Then
                info = info.Replace("#element#", "<field id=""" & colName & """><value>" & code & "_" & colName & "/" & szFilename & "/" & randGUID & "_" & Trim(Request.Form(x).Split(",")(0)).Replace("NULL", "").Replace("&", "&amp;") & "</value></field>#element#")
            Else
                Dim reqForm As String = IIf(Request.Form(x) = "NULL", "", Request.Form(x).Replace("'", "&#39;").Replace("&", "&amp;"))
                If reqForm.Length > 0 AndAlso reqForm.ToString.Substring(0, 1) = "," Then reqForm = reqForm.ToString.Substring(1, reqForm.Length - 1)
                info = info.Replace("#element#", "<field id=""" & colName & """><value>" & IIf(reqForm = "NULL", "", reqForm) & "</value></field>#element#")
                'info = info.Replace("#element#", "<field id=""" & colName & """><value>" & Request.Form(x).Replace("'", "&#39;").Replace("NULL", "").Replace("&", "&amp;") & "</value></field>#element#")
            End If
        Next
        info = info.Replace("#element#", "")

        Return info

    End Function
    Function populateSaveXML(ByVal vp As Long, ByVal Tablename As String, Optional ispreview As String = "", Optional fieldattachment As List(Of String) = Nothing, Optional ByVal randGUID As String = "") As String
        loadAccount()
        Dim DBCore = contentOfsqDB
        Dim curHostGUID = Session("hostGUID")
        Dim curUserGUID = Session("userGUID")


        Dim mainguid = getQueryVar("cfunctionlist")

        'Tablename = Left(Tablename, 1) & "o" & Mid(Tablename, 3, Len(Tablename) - 2)
        Dim saveXML = writeXMLFromRequestForm("sqroot", fieldattachment, randGUID, Tablename)
        saveXML = saveXML.Replace("&amp;lt;", "&lt;").Replace("&amp;gt;", "&gt;").Replace("&amp;#39;", "&#39;")
        Dim contentofSaveString As String = ""
        'Dim hostGUID As String

        If mainguid = "" Or Request.Form("gen_newid") = "1" Then
            'contentofSaveString = " exec api.[save] '" & Session("HostGUID").ToString & "', '" & Tablename & "', null, '" & saveXML & "'"
            contentofSaveString = "exec api.[save] '" & curHostGUID & "', '" & Tablename & "', null, '" & saveXML & "'"
        Else
            If mainguid.IndexOf(",") > 0 Then
                'Stop
                'should be cannot save more than one row
                'contentofSaveString &= " exec oph." & Tablename & "_save '" & mainguid.Substring(0, mainguid.IndexOf(",")) & "', '" & Session("HostGUID").ToString & "', '" & saveXML & "'"
                'mainguid = mainguid.Substring(mainguid.IndexOf(",") + 1, mainguid.Length - (mainguid.IndexOf(",") + 1))
            Else
                'contentofSaveString &= " exec api.[save] '" & Session("HostGUID").ToString & "', '" & Tablename & "', '" & mainguid & "', '" & saveXML & "'"
                Dim unique = ", @unique='" & Request.Form("unique") & "'"
                contentofSaveString &= " exec api.[save] '" & curHostGUID & "', @code='" & Tablename & "', @GUID='" & mainguid & "', @saveXML='" & saveXML & "'" & unique.ToString()
            End If
        End If

        Return contentofSaveString

    End Function

#End Region
#Region "Authorization"
    Public Function ValidAccess(ByVal tablename As String, ByVal access As String, Optional ByVal isStrict As Boolean = True) As Long
        Dim sqlstr As String, r As String
        If UCase(tablename) = UCase("CaUPLD") Then
            ValidAccess = 1
        Else
            Try
                tablename = Left(tablename, 1) & "a" & Right(tablename, Len(tablename) - 2)
                sqlstr = "exec dbo.CaUGRPMODL_verifyAuth '" & tablename & "','" & Session("HostGUID") & "','" & access & "'"
                r = runSQLwithResult(sqlstr)
                If r = "1" Then
                    ValidAccess = 1
                ElseIf r = "2" Then
                    ValidAccess = 0
                    If isStrict Then
                        contentofError = "You are under delegation status. You may take over your account back by go to User Control and select to take over delegation or click <a href=""../../../modules/systemsetup/caUSER/caUSER_clearDelegation.aspx"">here</a>." & "<br>"
                    End If

                    'Response.Redirect("../../../OPH/welcome/menu/BACK.aspx")
                Else
                    ValidAccess = 0
                    If isStrict Then contentofError = "You are not authorized to access that page." & "<br>"
                    'Response.Redirect("../../../OPH/welcome/menu/BACK.aspx")
                End If
            Catch ex As Exception
                contentofError = ex.Message & "<br>"
                ValidAccess = 0
                'Response.Redirect("../../../OPH/welcome/menu/BACK.aspx")
            End Try
        End If

    End Function

    Function GetConnect(ByVal accountid As String, ByVal siteid As String, ByVal userid As String, Optional ByVal pwd As String = "", Optional ByVal bypasspwd As String = "", Optional connection As String = "") As Boolean
        Dim sqlstr As String
        sqlstr = "exec api.VerifyPassword '" & accountid & "', '" & userid & "', '" & pwd & "', " & IIf(bypasspwd = "", "", "1")

        Dim ds As DataSet = SelectSqlSrvRows(sqlstr)
        Dim isValid As Boolean = True
        If Not ds Is Nothing Then
            Try
                Session("AppTitle") = ds.Tables(0).Rows(0).Item("Description").ToString
                Session("HostGUID") = ds.Tables(0).Rows(0).Item("HostGUID").ToString
                setCookie("hostGUID", ds.Tables(0).Rows(0).Item("HostGUID").ToString, 1)

                Session("SiteGUID") = ds.Tables(0).Rows(0).Item("siteGUID").ToString
                Session("UserGUID") = ds.Tables(0).Rows(0).Item("UserGUID").ToString
                Session("OriginalUserGUID") = ds.Tables(0).Rows(0).Item("UserGUID").ToString
                Session("UserName") = ds.Tables(0).Rows(0).Item("UserName").ToString
                Session("OriginalUserName") = ds.Tables(0).Rows(0).Item("UserName").ToString
                Session("AccountId") = ds.Tables(0).Rows(0).Item("AccountId")
                Session("Folder") = ds.Tables(0).Rows(0).Item("Folder").ToString
                Session("DocumentFolder") = ds.Tables(0).Rows(0).Item("DocumentFolder").ToString
                Session("EngineFolder") = ds.Tables(0).Rows(0).Item("EngineFolder").ToString
                Session("ReportFolder") = ds.Tables(0).Rows(0).Item("ReportFolder").ToString
                Session("UploadFolder") = ds.Tables(0).Rows(0).Item("UploadFolder").ToString
                Session("SkinFolder") = ds.Tables(0).Rows(0).Item("SkinFolder").ToString
                Dim expDate As DateTime = ds.Tables(0).Rows(0).Item("expirypwd").ToString
                Session("isPwdExpired") = IIf(DateDiff("d", Today, expDate) <= 0, True, False)
                Dim delegateUserGUID = ds.Tables(0).Rows(0).Item("delegateUserGUID").ToString()

                If Session("SkinFolder") = "" Then Session("SkinFolder") = "lor-blue"


                Session("Charset") = ds.Tables(0).Rows(0).Item("Charset")
                Session("CodePage") = ds.Tables(0).Rows(0).Item("CodePage")
                Session("FirstPage") = ds.Tables(0).Rows(0).Item("FirstPage")
                Session("BackMenu") = "../../../OPH/welcome/menu/form.aspx"

                Session("DelegateUserGUID") = ""

                Dim MyCookie As New HttpCookie("OPH_UserId")
                MyCookie.Value = userid
                MyCookie.Expires = Now.AddMonths(1)
                Response.Cookies.Add(MyCookie)

                Dim MyCookie3 As New HttpCookie("OPH_UserGUID")
                MyCookie3.Value = ds.Tables(0).Rows(0).Item("UserGUID").ToString
                MyCookie3.Expires = Now.AddMonths(1)
                Response.Cookies.Add(MyCookie3)

                Dim MyCookie1 As New HttpCookie("OPH_AccountId")
                MyCookie1.Value = accountid
                MyCookie1.Expires = Now.AddMonths(1)
                Response.Cookies.Add(MyCookie1)

                Dim MyCookie4 As New HttpCookie("OPH_AccountGUID")
                MyCookie4.Value = ds.Tables(0).Rows(0).Item("AccountGUID").ToString
                MyCookie4.Expires = Now.AddMonths(1)
                Response.Cookies.Add(MyCookie4)

                Dim MyCookie2 As New HttpCookie("OPH_SiteId")
                MyCookie2.Value = siteid
                MyCookie2.Expires = Now.AddMonths(1)
                Response.Cookies.Add(MyCookie2)

                Dim MyCookie5 As New HttpCookie("OPH_delegateUserGUID")
                MyCookie5.Value = delegateUserGUID
                MyCookie5.Expires = Now.AddHours(1)
                Response.Cookies.Add(MyCookie5)

                Dim MyCookie6 As New HttpCookie("showForm")
                MyCookie6.Value = "1"
                MyCookie6.Expires = Now.AddHours(1)
                Response.Cookies.Add(MyCookie6)

                sqlstr = "update couser set verifyCode=null, verifyAction=null where userid='" & userid & "'"
                runSQL(sqlstr, connection)

            Catch ex As Exception
                isValid = False
            End Try
            ds.Dispose()
        Else
            isValid = False
        End If

        Return isValid

    End Function

#End Region
#Region "SQL Section"


    Function runSQL(ByVal sqlstr As String, Optional ByVal sqlconstr As String = "") As Boolean
        Dim r As Boolean

        Dim myConnectionString As String = sqlconstr
        If sqlconstr = "" Then myConnectionString = contentOfdbODBC

        If myConnectionString = "" And sqlconstr = "" Then
            r = False 'Return False
            'Exit Function
        End If

        Dim myConnection As New SqlConnection(myConnectionString)
        '        Dim myInsertQuery As String = "INSERT INTO Customers (CustomerID, CompanyName) Values('NWIND', 'Northwind Traders')"
        Dim myInsertQuery As String = sqlstr
        Dim myCommand As New SqlCommand(myInsertQuery)
        Try
            myCommand.Connection = myConnection
            myConnection.Open()
            myCommand.CommandTimeout = 600
            myCommand.ExecuteNonQuery()
        Catch ex As SqlException
            'Response.Write(ex.Message)
            contentofError = ex.Message & "<br>"
            'Return False
            r = False
        Catch ex As Exception
            'Response.Write(ex.Message)
            contentofError = ex.Message & "<br>"
            'Return False
            r = False
        Finally
            myCommand.Connection.Close()
            myConnection.Close()

        End Try
        'GC.Collect()
        Return r

    End Function
    Function runSQLwithResult(ByVal sqlstr As String, Optional ByVal sqlconstr As String = "") As String
        Dim result As String

        ' If the connection string is null, usse a default.
        Dim myConnectionString As String = sqlconstr
        If sqlconstr = "" Then myConnectionString = contentOfdbODBC
        If myConnectionString = "" And sqlconstr = "" Then
            'SignOff()
            Return ""
            Exit Function
        End If

        Dim myConnection As New SqlConnection(myConnectionString)
        Dim myInsertQuery As String = sqlstr
        Dim myCommand As New SqlCommand(myInsertQuery)
        Try


            Dim Reader As SqlClient.SqlDataReader

            myCommand.Connection = myConnection
            myConnection.Open()

            myCommand.CommandTimeout = 600
            Reader = myCommand.ExecuteReader()

            Reader.Read()
            If Reader.HasRows Then
                result = Reader.GetValue(0).ToString
            Else
                result = ""
            End If

        Catch ex As SqlException
            'Response.Write(ex.Message)
            contentofError = ex.Message & "<br>"
            Return ""
        Catch ex As Exception
            'Response.Write(ex.Message)
            contentofError = ex.Message & "<br>"
            Return ""
        Finally
            myCommand.Connection.Close()
            myConnection.Close()
        End Try
        'GC.Collect()
        Return result
    End Function
    Public Function getXML(ByVal sqlstr As String, Optional ByVal sqlconstr As String = "", Optional isXML As Boolean = 1) As String
        Dim result As String

        Dim myConnectionString As String
        ' If the connection string is null, usse a default.
        myConnectionString = contentOfdbODBC
        If myConnectionString = "" And sqlconstr = "" Then
            'SignOff()
            Return Nothing
            Exit Function
        End If


        If sqlconstr <> "" Then
            myConnectionString = sqlconstr
        End If

        Dim myConnection As New SqlConnection(myConnectionString)
        Dim myInsertQuery As String = sqlstr

        Dim myCommand As New SqlCommand(myInsertQuery)
        Try
            'Dim Reader As SqlClient.SqlDataReader
            myCommand.Connection = myConnection
            myConnection.Open()
            myCommand.CommandTimeout = 600
            Dim r As XmlReader = myCommand.ExecuteXmlReader()

            'Reader = myCommand.ExecuteReader()

            'Reader.Read()
            r.Read()
            'Dim RegularExp = "[^\x09\x0A\x0D\x20-\xD7FF\xE000-\xFFFD\x10000-x10FFFF]"
            'Return Regex.Replace(StrInput, RegularExp, String.Empty)
            'result = Regex.Replace(r.ReadOuterXml(), "[^\x08\x09\x0A\x0D\x20-\xD7FF\xE000-\xFFFD\x10000-x10FFFF]", "")
            If isXML Then
                result = r.ReadOuterXml()
            Else
                result = r.Value
            End If

            'If Reader.HasRows Then
            'result = Reader.Item(0)
            'Else
            'result = Nothing
            'End If

        Catch ex As SqlException
            'Response.Write(ex.Message)
            contentofError = ex.Message & "<br>"
            Return Nothing
        Catch ex As Exception
            'Response.Write(ex.Message)
            contentofError = ex.Message & "<br>"
            Return Nothing
        Finally
            myCommand.Connection.Close()
            myConnection.Close()
        End Try
        'GC.Collect()
        Return result

    End Function
    Public Function SelectSqlSrvRows(ByVal query As String, ByVal Optional sqlconstr As String = "") As DataSet

        Dim myConnectionString As String = sqlconstr
        If sqlconstr = "" Then myConnectionString = contentOfdbODBC

        Dim conn As New SqlConnection(myConnectionString)
        Dim adapter As New SqlDataAdapter
        Dim dataSet As New DataSet
        Try
            adapter.SelectCommand = New SqlCommand(query, conn)
            adapter.SelectCommand.CommandTimeout = 0
            adapter.Fill(dataSet)

        Catch ex As SqlException
            contentofError = query & ex.Message & "<br>"
        Catch ex As Exception
            contentofError = query & ex.Message & "<br>"
        Finally
            conn.Close()

        End Try
        adapter = Nothing
        'GC.Collect()
        Return dataSet

    End Function
    Sub loadAccount(Optional env As String = "", Optional code As String = "", Optional GUID As String = "")

        'prepare curHostGUID, curUserGUID
        Dim hGUID = IIf(IsNothing(Response.Cookies("guestID").Value), Session("hostGUID"), Response.Cookies("guestID").Value)
        If hGUID = "" Then hGUID = "null" Else hGUID = "'" & hGUID & "'"
        Dim appSettings As NameValueCollection = ConfigurationManager.AppSettings
        'dynamic account
        contentOfsequoiaCon = appSettings.Item("sequoia")
        Session("sequoia") = contentOfsequoiaCon

        Dim x = Request.Url.Authority & Request.ApplicationPath
        If x.Substring(Len(x) - 1, 1) = "/" Then x = x.Substring(0, Len(x) - 1)

        Dim autouserloginid = Request.ServerVariables(5)
        If env = "" Then env = "" Else env = ", @env='" & env & "'"
        If code = "" Then code = "" Else code = ", @code='" & code & "'"
        If GUID = "undefined" Then GUID = ""
        If GUID = "" Then GUID = "" Else GUID = ", @GUID='" & GUID & "'"

        Dim sqlstr = "exec core.loadAccount " & hGUID & ", '" & x & "'" & env & code & GUID & IIf(autouserloginid <> "", ", @userid='" & autouserloginid & "'", "")
        'Dim sqlstr = "exec core.loadAccount " & hGUID & ", '" & x & "', " & env & ", " & code & ""
        writeLog("loadaccount: " & sqlstr)
        'writeLog(contentOfsequoiaCon)
        Dim r1 As DataSet = SelectSqlSrvRows(sqlstr, contentOfsequoiaCon)
        If r1.Tables.Count > 0 AndAlso r1.Tables(0).Rows.Count > 0 Then
            contentOfaccountId = r1.Tables(0).Rows(0).Item(0).ToString
            contentOfsqDB = r1.Tables(0).Rows(0).Item(1).ToString


            contentOfdbODBC = r1.Tables(0).Rows(0).Item(2).ToString
            contentOfthemeFolder = r1.Tables(0).Rows(0).Item(3).ToString
            contentOfthemePage = r1.Tables(0).Rows(0).Item(4).ToString
            contentOfEnv = r1.Tables(0).Rows(0).Item(5).ToString
            contentOfCode = r1.Tables(0).Rows(0).Item(6).ToString

            contentofNeedLogin = r1.Tables(0).Rows(0).Item(9).ToString
            contentofsignInPage = r1.Tables(0).Rows(0).Item(10).ToString
            contentofwhiteAddress = r1.Tables(0).Rows(0).Item(11)
            'contentofOfflineCode = r1.Tables(0).Rows(0).Item(13)

            Session("hostGUID") = r1.Tables(0).Rows(0).Item(7).ToString
            Session("userGUID") = r1.Tables(0).Rows(0).Item(8).ToString

            setCookie("isWhiteAddress", IIf(contentofwhiteAddress, 1, 0), 1)
            setCookie("skinColor", r1.Tables(0).Rows(0).Item(12).ToString, 1)
            contentOfGUID = r1.Tables(0).Rows(0).Item(13).ToString
        End If

    End Sub
    Sub getAccount(Optional hostGUID As String = "", Optional env As String = "", Optional code As String = "", Optional GUID As String = "")

        'prepare curHostGUID, curUserGUID
        Dim hGUID = hostGUID 'IIf(IsNothing(Response.Cookies("guestID").Value), Session("hostGUID"), Response.Cookies("guestID").Value)
        If hGUID = "" Then hGUID = "null" Else hGUID = "'" & hGUID & "'"

        Dim autouserloginid = Request.ServerVariables(5)
        Dim appSettings As NameValueCollection = ConfigurationManager.AppSettings
        'dynamic account
        contentOfsequoiaCon = appSettings.Item("sequoia")
        Session("sequoia") = contentOfsequoiaCon

        Dim x = Request.Url.Authority & Request.ApplicationPath
        If x.Substring(Len(x) - 1, 1) = "/" Then x = x.Substring(0, Len(x) - 1)

        If env = "" Then env = "" Else env = ", @env='" & env & "'"
        If code = "" Then code = "" Else code = ", @code='" & code & "'"
        If GUID = "" Then GUID = "" Else GUID = ", @GUID='" & GUID & "'"

        Dim sqlstr = "exec core.loadAccount " & hGUID & ", '" & x & "'" & env & code & GUID & IIf(autouserloginid <> "", ", @userid='" & autouserloginid & "'", "")
		writeLog("getaccount: " & sqlstr)
        Dim r1 As DataSet = SelectSqlSrvRows(sqlstr, contentOfsequoiaCon)
        If r1.Tables.Count > 0 AndAlso r1.Tables(0).Rows.Count > 0 Then
            'contentOfaccountId = r1.Tables(0).Rows(0).Item(0).ToString
            'contentOfsqDB = r1.Tables(0).Rows(0).Item(1).ToString
            contentOfdbODBC = r1.Tables(0).Rows(0).Item(2).ToString
            contentOfthemeFolder = r1.Tables(0).Rows(0).Item(3).ToString
            contentOfthemePage = r1.Tables(0).Rows(0).Item(4).ToString
            contentOfEnv = r1.Tables(0).Rows(0).Item(5).ToString
            contentOfCode = r1.Tables(0).Rows(0).Item(6).ToString
            contentofNeedLogin = r1.Tables(0).Rows(0).Item(9).ToString
            contentofsignInPage = r1.Tables(0).Rows(0).Item(10).ToString
            contentofwhiteAddress = r1.Tables(0).Rows(0).Item(11)
            Session("hostGUID") = r1.Tables(0).Rows(0).Item(7).ToString
            setCookie("isWhiteAddress", IIf(contentofwhiteAddress, 1, 0), 1)
            setCookie("skinColor", r1.Tables(0).Rows(0).Item(12).ToString, 1)
            contentOfGUID = r1.Tables(0).Rows(0).Item(13).ToString
        End If

    End Sub

#End Region

    'Private Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Init
    '    'Me.BodyOnLoad = "moveSpan(document.all.BodyTopSpan, document.all.BodyTop);" & vbCrLf
    '    'Me.BodyOnLoad = "moveSpan(document.all.BodyLeftSpan, document.all.BodyLeft);" & vbCrLf
    '    'Me.BodyOnLoad = "moveSpan(document.all.BodyBottomSpan, document.all.BodyBottom);" & vbCrLf
    '    'Me.BodyOnLoad = "moveSpan(document.all.BodyMainSpan, document.all.BodyMain);" & vbCrLf
    'End Sub
    Private Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.PreRender
        'If contentofError.Replace("<br>", "") <> "" Then
        '    AddTaskMenu("Messages", "", True)
        '    AddTaskMenu(contentofError, "", False)
        '    'headScript = "alert('" & contentofError.Replace("<br>", "") & "');"
        'End If

    End Sub
End Class
