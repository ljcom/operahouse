<%@ Application Language="VB" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

    Sub Application_PreSendRequestHeaders(ByVal sender As Object, ByVal e As EventArgs)
        Response.Headers.Remove("Server")
        Response.Headers.Remove("X-AspNet-Version")
        Response.Headers.Remove("X-AspNetMvc-Version")
    End Sub

    Sub Application_BeginRequest(sender As Object, e As EventArgs)
        'turn on when live
        'Select Case Request.Url.Scheme
        '    Case "https"
        '        Response.AddHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains; preload")
        '    Case "http"
        '        Dim path = "https://" + Request.Url.Host + Request.Url.PathAndQuery
        '        Response.Status = "301 Moved Permanently"
        '        Response.AddHeader("Location", path)
        'End Select
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
        Session("init") = "1"
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub

</script>