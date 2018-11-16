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
        Dim curHostGUID = Session("hostGUID")
        Dim curUserGUID = Session("userGUID")

        Dim wf1 = getQueryVar("wf1")
        Dim wf1value = getQueryVar("wf1value")
        Dim wf2 = getQueryVar("wf2")
        Dim wf2value = getQueryVar("wf2value")
        If wf2 = "0" Then wf2 = ""
        wf1value = IIf(wf1value = "NULL", wf1value, "'" & wf1value & "'")
        wf2value = IIf(wf2value = "NULL", wf2value, "'" & wf2value & "'")

        If Request("code") <> "" Then
            Dim appSettings = ConfigurationManager.AppSettings
            Dim nbRow = getQueryVar("nbRow").ToString
            Dim search = getQueryVar("search") & " " & getQueryVar("q")
            Dim dv = getQueryVar("defaultValue").ToString
            Dim code = getQueryVar("code").ToString
            Dim colkey = getQueryVar("colkey").ToString
            Dim parentCode = getQueryVar("parentCode").ToString

            search = search.Replace("*", " ")
            'Dim sqlstr = "exec api.autosuggest_old '" & curHostGUID & "', '" & getQueryVar("code") & "','" & getQueryVar("key") & "','" & getQueryVar("id") & "','" & getQueryVar("name") & "','" & search & "','" & wf1 & "'," & wf1value & ",'" & wf2 & "'," & wf2value & ""
            Dim sqlstr = "exec api.autosuggest @hostguid='" & curHostGUID & "', @code='" & code & "', @colkey='" & colkey & "', @defaultValue='" & dv & "', @searchText='" & Trim(search) & "', @wf1Value=" & wf1value & ", @wf2value=" & wf2value & IIf(nbRow <> "", ", @nbRow=" & nbRow, "")

            Dim xmlstr = getXML(sqlstr)
            Dim json = ""
            If xmlstr = "" Then
                writeLog("autosuggest:" & sqlstr)
            End If

            If getQueryVar("mode") = "token" Then
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
