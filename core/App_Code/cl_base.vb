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
    'Protected session("ODBC") As String
    'Protected contentOfsqDB As String
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
    Protected contentofMultiAccount As String = "0"
    Protected contentofCartID As String = ""
    Protected contentofSuba As String = ""
	protected contentofExpired as string = ""

#Region "Properties Section"

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
    Sub reloadURL(url As String, Optional ispost As Boolean = True)
        Response.Clear()
        Dim newURL = url.Substring(InStr(url, "?"))

        Dim par = newURL.Split("&")
        Dim env As String = "", code As String = "", guid As String = "", otherpars As String = ""
        If par.Count > 0 Then
            For Each p In par
                If p.Split("=").Length > 1 Then
                    If p <> "" AndAlso p.Split("=")(1) <> "" Then

                        If p.Split("=")(0).ToLower = "env" Then
                            env = p.Split("=")(1)
                        ElseIf p.Split("=")(0).ToLower = "code" Then
                            code = p.Split("=")(1)
                        ElseIf p.Split("=")(0).ToLower = "guid" Then
                            guid = p.Split("=")(1)
                        ElseIf p.Split("=")(0).ToLower = "no" Then
                            'guid = p.Split("=")(1)
                        ElseIf p.Split("=")(0).ToLower = "refno" Then
                            'guid = p.Split("=")(1)
                        ElseIf p.Split("=")(0).ToLower = "id" Then
                            'guid = p.Split("=")(1)

                        Else
                            otherpars &= p.Split("=")(0) & "=" & p.Split("=")(1) & "&"
                        End If
                    End If
                End If
            Next
        End If
        'rewrite
        'newURL = "index.aspx" & IIf(env <> "", env & "/", "") & IIf(code <> "", code & "/", "") & IIf(guid <> "", guid & "/", "") & otherpars
        newURL = "index.aspx?" & IIf(env <> "", "env=" & env & "&", "") & IIf(code <> "", "code=" & code & "&", "") & otherpars '& IIf(guid <> "", "guid=" & guid & "&", "") & otherpars
        newURL = IIf(Right(newURL, 2) = "/?", Replace(newURL, "/?", ""), newURL)
        newURL = IIf(Right(newURL, 1) = "&", newURL.Substring(0, Len(newURL) - 1), newURL)

        Dim sb As StringBuilder = New StringBuilder()
        sb.Append("<html>")
        sb.AppendFormat("<body onload='document.forms[""form""].submit()'>")
        sb.AppendFormat("<form name='form' action='{0}' method='post'>", newURL)
        sb.AppendFormat("<input type='hidden' name='guid' value='{0}'>", guid)
        'For Each t In otherpars.Split("&")
        'If t <> "" Then
        'sb.AppendFormat("<input type='hidden' name='{0}' value='{1}'>", t.Split("=")(0), t.Split("=")(1))
        'End If
        'Next

        If ispost Then
            sb.Append("</form>")
            sb.Append("</body>")
            sb.Append("</html>")

            Response.Write(sb.ToString())

            Response.End()
        Else
            newURL = "index.aspx?" & IIf(env <> "", "env=" & env & "&", "") & IIf(code <> "", "code=" & code & "&", "") & IIf(guid <> "", "guid=" & guid & "&", "") & otherpars
            newURL = IIf(Right(newURL, 2) = "/?", Replace(newURL, "/?", ""), newURL)
            newURL = IIf(Right(newURL, 1) = "&", newURL.Substring(0, Len(newURL) - 1), newURL)

            Response.Redirect(newURL)
        End If

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

                Dim async = ""
                For Each jsFile In doc.SelectNodes("//jsFile")
                    'jsFile.InnerText = (jsFile.InnerText)
                    'contentOfScripts = jsFile.InnerText
                    'str &= "<script type=""text/javascript"" src=""" & jsFile.InnerText.Replace("OPHContent/cdn", cdnLocation) & "?unique=" & Format(lastMod, "yyyyMMddhhmmss") & """></script>" & vbCrLf
                    If jsFile.OuterXml.IndexOf("async=""true""") > 0 Then async = "async"

                    str &= "<script " & async & "type=""text/javascript"" src=""" & jsFile.InnerText.Replace("OPHContent/cdn", cdnLocation) & """></script>" & vbCrLf
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

    Sub setCookie(cookieName As String, cookieValue As String, cookieDay As Long, Optional cookieHour As Long = 0, Optional cookieMin As Long = 0)
        'response.Cookies(cookiename)
        If Response.Cookies(cookieName) Is Nothing Then
            Dim MyCookie As New HttpCookie(cookieName)
            MyCookie.Value = cookieValue
            MyCookie.Expires = Now.AddDays(cookieDay).AddHours(cookieHour)
            Response.Cookies.Add(MyCookie)
        Else
            Response.Cookies(cookieName).Value = cookieValue
        End If
    End Sub
    Function getCookie(cookieName As String) As String
        Return Response.Cookies(cookieName).Value
    End Function
    Sub writeLog(logMessage As String) ', ByVal Optional accountName As String = "")
        'Dim w As TextWriter
        Dim accountName = ""
        If contentOfaccountId <> "" Or IsNothing(contentOfaccountId) Then
            accountName = Session("baseAccount")
            'accountName = getCookie(accountName & "_accountid")
        End If
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
                    w.WriteLine("{0} {1} {2}: " + vbCrLf + "{3}", DateTime.Now.ToLongTimeString(), DateTime.Now.ToLongDateString(), GetIPAddress(), logMessage)
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
        If Not File.Exists(path & saveFile) Then
            Try
                Using w As StreamWriter = File.AppendText(path & saveFile)
                    w.Write(content)
                End Using

            Catch ex As Exception
                Debug.Write(ex.Message.ToString)
            End Try
        End If

    End Sub

    Function getQueryVar(key As String) As String
        Dim r = ""

        'replace this:' " ( ) ; , | < > - \ & $ @
        '+ dipakai untuk search
        If Not IsNothing(Request.QueryString(key)) Then
            r = Request.QueryString(key).ToString()
        ElseIf Not IsNothing(Request.Form(key)) Then
            r = Request.Form(key).ToString()
        End If
        Dim old_r = r

        If r <> "" Then
            If key.ToLower = "sqlfilter" Then
                r = r.Replace("--", "").Replace("+", "").Replace(";", "").Replace("<", "").Replace(">", "")
            ElseIf key.ToLower = "bsearchtext" Or key.ToLower = "search" Or key.ToLower = "q" Then
                r = r.Replace("--", "").Replace(";", "").Replace("<", "").Replace(">", "")
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
        'Dim secret = appSettings.Item("reCAPTCHAsecret")
        Dim secret = runSQLwithResult("select infovalue from acctinfo where infokey='recaptchasecret'")

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
        'loadAccount()
        Dim DBCore = Session("sqDB")    'contentOfsqDB
        Dim curHostGUID = getSession()  'Session("hostGUID")
        Dim curUserGUID = Session("userGUID")


        Dim mainguid = getQueryVar("cfunctionlist")

        'Tablename = Left(Tablename, 1) & "o" & Mid(Tablename, 3, Len(Tablename) - 2)
        Dim saveXML = writeXMLFromRequestForm("sqroot", fieldattachment, randGUID, Tablename)
        saveXML = saveXML.Replace("&amp;lt;", "&lt;").Replace("&amp;gt;", "&gt;").Replace("&amp;#39;", "&#39;").replace("%40","@").replace("%20"," ")
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


#End Region
#Region "SQL Section"


    Function runSQL(ByVal sqlstr As String, Optional ByVal sqlconstr As String = "") As Boolean
        Dim r As Boolean

        Dim myConnectionString As String = sqlconstr
        If sqlconstr = "" Then myConnectionString = Session("ODBC")

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
            writeLog(contentofError)
            'Return False
            r = False
        Catch ex As Exception
            'Response.Write(ex.Message)
            contentofError = ex.Message & "<br>"
            writeLog(contentofError)
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
        If sqlconstr = "" Then myConnectionString = Session("odbc") 'session("ODBC")
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
            writeLog(contentofError)
            Return ""
        Catch ex As Exception
            'Response.Write(ex.Message)
            contentofError = ex.Message & "<br>"
            writeLog(contentofError)
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
        myConnectionString = Session("ODBC")
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
            writeLog(contentofError)
            Return Nothing
        Catch ex As Exception
            'Response.Write(ex.Message)
            contentofError = ex.Message & "<br>"
            writeLog(contentofError)
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
        If sqlconstr = "" Then myConnectionString = Session("ODBC")

        Dim conn As New SqlConnection(myConnectionString)
        Dim adapter As New SqlDataAdapter
        Dim dataSet As New DataSet
        Try
            adapter.SelectCommand = New SqlCommand(query, conn)
            adapter.SelectCommand.CommandTimeout = 0
            adapter.Fill(dataSet)

        Catch ex As SqlException
            contentofError = query & ex.Message & "<br>"
            writeLog(contentofError)
        Catch ex As Exception
            contentofError = query & ex.Message & "<br>"
            writeLog(contentofError)
        Finally
            conn.Close()

        End Try
        adapter = Nothing
        'GC.Collect()
        Return dataSet

    End Function
    Function getSession() As String
        Dim hGUID As String = ""


        If getQueryVar("hostGUID") <> "" Then
            hGUID = getQueryVar("hostGUID")
        Else
            Dim urlAddress = Request.Url.Authority & Request.ApplicationPath
            If urlAddress.Substring(Len(urlAddress) - 1, 1) = "/" Then urlAddress = urlAddress.Substring(0, Len(urlAddress) - 1)

            Dim base = Session(urlAddress.Replace("/", "_"))
            'If base = "" Then base = getCookie(urlAddress.Replace("/", "_"))
            If base <> "" Then
                hGUID = Session(base & "_hostGUID")
            Else
                hGUID = IIf(IsNothing(Response.Cookies("guestID").Value), Session("hostGUID"), Response.Cookies("guestID").Value)
            End If
        End If
        Return hGUID
    End Function
    Function loadAccount(Optional env As String = "", Optional code As String = "",
                         Optional GUID As String = "", Optional no As String = "", Optional refno As String = "", Optional id As String = "",
                         Optional suba As String = "") As String
        Dim loadStr = ""
        If GUID = "undefined" Then GUID = ""

        Dim hguid = getSession()

        If hguid = "" Then hguid = "null" Else hguid = "'" & hguid & "'"
        Dim appSettings As NameValueCollection = ConfigurationManager.AppSettings
        'dynamic account
        contentOfsequoiaCon = appSettings.Item("sequoia")
        Session("sequoia") = contentOfsequoiaCon

        Dim urlAddress = Request.Url.Authority & Request.ApplicationPath
        If urlAddress.Substring(Len(urlAddress) - 1, 1) = "/" Then urlAddress = urlAddress.Substring(0, Len(urlAddress) - 1)

        Dim autouserloginid = Request.ServerVariables(5)
        If env = "" Then env = "" Else env = ", @env='" & env & "'"
        If code = "" Then code = "" Else code = ", @code='" & code & "'"
        If GUID = "" Then GUID = "" Else GUID = ", @GUID='" & GUID & "'"
        If no = "" Then no = "" Else no = ", @no='" & no & "'"
        If refno = "" Then refno = "" Else refno = ", @refno='" & refno & "'"
        If id = "" Then id = "" Else id = ", @id='" & id & "'"
        If suba = "" Then suba = "" Else suba = ", @suba='" & suba & "'"

        Dim sqlstr = "exec api.loadAccount " & hguid & ", '" & urlAddress & "'" & env & code & GUID & no & refno & id & IIf(autouserloginid <> "", ", @userid='" & autouserloginid & "'", "") & suba
        'Dim sqlstr = "exec api.loadAccount " & hGUID & ", '" & urlAddress & "', " & env & ", " & code & ""
        writeLog("loadaccount: " & sqlstr)
        'writeLog(contentOfsequoiaCon)
        Dim r1 As DataSet = SelectSqlSrvRows(sqlstr, contentOfsequoiaCon)
        If r1.Tables.Count > 0 AndAlso r1.Tables(0).Rows.Count > 0 Then
            contentOfaccountId = r1.Tables(0).Rows(0).Item(0).ToString
            Session(urlAddress.Replace("/", "_")) = contentOfaccountId
            setCookie(urlAddress.Replace("/", "_"), contentOfaccountId, 1)
            setCookie("baseAccount", contentOfaccountId, 1)
            Session("baseAccount") = contentOfaccountId
            'contentOfsqDB = 
            Session("sqDB") = r1.Tables(0).Rows(0).Item(1).ToString

            'session("ODBC") = 
            Session("ODBC") = r1.Tables(0).Rows(0).Item(2).ToString
            'Session("odbc") = session("ODBC")
            contentOfthemeFolder = r1.Tables(0).Rows(0).Item(3).ToString
            'Session("themeFolder") = contentOfthemeFolder
            contentOfthemePage = r1.Tables(0).Rows(0).Item(4).ToString
            'Session("themePage") = contentOfthemePage
            contentOfEnv = r1.Tables(0).Rows(0).Item(5).ToString
            contentOfCode = r1.Tables(0).Rows(0).Item(6).ToString
            'Session("code") = r1.Tables(0).Rows(0).Item(6).ToString

            contentofNeedLogin = r1.Tables(0).Rows(0).Item(9).ToString
            contentofsignInPage = r1.Tables(0).Rows(0).Item(10).ToString
            contentofwhiteAddress = r1.Tables(0).Rows(0).Item(11)
            'contentofOfflineCode = r1.Tables(0).Rows(0).Item(13)

            Session(contentOfaccountId & "_hostGUID") = r1.Tables(0).Rows(0).Item(7).ToString
            setCookie(contentOfaccountId & "_hostGUID", Session("hostGUID"), 1)
            Session("userGUID") = r1.Tables(0).Rows(0).Item(8).ToString

            setCookie("isWhiteAddress", IIf(contentofwhiteAddress, 1, 0), 1)
            setCookie("skinColor", r1.Tables(0).Rows(0).Item(12).ToString, 1)
            contentOfGUID = r1.Tables(0).Rows(0).Item(13).ToString
            contentofMultiAccount = r1.Tables(0).Rows(0).Item(15).ToString
            contentofCartID = r1.Tables(0).Rows(0).Item(16).ToString
            contentofSuba = r1.Tables(0).Rows(0).Item(17).ToString
            contentofExpired = r1.Tables(0).Rows(0).Item(18).ToString

            setCookie(contentOfaccountId & "_multiAccount", contentofMultiAccount, 365)
            If contentofMultiAccount = "0" Then
                setCookie(contentOfaccountId + "_accountid", contentOfaccountId, 365)
            End If

            loadStr = contentOfCode & ";" & contentOfthemeFolder & ";" & contentOfthemePage & ";" & contentofNeedLogin & ";" & contentofsignInPage 
            loadStr = loadStr & ";" & contentOfGUID & ";" & contentofwhiteAddress & ";" & contentofCartID & ";" & contentofSuba & ";" & contentofExpired

			Session(contentOfCode.ToLower() & GUID.ToLower()) = loadStr
            setCookie(contentOfCode.ToLower(), loadStr, 1)
        Else
            loadStr = ";;;;;;;;"
        End If

        'End If
        Return loadStr
    End Function

    Public Shared Function GetIPAddress() As String
        Dim context As System.Web.HttpContext = System.Web.HttpContext.Current
        Dim sIPAddress As String = context.Request.ServerVariables("HTTP_X_FORWARDED_FOR")
        If String.IsNullOrEmpty(sIPAddress) Then
            Return context.Request.ServerVariables("REMOTE_ADDR")
        Else
            Dim ipArray As String() = sIPAddress.Split(New [Char]() {","c})
            Return ipArray(0)
        End If
    End Function
#End Region

    'Private Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.PreRender

    'End Sub
End Class
