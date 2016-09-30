<cfoutput>

<script>
	$(document).ready(function() {
	
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
		
		$(".tab-title").click(function() {
		  $("##tab_id").val($(this).attr('tabid'));
		});
		
		CKEDITOR.replace( 'custom_design',
		{
			filebrowserBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserImageBrowseUrl : '#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserFlashBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html'}
		 );
		
		$("##uploader").plupload({
			// General settings
			runtimes: 'html5,flash,silverlight,html4',
			
			url: "#APPLICATION.absoluteUrlSite#admin/ajax/upload_category_images.cfm",

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
		
		$("##ads_image").plupload({
			// General settings
			runtimes: 'html5,flash,silverlight,html4',
			
			url: "#APPLICATION.absoluteUrlSite#admin/ajax/upload_ads.cfm",

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
					
		$( ".delete-image" ).click(function() {
			$("##deleted_image_id").val($(this).attr('imageid'));
		});
		
		$( ".delete-ad" ).click(function() {
			$("##deleted_ad_id").val($(this).attr('adid'));
		});
		
		$( "##filter-group-id" ).change(function() {
			$(".filter-group").hide();
			$("##filter-group-" + $(this).val()).show();
		});
		
		var new_filter_index = 1;
		
		$('##new-filter-option-name-color').colorpicker();
		
		$("##search-product").click(function() {
			$.ajax({
						type: "get",
						url: "#APPLICATION.absoluteUrlSite#core/services/productService.cfc",
						dataType: 'json',
						data: {
							method: 'searchProducts',
							productGroupId: $("##search-product-group-id").val(),
							categoryId: $("##search-category-id").val(),
							keywords: $("##search-keywords").val()
						},		
						success: function(response) {
							var productArray = response.DATA;
							var productName = '';
							var productId = '';
							
							$("##products-searched").empty();
							for (var i = 0, len = productArray.length; i < len; i++) {
								productName = productArray[i][0];
								productId = productArray[i][1];
								
								$("##products-searched").append('<option value="' + productId + '">' + productName + '</option>');
							}
						}
			});
		});
		
		$('##save-item').click(function() {  
			selectBox = document.getElementById("products-selected");

			for (var i = 0; i < selectBox.options.length; i++) 
			{ 
				 selectBox.options[i].selected = true; 
			} 
		}); 
		
		$('##add-all').click(function() {  
			$("##products-searched").each(function() {
				$('##products-searched option').remove().appendTo('##products-selected'); 
			});
		});  
		
		$('##remove-all').click(function() {  
			$("##products-selected").each(function() {
				$('##products-selected option').remove().appendTo('##products-searched'); 
			});  
		}); 

		$('##add').click(function() {  
			return !$('##products-searched option:selected').remove().appendTo('##products-selected').removeAttr("selected"); 
		});  
		
		$('##remove').click(function() {  
			return !$('##products-selected option:selected').remove().appendTo('##products-searched').removeAttr("selected"); 
		});		
		
		$('##edit-filter-confirm').click(function() {  
			if(filterChanged == true)
			{
				var newFilterArray = getNewFilterArray();
				var currentFilterArray = getCurrentFilterArray();
			
				for(var i=0;i<currentFilterArray.length;i++)
				{	
					if(filterFound(currentFilterArray[i],newFilterArray) == false)
					{
						removeFilter(currentFilterArray[i]);
					}
				}
				
				for(var j=0;j<newFilterArray.length;j++)
				{	
					if(filterFound(newFilterArray[j],currentFilterArray) == false)
					{
						addFilter(newFilterArray[j]);
					}
				}
								
				generateFilters();
				filterChanged = false;
			}			
		});	
		
		$('##filter-id').change(function() {
			filterChanged = true;
		});
		
		function getNewFilterArray() {
			var newFilterArray = []; 
			$('##filter-id :selected').each(function(i, selected){ 
				var filter = new Object();
				filter.fid = $(selected).val();
				filter.name = $(selected).text();
				filter.deleted = false;
				newFilterArray[i] = filter; 
			});
			
			return newFilterArray;
		}
		
		function getCurrentFilterArray() {			
			return filterArray.slice(0);
		}
		
		function filterFound(f, fArray) {
			var filterFound = false;
			
			for(var i=0;i<fArray.length;i++)
			{
				if(fArray[i].fid == f.fid && fArray[i].deleted == false)
				{
					filterFound = true;
					break;
				}
			}
			
			return filterFound;
		}
		
		function addFilter(f) {
			for(var i=0;i<filterArray.length;i++)
			{
				if(filterArray[i].fid == f.fid)
				{
					filterArray[i].deleted = false;
					filterArray[i].options = [];
					break;
				}
			}
		}
		
		function removeFilter(f) {
			for(var i=0;i<filterArray.length;i++)
			{
				if(filterArray[i].fid == f.fid)
				{
					filterArray[i].deleted = true;
					filterArray[i].options = [];
					break;
				}
			}
		}
		
		function addFilterOption(f, option) {
			
			for(var i=0;i<filterArray.length;i++)
			{
				if(filterArray[i].fid == f.fid)
				{
					filterArray[i].options.push(option);
					break;
				}
			}
		}
		
		function removeFilterOption(f, option) {
			
			for(var i=0;i<filterArray.length;i++)
			{
				if(filterArray[i].fid == f.fid)
				{
					var options = filterArray[i].options;
					for(var j=0;j<options.length;j++)
					{
						if(options[j].foid == option.foid)
						{
							options.splice(j, 1);
							break;
						}
					}
					break;
				}
			}
		}
		
		function generateFilters() {
			$('##filters').empty();
			
			var str = '';
			
			for(var i=0;i<filterArray.length;i++)
			{
				if(filterArray[i].deleted == false)
				{
					var options = filterArray[i].options;
					str = str + '<div class="col-xs-3"><div class="box box-warning"><div class="box-body table-responsive no-padding"><table class="table table-hover"><tr class="warning" id="tr-'+filterArray[i].fid+'"><th colspan="2">' + filterArray[i].name + '</th><th><a filterid="' + filterArray[i].fid + '" filtername="'+filterArray[i].name+'" class="add-new-filter-option pull-right" data-toggle="modal" data-target="##add-new-filter-option-modal" style="cursor:pointer;cursor:hand;"><span class="label label-primary">Add Option</span></a></th></tr>';
											
					for(var j=0;j<options.length;j++)
					{
						str = str + '<tr id="tr-ao-'+options[j].foid+'"><td><table><tr><td>' + options[j].value+'</td>';
						
						if(filterArray[i].name.toLowerCase() == 'color')
						{
							str = str + '<td><div style="margin-left:10px;width:15px;height:15px;border:1px solid ##CCC;background-color:'+options[j].value+';margin-top:2px;"></div></td>';
						}
						str = str + '</tr></table></td><td><div style="width:15px;height:15px;border:1px solid ';
						str = str + '##CCC';
						str = str + ';margin-top:4px;"><img src="'+options[j].imageSrc+'" style="width:100%;height:100%;vertical-align:top;" /></div></td>';
						
						str = str + '<td><a filterid='+filterArray[i].fid+' filteroptionid="'+options[j].foid+'" href="" class="delete-filter-option pull-right" data-toggle="modal" data-target="##delete-filter-option-modal" style="cursor:pointer;cursor:hand;"><span class="label label-danger">Delete</span></a></td></tr>';
					}
					str = str + '</table></div></div></div>';
				}
			}
			
			$('##filters').append(str);
		}
		
		$('##filters').on("click","a.add-new-filter-option", function(e) {
		
			$("##new-filter-id-hidden").val($(this).attr('filterid'));
			$("##new-filter-name-hidden").val($(this).attr('filtername'));
			
			if($(this).attr('filtername').toLowerCase() == 'color')
			{
				$("##new-filter-option-name-color").show();
				$("##new-filter-option-name").hide();
			}
			else
			{
				$("##new-filter-option-name-color").hide();
				$("##new-filter-option-name").show();
			}
		});
		
		var new_option_index = 1;
		
		$( "##add-new-filter-option-confirm" ).click(function() {
		
			var f = new Object();
			f.fid = $("##new-filter-id-hidden").val();
			
			var option = new Object();
			option.foid = 'new_' + new_option_index;
			option.fid = f.fid;
			option.value = $("##new-filter-option-name").val();
			option.imageName = 'no_image_available.png';
			option.imageSrc = '#APPLICATION.absoluteUrlSite#images/site/no_image_available.png';
			
			if($("##new-filter-name-hidden").val().toLowerCase() == 'color')
			{
				option.value = $("##new-filter-option-name-color").val();
			}
			
			if($("##new-filter-option-image-" + $('##image-coutnt-hidden').val()).val() != '')
			{
				loadThumbnail($("##new-filter-option-image-" + $('##image-coutnt-hidden').val())[0].files[0], function(image_src) { 
				
					option.imageName = $("##new-filter-option-image-" + $('##image-coutnt-hidden').val())[0].files[0].name;
					option.imageSrc = image_src;
					
					addFilterOption(f, option);
					generateFilters();
					
					$("##new-filter-option-name").val('');
					$("##new-filter-option-name-color").val('');
					
					new_option_index++;
					createNewImageUploader();
				});
			}
			else
			{
				addFilterOption(f, option);
				generateFilters();
				
				$("##new-filter-option-name").val('');
				$("##new-filter-option-name-color").val('');
				
				new_option_index++;
			}
		});
		
		function createNewImageUploader() {
		
			var imageCount = $('##image-coutnt-hidden').val();
			imageCount++;
			$('.filter-option-image-div').hide();
			$('##image-coutnt-hidden').val(imageCount);
			
			$('##filter-option-modal-div').append('<div class="form-group filter-option-image-div" style="margin-top:15px;" id="filter-option-image-div-'+imageCount+'"><div class="btn btn-success btn-file" style="width:150px;margin-right:20px;"><i class="fa fa-paperclip"></i> &nbsp;&nbsp;Add Image<input type="file" name="new_filter_option_image_'+imageCount+'" id="new-filter-option-image-'+imageCount+'"/></div></div>');
			$(".new-checkbox").iCheck({
				checkboxClass: 'icheckbox_minimal'
			});
		}
		
		$('##filters').on("click","a.delete-filter-option", function() {
			$("##deleted-filter-id-hidden").val($(this).attr('filterid'));
			$("##deleted-filter-option-id-hidden").val($(this).attr('filteroptionid'));
		});
		
		$( "##delete-filter-option-confirm" ).click(function() {		

			var f = new Object();
			var isLastOption = false;
			f.fid = $("##deleted-filter-id-hidden").val();
			
			var option = new Object();
			option.foid = $("##deleted-filter-option-id-hidden").val();
			
			isLastOption = removeFilterOption(f, option);
			generateFilters();
		});
		
		function loadThumbnail(file, callback) {
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onloadend = function () {
				callback(reader.result);
			}
		}
		
		function createHiddenField(n, v) {
			$('<input>').attr({
				type: 'hidden',
				name: n,
				value: v,
			}).appendTo('form');
		}
		
		function convertFilterArray() {
			var options = [];
			for(var i=0;i<filterArray.length;i++)
			{
				if(filterArray[i].deleted == false)
				{
					createHiddenField('c_filter_id', filterArray[i].fid);
					createHiddenField('c_filter_name_' + filterArray[i].fid, filterArray[i].name);
					
					options = filterArray[i].options;
					for(var j=0;j<options.length;j++)
					{
						createHiddenField('c_filter_option_id_' + filterArray[i].fid, options[j].foid);
						createHiddenField('c_filter_option_value_' + filterArray[i].fid + '_' + options[j].foid, options[j].value);
						createHiddenField('c_filter_option_imagename_' + filterArray[i].fid + '_' + options[j].foid, options[j].imageName);
					}
				}
			}
		}
		
		$('##save-item').click(function(){
			convertFilterArray();
			$('form[id=category-detail]').submit();
		});
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
<input type="hidden" name="image_count_hidden" id="image-coutnt-hidden" value="0" />

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
					<li class="tab-title #REQUEST.pageData.tabs['tab_7']#" tabid="tab_7"><a href="##tab_7" data-toggle="tab">Advertisement</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_8']#" tabid="tab_8"><a href="##tab_8" data-toggle="tab">Best Seller</a></li>
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
														<td><a href="#APPLICATION.absoluteUrlSite#admin/product_detail.cfm?id=#product[1].getProductId()#">View Detail</a></td>
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
					<div class="tab-pane #REQUEST.pageData.tabs['tab_7']#" id="tab_7">
						<div class="form-group">
							<div class="row">
								<cfif NOT IsNull(REQUEST.pageData.advertisementSection.getSectionData())>
									<cfloop array="#REQUEST.pageData.advertisementSection.getSectionData()#" index="ad">						
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
								<div id="ads_image">
									<p>Your browser doesn't have Flash, Silverlight or HTML5 support.</p>
								</div>
							</div>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_8']#" id="tab_8">
						<div class="row">
							<div class="col-xs-3" style="padding-right:0;">
								<select name="search_product_group_id" id="search-product-group-id" class="form-control">
									<option value="0">Choose Product Group ...</option>
									<cfloop array="#REQUEST.pageData.productGroups#" index="group">
										<option value="#group.getProductGroupId()#">#group.getDisplayName()#</option>
									</cfloop>
								</select>
							</div>
							<div class="col-xs-4" style="padding-right:0;">
								<select class="form-control" name="search_category_id" id="search-category-id">
									<option value="0">Choose Category ...</option>
									<cfloop array="#REQUEST.pageData.categoryTree#" index="cat">
										<option value="#cat.getCategoryId()#"
										<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),cat)>
										selected
										</cfif>
										>#RepeatString("&nbsp;",1)##cat.getDisplayName()#</option>
										<cfloop array="#cat.getSubCategories()#" index="subCat">
											<option value="#subCat.getCategoryId()#"
											<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),subCat)>
											selected
											</cfif>
											>#RepeatString("&nbsp;",11)##subCat.getDisplayName()#</option>
											<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
												<option value="#thirdCat.getCategoryId()#"
												<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),thirdCat)>
												selected
												</cfif>
												>#RepeatString("&nbsp;",21)##thirdCat.getDisplayName()#</option>
											</cfloop>
											</li>
										</cfloop>
										</li>
									</cfloop>
								</select>
							</div>
							<div class="col-xs-4" style="padding-right:0;padding-left:10px;">
								<input type="text" name="search_keywords" id="search-keywords" class="form-control" placeholder="Keywords">
							</div>
							<div class="col-xs-1" style="padding-left:10px;">
								<button name="search_product" id="search-product" type="button" class="btn btn-sm btn-primary search-button" style="width:100%">Search</button>
							</div>
						</div>
						<div class="row" style="margin-top:18px;">
							<div class="col-xs-5">	
								<select name="products_searched" id="products-searched" multiple class="form-control" style="height:270px;">
								</select>
							</div>
							<div class="col-xs-2" style="text-align:center;">
								<a class="btn btn-app" id="add-all">
									<i class="fa fa-angle-double-right"></i> Add All
								</a>
								<a class="btn btn-app" id="add">
									<i class="fa fa-angle-right"></i> Add
								</a>
								<a class="btn btn-app" id="remove">
									<i class="fa fa-angle-left"></i> Remove
								</a>
								<a class="btn btn-app" id="remove-all">
									<i class="fa fa-angle-double-left"></i> Remove All
								</a>
							</div>
							<div class="col-xs-5">	
								<select name="products_selected" id="products-selected" multiple class="form-control" style="height:270px;">
									<cfif NOT IsNull(REQUEST.pageData.bestSellerSection.getSectionData())>
										<cfloop array="#REQUEST.pageData.bestSellerSection.getSectionData()#" index="bs">	
											<cfset product = bs.getProduct() />
											<option value="#product.getProductId()#">#product.getDisplayName()#</option>
										</cfloop>
									</cfif>
								</select>
							</div>
						</div>
					</div><!-- /.tab-pane -->
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