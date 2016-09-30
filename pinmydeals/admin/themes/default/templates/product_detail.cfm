<cfoutput>

<script>
	$(document).ready(function() {
	
		var attributeChanged = false;
	
		CKEDITOR.replace( 'detail',
		{
			filebrowserBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserImageBrowseUrl : '#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserFlashBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html'}
		 );
		
		$(".top-level-tab").click(function() {
		  $("##tab_id").val($(this).attr('tabid'));
		});
				
		$("##uploader").plupload({
			// General settings
			runtimes: 'html5,flash,silverlight,html4',
			
			url: "#APPLICATION.absoluteUrlSite#admin/ajax/upload_product_images.cfm",

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
		
		$('.date').datepicker();
		$('##new-attribute-option-name-color').colorpicker();
				
		$( ".delete-attribute-option-value" ).click(function() {
			$("##sub_product_id").val($(this).attr('subproductid'));
		});
		
		$( ".delete-related-product" ).click(function() {
			$("##delete_related_product_id").val($(this).attr('relatedproductid'));
		});
				
		$('##attribute-options').on("click","a.add-new-attribute-option", function(e) {
		
			$("##new-attribute-id-hidden").val($(this).attr('attributeid'));
			$("##new-attribute-name-hidden").val($(this).attr('attributename'));
			
			if($(this).attr('attributename').toLowerCase() == 'color')
			{
				$("##new-attribute-option-name-color").show();
				$("##new-attribute-option-name").hide();
			}
			else
			{
				$("##new-attribute-option-name-color").hide();
				$("##new-attribute-option-name").show();
			}
		});
		
		var new_option_index = 1;
		var thumb = false;
		
		$('##generate-thumbnail').on('ifChecked', function(event){
			thumb = true;
		});
		
		$( "##add-new-attribute-option-confirm" ).click(function() {
		
			var isFirstOption = false;
			
			var attr = new Object();
			attr.aid = $("##new-attribute-id-hidden").val();
			
			var option = new Object();
			option.aoid = 'new_' + new_option_index;
			option.aid = attr.aid;
			option.value = $("##new-attribute-option-name").val();
			option.imageName = 'no_image_available.png';
			option.imageSrc = '#APPLICATION.absoluteUrlSite#images/site/no_image_available.png';
			option.hasThumbnail = thumb;
			
			if($("##new-attribute-name-hidden").val().toLowerCase() == 'color')
			{
				option.value = $("##new-attribute-option-name-color").val();
			}
			
			if($("##new-attribute-option-image-" + $('##image-coutnt-hidden').val()).val() != '')
			{
				loadThumbnail($("##new-attribute-option-image-" + $('##image-coutnt-hidden').val())[0].files[0], function(image_src) { 
				
					option.imageName = $("##new-attribute-option-image-" + $('##image-coutnt-hidden').val())[0].files[0].name;
					option.imageSrc = image_src;
					
					isFirstOption = addAttributeOption(attr, option);
					generateAttributes();
					if(isFirstOption)
						generateAllSubProducts();
					else
						generateSubProducts(attr, option);
					
					$("##new-attribute-option-name").val('');
					$("##new-attribute-option-name-color").val('');
					$("##generate-thumbnail").iCheck('uncheck');
					thumb = false
					
					new_option_index++;
					createNewImageUploader();
				});
			}
			else
			{
				isFirstOption = addAttributeOption(attr, option);
				generateAttributes();
				if(isFirstOption)
					generateAllSubProducts();
				else
					generateSubProducts(attr, option);
				
				$("##new-attribute-option-name").val('');
				$("##new-attribute-option-name-color").val('');
				$("##generate-thumbnail").iCheck('uncheck');
				thumb = false
				
				new_option_index++;
			}
		});
		
		$('##attribute-options').on("click","a.delete-attribute-option", function() {
			$("##deleted-attribute-id-hidden").val($(this).attr('attributeid'));
			$("##deleted-attribute-option-id-hidden").val($(this).attr('attributeoptionid'));
		});
		
		$( "##delete-attribute-option-confirm" ).click(function() {		

			var attr = new Object();
			var isLastOption = false;
			attr.aid = $("##deleted-attribute-id-hidden").val();
			
			var option = new Object();
			option.aoid = $("##deleted-attribute-option-id-hidden").val();
			
			isLastOption = removeAttributeOption(attr, option);
			generateAttributes();
			if(isLastOption)
				generateAllSubProducts();
			else
				removeSubProducts(attr, option);
		});
		
		function createNewImageUploader() {
		
			var imageCount = $('##image-coutnt-hidden').val();
			imageCount++;
			$('.attribute-option-image-div').hide();
			$('##image-coutnt-hidden').val(imageCount);
			
			$('##attribute-option-modal-div').append('<div class="form-group attribute-option-image-div" style="margin-top:15px;" id="attribute-option-image-div-'+imageCount+'"><div class="btn btn-success btn-file" style="width:150px;margin-right:20px;"><i class="fa fa-paperclip"></i> &nbsp;&nbsp;Add Image<input type="file" name="new_attribute_option_image_'+imageCount+'" id="new-attribute-option-image-'+imageCount+'"/></div><input type="checkbox" class="form-control new-checkbox" name="generate_thumbnail_'+imageCount+'" id="generate-thumbnail-'+imageCount+'" value="1"/> Generate Image Thumbnail</div>');
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
		
		$( ".delete-image" ).click(function() {
			$("##deleted_image_id").val($(this).attr('imageid'));
		});
				
		$( ".delete-video" ).click(function() {
			$("##deleted_product_video_id").val($(this).attr('productvideoid'));
		});
		
		$( ".add-single-group-price" ).click(function() {
			$("##add_customer_group_id").val($(this).attr('customergroupid'));
		});
		
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

		$("##category-id").attr("size",$("##category-id option").length);
		
		$('##product-type-single').on('ifChecked', function(event){
			$('##single-product').show();
			$('##configurable-product').hide();
		});
		
		$('##product-type-configurable').on('ifChecked', function(event){
			$('##single-product').hide();
			$('##configurable-product').show();
		});
		
		var attributeArray = new Array();
		<cfloop array="#REQUEST.pageData.attributes#" index="attribute">
			var attribute = new Object();
			var attributeOptions = new Array();
			attribute.aid = '#attribute.getAttributeId()#';
			attribute.name = '#attribute.getDisplayName()#';
			
			<cfif ListFind(REQUEST.pageData.attributeList,attribute.getAttributeId())>
				attribute.deleted = false;
				
				<cfset productAttributeRela = EntityLoad("product_attribute_rela", {product = REQUEST.pageData.product, attribute = attribute}, true) />
				
				<cfloop array="#productAttributeRela.getAttributeValues()#" index="attributeValue">
					var attributeOption = new Object();
					attributeOption.aoid = '#attributeValue.getAttributeValueId()#';
					attributeOption.value = '#attributeValue.getValue()#';
					attributeOption.imageName = '#attributeValue.getImageName()#';
					attributeOption.imageSrc = '#attributeValue.getImageLink(type = "thumbnail")#';
					<cfif attributeValue.getHasThumbnail()>
						attributeOption.hasThumbnail = true;
					<cfelse>
						attributeOption.hasThumbnail = false;
					</cfif>
					attributeOptions.push(attributeOption);
				</cfloop>
			<cfelse>
				attribute.deleted = true;
			</cfif>
			
			attribute.options = attributeOptions;
			attributeArray.push(attribute);
		</cfloop>
		
		var subProductArray = [];
		var result = new Object();
		<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.subProducts)>
			<cfloop array="#REQUEST.pageData.subProducts#" index="p">
				result = new Object();
				result.productId = '#p.getProductId()#';
				result.sku = '#p.getSku()#';
				result.stock = '#p.getStock()#';
				
				<cfif p.getIsEnabled() EQ true>
					result.enabled = true;
				<cfelse>
					result.enabled = false;
				</cfif>
				
				<cfif p.getUseAdvancedPrices() EQ true>
					result.advancedPrice = true;
				<cfelse>
					result.advancedPrice = false;
				</cfif>
				result.groupPrices = new Object();
				
				<cfloop array="#p.getProductCustomerGroupRelas()#" index="rela">	
					_group = new Object();
					_group.price = '#rela.getPrice()#';
					_group.specialPrice = '#rela.getSpecialPrice()#';
					_group.fromDate = '#DateFormat(rela.getSpecialPriceFromDate(),"yyyy-mm-dd")#';
					_group.toDate = '#DateFormat(rela.getSpecialPriceToDate(),"yyyy-mm-dd")#';
					result.groupPrices['sub_#rela.getCustomerGroup().getCustomerGroupId()#'] = _group;
				</cfloop>

				_options = [];
					
				<cfloop array="#REQUEST.pageData.product.getProductAttributeRelas()#" index="rela">
					<cfif NOT ArrayIsEmpty(rela.getAttributeValues())>
						<cfset attributeValue = rela.getAttributeValues()[1] />
						var attr = new Object();
						attr.aid = '#rela.getAttribute().getAttributeId()#';
						attr.name = '#rela.getAttribute().getDisplayName()#';
						attr.value = '#attributeValue.getValue()#';
						attr.aoid = #attributeValue.getAttributeValueId()#;
					
						_options.push(attr);
					</cfif>
				</cfloop>

				result.options = _options;
				
				subProductArray.push(result);
			</cfloop>
		</cfif>
		
		var newSubProductId = 0;
		
		$('.c-sub-product-use-advanced-price').on('ifChecked', function(event){
			for(var i=0;i<subProductArray.length;i++)
			{
				if(subProductArray[i].productId == $(this).attr('productid'))
				{
					subProductArray[i].advancedPrice = true;
					break;
				}
			}
		});
		
		$('.c-sub-product-use-advanced-price').on('ifUnchecked', function(event){
			for(var i=0;i<subProductArray.length;i++)
			{
				if(subProductArray[i].productId == $(this).attr('productid'))
				{
					subProductArray[i].advancedPrice = false;
					break;
				}
			}
		});
		
		$('.enable-sub-product').on('ifChecked', function(event){
			for(var i=0;i<subProductArray.length;i++)
			{
				if(subProductArray[i].productId == $(this).attr('productid'))
				{
					subProductArray[i].enabled = true;
					break;
				}
			}
		});
		
		
		$('.enable-sub-product').on('ifUnchecked', function(event){
			for(var i=0;i<subProductArray.length;i++)
			{
				if(subProductArray[i].productId == $(this).attr('productid'))
				{
					subProductArray[i].enabled = false;
					break;
				}
			}
		});
		
		$('##single-advanced-price-settings').on('ifChecked', function(event){
			$('##single-simple-price-section').hide();
			$('##single-advanced-price-section').show();
		});
		
		$('##single-advanced-price-settings').on('ifUnchecked', function(event){
			$('##single-simple-price-section').show();
			$('##single-advanced-price-section').hide();
		});
				
		$('##sub-products').on("click","a.c-sub-product-advanced-product-price", function() {
			$('##edit-sub-product-id-hidden').val($(this).attr('productid'));
			
			$('.advanced-price-tab').removeClass('active');
			$('.advanced-price-tab-content').removeClass('active');
			$('##advanced-price-tab-#REQUEST.pageData.defaultCustomerGroup.getCustomerGroupId()#').addClass('active');
			$('##advanced-price-tab-content-#REQUEST.pageData.defaultCustomerGroup.getCustomerGroupId()#').addClass('active');
			
			for(var i=0;i<subProductArray.length;i++)
			{
				if(subProductArray[i].productId == $(this).attr('productid'))
				{
					<cfloop array="#REQUEST.pageData.customerGroups#" index="group">
						$('##advanced-price-#group.getCustomerGroupId()#').val(subProductArray[i].groupPrices['sub_#group.getCustomerGroupId()#'].price);
						$('##advanced-special-price-#group.getCustomerGroupId()#').val(subProductArray[i].groupPrices['sub_#group.getCustomerGroupId()#'].specialPrice);
						$('##advanced-from-date-#group.getCustomerGroupId()#').val(subProductArray[i].groupPrices['sub_#group.getCustomerGroupId()#'].fromDate);
						$('##advanced-to-date-#group.getCustomerGroupId()#').val(subProductArray[i].groupPrices['sub_#group.getCustomerGroupId()#'].toDate);
					</cfloop>
					break;
				}
			}
		});
		
		$('##edit-advanced-price-confirm').click(function() { 
			for(var i=0;i<subProductArray.length;i++)
			{
				if(subProductArray[i].productId == $('##edit-sub-product-id-hidden').val())
				{
					<cfloop array="#REQUEST.pageData.customerGroups#" index="group">
						subProductArray[i].groupPrices['sub_#group.getCustomerGroupId()#'].price = $('##advanced-price-#group.getCustomerGroupId()#').val();
						subProductArray[i].groupPrices['sub_#group.getCustomerGroupId()#'].specialPrice = $('##advanced-special-price-#group.getCustomerGroupId()#').val();
						subProductArray[i].groupPrices['sub_#group.getCustomerGroupId()#'].fromDate = $('##advanced-from-date-#group.getCustomerGroupId()#').val();
						subProductArray[i].groupPrices['sub_#group.getCustomerGroupId()#'].toDate = $('##advanced-to-date-#group.getCustomerGroupId()#').val();
					</cfloop>
					break;
				}
			}
		});
		
		$('##edit-attribute-confirm').click(function() {  
			if(attributeChanged == true)
			{
				var newAttributeArray = getNewAttributeArray();
				var currentAttributeArray = getCurrentAttributeArray();
			
				for(var i=0;i<currentAttributeArray.length;i++)
				{	
					if(attributeFound(currentAttributeArray[i],newAttributeArray) == false)
					{
						removeAttribute(currentAttributeArray[i]);
					}
				}
				
				for(var j=0;j<newAttributeArray.length;j++)
				{	
					if(attributeFound(newAttributeArray[j],currentAttributeArray) == false)
					{
						addAttribute(newAttributeArray[j]);
					}
				}
								
				generateAttributes();
				generateAllSubProducts();
				attributeChanged = false;
			}			
		});	
		
		$('##attribute-id').change(function() {
			attributeChanged = true;
		});
		
		function getNewAttributeArray() {
			var newAttributeArray = []; 
			$('##attribute-id :selected').each(function(i, selected){ 
				var attribute = new Object();
				attribute.aid = $(selected).val();
				attribute.name = $(selected).text();
				attribute.deleted = false;
				newAttributeArray[i] = attribute; 
			});
			
			return newAttributeArray;
		}
		
		function getCurrentAttributeArray() {			
			return attributeArray.slice(0);
		}
		
		function attributeFound(attr, attrArray) {
			var attributeFound = false;
			
			for(var i=0;i<attrArray.length;i++)
			{
				if(attrArray[i].aid == attr.aid && attrArray[i].deleted == false)
				{
					attributeFound = true;
					break;
				}
			}
			
			return attributeFound;
		}
		
		function addAttribute(attr) {
			for(var i=0;i<attributeArray.length;i++)
			{
				if(attributeArray[i].aid == attr.aid)
				{
					attributeArray[i].deleted = false;
					attributeArray[i].options = [];
					break;
				}
			}
		}
		
		function removeAttribute(attr) {
			for(var i=0;i<attributeArray.length;i++)
			{
				if(attributeArray[i].aid == attr.aid)
				{
					attributeArray[i].deleted = true;
					attributeArray[i].options = [];
					break;
				}
			}
		}
		
		function addAttributeOption(attr, option) {
			var isFirstOption = false;
			
			for(var i=0;i<attributeArray.length;i++)
			{
				if(attributeArray[i].aid == attr.aid)
				{
					if(attributeArray[i].options.length == 0)
					{
						isFirstOption = true;
					}
					attributeArray[i].options.push(option);
					break;
				}
			}
			return isFirstOption;
		}
		
		function removeAttributeOption(attr, option) {
			var isLastOption = false;
			
			for(var i=0;i<attributeArray.length;i++)
			{
				if(attributeArray[i].aid == attr.aid)
				{
					var options = attributeArray[i].options;
					for(var j=0;j<options.length;j++)
					{
						if(options[j].aoid == option.aoid)
						{
							options.splice(j, 1);
							if(attributeArray[i].options.length == 0)
							{
								isLastOption = true;
							}
							break;
						}
					}
					break;
				}
			}
			return isLastOption;
		}
		
		function generateAttributes() {
			$('##attribute-options').empty();
			
			var str = '';
			
			for(var i=0;i<attributeArray.length;i++)
			{
				if(attributeArray[i].deleted == false)
				{
					var options = attributeArray[i].options;
					str = str + '<div class="col-xs-3"><div class="box box-warning"><div class="box-body table-responsive no-padding"><table class="table table-hover"><tr class="warning" id="tr-'+attributeArray[i].aid+'"><th colspan="2">' + attributeArray[i].name + '</th><th><a attributeid="' + attributeArray[i].aid + '" attributename="'+attributeArray[i].name+'" class="add-new-attribute-option pull-right" data-toggle="modal" data-target="##add-new-attribute-option-modal" style="cursor:pointer;cursor:hand;"><span class="label label-primary">Add Option</span></a></th></tr>';
											
					for(var j=0;j<options.length;j++)
					{
						str = str + '<tr id="tr-ao-'+options[j].aoid+'"><td><table><tr><td>' + options[j].value+'</td>';
						
						if(attributeArray[i].name.toLowerCase() == 'color')
						{
							str = str + '<td><div style="margin-left:10px;width:15px;height:15px;border:1px solid ##CCC;background-color:'+options[j].value+';margin-top:4px;"></div></td>';
						}
						str = str + '</tr></table></td><td><div style="width:15px;height:15px;border:1px solid ';
						
						if(options[j].hasThumbnail == false)
							str = str + '##CCC';
						else
							str = str + 'red';
				
						str = str + ';margin-top:4px;"><img src="'+options[j].imageSrc+'" style="width:100%;height:100%;vertical-align:top;" /></div></td>';
						
						str = str + '<td><a attributeid='+attributeArray[i].aid+' attributeoptionid="'+options[j].aoid+'" href="" class="delete-attribute-option pull-right" data-toggle="modal" data-target="##delete-attribute-option-modal" style="cursor:pointer;cursor:hand;"><span class="label label-danger">Delete</span></a></td></tr>';
					}
					str = str + '</table></div></div></div>';
				}
			}
			
			$('##attribute-options').append(str);
		}
		
		function generateAllSubProducts() {
			subProductArray = createArrayPermutation(attributeArray);
			
			var str = '';
			var emptyOption = true;
			
			str += '<div class="form-group"><label>Product(s)</label><table class="table table-bordered table-hover" id="sub-products-table"><tr class="warning">';
			
			for(var i=0;i<attributeArray.length;i++)
			{
				if(attributeArray[i].deleted == false && attributeArray[i].options.length > 0)
				{
					str += '<th>' + attributeArray[i].name + '</th>';
					emptyOption = false;
				}
			}
			
			str += '<th>Sku</th><th>Stock</th><th>Price</th><th>Special Price</th><th style="width:110px;">Advanced</th><th style="width:10px;">Enabled</th></tr>';
			
			for(var i=0;i<subProductArray.length;i++)
			{
				str += generateRow(subProductArray[i]);
			}
			
			if(emptyOption == false)
				$('##sub-products').html(str);
			else
				$('##sub-products').empty();
				
			$(".new-checkbox").iCheck({
				checkboxClass: 'icheckbox_minimal'
			});
		}
		
		function generateSubProducts(attr, option) {
		
			var newArr = $.extend(true, [], attributeArray);;
			
			for(var i=0;i<newArr.length;i++)
			{
				if(newArr[i].aid == attr.aid)
				{
					newArr[i].options = [];
					newArr[i].options.push(option);
					break;
				}
			}
		
			var arr = createArrayPermutation(newArr);
			
			subProductArray = subProductArray.concat(arr);
			
			var str = '';
			
			for(var i=0;i<arr.length;i++)
			{
				str += generateRow(arr[i]);
			}
			
			$('##sub-products-table').append(str);
			
			$(".new-checkbox").iCheck({
				checkboxClass: 'icheckbox_minimal'
			});
		}
		
		function removeSubProducts(attr, option) {
			var cls = 'tr-ao-' + option.aoid;
			var options = [];
			
			$('.' + cls).each(function( index ) {
			  $(this).parent().remove();
			});
			
			for(var i=0;i<subProductArray.length;i++)
			{
				options = subProductArray[i].options;
				
				for(var j=0;j<options.length;j++)
				{
					if(option.aoid == options[j].aoid)
					{
						subProductArray = subProductArray.slice(i,1);
						break;
					}
				}
			}
		}
				
		function generateRow(subProduct) {
			var str = 	'<tr>';
			var cls = '';
							
			for(var i=0;i<subProduct.options.length;i++)
			{
				str = str + '<td><table><tr><td>' + subProduct.options[i].value + '</td>';
				if(subProduct.options[i].name.toLowerCase() == 'color')
					str = str + '<td><div class="pull-left" style="margin-left:10px;width:15px;height:15px;border:1px solid ##CCC;background-color:'+subProduct.options[i].value+';margin-top:4px;"></div></td>';
				str = str + '</tr></table></td>';
				
				cls += 'tr-ao-' + subProduct.options[i].aoid + ' ';
			}
							
			str = str + '<td class="'+cls+'"><input name="c_sub_product_sku_'+subProduct.productId+'" value="'+subProduct.sku+'" style="width:100%;" /></td><td><input name="c_sub_product_stock_'+subProduct.productId+'" value="'+subProduct.stock+'" style="width:100%;" /></td><td><input name="c_sub_product_simple_price_'+subProduct.productId+'" value="'+subProduct.groupPrices['sub_#REQUEST.pageData.defaultCustomerGroup.getCustomerGroupId()#'].price+'" style="width:100%;"/></td><td><input name="c_sub_product_simple_special_price_'+subProduct.productId+'" value="'+subProduct.groupPrices['sub_#REQUEST.pageData.defaultCustomerGroup.getCustomerGroupId()#'].specialPrice+'" style="width:100%;"/></td><td><div class="pull-left" style="margin-right:10px;"><input type="checkbox" class="form-control c-sub-product-use-advanced-price new-checkbox" productid="'+subProduct.productId+'" name="c_sub_product_use_advanced_price_'+subProduct.productId+'" value="1" /></div><a productid="'+subProduct.productId+'" class="c-sub-product-advanced-product-price pull-left" data-toggle="modal" data-target="##advanced-price-modal" style="cursor:pointer;cursor:hand;"><span class="label label-danger">Advanced</span></a></td><td style="text-align:right;"><input type="checkbox" class="form-control enable-sub-product new-checkbox" name="c_sub_product_enabled_'+subProduct.productId+'" id="c-sub-product-enabled-'+subProduct.productId+'" value="1" /></td></tr>';
			
			return str;
		}
		
		function createHiddenField(n, v) {
			$('<input>').attr({
				type: 'hidden',
				name: n,
				value: v,
			}).appendTo('form');
		}
		
		function convertAttributeArray() {
			var options = [];
			for(var i=0;i<attributeArray.length;i++)
			{
				if(attributeArray[i].deleted == false)
				{
					createHiddenField('c_attribute_id', attributeArray[i].aid);
					createHiddenField('c_attribute_name_' + attributeArray[i].aid, attributeArray[i].name);
					
					options = attributeArray[i].options;
					for(var j=0;j<options.length;j++)
					{
						createHiddenField('c_attribute_option_id_' + attributeArray[i].aid, options[j].aoid);
						createHiddenField('c_attribute_option_value_' + attributeArray[i].aid + '_' + options[j].aoid, options[j].value);
						createHiddenField('c_attribute_option_imagename_' + attributeArray[i].aid + '_' + options[j].aoid, options[j].imageName);
						createHiddenField('c_attribute_option_hasthumbnail_' + attributeArray[i].aid + '_' + options[j].aoid, options[j].hasThumbnail);
					}
				}
			}
		}
		
		function convertSubProductArray() {
			
			var groupPrices = new Object();
			var options = [];
			
			for(var i=0;i<subProductArray.length;i++)
			{
				createHiddenField('c_sub_product_id', subProductArray[i].productId);
				
				options = subProductArray[i].options;
				groupPrices = subProductArray[i].groupPrices;
				
				for(var j=0;j<options.length;j++)
				{
					createHiddenField('c_sub_product_attribute_option_id_' + subProductArray[i].productId, options[j].aoid);
					createHiddenField('c_sub_product_attribute_option_attribute_id_' + subProductArray[i].productId + '_' + options[j].aoid, options[j].aid);
					createHiddenField('c_sub_product_attribute_option_value_' + subProductArray[i].productId + '_' + options[j].aoid, options[j].value);
				}
				
				for(var key in groupPrices) {
					if(groupPrices.hasOwnProperty(key)) {
						createHiddenField('c_sub_product_price_' + subProductArray[i].productId + '_' + key, groupPrices[key].price);
						createHiddenField('c_sub_product_specialprice_' + subProductArray[i].productId + '_' + key, groupPrices[key].specialPrice);
						createHiddenField('c_sub_product_fromdate_' + subProductArray[i].productId + '_' + key, groupPrices[key].fromDate);
						createHiddenField('c_sub_product_todate_' + subProductArray[i].productId + '_' + key, groupPrices[key].toDate);
					}
				}
			}
		}
		
		function createArrayPermutation(attributeArray) {
			var results = [];
			var result = '';
			var _arrayslen = attributeArray.length;
			var _size = (_arrayslen) ? 1 : 0;
			var _array = '';
			var x = 0;
			var i = 0;
			var j = 0;
			var _current = [];
			var _options = [];
			var _group = new Object();
		
			for (x=0; x < _arrayslen; x++) {
				if(attributeArray[x].deleted == false && attributeArray[x].options.length > 0)
				{
					_size = _size * attributeArray[x].options.length;
					_current[x] = 0;
				}
			}

			for (i=0; i < _size; i++) {
				result = new Object();
				result.productId = 'new_sub_product_' + newSubProductId;
				result.sku = '';
				result.stock = '';
				result.enabled = false;
				result.advancedPrice = false;
				result.groupPrices = new Object();
				
				<cfloop array="#REQUEST.pageData.customerGroups#" index="group">
					_group = new Object();
					_group.price = '';
					_group.specialPrice = '';
					_group.fromDate = '';
					_group.toDate = '';
					result.groupPrices['sub_#group.getCustomerGroupId()#'] = _group;
				</cfloop>

				_options = [];
				
				for (j=0; j < _arrayslen; j++) {
					
					if(attributeArray[j].deleted == false)
					{
						if(attributeArray[j].options.length > 0)
						{
							var attr = new Object();
							attr.aid = attributeArray[j].aid;
							attr.name = attributeArray[j].name;
							attr.value = attributeArray[j].options[_current[j]].value;
							attr.aoid = attributeArray[j].options[_current[j]].aoid;
						
							_options.push(attr);
						}
					}
				}

				result.options = _options;
				
				results.push(result);
					
				for (j=_arrayslen-1; j >= 0; j--) {
					if (attributeArray[j].options.length > (_current[j] + 1))  {
						_current[j]++;
						break;
					}
					else {
						_current[j] = 0;
					}
				}
				
				newSubProductId++;
			}

			return results;
		}
		
		$('##save-item').click(function(){
			convertAttributeArray();
			convertSubProductArray();
			$('form[id=product-detail]').submit();
		});
	});
</script>

<section class="content-header">
	<h1>
		Product Detail
		<small>product information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Product Detail</li>
	</ol>
</section>

<!-- Main content -->
<form id="product-detail" method="post" enctype="multipart/form-data">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.formData.id#" />
<input type="hidden" name="tab_id" id="tab_id" value="#REQUEST.pageData.tabs.activeTabId#" />
<input type="hidden" name="sub_product_id" id="sub_product_id" value="" />
<input type="hidden" name="new_attribute_imagename" id="new_attribute_imagename" value="" />
<input type="hidden" name="product_shipping_method_rela_id" id="product_shipping_method_rela_id" value="" />
<input type="hidden" name="deleted_image_id" id="deleted_image_id" value="" />
<input type="hidden" name="edit_product_customer_group_rela_id" id="edit_product_customer_group_rela_id" value="" />
<input type="hidden" name="deleted_product_customer_group_rela_id" id="deleted_product_customer_group_rela_id" value="" />
<input type="hidden" name="deleted_product_video_id" id="deleted_product_video_id" value="" />
<input type="hidden" name="add_customer_group_id" id="add_customer_group_id" value="" />
<input type="hidden" name="new_attribute_id_hidden" id="new-attribute-id-hidden" value="" />
<input type="hidden" name="new_attribute_name_hidden" id="new-attribute-name-hidden" value="" />
<input type="hidden" name="deleted_attribute_id_hidden" id="deleted-attribute-id-hidden" value="" />
<input type="hidden" name="deleted_attribute_option_id_hidden" id="deleted-attribute-option-id-hidden" value="" />
<input type="hidden" name="edit_sub_product_id_hidden" id="edit-sub-product-id-hidden" value="" />
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
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_1']#" tabid="tab_1"><a href="##tab_1" data-toggle="tab">General Information</a></li>
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_2']#" tabid="tab_2"><a href="##tab_2" data-toggle="tab">Meta Data</a></li>
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_4']#" tabid="tab_4"><a href="##tab_4" data-toggle="tab">Images</a></li>
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_8']#" tabid="tab_8"><a href="##tab_8" data-toggle="tab">Shipping</a></li>
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_9']#" tabid="tab_9"><a href="##tab_9" data-toggle="tab">Video</a></li>
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_6']#" tabid="tab_6"><a href="##tab_6" data-toggle="tab">Related Products</a></li>
					<li class="tab-title top-level-tab #REQUEST.pageData.tabs['tab_7']#" tabid="tab_7"><a href="##tab_7" data-toggle="tab">Reviews</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane #REQUEST.pageData.tabs['tab_1']#" id="tab_1">
						 <div class="form-group">
							<label>Product Name</label>&nbsp;&nbsp;(required)
							<input name="display_name" id="display-name" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.display_name#"/>
						</div>
						<div class="form-group">
							<label>Category</label>&nbsp;&nbsp;(required)
							<select class="form-control" multiple name="category_id" id="category-id">
								<cfloop array="#REQUEST.pageData.categoryTree#" index="cat">
									<option value="#cat.getCategoryId()#"
									<cfif IsNull(REQUEST.pageData.formData.category_id) AND NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),cat)
										OR
										NOT IsNull(REQUEST.pageData.formData.category_id) AND ListFind(REQUEST.pageData.formData.category_id, cat.getCategoryId())>
									selected
									</cfif>
									>#RepeatString("&nbsp;",1)##cat.getDisplayName()#</option>
									<cfloop array="#cat.getSubCategories()#" index="subCat">
										<option value="#subCat.getCategoryId()#"
										<cfif IsNull(REQUEST.pageData.formData.category_id) AND NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),subCat)
											OR
											NOT IsNull(REQUEST.pageData.formData.category_id) AND ListFind(REQUEST.pageData.formData.category_id, subCat.getCategoryId())>
										selected
										</cfif>
										>#RepeatString("&nbsp;",11)##subCat.getDisplayName()#</option>
										<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
											<option value="#thirdCat.getCategoryId()#"
											<cfif IsNull(REQUEST.pageData.formData.category_id) AND NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),thirdCat)
												OR
												NOT IsNull(REQUEST.pageData.formData.category_id) AND ListFind(REQUEST.pageData.formData.category_id, thirdCat.getCategoryId())>
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
						<div class="form-group">
							<cfloop array="#REQUEST.pageData.specialCategories#" index="spCategory">
							<input name="category_id" value="#spCategory.getCategoryId()#" type="checkbox" class="form-control"
							<cfif IsNull(REQUEST.pageData.formData.category_id) AND NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),spCategory)
								OR
								NOT IsNull(REQUEST.pageData.formData.category_id) AND ListFind(REQUEST.pageData.formData.category_id, spCategory.getCategoryId())>
							checked
							</cfif>
							/>
							&nbsp;&nbsp;#spCategory.getDisplayName()##RepeatString("&nbsp;",11)#
							</cfloop>
						</div>
						<div class="form-group">
							<label>Product Type</label>&nbsp;&nbsp;(required)
							<table class="table table-hover">
								<tr>
									<td style="width:10px;">
										<input type="radio" name="product_type" id="product-type-single" value="single" class="form-control"
										
										<cfif IsNull(REQUEST.pageData.product) OR REQUEST.pageData.product.getProductType().getName() EQ "single">
										checked
										</cfif>
										
										>
									</td>
									<td>Single</td>
								</tr>
								<tr id="single-product" style="
								
								<cfif NOT (IsNull(REQUEST.pageData.product) OR REQUEST.pageData.product.getProductType().getName() EQ "single")>
								display:none;
								</cfif>
								
								">
									<td></td>
									<td>
										<div class="form-group">
											<label>SKU</label>
											<input name="single_sku" id="single-sku" type="text" style="width:100%" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.single_sku#"/>
										</div>
										<div class="form-group">
											<label>Stock</label>
											<input name="single_stock" id="single-stock" type="text" style="width:100%" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.single_stock#"/>
										</div>
										
										<div id="single-simple-price-section" <cfif  NOT IsNull(REQUEST.pageData.product) AND REQUEST.pageData.product.getUseAdvancedPrices() NEQ false>style="display:none;"</cfif>>
											<div class="form-group">
												<label>Price</label>
												<input name="single_simple_price" id="single-simple-price" type="text" style="width:100%" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.single_simple_price#"/>
											</div>
											<div class="form-group">
												<label>Special Price</label>
												<input name="single_simple_special_price" id="single-simple-special-price" type="text" style="width:100%" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.single_simple_special_price#"/>
											</div>
										</div>
										<div class="nav-tabs-custom" id="single-advanced-price-section" <cfif IsNull(REQUEST.pageData.product) OR (NOT IsNull(REQUEST.pageData.product) AND REQUEST.pageData.product.getUseAdvancedPrices() EQ false)>style="display:none;"</cfif>>
											<ul class="nav nav-tabs">
												<cfloop from="1" to="#ArrayLen(REQUEST.pageData.customerGroups)#" index="i">
													<li<cfif i EQ 1> class="active"</cfif>><a href="##single-price-#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" data-toggle="tab">#REQUEST.pageData.customerGroups[i].getDisplayName()#</a></li>
												</cfloop>
											</ul>
											<div class="tab-content">
												<cfloop from="1" to="#ArrayLen(REQUEST.pageData.customerGroups)#" index="i">
													<div class="tab-pane<cfif i EQ 1> active</cfif>" id="single-price-#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#">
														<div class="form-group">
															<label>Price</label>
															<input name="single_advanced_price_#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" id="single-advanced-price-#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" type="text" style="width:100%" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData["single_advanced_price_#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#"]#"/>
														</div>
														<div class="form-group">
															<label>Special Price</label>
															<input name="single_advanced_special_price_#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" id="single-advanced-special-price-#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" type="text" style="width:100%" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData["single_advanced_special_price_#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#"]#"/>
														</div>
														<div class="form-group">
															<label>From Date</label>
															<input type="text" class="form-control date" name="single_advanced_from_date_#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" id="single-advanced-from-date-#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" style="width:100%" value="#REQUEST.pageData.formData["single_advanced_from_date_#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#"]#" />
														</div>
														<div class="form-group">
															<label>To Date</label>
															<input type="text" class="form-control date" name="single_advanced_to_date_#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" id="single-advanced-to-date-#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" style="width:100%" value="#REQUEST.pageData.formData["single_advanced_to_date_#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#"]#" />
														</div>
													</div><!-- /.tab-pane -->
												</cfloop>
											</div><!-- /.tab-content -->
										</div><!-- nav-tabs-custom -->
										<div class="form-group">
											<input type="checkbox" class="form-control" name="single_advanced_price_settings" id="single-advanced-price-settings" value="1"
											<cfif NOT IsNull(REQUEST.pageData.product) AND REQUEST.pageData.product.getUseAdvancedPrices() NEQ false>
											checked
											</cfif>
											/>&nbsp;&nbsp;&nbsp;Advanced Price Settings
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<input type="radio" name="product_type" id="product-type-configurable" value="configurable" class="form-control"
										
										<cfif NOT IsNull(REQUEST.pageData.product) AND REQUEST.pageData.product.getProductType().getName() EQ "configurable">
										checked
										</cfif>
										
										>
									</td>
									<td>Configurable</td>
								</tr>
								<tr id="configurable-product" style="
								
								<cfif IsNull(REQUEST.pageData.product) OR REQUEST.pageData.product.getProductType().getName() NEQ "configurable">
								display:none;
								</cfif>
								
								">
									<td></td>
									<td>
										<label>Attribute Option(s)</label>&nbsp;&nbsp;&nbsp;
										<a href="" class="add-new-attribute" data-toggle="modal" data-target="##add-new-attribute-modal">
											<span class="label label-primary">Edit Attribute(s)</span>
										</a>
										
										<div id="attribute-options" class="row" style="margin-top:10px;">
											<cfif NOT IsNull(REQUEST.pageData.product)>
												<cfloop array="#REQUEST.pageData.attributes#" index="attribute">
													<cfset productAttributeRela = EntityLoad("product_attribute_rela",{product=REQUEST.pageData.product,attribute=attribute},true) />
													<cfif NOT IsNull(productAttributeRela)>
														<div class="col-xs-3">
															<div class="box box-warning">
																<div class="box-body table-responsive no-padding">
																	<table class="table table-hover">
																		<tr class="warning" id="tr-#attribute.getAttributeId()#">
																			<th colspan="2">#attribute.getDisplayName()#</th>
																			<th>
																				<a attributeid="#attribute.getAttributeId()#" attributename="#attribute.getName()#" class="add-new-attribute-option pull-right" data-toggle="modal" data-target="##add-new-attribute-option-modal" style="cursor:pointer;cursor:hand;">
																					<span class="label label-primary">Add Option</span>
																				</a>
																			</th>
																		</tr>
																		
																		<cfloop array="#productAttributeRela.getAttributeValues()#" index="attributeValue">
																			<tr id="tr-ao-#attributeValue.getAttributeValueId()#">
																				<td>
																					<table>
																						<tr>
																							<td>#attributeValue.getValue()#</td>
																							<cfif attribute.getDisplayName() EQ "color">
																								<td><div style="width:15px;height:15px;border:1px solid ##CCC;background-color:#attributeValue.getValue()#;margin-top:4px;margin-left:10px;"></div></td>
																							</cfif>
																						</tr>
																					</table>
																				</td>
																				<td>
																					<cfif attributeValue.getHasThumbnail()>
																						<cfset color = "red" />
																					<cfelse>
																						<cfset color = " ##CCC" />
																					</cfif>
																					<div style="width:15px;height:15px;border:1px solid #color#;margin-top:4px;">
																						<img src="#attributeValue.getImageLink(type = "thumbnail")#" style="width:100%;height:100%;vertical-align:top;" />
																					</div>
																				</td>
																				<td>
																					<a attributeid="#attribute.getAttributeId()#" attributeoptionid="#attributeValue.getAttributeValueId()#" class="delete-attribute-option pull-right" data-toggle="modal" data-target="##delete-attribute-option-modal" style="cursor:pointer;cursor:hand;">
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
										
										<div id="sub-products">
											<cfif NOT IsNull(REQUEST.pageData.product) AND NOT ArrayIsEmpty(REQUEST.pageData.subProducts)>
												<div class="form-group">
													<label>Product(s)</label>
													<table class="table table-bordered table-hover" id="sub-products-table">
														<tr class="warning">
															<cfloop array="#REQUEST.pageData.attributes#" index="attribute">
																<cfset productAttributeRela = EntityLoad("product_attribute_rela", {product = REQUEST.pageData.product, attribute = attribute}, true) />
																<cfif NOT IsNull(productAttributeRela) AND NOT ArrayIsEmpty(productAttributeRela.getAttributeValues())>
																	<th>#LCase(productAttributeRela.getAttribute().getDisplayName())#</th>
																</cfif>
															</cfloop>
															<th>Sku</th>
															<th>Stock</th>
															<th>Price</th>
															<th>Special Price</th>
															<th style="width:110px;">Advanced</th>
															<th style="width:10px;">Enabled</th>
														</tr>
														<cfloop array="#REQUEST.pageData.subProducts#" index="p">	
															<cfset productCustomerGroupRela = EntityLoad("product_customer_group_rela", {product = p, customerGroup = REQUEST.pageData.defaultCustomerGroup}, true) />
															<tr>
																<cfset cls = "" />
																<cfloop array="#REQUEST.pageData.attributes#" index="attribute">
																	<cfset productAttributeRela = EntityLoad("product_attribute_rela", {product = p, attribute = attribute}, true) />
																	<cfif NOT IsNull(productAttributeRela) AND NOT ArrayIsEmpty(productAttributeRela.getAttributeValues())>
																		<cfset cls &= "tr-ao-#productAttributeRela.getAttributeValues()[1].getAttributeValueId()# " />
																		<td>
																			<table>
																				<tr>
																					<td>#productAttributeRela.getAttributeValues()[1].getValue()#</td>
																					<cfif productAttributeRela.getAttribute().getDisplayName() EQ "color">
																						<td><div class="pull-left" style="margin-left:10px;width:15px;height:15px;border:1px solid ##CCC;background-color:#productAttributeRela.getAttributeValues()[1].getValue()#;margin-top:4px;"></div></td>
																					</cfif>
																				</tr>
																			</table>
																		</td>
																	</cfif>
																</cfloop>
																
																<td class="#cls#">
																	<input name="c_sub_product_sku_#p.getProductId()#" value="#p.getSku()#" style="width:100%;" />
																</td>
																<td>
																	<input name="c_sub_product_stock_#p.getProductId()#" value="#p.getStock()#" style="width:100%;" />
																</td>
																<td>
																	<input name="c_sub_product_simple_price_#p.getProductId()#" value="#productCustomerGroupRela.getPrice()#" style="width:100%;"/>
																</td>
																<td>
																	<input name="c_sub_product_simple_special_price_#p.getProductId()#" value="#productCustomerGroupRela.getSpecialPrice()#" style="width:100%;"/>
																</td>
																<td>
																	<div class="pull-left" style="margin-right:10px;">
																		<input type="checkbox" class="form-control c-sub-product-use-advanced-price" productid="#p.getProductId()#" name="c_sub_product_use_advanced_price_#p.getProductId()#" value="1" <cfif p.getUseAdvancedPrices() EQ true>checked</cfif> />
																	</div>
																	<a productid="#p.getProductId()#" class="c-sub-product-advanced-product-price pull-left" data-toggle="modal" data-target="##advanced-price-modal" style="cursor:pointer;cursor:hand;">
																		<span class="label label-danger">Advanced</span>
																	</a>
																</td>
																<td style="text-align:right;">
																	<input type="checkbox" productid="#p.getProductId()#" class="form-control enable-sub-product" name="c_sub_product_enabled_#p.getProductId()#" id="c-sub-product-enabled-#p.getProductId()#" <cfif p.getIsEnabled() EQ true>checked</cfif> value="1" />
																</td>
															</tr>
														</cfloop>
													</table>
												</div>
											</cfif>
										</div>
									</td>
								</tr>
							</table>
						</div>
						<div class="form-group">
							<label>Tax Category</label>
							<select name="tax_category_id" class="form-control">
								<cfloop array="#REQUEST.pageData.taxCategories#" index="tc">
									<option value="#tc.getTaxCategoryId()#"
									
									<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getTaxCategoryMV()) AND tc.getTaxCategoryId() EQ REQUEST.pageData.formData.tax_category_id>
									selected
									</cfif>
									
									>#tc.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
						<div class="form-group">
							<label>Product Detail</label>
							<textarea name="detail" id="detail" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.detail#</textarea>
						</div>
						<div class="form-group">
							<label>Status</label>
							 <select class="form-control" name="is_enabled">
								<option value="1" <cfif REQUEST.pageData.formData.is_enabled EQ TRUE>selected</cfif>>Enabled</option>
								<option value="0" <cfif REQUEST.pageData.formData.is_enabled EQ FALSE>selected</cfif>>Disabled</option>
							</select>
						</div>
					</div><!-- /.tab-pane -->
					<div class="tab-pane #REQUEST.pageData.tabs['tab_2']#" id="tab_2">
						
						<div class="form-group">
							<label>Title</label>
							<input name="title" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.title#"/>
						</div>
						<div class="form-group">
							<label>Description</label>
							<textarea name="description" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.formData.description#</textarea>
						</div>
						<div class="form-group">
							<label>Keywords</label>
							<textarea name="keywords" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.formData.keywords#</textarea>
						</div>
						
					</div><!-- /.tab-pane -->
					
					<div class="tab-pane #REQUEST.pageData.tabs['tab_4']#" id="tab_4">
					
						<cfif NOT IsNULL(REQUEST.pageData.product) AND NOT IsNULL(REQUEST.pageData.product.getImagesMV())>
							<div class="row">
								<cfloop array="#REQUEST.pageData.product.getImagesMV()#" index="img">						
									<div class="col-xs-2">
										<div class="box <cfif img.getIsDefault() EQ true>box-danger</cfif>">
											<div class="box-body table-responsive no-padding">
												<table class="table table-hover">
													<tr <cfif img.getIsDefault() EQ true>class="danger"<cfelse>class="default"</cfif>>
														<th style="font-size:11px;line-height:20px;">#Left(img.getName(),"10")#</th>
														<th><a imageid="#img.getProductImageId()#" href="" class="delete-image pull-right" data-toggle="modal" data-target="##delete-image-modal"><span class="label label-danger">Delete</span></a></th>
													</tr>
													<tr>
														<td colspan="2">
															<img class="img-responsive" src="#img.getImageLink(type = "small")#" />
														</td>
													</tr>
													<tr>
														<td colspan="2">
															<table style="width:100%;">
																<tr>
																	<td>
																		<input class="form-control pull-left" type="radio" name="default_image_id" value="#img.getProductImageId()#" <cfif img.getIsDefault() EQ true>checked</cfif>/>
																	</td>
																	<td style="padding-left:5px;padding-top:1px;font-size:12px;">
																		Set as Default
																	</td>
																	<td style="text-align:right">
																		<input type="text" name="rank_#img.getProductImageId()#" value="#img.getRank()#" style="width:30px;text-align:center;" />
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
					<div class="tab-pane #REQUEST.pageData.tabs['tab_8']#" id="tab_8">
						<table class="table table-hover">
							<tr>
								<td>
									<input type="radio" name="shipping_method" value="free" checked>
								</td>
								<td>Free Shipping</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="shipping_method" value="flat">
								</td>
								<td>Flat Rate: <input type="text" name="flat_rate_price" value="" style="margin-left:20px;"></td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="shipping_method" value="carrier">
								</td>
								<td>Choose Carrier</td>
							</tr>
							<tr>
								<td></td>
								<td>
									<div class="form-group">
										<label>Weight</label>
										<input name="weight" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.weight#"/>
									</div>
									<div class="form-group">
										<label>Length</label>
										<input name="length" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.length#"/>
									</div>
									<div class="form-group">
										<label>Width</label>
										<input name="width" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.width#"/>
									</div>
									<div class="form-group">
										<label>Height</label>
										<input name="height" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.height#"/>
									</div>
									<div class="row" style="margin-top:10px;">
										<cfloop array="#REQUEST.pageData.shippingCarriers#" index="sc">
											<div class="col-xs-2">
												<div class="box box-warning">
													<div class="box-body table-responsive no-padding">
														<table class="table table-hover">
															<tr class="warning">
																<th><img src="#APPLICATION.absoluteUrlSite#images/uploads/shipping/#sc.getImageName()#" style="height:25px;vertical-align:top;" /></th>
																<th colspan="2" style="padding-right:10px;" nowrap>#sc.getDisplayName()#</th>
																<th style="text-align:right;">
																	<input type="checkbox" class="form-control pull-right" name="shipping_carrier_id" value="#sc.getShippingCarrierId()#"
																	
																	<cfif NOT IsNull(productShippingCarrierRela) 
																		OR 
																		NOT IsNull(REQUEST.pageData.formData.shipping_carrier_id) AND ListFind(REQUEST.pageData.formData.shipping_carrier_id, sc.getShippingCarrierId())>
																		checked
																	</cfif>
																	
																	/>
																</th>
															</tr>	
														</table>
													</div><!-- /.box-body -->
												</div><!-- /.box -->
											</div>
										</cfloop>
									</div>
								</td>
							</tr>
						</table>
					</div>
					<div class="tab-pane #REQUEST.pageData.tabs['tab_9']#" id="tab_9">
						<cfif NOT IsNULL(REQUEST.pageData.product) AND NOT IsNULL(REQUEST.pageData.product.getProductVideosMV())>
							<div class="form-group">
								<label>Videos</label>
								<a data-toggle="modal" data-target="##add-video-modal" href="" style="margin-left:10px;"><span class="label label-primary">Add New Video</span></a>
								<div class="row" style="margin-top:10px;">
									<cfloop array="#REQUEST.pageData.product.getProductVideosMV()#" index="video">	
										<div class="col-xs-3">
											<div class="box">
												<div class="box-body table-responsive no-padding">
													<table class="table table-hover">
														<tr class="default">
															<th><a href="#video.getUrl()#">Link</a></th>
															<th><a productvideoid="#video.getProductVideoId()#" href="" class="delete-video pull-right" data-toggle="modal" data-target="##delete-video-modal"><span class="label label-danger">Delete</span></a></th>
														</tr>
														<tr>
															<td colspan="2">
																<iframe width="100%" height="100%" src="#video.getUrl()#" frameborder="0" allowfullscreen></iframe>
															</td>
														</tr>
													</table>
												</div><!-- /.box-body -->
											</div><!-- /.box -->
										</div>
									</cfloop>
								</div>
							</div>
						<cfelse>
							<div class="form-group">
								<label>Video 1</label>
								<input name="video1" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.video1#"/>
							</div>
							<div class="form-group">
								<label>Video 2</label>
								<input name="video2" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.video2#"/>
							</div>
							<div class="form-group">
								<label>Video 3</label>
								<input name="video3" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.video3#"/>
							</div>
							<div class="form-group">
								<label>Video 4</label>
								<input name="video4" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.video4#"/>
							</div>
							<div class="form-group">
								<label>Video 5</label>
								<input name="video5" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.video5#"/>
							</div>
						</cfif>
					</div>
					<div class="tab-pane #REQUEST.pageData.tabs['tab_6']#" id="tab_6">
					
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
									<cfif NOT IsNull(REQUEST.pageData.product)>
										<cfloop array="#REQUEST.pageData.product.getRelatedProducts()#" index="product">
											<option value="#product.getProductId()#">#product.getDisplayName()#</option>
										</cfloop>
									</cfif>
								</select>
							</div>
						</div>
					</div>
					<div class="tab-pane #REQUEST.pageData.tabs['tab_7']#" id="tab_7">
						<div class="row">
							<div class="col-xs-12">
								<div class="box box-primary">
									<div class="box-header">
										<h3 class="box-title">Reviews</h3>
									</div><!-- /.box-header -->
									<div class="box-body table-responsive">
										<table class="table table-bordered table-striped data-table">
											<thead>
												<tr>
													<th>Subject</th>
													<th>Message</th>
													<th>Rating</th>
													<th>Create Datetime</th>
													<th>Action</th>
												</tr>
											</thead>
											<tbody>
												<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getReviewsMV()) AND ArrayLen(REQUEST.pageData.product.getReviewsMV()) GT 0>
													<cfloop array="#REQUEST.pageData.product.getReviewsMV()#" index="review">
													<tr>
														<td>#review.getSubject()#</td>
														<td>#review.getMessage()#</td>
														<td>#review.getRating()#</td>
														<td>#review.getCreatedDatetime()#</td>
														<td><a href="#APPLICATION.absoluteUrlSite#admin/review_detail.cfm?id=#review.getReviewId()#">View Detail</a></td>
													</tr>
													</cfloop>
												</cfif>
											</tbody>
											<tfoot>
												<tr>
													<th>Subject</th>
													<th>Message</th>
													<th>Rating</th>
													<th>Create Datetime</th>
													<th>Action</th>
												</tr>
											</tfoot>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div><!-- /.tab-content -->
			</div><!-- nav-tabs-custom -->
			<cfif 	IsNull(REQUEST.pageData.product)
					OR
					NOT IsNull(REQUEST.pageData.product) AND REQUEST.pageData.product.getProductType().getName() EQ "single"
					OR
					NOT IsNull(REQUEST.pageData.product) AND REQUEST.pageData.product.getProductType().getName() EQ "configurable">
				<div class="form-group">
					<button name="save_item" id="save-item" type="button" class="btn btn-primary top-nav-button">Save Product</button>
					<button type="button" class="btn btn-danger pull-right #REQUEST.pageData.deleteButtonClass#" data-toggle="modal" data-target="##delete-current-entity-modal">Delete Product</button>
				</div>
			</cfif>
		</div><!-- /.col -->
		
	</div>   <!-- /.row -->
