<cfcomponent extends="core.modules.module">	
    <cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.products = EntityLoad("module_admin_category_detail_bestseller", {category=EntityLoadByPK("category",getUrlData().id)})> 
		<cfset LOCAL.retStruct.javascript = "good"> 
		<cfset LOCAL.retStruct.tab_title = "heiheihei"> 
		
		<cfset LOCAL.productGroups = EntityLoad("product_group") />
		<cfset LOCAL.retStruct.tab_view = '<div class="row">
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
									<cfif NOT IsNull(REQUEST.pageData.bestSellers)>
										<cfloop array="#REQUEST.pageData.bestSellers#" index="bs">	
											<cfset product = bs.getProduct() />
											<option value="#product.getProductId()#">#product.getDisplayName()#</option>
										</cfloop>
									</cfif>
								</select>
							</div>
						</div>' />
						
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>