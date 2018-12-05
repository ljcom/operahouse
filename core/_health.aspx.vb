Partial Class _health
    'Inherits System.Web.UI.Page
    Inherits cl_base
    Protected result As String = "0"
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim appSettings As NameValueCollection = ConfigurationManager.AppSettings
        Dim contentOfsequoiaCon = appSettings.Item("sequoia")

        Dim sqlstr = "select status from node where nodename='" & My.Computer.Name.ToString & "'"
        result = runSQLwithResult(sqlstr, contentOfsequoiaCon).ToString
        If result <> "400" Then
            sqlstr = "update node set status=400 where status<>500 and nodename='" & My.Computer.Name.ToString & "'"
            runSQL(sqlstr, contentOfsequoiaCon)
        End If
    End Sub
End Class