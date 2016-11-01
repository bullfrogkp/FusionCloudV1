<cfoutput>
<section class="content-header">
	<h1>
		Discount Types
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Discount Types</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Discount Types</h3>
					<a href="#APPLICATION.urlHttpsAdmin#discount_type_detail.cfm" class="btn btn-default btn-sm pull-right top-nav-anchor">Add New Discount Type</a>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table class="table table-bordered table-hover">
					
						<tr class="default">
							<th>Name</th>
							<th>Calculation Type</th>
							<th>Amount</th>
							<th style="width:110px;">Action</th>
						</tr>
						
						<cfif ArrayLen(REQUEST.pageData.discountTypes) GT 0>
							<cfloop array="#REQUEST.pageData.discountTypes#" index="type">
								<tr>
									<td>#type.getDisplayName()#</td>
									<td>#type.getCalculationType().getDisplayName()#</td>
									<td>#type.getAmount()#</td>
									<td><a href="#APPLICATION.urlHttpsAdmin#discount_type_detail.cfm?id=#type.getDiscountTypeId()#">View Detail</a></td>
								</tr>
							</cfloop>
						<cfelse>
							<tr>
								<td colspan="4">No data available</td>
							</tr>
						</cfif>
						
						<tr class="default">
							<th>Name</th>
							<th>Calculation Type</th>
							<th>Amount</th>
							<th>Action</th>
						</tr>
						
					</table>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div>
	</div>
</section><!-- /.content -->
</cfoutput>
