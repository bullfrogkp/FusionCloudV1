<cfoutput>
<section class="content-header">
	<h1>
		Customer Groups
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Customer Groups</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Customer Groups</h3>
					<a href="#APPLICATION.absoluteUrlSite#customer_group_detail.cfm" class="btn btn-default btn-sm pull-right top-nav-anchor">Add New Customer Group</a>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table class="table table-bordered table-hover">
					
						<tr class="default">
							<th>Group Name</th>
							<th>Default</th>
							<th>Action</th>
						</tr>
					
						<cfloop array="#REQUEST.pageData.customerGroups#" index="group">
							<tr>
								<td>#group.getDisplayName()#</td>
								<td>#group.getIsDefault()#</td>
								<td><a href="#APPLICATION.absoluteUrlSite#customer_group_detail.cfm?id=#group.getCustomerGroupId()#">View Detail</a></td>
							</tr>
						</cfloop>
				
						<tr class="default">
							<th>Group Name</th>
							<th>Discount Type</th>
							<th>Action</th>
						</tr>
					
					</table>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div>
	</div>
</section><!-- /.content -->
</cfoutput>
