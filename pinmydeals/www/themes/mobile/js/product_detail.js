$(function() {

	"use strict";
	
	(function main(){
		$(function() {
			$(".overlay-popup .detail-info-entry .entry").hide();
			$(".overlay-popup .detail-info-entry .entry").removeClass('active');
			
			$(".overlay-popup .detail-info-entry").each(function( index ) {
				$( this ).children(".entry").first().show();
			});
			
			$("#add-to-cart").click(function() {
				$.ajax({
						type: "get",
						url: cartRequestUrl,
						dataType: 'json',
						data: {
							method: 'addProductToCart',
							productid: selectedProductId,
							quantity: $("#quantity").html()
						}
				})
				.done(function(data) {		
					var str = '';
					for(var i=0;i<data.PRODUCTS.length;i++) {
						str += '<div class="cart-entry"><a class="image"><img src="'+data.PRODUCTS[i].IMAGE+'" alt="'+data.PRODUCTS[i].NAME+'"></a><div class="content"><a class="title" href="'+data.PRODUCTS[i].HREF+'">'+data.PRODUCTS[i].NAME+'</a><div class="quantity">Quantity: '+data.PRODUCTS[i].QUANTITY+'</div><div class="price">'+data.PRODUCTS[i].PRICE+'</div></div></div>';
					}
					
					str += '<div class="summary"><div class="subtotal">Subtotal: '+data.SUBTOTAL+'</div><div class="grandtotal">Grand Total <span>'+data.TOTAL+'</span></div></div><div class="cart-buttons"><div class="column"><a class="button style-3" href="'+absoluteUrlWeb+'cart.cfm">view cart</a><div class="clear"></div></div><div class="column"><a class="button style-4" href="'+absoluteUrlWeb+'checkout/checout_paypal_express.cfm">checkout</a><div class="clear"></div></div><div class="clear"></div></div>';
					
					$(".cart-box .popup-container").html(str);   
				})
				.fail(function(data) {
					alert( "error" );
				})
				.always(function(data) {
				});
			});
			
			$(".entry").click(function() {
				var aid = $(this).attr('aid');
				var avid = $(this).attr('avid');
				
				$(".overlay-popup .attr-" + aid).hide();
				$(".overlay-popup #attr-val-" + avid).show();
								
				var insert = true;
				
				for (var i = 0; i < optionArray.length; i++) {
					if(optionArray[i].attributeid == aid)
					{
						optionArray[i].attributevalueid = avid;
						insert = false;
						break;
					}
				}
				
				if(insert == true)
				{
					var option = new Object();
					option.attributeid = aid;
					option.attributevalueid = avid;
					optionArray.push(option);
				}
				
				if(optionArray.length == optionArrayLength)
				{
					var optionList = '';
					for (var i = 0; i < optionArray.length; i++) {
						optionList = optionList + optionArray[i].attributevalueid + ',';
					}
					
					$.ajax({
						type: "get",
						url: requestUrl,
						dataType: 'json',
						data: {
							method: 'getProduct',
							parentProductId: parentProductId,
							attributeValueIdList: optionList,
							customerGroupId: customerGroupId
						},		
						success: function(result) {
							var oriPrice = result.ORIGINALPRICE.toFixed(2);
							var curPrice = result.CURRENTPRICE.toFixed(2);
							var stock = result.STOCK;
							var productid = result.PRODUCTID;
							
							selectedProductId = productid;
							
							if(curPrice > 0) {
								$(".detail-info-entry .current").html(currencySymbol + ' ' + curPrice);
								$(".detail-info-entry .current").show();
								
								if(oriPrice > curPrice) {
									$(".detail-info-entry .prev").html(currencySymbol + ' ' + oriPrice);
									$(".detail-info-entry .prev").show();
								} else {
									$(".detail-info-entry .prev").hide();
								}
								
								if(stock > 0) {
									$("#stock-detail").html(stock + ' in stock');
									$("#add-to-cart").show();
									$("#add-to-cart-disabled").hide();
								} else {
									$("#stock-detail").html('Stock is not available');
									$("#add-current-to-cart").hide();
									$("#add-current-to-cart-disabled").show();
								}
								
								$("#stock-detail").show();
							} else {
								$("#add-current-to-cart").hide();
								$("#add-current-to-cart-disabled").show();
							}
						}
					});
				}
			});
			/*
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
			*/
		});
	})();
});