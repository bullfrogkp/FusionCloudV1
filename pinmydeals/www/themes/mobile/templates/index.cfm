<cfoutput>
<div class="parallax-slide fullwidth-block small-slide" style="margin-bottom: 30px; margin-top: -25px;">
	<div class="swiper-container" data-autoplay="5000" data-loop="1" data-speed="500" data-center="0" data-slides-per-view="1">
		<div class="swiper-wrapper">
			#REQUEST.moduleData.slide.slideSection#
		</div>
		<div class="pagination"></div>
	</div>
</div>

<div class="information-blocks">
	<div class="row">
		<cfloop array="#REQUEST.moduleData.index_s1.categories#" index="category">
			<div class="col-sm-4 information-entry">
				<div class="special-item-entry">
					<img src="#category.image#" alt="" />
					<h3 class="title">Check out this weekend <span>#category.name#</span></h3>
					<a class="button style-6" href="##">shop now</a>
				</div>
			</div>
		</cfloop>
	</div>
</div>

<div class="information-blocks">
	<div class="tabs-container">
		<div class="swiper-tabs tabs-switch">
			<div class="title">Products</div>
			<div class="list">
				<cfloop from="1" to="#ArrayLen(REQUEST.moduleData.index_s2.tabs)#" index="tabIdx">
					<a class="block-title tab-switcher <cfif tabIdx EQ 1>active</cfif>">#REQUEST.moduleData.index_s2.tabs[tabIdx].name#</a>
				</cfloop>
				<div class="clear"></div>
			</div>
		</div>
		<div>
			<cfloop array="#REQUEST.moduleData.index_s2.tabs#" index="tab">
				<div class="tabs-entry">
					<div class="products-swiper">
						<div class="swiper-container" data-autoplay="0" data-loop="0" data-speed="500" data-center="0" data-slides-per-view="responsive" data-xs-slides="2" data-int-slides="2" data-sm-slides="3" data-md-slides="4" data-lg-slides="5" data-add-slides="5">
							<div class="swiper-wrapper">
								<cfloop array="#tab.products#" index="product">
									<div class="swiper-slide"> 
										<div class="paddings-container">
											<div class="product-slide-entry shift-image">
												<div class="product-image">
													<img src="#product.image1#" alt="" />
													<img src="#product.image2#" alt="" />
													<a class="top-line-a right open-product" popupid="#product.id#"><i class="fa fa-expand"></i> <span>Quick View</span></a>
													<div class="bottom-line">
														<div class="right-align">
															<a class="bottom-line-a square"><i class="fa fa-retweet"></i></a>
															<a class="bottom-line-a square"><i class="fa fa-heart"></i></a>
														</div>
														<div class="left-align">
															<a class="bottom-line-a"><i class="fa fa-shopping-cart"></i> Add to cart</a>
														</div>
													</div>
												</div>
												<a class="tag" href="##">#product.categoryName#</a>
												<a class="title" href="##">#product.name#</a>
												<div class="rating-box">
													<div class="star"><i class="fa fa-star"></i></div>
													<div class="star"><i class="fa fa-star"></i></div>
													<div class="star"><i class="fa fa-star"></i></div>
													<div class="star"><i class="fa fa-star"></i></div>
													<div class="star"><i class="fa fa-star"></i></div>
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
			</cfloop>
		</div>
	</div>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="information-entry col-md-6">
			<div class="image-text-widget" style="background-image: url(#REQUEST.moduleData.index_s3.left.image#);">
				<div class="hot-mark red">hot</div>
				<h3 class="title">#REQUEST.moduleData.index_s3.left.name#</h3>
				<div class="article-container style-1">
					<p>#REQUEST.moduleData.index_s3.left.description#</p>
					<ul>
						<cfloop array="#REQUEST.moduleData.index_s3.left.links#" index="link">
							<li><a href="#link.href#">#link.text#</a></li>
						</cfloop>
					</ul>
				</div>
			</div>
		</div>
		<div class="information-entry col-md-6">
			<div class="image-text-widget" style="background-image: url(#REQUEST.moduleData.index_s3.right.image#);">
				<div class="hot-mark red">hot</div>
				<h3 class="title">#REQUEST.moduleData.index_s3.right.name#</h3>
				<div class="article-container style-1">
					<p>#REQUEST.moduleData.index_s3.right.description#</p>
					<ul>
						<cfloop array="#REQUEST.moduleData.index_s3.right.links#" index="link">
							<li><a href="#link.href#">#link.text#</a></li>
						</cfloop>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>    

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-4 information-entry">
			<h3 class="block-title inline-product-column-title">#REQUEST.moduleData.index_s4.left.name#</h3>
			<cfloop array="#REQUEST.moduleData.index_s4.left.links#" index="link">
				<div class="inline-product-entry">
					<a href="#link.href#" class="image"><img alt="" src="#link.image#"></a>
					<div class="content">
						<div class="cell-view">
							<a href="#link.href#" class="title">#link.text#</a>
							<div class="price">
								<div class="prev">$#link.previousPrice#</div>
								<div class="current">$#link.currentPrice#</div>
							</div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
			</cfloop>
		</div>
		<div class="col-sm-4 information-entry">
			<h3 class="block-title inline-product-column-title">#REQUEST.moduleData.index_s4.middle.name#</h3>
			<cfloop array="#REQUEST.moduleData.index_s4.middle.links#" index="link">
				<div class="inline-product-entry">
					<a href="#link.href#" class="image"><img alt="" src="#link.image#"></a>
					<div class="content">
						<div class="cell-view">
							<a href="#link.href#" class="title">#link.text#</a>
							<div class="price">
								<div class="prev">$#link.previousPrice#</div>
								<div class="current">$#link.currentPrice#</div>
							</div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
			</cfloop>
		</div>
		<div class="col-sm-4 information-entry">
			<h3 class="block-title inline-product-column-title">#REQUEST.moduleData.index_s4.right.name#</h3>
			<cfloop array="#REQUEST.moduleData.index_s4.right.links#" index="link">
				<div class="inline-product-entry">
					<a href="#link.href#" class="image"><img alt="" src="#link.image#"></a>
					<div class="content">
						<div class="cell-view">
							<a href="#link.href#" class="title">#link.text#</a>
							<div class="price">
								<div class="prev">$#link.previousPrice#</div>
								<div class="current">$#link.currentPrice#</div>
							</div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
			</cfloop>
		</div>
	</div>
