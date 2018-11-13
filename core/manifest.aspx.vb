
Partial Class OPH_welcome_default_master_manifest
    'Inherits System.Web.UI.Page
    Inherits cl_base

    Protected contentofCacheManifest As String
    Protected contentofLatestUpdate As String

    Private Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If getQueryVar("mode") = "json" Then
            Dim headPath = "/"
            Dim appName = "OPERAHOUSE.SYSTEMS"
            Dim appShort = "OPERAHOUSE"
            Dim logo = "oph-logo"
            Response.ContentType = "text/json"
            Response.Write("{  ""short_name"": """ & appShort & """,  ""name"": """ & appName & """,  ""icons"": [    {      ""src"": """ & logo & "-192.png"",      ""type"": ""image/png"",      ""sizes"": ""192x192""    },    {      ""src"": """ & logo & "-512.png"",      ""type"": ""image/png"",      ""sizes"": ""512x512""    }  ],  ""start_url"": """ & headPath & """,  ""background_color"": ""#3B7DA6"",  ""display"": ""standalone"",  ""scope"": """ & headPath & """,  ""theme_color"": ""#3B7DA6""}")
        Else
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            loadAccount()

            loadManifest("", "") 'pindah dari index.aspx
            'putManifest()

            contentofCacheManifest = Session("cacheManifest")
            'contentofCacheManifest &= loadOfflineData()
            contentofLatestUpdate = Session("latestCache") + 8

            Response.ContentType = "text/cache-manifest"
            Response.Write("CACHE MANIFEST" & vbCrLf & "# version " & contentofLatestUpdate & vbCrLf & "CACHE:" & vbCrLf & contentofCacheManifest & vbCrLf & vbCrLf & "NETWORK:" & vbCrLf & "*")


        End If

    End Sub

End Class
