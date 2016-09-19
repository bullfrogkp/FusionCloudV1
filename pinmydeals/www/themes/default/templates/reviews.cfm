<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">My Account</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Reviews</span> 
</div>
			
<cfinclude template="myaccount_sidenav.cfm" />
<div id="myaccount-content">
	<strong>My Product Reviews</strong>
	<div style="margin-top:20px;">
		<div class="myaccount-table" >
			<table>
				<tr>
					<td>Review No.</td>
					<td>Product</td>
					<td>Subject</td>
					<td></td>
				</tr>
				<cfif ArrayLen(REQUEST.pageData.customer.getActiveReviews()) GT 0>
					<cfloop array="#REQUEST.pageData.customer.getReviews()#" index="review">
					<tr>
						<td>#review.getReviewId()#</td>
						<td>#review.getProduct().getDisplayName()#</td>
						<td>#review.getSubject()#</td>
						<td><a href="review_detail.cfm?id=#review.getReviewId()#">Detail</a></td>
					</tr>
					</cfloop>
				<cfelse>
					<tr>
						<td colspan="4">No review found.</td>
					</tr>
				</cfif>
			</table>
		</div>
		
		<div style="clear:both;"></div>
	</div>
</div>
		
</cfoutput>