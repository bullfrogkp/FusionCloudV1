<cfoutput>

<div id="slide-div" style="width:712px;float:right;">
	<div id="breadcrumb">
		<div class="breadcrumb-home-icon"></div>
		<cfloop array="#REQUEST.pageData.categoryArray#" index="category">
			<div class="breadcrumb-arrow-icon"></div>
			<span style="vertical-align:middle">
				<a href="#category.getDetailPageURL()#">
				#category.getDisplayName()#
				</a>
			</span> 
		</cfloop>
	</div>
	
	<h1>
		#category.getDisplayName()# <span style="font-size:12px;">(#ArrayLen(REQUEST.pageData.paginationInfo.records)# total)</span>
	</h1> 
	
	<cfif REQUEST.pageData.category.getDisplayCustomDesign() EQ true>
	#REQUEST.pageData.category.getCustomDesign()#
	</cfif>
	
	<cfif REQUEST.pageData.category.getDisplayCategoryList() EQ true>
		<div style="border:1px solid ##CCC;width:692px;padding:10px;margin-bottom:10px;">
			<table id="new-products">
				<tr class="categories">
					<td>
						<ul>   
							<cfloop array="#REQUEST.pageData.allCategories#" index="category">
								<li><a title="#category.getDisplayName()#" href="#category.getDetailPageUrl()#">#category.getDisplayName()#</a></li>
							</cfloop>
						</ul>
					</td>
				</tr>
			</table>
		</div>
	</cfif>
	
	<cfif REQUEST.pageData.category.getDisplayFilter() EQ true>
		<cfif NOT ArrayIsEmpty(REQUEST.pageData.category.getCategoryFilterRelas())>
			<div style="border:1px solid ##CCC;width:692px;padding:10px;">
				<table id="filters">
					<cfloop array="#REQUEST.pageData.filterArray#" index="filter">
						<tr>
							<td>#filter.filterName#:</td>
							<td>
								<ul>
									<cfloop array="#filter.filterValueArray#" index="filterValue">
										<a href="#filterValue.link#">
										<li class="filter-value <cfif filterValue.selected>active-filter</cfif>"
										<cfif filter.filterName EQ "color">style="background-color:#filterValue.value#;width:20px;height:20px;padding:0;"</cfif>
										>
										
										<cfif filter.filterName NEQ "color">
											#filterValue.name#
										</cfif>
										
										</li>
										</a>
									</cfloop>
								</ul>
							</td>
						</tr>
					</cfloop>
				</table>
			</div>
		</cfif>
	</cfif>
	
	<cfif ArrayLen(REQUEST.pageData.paginationInfo.records) GT 0>
		<div id="sort-by">
			<ul>
				<li style="border:none;margin-left:0;padding:left:0;">Sort By:</li>
				<cfloop array="#REQUEST.pageData.sortTypeArray#" index="sortType">
					<li <cfif sortType.selected>class="active"</cfif>><a href="#sortType.link#" style="color:##000;text-decoration:none;padding:3px 4px;">#sortType.name#</a></li>
				</cfloop>
			</ul>
		</div>
	</cfif>
	
	<div id="pages">
		<ul class="pagination pagination-sm no-margin pull-right">
		<cfif ArrayLen(REQUEST.pageData.pageArray) GT 1>
		<cfloop array="#REQUEST.pageData.pageArray#" index="page">
			<li <cfif page.selected>class="active"</cfif>><a href="#page.link#" style="color:##000;text-decoration:none;padding:3px 4px;">#page.number#</a></li>
		</cfloop>
		</ul>
		</cfif>
	</div>
	<div class="clear"></div>
	
	<div class="cat-thumbnails" style="margin-top:10px;">
		<div class="cat-thumbnail-section" style="border-top:none;">
			<ul class="rig columns-4">
				<cfloop array="#REQUEST.pageData.paginationInfo.records#" index="product">
					<li class="single-products">
						<a href="#product.getDetailPageURL()#">
							<img class="thumbnail-img" src="#product.getDefaultImageLink(type='small')#" />
						</a>
						<div class="thumbnail-name"><a href="#product.getDetailPageURL()#">#product.getDisplayName()#</a></div>
						<div class="thumbnail-price">#LSCurrencyFormat(product.getPrice(customerGroupId = SESSION.user.customerGroupId, currencyId = SESSION.currency.id),"local",SESSION.currency.locale)#</div>
						<cfif product.isFreeShipping()>
						<img class="free-shipping-icon" src="#APPLICATION.urlAdmin#images/freeshipping.jpg" style="width:120px;margin-top:7px;" />
						</cfif>
						<div class="product-overlay">
							<div class="overlay-content">
								<div class="thumbnail-rating"></div>
								<div class="thumbnail-review"><a href="#product.getDetailPageURL()#">(#product.getReviewCountMV()# Reviews)</a></div>
								<div class="thumbnail-cart"><a class="btn add-to-cart" style="padding-right:13px;">Add to cart</a></div>
							</div>
						</div>
					</li>
				</cfloop>
			</ul>
		</div>
	</div>
</div>
<div id="top-sidebar">
	<div class="recommendation">
		Browse By Category
	</div>
	<div style="font-size:12px;margin-bottom:4px;border: 1px solid ##CCC;
margin-top: -1px;padding: 2px 5px 3px 3px;">
		<div id="demo1_menu">
			<ul>
				<cfloop from="1" to="#ArrayLen(REQUEST.pageData.subCategoryTree)#" index="i">
					<cfset cat = REQUEST.pageData.categoryTree[i] />
					<li class=" 
						<cfif cat.getIsExpanded()>isExpanded</cfif>
						<cfif cat.getIsActive()>easytree-active</cfif>
						" title="#cat.getDisplayName()#">
						<a href="#cat.getDetailPageURL()#">
							#cat.getDisplayName()#
						</a>
						<ul>
							<cfloop array="#cat.getSubCategories()#" index="subCat">
								<li class="
									<cfif subCat.getIsExpanded()>isExpanded</cfif>
									<cfif subCat.getIsActive()>easytree-active</cfif>
								">
									<a href="#subCat.getDetailPageURL()#">
										#subCat.getDisplayName()#
									</a>
									<ul>
										<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
											<li class="
												<cfif thirdCat.getIsExpanded()>isExpanded</cfif>
												<cfif thirdCat.getIsActive()>easytree-active</cfif>
											">
												<a href="#thirdCat.getDetailPageURL()#">
													#thirdCat.getDisplayName()#
												</a>
											</li>
										</cfloop>	
									</ul>
								</li>
							</cfloop>	
						</ul>
					</li>
				</cfloop>
			</ul>
		</div>
		<script>
		   $('##demo1_menu').easytree();
		   function changeTheme() {
			   var theme = $('##themes').val();
			   var stylesheet = $('.skins');
			   var href = stylesheet.attr('href');
			   stylesheet.attr('href', '/content/skin-' + theme + '/ui.easytree.css');
		   }
		</script>
	</div>
	<cfif ArrayLen(REQUEST.pageData.bestSellerSection.getSectionData()) GT 0>
		<div class="recommendation">
			Best Sellers
		</div>
		<div class="recommendation-list" style="margin-bottom:8px;">
			<ul>
				<cfloop array="#REQUEST.pageData.bestSellerSection.getSectionData()#" index="bs">	
					<cfset product = bs.getProduct() />
					<li>
						<img src="#product.getDefaultImageLink(type='small')#" />
						<div class="recommendation-list-detail">
							<div class="recommendation-list-name">
								<a href="#APPLICATION.urlAdmin#product_detail.cfm/#URLEncodedFormat(product.getDisplayName())#/#product.getProductId()#">
									#product.getDisplayName()#
								</a>
							</div>
							<div class="recommendation-list-price">#LSCurrencyFormat(product.getPrice(customerGroupId = SESSION.user.customerGroupId, currencyId = SESSION.currency.id),"local",SESSION.currency.locale)#</div>
							<div class="recommendation-list-review"></div>
							<div><a href="">(#product.getReviewCountMV()# Reviews)</a></div>
						</div>
						<div style="clear:both;"></div>
					</li>
				</cfloop>
			</ul>
		</div>
	</cfif>
	<cfif ArrayLen(REQUEST.pageData.advertisementSection.getSectionData()) GT 0>
		<cfloop array="#REQUEST.pageData.advertisementSection.getSectionData()#" index="ad">	
			<img src="#APPLICATION.urlAdmin#images/uploads/advertise/#ad.getName()#" style="width:228px;border:1px solid ##CCC">
		</cfloop>
	</cfif>
</div>

</cfoutput>
