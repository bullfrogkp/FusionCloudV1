<cfoutput>
<section class="content-header">
	<h1>
		Currencies
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Currencies</li>
	</ol>
</section>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Currencies</h3>
					<a href="#APPLICATION.absoluteUrlWeb#admin/currency_detail.cfm" class="btn btn-default btn-sm pull-right top-nav-anchor">Add Currency</a>
				</div>
				<div class="box-body table-responsive">
					<table class="table table-bordered table-hover">
						<tr class="default">
							<th>Code</th>
							<th>Multiplier</th>
							<th>Locale</th>
							<th>Default</th>
							<th>Status</th>
							<th>Action</th>
						</tr>
					
						<cfif ArrayLen(REQUEST.pageData.currencies) NEQ 0>
							<cfloop array="#REQUEST.pageData.currencies#" index="currency">
								<tr>
									<td>#currency.getCode()#</td>
									<td>#currency.getMultiplier()#</td>
									<td>#currency.getLocale()#</td>
									<td>#currency.getIsDefault()#</td>
									<td>
										<cfif currency.getIsEnabled() EQ true>
											<span class="label label-success">Enabled</span>
										<cfelse>
											<span class="label label-danger">Disabled</span>
										</cfif>
									</td>
									<td><a href="#APPLICATION.absoluteUrlWeb#admin/currency_detail.cfm?id=#currency.getCurrencyId()#">View Detail</a></td>
								</tr>
							</cfloop>
						<cfelse>
							<tr>
								<td colspan="7">No data available</td>
							</tr>
						</cfif>
					
						<tr class="default">
							<th>Code</th>
							<th>Multiplier</th>
							<th>Locale</th>
							<th>Default</th>
							<th>Status</th>
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
