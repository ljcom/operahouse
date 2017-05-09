Imports System.IO

Partial Class index
    Inherits cl_base

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim sqlstr As String, pageURL As String = "", GUID As String = ""

        loadAccount()
        Dim curODBC = contentOfdbODBC
        'Dim DBCore = getDBCore(accountid)

        'check expired session
        sqlstr = "exec gen.verifyhost '" & Session("hostGUID") & "'"
        Dim hGUID = runSQLwithResult(sqlstr, curODBC)

        Dim reloadStr = Request.RawUrl & IIf(InStr(Request.RawUrl, "?") = 0, "?", IIf(Right(Request.RawUrl, 1) = "&", "", "&"))

        'check env if exists 
        Dim env As String = ""
        'If Not Session("env") Is Nothing Then env = Session("env")
        If Not Request.QueryString("env") Is Nothing Or env = "" Then
            env = Request.QueryString("env")
            sqlstr = "select modulegroupid from modg a where " & IIf(env = "", "isDefault=1", "modulegroupid='" & env & "'")
            env = runSQLwithResult(sqlstr, curODBC)
            Session("env") = env
        End If

        'frontpage
        Dim frontPage As String = ""
        sqlstr = "select e.infovalue from modg d inner join modginfo e on d.ModuleGroupGUID=e.envGUID where modulegroupid='" & env & "' and e.InfoKey='frontpage'"
        frontPage = runSQLwithResult(sqlstr, curODBC)
        If frontPage = "" Then frontPage = contentOffrontPage

        'signinpage
        Dim loginPage As String
        sqlstr = "select e.infovalue from modg d inner join modginfo e on d.ModuleGroupGUID=e.envGUID where modulegroupid='" & env & "' and e.InfoKey='signinPage'"
        loginPage = runSQLwithResult(sqlstr, curODBC)
        If loginPage = "" Then loginPage = contentOfsigninPage

        Dim code = IIf(Request.QueryString("code") = "", frontPage, Request.QueryString("code"))

        'check code and env, must be sync
        checkCodeEnv(code, env, curODBC)

        If Request.QueryString("code") = "" Or Request.QueryString("env") = "" Or Request.QueryString("code") <> code Or Request.QueryString("env") <> env Then
            If Request.QueryString("env") = "" Then
                reloadStr &= "env=" & env & "&"
            Else
                reloadStr = reloadStr.replace(Request.QueryString("env"), env)
            End If

            If Request.QueryString("code") = "" Then
                reloadStr &= "code=" & code & "&"
            Else
                reloadStr = reloadStr.replace(Request.QueryString("code"), code)
            End If
            reloadURL(reloadStr)
            'Stop
        End If

        If code <> "" Then
            'check needlogin
            sqlstr = "select needlogin from modl c where moduleid='" & code & "'"
            Dim needlogin = runSQLwithResult(sqlstr, curODBC)

            'not loginpage
            If Request.Url.PathAndQuery.IndexOf(loginPage) = -1 Then
                setCookie("lastPar", Request.Url.PathAndQuery, 1)
                Session("lastPar") = Request.Url.PathAndQuery
                'Response.Cookies("lastPar").Value = 
            End If

            If needlogin And Session("hostGUID") Is Nothing Then    'And userInfo = "" Then
                reloadURL("index.aspx?env=" & env & "&code=" & loginPage)
            End If


            sqlstr = "select pageurl from modl a inner join thmepage b on a.themepageguid=b.themepageguid where moduleid='" & code & "'"
            pageURL = runSQLwithResult(sqlstr, curODBC)
            If pageURL = "" Then
                contentofError = "This page not yet defined. Please ask your Administrator"
            End If
        Else

            reloadURL("index.aspx?code=404&env=" & env)
        End If

        '--!
        Dim cartID = ""
        If Not Request.Cookies("cartID") Is Nothing Then
            cartID = Request.Cookies("cartID").Value
        Else
            Response.Cookies("cartID").Value = ""
        End If
        If cartID = "" Then
            Response.Cookies("cartID").Value = runSQLwithResult("exec api.createNewid")
        Else
            Response.Cookies("cartID").Value = Request.Cookies("cartID").Value
        End If
        '-- !

        'themeFolder
        Dim themeFolder As String
        sqlstr = "select d.ThemeFolder from modg a inner join modginfo b on a.ModuleGroupGUID= b.EnvGUID and b.InfoKey = 'themeCode' inner join thme d on d.themecode=b.infovalue where a.modulegroupid='" & env & "'"
        themeFolder = runSQLwithResult(sqlstr, curODBC)
        If themeFolder = "" Then themeFolder = contentOfthemeFolder
        'Session("themeFolder") = themeFolder

        WindowOnLoad = "initTheme('" & code & "', '" & GUID & "');"
        Response.Cookies("themeFolder").Value = themeFolder
        Response.Cookies("page").Value = pageURL
        writeLog(Server.MapPath("~/"))
        writeLog(Server.MapPath("~/ophcontent/x"))
        writeLog(Server.MapPath("~/ophcontent/temp"))
        writeLog(Server.MapPath("~/ophcontent/live"))
        writeLog(Request.PhysicalApplicationPath)
        writeLog(Request.PhysicalPath)

    End Sub
    Sub checkCodeEnv(ByRef code As String, ByRef env As String, curODBC As String)
        Dim sqlstr = "select moduleid from modl c where moduleid='" & code & "'"
        code = runSQLwithResult(sqlstr, curODBC)
        If code <> "" Then
            'check env
            sqlstr = "select e.ModuleGroupID from modl a inner join modgmodl b on b.moduleGUID=a.moduleGUID inner join modg e on e.moduleGroupGUID=b.moduleGroupGUID where a.moduleid='" & code & "'"
            Dim e = runSQLwithResult(sqlstr, curODBC)
            If e = "" Then
                sqlstr = "select e.ModuleGroupID from modl a inner join modg e on e.AccountDBGUID=a.AccountDBGUID where a.moduleid='" & code & "'"
                Dim ex = runSQLwithResult(sqlstr, curODBC)
                If ex <> "" Then env = ex
            Else
                If e <> "" Then env = e
            End If
        End If
    End Sub
End Class
