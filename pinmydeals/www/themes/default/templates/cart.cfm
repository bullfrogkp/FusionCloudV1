<cfoutput>
<cfif ArrayLen(REQUEST.pageData.trackingRecords) GT 0>
<script>
	$(document).ready(function() {
		
		$(".plus").click(function() {
			var e = $("##product_count_" + $(this).attr("trid"));
			e.val(Math.max(parseInt(e.val()) + 1, 1));
		});
		
		$(".minus").click(function() {
			var e = $("##product_count_" + $(this).attr("trid"));
			e.val(Math.max(parseInt(e.val()) - 1, 1));
		});
		
		$(".update-count").click(function() {
			$("##tracking_record_id").val($(this).attr("trid"));
		});
		
		$("##apply_coupon").click(function() {
			var couponCode = $("##coupon_code").val();
			$.ajax({
						type: "get",
						url: "#APPLICATION.absoluteUrlWeb#core/services/cartService.cfc",
						dataType: 'json',
						data: {
							method: 'applyCouponCode',
							couponCode: couponCode,
							customerId: '#SESSION.user.customerId#',
							total: '#REQUEST.pageData.subTotal#'
						},		
						success: function(result) {
							if(result.SUCCESS == true)
							{
								$("##coupon").html("Coupon has been applied successfully.");
								$("##coupon_code_applied").val(couponCode);
								$("##subtotal-price-amount").html("$" + result.NEWTOTAL.toFixed(2));
								$( "<li style='color:white;background-color:red;'>Discount <span>- $"+result.DISCOUNT.toFixed(2)+"</span></li>" ).insertBefore( "##subtotal-price" );
							}
							else
							{
								if(result.MESSAGETYPE == 1)
									$("##coupon-message").html("This coupon can only be applied to order more than " + result.THRESHOLDAMOUNT);
								else if (result.MESSAGETYPE == 2)
									$("##coupon-message").html("This coupon is expired.");
								else if (result.MESSAGETYPE == 3)
									$("##coupon-message").html("Coupon is not assigned to the current customer, please try login and apply the coupon again.");
								else if (result.MESSAGETYPE == 4)
									$("##coupon-message").html("Coupon is not valid.");
							}	
						}
			});
		});
	});
