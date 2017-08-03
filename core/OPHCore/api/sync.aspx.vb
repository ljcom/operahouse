
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
        Select Case mode
            Case "reqToken"
                Dim accountId = getQueryVar("accountId")
                Dim userId = getQueryVar("userId")
                Dim pwd = getQueryVar("pwd")
                If accountId.ToLower() <> contentOfaccountId.ToLower() Or userId = "" Or pwd = "" Then
                    result = "<sqroot><message>Wrong Parameter Input!</message></sqroot>"
                Else
                    sqlstr = "exec core.verifyToken '" & accountId & "', '" & userId & "', '" & pwd & "'"
                    xmlstr = getXML(sqlstr, contentOfsequoiaCon)

                    If xmlstr IsNot Nothing And xmlstr <> "" Then
                        result = "<sqroot>" & xmlstr & "</sqroot>"
                    Else
                        result = "<sqroot><message>Incorrect Password!</message></sqroot>"
                    End If

                End If
            Case "checkLatestEvent"
                Dim lastEvent = getQueryVar("lastEvent")
                Dim sessionToken = getQueryVar("token")

                Response.Write(result)
            Case "reqTableProp"
                Dim tableList = getQueryVar("tableListXML")

                Response.Write(result)

            Case "requestData"
                Dim tableList = getQueryVar("dataKeyXML")
                Response.Write(result)

            Case "sendData"
                Dim tableList = getQueryVar("dataXML")
                Response.Write(result)

        End Select

        Response.ContentType = "text/xml"
        Response.Write("<?xml version=""1.0"" encoding=""utf-8""?>")
        Response.Write(result)

    End Sub
End Class
