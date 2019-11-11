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

        Dim curHostGUID = getSession() 'Session("hostGUID")
        If curHostGUID = "" Or Session("odbc") = "" Then loadAccount()

        Dim curUserGUID = Session("userGUID")
		
		if getQueryVar("hostguid")<>"" then curHostGUID=getQueryVar("hostguid")

        'Dim wf1 = getQueryVar("wf1")
        Dim wf1value = getQueryVar("wf1value")
        'Dim wf2 = getQueryVar("wf2")
        Dim wf2value = getQueryVar("wf2value")
        'If wf2 = "0" Then wf2 = ""
        wf1value = IIf(wf1value = "NULL", wf1value, "'" & wf1value & "'")
        wf2value = IIf(wf2value = "NULL", wf2value, "'" & wf2value & "'")
		dim type = getQueryVar("type").toString
		if type = "" then type = "json"
		
        If Request("code") <> "" Then
            Dim appSettings = ConfigurationManager.AppSettings
            Dim nbRow = getQueryVar("nbRow").ToString
            Dim search = getQueryVar("search") & " " & getQueryVar("q")
            Dim dv = getQueryVar("defaultValue").ToString
            Dim code = getQueryVar("code").ToString
            Dim colkey = getQueryVar("colkey").ToString
            Dim parentCode = getQueryVar("parentCode").ToString
            Dim pgNo = getQueryVar("page").ToString

            search = search.Replace("*", " ")
            'Dim sqlstr = "exec api.autosuggest_old '" & curHostGUID & "', '" & getQueryVar("code") & "','" & getQueryVar("key") & "','" & getQueryVar("id") & "','" & getQueryVar("name") & "','" & search & "','" & wf1 & "'," & wf1value & ",'" & wf2 & "'," & wf2value & ""
            Dim sqlstr = "exec api.autosuggest @hostguid='" & curHostGUID & "', @code='" & code & "', @colkey='" & colkey & "', @defaultValue='" & dv & "', @searchText='" & Trim(search) & "', @wf1Value=" & wf1value & ", @wf2value=" & wf2value & IIf(nbRow <> "", ", @nbRow=" & nbRow, "") & IIf(pgNo <> "", ", @pgNo=" & pgNo, "")
			writeLog(sqlstr)

            Dim xmlstr = getXML(sqlstr)
            writeLog("autosuggest:" & sqlstr)
            Dim json = ""
            If xmlstr = "" Then
                writeLog("autosuggest:" & sqlstr)
            End If

            If getQueryVar("mode") = "token" Then
                Dim OptionList As New List(Of optiToken)


                If xmlstr IsNot Nothing Or xmlstr <> "" Then

                    For Each opt In XDocument.Parse(xmlstr).Element("sqroot").Elements("options").Elements("option")
                        OptionList.Add(New optiToken With {.id = opt.Element("value").Value, .name = opt.Element("caption").Value})
                    Next

                    Dim serializer As New JavaScriptSerializer()
                    Dim serializedResult = serializer.Serialize(OptionList)

                    json = "" + serializedResult + ""

                Else
                    'json = "{""results"": {""id""=""1"",""text""=""No Result Found"",""name""=""No Result Found""},""more"": false}"
                    json = "[{""id"":""1"",""name"":""No Result Found""}]"
                End If
            Else
                Dim OptionList As New List(Of opti)

                If xmlstr IsNot Nothing Or xmlstr <> "" Then
					
                    For Each opt In XDocument.Parse(xmlstr).Element("sqroot").Elements("options").Elements("option")
                        OptionList.Add(New opti With {.id = opt.Element("value").Value, .text = opt.Element("caption").Value})
                    Next

                    Dim serializer As New JavaScriptSerializer()
                    Dim serializedResult = serializer.Serialize(OptionList)

                    Dim doc As XDocument = XDocument.Parse(xmlstr)
                    Dim element = doc.Root.Element("value")

                    Dim more As String
                    If pgNo = "" Then pgNo = 1
                    If XDocument.Parse(xmlstr).Element("sqroot").Element("maxPages").Value = "0" Or XDocument.Parse(xmlstr).Element("sqroot").Element("maxPages").Value = pgNo Then
                        more = "false"
                        'serializedResult = serializedResult.Replace("No Result Found", "")
                    Else
                        more = "true"
                    End If

                    'json = "{""results"": " + serializedResult + ",""more"": true}"
                    json = "{""results"": " + serializedResult + ",""more"":" + more + "}"

                Else
                    'json = "{""results"": {""id""=""1"",""text""=""No Result Found"",""name""=""No Result Found""},""more"": false}"
                    json = "[{""id"":""1"",""text"":""No Result Found""}]"
                End If
            End If

            Response.Clear()
			if type<>"xml" then
				Response.ContentType = "application/json; charset=utf-8"
				Response.Write(json)
            else
				Response.ContentType = "text/xml"
				response.write(xmlstr)
			end if
			Response.Flush()
			
            'Response.End()
        Else
            reloadURL("?")
        End If

    End Sub
End Class