</section><!-- /.content -->

<!-- ADD OPTION MODAL -->
<div class="modal fade" id="add-new-attribute-option-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Attribute Option</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group" id="attribute-option-modal-div">
					<input id="new-attribute-option-name" name="new_attribute_option_name" type="text" class="form-control" placeholder="Value">
					<input id="new-attribute-option-name-color" name="new_attribute_option_name_color" type="text" class="form-control" placeholder="Value">
				</div>
				<div class="form-group attribute-option-image-div" id="attribute-option-image-div-0">
					<div class="btn btn-success btn-file" style="width:150px;margin-right:20px;">
						<i class="fa fa-paperclip"></i> &nbsp;&nbsp;Add Image
						<input type="file" name="new_attribute_option_image_0" id="new-attribute-option-image-0"/>
					</div>
					<input type="checkbox" class="form-control" name="generate_thumbnail_0" id="generate-thumbnail-0" value="1"/> Generate Image Thumbnail
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button id="add-new-attribute-option-confirm" name="add_new_attribute_option_confirm" type="button" class="btn btn-primary pull-left" data-dismiss="modal"><i class="fa fa-check"></i> Add</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE OPTION MODAL -->
<div class="modal fade" id="delete-attribute-option-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this option?</h4>
			</div>
		
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_attribute_option_confirm" id="delete-attribute-option-confirm" type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-check"></i> Yes</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE ENTITY MODAL -->
<div class="modal fade" id="delete-current-entity-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this product?</h4>
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
<!-- ADD VIDEO MODAL -->
<div class="modal fade" id="add-video-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Video</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<label>URL</label>
					<input id="new_video_url" name="new_video_url" type="text" class="form-control" placeholder="Video URL">
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_new_video" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE VIDEO MODAL -->
<div class="modal fade" id="delete-video-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this video?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_video" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- ADD ATTRIBUTE MODAL -->
<div class="modal fade" id="add-new-attribute-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Attribute(s)</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<label>Attributes</label>
					<select class="form-control" multiple name="attribute_id" id="attribute-id">
						<cfloop array="#REQUEST.pageData.attributes#" index="attr">
							<option value="#attr.getAttributeId()#"
							<cfif ListFind(REQUEST.pageData.attributeList,attr.getAttributeId())>
								selected
							</cfif>
							>#attr.getDisplayName()#</option>
						</cfloop>
					</select>
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="edit_attribute" id="edit-attribute-confirm" type="button" class="btn btn-primary pull-left" data-dismiss="modal"><i class="fa fa-check"></i> Save</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- ADVANCED PRICE MODAL -->
<div class="modal fade" id="advanced-price-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Advanced Price Settings</h4>
			</div>
		
			<div class="modal-body">
				<div class="nav-tabs-custom">
					<ul class="nav nav-tabs">
						<cfloop from="1" to="#ArrayLen(REQUEST.pageData.customerGroups)#" index="i">
							<li class="advanced-price-tab<cfif i EQ 1> active</cfif>" id="advanced-price-tab-#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#"><a href="##advanced-price-tab-content-#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" data-toggle="tab">#REQUEST.pageData.customerGroups[i].getDisplayName()#</a></li>
						</cfloop>
					</ul>
					<div class="tab-content">
						<cfloop from="1" to="#ArrayLen(REQUEST.pageData.customerGroups)#" index="i">
							<div class="tab-pane<cfif i EQ 1> active</cfif> advanced-price-tab-content" id="advanced-price-tab-content-#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#">
								<div class="form-group">
									<label>Price</label>
									<input name="advanced_price_#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" id="advanced-price-#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" type="text" style="width:100%" class="form-control" placeholder="Enter ..." value=""/>
								</div>
								<div class="form-group">
									<label>Special Price</label>
									<input name="advanced_special_price_#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" id="advanced-special-price-#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" type="text" style="width:100%" class="form-control" placeholder="Enter ..." value=""/>
								</div>
								<div class="form-group">
									<label>From Date</label>
									<input type="text" class="form-control date" name="advanced_from_date_#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" id="advanced-from-date-#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" style="width:100%" />
								</div>
								<div class="form-group">
									<label>To Date</label>
									<input type="text" class="form-control date" name="advanced_to_date_#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" id="advanced-to-date-#REQUEST.pageData.customerGroups[i].getCustomerGroupId()#" style="width:100%" />
								</div>
							</div><!-- /.tab-pane -->
						</cfloop>
					</div><!-- /.tab-content -->
				</div><!-- nav-tabs-custom -->
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="edit_advanced_price" id="edit-advanced-price-confirm" type="button" class="btn btn-primary pull-left" data-dismiss="modal"><i class="fa fa-check"></i> Save</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</form>
</cfoutput>