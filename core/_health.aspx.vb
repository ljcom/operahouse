Partial Class _health
    'Inherits System.Web.UI.Page
    Inherits cl_base
    Protected result As String = "0"
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim appSettings As NameValueCollection = ConfigurationManager.AppSettings
        Dim contentOfsequoiaCon = appSettings.Item("sequoia")
        Dim ip = GetIPAddress(My.Computer.Name.ToString)
        Dim sqlstr = "select status from node where nodeIP='" & ip.ToString & "'"
        result = runSQLwithResult(sqlstr, contentOfsequoiaCon).ToString
        If result <> "400" Then
            sqlstr = "update node set status=400 where status<>500 and nodename='" & My.Computer.Name.ToString & "'"
            runSQL(sqlstr, contentOfsequoiaCon)
        End If
    End Sub
    Private Function GetIPAddress(strHostName) As String

        Dim strIPAddress As String

        'strHostName = System.Net.Dns.GetHostName()
        strIPAddress = Net.Dns.GetHostByName(strHostName).AddressList(0).ToString()
        Return strIPAddress

    End Function
End Class