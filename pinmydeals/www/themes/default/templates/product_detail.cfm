<cfoutput>
<script>
	$(document).ready(function() {
		<cfif Find("no_image_available",REQUEST.pageData.product.getDefaultImageLink()) EQ 0>
		$("##img_01").elevateZoom({gallery:'gallery_01', cursor: 'pointer', galleryActiveClass: 'active', borderSize: '1', imageCrossfade: true, loadingIcon: '#SESSION.absoluteUrlTheme#images/loader.gif'}); 
		$("##img_01").bind("click", function(e) { var ez = $('##img_01').data('elevateZoom');	$.fancybox(ez.getGalleryList()); return false; }); 
		</cfif>
		
		var dialog, form,
 
		emailRegex = /^[a-zA-Z0-9.!##$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
		name = $( "##name" ),
		email = $( "##email" ),
		password = $( "##password" ),
		allFields = $( [] ).add( name ).add( email ).add( password ),
		tips = $( ".validateTips" );

		function updateTips( t ) {
		tips
		.text( t )
		.addClass( "ui-state-highlight" );
		setTimeout(function() {
		tips.removeClass( "ui-state-highlight", 1500 );
		}, 500 );
		}

		function checkLength( o, n, min, max ) {
		if ( o.val().length > max || o.val().length < min ) {
		o.addClass( "ui-state-error" );
		updateTips( "Length of " + n + " must be between " +
		  min + " and " + max + "." );
		return false;
		} else {
		return true;
		}
		}

		function checkRegexp( o, regexp, n ) {
		if ( !( regexp.test( o.val() ) ) ) {
		o.addClass( "ui-state-error" );
		updateTips( n );
		return false;
		} else {
		return true;
		}
		}

		function addUser() {
		var valid = true;
		allFields.removeClass( "ui-state-error" );

		valid = valid && checkLength( name, "username", 3, 16 );
		valid = valid && checkLength( email, "email", 6, 80 );
		valid = valid && checkLength( password, "password", 5, 16 );

		valid = valid && checkRegexp( name, /^[a-z]([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter." );
		valid = valid && checkRegexp( email, emailRegex, "eg. ui@jquery.com" );
		valid = valid && checkRegexp( password, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9" );

		if ( valid ) {
		$( "##users tbody" ).append( "<tr>" +
		  "<td>" + name.val() + "</td>" +
		  "<td>" + email.val() + "</td>" +
		  "<td>" + password.val() + "</td>" +
		"</tr>" );
		dialog.dialog( "close" );
		}
		return valid;
		}

		dialog = $( "##dialog-form" ).dialog({
		autoOpen: false,
		height: 370,
		width: 350,
		modal: true,
		show: 'fade',
		hide: 'fade',
		dialogClass: 'main-dialog-class',
		buttons: [

		{
			text: "Checkout",
			"class": 'checkoutButtonClass',
			click: function() {
			window.location.href='#APPLICATION.absoluteUrlWeb#cart.cfm';
			}
		},
		{
			text: "Continute Shopping",
			"class": 'continuteButtonClass',
			click: function() {
			dialog.dialog('close');
			}
		}
		],
		open: function(event) {
		$('.ui-dialog-buttonpane').find('button:contains("Continute Shopping")').css("margin-right","-9px");
		},
		close: function() {

		},

		});
		
		wishlistdialog = $( "##wishlist-form" ).dialog({
		autoOpen: false,
		height: 370,
		width: 350,
		modal: true,
		show: 'fade',
		hide: 'fade',
		dialogClass: 'main-dialog-class',
		buttons: [

		{
			text: "My Wishlist",
			"class": 'checkoutButtonClass',
			click: function() {
			window.location.href='#APPLICATION.absoluteUrlWeb#wishlist.cfm';
			}
		},
		{
			text: "Continute Shopping",
			"class": 'continuteButtonClass',
			click: function() {
			dialog.dialog('close');
			}
		}
		],
		open: function(event) {
		$('.ui-dialog-buttonpane').find('button:contains("Continute Shopping")').css("margin-right","-9px");
		},
		close: function() {

		},

		});

		form = dialog.find( "form" ).on( "submit", function( event ) {
		event.preventDefault();
		addUser();
		});

		var valueElement = $('##product-count');
		
		function incrementValue(e){
			valueElement.val(Math.max(parseInt(valueElement.val()) + e.data.increment, 1));
			return false;
		}

		$('##plus').bind('click', {increment: 1}, incrementValue);

		$('##minus').bind('click', {increment: -1}, incrementValue);
		
		$( "##product-description" ).tabs();
	
		$(".fancybox").fancybox();
		$(".various").fancybox({
			maxWidth	: 800,
			maxHeight	: 600,
			fitToView	: false,
			width		: '70%',
			height		: '70%',
			autoSize	: false,
			closeClick	: false,
			openEffect	: 'none',
			closeEffect	: 'none'
		});
	
		var optionStruct = new Object();
		var optionArray = new Array();
		
		<cfloop array="#REQUEST.pageData.product.getProductAttributeRelas()#" index="productAttributeRela">
			<cfloop array="#productAttributeRela.getAttributeValues()#" index="attributeValue">
				optionStruct['#attributeValue.getAttributeValueId()#'] = #productAttributeRela.getAttribute().getAttributeId()#;
			</cfloop>
		</cfloop>
		
		$(".filter-options div").click(function() {
			$(this).closest('.filter-options').css("border-color","red");
			$(this).closest('.filter-options').siblings().css("border-color","##CCC");
			
			var index = $(this).closest('.filter-options').attr('attributevalueid');
			var value = optionStruct[index];
			var insert = true;
			
			for (var i = 0; i < optionArray.length; i++) {
				if(optionArray[i].attributeid == value)
				{
					optionArray[i].attributevalueid = index;
					insert = false;
					break;
				}
			}
			
			if(insert == true)
			{
				var option = new Object();
				option.attributeid = value;
				option.attributevalueid = index;
				optionArray.push(option);
			}
			
			if(optionArray.length == #REQUEST.pageData.requiredAttributeCount#)
			{
				var optionList = '';
				for (var i = 0; i < optionArray.length; i++) {
					optionList = optionList + optionArray[i].attributevalueid + ',';
				}
				
				$.ajax({
						type: "get",
						url: "#APPLICATION.absoluteUrlWeb#core/services/productService.cfc",
						dataType: 'json',
						data: {
							method: 'getProduct',
							parentProductId: #REQUEST.pageData.product.getProductId()#,
							attributeValueIdList: optionList,
							customerGroupId: '#SESSION.user.customerGroupId#'
						},		
						success: function(result) {
							var price = result.PRICE;
							var stock = result.STOCK;
							var productid = result.PRODUCTID;
						
						
							if(price > 0)
							{
								$("##price-amount").html('$' + price.toFixed(2));
							}
							else
							{
								$("##price-amount").html('Price is not available');
							}
							
							if(stock > 0)
							{
								$("##stock-count").html(stock + ' in stock');
							}
							else
							{
								$("##stock-count").html('Stock is not available');
							}
							
							if(price > 0 && stock > 0)
							{
								$("##selected_product_id").val(productid);
								$("##add-current-to-cart").show();
								$("##add-current-to-cart-disabled").hide();
								$("##add-current-to-wishlist").show();
								$("##add-current-to-wishlist-disabled").hide();
							}
							else
							{
								$("##selected_product_id").val(#REQUEST.pageData.product.getProductId()#);
								$("##add-current-to-cart").hide();
								$("##add-current-to-cart-disabled").show();
								$("##add-current-to-wishlist").hide();
								$("##add-current-to-wishlist-disabled").show();
							}
						}
				});
			}
		});
		
		$("##add-current-to-cart").click(function() {
			$.ajax({
						type: "get",
						url: "#APPLICATION.absoluteUrlWeb#core/services/trackingService.cfc",
						dataType: 'json',
						data: {
							method: 'addTrackingRecord',
							productId: $("##selected_product_id").val(),
							trackingRecordType: 'shopping cart',
							count: $("##product-count").val()
						},		
						success: function(result) {
							if(result.TRACKINGRECORDID)
							{
								dialog.dialog( "open" );
								$("##cart-info").html( parseInt($("##cart-info").html(), 10) + parseInt($("##product-count").val(), 10));
			
							}
							else
							{
								console.log('Fail to add record');
							}
						}
			});
		});
		$("##add-current-to-wishlist").click(function() {
			$.ajax({
						type: "get",
						url: "#APPLICATION.absoluteUrlWeb#core/services/trackingService.cfc",
						dataType: 'json',
						data: {
							method: 'addTrackingRecord',
							productId: $("##selected_product_id").val(),
							trackingRecordType: 'wishlist'
						},		
						success: function(result) {
							if(result.TRACKINGRECORDID)
							{
								wishlistdialog.dialog( "open" );			
							}
							else
							{
								console.log('Fail to add record');
							}
						}
			});
		});
		
		<cfif ArrayLen(REQUEST.pageData.product.getProductVideos()) GT 0>
			<cfloop array="#REQUEST.pageData.product.getProductVideos()#" index="productVideo">
				processURL('#productVideo.getUrl()#', 'video_#productVideo.getProductVideoId()#');
			</cfloop>
			
			function success(imgurl, divid) {
				$('##' + divid).html('<img src="' + imgurl + '" />');
				console.log($('##' + divid).html());
			}
			
			function processURL(url, divid){
				var id;

				if (url.indexOf('youtube.com') > -1) {
					<!-- CHANGED -->
					id = url.split('/embed/')[1];
					return processYouTube(id);
				} else if (url.indexOf('youtu.be') > -1) {
					id = url.split('/')[1];
					return processYouTube(id);
				} else if (url.indexOf('vimeo.com') > -1) {
					<!-- CHANGED -->
					if (url.match(/http:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/)) {
						id = url.split('/')[1];
					} else if (url.match(/^vimeo.com\/channels\/[\d\w]+##[0-9]+/)) {
						id = url.split('##')[1];
					} else if (url.match(/vimeo.com\/groups\/[\d\w]+\/videos\/[0-9]+/)) {
						id = url.split('/')[4];
					} else {
						throw new Error('Unsupported Vimeo URL');
					}

					$.ajax({
						url: 'http://vimeo.com/api/v2/video/' + id + '.json',
						dataType: 'jsonp',
						success: function(data) {
							<!-- CHANGED -->
							 success(data[0].thumbnail_large, divid);
						}
					});
				} else {
					throw new Error('Unrecognised URL');
				}

				function processYouTube(id) {
					if (!id) {
						throw new Error('Unsupported YouTube URL');
					}console.log(id);
					<!-- CHANGED -->
					success('http://i2.ytimg.com/vi/' + id + '/hqdefault.jpg', divid);
				}
			}
		</cfif>
		<!---
		var ddData = [
			<cfset s = REQUEST.pageData.shippingMethods />
			<cfloop query="s">
				{
					text: "#s.shipping_carrier_name# - #s.shipping_method_name#: #LSCurrencyFormat(s.shipping_price,"local",SESSION.currency.locale)#",
					value: #s.product_shipping_method_rela_id#,
					selected: false,
					imageSrc: "#APPLICATION.absoluteUrlWeb#images/uploads/shipping/#s.image_name#"
				}
				<cfif s.currentRow LT s.recordCount>
				,
				</cfif>
			</cfloop>
		];

		$('##shipping_methods').ddslick({
			data: ddData,
			width: 300,
			imagePosition: "left",
			selectText: "Select your shipping method",
			onSelected: function (data) {
				console.log(data);
			}
		});
		--->
	});
</script>
<style>
.dd-select {
  font-size:12px;
}

.dd-option-text, .dd-selected-text {
	font-size:12px;
	float:right;
	margin-right:20px;
}

.dd-option-image, .dd-selected-image {
	height:23px;
}
</style>

<form method="post">
<input type="hidden" id="selected_product_id" name="selected_product_id" value="#REQUEST.pageData.product.getProductId()#" />
<input type="hidden" id="current_product_id" name="current_product_id" value="#REQUEST.pageData.product.getProductId()#" />
<div style="margin-top:20px;">
	<div style="width:413px;float:left;">
		<img id="img_01" src="#REQUEST.pageData.product.getDefaultImageLink(type='medium')#" data-zoom-image="#REQUEST.pageData.product.getDefaultImageLink()#" />
		
		<div id="gallery_01"> 
			<cfloop array="#REQUEST.pageData.allImages#" index="img">
				<a href="##" data-image="#img.getImageLink(type='medium')#" data-zoom-image="#img.getImageLink()#"> 
					<img src="#img.getImageLink(type='small')#" /> 
				</a> 
			</cfloop>
		</div>
		
		<cfif ArrayLen(REQUEST.pageData.product.getProductVideos()) GT 0>
			<div id="videos">
				<div style="padding-bottom:5px;">Videos:</div>
				<cfloop array="#REQUEST.pageData.product.getProductVideos()#" index="productVideo">
					<a class="various fancybox.iframe" href="#productVideo.getUrl()#" id="video_#productVideo.getProductVideoId()#"></a> 
				</cfloop>
			</div>
		</cfif>
	</div>
	<div style="width:523px;float:right;">
		<div id="product-name" style="font-size:18px;font-weight:bold;">
			#REQUEST.pageData.product.getDisplayName()#
		</div>
		<div id="product-share" style="margin-top:10px;">
			<img class="logo facebook-logo" title="Share on Facebook" src="#SESSION.absoluteUrlTheme#images/p_facebook-color.png">
			<img class="logo twitter-logo" title="Share on Twitter" src="#SESSION.absoluteUrlTheme#images/p_tweet.png">
			<img class="logo google-logo" title="Share on Google Plus" src="#SESSION.absoluteUrlTheme#images/p_gplus-color.png">
			<img src="#SESSION.absoluteUrlTheme#images/p_pinterest.png">
		</div>
		<div id="product-sku" style="font-size:12px;margin-top:10px;">
			SKU:#REQUEST.pageData.product.getSku()#
		</div>
	
		<div id="product-filters" style="font-size:12px;margin-top:14px;padding-top:7px;border-top:1px dashed ##ccc;margin-bottom:-16px;">
			<div id="gallery_01">
			<cfloop array="#REQUEST.pageData.product.getProductAttributeRelas()#" index="productAttributeRela">
				<ul>
					<li style="width:40px;font-weight:bold;">#productAttributeRela.getAttribute().getDisplayName()#: </li>
					<cfloop array="#productAttributeRela.getAttributeValues()#" index="attributeValue">
						<li style="-webkit-border-radius: 2px;-moz-border-radius: 2px;border-radius: 2px;" class="filter-options" attributevalueid="#attributeValue.getAttributeValueId()#">
							<cfif NOT IsNull(attributeValue.getImageName())>
								<a href="##" data-image="#attributeValue.getImageLink(type="medium")#" data-zoom-image="#attributeValue.getImageLink()#">
							</cfif>
							<cfif NOT IsNull(attributeValue.getImageName())>
								<div style="width:22px;height:22px;background-image: url('#attributeValue.getImageLink(type = "thumbnail")#');background-size: 22px 22px;-webkit-border-radius: 1px;-moz-border-radius: 1px;border-radius: 1px;"></div>
							<cfelse>
								<cfif productAttributeRela.getAttribute().getDisplayName() EQ "color">
									<div style="width:22px;height:22px;background-color:#attributeValue.getValue()#;-webkit-border-radius: 1px;-moz-border-radius: 1px;border-radius: 1px;"></div>
								<cfelse>
									<div style="padding:5px 8px;">#attributeValue.getValue()#</div>
								</cfif>
							</cfif>
							<cfif NOT IsNull(attributeValue.getImageName())>
							</a>
							</cfif>
						</li>
					</cfloop>
					
				</ul>
				<div style="clear:both;"></div>
			</cfloop>
			</div>
		</div>
		<!---
		<div id="shipping_methods_div" style="margin-top:15px;padding-top:17px;border-top:1px dashed ##ccc;">
			<div id="shipping_methods"></div>
		</div>
		--->
		
		<div id="product-price" style="font-size:18px;font-weight:bold;color:##C20000;margin-top:18px;border-top:1px dashed ##ccc;padding-top:15px;">
			<cfif REQUEST.pageData.product.getProductType().getName() EQ "configurable">
				<span id="price-amount">Please choose your options</span>
				<div id="stock-count" style="color:##8F8F8F;margin-top:10px;font-size:14px;">In stock</div>
			<cfelseif REQUEST.pageData.product.getProductType().getName() EQ "single">
				#LSCurrencyFormat(REQUEST.pageData.product.getPrice(customerGroupId = SESSION.user.customerGroupId, currencyId = SESSION.currency.id),"local",SESSION.currency.locale)#
				<div style="color:##8F8F8F;margin-top:10px;font-size:14px;">
					#REQUEST.pageData.product.getStock()# in stock
				</div>
			</cfif>
		</div>
		<div id="product-addtocart" style="margin-top:30px;">
			<span style="font-size:13px;">Qty: </span>
			<button id="minus">-</button>
			<input id="product-count" type="text" value="1" style="width:30px;text-align:center;" />
			<button id="plus">+</button>
			
			<cfif REQUEST.pageData.product.getProductType().getName() EQ "configurable">
				<a id="add-current-to-cart" class="btn add-to-cart" style="padding-right:13px;margin-left:15px;display:none;">Add to Cart</a>
				<a id="add-current-to-cart-disabled" class="btn" style="padding-right:13px;margin-left:15px;opacity:0.5;cursor:not-allowed;pointer:not-allowed;">Add to Cart</a>
				<a id="add-current-to-wishlist" class="btn-wish" style="padding-right:13px;display:none;">Add to Wishlist</a>
				<a id="add-current-to-wishlist-disabled" class="btn-wish" style="padding-right:13px;opacity:0.5;cursor:not-allowed;pointer:not-allowed;">Add to Wishlist</a>
			<cfelseif REQUEST.pageData.product.getProductType().getName() EQ "single">
				<a id="add-current-to-cart" class="btn add-to-cart" style="padding-right:13px;margin-left:15px;">Add to Cart</a>
				<a id="add-current-to-wishlist" class="btn-wish" style="padding-right:13px;">Add to Wishlist</a>
			</cfif>
		</div>
		
		<div id="product-description">
			<ul>
				<li><a href="##tabs-1">Product Description</a></li>
				<li><a href="##tabs-2">Reviews</a></li>
			</ul>
			<div id="tabs-1">
				#REQUEST.pageData.product.getDetail()#
			</div>
		  <div id="tabs-2">
			<cfloop array="#REQUEST.pageData.reviews#" index="review">
				<div style="border-bottom: 1px dashed ##CCCCCC;">
					<p style="font-weight:bold;">#review.getSubject()# Review by #review.getReviewerName()#</p>
					<p style="width:200px;height: 13px;
						background: url(#SESSION.absoluteUrlTheme#images/breadcrub20140512.png);
						background-position: left -1500px;
						background-repeat: no-repeat;"></p>
					<p>#review.getMessage()#</p>
					<p>(Posted on #DateFormat(review.getCreatedDatetime(),"mmm dd, yyyy")#)</p>
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
	<div style="clear:both;"></div>
	<cfif ArrayLen(REQUEST.pageData.product.getRelatedProducts()) GT 0>
		<div class="related-thumbnails">
			<div class="cat-thumbnail-title"><a href="">Related Products</a></div>
			<div class="clear"></div>
			<div class="cat-thumbnail-section">
				<ul class="rig columns-4">
					<cfloop array="#REQUEST.pageData.product.getRelatedProducts()#" index="product">
						<li class="single-products">
							<a href="#product.getDetailPageURL()#">
								<img class="thumbnail-img" src="#product.getDefaultImageLink(type='small')#" />
							</a>
							<div class="thumbnail-name"><a href="#product.getDetailPageURL()#">#product.getDisplayName()#</a></div>
							<div class="thumbnail-price">#LSCurrencyFormat(product.getPrice(customerGroupId = SESSION.user.customerGroupId, currencyId = SESSION.currency.id),"local",SESSION.currency.locale)#</div>
							<cfif product.isFreeShipping()>
							<img class="free-shipping-icon" src="#APPLICATION.absoluteUrlWeb#images/freeshipping.jpg" style="width:120px;margin-top:7px;" />
							</cfif>
							<div class="product-overlay">
								<div class="overlay-content">
									<div class="thumbnail-rating" style="background-position: 30px -1512px;"></div>
									<div class="thumbnail-review"><a href="#product.getDetailPageURL()#">(#ArrayLen(product.getReviews())# Reviews)</a></div>
									<div class="thumbnail-cart"><a class="btn add-to-cart" style="padding-right:13px;">Add to cart</a></div>
								</div>
							</div>
						</li>
					</cfloop>
				</ul>
			</div>
		</div>
	</cfif>
</div>
<div id="dialog-form" title="Product has been added to the cart">
	<div style="margin-top:10px;text-align:center;">
		<img class="thumbnail-img" src="#REQUEST.pageData.product.getDefaultImageLink(type='small')#" />
	
		<p>#REQUEST.pageData.product.getDisplayName()#</p>
	</div>
</div>
<div id="wishlist-form" title="Product has been added to your wishlist">
	<div style="margin-top:10px;text-align:center;">
		<img class="thumbnail-img" src="#REQUEST.pageData.product.getDefaultImageLink(type='small')#" />
	
		<p>#REQUEST.pageData.product.getDisplayName()#</p>
	</div>
</div>
</form>
</cfoutput>
	