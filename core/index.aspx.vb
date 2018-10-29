'Imports System.IO

Partial Class index
    'Inherits System.Web.UI.Page
    Inherits cl_base
    Protected isOfflineMode As Boolean = False
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        'offline
        If getQueryVar("offline") = "1" Then
            setCookie("offline", "1", 1)
            isOfflineMode = True
        ElseIf getQueryVar("offline") = "0" Then
            setCookie("offline", "0", 1)
        End If

        If Not IsNothing(Request.Cookies("offline")) Then
            isOfflineMode = Request.Cookies("offline").Value = "1"
        End If

        Dim curHostGUID, code, env, themeFolder, pageURL As String
        Dim needLogin As Boolean = False
        Dim loginPage As String

        Dim old = False
        If old Then
            loadAccount(getQueryVar("env"), getQueryVar("code"))
            curHostGUID = Session("hostGUID")
            code = contentOfCode
            env = contentOfEnv
            themeFolder = contentOfthemeFolder
            pageURL = contentOfthemePage
            needLogin = contentofNeedLogin
            loginPage = contentofsignInPage

        Else
            Dim account As String = "", url As String = Request.Url.OriginalString.Replace(Request.Url.PathAndQuery, "") & Request.ApplicationPath
            If url.Substring(Len(url) - 1, 1) = "/" Then url = url.Substring(0, Len(url) - 1)
            Dim HostGUID As String = MyBase.Session("hostGUID")
            url = url & "/ophcore/api/default.aspx?mode=account&code=" & getQueryVar("code") & "&env=" & getQueryVar("env") & "&hostGUID=" & HostGUID
            'writeLog(url)
            Using WC As New System.Net.WebClient()
                If Request.ServerVariables(5) <> "" Then WC.UseDefaultCredentials = True
                Try
                    account = WC.DownloadString(url)
                    Dim x = XDocument.Parse(account)

                    curHostGUID = x.<sqroot>.<hostGUID>.Value    'Session("hostGUID")
                    code = x.<sqroot>.<code>.Value 'contentOfCode
                    env = x.<sqroot>.<env>.Value 'contentOfEnv
                    themeFolder = x.<sqroot>.<themeFolder>.Value 'contentOfthemeFolder
                    pageURL = x.<sqroot>.<themePage>.Value 'contentOfthemePage
                    needLogin = x.<sqroot>.<needLogin>.Value 'contentofNeedLogin
                    loginPage = x.<sqroot>.<signInPage>.Value 'contentofsignInPage
                    Session("hostGUID") = curHostGUID

                Catch exc As Exception
                    Console.Write(exc.Message)
                    code = "404"
                End Try
            End Using


        End If

        If code = "" And getQueryVar("code") <> "404" Then
            reloadURL("index.aspx?code=404&env=")
        ElseIf (getQueryVar("code") = "") And getQueryVar("code") <> "404" Then

            Dim reloadStr = Request.RawUrl & IIf(InStr(Request.RawUrl, "?") = 0, "?", IIf(Right(Request.RawUrl, 1) = "&", "", "&"))

            If getQueryVar("env") = "" Then
                reloadStr &= "env=" & env & "&"
            Else
                reloadStr = reloadStr.replace(getQueryVar("env"), env)
            End If

            If getQueryVar("code") = "" Then
                reloadStr &= "code=" & code & "&"
            Else
                reloadStr = reloadStr.replace(getQueryVar("code"), code)
            End If
            reloadURL(reloadStr)
        ElseIf code <> "" And needLogin Then

            setCookie(Request.ApplicationPath.Replace("/", "") & "_lastPar", Request.Url.PathAndQuery, 1)
            'Session(Request.ApplicationPath & "_lastPar") = Request.Url.PathAndQuery
            reloadURL("index.aspx?env=" & "&code=" & loginPage)
        End If

        '--!
        Dim cartID = ""
        If Not Request.Cookies("cartID") Is Nothing Then
            cartID = Request.Cookies("cartID").Value
        Else
            setCookie("cartID", "", 0)
            'Response.Cookies("cartID").Value = ""
        End If

        Dim appSet As NameValueCollection = ConfigurationManager.AppSettings
        'dynamic account
        Dim cdnLocation = appSet.Item("cdnLocation")
        Dim getseqcon = appSet.Item("sequoia")

        If cartID = "" Then
            'Response.Cookies("cartID").Value = runSQLwithResult("exec api.createNewid")
            Dim newid As String

            newid = runSQLwithResult("exec api.createNewid", getseqcon) '//tidak boleh ada, taruh di atas, kalau masih dipakai
            setCookie("cartID", newid, 7)
        Else
            'Response.Cookies("cartID").Value = Request.Cookies("cartID").Value
        End If

        Dim GUID = "" 'getQueryVar("GUID") 
        WindowOnLoad = "initTheme('" & code & "', '" & GUID & "', '" & curHostGUID & "');"
        Response.Cookies("themeFolder").Value = themeFolder
        loadManifest(themeFolder, cdnLocation, isOfflineMode)
        setCookie("page", pageURL, "1")
        'Response.Cookies("page").Value = pageURL

    End Sub
End Class
