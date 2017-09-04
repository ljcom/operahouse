
Partial Class OPHCore_api_sync
    Inherits cl_base

    Private Sub OPHCore_api_sync_Load(sender As Object, e As EventArgs) Handles Me.Load
        loadAccount()

        Dim curODBC = contentOfdbODBC
        Dim DBCore = contentOfsqDB

        Dim curHostGUID = Session("hostGUID")
        Dim curUserGUID = Session("userGUID")
        Dim result = "", sqlstr = "", xmlstr = ""
        Dim mode = getQueryVar("mode")
        Dim accountId = contentOfaccountId
        Dim sessionToken = getQueryVar("token")
		writeLog(mode)
		Select Case mode.ToLower
            Case "reqtoken"
                Dim userId = getQueryVar("userId")
                Dim pwd = getQueryVar("pwd")
                If accountId.ToLower() <> contentOfaccountId.ToLower() Or userId = "" Or pwd = "" Then
                    result = "<sqroot><message>Wrong Parameter Input!</message></sqroot>"
                Else
                    sqlstr = "exec api.sync_reqtoken '" & accountId & "', '" & userId & "', '" & pwd & "'"
                    xmlstr = getXML(sqlstr, contentOfsequoiaCon)

                    If xmlstr IsNot Nothing And xmlstr <> "" Then
						'result = "<sqroot>" & xmlstr & "</sqroot>"
						result = xmlstr
					Else
						result = "<sqroot><source>reqtoken</source><message>Incorrect Password!</message></sqroot>"
					End If

                End If
            Case "checklatestevent"
                Dim lvl = getQueryVar("lvl")
                sqlstr = "exec [api].[sync_checklatestevent] '" & accountId & "', '" & sessionToken & "', '" & lvl & "'"

				xmlstr = getXML(sqlstr, contentOfdbODBC)

				If xmlstr IsNot Nothing And xmlstr <> "" Then
					'result = "<sqroot>" & xmlstr & "</sqroot>"
					result = xmlstr
				Else
					result = "<sqroot><source>checklatestevent</source><message>Incorrect Data!</message></sqroot>"
				End If

            Case "reqcodeprop"
                Dim code = getQueryVar("code")

                sqlstr = "exec [api].[sync_reqcodeprop] '" & accountId & "', '" & sessionToken & "', '" & code & "'"

				xmlstr = getXML(sqlstr, contentOfdbODBC)

				If xmlstr IsNot Nothing And xmlstr <> "" Then
					'result = "<sqroot>" & xmlstr & "</sqroot>"
					result = xmlstr
				Else
					result = "<sqroot><source>reqcodeprop</source><message>Incorrect Data!</message></sqroot>"
				End If
			Case "sendcodeprop"
				Dim code = getQueryVar("code")

				sqlstr = "exec [api].[sync_sendcodeprop] '" & accountId & "', '" & sessionToken & "', '" & code & "'"

				xmlstr = getXML(sqlstr, contentOfdbODBC)

				If xmlstr IsNot Nothing And xmlstr <> "" Then
					'result = "<sqroot>" & xmlstr & "</sqroot>"
					result = xmlstr
				Else
					result = "<sqroot><source>sendcodeprop</source><message>Incorrect Data!</message></sqroot>"
				End If
			Case "reqheader"
                Dim code = getQueryVar("code")
                Dim pg = getQueryVar("page")

				sqlstr = "exec [api].[sync_reqheader] '" & accountId & "', '" & sessionToken & "', '" & code & "', " & IIf(pg = "", 1, pg) & ""

				xmlstr = getXML(sqlstr, contentOfdbODBC)

				If xmlstr IsNot Nothing And xmlstr <> "" Then
					'result = "<sqroot>" & xmlstr & "</sqroot>"
					result = xmlstr
				Else
					result = "<sqroot><source>reqheader</source><message>Incorrect Data!</message></sqroot>"
				End If

            Case "reqdata"
                Dim code = getQueryVar("code")
				Dim guid = Request.Form("guid")
				'Dim pg = getQueryVar("page")

				sqlstr = "exec [api].[sync_reqdata] '" & accountId & "', '" & sessionToken & "', '" & code & "', '" & guid & "'"

				xmlstr = getXML(sqlstr, contentOfdbODBC)

				If xmlstr IsNot Nothing And xmlstr <> "" Then
					'result = "<sqroot>" & xmlstr & "</sqroot>"
					result = xmlstr
				Else
					result = "<sqroot><source>reqdata</source><message>Incorrect Data!</message></sqroot>"
				End If

			Case "senddata"
				Dim code = getQueryVar("code")
				writeLog(code)
				If Not IsNothing(Request.Form("dataXML")) Then
					Dim dataxml = Request.Form("dataXML").ToString.Replace("%26lt;", "<").Replace("%26gt;", ">").Replace("%26", "&").Replace("&lt;", "<").Replace("&gt;", ">")
					writeLog(Len(Request.Form("dataXML")).ToString & " " & Len(dataxml).ToString & " " + dataxml)

					sqlstr = "exec [api].[sync_sendData] '" & accountId & "', '" & sessionToken & "', '" & code & "', '" & dataxml & "'"
					writeLog(sqlstr)
					xmlstr = getXML(sqlstr, contentOfdbODBC)
					writeLog(xmlstr)
					result = "<sqroot><message>Done</message></sqroot>"
				Else
					If xmlstr IsNot Nothing And xmlstr <> "" Then
						'result = "<sqroot>" & xmlstr & "</sqroot>"
						result = xmlstr
					Else
						result = "<sqroot><source>senddata</source><message>Incorrect Data!</message></sqroot>"
					End If
				End If
		End Select

        Response.ContentType = "text/xml"
        Response.Write("<?xml version=""1.0"" encoding=""utf-8""?>")
        Response.Write(result)

    End Sub
End Class
