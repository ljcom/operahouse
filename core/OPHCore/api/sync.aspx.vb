Imports System.IO
Imports System.IO.Compression

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
        If sessionToken = "" Then sessionToken = "null" Else sessionToken = "'" & sessionToken & "'"
        writeLog(mode)
        Dim isXML = True
        If accountId <> "" Then
            Select Case mode.ToLower
                Case "reqtoken"
                    Dim userId = getQueryVar("userId")
                    Dim pwd = getQueryVar("pwd")
                    If accountId.ToLower() <> contentOfaccountId.ToLower() Or userId = "" Or pwd = "" Then
                        result = "<sqroot><message>Wrong Parameter Input!</message></sqroot>"
                    Else
                        sqlstr = "exec api.sync_reqtoken '" & accountId & "', '" & userId & "', '" & pwd & "'"
                        writeLog(sqlstr)
                        xmlstr = getXML(sqlstr, contentOfsequoiaCon)

                        If xmlstr IsNot Nothing And xmlstr <> "" Then
                            'result = "<sqroot>" & xmlstr & "</sqroot>"
                            result = xmlstr
                        Else
                            result = "<sqroot><source>reqtoken</source><message>Incorrect Password!</message></sqroot>"
                        End If

                    End If
                Case "dbinfo"
                    sqlstr = "exec api.sync_dbinfo '" & accountId & "', " & sessionToken & ""
                    xmlstr = getXML(sqlstr, contentOfsequoiaCon)

                    If xmlstr IsNot Nothing And xmlstr <> "" Then
                        'result = "<sqroot>" & xmlstr & "</sqroot>"
                        result = xmlstr
                    Else
                        result = "<sqroot><source>dblist</source><message>Incorrect Data!</message></sqroot>"
                    End If
                Case "reqcorescript"
                    sqlstr = "exec core.createDB '" & accountId & "', @isScriptOnly=1, @token=" & sessionToken & ""
                    xmlstr = getXML(sqlstr, contentOfsequoiaCon, 0)
                    If Not IsNothing(xmlstr) Then
                        Dim result1 = xmlstr.Replace("&amp;", "&").Replace("&lt;", "<").Replace("&gt;", ">")
                        Dim newid = Guid.NewGuid().ToString
                        Dim path = Server.MapPath("~/OPHContent/documents") & "\temp\"
                        Dim filename = "install_" & accountId & "_" & newid & ".sql"
                        writeFile(path, filename, result1)
                        Dim r = download("../../ophcontent/documents/temp/", filename)
                    End If
                Case "webrequestfile"
                    Dim r = download("../../ophcontent/documents/sync/", "sync.data")
                Case "webrequestSETUP"
                    sqlstr = "exec core.webrequestsetup"
                    xmlstr = getXML(sqlstr, contentOfsequoiaCon, 0)
                Case "checklatestevent"
                    Dim lvl = getQueryVar("lvl")
                    sqlstr = "exec [api].[sync_checklatestevent] '" & accountId & "', " & sessionToken & ", '" & lvl & "'"

                    xmlstr = getXML(sqlstr, contentOfdbODBC)

                    If xmlstr IsNot Nothing And xmlstr <> "" Then
                        'result = "<sqroot>" & xmlstr & "</sqroot>"
                        result = xmlstr
                    Else
                        result = "<sqroot><source>checklatestevent</source><message>Incorrect Data!</message></sqroot>"
                    End If

                Case "reqcodeprop"
                    Dim code = getQueryVar("code")

                    sqlstr = "exec [api].[sync_reqcodeprop] '" & accountId & "', " & sessionToken & ", '" & code & "'"

                    xmlstr = getXML(sqlstr, contentOfdbODBC)

                    If xmlstr IsNot Nothing And xmlstr <> "" Then
                        'result = "<sqroot>" & xmlstr & "</sqroot>"
                        result = xmlstr
                    Else
                        result = "<sqroot><source>reqcodeprop</source><message>Incorrect Data!</message></sqroot>"
                    End If
                Case "sendcodeprop"
                    Dim code = getQueryVar("code")
                    If Not IsNothing(Request.Form("dataXML")) Then
                        Dim dataxml = Request.Form("dataXML").ToString.Replace("%26lt;", "<").Replace("%26gt;", ">").Replace("%26", "&").Replace("&lt;", "<").Replace("&gt;", ">")
                        writeLog(Len(Request.Form("dataXML")).ToString & " " & Len(dataxml).ToString & " " + dataxml)

                        sqlstr = "exec [api].[sync_sendcodeprop] '" & accountId & "', " & sessionToken & ", '" & code & "', '" & dataxml.Replace("'", "''") & "'"

                        writeLog(sqlstr)
                        xmlstr = getXML(sqlstr, contentOfdbODBC)
                        writeLog(xmlstr)
                        result = "<sqroot><message>Done</message></sqroot>"
                    Else

                        If xmlstr IsNot Nothing And xmlstr <> "" Then
                            'result = "<sqroot>" & xmlstr & "</sqroot>"
                            result = xmlstr
                        Else
                            result = "<sqroot><source>sendcodeprop</source><message>Incorrect Data!</message></sqroot>"
                        End If
                    End If
                Case "reqheader"
                    Dim code = getQueryVar("code")
                    Dim pg = getQueryVar("page")

                    sqlstr = "exec [api].[sync_reqheader] '" & accountId & "', " & sessionToken & ", '" & code & "', " & IIf(pg = "", 1, pg) & ""
                    writeLog(sqlstr)

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
                    Dim delMode = Request.Form("delMode")
                    'Dim pg = getQueryVar("page")

                    sqlstr = "exec [api].[sync_reqdata] @accountid='" & accountId & "', @token=" & sessionToken & ", @code='" & code & "', @guid='" & guid & "', @delMode=" & IIf(delMode = "1", "1", "0")
                    writeLog(sqlstr)
                    xmlstr = getXML(sqlstr, contentOfdbODBC)
                    writeLog(xmlstr)
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
                        Dim dataxml = Request.Form("dataXML").ToString.Replace("&lt;", "<").Replace("&gt;", ">")
                        writeLog(Len(Request.Form("dataXML")).ToString & " " & Len(dataxml).ToString & " " + dataxml)

                        sqlstr = "exec [api].[sync_sendData] '" & accountId & "', " & sessionToken & ", '" & code & "', '" & dataxml.Replace("'", "''") & "', 1"
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
        Else
            result = "account is not exists"
        End If
        If isXML Then
            Response.ContentType = "text/xml"
            Response.Write("<?xml version=""1.0"" encoding=""utf-8""?>")
        End If

        Response.Write(result)

    End Sub
    Protected Function download(path As String, f1 As String) As Boolean
        Dim bytes() As Byte
        Dim fInfo As New FileInfo(Server.MapPath(path) & f1)
        Dim numBytes As Long = fInfo.Length
        Dim fStream As New FileStream(Server.MapPath(path) & f1, FileMode.Open, FileAccess.Read)
        Dim br As New BinaryReader(fStream)
        bytes = br.ReadBytes(CInt(numBytes))

        Response.Buffer = True
        Response.Charset = ""
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.AddHeader("content-disposition", "attachment;filename=" & f1)
        Response.BinaryWrite(bytes)
        Response.Flush()
        Response.End()
        Return True
    End Function
End Class
