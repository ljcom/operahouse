
Partial Class OPH_welcome_default_master_manifest
    'Inherits System.Web.UI.Page
    Inherits cl_base

    Protected contentofCacheManifest As String
    Protected contentofLatestUpdate As String

    Private Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        'loadManifest()
        'putManifest()
        contentofCacheManifest = Session("cacheManifest")
        contentofLatestUpdate = Session("latestCache")
    End Sub

End Class
