<cfoutput>
<div id="myaccount-sidenav" style="width:200px;float:left;">
	<div class="recommendation" style="width:188px;">
		My Account
	</div>
	<div class="recommendation-list" style="font-size:12px;padding-bottom:0;">
		<ul>
			<li>
				<a href="#APPLICATION.urlAdmin#myaccount/dashboard.cfm">Dashboard</a>
			</li>
			<li>
				<a href="#APPLICATION.urlAdmin#myaccount/orders.cfm">My Orders</a>
			</li>
			<li>
				<a href="#APPLICATION.urlAdmin#myaccount/addresses.cfm">My Addresses</a>
			</li>
			<li>
				<a href="#APPLICATION.urlAdmin#myaccount/reviews.cfm">My Product Reviews</a>
			</li>
			<li>
				<a href="#APPLICATION.urlAdmin#myaccount/coupons.cfm">My Coupons</a>
			</li>
			<li>
				<a href="#APPLICATION.urlAdmin#myaccount/profile.cfm">My Profile</a>
			</li>
			<li>
				<a href="#APPLICATION.urlAdmin#myaccount/change_password.cfm">Change Password</a>
			</li>
			<li style="border-bottom:none;">
				<a href="#CGI.SCRIPT_NAME#?logout">Logout</a>
			</li>
		</ul>
	</div>
</div>
</cfoutput>