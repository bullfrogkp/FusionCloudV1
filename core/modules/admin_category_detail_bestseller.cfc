﻿<cfcomponent extends="core.modules.module">	
	<!------------------------------------------------------------------------------->
    <cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.categoryService = new "core.services.categoryService"() />
		<cfset LOCAL.categoryTree = LOCAL.categoryService.getCategoryTree() />
		
		<cfset LOCAL.retStruct = {} />
		<cfif StructKeyExists(getUrlData(),"id") AND IsNumeric(getUrlData().id)>
			<cfset LOCAL.retStruct.products = EntityLoad("module_admin_category_detail_bestseller", {category = EntityLoadByPK("category",getUrlData().id)})> 
			<cfset LOCAL.retStruct.tab_title = "Best Seller"> 
			
			<cfset LOCAL.productGroups = EntityLoad("product_group") />
			<cfset LOCAL.retStruct.tab_content = '<div class="row">
								<div class="col-xs-3" style="padding-right:0;">
									<select name="search_product_group_id" id="search-product-group-id" class="form-control">
										<option value="0">Choose Product Group ...</option> ' />
										<cfloop array="#LOCAL.productGroups#" index="group">
											<cfset LOCAL.retStruct.tab_content &= '<option value="#group.getProductGroupId()#">#group.getDisplayName()#</option>' />
										</cfloop>
									<cfset LOCAL.retStruct.tab_content &= '
									</select>
								</div>
								<div class="col-xs-4" style="padding-right:0;">
									<select class="form-control" name="search_category_id" id="search-category-id">
										<option value="0">Choose Category ...</option>' />
										<cfloop array="#LOCAL.categoryTree#" index="cat">
											<cfset LOCAL.retStruct.tab_content &= '<option value="#cat.getCategoryId()#"' />
											<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),cat)>
											<cfset LOCAL.retStruct.tab_content &= ' selected' />
											</cfif>
											
											<cfset LOCAL.retStruct.tab_content &= '
											>#RepeatString("&nbsp;",1)##cat.getDisplayName()#</option>' />
											<cfloop array="#cat.getSubCategories()#" index="subCat">
												<cfset LOCAL.retStruct.tab_content &= '<option value="#subCat.getCategoryId()#"' />
												<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),subCat)>
												<cfset LOCAL.retStruct.tab_content &= ' selected' />
												</cfif>
												<cfset LOCAL.retStruct.tab_content &= '>#RepeatString("&nbsp;",11)##subCat.getDisplayName()#</option>' />
												<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
													<cfset LOCAL.retStruct.tab_content &= '<option value="#thirdCat.getCategoryId()#"' />
													<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),thirdCat)>
													<cfset LOCAL.retStruct.tab_content &= ' selected' />
													</cfif>
													<cfset LOCAL.retStruct.tab_content &= '>#RepeatString("&nbsp;",21)##thirdCat.getDisplayName()#</option>' />
												</cfloop>
												<cfset LOCAL.retStruct.tab_content &= '</li>' />
											</cfloop>
											<cfset LOCAL.retStruct.tab_content &= '</li>' />
										</cfloop>
									<cfset LOCAL.retStruct.tab_content &= '</select>
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
												<cfset LOCAL.retStruct.tab_content &= '<option value="#product.getProductId()#">#product.getDisplayName()#</option>' />
											</cfloop>
										</cfif>
									<cfset LOCAL.retStruct.tab_content &= '</select>
								</div>
							</div>' />
		</cfif>				
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="processFormData" access="remote" output="false" returnType="struct" returnformat="json">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.isValid = true />
		<cfset LOCAL.retStruct.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"save_item")>	
			<cfset LOCAL.category = EntityLoadByPK("category",getEntityId()) />
			<cfset LOCAL.products = EntityLoad("module_admin_category_detail_bestseller", {category = LOCAL.category})> 
			<cfloop array="#LOCAL.products#" index="LOCAL.product">
				<cfset EntityDelete(LOCAL.product) />
			</cfloop>
			<cfif StructKeyExists(FORM,"products_selected") AND FORM.products_selected NEQ "">
				<cfloop list="#FORM.products_selected#" index="LOCAL.productId">
					<cfset LOCAL.newProduct = EntityNew("module_admin_category_detail_bestseller") />
					<cfset LOCAL.newProduct.setProduct(EntityLoadByPK("product",LOCAL.productId)) />
					<cfset LOCAL.newProduct.setCategory(LOCAL.category) />
					<cfset EntitySave(LOCAL.newProduct) />
				</cfloop>
			</cfif>
		</cfif>
			
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->
</cfcomponent>