</div>   

<cfloop array="#REQUEST.moduleData.index_s2.tabs#" index="tab">
	<cfloop array="#tab.products#" index="product">
		<div id="product-popup-#product.id#" class="overlay-popup">
			<div class="overflow">
				<div class="table-view">
					<div class="cell-view">
						<div class="close-layer"></div>
						<div class="popup-container">

							<div class="row">
								<div class="col-sm-6 information-entry">
									<div class="product-preview-box">
										<div class="swiper-container product-preview-swiper" data-autoplay="0" data-loop="1" data-speed="500" data-center="0" data-slides-per-view="1">
											<div class="swiper-wrapper">
												<div class="swiper-slide">
													<div class="product-zoom-image">
														<img src="#SESSION.absoluteUrlTheme#images/product-main-1.jpg" alt="" data-zoom="#SESSION.absoluteUrlTheme#images/product-main-1-zoom.jpg" />
													</div>
												</div>
												<div class="swiper-slide">
													<div class="product-zoom-image">
														<img src="#SESSION.absoluteUrlTheme#images/product-main-2.jpg" alt="" data-zoom="#SESSION.absoluteUrlTheme#images/product-main-2-zoom.jpg" />
													</div>
												</div>
												<div class="swiper-slide">
													<div class="product-zoom-image">
														<img src="#SESSION.absoluteUrlTheme#images/product-main-3.jpg" alt="" data-zoom="#SESSION.absoluteUrlTheme#images/product-main-3-zoom.jpg" />
													</div>
												</div>
												<div class="swiper-slide">
													<div class="product-zoom-image">
														<img src="#SESSION.absoluteUrlTheme#images/product-main-4.jpg" alt="" data-zoom="#SESSION.absoluteUrlTheme#images/product-main-4-zoom.jpg" />
													</div>
												</div>
											</div>
											<div class="pagination"></div>
											<div class="product-zoom-container">
												<div class="move-box">
													<img class="default-image" src="#SESSION.absoluteUrlTheme#images/product-main-1.jpg" alt="" />
													<img class="zoomed-image" src="#SESSION.absoluteUrlTheme#images/product-main-1-zoom.jpg" alt="" />
												</div>
												<div class="zoom-area"></div>
											</div>
										</div>
										<div class="swiper-hidden-edges">
											<div class="swiper-container product-thumbnails-swiper" data-autoplay="0" data-loop="0" data-speed="500" data-center="0" data-slides-per-view="responsive" data-xs-slides="3" data-int-slides="3" data-sm-slides="3" data-md-slides="4" data-lg-slides="4" data-add-slides="4">
												<div class="swiper-wrapper">
													<div class="swiper-slide selected">
														<div class="paddings-container">
															<img src="#SESSION.absoluteUrlTheme#images/product-main-1.jpg" alt="" />
														</div>
													</div>
													<div class="swiper-slide">
														<div class="paddings-container">
															<img src="#SESSION.absoluteUrlTheme#images/product-main-2.jpg" alt="" />
														</div>
													</div>
													<div class="swiper-slide">
														<div class="paddings-container">
															<img src="#SESSION.absoluteUrlTheme#images/product-main-3.jpg" alt="" />
														</div>
													</div>
													<div class="swiper-slide">
														<div class="paddings-container">
															<img src="#SESSION.absoluteUrlTheme#images/product-main-4.jpg" alt="" />
														</div>
													</div>
												</div>
												<div class="pagination"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-sm-6 information-entry">
									<div class="product-detail-box">
										<h1 class="product-title">T-shirt Basic Stampata #product.id#</h1>
										<h3 class="product-subtitle">Loremous Clothing</h3>
										<div class="rating-box">
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star"></i></div>
											<div class="star"><i class="fa fa-star-o"></i></div>
											<div class="star"><i class="fa fa-star-o"></i></div>
											<div class="rating-number">25 Reviews</div>
										</div>
										<div class="product-description detail-info-entry">Lorem ipsum dolor sit amet, consectetur adipiscing elit, eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur.</div>
										<div class="price detail-info-entry">
											<div class="prev">$90,00</div>
											<div class="current">$70,00</div>
										</div>
										<div class="size-selector detail-info-entry">
											<div class="detail-info-entry-title">Size</div>
											<div class="entry active">xs</div>
											<div class="entry">s</div>
											<div class="entry">m</div>
											<div class="entry">l</div>
											<div class="entry">xl</div>
											<div class="spacer"></div>
										</div>
										<div class="color-selector detail-info-entry">
											<div class="detail-info-entry-title">Color</div>
											<div class="entry active" style="background-color: ##d23118;">&nbsp;</div>
											<div class="entry" style="background-color: ##2a84c9;">&nbsp;</div>
											<div class="entry" style="background-color: ##000;">&nbsp;</div>
											<div class="entry" style="background-color: ##d1d1d1;">&nbsp;</div>
											<div class="spacer"></div>
										</div>
										<div class="quantity-selector detail-info-entry">
											<div class="detail-info-entry-title">Quantity</div>
											<div class="entry number-minus">&nbsp;</div>
											<div class="entry number">10</div>
											<div class="entry number-plus">&nbsp;</div>
										</div>
										<div class="detail-info-entry">
											<a class="button style-10">Add to cart</a>
											<a class="button style-11"><i class="fa fa-heart"></i> Add to Wishlist</a>
											<div class="clear"></div>
										</div>
										<div class="tags-selector detail-info-entry">
											<div class="detail-info-entry-title">Tags:</div>
											<a href="##">bootstrap</a>/
											<a href="##">collections</a>/
											<a href="##">color/</a>
											<a href="##">responsive</a>
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
	</cfloop>
</cfloop>
</cfoutput>