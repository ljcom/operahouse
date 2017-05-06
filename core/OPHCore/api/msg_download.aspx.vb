Imports System.Data
Imports System.IO

Partial Class OPHCore_api_msg_download
    Inherits cl_base

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim tGUID As String = Request.QueryString("GUID")
        Dim code As String = Request.QueryString("code")
        Dim fieldAttachment As String = Request.QueryString("fieldAttachment")

        'Dim fieldKey As String = Request.QueryString("fieldKey")
        Dim ocode = Left(code, 1) & "a" & code.Substring(2, Len(code) - 2)

        Dim con = runSQLwithResult("select ACCTDBSE.ODBC from MODL inner join ACCTDBSE on MODL.accountDBGUID=ACCTDBSE.accountDBGUID where MODL.ModuleId='" & code & "'")
        'Dim con = runSQLwithResult("select ODBC from CoMODL where ModuleId='" & code & "'")
        Dim sqlstr1 = "select colname from gen.coTABLFIEL a inner join gen.coTABL b on a.tableGUID=b.TableGUID where tablename='" & ocode & "' and colorder=10"
        Dim fieldKey As String = runSQLwithResult(sqlstr1, con)

        'Dim path As String = Request.QueryString("path")
        'If Request.QueryString("dontdelete") = 1 Then
        'Dim path As String = Server.MapPath(Session("DocumentFolder") & "\temp\").ToString
        'Else
        'Dim path As String = Session("document") & Session("documentFolder") & "/" & Left(code, 1) & "a" & Mid(code, 3, Len(code) - 2) & "_" & fieldAttachment & "/"
        Dim hostguid = Session("hostguid")
        sqlstr1 = "select infovalue from acctinfo a 	inner join acct b 		on a.accountguid=b.accountguid	inner join [user] d		on d.accountguid = b.AccountGUID	inner join userhost c 		on c.UserGUID = d.userguid where infokey='documentFolder' and c.hostguid='" & hostguid & "'"

        Dim path As String = runSQLwithResult(sqlstr1)
        'path=path & ocode & ""
        'End If


        If fieldAttachment <> "" Then
            'Dim con = Session("odbc")
            Dim sqlstr = "Select " & fieldAttachment & " From oph." & ocode & " Where " & fieldKey & " ='" & tGUID & "'"
            Dim dt = SelectSqlSrvRows(sqlstr, con)
            path = path & "\" & ocode & "_" & fieldAttachment & "\"
            download(path, dt.Tables(0).Rows(0)(fieldAttachment).ToString())
        Else
            Dim querysql As String = Request.QueryString("querysql")
            Dim sqlexec = "exec " & querysql & " '" & Session("hostGUID") & "', '" & tGUID & "' ,1"
            runSQL(sqlexec, con)
            Dim sqlTXT = "exec gen.downloadTXT '" & tGUID & "_" & code & "'"
            Dim dt = SelectSqlSrvRows(con, sqlTXT) 'hasil harus tXTFIle berupa filepath dan BLOB 
            'download(dt.Tables(0), "TXTFile", path)
        End If
    End Sub

    Protected Function download(path As String, filename As String) As Boolean
        Dim bytes() As Byte
        path = path '& filename
        If Directory.Exists(path) Then
            Dim f As String
            f = filename
            'Else
            'f = Server.MapPath(path) & LTrim(dt.Rows(0)(f1).ToString())
            'End If
            Dim fInfo As New FileInfo(f)

            Dim numBytes As Long = fInfo.Length
            Dim fStream As New FileStream(f, FileMode.Open, FileAccess.Read)
            Dim br As New BinaryReader(fStream)
            bytes = br.ReadBytes(CInt(numBytes))
            If Request.QueryString("dontdelete") = 1 Then
                Response.Write(f)
            Else
                Response.Buffer = True
                Response.Charset = ""
                Response.Cache.SetCacheability(HttpCacheability.NoCache)
                'Response.ContentType = dt.Rows(0)(f2).ToString()
                Response.AddHeader("content-disposition", "attachment;filename=" & filename)
                Response.BinaryWrite(bytes)
                Response.Flush()
                Response.End()
            End If
        Else
            Response.Write("File not found.")
            Response.End()
        End If

        Return True

    End Function

End Class
