<cfoutput>
<!-- Content Header (Page header) -->
<section class="content-header">
	<h1>
		Categories
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Categories</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	 <div class="row">
		<div class="col-md-12">
			<cfif IsDefined("REQUEST.pageData.message")>
				<div class="alert #REQUEST.pageData.message_type# alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					#REQUEST.pageData.message#
				</div>
			</cfif>
		</div>
		<div class="col-md-4">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Categories</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<ul>
						<cfloop array="#REQUEST.pageData.categoryTree#" index="cat">
							<li><a href="#APPLICATION.absoluteUrlSite#category_detail.cfm?id=#cat.getCategoryId()#">#cat.getDisplayName()#</a>
							<cfif ArrayLen(cat.getSubCategories()) NEQ 0>
								<ul>
							</cfif>
							<cfloop array="#cat.getSubCategories()#" index="subCat">
								<li><a href="#APPLICATION.absoluteUrlSite#category_detail.cfm?id=#subCat.getCategoryId()#">#subCat.getDisplayName()#</a>
								<cfif ArrayLen(subCat.getSubCategories()) NEQ 0>
									<ul>
								</cfif>
								<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
									<li><a href="#APPLICATION.absoluteUrlSite#category_detail.cfm?id=#thirdCat.getCategoryId()#">#thirdCat.getDisplayName()#</a>
								</cfloop>
								<cfif ArrayLen(subCat.getSubCategories()) NEQ 0>
									</ul>
								</cfif>
								</li>
							</cfloop>
							<cfif ArrayLen(cat.getSubCategories()) NEQ 0>
								</ul>
							</cfif>
							</li>
						</cfloop>
					</ul>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!-- ./col -->
		<div class="col-md-8">
			<form>
				<div class="box box-success">
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
			
			<div class="box box-warning">
				<div class="box-header">
					<h3 class="box-title">Categories</h3>
					<a href="#APPLICATION.absoluteUrlSite#category_detail.cfm" class="btn btn-default btn-sm pull-right top-nav-anchor">Add New Category</a>
				</div><!-- /.box-header -->
				<div class="box-body table-responsive">
					<table class="table table-bordered table-hover">
						<tr class="default">
							<th style="width:40px;">ID</th>
							<th>Name</th>
							<th>Rank</th>
							<th>Show On Navigation</th>
							<th style="width:40px;">Status</th>
							<th style="width:110px;">Action</th>
						</tr>
						<cfif ArrayLen(REQUEST.pageData.paginationInfo.records) NEQ 0>
							<cfloop array="#REQUEST.pageData.paginationInfo.records#" index="category">
							<tr>
								<td>#category.getCategoryId()#</td>
								<td>#category.getDisplayName()#</td>
								<td>#category.getRank()#</td>
								<td>#YesNoFormat(category.getShowCategoryOnNavigation())#</td>
								<td>
									<cfswitch expression="#category.getIsEnabled()#">
										<cfcase value="yes"><span class="label label-success">Enabled</span></cfcase>
										<cfcase value="no"><span class="label label-danger">Disabled</span></cfcase>
									</cfswitch>
								</td>
								<td><a href="#APPLICATION.absoluteUrlSite#category_detail.cfm?id=#category.getCategoryId()#">View Detail</a></td>
							</tr>
							</cfloop>
						<cfelse>
							<tr>
								<td colspan="6">No result found.</td>
							</tr>
						</cfif>
						<tr class="default">
							<th>ID</th>
							<th>Name</th>
							<th>Rank</th>
							<th>Show On Navigation</th>
							<th>Status</th>
							<th>Action</th>
						</tr>
					</table>
				</div><!-- /.box-body -->
				<div class="box-footer clearfix">
					<cfinclude template="pagination.cfm" />
				</div>
			</div><!-- /.box -->
		
		</div><!-- ./col -->
	</div><!-- /.row -->
</section><!-- /.content -->
</cfoutput>