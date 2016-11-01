<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Checkout</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Sign In</span> 
</div>
<form method="post">
<div id="login-wrapper">
	<div id="login-form"><!--login form-->
		<h2>Login to your account</h2>
		<table>
			<tr>
				<td colspan="2">
					<input type="text" name="username" placeholder="Username">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="password" name="password" placeholder="Password">
				</td>
			</tr>
			<tr>
				<td style="width:20px;">
					<input type="checkbox" class="checkbox">
				</td>
				<td style="font-size: 12px;">
					<div style="margin-left:-40px;float:left;">Keep me signed in</div>
					<div style="float:right;"><a href="#APPLICATION.urlAdmin#forget_password.cfm">Forget Password?</a></div>
				</td>
			</tr>
			<tr>
				<td style="padding-top:10px;">
					<input type="submit" name="checkout_login" class="btn-signup" value="Login">
				</td>
			</tr>
		</table>
	</div>
	<div id="or" style="font-size:14px;text-align:center;line-height:60px;float:left;margin:50px 50px 0 66px;width: 60px;
    height: 60px;
   border: 1px solid ##bbb;
	border-radius: 50%;-webkit-box-shadow: inset 0 1px 0 rgba(255,255,255,0.2),0 1px 2px rgba(0,0,0,0.05);
-moz-box-shadow: inset 0 1px 0 rgba(255,255,255,0.2),0 1px 2px rgba(0,0,0,0.05);
box-shadow: inset 0 1px 0 rgba(255,255,255,0.2),0 1px 2px rgba(0,0,0,0.05);
color: ##fff;
text-shadow: 0 -1px 0 rgba(0,0,0,0.25);
background-color: ##49afcd;
background-image: -moz-linear-gradient(top,##5bc0de,##2f96b4);
background-image: -webkit-gradient(linear,0 0,0 100%,from(##5bc0de),to(##2f96b4));
background-image: -webkit-linear-gradient(top,##5bc0de,##2f96b4);
background-image: -o-linear-gradient(top,##5bc0de,##2f96b4);
background-image: linear-gradient(to bottom,##5bc0de,##2f96b4);
background-repeat: repeat-x;
border-color: ##2f96b4 ##2f96b4 ##1f6377;
border-color: rgba(0,0,0,0.1) rgba(0,0,0,0.1) rgba(0,0,0,0.25);
filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='##ff5bc0de',endColorstr='##ff2f96b4',GradientType=0);
filter: progid:DXImageTransform.Microsoft.gradient(enabled=false);">
					OR
	</div>
	<div id="signup-form"><!--sign up form-->
		<h2>Guest Checkout</h2>
		<p style="font-size:12px;">Save time now. You don't need an account to checkout.</p>
		<input type="submit" name="guest_checkout" class="btn-signup" value="Continue">
	</div>
	<div style="clear:both;"></div>
</div>	
</form>
		
</cfoutput>