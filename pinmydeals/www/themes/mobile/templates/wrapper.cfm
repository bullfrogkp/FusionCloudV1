<cfoutput>
<!DOCTYPE html>
<html>
<head>
	<title>#REQUEST.pageData.title#</title>
	<meta name="description" content="#REQUEST.pageData.description#">
	<meta name="keywords" content="#REQUEST.pageData.keywords#">
	<meta name="author" content="Kevin Pan">
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no, minimal-ui"/>
    <link href="#SESSION.absoluteUrlTheme#css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="#SESSION.absoluteUrlTheme#css/idangerous.swiper.css" rel="stylesheet" type="text/css" />
    <link href="#SESSION.absoluteUrlTheme#css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href='http://fonts.googleapis.com/css?family=Raleway:300,400,500,600,700%7CDancing+Script%7CMontserrat:400,700%7CMerriweather:400,300italic%7CLato:400,700,900' rel='stylesheet' type='text/css' />
    <link href="#SESSION.absoluteUrlTheme#css/style.css" rel="stylesheet" type="text/css" />
    <!--[if IE 9]>
        <link href="#SESSION.absoluteUrlTheme#css/ie9.css" rel="stylesheet" type="text/css" />
    <![endif]-->
    <link rel="shortcut icon" href="#SESSION.absoluteUrlTheme#images/favicon-6.ico" />
	<cfloop collection=""
