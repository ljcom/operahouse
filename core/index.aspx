<%@ Page Language="VB" AutoEventWireup="false" CodeFile="index.aspx.vb"
    Inherits="index" %>

<!DOCTYPE html>
<html> <!--manifest="manifest.aspx?mode=cache"-->
<head>
    <title>OPERAHOUSE</title>
    <meta http-equiv="X-UA-Compatible" content="IE=EDGE" />
    <link rel="manifest" href="manifest.aspx?mode=json">
    <%=contentOfScripts %>

    <script type="text/javascript" charset="utf-8">
        $(document).ready(function () {
            <%=wordofWindowOnLoad%>
        });
    </script>
</head>
<body style="background-color:#ECF0F5; class="">
	<div id="loader"></div>
    <div class="wrapper animate-bottom" id="frameMaster"></div>
    <%--    <form id="ophForm" method="post" runat="server">
        <div id="frameMaster">Loading. Please wait...</div>
        <div id="frameBrowse"></div>
    </form>--%>
    <input type="hidden" id="unique" value="<%=Now().ToString("yyyyMMddHHmmss")%>" />

</body>
</html>
