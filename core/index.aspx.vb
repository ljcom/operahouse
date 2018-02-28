'Imports System.IO

Partial Class index
    'Inherits System.Web.UI.Page
    Inherits cl_base

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim curHostGUID, code, env, themeFolder, pageURL, needLogin, loginPage As String
        Dim old = False
        If old Then
            getAccount(Session("hostGUID"), getQueryVar("env"), getQueryVar("code"))
            curHostGUID = Session("hostGUID")
            code = contentOfCode
            env = contentOfEnv
            themeFolder = contentOfthemeFolder
            pageURL = contentOfthemePage
            needLogin = contentofNeedLogin
            loginPage = contentofsignInPage

        Else
            Dim HostGUID As String = Session("hostGUID")
            'Dim account As String, url As String = Request.Url.OriginalString.Replace(Request.Url.PathAndQuery, "") & "/ophcore/api/default.aspx?mode=account&code=" & getQueryVar("code") & "&env=" & getQueryVar("env") & "&hostGUID=" & HostGUID
            Dim account As String, url As String = Request.Url.OriginalString.Replace(Request.Url.PathAndQuery, "") & Request.ApplicationPath
            If url.Substring(Len(url) - 1, 1) = "/" Then url = url.Substring(0, Len(url) - 1)
            url = url & "/ophcore/api/default.aspx?mode=account&code=" & getQueryVar("code") & "&env=" & getQueryVar("env") & "&hostGUID=" & HostGUID

            Using WC As New System.Net.WebClient()
                account = WC.DownloadString(url)
            End Using
            Dim x = XDocument.Parse(account)

            curHostGUID = x.<sqroot>.<hostGUID>.Value    'Session("hostGUID")
            code = x.<sqroot>.<code>.Value 'contentOfCode
            env = x.<sqroot>.<env>.Value 'contentOfEnv
            themeFolder = x.<sqroot>.<themeFolder>.Value 'contentOfthemeFolder
            pageURL = x.<sqroot>.<themePage>.Value 'contentOfthemePage
            needLogin = x.<sqroot>.<needLogin>.Value 'contentofNeedLogin
            loginPage = x.<sqroot>.<signInPage>.Value 'contentofsignInPage
            Session("hostGUID") = curHostGUID
        End If

        If code = "" Then
            reloadURL("index.aspx?code=404&env=")
        ElseIf getQueryVar("code") = "" Or getQueryVar("code").ToLower() <> code.ToLower() Or getQueryVar("env").ToLower() <> env.ToLower() Then

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
            setCookie("lastPar", Request.Url.PathAndQuery, 1)
            Session("lastPar") = Request.Url.PathAndQuery
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
        If cartID = "" Then
            'Response.Cookies("cartID").Value = runSQLwithResult("exec api.createNewid")
            Dim appSet As NameValueCollection = ConfigurationManager.AppSettings
            'dynamic account
            Dim getseqcon = appSet.Item("sequoia")
            Dim newid As String

            newid = runSQLwithResult("exec api.createNewid", getseqcon)
            setCookie("cartID", newid, 7)
        Else
            'Response.Cookies("cartID").Value = Request.Cookies("cartID").Value
        End If

        Dim GUID = "" 'getQueryVar("GUID") 
        WindowOnLoad = "initTheme('" & code & "', '" & GUID & "', '" & curHostGUID & "');"
        Response.Cookies("themeFolder").Value = themeFolder
        loadManifest(themeFolder)
        Response.Cookies("page").Value = pageURL

    End Sub
End Class
