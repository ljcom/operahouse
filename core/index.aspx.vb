Partial Class index
    'Inherits System.Web.UI.Page
    Inherits cl_base
    Protected isOfflineMode As Boolean = False
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        'offline
        'If getQueryVar("offline") = "1" Then
        '    setCookie("offline", "1", 1)
        '    isOfflineMode = True
        'ElseIf getQueryVar("offline") = "0" Then
        '    setCookie("offline", "0", 1)
        'End If

        'If Not IsNothing(Request.Cookies("offline")) Then
        '    isOfflineMode = Request.Cookies("offline").Value = "1"
        'End If

        Dim curHostGUID As String = "", code As String = "", themeFolder As String = "", pageURL As String = ""
        Dim GUID = getQueryVar("GUID")
        Dim needLogin As Boolean = False
        Dim loginPage As String = ""
        Dim suba As String = ""

        'Dim old = True
        'If old Then
        contentOfCode = getQueryVar("code")
        'If Session(contentOfCode.ToLower()) = "" Then
        Dim loadStr = loadAccount(getQueryVar("env"), getQueryVar("code"), getQueryVar("GUID"))
        'Session(contentOfCode.ToLower()) = contentOfthemeFolder & ";" & contentOfthemePage & ";" & contentofNeedLogin & ";" & contentofsignInPage & ";" & contentOfGUID
        'setCookie(contentOfCode.ToLower(), Session(contentOfCode), 1)
        'End If

        curHostGUID = getSession()

        Dim x = loadStr.Split(";")
        Try
            code = x(0)
            themeFolder = x(1)
            pageURL = x(2)
            If x(3) <> "" Then needLogin = x(3) = True
            loginPage = x(4)
            GUID = x(5)
            'CartID = x(7)
            suba = x(8)
        Catch exc As Exception
            Stop
        End Try


        'code = contentOfCode
        ''env = contentOfEnv
        'themeFolder = contentOfthemeFolder
        'pageURL = contentOfthemePage
        'needLogin = contentofNeedLogin
        'loginPage = contentofsignInPage
        'GUID = contentOfGUID


        'Else
        '    Dim account As String = "", url As String = Request.Url.OriginalString.Replace(Request.Url.PathAndQuery, "") & Request.ApplicationPath
        '    If url.Substring(Len(url) - 1, 1) = "/" Then url = url.Substring(0, Len(url) - 1)
        '    Dim HostGUID As String = getSession()

        '    url = url & "/ophcore/api/default.aspx?mode=account&env=" & getQueryVar("env") & "&code=" & getQueryVar("code") & "&hostGUID=" & HostGUID & "&GUID=" & GUID
        '    'writeLog(url)
        '    Using WC As New System.Net.WebClient()
        '        If Request.ServerVariables(5) <> "" Then WC.UseDefaultCredentials = True
        '        Try
        '            account = WC.DownloadString(url)
        '            Dim x = XDocument.Parse(account)

        '            curHostGUID = x.<sqroot>.<hostGUID>.Value    'Session("hostGUID")
        '            code = x.<sqroot>.<code>.Value.ToLower 'contentOfCode
        '            'env = x.<sqroot>.<env>.Value 'contentOfEnv
        '            themeFolder = x.<sqroot>.<themeFolder>.Value 'contentOfthemeFolder
        '            pageURL = x.<sqroot>.<themePage>.Value 'contentOfthemePage
        '            needLogin = x.<sqroot>.<needLogin>.Value 'contentofNeedLogin
        '            loginPage = x.<sqroot>.<signInPage>.Value 'contentofsignInPage
        '            Session("hostGUID") = curHostGUID
        '            GUID = x.<sqroot>.<GUID>.Value 'contentofGUID
        '        Catch exc As Exception
        '            Console.Write(exc.Message)
        '            code = "404"
        '        End Try
        '    End Using
        'End If

		dim err as boolean=false
        If code = "" Then 'And getQueryVar("code") <> "404" Then
            Response.Write("LoadAccount: code is empty")
			err=true
			'Stop
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

		if not err then
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
			If code <> loginPage And code <> "lockscreen" And code <> "home" And code <> "login2" And code <> "login" Then  'And code <> "404" Then
				If Request.ApplicationPath.Replace("/", "") = "" Then
					setCookie(Request.Url.Authority.Replace(": ", "") & "_lastPar", Request.Url.PathAndQuery, 1)
				Else
					setCookie(Request.ApplicationPath.Replace("/", "") & "_lastPar", Request.Url.PathAndQuery, 1)
				End If
			End If

			If suba <> "" And Session("baseAccount") & "_accountid" <> suba Then
				setCookie(Session("baseAccount") & "_accountid", suba, "1")
			End If

			'loadaccount in trouble, please check

			WindowOnLoad = "initTheme('" & code.ToLower & "', null, '" & curHostGUID & "', '" & pageURL & "');"
			Response.Cookies("themeFolder").Value = themeFolder
			loadManifest(themeFolder, cdnLocation, isOfflineMode)
			setCookie("page", pageURL, "1")
		end if
    End Sub
End Class