</script>
</cfif>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Shopping Cart</span> 
</div>
			<style>
			.myaccount-table td {
			text-align:center;
			}
			</style>
			
			<cfif ArrayLen(REQUEST.pageData.trackingRecords) GT 0>
			
			<form method="post">
			<input type="hidden" id="tracking_record_id" name="tracking_record_id" value="" />
			<input type="hidden" id="coupon_code_applied" name="coupon_code_applied" value="" />
			
			<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
				<div style="font-size:12px;color:red;margin:20px 0 20px 20px;">
					<ul>
						<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
							<li>#msg#</li>
						</cfloop>
					</ul>
				</div>
			</cfif>
			<div class="myaccount-table">
				<table>
					
					<tr class="cart_menu">
						<td class="image" style="width:75px;">Product</td>
						<td class="description">Name</td>
						<td class="description">SKU</td>
						<td class="price">Price</td>
						<td class="quantity">Quantity</td>
						<td class="total">Sub Total</td>
						<td></td>
					</tr>
				
					<cfloop array="#REQUEST.pageData.trackingRecords#" index="cartItem">
						<cfset product = cartItem.getProduct() />
						<cfset detailPageLink = product.getDetailPageURLMV() />
						<cfset imageLink = product.getDefaultImageLinkMV(type='small') />
						<cfset displayName = product.getDisplayNameMV() />
						<tr>
							<td class="cart_product" pid="#product.getProductId()#">
								<a href="#product.getDetailPageURL()#">
									<img style="width:70px" src="#imageLink#" alt="#displayName#">
								</a>
							</td>
							<td class="cart_description">
								<h4><a href="#detailPageLink#">#displayName#</a></h4>
							</td>
							<td class="cart_description">
								<p>SKU: #product.getSku()#</p>
							</td>
							<td class="cart_price">
								<p>#LSCurrencyFormat(product.getPrice(customerGroupId = SESSION.user.customerGroupId, currencyId = SESSION.currency.id),"local",SESSION.currency.locale)#</p>
							</td>
							<td class="cart_quantity">
								<div class="cart_quantity_button">
									<button type="button" class="minus" trid="#cartItem.getTrackingRecordId()#">-</button>
									<input id="product_count_#cartItem.getTrackingRecordId()#" name="product_count_#cartItem.getTrackingRecordId()#" type="text" value="#cartItem.getQuantity()#" style="width:30px;text-align:center;" size="2" />
									<button type="button" class="plus" trid="#cartItem.getTrackingRecordId()#">+</button>
									<input type="submit" class="update-count" trid="#cartItem.getTrackingRecordId()#" name="update_count" value="update" />
								</div>
							</td>
							<td class="cart_total">
								<p class="cart_total_price">#LSCurrencyFormat(cartItem.getQuantity() * product.getPrice(customerGroupId = SESSION.user.customerGroupId, currencyId = SESSION.currency.id),"local",SESSION.currency.locale)#</p>
							</td>
							<td class="cart_delete">
								<input type="image" name="remove_product" value="#cartItem.getTrackingRecordId()#" src="#SESSION.absoluteUrlTheme#images/delete2.png" style="width:20px;" />
							</td>
						</tr>
					</cfloop>
				</table>
			</div>
			<!---
			<div id="shipping-estimate">
				<div style="font-weight:bold;">Estimate Shipping and Tax</div>
				<p>Enter your destination to get a shipping estimate.</p>
				<ul class="user_info">
					<li class="single_field">
						<div class="label">Country:</div>
						<select>
							<option>United States</option>
							<option>Bangladesh</option>
							<option>UK</option>
							<option>India</option>
							<option>Pakistan</option>
							<option>Ucrane</option>
							<option>Canada</option>
							<option>Dubai</option>
						</select>
						
					</li>
					<li class="single_field">
						<div class="label">State / Province:</div>
						<select>
							<option>Select</option>
							<option>Dhaka</option>
							<option>London</option>
							<option>Dillih</option>
							<option>Lahore</option>
							<option>Alaska</option>
							<option>Canada</option>
							<option>Dubai</option>
						</select>
					
					</li>
					<li class="single_field">
						<div class="label">Zip/Postal Code:</div>
						<input type="text">
					</li>
					<li class="single_field">
						<input type="button" value="Get Estimate" class="btn-signup" style="margin-top:10px;font-size:12px;">
					</li>
				</ul>
			</div>
			--->
			<div id="coupon">
				<div style="font-weight:bold;">Discount Codes</div>
				<p id="coupon-message">Enter your coupon code if you have one.</p>
				<input type="text" id="coupon_code" name="coupon_code" value="" style="width:564px">
				<div style="margin-top:10px;">
					<button class="btn-signup" type="button" name="apply_coupon" id="apply_coupon" value="Apply Coupon" style="font-size:12px;"><span>Apply Coupon</span></button>
				</div>
			</div>
			<div id="checkout">
				<ul>
					<li id="subtotal-price">Sub Total <span id="subtotal-price-amount">#LSCurrencyFormat(REQUEST.pageData.subTotal,"local",SESSION.currency.locale)#</span></li>
				</ul>
				<p style="float:right;font-weight:bold;">PayPal securely processes payments for PinMyDeals</p>
				<input type="image" name="submit_cart" src="#SESSION.absoluteUrlTheme#images/checkout_paypal.gif" alt="Submit Form" style="float:right;" />
			</div>
			</form>
			<cfelse>
			<span style="font-size:12px;">Your cart is empty.</span>
			</cfif>
</cfoutput>