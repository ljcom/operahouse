Partial Class index
    'Inherits System.Web.UI.Page
    Inherits cl_base
    Protected isOfflineMode As Boolean = False
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        Dim curHostGUID As String = "", code As String = "", themeFolder As String = "", pageURL As String = ""
        Dim GUID = getQueryVar("GUID")
        Dim no = getQueryVar("no")
        Dim refno = getQueryVar("refno")
        Dim id = getQueryVar("id")
        Dim hasGUID = True
        If (GUID Is Nothing Or GUID = "") Then
            If (no Is Nothing Or no = "") Then
                If (refno Is Nothing Or refno = "") Then
                    If (id Is Nothing Or id = "") Then
                        hasGUID = False
                    End If
                End If
            End If
        End If

        Dim needLogin As Boolean = False
        Dim loginPage As String = ""
        Dim suba As String = ""
        Dim isExpired As Boolean = False

        If curHostGUID = "" Or Session("ODBC") = "" Or Session("baseAccount") = "" Then loadAccount()

        Dim newaccount = Request.QueryString("accountid")
        If Session("suba") <> newaccount And Not newaccount Is Nothing Then
            contentOfaccountId = newaccount
            needLogin = True
            Session("suba") = newaccount
        Else
            contentOfaccountId = Session("suba")
        End If

        contentOfCode = getQueryVar("code")
        Dim loadStr = loadAccount(getQueryVar("env"), getQueryVar("code"),
                                  getQueryVar("GUID"), getQueryVar("no"), getQueryVar("refno"), getQueryVar("id"),
                                  contentOfaccountId)

        curHostGUID = getSession()

        Dim x = loadStr.Split(";")
        Try
            code = x(0)
            themeFolder = x(1)
            pageURL = x(2)
            If Not needLogin Then
                If x(3) <> "" Then needLogin = x(3) = "True"
            End If
            loginPage = x(4)
            GUID = x(5)
            'CartID = x(7)
            suba = x(8)
            isExpired = x(9) = "True"
        Catch exc As Exception
            Stop
        End Try

        Dim err As Boolean = False
        If code = "" Then 'And getQueryVar("code") <> "404" Then
            Response.Write("LoadAccount: code is empty")
            err = True
        ElseIf isExpired And (code <> "login" Or getQueryVar("mode") <> "5" Or getQueryVar("expired") <> "1") Then
            'Dim reloadStr = Request.RawUrl & IIf(InStr(Request.RawUrl, "?") = 0, "?", IIf(Right(Request.RawUrl, 1) = "&", "", "&"))
            Dim reloadStr = "index.aspx?code=" & code & "&mode=5&expired=1"
            writeLog(reloadStr)
            reloadURL(reloadStr)
        ElseIf isExpired = "False" And getQueryVar("expired") = "1" Then
            'Dim reloadStr = Request.RawUrl & IIf(InStr(Request.RawUrl, "?") = 0, "?", IIf(Right(Request.RawUrl, 1) = "&", "", "&"))
            Dim reloadStr = "index.aspx?code=" & code
            writeLog(reloadStr)
            reloadURL(reloadStr)
        ElseIf getQueryVar("guid") = "" And (no <> "" Or refno <> "" Or id <> "") And GUID <> "" Then
            Dim reloadStr = Request.RawUrl & IIf(InStr(Request.RawUrl, "?") = 0, "?", IIf(Right(Request.RawUrl, 1) = "&", "", "&"))
            reloadStr &= "guid=" & GUID
            setCookie("GUID", GUID, 0, 1)
            reloadURL(reloadStr)
        ElseIf (getQueryVar("code") = "") Then 'And getQueryVar("code") <> "404" Then

            Dim reloadStr = Request.RawUrl & IIf(InStr(Request.RawUrl, "?") = 0, "?", IIf(Right(Request.RawUrl, 1) = "&", "", "&"))

            If getQueryVar("code") = "" Then
                reloadStr &= "code=" & code & "&"
            Else
                reloadStr = reloadStr.replace(getQueryVar("code"), code)
            End If

            reloadURL(reloadStr)
        ElseIf code <> "" And needLogin And getQueryVar("code") <> loginPage Then
            reloadURL("index.aspx?code=" & loginPage)
        ElseIf GUID.ToLower <> getQueryVar("GUID").ToLower Then 'reload for onedataonly
            Dim url1 = "?"
            For Each u In Request.Url.Query.Replace("?", "").Split("&")
                If u.Split("=")(0) = "code" Then
                    url1 &= u.Split("=")(0) & "=" & code & "&"
                ElseIf u.Split("=")(0) = "guid" Then
                    If GUID <> "" Then
                        setCookie("GUID", GUID, 0, 1)   'set cookie
                        url1 &= u.Split("=")(0) & "=" & GUID & "&"
                    Else
                        setCookie("GUID", "", 0, 1) 'reset then guid is missing
                    End If
                Else
                    url1 &= u & "&"
                End If
            Next
            If url1.IndexOf("GUID=") < 0 Then url1 &= IIf(GUID <> "", "guid=" & GUID, "")   'jika guid nya kosong, harus dipasang
            'If Request.QueryString("guid") <> "" Then setCookie("GUID", getQueryVar("guid"), 0, 1)
            reloadURL(url1)


        ElseIf Request.QueryString("guid") <> "" Then  'change to post
            setCookie("GUID", getQueryVar("guid"), 0, 1)
            reloadURL(Request.Url.OriginalString)
        ElseIf Request.Form("guid") = "" Then   'no guid - browse mode
            setCookie("GUID", "", 0, 1)
        End If

        '--!
        'Dim cartID = ""
        'If Not Request.Cookies("cartID") Is Nothing Then
        '    cartID = Request.Cookies("cartID").Value
        'Else
        '    setCookie("cartID", "", 0)
        '    'Response.Cookies("cartID").Value = ""
        'End If

        If Not err Then
            Dim appSet As NameValueCollection = ConfigurationManager.AppSettings
            'dynamic account
            Dim cdnLocation = appSet.Item("cdnLocation")
            Dim getseqcon = appSet.Item("sequoia")

            'If cartID = "" Then
            'Response.Cookies("cartID").Value = runSQLwithResult("exec api.createNewid")
            Dim newid As String

            'newid = runSQLwithResult("exec api.createNewid", getseqcon) '//tidak boleh ada, taruh di atas, kalau masih dipakai
            newid = curHostGUID
            setCookie("cartID", newid, 7)
            'Else
            'Response.Cookies("cartID").Value = Request.Cookies("cartID").Value
            'End If
            If code <> loginPage And code <> "lockscreen" And code <> "home" And code <> "login2" And code <> "login" And code <> "verifycode" Then  'And code <> "404" Then
                If Request.ApplicationPath.Replace("/", "") = "" Then
                    setCookie(Request.Url.Authority.Replace(": ", "") & "_lastPar", Request.Url.PathAndQuery, 1)
                Else
                    setCookie(Request.ApplicationPath.Replace("/", "") & "_lastPar", Request.Url.PathAndQuery, 1)
                End If
            End If

            If suba <> "" And getCookie(getCookie("baseAccount") & "_accountid") <> suba Then
                setCookie(Session("baseAccount") & "_accountid", suba, "1")
            End If

            'loadaccount in trouble, please check

            WindowOnLoad = "initTheme('" & code.ToLower & "', null, '" & curHostGUID & "', '" & pageURL & "');"
            Response.Cookies("themeFolder").Value = themeFolder
            loadManifest(themeFolder, cdnLocation, isOfflineMode)
            setCookie("page", pageURL, "1")
        End If
    End Sub
End Class
