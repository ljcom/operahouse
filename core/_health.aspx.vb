Partial Class _health
    'Inherits System.Web.UI.Page
    Inherits cl_base
    Protected result As String = "0"
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim appSettings As NameValueCollection = ConfigurationManager.AppSettings
        Dim contentOfsequoiaCon = appSettings.Item("sequoia")

        Dim sqlstr = "update node set status=400 where nodename='" & My.Computer.Name.ToString & "' and status in (0,100)"
        result = runSQLwithResult(sqlstr, contentOfsequoiaCon).ToString

        Dim sqlstr = "select status from node where nodename='" & My.Computer.Name.ToString & "'"
        result = runSQLwithResult(sqlstr, contentOfsequoiaCon).ToString
    End Sub
End Class