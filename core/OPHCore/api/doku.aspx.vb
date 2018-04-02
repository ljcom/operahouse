Imports System.IO
Imports System.Net
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Imports System.Xml


Partial Class OPHCore_API_midtrans

    Inherits cl_base_view

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        loadAccount()

        Dim curODBC = contentOfdbODBC
        Dim DBCore = contentOfsqDB
        Dim curHostGUID = Session("hostGUID")
        Dim curUserGUID = Session("userGUID")

        Dim sqlstr = ""
        Dim noxml = False
        'Dim isValid = False
        Dim appSettings = ConfigurationManager.AppSettings

        Dim isSingle = True
        Dim xmlstr = ""
        Dim xmlstr1 = ""

        Dim mode = getQueryVar("mode")
        If mode = "" Then
            mode = Request.Form("mode")
        End If

        Select Case mode
            Case "notify"
                Response.Write("Continue")
        End Select

    End Sub

End Class
