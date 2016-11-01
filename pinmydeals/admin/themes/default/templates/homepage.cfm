<cfoutput>
<script>
	$(document).ready(function() {		
	
		$(".tab-title").click(function() {
		  $("##tab_id").val($(this).attr('tabid'));
		});
	
		CKEDITOR.replace( 'slide_content',
		{
			filebrowserBrowseUrl :'#SESSION.urlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserImageBrowseUrl : '#SESSION.urlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserFlashBrowseUrl :'#SESSION.urlThemeAdmin#js/plugins/ckeditor/filemanager/index.html'}
		);
		
		$("##uploader").plupload({
			// General settings
			runtimes: 'html5,flash,silverlight,html4',
			
			url: "#APPLICATION.urlHttpsAdmin#ajax/upload_ads.cfm",

			// Maximum file size
			max_file_size: '1000mb',

			// User can upload no more then 20 files in one go (sets multiple_queues to false)
			max_file_count: 20,
			
			chunk_size: '1mb',

			// Specify what files to browse for
			filters: [
				{ title: "Image files", extensions: "jpg,gif,png" }
			],

			// Rename files by clicking on their titles
			rename: true,
			
			// Sort files
			sortable: true,

			// Enable ability to drag'n'drop files onto the widget (currently only HTML5 supports that)
			dragdrop: true,

			// Views to activate
			views: {
				thumbs: true,
				list: false,
				active: 'thumbs'
			},

			// Flash settings
			flash_swf_url : 'http://rawgithub.com/moxiecode/moxie/master/bin/flash/Moxie.cdn.swf',

			// Silverlight settings
			silverlight_xap_url : 'http://rawgithub.com/moxiecode/moxie/master/bin/silverlight/Moxie.cdn.xap'
		});
		
		$( ".delete-ad" ).click(function() {
			$("##deleted_ad_id").val($(this).attr('adid'));
		});
		
		$( ".delete-top-selling-product" ).click(function() {
			$("##deleted_top_selling_product_id").val($(this).attr('productid'));
		});
		
		$( ".delete-group-buying-product" ).click(function() {
			$("##deleted_group_buying_product_id").val($(this).attr('productid'));
		});
		
	});
</script>
<section class="content-header">
	<h1>
		Home Page
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Home Page</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="tab_id" id="tab_id" value="#REQUEST.pageData.tabs.activeTabId#" />
<input type="hidden" name="deleted_ad_id" id="deleted_ad_id" value="" />
<input type="hidden" name="deleted_top_selling_product_id" id="deleted_top_selling_product_id" value="" />
<input type="hidden" name="deleted_group_buying_product_id" id="deleted_group_buying_product_id" value="" />
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
					<li class="tab-title #REQUEST.pageData.tabs['tab_1']#" tabid="tab_1"><a href="##tab_1" data-toggle="tab">Slide</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_2']#" tabid="tab_2"><a href="##tab_2" data-toggle="tab">Advertisement</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_3']#" tabid="tab_3"><a href="##tab_3" data-toggle="tab">Top Selling</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_4']#" tabid="tab_4"><a href="##tab_4" data-toggle="tab">Group Buying</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_5']#" tabid="tab_5"><a href="##tab_5" data-toggle="tab">Meta Data</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane #REQUEST.pageData.tabs['tab_1']#" id="tab_1">
						<div class="form-group">
							<textarea name="slide_content" id="slide_content" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.slide_content#</textarea>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_2']#" id="tab_2">
						<div class="form-group">
							<div class="row">
								<cfif NOT IsNull(REQUEST.pageData.advertisementSection.getAdvertisements())>
									<cfloop array="#REQUEST.pageData.advertisementSection.getAdvertisements()#" index="ad">						
										<div class="col-xs-2">
											<div class="box box-warning">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr class="warning">
															<th style="font-size:11px;line-height:20px;">
																<input type="text" placeholder="Rank" name="advertisement_rank_#ad.getPageSectionAdvertisementId()#" value="#ad.getRank()#" style="width:40px;text-align:center;" />
															</th>
															<th><a adid="#ad.getPageSectionAdvertisementId()#" href="" class="delete-ad pull-right" data-toggle="modal" data-target="##delete-ad-modal"><span class="label label-danger">Delete</span></a></th>
														</tr>
														<tr>
															<td colspan="2">
																<img class="img-responsive" src="#ad.getImageLink(type = "small")#" />
															</td>
														</tr>
														<tr>
															<td colspan="2">
																<input type="text" placeholder="Link" name="advertisement_link_#ad.getPageSectionAdvertisementId()#" value="#ad.getLink()#" style="width:100%;padding-left:5px;"/>
															</td>
														</tr>
													</table>
												</div><!-- /.box-body -->
											</div><!-- /.box -->
										</div>
									</cfloop>
								</cfif>
							</div>
							
							<div class="form-group">
								<div id="uploader">
									<p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
								</div>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_3']#" id="tab_3">
						<div class="form-group">
							<a data-toggle="modal" data-target="##add-top-selling-product-modal" href="">
								<span class="label label-primary">Add New Product</span>
							</a>
							<div class="row" style="margin-top:10px;">
								<cfif NOT IsNull(REQUEST.pageData.topSellingSection.getSectionData())>
									<cfloop array="#REQUEST.pageData.topSellingSection.getSectionData()#" index="tp">	
										<cfset product = tp.getProduct() />
										<div class="col-xs-2">
											<div class="box">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr class="default">
															<th style="font-size:11px;line-height:20px;">
																<input type="text" placeholder="Rank" name="top_selling_rank_#tp.getPageSectionProductId()#" value="#tp.getRank()#" style="width:40px;text-align:center;" />
															</th>
															<th><a productid="#product.getProductId()#" href="" class="delete-top-selling-product pull-right" data-toggle="modal" data-target="##delete-top-selling-product-modal"><span class="label label-danger">Delete</span></a></th>
														</tr>
														<tr>
															<td colspan="2">
																<a href="#product.getDetailPageURL()#">
																	<img class="img-responsive" src="#product.getDefaultImageLink(type='small')#" />
																</a>
															</td>
														</tr>
													</table>
												</div><!-- /.box-body -->
											</div><!-- /.box -->
										</div>
									</cfloop>
								</cfif>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_4']#" id="tab_4">
						<div class="form-group">
							<a data-toggle="modal" data-target="##add-group-buying-product-modal" href="">
								<span class="label label-primary">Add New Product</span>
							</a>
							<div class="row" style="margin-top:10px;">
								<cfif NOT IsNull(REQUEST.pageData.groupBuyingSection.getSectionData())>
									<cfloop array="#REQUEST.pageData.groupBuyingSection.getSectionData()#" index="gb">	
										<cfset product = gb.getProduct() />
										<div class="col-xs-2">
											<div class="box">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr class="default">
															<th style="font-size:11px;line-height:20px;">
																<input type="text" placeholder="Rank" name="group_buying_rank_#gb.getPageSectionProductId()#" value="#gb.getRank()#" style="width:40px;text-align:center;" />
															</th>
															<th><a productid="#product.getProductId()#" href="" class="delete-group-buying-product pull-right" data-toggle="modal" data-target="##delete-group-buying-product-modal"><span class="label label-danger">Delete</span></a></th>
														</tr>
														<tr>
															<td colspan="2">
																<a href="#product.getDetailPageURL()#">
																	<img class="img-responsive" src="#product.getDefaultImageLink(type='small')#" />
																</a>
															</td>
														</tr>
													</table>
												</div><!-- /.box-body -->
											</div><!-- /.box -->
										</div>
									</cfloop>
								</cfif>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_5']#" id="tab_5">
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
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
		
			<div class="form-group">
				<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Homepage</button>
			</div>
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
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
<!-- ADD TOP SELLING PRODUCT MODAL -->
<div class="modal fade" id="add-top-selling-product-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add Top Selling Product</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<label>Product Group</label>
					<select name="top_selling_product_group_id" multiple class="form-control">
						<cfloop array="#REQUEST.pageData.productGroups#" index="group">
							<option value="#group.getProductGroupId()#">#group.getDisplayName()#</option>
						</cfloop>
					</select>
				</div>
				<div class="form-group">
					<label>Product ID</label>
					<input id="new_top_selling_product_id" name="new_top_selling_product_id" type="text" class="form-control" placeholder="Product ID">
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_top_selling_product" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- ADD GROUP BUYING PRODUCT MODAL -->
<div class="modal fade" id="add-group-buying-product-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add Group Buying Product</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<label>Product Group</label>
					<select name="group_buying_product_group_id" multiple class="form-control">
						<cfloop array="#REQUEST.pageData.productGroups#" index="group">
							<option value="#group.getProductGroupId()#">#group.getDisplayName()#</option>
						</cfloop>
					</select>
				</div>
				<div class="form-group">
					<label>Product ID</label>
					<input id="new_group_buying_product_id" name="new_group_buying_product_id" type="text" class="form-control" placeholder="Product ID">
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_group_buying_product" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE TOP SELLING PRODUCT MODAL -->
<div class="modal fade" id="delete-top-selling-product-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this top selling product?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_top_selling_product" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE GROUP BUYING PRODUCT MODAL -->
<div class="modal fade" id="delete-group-buying-product-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this group buying product?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_group_buying_product" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</form>
</cfoutput>