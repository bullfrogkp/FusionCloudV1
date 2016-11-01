<cfoutput>
<!DOCTYPE html>
<html>
<head>
	<title>#REQUEST.pageData.title#</title>
	<meta name="keywords" content="#REQUEST.pageData.keywords#" />
	<meta name="description" content="#REQUEST.pageData.description#" />
	
	<link rel="stylesheet" type="text/css" href="#SESSION.absoluteUrlTheme#css/style2.css" />
	<link rel="stylesheet" type="text/css" href="#SESSION.absoluteUrlTheme#css/style1.css" />
	<link rel="stylesheet" href="#SESSION.absoluteUrlTheme#css/jquery-ui.css">
	<link rel="stylesheet" href="#SESSION.absoluteUrlTheme#css/ui.easytree.css">
	<link rel="stylesheet" href="#SESSION.absoluteUrlTheme#css/custom.css">
		
	<script type="text/javascript" src="#SESSION.absoluteUrlTheme#js/modernizr.custom.28468.js"></script>
	<script type="text/javascript" src="#SESSION.absoluteUrlTheme#js/jquery-1.10.1.min.js"></script>
	<script type="text/javascript" src="#SESSION.absoluteUrlTheme#js/jquery.cslider.js"></script>
	<script src="#SESSION.absoluteUrlTheme#js/jquery-ui.js"></script>
	<script src='#SESSION.absoluteUrlTheme#js/jquery.elevatezoom.js'></script>
	<script src='#SESSION.absoluteUrlTheme#js/jquery.easytree.min.js'></script>
	
	<link rel="stylesheet" type="text/css" href="#SESSION.absoluteUrlTheme#css/jquery.fancybox.css?v=2.1.5" media="screen" />
	<script type="text/javascript" src="#SESSION.absoluteUrlTheme#js/jquery.fancybox.pack.js?v=2.1.5"></script>
	<script type="text/javascript" src="#SESSION.absoluteUrlTheme#js/jquery.fancybox-media.js?v=1.0.6"></script>
	<script type="text/javascript" src="#SESSION.absoluteUrlTheme#js/jquery.ddslick.min.js"></script>
</head>

