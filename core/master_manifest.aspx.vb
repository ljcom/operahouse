
Partial Class OPH_welcome_default_master_manifest
    Inherits System.Web.UI.Page
    Public contentofCacheManifest As String

    Private Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
    End Sub
End Class
