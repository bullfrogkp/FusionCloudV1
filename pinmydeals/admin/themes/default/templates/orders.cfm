<cfoutput>
<section class="content-header">
	<h1>
		Orders
		<small>order information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Orders</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<form>
				<div class="box box-default">
					<div class="box-body">
						<div class="row">
							<div class="col-xs-2" style="padding-right:0;">
								<input type="text" name="id" class="form-control" placeholder="ID" <cfif StructKeyExists(URL,"id")>value="#URL.id#"</cfif>>
							</div>
							<div class="col-xs-3" style="padding-right:0;padding-left:10px;">
								<select class="form-control" name="is_enabled">
									<option value="">All Status</option>
									<option value="1" <cfif StructKeyExists(URL,"is_enabled") AND URL.is_enabled EQ 1>selected</cfif>>Enabled</option>
									<option value="0" <cfif StructKeyExists(URL,"is_enabled") AND URL.is_enabled EQ 0>selected</cfif>>Disabled</option>
								</select>
							</div>
							<div class="col-xs-5" style="padding-right:0;padding-left:10px;">
								<input type="text" name="search_keyword" class="form-control" placeholder="Keywords" <cfif StructKeyExists(URL,"search_keyword")>value="#URL.search_keyword#"</cfif>>
							</div>
							<div class="col-xs-2" style="padding-left:10px;">
								<button name="search_category" type="submit" class="btn btn-sm btn-primary search-button pull-right">Search</button>
							</div>
						</div>
					</div>
				</div>
			</form>
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Orders</h3>
					<a href="#APPLICATION.urlHttpsAdmin#new_order.cfm" class="btn btn-default btn-sm pull-right top-nav-anchor">Add New Order</a>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table class="table table-bordered table-hover">
						
						<tr class="default">
							<th>ID</th>
							<th>Order No.</th>
							<th>Email</th>
							<th>Name</th>
							<th>Create Datetime</th>
							<th>Status</th>
							<th>Invoice</th>
							<th>Action</th>
						</tr>
					
						<cfif ArrayLen(REQUEST.pageData.paginationInfo.records) NEQ 0>
							<cfloop array="#REQUEST.pageData.paginationInfo.records#" index="order">
								<tr>
									<td>#order.getOrderId()#</td>
									<td>
										#order.getOrderTrackingNumber()#
										<cfif order.getIsNew() EQ true>
											<span class="label label-danger pull-right" style="margin-top:3px;">New</span>
										</cfif>
									</td>
									<td>
										#order.getCustomerEmail()#
									</td>
									<td>
										#order.getCustomerFirstName()# #order.getCustomerMiddleName()# #order.getCustomerLastName()#
									</td>
									<td>#DateFormat(order.getCreatedDatetime(),"mmm dd,yyyy")#</td>
									<td>#isNull(EntityLoad("order_status",{order = order, current = true}, true))?"":EntityLoad("order_status",{order = order, current = true}, true).getOrderStatusType().getDisplayName()#</td>
									<td><a href="#APPLICATION.urlHttpsAdmin#order_detail.cfm?id=#order.getOrderId()#&active_tab_id=tab_4">Invoice</a></td>
									<td><a href="#APPLICATION.urlHttpsAdmin#order_detail.cfm?id=#order.getOrderId()#">View Detail</a></td>
								</tr>
							</cfloop>
						<cfelse>
							<tr>
								<td colspan="7">No data available</td>
							</tr>
						</cfif>
					
						<tr class="default">
							<th>ID</th>
							<th>Order No.</th>
							<th>Email</th>
							<th>Name</th>
							<th>Create Datetime</th>
							<th>Status</th>
							<th>Invoice</th>
							<th>Action</th>
						</tr>
						
					</table>
				</div><!-- /.box-body -->
				<div class="box-footer clearfix">
					<cfinclude template="pagination.cfm" />
				</div>
			</div><!-- /.box -->
		</div>
	</div>
</section><!-- /.content -->
</cfoutput>