<body>
	<div id="top-nav">
		<div class="container">
			<div id="top-info">
				<table>
					<tr>
						<td>
							<div id="top-currency-icon" style="background: url(#APPLICATION.urlAdmin#images/#SESSION.currency.code#.png) no-repeat;">
								<form method="post">
									<select name="currency_id" style="font-size:10px;margin-top:-5px;" onchange="this.form.submit()">
										<cfloop array="#REQUEST.pageData.currencies#" index="currency">
											<option value="#currency.getCurrencyId()#"
											
											<cfif currency.getCurrencyId() EQ SESSION.currency.id>
											selected
											</cfif>
											
											>#currency.getCode()#</option>
										</cfloop>
									</select>
								</form>
							</div>
						</td>
						<td style="padding-left:10px;">
							<div id="top-signin-icon"></div>
						</td>
						<td>
							<cfif IsNumeric(SESSION.user.customerId)>
								<a href="#CGI.SCRIPT_NAME#?logout">Logout</a>
							<cfelse>
								<a href="#APPLICATION.urlAdmin#login.cfm">Sign In</a> / <a href="#APPLICATION.urlAdmin#login.cfm">Create Account</a>
							</cfif>
						</td>
					</tr>
				</table>
			</div>
			<div id="cart">
				<table>
					<tr>
						<td>
							<div id="top-order-tracking-icon"></div>
						</td>
						<td><a href="#APPLICATION.urlAdmin#order_tracking.cfm">Order Tracking</a>&nbsp;&nbsp;&nbsp;</td>
						<td>
							<div id="top-myaccount-icon"></div>
						</td>
						<td>
							<cfif IsNumeric(SESSION.user.customerId)>
								<a href="#APPLICATION.urlAdmin#myaccount/dashboard.cfm">My Account</a>&nbsp;&nbsp;&nbsp;
							<cfelse>
								<a href="#APPLICATION.urlAdmin#login.cfm">My Account</a>&nbsp;&nbsp;&nbsp;
							</cfif>
						</td>
						<td>
							<div id="top-faq-icon"></div>
						</td>
						<td><a href="#APPLICATION.urlAdmin#faq.cfm">FAQs</a></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div id="header" class="container">
		<a href="#APPLICATION.urlAdmin#index.cfm"><div id="logo"></div></a>
		<div id="minicart">
			<div style="position:relative;">
				<a class="btn" href="#APPLICATION.urlAdmin#cart.cfm">Shopping Cart </a>
				<div id="cart-info">#REQUEST.pageData.shoppingCartItemTotalCount#</div>
			</div>
		</div>
		<div id="search">
			<form method="post">
			<select id="search-category" name="search_category_id">
				<option value="0">All Categories</option>
				<cfloop array="#REQUEST.pageData.categoryTree#" index="cat">
					<option value="#cat.getCategoryId()#"
					<cfif REQUEST.pageData.categoryId EQ cat.getCategoryId()>
					selected
					</cfif>
					>#RepeatString("&nbsp;",1)##cat.getDisplayName()#</option>
					<cfloop array="#cat.getSubCategories()#" index="subCat">
						<option value="#subCat.getCategoryId()#"
						<cfif REQUEST.pageData.categoryId EQ subCat.getCategoryId()>
						selected
						</cfif>
						>#RepeatString("&nbsp;",11)##subCat.getDisplayName()#</option>
						<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
							<option value="#thirdCat.getCategoryId()#"
							<cfif REQUEST.pageData.categoryId EQ thirdCat.getCategoryId()>
							selected
							</cfif>
							>#RepeatString("&nbsp;",21)##thirdCat.getDisplayName()#</option>
						</cfloop>
						</li>
					</cfloop>
					</li>
				</cfloop>
			</select>
			<input name="search_text" id="search-text" type="text" placeholder="Search..." value="#REQUEST.pageData.searchText#" />
			<input type="image" id="search-img" name="search_product" src="#SESSION.absoluteUrlTheme#images/search-img-up.png" />
			</form>
		</div>
	</div>
	<div id="nav-wrapper">
		<div id="nav">
			<div class="container">
				<ul>
					<li>
						<a href="#APPLICATION.urlAdmin#index.cfm">Home</a>
					</li>
					<li>|</li>
					<cfloop array="#REQUEST.pageData.specialCategories#" index="sc">
					<li>
						<a href="#sc.getDetailPageUrl()#">#sc.getDisplayName()#</a>
					</li>
					<li>|</li>
					</cfloop>
					<li>
						<a href="#APPLICATION.urlAdmin#view_history.cfm">View History</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	
	<div id="content-top" class="container">
		<cfinclude template="#REQUEST.pageData.templatePath#" />
	</div>
	
	<div style="clear:both;"></div>
	<div id="company-info">
		<div class="container">
			<div id="about-us">
				<h2>About Us</h2>
				<p style="font-size:12px;line-height:18px;margin:0;padding:0;">
					As a new and growing company in Canada, PinMyDeals is dedicated to be one of the best supplier of high quality products. We have our own manufactory in China with more than 15-year history and our company goal is to have the larger selection of photographic supplies around at the best prices you will find anywhere. 
				</p>
				<div id="sidebar" style="margin:12px 0 10px 0">
					<form id="signup" method="post">
						<div class="signup-header">
							<h3>Newsletter Subscription</h3>
							<p>Get the latest product and promotion information!</p>
						</div>
						<div class="inputs">
							<input name="subscribe_email" type="email" placeholder="Email" />
							<button name="subscribe_customer" id="submit" type="submit" style="cursor:hand;cursor:pointer;">SIGN UP FOR SUBSCRIPTION</button>
						</div>
					</form>
				</div>
			</div>
			<div id="secure-shopping" style="margin-bottom:14px;width:350px;float:right;">
				<h2>Secure Shopping</h2>
				<p style="font-size:12px;line-height:18px;margin:0;padding:0;margin-bottom:12px;">
					We want you to have peace of mind when shopping online at PinMyDeals. If you are not an existing PinMyDeals customer, rest assured that shopping here is safe. Our security systems use up-to-date technology embodying industry standards, and secure shopping is our priority. The PinMyDeals Secure Shopping Guarantee is our commitment to you. 
				</p>
				<img src="#SESSION.absoluteUrlTheme#images/visa1.gif">
				<img src="#SESSION.absoluteUrlTheme#images/mastercard1.gif">
				<img src="#SESSION.absoluteUrlTheme#images/amex1.gif">
				<img src="#SESSION.absoluteUrlTheme#images/paypal.gif" style="height:31px;">
			</div>
			<div style="clear:both;"></div>
		</div>
	</div>
	<div id="footer">
		<div class="container">
			<table>
				<tr>
					<td style="padding-bottom:10px;"><strong>INFORMATION</strong></td>
					<td style="width:60px;"></td>
					<td></td>
					<td style="width:60px;"></td>
					<td style="padding-bottom:10px;"><strong>COMPANY INFO</strong></td>
					<td style="width:200px;"></td>
					<td style="padding-bottom:10px;"><strong>CONNECT</strong></td>
				</tr>
				<tr>
					<td><a href="#APPLICATION.urlAdmin#site_content.cfm/payment">Payment Info</a></td>
					<td></td>
					<td><a href="#APPLICATION.urlAdmin#site_content.cfm/privacy">Privacy Policy</a></td>
					<td></td>
					<td><a href="#APPLICATION.urlAdmin#site_content.cfm/about-us">About Us</a></td>
					<td></td>
					<td rowspan="5" valign="top">
						<div>
							<a href="#APPLICATION.urlAdmin#">
							<img src="#SESSION.absoluteUrlTheme#images/facebook.png" style="width:24px;margin-right:10px;">
							</a>
							<a href="#APPLICATION.urlAdmin#">
							<img src="#SESSION.absoluteUrlTheme#images/google.png" style="width:24px;margin-right:10px;">
							</a>
							<a href="#APPLICATION.urlAdmin#">
							<img src="#SESSION.absoluteUrlTheme#images/YouTube2.png" style="width:24px;margin-right:10px;">
							</a>
							<a href="#APPLICATION.urlAdmin#">
							<img src="#SESSION.absoluteUrlTheme#images/Linkedein.png" style="width:24px;margin-right:10px;">
							</a>
							<a href="#APPLICATION.urlAdmin#">
							<img src="#SESSION.absoluteUrlTheme#images/Instagram.png" style="width:24px;">
							</a>
						</div>
						<div style="margin-top:20px;font-weight:bold;">CUSTOMER SERVICE:&nbsp;&nbsp;<span style="letter-spacing:1px;">416.666.6666</span></div>
						<div style="margin:20px 0 10px 0;">Get the latest product information!</div>
						<div style="margin:10px 0 0 0;"><input style="padding:4px 10px 4px 10px;border-radius:4px;width:230px;" type="text" name="subscription_email" placeholder="Please enter your Email" /></div>
					</td>
				</tr>
				<tr>
					<td><a href="#APPLICATION.urlAdmin#site_content.cfm/shipping">Shipping Info</a></td>
					<td></td>
					<td><a href="#APPLICATION.urlAdmin#site_content.cfm/term-of-use">Terms of Use</a></td>
					<td></td>
					<td><a href="#APPLICATION.urlAdmin#contact_us.cfm">Contact Us</a></td>
					<td></td>
				</tr>
				<tr>
					<td><a href="#APPLICATION.urlAdmin#site_content.cfm/delivery-estimate">Delivery Estimate</a></td>
					<td></td>
					<td><a href="#APPLICATION.urlAdmin#site_content.cfm/return-policy">Return Policy</a></td>
					<td></td>
					<td><a href="#APPLICATION.urlAdmin#site_content.cfm/faqs">FAQs</a></td>
					<td></td>
				</tr>
				<tr>
					<td><a href="#APPLICATION.urlAdmin#site_content.cfm/locations">Locations</a></td>
					<td></td>
					<td><a href="#APPLICATION.urlAdmin#site_content.cfm/wholesale">Wholesale</a></td>
					<td></td>
					<td><a href="#APPLICATION.urlAdmin#report_problems.cfm">Report Problems</a></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="6">
						<div id="cards">
							<img src="#SESSION.absoluteUrlTheme#images/visa1.gif">
							<img src="#SESSION.absoluteUrlTheme#images/mastercard1.gif">
							<img src="#SESSION.absoluteUrlTheme#images/amex1.gif">
							<img src="#SESSION.absoluteUrlTheme#images/paypal.gif">
						</div>
						<div id="bottom-secure-shopping">
							<a href="#APPLICATION.urlAdmin#site_content.cfm/secure-shopping" style="color:##333;">SECURE SHOPPING</a>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="6" style="padding-top:15px;">
						1998 - 2014, PinMyDeals, Inc. | <a href="#APPLICATION.urlAdmin#conditions_of_use.cfm">Conditions of Use</a> | <a href="#APPLICATION.urlAdmin#site_index.cfm">Site Index</a>
					</td>
					<td>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
</cfoutput>