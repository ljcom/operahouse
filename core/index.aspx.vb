Imports System.IO

Partial Class index
    Inherits cl_base

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        loadAccount(getQueryVar("env"), getQueryVar("code"))

        Dim curODBC = contentOfdbODBC
        'Dim DBCore = getDBCore(accountid)
        Dim curHostGUID = Session("hostGUID")
        Dim curUserGUID = Session("userGUID")

        Dim code As String = contentOfCode
        Dim env As String = contentOfEnv
        Dim themeFolder = contentOfthemeFolder
        Dim pageURL As String = contentOfthemePage
        Dim needLogin = contentofNeedLogin
        Dim loginPage = contentofsignInPage

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
            setCookie("cartID", runSQLwithResult("exec api.createNewid"), 7)
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
