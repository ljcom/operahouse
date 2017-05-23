<%@ Page Language="VB" AutoEventWireup="false" CodeFile="index.aspx.vb"
    Inherits="index" %>

<!DOCTYPE html>
<html>
<!--html manifest="manifest.aspx"-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>OPERAHOUSE</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <%=contentOfScripts %>

    <script type="text/javascript" charset="utf-8">
        $(document).ready(function () {
            <%=wordofWindowOnLoad%>
        });
    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini fixed">
    <div class="wrapper" id="frameMaster">
    </div>
    <%--    <form id="ophForm" method="post" runat="server">
        <div id="frameMaster">Loading. Please wait...</div>
        <div id="frameBrowse"></div>
    </form>--%>
</body>
</!--html>
