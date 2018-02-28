<%@ Page Language="VB" AutoEventWireup="false" CodeFile="index.aspx.vb"
    Inherits="index" %>

<!DOCTYPE html>
<html>
<!--html manifest="manifest.aspx"-->
<head>
    <title>OPERAHOUSE</title>
    <meta http-equiv="X-UA-Compatible" content="IE=EDGE" />
    <%=contentOfScripts %>

    <script type="text/javascript" charset="utf-8">
        $(document).ready(function () {
           

            <%=wordofWindowOnLoad%>
        });
    </script>
</head>
<body class="">
    <div class="wrapper" id="frameMaster"></div>
    <%--    <form id="ophForm" method="post" runat="server">
        <div id="frameMaster">Loading. Please wait...</div>
        <div id="frameBrowse"></div>
    </form>--%>
</body>
</html>
