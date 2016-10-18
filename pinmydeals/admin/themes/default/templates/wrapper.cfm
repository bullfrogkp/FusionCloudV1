<cfoutput>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>#REQUEST.pageData.title#</title>
		<meta name="author" content="Bullfrog Design">
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <!-- bootstrap 3.0.2 -->
        <link href="#SESSION.absoluteUrlThemeAdmin#css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="#SESSION.absoluteUrlThemeAdmin#css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="#SESSION.absoluteUrlThemeAdmin#css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- Morris chart -->
        <link href="#SESSION.absoluteUrlThemeAdmin#css/morris/morris.css" rel="stylesheet" type="text/css" />
        <!-- jvectormap -->
        <link href="#SESSION.absoluteUrlThemeAdmin#css/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
        <!-- Date Picker -->
        <link href="#SESSION.absoluteUrlThemeAdmin#css/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />
        <!-- Daterange picker -->
        <link href="#SESSION.absoluteUrlThemeAdmin#css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
        <!-- Theme style -->
        <link href="#SESSION.absoluteUrlThemeAdmin#css/AdminLTE.css" rel="stylesheet" type="text/css" />
		 <!-- DATA TABLES -->
        <link href="#SESSION.absoluteUrlThemeAdmin#css/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
		
		<link rel="stylesheet" type="text/css" href="#SESSION.absoluteUrlThemeAdmin#css/jquery.ui.plupload.css">
		<link rel="stylesheet" type="text/css" href="#SESSION.absoluteUrlThemeAdmin#css/custom.css">
		<link rel="stylesheet" type="text/css" href="#SESSION.absoluteUrlThemeAdmin#css/bootstrap-colorpicker.min.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="#SESSION.absoluteUrlThemeAdmin#js/html5shiv.js"></script>
          <script src="#SESSION.absoluteUrlThemeAdmin#js/respond.min.js"></script>
        <![endif]-->
		  <!-- jQuery 2.0.2 -->
        <script src="#SESSION.absoluteUrlThemeAdmin#js/jquery.min.js"></script>
    </head>
    <body class="skin-blue">
        <!-- header logo: style can be found in header.less -->
        <header class="header">
            <a href="index.cfm" class="logo">
                <!-- Add the class icon to your logo image or logo icon to add the margining -->
                Admin Panel
            </a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="##" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <div class="navbar-right">
					 <ul class="nav navbar-nav">
                        <!-- Messages: style can be found in dropdown.less-->
                        <li class="dropdown messages-menu">
                            <a href="##" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-envelope"></i>
                                <span class="label label-success">4</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">You have 4 messages</li>
                                <li>
                                    <!-- inner menu: contains the actual data -->
                                    <ul class="menu">
                                        <li><!-- start message -->
                                            <a href="##">
                                                <div class="pull-left">
                                                    <img src="#SESSION.absoluteUrlThemeAdmin#img/avatar3.png" class="img-circle" alt="User Image"/>
                                                </div>
                                                <h4>
                                                    Support Team
                                                    <small><i class="fa fa-clock-o"></i> 5 mins</small>
                                                </h4>
                                                <p>Why not buy a new awesome theme?</p>
                                            </a>
                                        </li><!-- end message -->
                                        <li>
                                            <a href="##">
                                                <div class="pull-left">
                                                    <img src="#SESSION.absoluteUrlThemeAdmin#img/avatar2.png" class="img-circle" alt="user image"/>
                                                </div>
                                                <h4>
                                                    AdminLTE Design Team
                                                    <small><i class="fa fa-clock-o"></i> 2 hours</small>
                                                </h4>
                                                <p>Why not buy a new awesome theme?</p>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="##">
                                                <div class="pull-left">
                                                    <img src="#SESSION.absoluteUrlThemeAdmin#img/avatar.png" class="img-circle" alt="user image"/>
                                                </div>
                                                <h4>
                                                    Developers
                                                    <small><i class="fa fa-clock-o"></i> Today</small>
                                                </h4>
                                                <p>Why not buy a new awesome theme?</p>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="##">
                                                <div class="pull-left">
                                                    <img src="#SESSION.absoluteUrlThemeAdmin#img/avatar2.png" class="img-circle" alt="user image"/>
                                                </div>
                                                <h4>
                                                    Sales Department
                                                    <small><i class="fa fa-clock-o"></i> Yesterday</small>
                                                </h4>
                                                <p>Why not buy a new awesome theme?</p>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="##">
                                                <div class="pull-left">
                                                    <img src="#SESSION.absoluteUrlThemeAdmin#img/avatar.png" class="img-circle" alt="user image"/>
                                                </div>
                                                <h4>
                                                    Reviewers
                                                    <small><i class="fa fa-clock-o"></i> 2 days</small>
                                                </h4>
                                                <p>Why not buy a new awesome theme?</p>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="footer"><a href="##">See All Messages</a></li>
                            </ul>
                        </li>
                        <!-- Notifications: style can be found in dropdown.less -->
                        <li class="dropdown notifications-menu">
                            <a href="##" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-warning"></i>
                                <span class="label label-warning">10</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">You have 10 notifications</li>
                                <li>
                                    <!-- inner menu: contains the actual data -->
                                    <ul class="menu">
                                        <li>
                                            <a href="##">
                                                <i class="ion ion-ios7-people info"></i> 5 new members joined today
                                            </a>
                                        </li>
                                        <li>
                                            <a href="##">
                                                <i class="fa fa-warning danger"></i> Very long description here that may not fit into the page and may cause design problems
                                            </a>
                                        </li>
                                        <li>
                                            <a href="##">
                                                <i class="fa fa-users warning"></i> 5 new members joined
                                            </a>
                                        </li>

                                        <li>
                                            <a href="##">
                                                <i class="ion ion-ios7-cart success"></i> 25 sales made
                                            </a>
                                        </li>
                                        <li>
                                            <a href="##">
                                                <i class="ion ion-ios7-person danger"></i> You changed your username
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="footer"><a href="##">View all</a></li>
                            </ul>
                        </li>
                        <!-- Tasks: style can be found in dropdown.less -->
                        <li class="dropdown tasks-menu">
                            <a href="##" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-tasks"></i>
                                <span class="label label-danger">9</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">You have 9 tasks</li>
                                <li>
                                    <!-- inner menu: contains the actual data -->
                                    <ul class="menu">
                                        <li><!-- Task item -->
                                            <a href="##">
                                                <h3>
                                                    Design some buttons
                                                    <small class="pull-right">20%</small>
                                                </h3>
                                                <div class="progress xs">
                                                    <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">20% Complete</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li><!-- end task item -->
                                        <li><!-- Task item -->
                                            <a href="##">
                                                <h3>
                                                    Create a nice theme
                                                    <small class="pull-right">40%</small>
                                                </h3>
                                                <div class="progress xs">
                                                    <div class="progress-bar progress-bar-green" style="width: 40%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">40% Complete</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li><!-- end task item -->
                                        <li><!-- Task item -->
                                            <a href="##">
                                                <h3>
                                                    Some task I need to do
                                                    <small class="pull-right">60%</small>
                                                </h3>
                                                <div class="progress xs">
                                                    <div class="progress-bar progress-bar-red" style="width: 60%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">60% Complete</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li><!-- end task item -->
                                        <li><!-- Task item -->
                                            <a href="##">
                                                <h3>
                                                    Make beautiful transitions
                                                    <small class="pull-right">80%</small>
                                                </h3>
                                                <div class="progress xs">
                                                    <div class="progress-bar progress-bar-yellow" style="width: 80%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">80% Complete</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li><!-- end task item -->
                                    </ul>
                                </li>
                                <li class="footer">
                                    <a href="##">View all tasks</a>
                                </li>
                            </ul>
                        </li>
                        <!-- User Account: style can be found in dropdown.less -->
                        <li class="dropdown user user-menu">
                            <a href="##" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="glyphicon glyphicon-user"></i>
                                <span>#SESSION.adminUser# <i class="caret"></i></span>
                            </a>
                            <ul class="dropdown-menu">
                                <!-- User image -->
                                <li class="user-header bg-light-blue">
                                    <img src="#SESSION.absoluteUrlThemeAdmin#img/avatar/#SESSION.adminUserAvatar#.png" class="img-circle" alt="User Image" />
                                    <p>
                                        #SESSION.adminUser# <cfif SESSION.isSuperAdmin EQ true>- Administrator</cfif>
                                    </p>
                                </li>
                                <!-- Menu Footer-->
                                <li class="user-footer">
                                    <div class="pull-left">
                                        <a href="#APPLICATION.absoluteUrlSite#user_detail.cfm?id=#SESSION.adminUserId#" class="btn btn-default btn-flat">Profile</a>
                                    </div>
                                    <div class="pull-right">
                                        <a href="#CGI.SCRIPT_NAME#?logout" class="btn btn-default btn-flat">Sign out</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
				</div>
            </nav>
        </header>
        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- Sidebar user panel 
                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="#SESSION.absoluteUrlThemeAdmin#img/avatar3.png" class="img-circle" alt="User Image" />
                        </div>
                        <div class="pull-left info">
                            <p>Hello, Rona</p>

                            <a href="##"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>-->
                    <!-- search form -->
                    <form action="##" method="get" class="sidebar-form">
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="Search..."/>
                            <span class="input-group-btn">
                                <button type='submit' name='seach' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
                            </span>
                        </div>
                    </form>
                    <!-- /.search form -->
                    <!-- sidebar menu: : style can be found in sidebar.less -->
                     <ul class="sidebar-menu">
                        <li class="index">
                            <a href="#APPLICATION.absoluteUrlSite#index.cfm">
                                <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                            </a>
                        </li>
						<li class="treeview">
                            <a href="##">
                                <i class="fa fa-bars"></i>
                                <span>Categories</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li class="categories"><a href="#APPLICATION.absoluteUrlSite#categories.cfm"><i class="fa fa-angle-double-right"></i> Categories</a></li>
                                <li class="category_detail"><a href="#APPLICATION.absoluteUrlSite#category_detail.cfm"><i class="fa fa-angle-double-right"></i> Add Category</a></li>
                            </ul>
                        </li>
						<li class="treeview">
                            <a href="##">
                                <i class="fa fa-shopping-cart"></i>
                                <span>Products</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li class="products"><a href="#APPLICATION.absoluteUrlSite#products.cfm"><i class="fa fa-angle-double-right"></i> Products</a></li>
                                <li class="product_detail"><a href="#APPLICATION.absoluteUrlSite#product_detail.cfm"><i class="fa fa-angle-double-right"></i> Add Product</a></li>
								<li class="product_groups"><a href="#APPLICATION.absoluteUrlSite#product_groups.cfm"><i class="fa fa-angle-double-right"></i> Product Groups</a></li>
                                <li class="product_group_detail"><a href="#APPLICATION.absoluteUrlSite#product_group_detail.cfm"><i class="fa fa-angle-double-right"></i> Add Product Group</a></li>
                            </ul>
                        </li>
						
						 <li class="treeview">
                            <a href="##">
                                <i class="fa fa-users"></i>
                                <span>Customers</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li class="customers"><a href="#APPLICATION.absoluteUrlSite#customers.cfm"><i class="fa fa-angle-double-right"></i> Customers</a></li>
                                <li class="customer_detail"><a href="#APPLICATION.absoluteUrlSite#customer_detail.cfm"><i class="fa fa-angle-double-right"></i> Add Customer</a></li>
                                <li class="customer_groups"><a href="#APPLICATION.absoluteUrlSite#customer_groups.cfm"><i class="fa fa-angle-double-right"></i> Customer Groups</a></li>
                                <li class="customer_group_detail"><a href="#APPLICATION.absoluteUrlSite#customer_group_detail.cfm"><i class="fa fa-angle-double-right"></i> Add Customer Group</a></li>
                            </ul>
                        </li>
						<li class="treeview">
                            <a href="##">
                                <i class="fa fa-bullhorn"></i>
                                <span>Promotions</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li class="coupons"><a href="#APPLICATION.absoluteUrlSite#coupons.cfm"><i class="fa fa-angle-double-right"></i> Coupons</a></li>
                                <li class="coupon_detail"><a href="#APPLICATION.absoluteUrlSite#coupon_detail.cfm"><i class="fa fa-angle-double-right"></i> Add Coupon</a></li>
								<li class="discount_types"><a href="#APPLICATION.absoluteUrlSite#discount_types.cfm"><i class="fa fa-angle-double-right"></i> Discount Types</a></li>
                                <li class="discount_type_detail"><a href="#APPLICATION.absoluteUrlSite#discount_type_detail.cfm"><i class="fa fa-angle-double-right"></i> Add Discount Type</a></li>
                            </ul>
                        </li>
						<li class="treeview">
                            <a href="##">
                                <i class="fa fa-envelope"></i>
                                <span>Emails</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li class="newsletters"><a href="#APPLICATION.absoluteUrlSite#newsletters.cfm"><i class="fa fa-angle-double-right"></i> Newsletters</a></li>
                                <li class="newsletter_detail"><a href="#APPLICATION.absoluteUrlSite#newsletter_detail.cfm"><i class="fa fa-angle-double-right"></i> Add Newsletter</a></li>
								<li class="system_emails"><a href="#APPLICATION.absoluteUrlSite#system_emails.cfm"><i class="fa fa-angle-double-right"></i> System Emails</a></li>
                                <li class="system_email_detail"><a href="#APPLICATION.absoluteUrlSite#system_email_detail.cfm"><i class="fa fa-angle-double-right"></i> Add System Email</a></li>
                            </ul>
                        </li>		
						<li class="treeview">
                            <a href="##">
                                <i class="fa fa-money"></i>
                                <span>Orders</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li class="orders"><a href="#APPLICATION.absoluteUrlSite#orders.cfm"><i class="fa fa-angle-double-right"></i> Orders</a></li>
                                <li class="order_detail new_order"><a href="#APPLICATION.absoluteUrlSite#new_order.cfm"><i class="fa fa-angle-double-right"></i> Add Order</a></li>
                            </ul>
                        </li>
						<li class="treeview">
                            <a href="##">
                                <i class="fa fa-comments"></i>
                                <span>Conversations</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li class="conversations"><a href="#APPLICATION.absoluteUrlSite#conversations.cfm"><i class="fa fa-angle-double-right"></i> Conversations</a></li>
                                <li class="conversation_detail"><a href="#APPLICATION.absoluteUrlSite#conversation_detail.cfm"><i class="fa fa-angle-double-right"></i> Add Conversation</a></li>
                            </ul>
                        </li>
						<li class="treeview">
                            <a href="##">
                                <i class="fa fa-user"></i>
                                <span>Users</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li class="users"><a href="#APPLICATION.absoluteUrlSite#users.cfm"><i class="fa fa-angle-double-right"></i> Users</a></li>
                                <li class="user_detail"><a href="#APPLICATION.absoluteUrlSite#user_detail.cfm"><i class="fa fa-angle-double-right"></i> Add User</a></li>
                            </ul>
                        </li>
						<li class="reviews">
                            <a href="#APPLICATION.absoluteUrlSite#reviews.cfm">
                                <i class="fa fa-comment"></i> <span>Reviews</span>
                            </a>
                        </li>	
						<li class="treeview">
                            <a href="##">
                                <i class="fa fa-user"></i>
                                <span>Contents</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li class="homepage"><a href="#APPLICATION.absoluteUrlSite#pages.cfm"><i class="fa fa-angle-double-right"></i> Pages</a></li>
                                <li class="site_content_detail"><a href="#APPLICATION.absoluteUrlSite#page_detail.cfm"><i class="fa fa-angle-double-right"></i> Add Page</a></li>
                            </ul>
                        </li>
                        <li class="treeview">
                            <a href="##">
                                <i class="fa fa-gear"></i>
                                <span>Settings</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li class="attributes attribute_detail"><a href="#APPLICATION.absoluteUrlSite#attributes.cfm"><i class="fa fa-angle-double-right"></i> Attributes</a></li>		
                                <li class="filters filter_detail"><a href="#APPLICATION.absoluteUrlSite#filters.cfm"><i class="fa fa-angle-double-right"></i> Filters</a></li>		
                                <li class="currencies currency_detail"><a href="#APPLICATION.absoluteUrlSite#currencies.cfm"><i class="fa fa-angle-double-right"></i> Currencies</a></li>
                                <li class="tax_information"><a href="#APPLICATION.absoluteUrlSite#tax_information.cfm"><i class="fa fa-angle-double-right"></i> Taxes</a></li>
                                <li class="site_info"><a href="#APPLICATION.absoluteUrlSite#site_info.cfm"><i class="fa fa-angle-double-right"></i> Site Info</a></li>
								<!---
								<li class="order_status_types"><a href="#APPLICATION.absoluteUrlSite#order_status_types.cfm"><i class="fa fa-angle-double-right"></i> Order Status Types</a></li>								
                                <li class="order_product_status_types"><a href="#APPLICATION.absoluteUrlSite#order_product_status_types.cfm"><i class="fa fa-angle-double-right"></i> Product Status Types</a></li>		
                                <li class="payment_methods"><a href="#APPLICATION.absoluteUrlSite#payment_methods.cfm"><i class="fa fa-angle-double-right"></i> Payment</a></li>	
                                <li class="shipping_methods"><a href="#APPLICATION.absoluteUrlSite#shipping_methods.cfm"><i class="fa fa-angle-double-right"></i> Shipping</a></li>	
                                <li class="countries"><a href="#APPLICATION.absoluteUrlSite#countries.cfm"><i class="fa fa-angle-double-right"></i> Countries</a></li>
                                <li class="provinces"><a href="#APPLICATION.absoluteUrlSite#provinces.cfm"><i class="fa fa-angle-double-right"></i> Provinces</a></li>
								--->								
                            </ul>
                        </li>
						<!---
						<li class="treeview">
                            <a href="##">
                                <i class="fa fa-bar-chart-o"></i>
                                <span>Reports</span>
                                <i class="fa fa-angle-left pull-right"></i>
                            </a>
                            <ul class="treeview-menu">
                                <li><a href="#APPLICATION.absoluteUrlSite#"><i class="fa fa-angle-double-right"></i> Sales</a></li>
                                <li><a href="#APPLICATION.absoluteUrlSite#"><i class="fa fa-angle-double-right"></i> Customers</a></li>
                                <li><a href="#APPLICATION.absoluteUrlSite#"><i class="fa fa-angle-double-right"></i> Products</a></li>
                                <li><a href="#APPLICATION.absoluteUrlSite#"><i class="fa fa-angle-double-right"></i> Reviews</a></li>
                            </ul>
                        </li>
							--->
						 <li>
                            <a href="#CGI.SCRIPT_NAME#?logout">
                                <i class="fa fa-power-off"></i> <span>Logout</span>
                            </a>
                        </li>
                    </ul>
                
                </section>
                <!-- /.sidebar -->
            </aside>

            <!-- Right side column. Contains the navbar and content of the page -->
            <aside class="right-side">
                <cfinclude template="#REQUEST.pageData.templatePath#" />
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->


      
        <!-- jQuery UI 1.10.3 -->
        <script src="#SESSION.absoluteUrlThemeAdmin#js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
        <!-- Bootstrap -->
        <script src="#SESSION.absoluteUrlThemeAdmin#js/bootstrap.min.js" type="text/javascript"></script>
       
        <!-- Sparkline -->
        <script src="#SESSION.absoluteUrlThemeAdmin#js/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
        <!-- jvectormap -->
        <script src="#SESSION.absoluteUrlThemeAdmin#js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
        <script src="#SESSION.absoluteUrlThemeAdmin#js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
        <!-- jQuery Knob Chart -->
        <script src="#SESSION.absoluteUrlThemeAdmin#js/plugins/jqueryKnob/jquery.knob.js" type="text/javascript"></script>
        <!-- daterangepicker -->
        <script src="#SESSION.absoluteUrlThemeAdmin#js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <!-- datepicker -->
        <script src="#SESSION.absoluteUrlThemeAdmin#js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
        <!-- Bootstrap WYSIHTML5 -->
        <script src="#SESSION.absoluteUrlThemeAdmin#js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
        <!-- iCheck -->
        <script src="#SESSION.absoluteUrlThemeAdmin#js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>

        <!-- AdminLTE App -->
        <script src="#SESSION.absoluteUrlThemeAdmin#js/AdminLTE/app.js" type="text/javascript"></script>
		
		
		<script src="#SESSION.absoluteUrlThemeAdmin#js/jquery-ui.js"></script>
		<script type="text/javascript" src="#SESSION.absoluteUrlThemeAdmin#js/jquery-ui2.js"></script>
		<link rel="stylesheet" type="text/css" href="#SESSION.absoluteUrlThemeAdmin#css/jquery-ui.css">
		
		<script type='text/javascript' src="#SESSION.absoluteUrlThemeAdmin#js/plupload.full.min.js"></script>
		<script type='text/javascript' src="#SESSION.absoluteUrlThemeAdmin#js/jquery.ui.plupload.min.js"></script>
		<script>
			$(document).ready(function() {
				$('.#REQUEST.pageData.currentPageName#').addClass('active');
				$('.#REQUEST.pageData.currentPageName#').parent('.treeview-menu').css('display','block');
				$('.#REQUEST.pageData.currentPageName#').parent().parent('.treeview').addClass('active');
				$(".data-table").dataTable();
			});
		</script>
		
		<!-- CK Editor -->
		<script src="#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/ckeditor.js" type="text/javascript"></script>
		 <!-- DATA TABES SCRIPT -->
        <script src="#SESSION.absoluteUrlThemeAdmin#js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="#SESSION.absoluteUrlThemeAdmin#js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>
        <script src="#SESSION.absoluteUrlThemeAdmin#js/bootstrap-colorpicker.js" type="text/javascript"></script>
		
		<script src="#SESSION.absoluteUrlThemeAdmin#js/#REQUEST.pageData.currentPageName#.js"></script>
		<script>
		<cfloop collection="#REQUEST.moduleData#" item="m">
			<cfif StructKeyExists(REQUEST.moduleData[m],"javascript")>
				#REQUEST.moduleData[m].javascript#
			</cfif>
		</cfloop>
		</script>
    </body>
</html>
</cfoutput>
