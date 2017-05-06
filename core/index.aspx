<%@ Page Language="VB" AutoEventWireup="false" CodeFile="index.aspx.vb"
    Inherits="index" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>OPERAHOUSE</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">


    <script type="text/javascript" src="OPHCore/scripts/thirdparty/jquery-2.2.3.min.js"></script>

    <!--link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css"-->
    <script type="text/javascript" src="OPHCore/scripts/fn_general.js"></script>
    <script type="text/javascript" src="OPHCore/scripts/fn_theme.js"></script>
    <!--script type="text/javascript" src="OPHCore/scripts/jquery.toastmessage.js"></!--script-->
    <script type="text/javascript" src="OPHCore/scripts/default_theme.js" charset="utf-8"></script>
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
</html>
