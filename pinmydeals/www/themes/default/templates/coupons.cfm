<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">My Account</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Coupons</span> 
</div>
<cfinclude template="myaccount_sidenav.cfm" />
<div id="myaccount-content">
	<strong>My Coupons</strong>
	<div style="margin-top:20px;">
		<div class="myaccount-table" >
			<table >
				<tr>
					<td>Coupon Code</td>
					<td>Description</td>
					<td>Status</td>
					<td></td>
				</tr>
				<cfif ArrayLen(REQUEST.pageData.customer.getActiveCoupons()) GT 0>
					<cfloop array="#REQUEST.pageData.customer.getCoupons()#" index="coupon">
						<tr>
							<td>#coupon.getCode()#</td>
							<td>#coupon.getDescription()#</td>
							<td>#coupon.getCurrentStatus()#</td>
							<td><a href="coupon_detail.cfm?id=#coupon.getCouponId()#">Detail</a></td>
						</tr>
					</cfloop>
				<cfelse>
				<tr>
					<td colspan="4">No product found.</td>
				</tr>
				</cfif>
			</table>
		</div>
		
		<div style="clear:both;"></div>
	</div>
</div>
</cfoutput>