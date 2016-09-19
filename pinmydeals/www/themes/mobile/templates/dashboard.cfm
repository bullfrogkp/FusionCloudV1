<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Dashboard</a>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-9 col-sm-push-3">
			<div class="information-blocks">
				<div class="row">
					<div class="col-md-12 information-entry">
						<div class="article-container style-1">
							<p><h5>My Account <a href="myaccount.cfm" style="margin-left:10px;font-weight:normal">EDIT</a></h5></p>
							<div class="table-responsive">
								<table class="profile-table style-1">
									<tr>
										<th>Email: </th>
										<th>#REQUEST.pageData.customer.getEmail()#</th>
										<th>Phone: </th>
										<th>#REQUEST.pageData.customer.getPhone()#</th>
									</tr>
									<tr>
										<td>First Name: </td>
										<td>#REQUEST.pageData.customer.getFirstName()#</td>
										<td>Company: </td>
										<td>#REQUEST.pageData.customer.getCompany()#</td>
									</tr>
									<tr>
										<td>Middle Name: </td>
										<td>#REQUEST.pageData.customer.getMiddleName()#</td>
										<td>Website: </td>
										<td>#REQUEST.pageData.customer.getWebsite()#</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 information-entry">
						<div class="article-container style-1">
							<p><h5>Address Information <a href="addresses.cfm" style="margin-left:10px;font-weight:normal">EDIT</a></h5></p>
							<div class="row">
								<cfloop array="#REQUEST.pageData.customer.getAddreses()#" index="addr">
									<div class="col-md-4 information-entry">
										<div class="article-container style-1">
											#addr.getFirstName()# #addr.getMiddleName()# #addr.getLastName()#<br/>
											#addr.getStreet()# #addr.getUnit()#<br/>
											#addr.getCity()#, #addr.getProvince().getDisplayName()#, #addr.getPostalCode()#<br/>
											#addr.getCountry().getDisplayName()#<br/>
										</div>
									</div>
								</cfloop>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 information-entry">
						<div class="article-container style-1">
							<p><h5>Recent Orders <a href="orders.cfm" style="margin-left:10px;font-weight:normal">VIEW ALL</a></h5></p>
							<div class="table-responsive">
								<table class="profile-table">
									<tr>
										<th>Tracking No.</th>
										<th>Created</th>
										<th>Status</th>
										<th></th>
									</tr>
									<cfloop array="#REQUEST.pageData.customer.getRecentOrders(count = 5)#" index="order">
										<tr>
											<td>#order.getOrderNumber()#</td>
											<td>#order.getCreateDate()#</td>
											<td>#order.getStatus()#</td>
											<td><a href="order_detail.cfm?order_id=#order.getOrderId()#">View Detail</a></td>
										</tr>
									</cfloop>
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