<cfoutput>
<section class="content-header">
	<h1>
		Attributes
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Attributes</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Attributes</h3>
					<a href="#APPLICATION.absoluteUrlSite#attribute_detail.cfm" class="btn btn-default btn-sm pull-right top-nav-anchor">Add New Attribute</a>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table class="table table-bordered table-hover data-table">
					
						<tr class="default">
							<th>ID</th>
							<th>Name</th>
							<th style="width:110px;">Action</th>
						</tr>
						
						<cfif ArrayLen(REQUEST.pageData.attributes) GT 0>
							<cfloop array="#REQUEST.pageData.attributes#" index="attribute">
								<tr>
									<td>#attribute.getAttributeId()#</td>
									<td>#attribute.getDisplayName()#</td>
									<td><a href="#APPLICATION.absoluteUrlSite#attribute_detail.cfm?id=#attribute.getAttributeId()#">View Detail</a></td>
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
