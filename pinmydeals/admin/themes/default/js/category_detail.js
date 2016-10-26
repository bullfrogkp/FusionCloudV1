$(function() {

	"use strict";
	
	function getNewFilterArray() {
		var newFilterArray = []; 
		$('#filter-id :selected').each(function(i, selected){ 
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
		$('#filters').empty();
		
		var str = '';
		
		for(var i=0;i<filterArray.length;i++)
		{
			if(filterArray[i].deleted == false)
			{
				var options = filterArray[i].options;
				str = str + '<div class="col-xs-3"><div class="box box-warning"><div class="box-body table-responsive no-padding"><table class="table table-hover"><tr class="warning" id="tr-'+filterArray[i].fid+'"><th colspan="2">' + filterArray[i].name + '</th><th><a filterid="' + filterArray[i].fid + '" filtername="'+filterArray[i].name+'" class="add-new-filter-option pull-right" data-toggle="modal" data-target="#add-new-filter-option-modal" style="cursor:pointer;cursor:hand;"><span class="label label-primary">Add Option</span></a></th></tr>';
										
				for(var j=0;j<options.length;j++)
				{
					str = str + '<tr id="tr-ao-'+options[j].foid+'"><td><table><tr><td>' + options[j].value+'</td>';
					
					if(filterArray[i].name.toLowerCase() == 'color')
					{
						str = str + '<td><div style="margin-left:10px;width:15px;height:15px;border:1px solid #CCC;background-color:'+options[j].value+';margin-top:2px;"></div></td>';
					}
					str = str + '</tr></table></td><td><div style="width:15px;height:15px;border:1px solid ';
					str = str + '#CCC';
					str = str + ';margin-top:4px;"><img src="'+options[j].imageSrc+'" style="width:100%;height:100%;vertical-align:top;" /></div></td>';
					
					str = str + '<td><a filterid='+filterArray[i].fid+' filteroptionid="'+options[j].foid+'" href="" class="delete-filter-option pull-right" data-toggle="modal" data-target="#delete-filter-option-modal" style="cursor:pointer;cursor:hand;"><span class="label label-danger">Delete</span></a></td></tr>';
				}
				str = str + '</table></div></div></div>';
			}
		}
		
		$('#filters').append(str);
	}
	
	function createNewImageUploader() {
	
		var imageCount = $('#image-count-hidden').val();
		imageCount++;
		$('.filter-option-image-div').hide();
		$('#image-count-hidden').val(imageCount);
		
		$('#filter-option-modal-div').append('<div class="form-group filter-option-image-div" style="margin-top:15px;" id="filter-option-image-div-'+imageCount+'"><div class="btn btn-success btn-file" style="width:150px;margin-right:20px;"><i class="fa fa-paperclip"></i> &nbsp;&nbsp;Add Image<input type="file" name="new_filter_option_image_'+imageCount+'" id="new-filter-option-image-'+imageCount+'"/></div></div>');
		$(".new-checkbox").iCheck({
			checkboxClass: 'icheckbox_minimal'
		});
	}
	
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
			
	(function main(){
		$(function() {
			
			$(".tab-title").click(function() {
			  $("#tab-id").val($(this).attr('tabid'));
			});
			
			CKEDITOR.replace( 'custom_design',
			{
				filebrowserBrowseUrl :absoluteUrlThemeAdmin + 'js/plugins/ckeditor/filemanager/index.html',
				filebrowserImageBrowseUrl : absoluteUrlThemeAdmin + 'js/plugins/ckeditor/filemanager/index.html',
				filebrowserFlashBrowseUrl :absoluteUrlThemeAdmin + 'js/plugins/ckeditor/filemanager/index.html'}
			 );
			
			$("#uploader").plupload({
				// General settings
				runtimes: 'html5,flash,silverlight,html4',
				url: absoluteUrlSite + 'ajax/upload_category_images.cfm',
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
				$("#deleted-image-id").val($(this).attr('imageid'));
			});
			
			var new_filter_index = 1;
			
			$('#new-filter-option-name-color').colorpicker();
			
			$('#edit-filter-confirm').click(function() {  
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
			
			$('#filter-id').change(function() {
				filterChanged = true;
			});
			
			$('#filters').on("click","a.add-new-filter-option", function(e) {
			
				$("#new-filter-id-hidden").val($(this).attr('filterid'));
				$("#new-filter-name-hidden").val($(this).attr('filtername'));
				
				if($(this).attr('filtername').toLowerCase() == 'color')
				{
					$("#new-filter-option-name-color").show();
					$("#new-filter-option-name").hide();
				}
				else
				{
					$("#new-filter-option-name-color").hide();
					$("#new-filter-option-name").show();
				}
			});
			
			var new_option_index = 1;
			
			$( "#add-new-filter-option-confirm" ).click(function() {
			
				var f = new Object();
				f.fid = $("#new-filter-id-hidden").val();
				
				var option = new Object();
				option.foid = 'new_' + new_option_index;
				option.fid = f.fid;
				option.value = $("#new-filter-option-name").val();
				option.imageName = 'no_image_available.png';
				option.imageSrc = absoluteUrlThemeAdmin + 'images/site/no_image_available.png';
				
				if($("#new-filter-name-hidden").val().toLowerCase() == 'color')
				{
					option.value = $("#new-filter-option-name-color").val();
				}
				
				if($("#new-filter-option-image-" + $('#image-count-hidden').val()).val() != '')
				{
					loadThumbnail($("#new-filter-option-image-" + $('#image-count-hidden').val())[0].files[0], function(image_src) { 
					
						option.imageName = $("#new-filter-option-image-" + $('#image-count-hidden').val())[0].files[0].name;
						option.imageSrc = image_src;
						
						addFilterOption(f, option);
						generateFilters();
						
						$("#new-filter-option-name").val('');
						$("#new-filter-option-name-color").val('');
						
						new_option_index++;
						createNewImageUploader();
					});
				}
				else
				{
					addFilterOption(f, option);
					generateFilters();
					
					$("#new-filter-option-name").val('');
					$("#new-filter-option-name-color").val('');
					
					new_option_index++;
				}
			});
			
			$('#filters').on("click","a.delete-filter-option", function() {
				$("#deleted-filter-id-hidden").val($(this).attr('filterid'));
				$("#deleted-filter-option-id-hidden").val($(this).attr('filteroptionid'));
			});
			
			$( "#delete-filter-option-confirm" ).click(function() {		

				var f = new Object();
				var isLastOption = false;
				f.fid = $("#deleted-filter-id-hidden").val();
				
				var option = new Object();
				option.foid = $("#deleted-filter-option-id-hidden").val();
				
				isLastOption = removeFilterOption(f, option);
				generateFilters();
			});
			
			$('#save-item').click(function() {  
				convertFilterArray();
				$('.nav-tabs-custom').append('<div id="loading-overlay" class="overlay"></div><div class="loading-img"></div>');
				
				var url = absoluteUrlSite + 'ajax/page.cfc';
				var myform = document.getElementById("category-detail");
				var fd = new FormData(myform );
				
				fd.pageName = 'category_detail';

				$.ajax({
						type: "post",
						url: "http://admin.pinmydeals.loc/ajax/page.cfc",
						dataType: 'json',
						data: {
							method: 'validate',
							pageName: 'category_detail'
						}
				})
				.done(function(data) {		
					var str = '<div class="alert warning alert-dismissable"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>';
					
					for(var i=0;i<data.MESSAGEARRAY.length;i++) {
						str += data.MESSAGEARRAY[i] + '<br/>';
					}
					
					str += '</div>';
					$("#messages").html(str); 
					$("#loading-overlay").remove();
					$("#loading-img").remove();
				})
				.fail(function(data) {
					alert( "error" );
				})
				.always(function(data) {
				});
			});
		});
	})();
});