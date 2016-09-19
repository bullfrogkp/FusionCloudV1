<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Orders</a>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-9 col-sm-push-3">
			<div class="information-blocks">
				<div class="row">
					<div class="col-md-12 information-entry">
						<div class="article-container style-1">
							<p><h5>Orders</h5></p>
							<div class="table-responsive">
								<table class="profile-table">
									<tr>
										<th>Tracking No.</th>
										<th>Created</th>
										<th>Status</th>
										<th></th>
									</tr>
									<tr>
										<td>OR12345</td>
										<td>Julu 12, 2016</td>
										<td>Shipped</td>
										<td><a href="myorder_detail.cfm">View Detail</a></td>
									</tr>
									<tr>
										<td>OR12345</td>
										<td>Julu 12, 2016</td>
										<td>Shipped</td>
										<td><a href="myorder_detail.cfm">View Detail</a></td>
									</tr>
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