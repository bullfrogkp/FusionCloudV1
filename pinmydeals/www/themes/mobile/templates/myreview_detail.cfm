<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Review Detail</a>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-9 col-sm-push-3">
			<div class="information-blocks">
				<form>
					<div class="row">
						<div class="col-md-12 information-entry">
							<div class="article-container style-1">
								<p><h5>Review Detail</h5></p>
								<label>Status: #REQUEST.pageData.review.getStatus().getDisplayName()#</label>
								<label>Product: #REQUEST.pageData.review.getProduct().getDisplayName()#</label>
								<label>Post At: #REQUEST.pageData.review.getCreateDatetime()#</label>
								<label>Message: #REQUEST.pageData.review.getContent()#</label>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		<cfinclude template="nav.cfm" />
	</div>
</div>
</cfoutput>