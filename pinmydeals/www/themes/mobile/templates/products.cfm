<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>	
	<cfloop array="#REQUEST.pageData.breadcrumbCategoryArray#" index="category">
		<a href="#category.getDetailPageURL()#">#category.getDisplayName()#</a>
	</cfloop>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-md-9 col-md-push-3 col-sm-8 col-sm-push-4">
			<div class="page-selector">
				<div class="pages-box hidden-xs">
					<cfif ArrayLen(REQUEST.pageData.pageArray) GT 1>
						<cfloop array="#REQUEST.pageData.pageArray#" index="page">
							<a href="#page.link#" class="square-button <cfif page.selected>active</cfif>">#page.number#</a>
						</cfloop>
						<div class="divider">...</div>
						<a href="##" class="square-button"><i class="fa fa-angle-right"></i></a>
					</cfif>
				</div>
				<div class="shop-grid-controls">
					<div class="entry">
						<div class="inline-text">Sorty by</div>
						<div class="simple-drop-down">
							<select>
								<option>Position</option>
								<option>Price</option>
								<option>Category</option>
								<option>Rating</option>
								<option>Color</option>
							</select>
						</div>
						<div class="sort-button"></div>
					</div>
					<div class="entry">
						<div class="view-button active grid"><i class="fa fa-th"></i></div>
						<div class="view-button list"><i class="fa fa-list"></i></div>
					</div>
					<div class="entry">
						<div class="inline-text">Show</div>
						<div class="simple-drop-down" style="width: 75px;">
							<select>
								<option>12</option>
								<option>20</option>
								<option>30</option>
								<option>40</option>
								<option>all</option>
							</select>
						</div>
						<div class="inline-text">per page</div>
					</div>
				</div>
				<div class="clear"></div>
			</div>
			<cfif REQUEST.pageData.category.getDisplayCustomDesign() EQ true>
				#REQUEST.pageData.category.getCustomDesign()#
			</cfif>
			<div class="row shop-grid grid-view">	
				<cfloop array="#REQUEST.pageData.paginationInfo.records#" index="product">
					<div class="col-md-3 col-sm-4 shop-grid-item">
						<div class="product-slide-entry shift-image">
							<div class="product-image">
								<!--- <img class="thumbnail-img" src="#product.getDefaultImageLink(type='small')#" /> --->
								<img src="#SESSION.absoluteUrlTheme#images/product-minimal-1.jpg" alt="" />
								<img src="#SESSION.absoluteUrlTheme#images/product-minimal-11.jpg" alt="" />
								<div class="bottom-line left-attached">
									<a class="bottom-line-a square"><i class="fa fa-shopping-cart"></i></a>
									<a class="bottom-line-a square"><i class="fa fa-heart"></i></a>
									<a class="bottom-line-a square"><i class="fa fa-retweet"></i></a>
									<a class="bottom-line-a square"><i class="fa fa-expand"></i></a>
								</div>
							</div>
							<a class="tag" href="##">Men clothing</a>
							<a class="title" href="#product.getDetailPageURL()#">#product.getDisplayName()#</a>
							<div class="rating-box">
								<div class="star"><i class="fa fa-star"></i></div>
								<div class="star"><i class="fa fa-star"></i></div>
								<div class="star"><i class="fa fa-star"></i></div>
								<div class="star"><i class="fa fa-star"></i></div>
								<div class="star"><i class="fa fa-star"></i></div>
								<div class="reviews-number">25 reviews</div>
							</div>
							<div class="article-container style-1">
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
							</div>
							<div class="price">
								<div class="prev">$#LSCurrencyFormat(product.getPrice(customerGroupId = SESSION.user.customerGroupId, currencyId = SESSION.currency.id),"local",SESSION.currency.locale)#</div>
								<div class="current">$#LSCurrencyFormat(product.getPrice(customerGroupId = SESSION.user.customerGroupId, currencyId = SESSION.currency.id),"local",SESSION.currency.locale)#</div>
							</div>
							<div class="list-buttons">
								<a class="button style-10">Add to cart</a>
								<a class="button style-11"><i class="fa fa-heart"></i> Add to Wishlist</a>
							</div>
						</div>
						<div class="clear"></div>
					</div>
				</cfloop>
			</div>
			<div class="page-selector">
				<div class="description">Showing: 1-3 of #ArrayLen(REQUEST.pageData.paginationInfo.records)#</div>
				<div class="pages-box">
					<cfif ArrayLen(REQUEST.pageData.pageArray) GT 1>
						<cfloop array="#REQUEST.pageData.pageArray#" index="page">
							<a href="#page.link#" class="square-button <cfif page.selected>active</cfif>">#page.number#</a>
						</cfloop>
						<div class="divider">...</div>
						<a href="##" class="square-button"><i class="fa fa-angle-right"></i></a>
					</cfif>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<div class="col-md-3 col-md-pull-9 col-sm-4 col-sm-pull-8 blog-sidebar">
		
			<div class="information-blocks categories-border-wrapper">
				<div class="block-title size-3">Categories</div>
				<div class="accordeon">
					<cfloop from="1" to="#ArrayLen(REQUEST.pageData.categoryTree)#" index="i">
						<cfset cat = REQUEST.pageData.categoryTree[i] />
						<div class="accordeon-title">#cat.getDisplayName()#</div>
						<div class="accordeon-entry" style="
							<cfif cat.getIsExpanded()>
							display:block;
							</cfif>
							"
							>
							<div class="article-container style-1">
								<ul>
									<cfloop array="#cat.getSubCategories()#" index="subCat">
										<li><a href="#subCat.getDetailPageURL()#" <cfif subCat.getIsActive()>text-color:##fff;background-color:##000;</cfif>>#subCat.getDisplayName()#</a></li>
									</cfloop>
									<li><a href="#cat.getDetailPageURL()#" <cfif cat.getIsActive()>text-color:##fff;background-color:##000;</cfif>>View All</a></li>
								</ul>
							</div>
						</div>
					</cfloop>
				</div>
			</div>

			<cfif REQUEST.pageData.category.getDisplayFilter() EQ true>				
				#REQUEST.moduleView.products_size_filter#
				#REQUEST.moduleView.products_color_filter#
				#REQUEST.moduleView.products_brand_filter#
			</cfif>
		</div>
	</div>
</div>
</cfoutput>
