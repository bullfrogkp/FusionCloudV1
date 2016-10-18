<cfcomponent extends="core.modules.module">	
    <cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.categoryService = new "core.services.categoryService"() />
		<cfset LOCAL.categoryTree = LOCAL.categoryService.getCategoryTree() />
		
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.products = EntityLoad("module_admin_category_detail_bestseller", {category=EntityLoadByPK("category",getUrlData().id)})> 
		<cfset LOCAL.retStruct.javascript = "
			$(document).ready(function() {
				$('##add-all').click(function() {  
					$('##products-searched').each(function() {
						$('##products-searched option').remove().appendTo('##products-selected'); 
					});
				});  
				
				$('##remove-all').click(function() {  
					$('##products-selected').each(function() {
						$('##products-selected option').remove().appendTo('##products-searched'); 
					});  
				}); 

				$('##add').click(function() {  
					return !$('##products-searched option:selected').remove().appendTo('##products-selected').removeAttr('selected'); 
				});  
				
				$('##remove').click(function() {  
					return !$('##products-selected option:selected').remove().appendTo('##products-searched').removeAttr('selected'); 
				});	
				
				$('##search-product').click(function() {
					$.ajax({
								type: 'get',
								url: '#APPLICATION.absoluteUrlSite#core/services/productService.cfc',
								dataType: 'json',
								data: {
									method: 'searchProducts',
									productGroupId: $('##search-product-group-id').val(),
									categoryId: $('##search-category-id').val(),
									keywords: $('##search-keywords').val()
								},		
								success: function(response) {
									var productArray = response.DATA;
									var productName = '';
									var productId = '';
									
									$('##products-searched').empty();
									for (var i = 0, len = productArray.length; i < len; i++) {
										productName = productArray[i][0];
										productId = productArray[i][1];
										
										$('##products-searched').append('<option value=#Chr(34)#' + productId + '#Chr(34)#>' + productName + '</option>');
									}
								}
					});
				});
				
				$('##save-item').click(function() {  
					selectBox = document.getElementById('products-selected');

					for (var i = 0; i < selectBox.options.length; i++) 
					{ 
						 selectBox.options[i].selected = true; 
					} 
				});
			});"> 
		<cfset LOCAL.retStruct.tab_title = "heiheihei"> 
		
		<cfset LOCAL.productGroups = EntityLoad("product_group") />
		<cfset LOCAL.retStruct.tab_view = '<div class="row">
							<div class="col-xs-3" style="padding-right:0;">
								<select name="search_product_group_id" id="search-product-group-id" class="form-control">
									<option value="0">Choose Product Group ...</option> ' />
									<cfloop array="#LOCAL.productGroups#" index="group">
										<cfset LOCAL.retStruct.tab_view &= '<option value="#group.getProductGroupId()#">#group.getDisplayName()#</option>' />
									</cfloop>
								<cfset LOCAL.retStruct.tab_view &= '
								</select>
							</div>
							<div class="col-xs-4" style="padding-right:0;">
								<select class="form-control" name="search_category_id" id="search-category-id">
									<option value="0">Choose Category ...</option>' />
									<cfloop array="#LOCAL.categoryTree#" index="cat">
										<cfset LOCAL.retStruct.tab_view &= '<option value="#cat.getCategoryId()#"' />
										<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),cat)>
										<cfset LOCAL.retStruct.tab_view &= ' selected' />
										</cfif>
										
										<cfset LOCAL.retStruct.tab_view &= '
										>#RepeatString("&nbsp;",1)##cat.getDisplayName()#</option>' />
										<cfloop array="#cat.getSubCategories()#" index="subCat">
											<cfset LOCAL.retStruct.tab_view &= '<option value="#subCat.getCategoryId()#"' />
											<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),subCat)>
											<cfset LOCAL.retStruct.tab_view &= ' selected' />
											</cfif>
											<cfset LOCAL.retStruct.tab_view &= '>#RepeatString("&nbsp;",11)##subCat.getDisplayName()#</option>' />
											<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
												<cfset LOCAL.retStruct.tab_view &= '<option value="#thirdCat.getCategoryId()#"' />
												<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),thirdCat)>
												<cfset LOCAL.retStruct.tab_view &= ' selected' />
												</cfif>
												<cfset LOCAL.retStruct.tab_view &= '>#RepeatString("&nbsp;",21)##thirdCat.getDisplayName()#</option>' />
											</cfloop>
											<cfset LOCAL.retStruct.tab_view &= '</li>' />
										</cfloop>
										<cfset LOCAL.retStruct.tab_view &= '</li>' />
									</cfloop>
								<cfset LOCAL.retStruct.tab_view &= '</select>
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
								<select name="products_selected" id="products-selected" multiple class="form-control" style="height:270px;">' />
									<cfif NOT IsNull(LOCAL.products)>
										<cfloop array="#REQUEST.pageData.bestSellers#" index="bs">	
											<cfset product = bs.getProduct() />
											<cfset LOCAL.retStruct.tab_view &= '<option value="#product.getProductId()#">#product.getDisplayName()#</option>' />
										</cfloop>
									</cfif>
								<cfset LOCAL.retStruct.tab_view &= '</select>
							</div>
						</div>' />
						
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>