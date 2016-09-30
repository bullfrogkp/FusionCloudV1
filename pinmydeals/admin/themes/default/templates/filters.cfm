<cfoutput>
<section class="content-header">
	<h1>
		Filters
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Filters</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Filters</h3>
					<a href="#APPLICATION.absoluteUrlSite#admin/filter_detail.cfm" class="btn btn-default btn-sm pull-right top-nav-anchor">Add New Filter</a>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table class="table table-bordered table-hover data-table">
					
						<tr class="default">
							<th>ID</th>
							<th>Name</th>
							<th style="width:110px;">Action</th>
						</tr>
						
						<cfif ArrayLen(REQUEST.pageData.filters) GT 0>
							<cfloop array="#REQUEST.pageData.filters#" index="filter">
								<tr>
									<td>#filter.getFilterId()#</td>
									<td>#filter.getDisplayName()#</td>
									<td><a href="#APPLICATION.absoluteUrlSite#admin/filter_detail.cfm?id=#filter.getFilterId()#">View Detail</a></td>
								</tr>
							</cfloop>
						<cfelse>
							<tr>
								<td colspan="3">No data available</td>
							</tr>
						</cfif>
						
						<tr class="default">
							<th>ID</th>
							<th>Name</th>
							<th style="width:110px;">Action</th>
						</tr>
						
					</table>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div>
	</div>
</section><!-- /.content -->
</cfoutput>
