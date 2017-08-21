
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
                        result = "<sqroot>" & xmlstr & "</sqroot>"
                    Else
                        result = "<sqroot><message>Incorrect Password!</message></sqroot>"
                    End If

                End If
            Case "checklatestevent"
                Dim lvl = getQueryVar("lvl")
                sqlstr = "exec [api].[sync_checklatestevent] '" & accountId & "', '" & sessionToken & "', '" & lvl & "'"

				xmlstr = getXML(sqlstr, contentOfdbODBC)

				If xmlstr IsNot Nothing And xmlstr <> "" Then
                    result = "<sqroot>" & xmlstr & "</sqroot>"
                Else
                    result = "<sqroot><message>Incorrect Data!</message></sqroot>"
                End If

            Case "reqcodeprop"
                Dim code = getQueryVar("code")

                sqlstr = "exec [api].[sync_reqcodeprop] '" & accountId & "', '" & sessionToken & "', '" & code & "'"

				xmlstr = getXML(sqlstr, contentOfdbODBC)

				If xmlstr IsNot Nothing And xmlstr <> "" Then
                    result = "<sqroot>" & xmlstr & "</sqroot>"
                Else
                    result = "<sqroot><message>Incorrect Data!</message></sqroot>"
                End If

            Case "reqheader"
                Dim code = getQueryVar("code")
                Dim pg = getQueryVar("page")

                sqlstr = "exec [api].[sync_reqheader] '" & accountId & "', '" & sessionToken & "', '" & code & "', " & IIf(pg = "", 1, pg) & ""

				xmlstr = getXML(sqlstr, contentOfdbODBC)

				If xmlstr IsNot Nothing And xmlstr <> "" Then
                    result = "<sqroot>" & xmlstr & "</sqroot>"
                Else
                    result = "<sqroot><message>Incorrect Data!</message></sqroot>"
                End If

            Case "reqdata"
                Dim code = getQueryVar("code")
                Dim guid = getQueryVar("guid")
                Dim pg = getQueryVar("page")

                sqlstr = "exec [api].[sync_reqdata] '" & accountId & "', '" & sessionToken & "', '" & code & "', '" & guid & "'"

				xmlstr = getXML(sqlstr, contentOfdbODBC)

				If xmlstr IsNot Nothing And xmlstr <> "" Then
                    result = "<sqroot>" & xmlstr & "</sqroot>"
                Else
                    result = "<sqroot><message>Incorrect Data!</message></sqroot>"
                End If

            Case "sendData"
                Dim code = getQueryVar("code")
                Dim dataxml = getQueryVar("dataXML")
                sqlstr = "exec [api].[sync_sendData] '" & accountId & "', '" & sessionToken & "', '" & code & "', '" & dataxml & "'"

				xmlstr = getXML(sqlstr, contentOfdbODBC)

				If xmlstr IsNot Nothing And xmlstr <> "" Then
                    result = "<sqroot>" & xmlstr & "</sqroot>"
                Else
                    result = "<sqroot><message>Incorrect Data!</message></sqroot>"
                End If

        End Select

        Response.ContentType = "text/xml"
        Response.Write("<?xml version=""1.0"" encoding=""utf-8""?>")
        Response.Write(result)

    End Sub
End Class
