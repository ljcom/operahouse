Imports System.Data
Imports System.Web.Script.Serialization

Partial Class OPHCore_api_msg_autosuggest
    Inherits cl_base

    Public Class opti
        Public id As String
        Public text As String
    End Class
    Public Class optiToken
        Public id As String
        Public name As String
    End Class

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Dim json = "[{id: 1,text: 'haha'},{id: 2,text: 'hehe'},{id: 3,text: 'ihiyahayuhuy'},{id: 4,text: 'asdssda'}]"
        loadAccount()
        'Dim accountid = getAccount()
        'Dim curODBC = getODBC(accountid)
        'Dim DBCore = getDBCore(accountid)

        Dim wf1 = Request.QueryString("wf1")
        Dim wf1value = Request.QueryString("wf1value")
        Dim wf2 = Request.QueryString("wf2")
        Dim wf2value = Request.QueryString("wf2value")
        wf1value = IIf(wf1value = "NULL", wf1value, "'" & wf1value & "'")

        If Request("code") <> "" Then
            Dim appSettings = ConfigurationManager.AppSettings

            Dim search = Request.QueryString("search") & " " & Request.QueryString("q")

            Dim sqlstr = "exec api.autosuggest '" & contentOfaccountId & "', '" & contentOfsqDB & "', '" & Request.QueryString("code") & "','" & Request.QueryString("key") & "','" & Request.QueryString("id") & "','" & Request.QueryString("name") & "','" & search & "','" & wf1 & "'," & wf1value & ",'" & wf2 & "','" & wf2value & "'"

            Dim xmlstr = getXML(sqlstr)
            Dim json = ""

            If Request.QueryString("mode") = "token" Then
                Dim OptionList As New List(Of optiToken)


                If xmlstr IsNot Nothing Or xmlstr <> "" Then

                    For Each opt In XDocument.Parse(xmlstr).Element("sqroot").Elements("option")
                        OptionList.Add(New optiToken With {.id = opt.Element("value").Value, .name = opt.Element("caption").Value})
                    Next

                    Dim serializer As New JavaScriptSerializer()
                    Dim serializedResult = serializer.Serialize(OptionList)

                    json = "" + serializedResult + ""

                Else
                    'json = "{""results"": {""id""=""1"",""text""=""No Result Found"",""name""=""No Result Found""},""more"": false}"
                    json = "[{""id""=""1"",""name""=""No Result Found""}]"
                End If
            Else
                Dim OptionList As New List(Of opti)

                If xmlstr IsNot Nothing Or xmlstr <> "" Then

                    For Each opt In XDocument.Parse(xmlstr).Element("sqroot").Elements("option")
                        OptionList.Add(New opti With {.id = opt.Element("value").Value, .text = opt.Element("caption").Value})
                    Next

                    Dim serializer As New JavaScriptSerializer()
                    Dim serializedResult = serializer.Serialize(OptionList)

                    json = "{""results"": " + serializedResult + ",""more"": false}"

                Else
                    'json = "{""results"": {""id""=""1"",""text""=""No Result Found"",""name""=""No Result Found""},""more"": false}"
                    json = "[{""id""=""1"",""text""=""No Result Found""}]"
                End If
            End If

            Response.Clear()
            Response.ContentType = "application/json; charset=utf-8"
            Response.Write(json)
            Response.Flush()
            'Response.End()
        Else
            reloadURL("?")
        End If

    End Sub
End Class