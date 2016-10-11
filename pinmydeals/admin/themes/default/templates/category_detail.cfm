<cfoutput>
<script>
	$(document).ready(function() {
	
		var absoluteUrlThemeAdmin = '#SESSION.absoluteUrlThemeAdmin#';
		var absoluteUrlSite = '#APPLICATION.absoluteUrlSite#';
	
		var filterChanged = false;
		var filterArray = new Array();
		<cfloop array="#REQUEST.pageData.filters#" index="filter">
			var filter = new Object();
			var filterOptions = new Array();
			filter.fid = '#filter.getFilterId()#';
			filter.name = '#filter.getDisplayName()#';
			
			<cfif ListFind(REQUEST.pageData.filterList,filter.getFilterId())>
				filter.deleted = false;
				
				<cfset categoryFilterRela = EntityLoad("category_filter_rela", {category = REQUEST.pageData.category, filter = filter}, true) />
				
				<cfloop array="#categoryFilterRela.getFilterValues()#" index="filterValue">
					var filterOption = new Object();
					filterOption.foid = '#filterValue.getFilterValueId()#';
					filterOption.value = '#filterValue.getValue()#';
					filterOption.imageName = '#filterValue.getImageName()#';
					filterOption.imageSrc = '#filterValue.getImageLink()#';
					
					filterOptions.push(filterOption);
				</cfloop>
			<cfelse>
				filter.deleted = true;
			</cfif>
			
			filter.options = filterOptions;
			filterArray.push(filter);
		</cfloop>
	});
</script>
<section class="content-header">
	<h1>
		Category Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Category Detail</li>
	</ol>
</section>

<!-- Main content -->
<form id="category-detail" method="post" enctype="multipart/form-data">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.formData.id#" />
<input type="hidden" name="tab_id" id="tab_id" value="#REQUEST.pageData.tabs.activeTabId#" />
<input type="hidden" name="deleted_image_id" id="deleted_image_id" value="" />
<input type="hidden" name="deleted_ad_id" id="deleted_ad_id" value="" />

<input type="hidden" name="new_filter_id_hidden" id="new-filter-id-hidden" value="" />
<input type="hidden" name="new_filter_name_hidden" id="new-filter-name-hidden" value="" />
<input type="hidden" name="deleted_filter_id_hidden" id="deleted-filter-id-hidden" value="" />
<input type="hidden" name="deleted_filter_option_id_hidden" id="deleted-filter-option-id-hidden" value="" />
<input type="hidden" name="image_count_hidden" id="image-count-hidden" value="0" />