</head>
<body class="style-10">

    <!-- LOADER -->
    <div id="loader-wrapper">
        <div class="bubbles">
            <div class="title">loading</div>
            <span></span>
            <span id="bubble2"></span>
            <span id="bubble3"></span>
        </div>
    </div>

    <div id="content-block">

        <div class="content-center fixed-header-margin">
            <!-- HEADER -->
            <div class="header-wrapper style-10">
                <header class="type-1">

                    <div class="header-product">
                        <div class="logo-wrapper">
                            <a href="#APPLICATION.absoluteUrlSite#" id="logo"><img alt="" src="#SESSION.absoluteUrlTheme#images/logo-9.png"></a>
                        </div>
                        <div class="product-header-message">
                            #REQUEST.pageData.slogan#
                        </div>
                        <div class="product-header-content">
                            <div class="line-entry">
                                <div class="menu-button responsive-menu-toggle-class"><i class="fa fa-reorder"></i></div>
                                <div class="header-top-entry increase-icon-responsive open-search-popup">
                                    <div class="title"><i class="fa fa-search"></i> <span>Search</span></div>
                                </div>
                                <div class="header-top-entry increase-icon-responsive">
                                	<cfif IsNumeric(SESSION.user.customerId)>
                                    	<div class="title"><i class="fa fa-user"></i> <a href="#APPLICATION.absoluteUrlSite#myaccount/dashboard.cfm"><span>My Account</span></a></div>
                                   	<cfelse>
                                    	<div class="title"><i class="fa fa-user"></i> <a href="#APPLICATION.absoluteUrlSite#signin.cfm"><span>Sign In</span></a></div>
                               		</cfif>
                                </div>
                                <div class="header-top-entry">
                                    <div class="title"><img alt="" src="#SESSION.absoluteUrlTheme#images/ca.png">English<i class="fa fa-caret-down"></i></div>
                                    <div class="list">
                                        <a class="list-entry" href="##"><img alt="" src="#SESSION.absoluteUrlTheme#images/fr.png">French</a>
										<a class="list-entry" href="##"><img alt="" src="#SESSION.absoluteUrlTheme#images/cn.png">Chinese</a>
                                    </div>
                                </div>
                                <div class="header-top-entry">
									<form method="post">
										<div class="title">#SESSION.currency.symbol# #SESSION.currency.code# <i class="fa fa-caret-down"></i></div>
										<div class="list">
											<cfloop array="#REQUEST.pageData.currencies#" index="currency">
												<cfif currency.getCurrencyId() NEQ SESSION.currency.id>
													<a class="list-entry" href="##">#currency.getSymbolText()# #currency.getCode()#</a>
												</cfif>
											</cfloop>
										</div>
									</form>
                                </div>
                            </div>
                            <div class="middle-line"></div>
                            <div class="line-entry">
                                <a href="##" class="header-functionality-entry"><i class="fa fa-copy"></i><span>Compare</span></a>
                                <a href="#APPLICATION.absoluteUrlSite#wishlist.cfm" class="header-functionality-entry"><i class="fa fa-heart-o"></i><span>Wishlist</span></a>
                                <a href="#APPLICATION.absoluteUrlSite#cart.cfm" class="header-functionality-entry open-cart-popup"><i class="fa fa-shopping-cart"></i><span>My Cart</span> &nbsp;&nbsp;&nbsp;<b id="cart-subtotal">#REQUEST.pageData.cart.getSubTotalWCLocal()#</b></a>
                            </div>
                        </div>
                    </div>

                    <div class="close-header-layer"></div>
                    <div class="navigation">
                        <div class="navigation-header responsive-menu-toggle-class">
                            <div class="title">Navigation</div>
                            <div class="close-menu"></div>
                        </div>
                        <div class="nav-overflow">
                            <nav>
                                <ul>
									<li class="full-width">
                                        <a href="##" class="active">#REQUEST.moduleData.menu.section1.label#</a><i class="fa fa-chevron-down"></i>
                                        <div class="submenu">
                                            <div class="full-width-menu-items-right">
                                                <div class="menu-slider-arrows">
                                                    <a class="left"><i class="fa fa-chevron-left"></i></a>
                                                    <a class="right"><i class="fa fa-chevron-right"></i></a>
                                                </div>
                                                <div class="submenu-list-title"><a href="##">#REQUEST.moduleData.menu.section1.subSection3.label#</a><span class="toggle-list-button"></span></div>
                                                <div class="menu-slider-out">
                                                    <div class="menu-slider-in">
                                                        <div class="menu-slider-entry">
															<cfloop array="#REQUEST.moduleData.menu.section1.subSection3.products#" index="product">
																<div class="product-slide-entry">
																	<div class="product-image">
																		<img src="#product.image#" alt="" />
																		<div class="bottom-line left-attached">
																			<a class="bottom-line-a square"><i class="fa fa-shopping-cart"></i></a>
																			<a class="bottom-line-a square"><i class="fa fa-heart"></i></a>
																			<a class="bottom-line-a square"><i class="fa fa-retweet"></i></a>
																			<a class="bottom-line-a square"><i class="fa fa-expand"></i></a>
																		</div>
																	</div>
																	<a href="##" class="title">#product.label#</a>
																	<div class="price">
																		<div class="current">$#product.price#</div>
																	</div>
																</div>
															</cfloop>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="full-width-menu-items-left">
                                                <div class="row">
                                                    <div class="col-lg-6">
                                                        <div class="submenu-list-title"><a href="index-wide.html">#REQUEST.moduleData.menu.section1.subSection1.label#<span class="menu-label blue">new</span></a><span class="toggle-list-button"></span></div>
                                                        <ul class="list-type-1 toggle-list-container">
															<cfloop array="#REQUEST.moduleData.menu.section1.subSection1.products#" index="product">
																<li><a href="#product.href#"><i class="fa fa-angle-right"></i>#product.label#</a></li>
															</cfloop>
                                                        </ul>
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="submenu-list-title"><a href="index-wide.html">#REQUEST.moduleData.menu.section1.subSection2.label#<span class="menu-label blue">new</span></a><span class="toggle-list-button"></span></div>
                                                        <ul class="list-type-1 toggle-list-container">
                                                            <cfloop array="#REQUEST.moduleData.menu.section1.subSection2.products#" index="product">
																<li><a href="#product.href#"><i class="fa fa-angle-right"></i>#product.label#</a></li>
															</cfloop>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="submenu-links-line">
                                                <div class="submenu-links-line-container">
                                                    <div class="cell-view">
                                                        <div class="line-links"><b>Quicklinks:</b>  <cfloop array="#REQUEST.moduleData.menu.section1.subSection4.links#" index="link"><a href="#link.href#">#link.label#</a></cfloop></div>
                                                    </div>
                                                    <div class="cell-view">
                                                        <div class="red-message"><b>#REQUEST.moduleData.menu.section1.subSection5.message#</b></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="full-width">
                                        <a href="##" class="active">#REQUEST.moduleData.menu.section2.label#</a><i class="fa fa-chevron-down"></i>
                                        <div class="submenu">
                                            <div class="full-width-menu-items-right">
                                                <div class="menu-slider-arrows">
                                                    <a class="left"><i class="fa fa-chevron-left"></i></a>
                                                    <a class="right"><i class="fa fa-chevron-right"></i></a>
                                                </div>
                                                <div class="submenu-list-title"><a href="##">#REQUEST.moduleData.menu.section2.subSection3.label#</a><span class="toggle-list-button"></span></div>
                                                <div class="menu-slider-out">
                                                    <div class="menu-slider-in">
                                                        <div class="menu-slider-entry">
															<cfloop array="#REQUEST.moduleData.menu.section2.subSection3.products#" index="product">
																<div class="product-slide-entry">
																	<div class="product-image">
																		<img src="#product.image#" alt="" />
																		<div class="bottom-line left-attached">
																			<a class="bottom-line-a square"><i class="fa fa-shopping-cart"></i></a>
																			<a class="bottom-line-a square"><i class="fa fa-heart"></i></a>
																			<a class="bottom-line-a square"><i class="fa fa-retweet"></i></a>
																			<a class="bottom-line-a square"><i class="fa fa-expand"></i></a>
																		</div>
																	</div>
																	<a href="##" class="title">#product.label#</a>
																	<div class="price">
																		<div class="current">$#product.price#</div>
																	</div>
																</div>
															</cfloop>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="full-width-menu-items-left">
                                                <div class="row">
                                                    <div class="col-lg-6">
                                                        <div class="submenu-list-title"><a href="index-wide.html">#REQUEST.moduleData.menu.section2.subSection1.label#<span class="menu-label blue">new</span></a><span class="toggle-list-button"></span></div>
                                                        <ul class="list-type-1 toggle-list-container">
															<cfloop array="#REQUEST.moduleData.menu.section2.subSection1.products#" index="product">
																<li><a href="#product.href#"><i class="fa fa-angle-right"></i>#product.label#</a></li>
															</cfloop>
                                                        </ul>
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <div class="submenu-list-title"><a href="index-wide.html">#REQUEST.moduleData.menu.section2.subSection2.label#<span class="menu-label blue">new</span></a><span class="toggle-list-button"></span></div>
                                                        <ul class="list-type-1 toggle-list-container">
                                                            <cfloop array="#REQUEST.moduleData.menu.section2.subSection2.products#" index="product">
																<li><a href="#product.href#"><i class="fa fa-angle-right"></i>#product.label#</a></li>
															</cfloop>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="submenu-links-line">
                                                <div class="submenu-links-line-container">
                                                    <div class="cell-view">
                                                        <div class="line-links"><b>Quicklinks:</b>  <cfloop array="#REQUEST.moduleData.menu.section2.subSection4.links#" index="link"><a href="#link.href#">#link.label#</a></cfloop></div>
                                                    </div>
                                                    <div class="cell-view">
                                                        <div class="red-message"><b>#REQUEST.moduleData.menu.section2.subSection5.message#</b></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="full-width-columns">
                                        <a href="##">#REQUEST.moduleData.menu.section3.label#</a><i class="fa fa-chevron-down"></i>
                                        <div class="submenu">
											<cfloop array="#REQUEST.moduleData.menu.section3.categories#" index="category">
												<div class="product-column-entry">
													<div class="image"><img alt="" src="#category.image#"></div>
													<div class="submenu-list-title"><a href="contact.html">#category.label#</a><span class="toggle-list-button"></span></div>
													<div class="description toggle-list-container">
														<ul class="list-type-1">
															<cfloop array="#category.subCategories#" index="subCategory">
																<li><a href="#subCategory.href#"><i class="fa fa-angle-right"></i>#subCategory.label#</a></li>
															</cfloop>
														</ul>
													</div>
													<div class="hot-mark">hot</div>
												</div>
											</cfloop>
                                        </div>
                                    </li>
                                    <li class="column-1">
                                        <a href="blog.html">#REQUEST.moduleData.menu.section4.label#</a><i class="fa fa-chevron-down"></i>
                                        <div class="submenu">
                                            <div class="full-width-menu-items-left">
                                                <img class="submenu-background" src="#REQUEST.moduleData.menu.section4.image#" alt="" />
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="submenu-list-title"><a href="blog.html">#REQUEST.moduleData.menu.section4.label# <span class="menu-label blue">new</span></a><span class="toggle-list-button"></span></div>
                                                        <ul class="list-type-1 toggle-list-container">
															<cfloop array="#REQUEST.moduleData.menu.section4.blogs#" index="blog">
																<li><a href="#blog.href#"><i class="fa fa-angle-right"></i>#blog.label#</a></li>
															</cfloop>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="submenu-links-line">
                                                <div class="submenu-links-line-container">
                                                    <div class="cell-view">
                                                        <div class="line-links"><b>Quicklinks:</b>   <cfloop array="#REQUEST.moduleData.menu.section4.links#" index="link"><a href="#link.href#">#link.label#</a></cfloop></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
									<li class="simple-list">
                                        <a>#REQUEST.moduleData.menu.section5.label#</a><i class="fa fa-chevron-down"></i>
                                        <div class="submenu">
                                            <ul class="simple-menu-list-column">
												<cfloop array="#REQUEST.moduleData.menu.section5.links#" index="link">
													<li><a href="#link.href#"><i class="fa fa-angle-right"></i>#link.label#</a></li>
												</cfloop>
                                            </ul>
                                        </div>
                                    </li>
                                </ul>
                                <ul>
                                    <li><a href="##" style="color:##fff;">Fusion Cloud</a></li>
                                    <li class="fixed-header-visible">
                                        <a class="fixed-header-square-button open-cart-popup"><i class="fa fa-shopping-cart"></i></a>
                                        <a class="fixed-header-square-button open-search-popup"><i class="fa fa-search"></i></a>
                                    </li>
                                </ul>
                                <div class="clear"></div>

                                <a class="fixed-header-visible additional-header-logo"><img src="#SESSION.absoluteUrlTheme#images/logo-9.png" alt=""/></a>
                            </nav>
                            <div class="navigation-footer responsive-menu-toggle-class">
                                <div class="socials-box">
                                    <a href="##"><i class="fa fa-facebook"></i></a>
                                    <a href="##"><i class="fa fa-twitter"></i></a>
                                    <a href="##"><i class="fa fa-google-plus"></i></a>
                                    <a href="##"><i class="fa fa-youtube"></i></a>
                                    <a href="##"><i class="fa fa-linkedin"></i></a>
                                    <a href="##"><i class="fa fa-instagram"></i></a>
                                    <a href="##"><i class="fa fa-pinterest-p"></i></a>
                                    <div class="clear"></div>
                                </div>
                                <div class="navigation-copyright">Created by <a href="##">FusionCloud</a>. All rights reserved</div>
                            </div>
                        </div>
                    </div>
                </header>
                <div class="clear"></div>
            </div>

            <div class="content-push">

                <cfinclude template="#REQUEST.pageData.templatePath#" />           

                <!-- FOOTER -->
                <div class="footer-wrapper style-10">
                    <footer class="type-1">
                        <div class="footer-columns-entry">
                            <div class="row">
                                <div class="col-md-3">
                                    <img class="footer-logo" src="#SESSION.absoluteUrlTheme#images/logo-9.png" alt="" />
                                    <div class="footer-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.</div>
                                    <div class="footer-address">30 Yonge St. Toronto<br/>
                                        Phone: +1 123 456 789<br/>
                                        Email: <a href="mailto:support@pinmydeals.com">support@pinmydeals.com</a><br/>
                                        <a href="www.pinmydeals.com"><b>www.pinmydeals.com</b></a>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="col-md-2 col-sm-4">
                                    <h3 class="column-title">Our Services</h3>
                                    <ul class="column">
                                        <li><a href="##">FAQ</a></li>
                                        <li><a href="##">Size Charts</a></li>
                                        <li><a href="##">Order Help</a></li>
                                        <li><a href="##">Shipping & Handling</a></li>
                                        <li><a href="##">Returns & Exchanges</a></li>
                                        <li><a href="##">Track My Order</a></li>
                                        <li><a href="##">My Account</a></li>
                                    </ul>
                                    <div class="clear"></div>
                                </div>
                                <div class="col-md-2 col-sm-4">
                                    <h3 class="column-title">ABOUT US</h3>
                                    <ul class="column">
                                        <li><a href="##">Brand Protection</a></li>
                                        <li><a href="##">History</a></li>
                                        <li><a href="##">Careers</a></li>
                                        <li><a href="##">Diversity</a></li>
                                        <li><a href="##">Investors</a></li>
                                        <li><a href="##">About Us</a></li>
                                        <li><a href="##">Contact Us</a></li>
                                    </ul>
                                    <div class="clear"></div>
                                </div>
                                <div class="col-md-2 col-sm-4">
                                    <h3 class="column-title">PRIVACY & TERMS</h3>
                                    <ul class="column">
                                        <li><a href="##">Privacy</a></li>
                                        <li><a href="##">Ad Cookies</a></li>
                                        <li><a href="##">Sale Terms</a></li>
                                        <li><a href="##">Text Termse</a></li>
                                        <li><a href="##">Terms of Use</a></li>
                                        <li><a href="##">Endorsements</a></li>
                                        <li><a href="##">Site Map</a></li>
                                    </ul>
                                    <div class="clear"></div>
                                </div>
                                <div class="clearfix visible-sm-block"></div>
                                <div class="col-md-3">
                                    <h3 class="column-title">Company working hours</h3>
                                    <div class="footer-description">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.</div>
                                    <div class="footer-description">
                                        <b>Monday-Friday:</b> 8.30 a.m. - 5.30 p.m.<br/>
                                        <b>Saturday:</b> 9.00 a.m. - 2.00 p.m.<br/>
                                        <b>Sunday:</b> Closed
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </div>
                        </div>
                        <div class="footer-bottom-navigation">
                            <div class="cell-view">
                                <div class="footer-links">
                                    <a href="##">Site Map</a>
                                    <a href="##">Search</a>
                                    <a href="##">Terms</a>
                                    <a href="##">Advanced Search</a>
                                    <a href="##">Orders and Returns</a>
                                    <a href="##">Contact Us</a>
                                </div>
                                <div class="copyright">Created with by <a href="##">FusionCloud</a>. All right reserved</div>
                            </div>
                            <div class="cell-view">
                                <div class="payment-methods">
                                    <a href="##"><img src="#SESSION.absoluteUrlTheme#images/payment-method-1.png" alt="" /></a>
                                    <a href="##"><img src="#SESSION.absoluteUrlTheme#images/payment-method-2.png" alt="" /></a>
                                    <a href="##"><img src="#SESSION.absoluteUrlTheme#images/payment-method-3.png" alt="" /></a>
                                    <a href="##"><img src="#SESSION.absoluteUrlTheme#images/payment-method-4.png" alt="" /></a>
                                    <a href="##"><img src="#SESSION.absoluteUrlTheme#images/payment-method-5.png" alt="" /></a>
                                    <a href="##"><img src="#SESSION.absoluteUrlTheme#images/payment-method-6.png" alt="" /></a>
                                </div>
                            </div>
                        </div>
                    </footer>
                </div>
            </div>

        </div>
        <div class="clear"></div>

    </div>

    <div class="search-box popup">
        <form>
            <div class="search-button">
                <i class="fa fa-search"></i>
                <input type="submit" />
            </div>
            <div class="search-drop-down">
                <div class="title"><span>All categories</span><i class="fa fa-angle-down"></i></div>
                <div class="list">
                    <div class="overflow">
						<cfloop array="#REQUEST.pageData.categories#" index="cat">
							<div class="category-entry">#cat.getDisplayName()#</div>
						</cfloop>
                    </div>
                </div>
            </div>
            <div class="search-field">
                <input type="text" value="" placeholder="Search for product" />
            </div>
        </form>
    </div>

    <div class="cart-box popup">
        <div class="popup-container">
			<cfif REQUEST.pageData.cart.getQuantity() GT 0>
				<cfloop array="#REQUEST.pageData.cart.getCartItems()#" index="item">
					<div class="cart-entry">
						<a class="image"><img src="#item.getDefaultImageURL()#" alt="" /></a>
						<div class="content">
							<a class="title" href="##">#item.getDisplayName()#</a>
							<div class="quantity">Quantity: #item.getQuantity()#</div>
							<div class="price">#item.getPrice(customerGroupId = SESSION.user.customerGroupId, currencyId = SESSION.currency.id)#</div>
						</div>
						<div class="button-x"><i class="fa fa-close"></i></div>
					</div>
				</cfloop>
				
				<div class="summary">
					<div class="subtotal">Subtotal: #REQUEST.pageData.cart.getSubTotalWCLocal()#</div>
				</div>
				<div class="cart-buttons">
					<div class="column">
						<a class="button style-3">view cart</a>
						<div class="clear"></div>
					</div>
					<div class="column">
						<a class="button style-4">checkout</a>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
			<cfelse>
				<div class="summary">
					Your cart is empty.
				</div>
			</cfif>
        </div>
    </div>
   
    <script src="#SESSION.absoluteUrlTheme#js/jquery-2.1.3.min.js"></script>
    <script src="#SESSION.absoluteUrlTheme#js/idangerous.swiper.min.js"></script>
    <script src="#SESSION.absoluteUrlTheme#js/global.js"></script>
	<script src="#SESSION.absoluteUrlTheme#js/jquery-ui.min.js"></script>

    <!-- custom scrollbar -->
    <script src="#SESSION.absoluteUrlTheme#js/jquery.mousewheel.js"></script>
    <script src="#SESSION.absoluteUrlTheme#js/jquery.jscrollpane.min.js"></script>
	<!---
	<!-- map -->
	<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false&amp;language=en"></script>
	<script src="#SESSION.absoluteUrlTheme#js/map.js"></script>
	--->
	<script src="#SESSION.absoluteUrlTheme#js/#REQUEST.pageData.currentPageName#.js"></script>
</body>
</html>
</cfoutput>