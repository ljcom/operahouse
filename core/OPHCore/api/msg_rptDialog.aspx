<%@ Page Language="VB" AutoEventWireup="false" CodeFile="msg_rptDialog.aspx.vb" Inherits="OPHCore_api_msg_rptDialog" %>

<html>
    <head>
        <title>Printing...</title>
    </head>
    <script src="../../OPHContent/cdn/printjs/print.min.js"></script>
    <body>
        <script>printJS('<% =pdfFile %>');
            window.onfocus=function(){ window.close();}
        </script>
    </body>
</html>