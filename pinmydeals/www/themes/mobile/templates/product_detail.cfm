<cfoutput>
<cfsavecontent variable="htmlhead">
	<script language="javascript" type="text/javascript">
		var productType = '#REQUEST.pageData.product.getProductType().getName()#';
		var cartRequestUrl = 'http://api.pinmydeals.loc/services/cartService.cfc';
		var absoluteUrlSite = '#APPLICATION.absoluteUrlSite#';
		var trackingEntityId = #REQUEST.pageData.trackingEntityId#;
		var customerGroupId = #SESSION.user.customerGroupId#;
		var currencyId = #SESSION.currency.id#;
		
		if(productType == 'configurable') {
			var selectedProductId = 0;
			var optionStruct = new Object();
			var optionArray = new Array();
			
			<cfloop array="#REQUEST.pageData.product.getProductAttributeRelas()#" index="productAttributeRela">
				<cfloop array="#productAttributeRela.getAttributeValues()#" index="attributeValue">
					optionStruct['#attributeValue.getAttributeValueId()#'] = #productAttributeRela.getAttribute().getAttributeId()#;
				</cfloop>
			</cfloop>
			
			var optionArrayLength = #ArrayLen(REQUEST.pageData.product.getProductAttributeRelas())#;
			var parentProductId = '#REQUEST.pageData.product.getProductId()#';
			var customerGroupId = '#SESSION.user.customerGroupId#';
			var requestUrl = 'http://api.pinmydeals.loc/services/productService.cfc';
			var currencySymbol = '#SESSION.currency.symbol#';
		} else {
			selectedProductId = #REQUEST.pageData.product.getProductId()#;
		}
	</script>
