<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" >
	
	<xsl:template match="/">
		<script>
			if (getCookie('isWhiteAddress') == '0' || getCookie('isWhiteAddress') == undefined || getCookie('isWhiteAddress') == '') {
				loadScript('https://www.google.com/recaptcha/api.js');
				loadScript('https://apis.google.com/js/platform.js');
			}		
		  
			if (getCookie('isWhiteAddress') == '1') {
				$('#formlogin .g-recaptcha').remove();
			}


			//signoff();

			if (getCookie("AutoUser")) {
				$('#autologin').css('display','block');
				$('#autoUser').html(getCookie("AutoUser"));
			}
			else {
			}

			$('.sidebar-toggle').click(function() {
				if ($('body').hasClass('sidebar-collapse')) $('body').removeClass('sidebar-collapse');
				else $('body').addClass('sidebar-collapse');
			});

			setCookie('<xsl:value-of select="/sqroot/header/info/account"/>_accountid', '<xsl:value-of select="/sqroot/header/info/suba"/>', 365,0,0);
			var mode=getQueryVariable("mode");
			if (mode=='' || mode==undefined) mode=2;
			var gmode='';
			if (mode=="1" &amp;&amp; getCookie('<xsl:value-of select="/sqroot/header/info/account"/>_multiAccount')!='0') {
				setCookie('<xsl:value-of select="/sqroot/header/info/account"/>_accountid', '', 365,0,0);
				$(".mode-createaccount").removeClass('hide');
				//$(".gsignup").addClass('g-signin2');
				gmode='gsignup';
			}
			if (mode=="1") {
				$(".mode-createuser").removeClass('hide');
			}

			else if (mode=="4" &amp;&amp; getQueryVariable("email")!='' &amp;&amp; getQueryVariable("email")!=undefined) $(".mode-verifyemail").removeClass('hide');
			else if (mode=="3" || (mode=="4" &amp;&amp; (getQueryVariable("email")=='' || getQueryVariable("email")==undefined))) $(".mode-forgotpassword").removeClass('hide');
			else if (mode=="5" &amp;&amp; (getQueryVariable("expired")=='1' || (getQueryVariable("email")!='' &amp;&amp; getQueryVariable("secret")!='' 
				&amp;&amp; getQueryVariable("email")!=undefined &amp;&amp; getQueryVariable("secret")!=undefined))) $(".mode-resetpassword").removeClass('hide');
			else if ((mode=="6" &amp;&amp; getCookie('<xsl:value-of select="/sqroot/header/info/account"/>_multiAccount')!='0')) {
				
				setCookie('<xsl:value-of select="/sqroot/header/info/account"/>_accountid', '', 365,0,0);
				$(".mode-chooseaccount").removeClass('hide');
			  
			}
			else {
				$(".mode-login").removeClass('hide');
				//$(".gsignin").addClass('g-signin2');
				//renderGButton('gsignin');
				gmode='gsignin';
			}
			if (getCookie('<xsl:value-of select="/sqroot/header/info/account"/>_multiAccount')!='0') $('#chooseLink').removeClass('hide');

			if (getCookie('<xsl:value-of select="/sqroot/header/info/account"/>_accountid')!='') $('.box-title').html('<xsl:value-of select="sqroot/header/info/company"/> '+getCookie('<xsl:value-of select="/sqroot/header/info/account"/>_accountid'));

			var n=new Date(Date.now());
			$('#cp').html($('#cp').html().split('#year#').join(n.getFullYear()));

			//google signin

			//window.onLoadCallback = function(){	  
			/*
			gSigninInit('##gsigninclientid##', function() {
			var a2 = gapi.auth2.getAuthInstance();
			if (a2.isSignedIn.get()) {
				a2.signOut().then(function () {
					//a2.disconnect();		
					if (gmode!='')	  renderGButton(gmode);
				});	
			}
			else if (gmode!='')	  renderGButton(gmode);

			});
			*/

			//}
			//google signin - end


			function checkEnterSignIn(e) {
			if (e.keyCode == 13) {
			signIn('<xsl:value-of select="/sqroot/header/info/account"/>');
			}}

			function checkEnterSignUp(e) {
			if (e.keyCode == 13) {
			signUp('<xsl:value-of select="/sqroot/header/info/account"/>');
			}}

			function checkEnterForgot(e) {
			if (e.keyCode == 13) {
			checkForgot('<xsl:value-of select="/sqroot/header/info/account"/>', $('#forgotemailaddress').val());
			}}

			function checkEnterVerify(e) {
			if (e.keyCode == 13) {
			checkCode('<xsl:value-of select="/sqroot/header/info/account"/>', $('#entercode').val());
			}}

			function checkEnterReset(e) {
			if (e.keyCode == 13) {
			resetPwd('<xsl:value-of select="/sqroot/header/info/account"/>', $('#resetnewpwd').val(), $('#resetconfirmpwd').val());
			}}

			function checkEnterChoose(e) {
			if (e.keyCode == 13) {
			chooseAccount('<xsl:value-of select="/sqroot/header/info/account"/>', $('#accountid').val());
			}}

			function goToChoose() {
				setCookie('<xsl:value-of select="/sqroot/header/info/account"/>_accountid', '', 1, 1, 0);
				goTo('?code=login&amp;mode=6');
			}		
		</script>

		<xsl:apply-templates select="sqroot" />
	</xsl:template>
	
	<xsl:template match="/sqroot/header">

		<section class="page-title parallax" style="background-image: url('{/sqroot/header/tag/image/.}'); ">
			<div class="title-heading">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<div class="box-title style1">
								<h2 style="color:#000000cc; margin-bottom:10px;" class="mode-login hide">
									login
								</h2>
								<h2 style="color:#000000cc; margin-bottom:10px;" class="mode-createaccount hide">
									create new account
								</h2>
								<h2 style="color:#000000cc; margin-bottom:10px;" class="mode-forgotpassword hide">
									forgot password
								</h2>				  
								<h2 style="color:#000000cc; margin-bottom:10px;" class="mode-createuser hide">
									create new user
								</h2>
								<h2 style="color:#000000cc; margin-bottom:10px;" class="mode-chooseaccount hide">
									choose account
								</h2>
								<h2 style="color:#000000cc; margin-bottom:10px;" class="mode-verifyemail hide">
									verify code from email
								</h2>	
								<h2 style="color:#000000cc; margin-bottom:10px;" class="mode-resetpassword hide">
									reset password
								</h2>						  
								<p style="color:#000000cc; font-size:25px; letter-spacing: 3px; ">
									<xsl:value-of select="code/titleTag/." />
								</p>
								<!--<div class="breadcrumbs">
								<ul>
								  <li>
									<a href="index.html" title="">Home</a>
									<i class="fa fa-angle-right" aria-hidden="true"></i>
								  </li>
								  <li>
									<a href="element.html" title="">Element</a>
									<i class="fa fa-angle-right" aria-hidden="true"></i>
								  </li>
								  <li>
									<a href="#" title="">Contact Simple</a>
								  </li>
								</ul>
								</div>-->
								<!-- /.breadcrumbs -->
							</div>
							<!-- /.box-title -->
						</div>
						<!-- /.col-md-12 -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container -->
			</div>
			<!-- /.title-heading -->
			<div class="overlay-black"></div>
		</section>
      <!-- /.page-title parallax -->
	</xsl:template>

	<xsl:template match="/sqroot/body">
		<div class="divider100" />
		<div class="flat-contact-simple">
			<div class="container">
				<div class="row mode-login hide">
					<div class="col-md-6">
						<div class="contact-classic">
							<p class="color-default" style="font-size:xx-large">
								SIGN IN
							</p>
							<!--<h2 class="font-weight-1">Please use Supplier ID to sign in</h2>-->
						</div>
						<!-- /.contact-classic -->
					</div>
					<!-- /.col-md-6 -->
					<div class="col-md-6">
						<div class="form-contact-form style3 v2 two">
							<form id="formlogin" onsubmit="return signIn('{/sqroot/header/info/account}')">
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>User ID</label>
									<input type="text" class="form-control" 
										name="userid" id="userid" autofocus="autofocus" 
										onkeypress="return checkEnterSignIn(event)"
										placeholder="Please use your ID" autocomplete="off"/>
								</div>
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>Password</label>
									<input type="password" class="form-control" name="pwd" id="pwd" autofocus="autofocus"
										onkeypress="return checkEnterSignIn(event)"
										placeholder="Please use your password" autocomplete="off"/>
								</div>
								<div class="form-group enabled-input contact-form-name contact-form">
									<a href="?code=login&amp;mode=3">Forgot Password</a><br/>
									<!--a class="hide" id="chooseLink" href="javascript:goToChoose();">Choose another account</a-->
									<a id="chooseLink" href="?code=login&amp;mode=1">Create new user</a>
								</div>
							</form>
							<br/>
							<p style="text-align:justify; font-style:italic;">
								Dengan memasuki Paroki Danau Sunter, anda telah memahami Kebijakan Privasi Paroki dan setuju bahwa informasi pribadi/gereja anda akan diperlakukan sesuai ketentuan Paroki termasuk dalam hal diproses, diungkapkan (jika diperlukan untuk tujuan yang diatur dalam Paroki), dan disimpan sesuai dengan ketentuan Paroki.
							</p>
							<div class="btn-contact-form" style="text-align:center; margin-top:20px;">
								<button id="btn_submitLogin" class="flat-button-form border-radius-2" 
									onclick="signIn('{/sqroot/header/info/account}')">SUBMIT</button>&#160;
							</div>
							<!-- /form -->
						</div>
						<!-- /.form-contact-form -->
					</div>
				</div>
				<div class="row mode-createaccount hide">
					<div class="col-md-6">
						<div class="contact-classic">
							<p class="color-default" style="font-size:xx-large">
								CREATE ACCOUNT
							</p>
							<!--<h2 class="font-weight-1">Please use Supplier ID to sign in</h2>-->
						</div>
						<!-- /.contact-classic -->
					</div>
					<!-- /.col-md-6 -->
					<div class="col-md-6">
						<div class="form-contact-form style3 v2 two">
							<form id="formcreateaccount" onsubmit="return signUp('{/sqroot/header/info/account}');">
								<h5 style="color:gray">Please enter your Account ID and Organization Name</h5>
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>Account ID</label>
									<input type="text" class="form-control" name ="newaccountid" 
										id ="newaccountid" autofocus="autofocus" 
										placeholder="Please enter Your Account ID" autocomplete="off"
										onkeypress="return checkEnterSignUp(event)"/>
								</div>
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>Organization Name</label>
									<input type="text" class="form-control" name ="companyname" 
										id ="companyname" autofocus="autofocus" 
										placeholder="Please enter Organization Name" autocomplete="off"
										onkeypress="return checkEnterSignUp(event)"/>
								</div>
								<h5 style="color:gray">Please enter your Administrator Name and Email Address</h5>
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>Your Name</label>
									<input type="text" class="form-control" name ="adminname" 
										id ="adminname" autofocus="autofocus" 
										placeholder="Please enter your name" autocomplete="off"
										onkeypress="return checkEnterSignUp(event)"/>
								</div>
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>Email Address</label>
									<input type="text" class="form-control" name ="emailaddress" 
										id ="emailaddress" autofocus="autofocus" 
										placeholder="Please enter email address" autocomplete="off"
										onkeypress="return checkEnterSignUp(event)"/>
									<!--label>New Password</label>
									<input type="password" class="form-control" name ="newpwd" id ="newpwd" autocomplete="off" placeholder="password" onkeypress="return checkEnterSignUp(event)"/>
									<label>Confirm Password</label>
									<input type="password" class="form-control" name ="confirmpwd" id ="confirmpwd" autocomplete="off" placeholder="password" onkeypress="return checkEnterSignUp(event)"/-->
								</div>
								
								<div class="g-recaptcha" data-sitekey="##recaptchakey##"></div>
								<a href="?code=login&amp;mode=6">Choose existing account</a>
							</form>
							<br/>
							<p style="text-align:justify; font-style:italic;">
								Dengan memasuki Paroki Danau Sunter, anda telah memahami Kebijakan Privasi Paroki dan setuju bahwa informasi pribadi/gereja anda akan diperlakukan sesuai ketentuan Paroki termasuk dalam hal diproses, diungkapkan (jika diperlukan untuk tujuan yang diatur dalam Paroki), dan disimpan sesuai dengan ketentuan Paroki.
							</p>
							<div class="btn-contact-form" style="text-align:center; margin-top:20px;">
								<button id="btn_submitCreateAccount" class="flat-button-form border-radius-2" 
									onclick="signUp('{/sqroot/header/info/account}');">SUBMIT</button>&#160;
							</div>
							<!-- /form -->
						</div>
						<!-- /.form-contact-form -->
					</div>			
				</div>
				<div class="row mode-chooseaccount hide">
					<div class="col-md-6">
						<div class="contact-classic">
							<p class="color-default" style="font-size:xx-large">
								CHOOSE YOUR ACCOUNTS
							</p>
							<!--<h2 class="font-weight-1">Please use Supplier ID to sign in</h2>-->
						</div>
						<!-- /.contact-classic -->
					</div>
					<!-- /.col-md-6 -->				
					<div class="col-md-6">
						<div class="form-contact-form style3 v2 two">
							<form id="formlogin" onsubmit="return signIn('{/sqroot/header/info/account}')">
								<div class="form-group enabled-input contact-form-name contact-form">
								  <label>Account ID</label>
								  <input type="text" class="form-control" name ="accountid" 
									id ="accountid" autofocus="autofocus" 
									placeholder="Please enter your acocunt ID" autocomplete="off"
									onkeypress="return checkEnterChoose(event)"/>
								</div>
							</form>
							<br/>
							<div class="btn-contact-form" style="text-align:center; margin-top:20px;">
								<button class="flat-button-form border-radius-2" id="btn_next" 
									onclick="chooseAccount('{/sqroot/header/info/account}', $('#accountid').val());">NEXT</button>&#160;
							</div>
							<!-- /form -->
						</div>
						<!-- /.form-contact-form -->
					</div>
				</div>	
				<div class="row mode-createuser hide">
					<div class="col-md-6">
						<div class="contact-classic">
							<p class="color-default" style="font-size:xx-large">
								CREATE USER
							</p>
							<!--<h2 class="font-weight-1">Please use Supplier ID to sign in</h2>-->
						</div>
						<!-- /.contact-classic -->
					</div>
					<!-- /.col-md-6 -->
					<div class="col-md-6">
						<div class="form-contact-form style3 v2 two">
							<form id="formcreateuser" onsubmit="return signUpUser('{/sqroot/header/info/account}');">
								<!--h5 style="color:gray">Please enter your Name and Email Address</h5-->
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>Your Name</label>
									<input type="text" class="form-control" name ="adminname" 
										id ="username" autofocus="autofocus" 
										placeholder="Please enter your name" autocomplete="off"
										onkeypress="return checkEnterSignUp(event)"/>
								</div>
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>Email Address</label>
									<input type="text" class="form-control" name ="emailaddress" 
										id ="emailadd" autofocus="autofocus" 
										placeholder="Please enter your email address" autocomplete="off"
										onkeypress="return checkEnterSignUp(event)"/>
								</div>
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>New Password</label>
									<input type="password" class="form-control" name ="newpwd" id ="newpwd" autocomplete="off" 
									placeholder="Please enter your password" onkeypress="return checkEnterSignUpUser(event)"/>
								</div>
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>Confirm Password</label>
									<input type="password" class="form-control" name ="confirmpwd" id ="confirmpwd" autocomplete="off" 
										placeholder="Please confirm your password" onkeypress="return checkEnterSignUpUser(event)"/>
								</div>
								<div class="g-recaptcha" data-sitekey="##recaptchakey##"></div>
							</form>
							<br/>
							<p style="text-align:justify; font-style:italic;">
								Dengan memasuki Paroki Danau Sunter, anda telah memahami Kebijakan Privasi Paroki dan setuju bahwa informasi pribadi/gereja anda akan diperlakukan sesuai ketentuan Paroki termasuk dalam hal diproses, diungkapkan (jika diperlukan untuk tujuan yang diatur dalam Paroki), dan disimpan sesuai dengan ketentuan Paroki.
							</p>
							<div class="btn-contact-form" style="text-align:center; margin-top:20px;">
								<!-- <button id="btn_submitCreateUser" class="flat-button-form border-radius-2"  -->
									<!-- onclick="signUpUser('{/sqroot/header/info/account}');">SUBMIT</button>&#160; -->
								<button id="btn_submitCreateUser" class="flat-button-form border-radius-2" 
									onclick="signUpUser('{/sqroot/header/info/account}');">SUBMIT</button>&#160;
							</div>
							<!-- /form -->
						</div>
						<!-- /.form-contact-form -->
					</div>			
				</div>
				<div class="row mode-forgotpassword hide">
					<div class="col-md-6">
						<div class="contact-classic">
							<p class="color-default" style="font-size:xx-large">
								FORGOT YOUR PASSWORD
							</p>
							<!--<h2 class="font-weight-1">Please use Supplier ID to sign in</h2>-->
						</div>
						<!-- /.contact-classic -->
					</div>
					<!-- /.col-md-6 -->				
					<div class="col-md-6">
						<div class="form-contact-form style3 v2 two">
							<form id="formlogin" onsubmit="return signIn('{/sqroot/header/info/account}')">
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>Email Address</label>
									<input type="text" class="form-control" name ="forgotemailaddress" 
										id ="forgotemailaddress" autofocus="autofocus" 
										placeholder="Please enter your email address" autocomplete="off"
										onkeypress="return checkEnterForgot(event)"/>
								</div>
								<div class="g-recaptcha" data-sitekey="##recaptchakey##"></div>
								<a href="?code=login">Go to sign in screen</a>
							</form>
							<br/>
							<div class="btn-contact-form" style="text-align:center; margin-top:20px;">
								<button id="btn_next" class="flat-button-form border-radius-2" 
									onclick="checkForgot('{/sqroot/header/info/account}', $('#forgotemailaddress').val());">SUBMIT</button>&#160;
							</div>
							<!-- /form -->
						</div>
						<!-- /.form-contact-form -->
					</div>		
				</div>					
				<div class="row mode-verifyemail hide">
					<div class="col-md-6">
						<div class="contact-classic">
							<p class="color-default" style="font-size:xx-large">
								VERIFY CODE FROM YOUR EMAIL
							</p>
							<!--<h2 class="font-weight-1">Please use Supplier ID to sign in</h2>-->
						</div>
						<!-- /.contact-classic -->
					</div>
					<!-- /.col-md-6 -->
					<div class="col-md-6">
						<div class="form-contact-form style3 v2 two">
							<form id="formlogin" onsubmit="return signIn('{/sqroot/header/info/account}')">
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>Code from your email</label>
									<input type="text" class="form-control" name ="entercode" 
										id ="entercode" autofocus="autofocus" 
										placeholder="Please enter your code" autocomplete="off"
										onkeypress="return checkEnterVerify(event)"/>
								</div>
								<a href="?code=login&amp;mode=3">Resend again the code</a>
							</form>
							<br/>
							<div class="btn-contact-form" style="text-align:center; margin-top:20px;">
								<button class="flat-button-form border-radius-2" 
									onclick="checkCode('{/sqroot/header/info/account}', $('#entercode').val());" id="btn_next">SUBMIT</button>&#160;
							</div>
							<!-- /form -->
						</div>
						<!-- /.form-contact-form -->
					</div>	
				</div>				
				<div class="row mode-resetpassword hide">
					<div class="col-md-6">
						<div class="contact-classic">
							<p class="color-default" style="font-size:xx-large">
								RESET PASSWORD
							</p>
							<!--<h2 class="font-weight-1">Please use Supplier ID to sign in</h2>-->
						</div>
						<!-- /.contact-classic -->
					</div>
					<!-- /.col-md-6 -->
					<div class="col-md-6">
						<div class="form-contact-form style3 v2 two">
							<form id="formlogin" onsubmit="return signIn('{/sqroot/header/info/account}')">
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>New Password</label>
									<input type="password" class="form-control" name ="resetnewpwd" 
										id ="resetnewpwd" autofocus="autofocus" 
										placeholder="Please enter your password" autocomplete="off"
										onkeypress="return checkEnterReset(event)"/>
								</div>
								<div class="form-group enabled-input contact-form-name contact-form">
									<label>Confirm Password</label>
									<input type="password" class="form-control" name ="resetconfirmpwd" 
										id="resetconfirmpwd" autofocus="autofocus" 
										placeholder="Please confirm your password" autocomplete="off"
										onkeypress="return checkEnterReset(event)"/>
								</div>
							</form>
							<br/>
							<div class="btn-contact-form" style="text-align:center; margin-top:20px;">
								<button class="flat-button-form border-radius-2" 
									onclick="resetPwd('{/sqroot/header/info/account}', $('#resetnewpwd').val(), $('#resetconfirmpwd').val());" id="btn_next">SUBMIT</button>&#160;
							</div>
							<!-- /form -->
						</div>
						<!-- /.form-contact-form -->
					</div>						
				</div>					
					<!-- /.col-md-6 -->
			</div>
				<!-- /.row -->
		</div>
			<!-- /.container -->
		  
		<div class="divider100" />
		
		<script>
		
		function checkEnterSignUpUser(e) {
			if (e.keyCode == 13) {
			signUpUser('<xsl:value-of select="/sqroot/header/info/account"/>');
			}
		}
		
		</script>
		
	</xsl:template>
	
	<xsl:include href="_base.xslt" />
</xsl:stylesheet>