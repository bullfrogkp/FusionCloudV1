<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">My Account</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Dashboard</span> 
</div>
				
<cfinclude template="myaccount_sidenav.cfm" />
<div style="width:750px;float:right;font-size:12px;">
	<div style="line-height:18px;">
	<strong>Hello, #REQUEST.pageData.customer.getFirstName()# !</strong>
	<p>From your My Account Dashboard you have the ability to view a snapshot of your recent account activity and update your account information. Select a link below to view or edit information.</p>
	</div>
	<div style="background-color:##F2F2F2;padding:20px;">
		<ul style="margin-left:-0.5%;list-style-type:none;">
			<li style="width:29%;float:left;margin-left:0.5%;padding-right:20px;height:160px;line-height:20px;">
				<div style="font-weight:bold;padding-bottom:10px;margin-bottom:5px;border-bottom:1px solid ##CCC;">
					Contact Information
					<a style="float:right;font-size:12px;" href="#APPLICATION.urlAdmin#myaccount/profile.cfm">Edit</a>
				</div>
				
				<p style="line-height:23px;">
				<strong>Name:</strong> #REQUEST.pageData.customer.getFullName()#<br/>
				<strong>Email:</strong> #REQUEST.pageData.customer.getEmail()#<br/>
				<strong>Phone:</strong> #REQUEST.pageData.customer.getPhone()#<br/>
				<strong>Company:</strong> #REQUEST.pageData.customer.getCompany()#
				</p>
			</li>
			<li style="width:29%;float:left;margin-left:0.5%;padding-left:20px;padding-right:20px;border-left:1px solid ##CCC;height:160px;">
			
				<div style="font-weight:bold;padding-bottom:10px;margin-bottom:5px;border-bottom:1px solid ##CCC;line-height:20px;">
					Latest Order
					<a style="float:right;font-size:12px;" href="#APPLICATION.urlAdmin#myaccount/orders.cfm">View</a>
				</div>
				<p>
				<cfif NOT ArrayIsEmpty(REQUEST.pageData.latestOrderArray)>
					<p style="line-height:23px;">
					<strong>Tracking No.:</strong> #REQUEST.pageData.latestOrderArray[1].getOrderTrackingNumber()#<br/>
					<strong>Created:</strong> #REQUEST.pageData.latestOrderArray[1].getCreatedDatetime()#<br/>
					<strong>Status:</strong> #REQUEST.pageData.latestOrderStatusArray[1].getOrderStatusType().getDisplayName()#<br/>
					<strong>Total:</strong> #LSCurrencyFormat(REQUEST.pageData.latestOrderArray[1].getTotalPrice(),"international",REQUEST.pageData.latestOrderArray[1].getCurrency().getLocale())#<br/>
				<cfelse>
					No order found.
				</cfif>
				</p>
			</li>
			<li style="width:29%;float:left;margin-left:0.5%;padding-left:20px;height:160px;border-left:1px solid ##CCC;line-height:20px;">
				<div style="font-weight:bold;padding-bottom:10px;margin-bottom:5px;border-bottom:1px solid ##CCC;">
					Subscription
					<a style="float:right;font-size:12px;" href="#APPLICATION.urlAdmin#myaccount/profile.cfm">Edit</a>
				</div>
				<cfif REQUEST.pageData.customer.getSubscribed() EQ true>
					<p>You are currently subscribed to our newsletter.</p>
				<cfelse>
					<p>You haven't subscribe any newsletter yet.</p>
				</cfif>
			</li>
		</ul>
		<div style="clear:both;"></div>
	</div>
</div>
</cfoutput>