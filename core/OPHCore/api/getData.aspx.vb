﻿Imports System.IO
Imports System.Net

Partial Class OPHCore_api_getData
    Inherits cl_base
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        'If getQueryVar("hostGUID") <> "" Then
        'getAccount(getQueryVar("hostGUID"), getQueryVar("env"), getQueryVar("code"), getQueryVar("GUID"))
        'Else
        'loadAccount(getQueryVar("env"), getQueryVar("code"), getQueryVar("GUID"))
        'End If



        Dim curHostGUID = getSession() 'Session("hostGUID")
        If curHostGUID = "" Then loadAccount()

        Dim curUserGUID = Session("userGUID")

        Dim curODBC = Session("ODBC")
        Dim DBCore = Session("sqDB")


        If getQueryVar("hostguid")<>"" then curHostGUID=getQueryVar("hostguid")		


        Dim mode = getQueryVar("mode")
        Dim sqlstr = "", xmlstr = ""
        Select Case mode
            Case "connect"
                Response.Write("continue")
            Case "absen"
                Dim content = ""
                content = Request.QueryString("content")
                If content <> "" Then
                    sqlstr = "exec api.getDataAbsen '" & content & "'"
                    writeLog("absen : " & sqlstr)
                    xmlstr = runSQLwithResult(sqlstr, curODBC)
                End If
        End Select

    End Sub
End Class
