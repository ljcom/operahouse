
Partial Class sw_offline
    Inherits cl_base

    Protected contentofSW As String
    Protected contentofLatestUpdate As String

    Private Sub sw_offline_Load(sender As Object, e As EventArgs) Handles Me.Load
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        loadAccount()
        Dim code = getQueryVar("code")
        Dim guid = getQueryVar("guid")

        contentofSW = loadOfflineData(code, guid)
        contentofLatestUpdate = Session("latestCache") + 2

        Response.ContentType = "text/javascript"
    End Sub


End Class
