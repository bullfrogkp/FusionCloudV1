<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Review</a>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-9 col-sm-push-3">
			<div class="information-blocks">
				<div class="row">
					<div class="col-md-12 information-entry">
						<div class="article-container style-1">
							<p><h5>Review</h5></p>
							<div class="table-responsive">
								<table class="profile-table">
									<tr>
										<th>Review No.</th>
										<th>Product</th>
										<th>Subject</th>
										<th></th>
									</tr>
									<cfif ArrayLen(REQUEST.pageData.customer.getActiveReviews()) GT 0>
										<cfloop array="#REQUEST.pageData.customer.getActiveReviews()#" index="review">
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
						</div>
					</div>
				</div>
			</div>
		</div>
		<cfinclude template="nav.cfm" />
	</div>
</div>
</cfoutput>