Imports System.IO
Imports System.Net

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

		Dim isSingle = True
		Dim xmlstr = ""
		Dim xmlstr1 = ""

		Dim mode = getQueryVar("mode")
		If mode = "" Then
			mode = Request.Form("mode")
		End If

		Dim code = ""
		If getQueryVar("code") <> "" Then code = "" & getQueryVar("code") & ""
		If code = "" Then
			code = Request.Form("code")
		End If

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

				If sortOrder = "" Or sortOrder = "," Then sortOrder = ""
				If stateid = "" Or stateid = "" Or stateid = "," Or stateid = "null" Then
					sqlstr = "select c.StateID from modl a inner join msta b on a.ModuleStatusGUID=b.ModuleStatusGUID inner join mstastat c on b.ModuleStatusGUID=c.ModuleStatusGUID and c.isDefault=1 where moduleid='" & code & "'"
					stateid = runSQLwithResult(sqlstr, curODBC)
				End If

				If searchText = "null" Or searchText = "search" Then searchText = ""
				If bpage = "" Then bpage = 1

				Dim rpp = 20 'IIf(code.Length() > 6 And String.IsNullOrWhiteSpace(sqlfilter) = False, 10, 20)
				'add showpage untuk frontend
				Dim showpage = getQueryVar("showpage")
				If showpage <> "" Then
					rpp = showpage
				End If
                sqlstr = "exec [api].[theme_browse] '" & curHostGUID & "', '" & code & "', '" & sqlfilter.Replace("'", "''") & "', '" & searchText.Replace("'", "''") & "', " & bpage & ", " & rpp & ", '" & sortOrder & "', '" & stateid & "'"

				'isSingle = False
				'xmlstr = getXML(sqlstr, curODBC)

			Case "view", "form"
				sqlstr = "exec [api].[theme_form] '" & curHostGUID & "', '" & code & "', " & GUID '& ", " & editMode

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
			Case "talk"
				Dim comment As String = getQueryVar("comment")
				sqlstr = "exec gen.submitTalk '" & curHostGUID & "', " & GUID & ", '" & comment & "'"
			Case "widget"
				Dim stateid = getQueryVar("stateid")
				sqlstr = "exec [api].[theme_widget] '" & curHostGUID & "', '" & code & "'"
			Case "data"
				Dim data = getQueryVar("data")
				Dim sqlFilter = getQueryVar("sqlFilter")
				sqlstr = "exec [api].[getData] '" & curHostGUID & "', '" & data & "', '" & sqlFilter & "'"
				xmlstr = runSQLwithResult(sqlstr, curODBC)
				isSingle = False
			Case "upload"
				Dim fieldattachment As New List(Of String)
				Dim f As String
				For Each f In Request.Files
					Dim path As String
					path = Server.MapPath("~/OPHContent/documents/temp")

					'Dim curField = ""

					'For Each n In Request.Form
					'    If Request.Form(n) = Request.Files(f).FileName Then
					'        curField = n
					'        fieldattachment.Add(curField)
					'        Exit For
					'    End If
					'Next
					'Dim theDate As DateTime = DateTime.Now
					Dim ranGUID = System.Guid.NewGuid().ToString()
					Dim ParentGUID = getQueryVar("GUID")


					Dim fxn As String = path & "\" & contentOfaccountId & "\" & code & "_" & ranGUID.Replace("'", "") & "_" & Request.Files(f).FileName

					Dim checkDir = path & "\" & contentOfaccountId & "\"
					If Not Directory.Exists(checkDir) Then Directory.CreateDirectory(checkDir)
					If Directory.Exists(checkDir) Then
						If fxn <> "" Then Request.Files(f).SaveAs(fxn)
					End If
					sqlstr = "exec gen.uploadChild '" & curHostGUID & "', '" & code & "', '" & GUID.Replace("'", "") & "', '" & ParentGUID & "', '" & fxn & "'"
					xmlstr = getXML(sqlstr, curODBC)
				Next

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
			'Case "widget"
			'    sqlstr = "exec [api].[theme_widget] '" & curHostGUID & "', '" & code & "'"
			'    xmlstr = runSQLwithResult(sqlstr, curODBC)

			Case "signout"
                Response.Cookies("guestID").Value = ""
                Response.Cookies("sqlFilter").Value = ""
                Session.Clear()
                Session.RemoveAll()
                Session.Abandon()
				noxml = True
				isSingle = False
            Case "revokeDelegation"
                sqlstr = "exec [api].[revoke_delegation] '" & curHostGUID & "', '" & code & "'"
                xmlstr = runSQLwithResult(sqlstr, curODBC)
                xmlstr = "<sqroot><message>" & xmlstr & "</message></sqroot>"
                isSingle = False
            Case "saveProfile"
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
					GUID = System.Guid.NewGuid().ToString()
					GUID = Left(GUID, 8)
					Dim fxn As String = path & "\" & contentOfaccountId & "\" & code & "_" & curField & "\" & szFilename & "\" & GUID.Replace("'", "") & "_" & Request.Files(f).FileName

					Dim checkDir = path & "\" & contentOfaccountId & "\" & code & "_" & curField & "\" & szFilename & "\"
					If Not Directory.Exists(checkDir) Then Directory.CreateDirectory(checkDir)
					If Directory.Exists(checkDir) Then
						If fxn <> "" Then Request.Files(f).SaveAs(fxn)
					End If
				Next

				sqlstr = populateSaveXML(1, code, 0, fieldattachment, GUID)
				sqlstr = sqlstr.Replace("#95#", "_")
				sqlstr = sqlstr.Replace("[save]", "[save_profile]")
                xmlstr = runSQLwithResult(sqlstr, curODBC)
                xmlstr = "<sqroot><message>" & xmlstr & "</message></sqroot>"
                isSingle = False
            Case "changePassword"
				Dim curPass = getQueryVar("curpass")
				Dim newPass = getQueryVar("newpass")

				sqlstr = "exec gen.changePassword '" & curHostGUID & "', '" & curPass & "', '" & newPass & "'"
				xmlstr = runSQLwithResult(sqlstr, curODBC)
                xmlstr = "<sqroot><message>" & xmlstr & "</message></sqroot>"
                isSingle = False
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
				Dim userid = getQueryVar("userid")
				Dim pwd = getQueryVar("pwd")
				Dim source As String = Request.Form("source")
				Dim captcha = Request.Form("g-recaptcha-response")
				If userid = "" And pwd = "" And captcha = "" Then
					reloadURL("index.aspx?")
				Else
					If (captcha <> "" And IsGoogleCaptchaValid()) Or (source.ToLower.IndexOf("localhost") > 0) Or (source.ToLower.IndexOf("code=lockscreen") > 0) Then
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
					Else
						xmlstr = "<sqroot><message>Please authorize CAPTCHA!</message></sqroot>"
					End If
					'--!
					isSingle = False

				End If
		End Select
		If isSingle Then xmlstr = getXML(sqlstr, curODBC)

		If xmlstr <> "" Then
			xmlstr1 = xmlstr.Substring(1, 6)
		End If
		If xmlstr1 <> "sqroot" Then
			isSingle = False
		End If
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