</cfsavecontent>
<cfhtmlhead text="#htmlhead#">

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-5 col-md-4 col-lg-5 information-entry">
			<div class="product-preview-box">
				<cfset images = REQUEST.pageData.product.getImages() />
				<div class="swiper-container product-preview-swiper" data-autoplay="0" data-loop="1" data-speed="500" data-center="0" data-slides-per-view="1">
					<div class="swiper-wrapper">
						<cfloop array="#images#" index="img">
							<div class="swiper-slide">
								<div class="product-zoom-image">
									<img src="#img.getImageLink(type='medium')#" alt="" data-zoom="#img.getImageLink()#" />
								</div>
							</div>
						</cfloop>
					</div>
					<div class="pagination"></div>
					<div class="product-zoom-container">
						<div class="move-box">
							<img class="default-image" src="#images[1].getImageLink(type='medium')#" alt="" />
							<img class="zoomed-image" src="#images[1].getImageLink()#" alt="" />
						</div>
						<div class="zoom-area"></div>
					</div>
				</div>
				<div class="swiper-hidden-edges">
					<div class="swiper-container product-thumbnails-swiper" data-autoplay="0" data-loop="0" data-speed="500" data-center="0" data-slides-per-view="responsive" data-xs-slides="3" data-int-slides="3" data-sm-slides="3" data-md-slides="4" data-lg-slides="4" data-add-slides="4">
						<div class="swiper-wrapper">
							<cfloop from="1" to ="#ArrayLen(images)#" index="i">
								<div class="swiper-slide <cfif i EQ 1>selected</cfif>">
									<div class="paddings-container">
										<img src="#images[i].getImageLink(type='small')#" alt="" />
									</div>
								</div>
							</cfloop>
						</div>
						<div class="pagination"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-7 col-md-4 information-entry">
			<div class="product-detail-box">
				<h1 class="product-title">#REQUEST.pageData.product.getDisplayName()#</h1>
				<h3 class="product-subtitle">SKU:#REQUEST.pageData.product.getSku()#</h3>
				<div class="rating-box">
					<cfloop from="1" to="#REQUEST.pageData.product.getStarCountMV()#" index="j">
						<div class="star"><i class="fa fa-star"></i></div>
					</cfloop>
					<cfloop from="#REQUEST.pageData.product.getStarCountMV()#" to="#5 - REQUEST.pageData.product.getStarCountMV()#" index="k">
						<div class="star"><i class="fa fa-star-o"></i></div>
					</cfloop>
					<div class="rating-number">#REQUEST.pageData.product.getReviewCountMV()# Reviews</div>
				</div>
				<div class="product-description detail-info-entry">
				#REQUEST.pageData.product.getDescription()#
				</div>
				<div class="price detail-info-entry">
					<cfif REQUEST.pageData.product.getProductType().getName() EQ "single">
						<cfset oriPrice = REQUEST.pageData.product.getOriginalPrice(customerGroupId = SESSION.user.customerGroupId, currencyId = SESSION.currency.id) />
						<cfset curPrice = REQUEST.pageData.product.getPrice(customerGroupId = SESSION.user.customerGroupId, currencyId = SESSION.currency.id) />
						<cfif oriPrice GT curPrice>
							<div class="prev">#LSCurrencyFormat(oriPrice,"local",SESSION.currency.locale)#</div>
						</cfif>
						<div class="current">#LSCurrencyFormat(curPrice,"local",SESSION.currency.locale)#</div>
						<div id="stock-detail"><cfif REQUEST.pageData.product.getStock() GT 0>#REQUEST.pageData.product.getStock()# in stock<cfelse>Stock is not available</cfif></div>
					<cfelseif REQUEST.pageData.product.getProductType().getName() EQ "configurable">
						<div class="prev" style="display:none;"></div>
						<div class="current" style="display:none;"></div>
						<div id="stock-detail" style="display:none;letter-spacing:0px;"></div>
					</cfif>
				</div>
				
				<cfif REQUEST.pageData.product.getProductType().getName() EQ "configurable">
					#REQUEST.moduleData.product_detail_options#
				</cfif>
				
				<div class="quantity-selector detail-info-entry">
					<div class="detail-info-entry-title">Quantity</div>
					<div class="entry number-minus">&nbsp;</div>
					<div class="entry number" id="quantity">1</div>
					<div class="entry number-plus">&nbsp;</div>
				</div>
				<div class="detail-info-entry">
					<cfif REQUEST.pageData.product.getProductType().getName() EQ "single">
						<a class="button style-10 open-product" id="add-to-cart" popupid="#REQUEST.pageData.product.getProductId()#">Add to cart</a>
					<cfelseif REQUEST.pageData.product.getProductType().getName() EQ "configurable">
						<a class="button style-10 open-product" id="add-to-cart" popupid="#REQUEST.pageData.product.getProductId()#" style="display:none;">Add to cart</a>
						<a class="button style-10 disabled" id="add-to-cart-disabled"  style="cursor:not-allowed;">Add to cart</a>
					</cfif>
					<a class="button style-11"><i class="fa fa-heart"></i> Add to Wishlist</a>
					<div class="clear"></div>
				</div>
				<div class="tags-selector detail-info-entry">
					<div class="detail-info-entry-title">Tags:</div>
					<cfloop array="#REQUEST.pageData.product.getProductTags()#" index="tag">
						<a href="#tag.getTagPageURL()#">#tag.getDisplayName()#</a>/
					</cfloop>
				</div>
				<div class="share-box detail-info-entry">
					<div class="title">Share in social media</div>
					<div class="socials-box">
						<a href="##"><i class="fa fa-facebook"></i></a>
						<a href="##"><i class="fa fa-twitter"></i></a>
						<a href="##"><i class="fa fa-google-plus"></i></a>
						<a href="##"><i class="fa fa-youtube"></i></a>
						<a href="##"><i class="fa fa-linkedin"></i></a>
						<a href="##"><i class="fa fa-instagram"></i></a>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
		<div class="clear visible-xs visible-sm"></div>
		<div class="col-md-4 col-lg-3 information-entry product-sidebar">
			<div class="row">
				<div class="col-md-12">
					<div class="information-blocks production-logo">
						<div class="background">
							<div class="logo"><img src="#REQUEST.pageData.product.getLogoURL()#" alt="" /></div>
							<a href="##">Review this producent</a>
						</div>
					</div>
				</div>
				<div class="col-md-12">
					<div class="information-blocks">
						<div class="information-entry products-list">
							<h3 class="block-title inline-product-column-title">Related products</h3>
							<cfloop array="#REQUEST.moduleData.product_detail_related_products.products#" index="product">
								<div class="inline-product-entry">
									<a href="#product.href#" class="image"><img alt="" src="#product.image#"></a>
									<div class="content">
										<div class="cell-view">
											<a href="#product.href#" class="title">#product.name#</a>
											<div class="price">
												<div class="prev">$#product.previousPrice#</div>
												<div class="current">$#product.currentPrice#</div>
											</div>
										</div>
									</div>
									<div class="clear"></div>
								</div>
							</cfloop>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="information-blocks">
	<div class="tabs-container style-1">
		<div class="swiper-tabs tabs-switch">
			<div class="title">Product Information</div>
			<div class="list">
				<a class="tab-switcher active">Description</a>
				<a class="tab-switcher">SHIPPING &amp; RETURNS</a>
				<a class="tab-switcher">Reviews (#REQUEST.pageData.product.getReviewCountMV()#)</a>
				<div class="clear"></div>
			</div>
		</div>
		<div>
			<div class="tabs-entry">
				<div class="article-container style-1">
					<div class="row">
						#REQUEST.pageData.product.getDetail()#
					</div>
				</div>
			</div>
			<div class="tabs-entry">
				<div class="article-container style-1">
					<div class="row">
						<div class="col-md-6 information-entry">
							<h4>RETURNS POLICY</h4>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit.</p>
							<ul>
								<li>Any Product types that You want - Simple, Configurable</li>
								<li>Downloadable/Digital Products, Virtual Products</li>
								<li>Inventory Management with Backordered items</li>
								<li>Customer Personal Products - upload text for embroidery, monogramming</li>
								<li>Create Store-specific attributes on the fly</li>
							</ul>
						</div>
						<div class="col-md-6 information-entry">
							<h4>SHIPPING</h4>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.</p>
							<ul>
								<li>Any Product types that You want - Simple, Configurable</li>
								<li>Downloadable/Digital Products, Virtual Products</li>
								<li>Inventory Management with Backordered items</li>
								<li>Customer Personal Products - upload text for embroidery, monogramming</li>
								<li>Create Store-specific attributes on the fly</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="tabs-entry">
				<div class="article-container style-1">
					<div class="row">
						<cfloop array="#REQUEST.pageData.product.getApprovedReviews()#" index="review">
							<div class="col-md-6 information-entry">
								<div style="border-bottom: 1px dashed ##CCCCCC;">
									<p style="font-weight:bold;">#review.getSubject()# Review by #review.getReviewerName()#</p>
									<p style="width:200px;height: 13px;
										background: url(#SESSION.absoluteUrlTheme#images/breadcrub20140512.png);
										background-position: left -1500px;
										background-repeat: no-repeat;"></p>
									<p>#review.getMessage()#</p>
									<p>(Posted on #DateFormat(review.getCreatedDatetime(),"mmm dd, yyyy")#)</p>
								</div>
							</div>
						</cfloop>
						<div>
							<p style="font-weight:bold;">Write Your Own Review</p>
							<p style="font-weight:bold;">How do you rate this product?</p>
							<input type="radio" name="review_rating" value="1" /> 1
							<input type="radio" name="review_rating" value="2" /> 2
							<input type="radio" name="review_rating" value="3" /> 3
							<input type="radio" name="review_rating" value="4" /> 4
							<input type="radio" name="review_rating" value="5" /> 5
							<p style="font-weight:bold;">Name</p>
							<p><input name="reviewer_name" type="text" style="width:100%;" /></p>
							<p style="font-weight:bold;">Subject</p>
							<p><input name="review_subject" type="text" style="width:100%;" /></p>
							<p style="font-weight:bold;">Content</p>
							<p><textarea name="review_message" style="width:100%;height:100px;" /></textarea></p>
							<p><input name="add_review" type="submit" value="Submit" style="padding:5px 10px;" /></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="information-blocks">
	<h3 class="block-title inline-product-column-title">Customers Who Bought This Item Also Bought</h3>
	<div class="products-swiper">
		<div class="swiper-container" data-autoplay="0" data-loop="0" data-speed="500" data-center="0" data-slides-per-view="responsive" data-xs-slides="2" data-int-slides="2" data-sm-slides="3" data-md-slides="4" data-lg-slides="5" data-add-slides="5">
			<div class="swiper-wrapper">
				<cfloop array="#REQUEST.moduleData.product_detail_also_bought_products.products#" index="product">
					<div class="swiper-slide"> 
						<div class="paddings-container">
							<div class="product-slide-entry shift-image">
								<div class="product-image">
									<img src="#product.image1#" alt="" />
									<img src="#product.image2#" alt="" />
									<a class="top-line-a left"><i class="fa fa-retweet"></i></a>
									<a class="top-line-a right"><i class="fa fa-heart"></i></a>
									<div class="bottom-line">
										<a class="bottom-line-a"><i class="fa fa-shopping-cart"></i> Add to cart</a>
									</div>
								</div>
								<a class="tag" href="#product.categoryHref#">#product.categoryName#</a>
								<a class="title" href="#product.href#">#product.name#</a>
								<div class="rating-box">
									<cfloop from="1" to="#product.stars#" index="j">
										<div class="star"><i class="fa fa-star"></i></div>
									</cfloop>
									<cfloop from="#product.stars#" to="#product.stars#" index="k">
										<div class="star"><i class="fa fa-star-o"></i></div>
									</cfloop>
								</div>
								<div class="price">
									<div class="prev">$#product.previousPrice#</div>
									<div class="current">$#product.currentPrice#</div>
								</div>
							</div>
						</div>
					</div>
				</cfloop>
			</div>
			<div class="pagination"></div>
		</div>
	</div>
</div>

<div id="product-popup-#REQUEST.pageData.product.getProductId()#" class="overlay-popup">
	<div class="overflow">
		<div class="table-view">
			<div class="cell-view">
				<div class="close-layer"></div>
				<div class="popup-container">
					<div class="row">
						<div class="col-sm-6 information-entry">
							<img src="#SESSION.absoluteUrlTheme#images/product-main-1.jpg" alt="" data-zoom="#SESSION.absoluteUrlTheme#images/product-main-1-zoom.jpg" style="width:100%" />
						</div>
						<div class="col-sm-6 information-entry">
							<div class="product-detail-box">
								<h1 class="product-title">#REQUEST.pageData.product.getDisplayName()#</h1>
								<h3 class="product-subtitle">Item successfully added to your cart</h3>
								<div class="price detail-info-entry">
									<cfif REQUEST.pageData.product.getProductType().getName() EQ "single">
										<cfset oriPrice = REQUEST.pageData.product.getOriginalPrice(customerGroupId = SESSION.user.customerGroupId, currencyId = SESSION.currency.id) />
										<cfset curPrice = REQUEST.pageData.product.getPrice(customerGroupId = SESSION.user.customerGroupId, currencyId = SESSION.currency.id) />
										<cfif oriPrice GT curPrice>
											<div class="prev">#LSCurrencyFormat(oriPrice,"local",SESSION.currency.locale)#</div>
										</cfif>
										<div class="current">#LSCurrencyFormat(curPrice,"local",SESSION.currency.locale)#</div>
									<cfelseif REQUEST.pageData.product.getProductType().getName() EQ "configurable">
										<div class="prev" style="display:none;"></div>
										<div class="current" style="display:none;"></div>
									</cfif>
								</div>
								#REQUEST.moduleData.product_detail_options#
								<div class="detail-info-entry">
									<a class="button style-10" href="#APPLICATION.absoluteUrlSite#cart.cfm">Checkout</a>
									<a class="button style-11 close-window">Continue Shopping</a>
									<div class="clear"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="close-popup"></div>
				</div>
			</div>
		</div>
	</div>
</div>
</cfoutput>
