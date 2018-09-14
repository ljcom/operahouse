
Partial Class OPH_welcome_default_master_manifest
    'Inherits System.Web.UI.Page
    Inherits cl_base

    Protected contentofCacheManifest As String
    Protected contentofLatestUpdate As String

    Private Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        loadAccount()

        'loadManifest("", "") 'pindah dari index.aspx
        'putManifest()

        contentofCacheManifest = Session("cacheManifest")
        contentofCacheManifest &= loadOfflineData()
        contentofLatestUpdate = Session("latestCache") + 5
    End Sub

End Class
