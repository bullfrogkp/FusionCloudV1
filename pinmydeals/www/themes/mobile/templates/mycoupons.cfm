<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Coupon</a>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-9 col-sm-push-3">
			<div class="information-blocks">
				<div class="row">
					<div class="col-md-12 information-entry">
						<div class="article-container style-1">
							<p><h5>Coupon</h5></p>
							<div class="table-responsive">
								<table class="profile-table">
									<tr>
										<th>Coupon Code</th>
										<th>Description</th>
										<th>Status</th>
										<th></th>
									</tr>
									<cfif ArrayLen(REQUEST.pageData.customer.getActiveCoupons()) GT 0>
										<cfloop array="#REQUEST.pageData.customer.getActiveCoupons()#" index="coupon">
											<tr>
												<td>#coupon.getCode()#</td>
												<td>#coupon.getDescription()#</td>
												<td>#coupon.getCurrentStatus()#</td>
												<td><a href="coupon_detail.cfm?id=#coupon.getCouponId()#">Detail</a></td>
											</tr>
										</cfloop>
									<cfelse>
									<tr>
										<td colspan="4">No coupon found.</td>
									</tr>
									</cfif>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<cfinclude template="nav.cfm" />
	</div>
</div>
</cfoutput>