<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">My Account</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Orders</span> 
</div>
<cfinclude template="myaccount_sidenav.cfm" />
<div id="myaccount-content">
	<h1>My Orders</h1>
	<div style="margin-top:20px;">
		<div class="myaccount-table" >
			<table >
				<tr>
					<td>Order No.</td>
					<td>Name</td>
					<td>Total</td>
					<td>Create Datetime	</td>
					<td>Status</td>
					<td></td>
				</tr>
				<cfif ArrayLen(REQUEST.pageData.customer.getOrders()) GT 0>
					<cfloop array="#REQUEST.pageData.customer.getActiveOrders()#" index="order">
						<tr>
							<td>#order.getOrderTrackingNumber()#</td>
							<td>#order.getCustomerFullName()#</td>
							<td>#order.getTotalPrice()#</td>
							<td>#order.getCreatedDatetime()#</td>
							<td>#order.getCurrentOrderStatus().getOrderStatusType().getDisplayName()#</td>
							<td><a href="order_detail.cfm?id=#order.getOrderId()#">Detail</a></td>
						</tr>
					</cfloop>
				<cfelse>
					<tr>
						<td colspan="7">No order record found.</td>
					</tr>
				</cfif>
			</table>
		</div>
		<div style="clear:both;"></div>
	</div>
</div>
</cfoutput>