<section class="content">
	<div class="row">
		<div class="col-md-12">
			<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
				<div class="alert #REQUEST.pageData.message.messageType# alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
					#msg#<br/>
					</cfloop>
				</div>
			</cfif>
		</div>
		<div class="col-md-12">
			<!-- Custom Tabs -->
			<div class="nav-tabs-custom">
				<ul class="nav nav-tabs">
					<li class="tab-title #REQUEST.pageData.tabs['tab_1']#" tabid="tab_1"><a href="##tab_1" data-toggle="tab">General Information</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_2']#" tabid="tab_2"><a href="##tab_2" data-toggle="tab">Meta Data</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_3']#" tabid="tab_3"><a href="##tab_3" data-toggle="tab">Filter</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_4']#" tabid="tab_4"><a href="##tab_4" data-toggle="tab">Custom Design</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_5']#" tabid="tab_5"><a href="##tab_5" data-toggle="tab">Thumbnail Image</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_6']#" tabid="tab_6"><a href="##tab_6" data-toggle="tab">Product</a></li>
					
					<cfset tab_idx = REQUEST.pageData.totalTabs />
					<cfloop collection="#REQUEST.moduleData#" item="m">
						<cfif StructKeyExists(REQUEST.moduleData[m],"tab_title")>
							<cfset tab_idx += 1 />
							<li class="tab-title #REQUEST.pageData.tabs['tab_#tab_idx#']#" tabid="tab_#tab_idx#"><a href="##tab_#tab_idx#" data-toggle="tab">#REQUEST.moduleData[m].tab_title#</a></li>
						</cfif>
					</cfloop>
				</ul>
				<div class="tab-content">
					<div class="tab-pane #REQUEST.pageData.tabs['tab_1']#" id="tab_1">
						<div class="form-group">
							<label>Category Name</label>&nbsp;&nbsp;(required)
							<input type="text" class="form-control" placeholder="Enter ..." name="display_name" value="#REQUEST.pageData.formData.display_name#"/>
						</div>
						<div class="form-group">
							<label>Parent Category</label>
							<select class="form-control" name="parent_category_id">
								<option value="">Root</option>
								<cfloop array="#REQUEST.pageData.categoryTree#" index="cat">
									<option value="#cat.getCategoryId()#"
									<cfif REQUEST.pageData.formData.parent_category_id EQ cat.getCategoryId()>
									selected
									</cfif>
									>#RepeatString("&nbsp;",10)##cat.getDisplayName()#</option>
									<cfloop array="#cat.getSubCategories()#" index="subCat">
										<option value="#subCat.getCategoryId()#"
										<cfif REQUEST.pageData.formData.parent_category_id EQ subCat.getCategoryId()>
										selected
										</cfif>
										>#RepeatString("&nbsp;",20)##subCat.getDisplayName()#</option>
										<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
											<option value="#thirdCat.getCategoryId()#"
											<cfif REQUEST.pageData.formData.parent_category_id EQ thirdCat.getCategoryId()>
											selected
											</cfif>
											>#RepeatString("&nbsp;",30)##thirdCat.getDisplayName()#</option>
										</cfloop>
										</li>
									</cfloop>
									</li>
								</cfloop>
							</select>
						</div>
						 <div class="form-group">
							<label>Rank</label>
							<input type="text" class="form-control" placeholder="Enter ..." name="rank" value="#REQUEST.pageData.formData.rank#" />
						</div>
						 <div class="form-group">
							<label>Status</label>
							 <select class="form-control" name="is_enabled">
								<option value="1" <cfif REQUEST.pageData.formData.is_enabled EQ TRUE>selected</cfif>>Enabled</option>
								<option value="0" <cfif REQUEST.pageData.formData.is_enabled EQ FALSE>selected</cfif>>Disabled</option>
							</select>
						</div>
						<div class="form-group">
							<label>Show on Navigation</label>
							 <select class="form-control" name="show_category_on_navigation">
								<option value="1" <cfif REQUEST.pageData.formData.show_category_on_navigation EQ TRUE>selected</cfif>>Yes</option>
								<option value="0" <cfif REQUEST.pageData.formData.show_category_on_navigation EQ FALSE>selected</cfif>>No</option>
							</select>
						</div>
						<div class="form-group">
							<label>Display Category List</label>
							 <select class="form-control" name="display_category_list">
								<option value="1" <cfif IsBoolean(REQUEST.pageData.formData.display_category_list) AND REQUEST.pageData.formData.display_category_list EQ TRUE>selected</cfif>>Yes</option>
								<option value="0" <cfif NOT (IsBoolean(REQUEST.pageData.formData.display_category_list) AND REQUEST.pageData.formData.display_category_list EQ TRUE)>selected</cfif>>No</option>
							</select>
						</div>
						<div class="form-group">
							<label>Special Category</label>
							 <select class="form-control" name="is_special">
								<option value="1" <cfif IsBoolean(REQUEST.pageData.formData.is_special) AND REQUEST.pageData.formData.is_special EQ TRUE>selected</cfif>>Yes</option>
								<option value="0" <cfif NOT (IsBoolean(REQUEST.pageData.formData.is_special) AND REQUEST.pageData.formData.is_special EQ TRUE)>selected</cfif>>No</option>
							</select>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_2']#" id="tab_2">
						<div class="form-group">
							<label>Title</label>
							<input type="text" class="form-control" placeholder="Enter ..." name="title" value="#REQUEST.pageData.formData.title#"/>
						</div>
						<div class="form-group">
							<label>Keywords</label>
							<textarea name="keywords" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.formData.keywords#</textarea>
						</div>
						<div class="form-group">
							<label>Description</label>
							<textarea name="description" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.formData.description#</textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_3']#" id="tab_3">
						<div class="form-group">
							<label>Display Filter</label>
							 <select class="form-control" name="display_filter">
								<option value="1" <cfif REQUEST.pageData.formData.display_filter EQ TRUE>selected</cfif>>Yes</option>
								<option value="0" <cfif REQUEST.pageData.formData.display_filter EQ FALSE OR REQUEST.pageData.formData.display_filter EQ "">selected</cfif>>No</option>
							</select>
						</div>
					
						<label>Filter(s)</label>&nbsp;&nbsp;&nbsp;
						<a href="" class="add-new-filter" data-toggle="modal" data-target="##add-new-filter-modal">
							<span class="label label-primary">Edit Filter(s)</span>
						</a>

						<div id="filters" class="row" style="margin-top:10px;">
							<cfif NOT IsNull(REQUEST.pageData.category)>
								<cfloop array="#REQUEST.pageData.filters#" index="filter">
									<cfset categoryFilterRela = EntityLoad("category_filter_rela",{category=REQUEST.pageData.category,filter=filter},true) />
									<cfif NOT IsNull(categoryFilterRela)>
										<div class="col-xs-3">
											<div class="box box-warning">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr class="warning" id="tr-#filter.getFilterId()#">
															<th colspan="2">#filter.getDisplayName()#</th>
															<th>
																<a filterid="#filter.getFilterId()#" filtername="#filter.getName()#" class="add-new-filter-option pull-right" data-toggle="modal" data-target="##add-new-filter-option-modal" style="cursor:pointer;cursor:hand;">
																	<span class="label label-primary">Add Option</span>
																</a>
															</th>
														</tr>
														
														<cfloop array="#categoryFilterRela.getFilterValues()#" index="filerValue">
															<tr id="tr-ao-#filerValue.getFilterValueId()#">
																<td>
																	<table>
																		<tr>
																			<td>#filerValue.getValue()#</td>
																			<cfif filter.getDisplayName() EQ "color">
																				<td><div style="width:15px;height:15px;border:1px solid ##CCC;background-color:#filerValue.getValue()#;margin-top:2px;margin-left:10px;"></div></td>
																			</cfif>
																		</tr>
																	</table>
																</td>
																<td>
																	<div style="width:15px;height:15px;border:1px solid ##CCC;margin-top:2px;">
																		<img src="#filerValue.getImageLink(type = "thumbnail")#" style="width:100%;height:100%;vertical-align:top;" />
																	</div>
																</td>
																<td>
																	<a filterid="#filter.getFilterId()#" filteroptionid="#filerValue.getFilterValueId()#" class="delete-filter-option pull-right" data-toggle="modal" data-target="##delete-filter-option-modal" style="cursor:pointer;cursor:hand;">
																		<span class="label label-danger">Delete</span>
																	</a>
																</td>
															</tr>
														</cfloop>
													</table>
												</div><!-- /.box-body -->
											</div><!-- /.box -->
										</div>
									</cfif>
								</cfloop>
							</cfif>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_4']#" id="tab_4">
						<div class="form-group">
							<label>Display Custom Design Section</label>
							 <select class="form-control" name="display_custom_design">
								<option value="1" <cfif REQUEST.pageData.formData.display_custom_design EQ TRUE>selected</cfif>>Yes</option>
								<option value="0" <cfif REQUEST.pageData.formData.display_custom_design EQ FALSE OR REQUEST.pageData.formData.display_custom_design EQ "">selected</cfif>>No</option>
							</select>
						</div>
						<div class="form-group">
							<textarea name="custom_design" id="custom_design" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.custom_design#</textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_5']#" id="tab_5">
						<cfif NOT IsNULL(REQUEST.pageData.category) AND NOT IsNULL(REQUEST.pageData.category.getImages())>
							<div class="row">
								<cfloop array="#REQUEST.pageData.category.getImages()#" index="img">						
									<div class="col-xs-2">
										<div class="box <cfif img.getIsDefault() EQ true>box-danger</cfif>">
											<div class="box-body table-responsive no-padding">
												<table class="table table-hover">
													<tr <cfif img.getIsDefault() EQ true>class="danger"<cfelse>class="default"</cfif>>
														<th style="font-size:11px;line-height:20px;">#img.getName()#</th>
														<th><a imageid="#img.getCategoryImageId()#" href="" class="delete-image pull-right" data-toggle="modal" data-target="##delete-image-modal"><span class="label label-danger">Delete</span></a></th>
													</tr>
													<tr>
														<td colspan="2">
															<img class="img-responsive" src="#APPLICATION.absoluteUrlSite#images/uploads/category/#REQUEST.pageData.category.getCategoryId()#/#img.getName()#" />
														</td>
													</tr>
													<tr>
														<td colspan="2">
															<table style="width:100%;">
																<tr>
																	<td>
																		<input class="form-control pull-left" type="radio" name="default_image_id" value="#img.getCategoryImageId()#" <cfif img.getIsDefault() EQ true>checked</cfif>/>
																	</td>
																	<td style="padding-left:5px;padding-top:1px;font-size:12px;">
																		Set as Default
																	</td>
																	<td style="text-align:right">
																		<input type="text" name="rank_#img.getCategoryImageId()#" value="#img.getRank()#" style="width:30px;text-align:center;" />
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</div><!-- /.box-body -->
										</div><!-- /.box -->
									</div>
								</cfloop>
							</div>
						</cfif>
						
						<div class="form-group">
							<div id="uploader">
								<p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_6']#" id="tab_6">
						<div class="row">
							<div class="col-xs-12">
								<div class="box">
									<div class="box-body table-responsive">
										<table class="table table-bordered table-hover">
											
											<tr class="default">
												<th>Name</th>
												<th>Create Datetime</th>
												<th>SKU</th>
												<th>Status</th>
												<th>Action</th>
											</tr>
										
											<cfif NOT IsNull(REQUEST.pageData.paginationInfo.records) AND ArrayLen(REQUEST.pageData.paginationInfo.records) NEQ 0>
												<cfloop array="#REQUEST.pageData.paginationInfo.records#" index="product">
													<tr>
														<td>#product[1].getDisplayName()#</td>
														<td>#DateFormat(product[1].getCreatedDatetime(),"mmm dd,yyyy")#</td>
														<td>#product[1].getSku()#</td>
														<td>#product[1].getIsEnabled()#</td>
														<td><a href="#APPLICATION.absoluteUrlSite#product_detail.cfm?id=#product[1].getProductId()#">View Detail</a></td>
													</tr>
												</cfloop>
											<cfelse>
												<tr>
													<td colspan="6">No data available</td>
												</tr>
											</cfif>
										
											<tr class="default">
												<th>Name</th>
												<th>Create Datetime</th>
												<th>SKU</th>
												<th>Status</th>
												<th>Action</th>
											</tr>
										</table>
									</div><!-- /.box-body -->
									<div class="box-footer clearfix">
										<cfset extraURLParams = "active_tab_id=tab_6" />
										<cfinclude template="pagination.cfm" />
									</div>
								</div><!-- /.box -->
							</div>
						</div>
					</div><!-- /.tab-pane -->
					
					<cfset tab_idx = REQUEST.pageData.totalTabs />
					<cfloop collection="#REQUEST.moduleData#" item="m">
						<cfif StructKeyExists(REQUEST.moduleData[m],"tab_view")>
							<cfset tab_idx += 1 />
							<div class="tab-pane #REQUEST.pageData.tabs['tab_#tab_idx#']#" id="tab_#tab_idx#">
								#REQUEST.moduleData[m].tab_view#
							</div><!-- /.tab-pane -->
						</cfif>
					</cfloop>
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
		
			<div class="form-group">
				<button name="save_item" id="save-item" type="submit" class="btn btn-primary top-nav-button">Save Category</button>
				<button type="button" class="btn btn-danger pull-right #REQUEST.pageData.deleteButtonClass#" data-toggle="modal" data-target="##delete-current-entity-modal">Delete Category</button>
			</div>
		</div><!-- /.col -->
	</div>   <!-- /.row -->
