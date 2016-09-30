<cfoutput>
<section class="content-header">
	<h1>
		Contents
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Contents</li>
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
				<div class="box-body table-responsive">
					<table class="table table-bordered table-hover">
					
						<tr class="default">
							<th>Title</th>
							<th>URL</th>
							<th>Create Datetime</th>
							<th>Status</th>
							<th>Action</th>
						</tr>
					
						<cfif ArrayLen(REQUEST.pageData.paginationInfo.records) NEQ 0>
							<cfloop array="#REQUEST.pageData.paginationInfo.records#" index="content">
								<tr>
									<td>#content.getTitle()#</td>
									<td>
										<a href="#APPLICATION.absoluteUrlSite#site_content.cfm/#content.getName()#" target="_blank">
											#APPLICATION.absoluteUrlSite#site_content.cfm/#content.getName()#
										</a>
									</td>
									<td>#DateFormat(content.getCreatedDatetime(),"mmm dd,yyyy")#</td>
									<td>
										<cfif content.getIsEnabled() EQ true>
											<span class="label label-success">Enabled</span>
										<cfelse>
											<span class="label label-danger">Disabled</span>
										</cfif>
									</td>
									<td><a href="#APPLICATION.absoluteUrlSite#site_content_detail.cfm?id=#content.getSiteContentId()#">View Detail</a></td>
								</tr>
							</cfloop>
						<cfelse>
							<tr>
								<td colspan="7">No data available</td>
							</tr>
						</cfif>
					
						<tr class="default">
							<th>Title</th>
							<th>URL</th>
							<th>Create Datetime</th>
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
