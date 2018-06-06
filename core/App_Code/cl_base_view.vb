Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Class cl_base_view
    Inherits cl_base
    Protected contentofSaveString As String = ""

    Function writeXMLFromRequestForm(root As String, Optional fieldattachment As List(Of String) = Nothing, Optional GUID As String = "", Optional code As String = "") As String
        Dim info = "<" & root & ">#element#</" & root & ">"
        Dim theDate As DateTime = DateTime.Now
        Dim szFilename = Year(theDate) & "/" & Month(theDate)

        For x = 0 To Request.Form.Count - 1
            Dim colName As String = Request.Form.Keys(x)
            Dim ix As Integer

            'for Radio Button
            'ix = colName.ToLower().IndexOf("_radio")
            'If ix > 0 Then colName = Left(colName, ix)

            If fieldattachment.Contains(Request.Form.Keys(x)) Then
                info = info.Replace("#element#", "<field id=""" & colName & """><value>" & code & "_" & colName & "/" & szFilename & "/" & GUID & "_" & Request.Form(x).Replace("'", "''").Replace("NULL", "").Replace("&", "&amp;") & "</value></field>#element#")
            Else
                Dim reqForm = IIf(Request.Form(x) = "NULL", "", Request.Form(x).Replace("'", "&#39;").Replace("&", "&amp;"))
                info = info.Replace("#element#", "<field id=""" & colName & """><value>" & IIf(reqForm = "NULL", "", reqForm) & "</value></field>#element#")
                'info = info.Replace("#element#", "<field id=""" & colName & """><value>" & Request.Form(x).Replace("'", "&#39;").Replace("NULL", "").Replace("&", "&amp;") & "</value></field>#element#")
            End If
        Next
        info = info.Replace("#element#", "")

        Return info

    End Function
    Function populateSaveXML(ByVal vp As Long, ByVal Tablename As String, Optional ispreview As String = "", Optional fieldattachment As List(Of String) = Nothing, Optional GUID As String = "", Optional ByVal connection As String = "") As String

        loadAccount()
        Dim DBCore = contentOfsqDB
        Dim curHostGUID = Session("hostGUID")
        Dim curUserGUID = Session("userGUID")

        'Tablename = Left(Tablename, 1) & "o" & Mid(Tablename, 3, Len(Tablename) - 2)
        Dim saveXML = writeXMLFromRequestForm("sqroot", fieldattachment, GUID, Tablename)
        saveXML = saveXML.Replace("&amp;lt;", "&lt;").Replace("&amp;gt;", "&gt;").Replace("&amp;#39;", "&#39;")
        Dim contentofSaveString As String = ""
        Dim mainguid = Request.QueryString("cfunctionlist")
        Dim hostGUID As String

        If mainguid = "" Or Request.Form("gen_newid") = "1" Then
            'contentofSaveString = " exec api.[save] '" & Session("HostGUID").ToString & "', '" & Tablename & "', null, '" & saveXML & "'"
            contentofSaveString = "exec api.[save] '" & curHostGUID & "', '" & Tablename & "', null, '" & saveXML & "'"
        Else
            If mainguid.IndexOf(",") > 0 Then
                Stop
                'should be cannot save more than one row
                'contentofSaveString &= " exec oph." & Tablename & "_save '" & mainguid.Substring(0, mainguid.IndexOf(",")) & "', '" & Session("HostGUID").ToString & "', '" & saveXML & "'"
                'mainguid = mainguid.Substring(mainguid.IndexOf(",") + 1, mainguid.Length - (mainguid.IndexOf(",") + 1))
            Else
                'contentofSaveString &= " exec api.[save] '" & Session("HostGUID").ToString & "', '" & Tablename & "', '" & mainguid & "', '" & saveXML & "'"
                contentofSaveString &= " exec api.[save] '" & curHostGUID & "', '" & Tablename & "', '" & mainguid & "', '" & saveXML & "'"
            End If
        End If

        'save file
        'Dim storedFilename As String = ""
        'If Not (f Is Nothing) AndAlso f.HasFile Then
        '    If Left(Request.Form("cfunction"), 4) = "save" Then
        '        If Dir(Server.MapPath(folder) & "\" & mainguid & "_" & f.FileName) <> "" Then
        '            Kill(Server.MapPath(folder) & "\" & mainguid & "_" & f.FileName)
        '        End If
        '        If f.FileName <> "" Then
        '            f.SaveAs(Server.MapPath(folder) & "\" & mainguid & "_" & f.FileName.Replace("'", "_").Replace("+", "_"))
        '            storedFilename = mainguid & "_" & f.FileName.Replace("'", "_").Replace("+", "_")
        '        End If
        '    End If
        'End If

        Return contentofSaveString

    End Function
    'Function populateSaveString(ByVal vp As Long, ByVal Tablename As String, Optional ByVal f As FileUpload = Nothing, Optional ByVal folder As String = "", Optional ByVal connection As String = "") As String
    '    Dim tablestr As String = "" 'syawal for padc
    '    Dim GUIDPK As String = "" 'syawal for padc
    '    Dim sqlstr As String = ""
    '    'haris
    '    'Dim connection As String = Session("ODBC")
    '    Dim isPrintHeader As Boolean = True
    '    Dim row, rowlist As String
    '    Dim lagi = Request.Form("cfunction")

    '    Tablename = Left(Tablename, 1) + "a" + Right(Tablename, (Tablename.Length) - 2)
    '    Select Case Request.QueryString("mode")
    '        Case "preview"
    '        Case "save"
    '        Case Else
    '            populateSaveString = ""
    '            Exit Function
    '    End Select

    '    If connection = "" Then
    '        'haris
    '        connection = Session("ODBC")
    '        If connection = "" Then
    '            populateSaveString = ""
    '            SignOff()
    '            Exit Function
    '        End If

    '    End If
    '    Dim GUID = Request.Form("cfunctionlist")
    '    Dim storedFilename As String = ""
    '    If Not (f Is Nothing) AndAlso f.HasFile Then
    '        If Left(Request.Form("cfunction"), 4) = "save" Then
    '            If Dir(Server.MapPath(folder) & "\" & GUID & "_" & f.FileName) <> "" Then
    '                Kill(Server.MapPath(folder) & "\" & GUID & "_" & f.FileName)
    '            End If
    '            If f.FileName <> "" Then
    '                f.SaveAs(Server.MapPath(folder) & "\" & GUID & "_" & f.FileName.Replace("'", "_").Replace("+", "_"))
    '                storedFilename = GUID & "_" & f.FileName.Replace("'", "_").Replace("+", "_")
    '            End If
    '        End If
    '    End If

    '    Dim GUIDstr1 As String
    '    If GUID = "" Then
    '        GUIDstr1 = "null"
    '    Else
    '        GUIDstr1 = "'" & GUID & "'"
    '    End If

    '    If (Request.QueryString("new") = 1 And Not IsPostBack()) And Not IsPostBack() Then
    '        If sqlstr = "" Then
    '            sqlstr = "exec oph." & Tablename & "_select " & GUIDstr1 & ", '" & Session("hostGUID") & "', 2"
    '        End If
    '    Else
    '        If sqlstr = "" Then
    '        End If

    '    End If

    '    Dim GUIDstr As String
    '    If GUID = "" Then
    '        GUIDstr = "null"
    '    Else
    '        GUIDstr = "'" & GUID & "'"
    '    End If
    '    sqlstr = "exec oph." & Tablename & "_select " & GUIDstr & ", '" & Session("hostGUID") & "', 1"

    '    Dim dssetup As DataSet = SelectSqlSrvRows(connection, sqlstr)

    '    Dim c As DataRow

    '    Dim rowno, colno As Long
    '    Dim lastrowno, lastcolno As Long
    '    Dim mainguid As String
    '    Dim extra As String = ""
    '    Dim dot As Boolean
    '    Dim requestvalue As String
    '    Dim dec, separator As String
    '    If languagemode = "EN" Then
    '        dec = ","
    '        separator = "."
    '    Else
    '        dec = "."
    '        separator = ","
    '    End If
    '    lastrowno = 1
    '    lastcolno = 1
    '    rowno = 1
    '    colno = 1

    '    mainguid = Request.Form("cfunctionlist")
    '    rowlist = Request.Form("crownolist")
    '    If mainguid Is Nothing Then
    '    Else
    '        Do
    '            If rowlist.IndexOf(",") > 0 Then
    '                row = rowlist.Substring(0, rowlist.IndexOf(","))
    '                rowlist = rowlist.Substring(rowlist.IndexOf(",") + 1, rowlist.Length - (rowlist.IndexOf(",") + 1))
    '            Else
    '                row = rowlist
    '            End If
    '            If mainguid = "" Or Request.Form("gen_newid") = "1" Then
    '                contentofSaveString = " exec oph." & Tablename & "_save null, '" & Session("HostGUID").ToString & "'"
    '            Else
    '                If mainguid.IndexOf(",") > 0 Then
    '                    contentofSaveString &= " exec oph." & Tablename & "_save '" & mainguid.Substring(0, mainguid.IndexOf(",")) & "', '" & Session("HostGUID").ToString & "'"
    '                    mainguid = mainguid.Substring(mainguid.IndexOf(",") + 1, mainguid.Length - (mainguid.IndexOf(",") + 1))
    '                Else
    '                    contentofSaveString &= " exec oph." & Tablename & "_save '" & mainguid & "', '" & Session("HostGUID").ToString & "'"
    '                    'Stop
    '                    If Request.Form("cfunction") = "save" Then
    '                        GUID = mainguid
    '                    End If
    '                End If
    '            End If
    '            'contentofSaveString &= ",'"  "'"
    '            Dim colName As String
    '            For Each c In dssetup.Tables(0).Rows
    '                colName = c.Item("colname")
    '                extra = ""
    '                dot = True
    '                If findProperty(dssetup, colName, "combotype") = "5" And findProperty(dssetup, colName, "isViewable") = "1" And Not IsNothing(Request.Form(Replace(colName, "_", "#95#"))) Then
    '                    contentofSaveString &= ",'" & Server.MapPath(folder) & mainguid & "_" & Request.Form(Replace(colName, "_", "#95#")).ToString.Substring(Request.Form(Replace(colName, "_", "#95#")).LastIndexOf("\") + 1) & "'"
    '                    'If Tablename = "TaPADDCOUN" Then
    '                    '    Dim attachment = "../../welcome/defaultindex.aspx?mode=view&tablename=taPADC&GUID=".ToString
    '                    '    Dim GUIDFK = ("select PADDGUID where PADDGUID='" & GUID & "'").ToString
    '                    '    tablestr &= "<span id=""" & colName & """><a href=""javascript:popTo('" & attachment & "" & GUIDPK & "')"">View</a></span>"
    '                    'End If
    '                ElseIf findProperty(dssetup, colName, "isEditable") = 3 Then
    '                    contentofSaveString &= ",'" & Request.Form("cid") & "'"
    '                    'contentofSaveString &= ",'" & GUID & "'"

    '                ElseIf findProperty(dssetup, colName, "isEditable") > 0 And findProperty(dssetup, colName, "ViewRowTypeOrder") = "" And findProperty(dssetup, colName, "ViewRowType") <> "" And findProperty(dssetup, colName, "ViewPageNo") = "1" Then
    '                    'contentofSaveString &= ",'" & Request.Form("cid") & "'"
    '                    contentofSaveString &= ",'" & Request.Form(Replace(colName, "_", "#95#")) & "'"

    '                ElseIf findProperty(dssetup, colName, "isEditable") <> 0 And findProperty(dssetup, colName, "isEditable") <> 99 And findProperty(dssetup, colName, "isEditable") <> 98 Then
    '                    'ElseIf findProperty(dssetup, colName, "isEditable") <> 99 And findProperty(dssetup, colName, "isEditable") <> 98 And findProperty(dssetup, colName, "viewcolorder") = "1" Then
    '                    If findProperty(dssetup, colName, "isbrowsable").ToString = "2" Then
    '                        extra = ""
    '                    End If

    '                    requestvalue = Request.Form(Replace(colName, "_", "#95#") & extra & row)
    '                    If requestvalue Is Nothing Then
    '                        requestvalue = ""
    '                    End If

    '                    Select Case findProperty(dssetup, colName, "xtype")
    '                        Case 104 'boolean
    '                            If Request.Form(Replace(colName, "_", "#95#") & extra & row) = "on" Then
    '                                'requestvalue = requestvalue.Replace(separator, "")
    '                                'requestvalue = requestvalue.Replace(dec, ".")
    '                                contentofSaveString &= ", 1"
    '                            Else
    '                                contentofSaveString &= ", 0"
    '                            End If

    '                        Case 48, 52, 56, 59, 62, 106, 108, 127, 265, 262 'numeric
    '                            If Request.Form(Replace(colName, "_", "#95#") & extra & row) <> "" Then
    '                                requestvalue = requestvalue.Replace(separator, "")
    '                                requestvalue = requestvalue.Replace(dec, ".")
    '                                contentofSaveString &= ", " & requestvalue
    '                            Else
    '                                contentofSaveString &= ", 0"
    '                            End If
    '                        Case 60, 122, 257, 263   'currency
    '                            If Request.Form(Replace(colName, "_", "#95#") & extra & row) <> "" Then
    '                                requestvalue = requestvalue.Replace(separator, "")
    '                                requestvalue = requestvalue.Replace(dec, ".")
    '                                contentofSaveString &= ", " & CDec(Val(requestvalue))
    '                            Else
    '                                contentofSaveString &= ", 0"
    '                            End If
    '                        Case 36, 270    'guid
    '                            If Request.Form(Replace(colName, "_", "#95#") & extra & row) <> "" Then
    '                                If Request.Form(Replace(colName, "_", "#95#") & extra & row) <> "," Then
    '                                    requestvalue = requestvalue.Replace(separator, "")
    '                                    contentofSaveString &= ", '" & requestvalue.ToString.Replace("'", "''") & "'"
    '                                Else
    '                                    contentofSaveString &= ", null"
    '                                End If

    '                            Else
    '                                contentofSaveString &= ", null"
    '                            End If
    '                        Case 58, 61 'date
    '                            If requestvalue = "" Or requestvalue Is Nothing Then
    '                                contentofSaveString &= ", null"
    '                            Else
    '                                contentofSaveString &= ", '" & requestvalue.ToString.Replace("'", "''") & "'"
    '                            End If

    '                        Case 175, 239, 231, 167 'text
    '                            If requestvalue Is Nothing Then
    '                            Else
    '                                'ModifiedBy eLs
    '                                Dim colSave = requestvalue.Replace("&lt;", "<")
    '                                contentofSaveString &= ", '" & colSave.ToString.Replace("'", "''") & "'"
    '                            End If

    '                        Case Else   'number any else
    '                            If requestvalue Is Nothing Then
    '                            Else
    '                                requestvalue = requestvalue.Replace(separator, "")
    '                                requestvalue = requestvalue.Replace(dec, ".")
    '                                contentofSaveString &= ", '" & requestvalue.ToString.Replace("'", "''") & "'"
    '                            End If
    '                    End Select

    '                End If
    '            Next
    '            If mainguid = "" Or mainguid.IndexOf(",") < 1 Then
    '                Exit Do
    '            End If
    '        Loop
    '    End If
    '    Return contentofSaveString


    'End Function

    Private Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Session("hostGUID") = "" Then
            'SignOff()
            'Stop
        End If
    End Sub
End Class