</section><!-- /.content -->

<!-- DELETE ENTITY MODAL -->
<div class="modal fade" id="delete-current-entity-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this category?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_item" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE IMAGE MODAL -->
<div class="modal fade" id="delete-image-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this image?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_image" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- DELETE AD MODAL -->
<div class="modal fade" id="delete-ad-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this Ad?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_ad" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- ADD FILTER MODAL -->
<div class="modal fade" id="add-new-filter-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Filter(s)</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<label>Filters</label>
					<select class="form-control" multiple name="filter_id" id="filter-id">
						<cfloop array="#REQUEST.pageData.filters#" index="filter">
							<option value="#filter.getFilterId()#"
							<cfif ListFind(REQUEST.pageData.filterList,filter.getFilterId())>
								selected
							</cfif>
							>#filter.getDisplayName()#</option>
						</cfloop>
					</select>
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="edit_filter" id="edit-filter-confirm" type="button" class="btn btn-primary pull-left" data-dismiss="modal"><i class="fa fa-check"></i> Save</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- ADD OPTION MODAL -->
<div class="modal fade" id="add-new-filter-option-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Filter Option</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group" id="filter-option-modal-div">
					<input id="new-filter-option-name" name="new_filter_option_name" type="text" class="form-control" placeholder="Value">
					<input id="new-filter-option-name-color" name="new_filter_option_name_color" type="text" class="form-control" placeholder="Value">
				</div>
				<div class="form-group filter-option-image-div" id="filter-option-image-div-0">
					<div class="btn btn-success btn-file" style="width:150px;margin-right:20px;">
						<i class="fa fa-paperclip"></i> &nbsp;&nbsp;Add Image
						<input type="file" name="new_filter_option_image_0" id="new-filter-option-image-0"/>
					</div>
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button id="add-new-filter-option-confirm" name="add_new_filter_option_confirm" type="button" class="btn btn-primary pull-left" data-dismiss="modal"><i class="fa fa-check"></i> Add</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE OPTION MODAL -->
<div class="modal fade" id="delete-filter-option-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this option?</h4>
			</div>
		
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_filter_option_confirm" id="delete-filter-option-confirm" type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-check"></i> Yes</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</form>
</cfoutput>