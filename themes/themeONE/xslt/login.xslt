<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:template match="/">

    <script>
      <!--loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/bootstrap/css/bootstrap.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/styles/font-awesome-4.7.0/css/font-awesome.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/daterangepicker/daterangepicker.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/datepicker/datepicker3.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/iCheck/all.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/colorpicker/bootstrap-colorpicker.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/timepicker/bootstrap-timepicker.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/select2/select2.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/admin-LTE/css/AdminLTE.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/admin-LTE/css/skins/_all-skins.min.css');
      loadStyle('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/styles/custom-me.css');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/jQuery/jquery-2.2.3.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/bootstrap/js/bootstrap.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/input-mask/jquery.inputmask.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/input-mask/jquery.inputmask.date.extensions.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/input-mask/jquery.inputmask.extensions.js');
      loadScript('https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js');

      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/datepicker/bootstrap-datepicker.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/colorpicker/bootstrap-colorpicker.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/timepicker/bootstrap-timepicker.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/slimScroll/jquery.slimscroll.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/iCheck/icheck.min.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/fastclick/fastclick.js');
      loadScript('OPHContent/themes/<xsl:value-of select="/sqroot/header/info/themeFolder" />/scripts/admin-LTE/js/demo.js');-->
      loadScript('OPHContent/themes/themeONE/scripts/admin-LTE/js/app.min.js');

      document.title='<xsl:value-of select="/sqroot/header/info/title"/>';
      <!--loadContent();-->
    </script>
    
    <div class="wrapper" style="background: rgba(38, 44, 44, 0.1);">

      <header class="main-header">
        <!-- Logo -->
        <a href="javascript:goHome();" class="logo visible-phone" style="text-align:left;">

        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top">
          <div id ="button-menu-phone"  class="" style="color:white;margin:0; display:inline-table; margin-top:5px; margin-left:10px" data-toggle="collapse" data-target="#demo5">
            <a href="#" style="color:white;">
              <span>
                <img width="30" style="margin-top:-9px;" alt="Logo Image" id="logoimg"/>
              <script>
                $("#logoimg").attr("src","OPHContent/themes/"+loadThemeFolder()+"/images/oph4_logo.png");
              </script>
                </span>
              <span style="font-size:25px;">
                <xsl:value-of select="sqroot/header/info/company"/>
              </span>
            </a>
          </div>
        </nav>
      </header>


      <!-- *** LOGIN MODAL END *** -->
      <!-- *** NOTIFICATION MODAL -->
      <div id="notiModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

          <!-- Modal content-->
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&#215;</button>
              <h4 class="modal-title" id="notiTitle">Modal Header</h4>
            </div>
            <div class="modal-body" id="notiContent">
              <p>Some text in the modal.</p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
          </div>

        </div>
      </div>
      <!-- *** NOTIFICATION MODAL END -->
      
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper" style="background:white">

        <!-- Main content -->
        <section class="content">
          <div class="row">
            <div class="col-md-6">
              <h1 style="font-size:40px; font-weight:bold">
                WELCOME TO <br/>
                <xsl:value-of select="sqroot/header/info/company"/>&#160;
              </h1>

              <h3>SIGN IN</h3>
              <!--<div style="text-align:center">
             <button class="btn btn-orange-a">WINDOWS CONNECT</button><br><br>
             <span> or </span>
          </div><br>-->
              <h4 style="color:gray">Please enter your username and password</h4>
              <form id="formlogin" onsubmit ="return signIn();">
                <div class="form-group enabled-input">
                  <label>User Name</label>
                  <input type="text" class="form-control" name ="userid" id ="userid" autofocus="autofocus" onkeypress="return checkenter(event)"/>
                </div>
                <div class="form-group enabled-input">
                  <label>Password</label>
                  <input type="password" class="form-control" name ="pwd" id ="pwd" onkeypress="return checkenter(event)"/>
                </div>
                <br/>
                
              </form>
              <div style="text-align:center">
                <button class="btn btn-orange-a" onclick="signIn();">SUBMIT</button>&#160;
                <button class="btn btn-gray-a" onclick="clearLoginText();">CLEAR</button>
              </div>
            </div>
            <!--<div class="col-md-6">
              <div style="margin-top:100px;"></div>
              <h3>FORGOT PASSWORD</h3>
              <br/>
              <form>
                <div class="form-group enabled-input">
                  <label>E-Mail Address</label>
                  <input type="email" class="form-control" />
                </div>
                <br/>
                <div style="text-align:center">
                  <button class="btn btn-orange-a">SUBMIT</button>
                </div>
                <br/>
                <br/>

              </form>
            </div>-->
          </div>
        </section>
        <!-- /.content -->
      </div>
      <!-- /.content-wrapper -->
      <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Version</b> 4.0
        </div>
        <strong>
          Copyright &#169; 2017 <a href="#">Operahouse</a>.
        </strong> All rights
        reserved.
      </footer>

    </div>
    <!-- ./wrapper -->

    <!-- jQuery 2.2.3 -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>

    <script>

      function checkenter(e) {
      if (e.keyCode == 13) {
      signIn();
      //checklogin();
      }
      }

      <!--function checklogin()
      {
      var uid = document.getElementById("userid").value;
      var pwd = document.getElementById("pwd").value;

      var dataForm = $('#signinForm').serialize() //.split('_').join('');

      var dfLength = dataForm.length;
      dataForm = dataForm.substring(2, dfLength);
      dataForm = dataForm.split('%3C').join('%26lt%3B');
      path = "OPHCore/api/default.aspx?mode=signin&amp;userid=" + uid + "&amp;pwd=" + pwd;

      $.ajax({
      url: path,
      data: dataForm,
      type: 'POST',
      dataType: "xml",
      timeout: 80000,
      beforeSend: function () {
      //setCursorWait(this);
      },
      success: function (data) {
      var x = $(data).find("sqroot").children().each(function () {
      var msg = $(this).text();
      if (msg != '') {
      if ($(this)[0].nodeName == "hostGUID")
      {
      lastPar=getCookie('lastPar');
      //setCookie('lastPar', '');
      if (lastPar=="") lastPar="?";
      window.location = lastPar;
      }
      }
      else {
      showMessage('Invalid User or password!');
      }
      });
      }
      });

      }-->


      function goToALL(name){
      window.location.assign("browse.html")
      // alert("goToALL");
      }
    </script>
    <!-- jQuery UI 1.11.4 -->
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <!--<script>
      $.widget.bridge('uibutton', $.ui.button);
    </script>-->
    <!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Morris.js charts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="plugins/morris/morris.min.js"></script>
    <!-- Sparkline -->
    <script src="plugins/sparkline/jquery.sparkline.min.js"></script>
    <!-- jvectormap -->
    <script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
    <script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
    <!-- jQuery Knob Chart -->
    <script src="plugins/knob/jquery.knob.js"></script>
    <!-- daterangepicker -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
    <!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- Bootstrap WYSIHTML5 -->
    <script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
    <!-- Slimscroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
    <script src="dist/js/pages/dashboard.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="dist/js/demo.js"></script>
  </xsl:template>
</xsl:stylesheet>
