<cfoutput>
<script>
	$(document).ready(function() {
		var order = new Object();
		var product = null;
		
		order.customer = new Object();
		<cfif IsNumeric(SESSION.user.customerId)>
			order.customer.id = '#SESSION.user.customerId#';
			order.customer.firstName = '#REQUEST.pageData.customer.getFirstName()#';
			order.customer.middleName = '#REQUEST.pageData.customer.getMiddleName()#';
			order.customer.lastName = '#REQUEST.pageData.customer.getLastName()#';
			order.customer.company = '#REQUEST.pageData.customer.getCompany()#';
			order.customer.email = '#REQUEST.pageData.customer.getEmail()#';
			order.customer.customerGroupId = '#REQUEST.pageData.customer.getCustomerGroup().getName()#';
		<cfelse>
			order.customer.id = '';
			order.customer.firstName = '';
			order.customer.middleName = '';
			order.customer.lastName = '';
			order.customer.company = '';
			order.customer.email = '';
			order.customer.customerGroupId = '';
		</cfif>
		
		order.shippingAddress = new Object();
		order.shippingAddress.firstName = '';
		order.shippingAddress.middleName = '';
		order.shippingAddress.lastName = '';
		order.shippingAddress.company = '';
		order.shippingAddress.phone = '';
		order.shippingAddress.unit = '';
		order.shippingAddress.street = '';
		order.shippingAddress.city = '';
		order.shippingAddress.postalCode = '';
		order.shippingAddress.provinceId = '';
		order.shippingAddress.countryId = '';
		
		order.billingAddress = new Object();
		order.billingAddress.firstName = '';
		order.billingAddress.middleName = '';
		order.billingAddress.lastName = '';
		order.billingAddress.company = '';
		order.billingAddress.phone = '';
		order.billingAddress.unit = '';
		order.billingAddress.street = '';
		order.billingAddress.city = '';
		order.billingAddress.postalCode = '';
		order.billingAddress.provinceId = '';
		order.billingAddress.countryId = '';
		
		order.products = new Array();
		
		<cfif REQUEST.pageData.cart.getQuantity() GT 0>
			<cfloop array="#REQUEST.pageData.cart.getCartItems()#" index="item">
				product = new Object();
				product.id = '#item.getProduct().getProductId()#';
				product.sku = '#item.getSku()#';
				product.price = '#item.getPrice()#';
				product.quantity = '#item.getQuantity()#';
				product.shippingMethodId = '';
				product.subtotal = '#item.getSubTotal()#';
				order.products.push(product);
			</cfloop>
			
			order.subtotal = '#REQUEST.pageData.cart.getSubTotal()#';
			order.tax = '#REQUEST.pageData.cart.getTax()#';
			order.shippingFee = '#REQUEST.pageData.cart.getShippingFee()#';
			order.discount = '#REQUEST.pageData.cart.getDiscount()#';
			order.coupon = '#REQUEST.pageData.cart.getCoupon()#';
			order.total = '#REQUEST.pageData.cart.getTotal()#';
		<cfelse>
			order.subtotal = '';
			order.tax = '';
			order.shippingFee = '';
			order.discount = '';
			order.coupon = '';
			order.total = '';
		</cfif>
		
		order.comments = '';
		order.paymentMethodId = '';
		order.currencyId = '#SESSION.currency.id#';
		
		order.coupon = '';
		order.subTotal = '';
		order.shippingFee = '';
		order.tax = '';
		order.discount = '';
		order.total = '';
		
		$(".use-this-address").click(function() {
			$.ajax({
						type: "get",
						url: "#APPLICATION.absoluteUrlSite#core/services/cartService.cfc",
						dataType: 'json',
						data: {
							method: 'cartLogin',
							username: $("##username").val(),
							password: $("##password").val()
						}
			})
			.done(function() {
				$("##login-section").slideUp();
			})
			.fail(function() {
				alert( "error" );
			})
			.always(function() {
				alert( "complete" );
			});
		});
		
		$("##add-new-address").click(function() {
			$.ajax({
						type: "get",
						url: "#APPLICATION.absoluteUrlSite#core/services/cartService.cfc",
						dataType: 'json',
						data: {
							method: 'cartLogin',
							username: $("##username").val(),
							password: $("##password").val()
						}
			})
			.done(function() {
				$("##login-section").slideUp();
			})
			.fail(function() {
				alert( "error" );
			})
			.always(function() {
				alert( "complete" );
			});
		});
		
		$(".shipping-method").click(function() {
			$.ajax({
						type: "get",
						url: "#APPLICATION.absoluteUrlSite#core/services/cartService.cfc",
						dataType: 'json',
						data: {
							method: 'cartLogin',
							username: $("##username").val(),
							password: $("##password").val()
						}
			})
			.done(function() {
				$("##login-section").slideUp();
			})
			.fail(function() {
				alert( "error" );
			})
			.always(function() {
				alert( "complete" );
			});
		});
		
	});
</script>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Checkout</a>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-9 information-entry">
			<div class="accordeon size-1">
				<div class="accordeon-title"><span class="number">1</span>Shipping Information</div>
				<div class="accordeon-entry">
					<cfif IsNumeric(SESSION.user.customerId)> AND ArrayLen(REQUEST.pageData.shippingAddresses) GT 0>
						<div class="row article-container">
							<cfloop array="#REQUEST.pageData.shippingAddresses#" index="address">
								<div class="col-md-4 information-entry">
									<div class="article-container style-1">
										#address.getFirstName()# #address.getMiddleName()# #address.getLastName()#<br/>
										#address.getUnit()# #address.getStreet()#<br/>
										#address.getCity()#, #address.getProvince().getDisplayName()#, #address.getPostalCode()#<br/>
										#address.getCountry().getDisplayName()#<br/><br/>
										<a class="button style-18 use-this-address" addressid="#address.getAddressId()#">use this address</a>
									</div>
								</div>
							</cfloop>
						</div>
					</cfif>
					<div class="row">
						<div class="col-md-12 information-entry">
							<div class="article-container style-1">
								<h3>New Shipping Address</h3>
								<form name="new_address_form">
									<input type="text" name="company" id="company" value="" placeholder="Company" class="simple-field">
									<input type="text" name="phone" id="phone" value="" placeholder="Phone" class="simple-field">
									<input type="text" name="first_name" id="first-name" value="" placeholder="First Name" class="simple-field">
									<input type="text" name="middle_name" id="middle-name" value="" placeholder="Middle Name" class="simple-field">
									<input type="text" name="last_name" id="last-name" value="" placeholder="Last Name" class="simple-field">
									<input type="text" name="unit" id="unit" value="" placeholder="Unit" class="simple-field">
									<input type="text" name="street" id="street" value="" placeholder="Street" class="simple-field">
									<input type="text" name="city" id="city" value="" placeholder="City" class="simple-field">
									<div class="simple-drop-down simple-field">
										<select name="province_id" id="province-id">
											<option value="">Province</option>
											<cfloop array="#REQUEST.pageData.provinces#" index="province">
												<option value="#province.getProvinceId()#">#province.getDisplayName()#</option>
											</cfloop>
										</select>
									</div>
									<input type="text" name="postal_code" id="postal-code" value="" placeholder="Postal Code" class="simple-field">
									<div class="simple-drop-down simple-field">
										<select name="country_id" id="country-id">
											<option value="">Country</option>
											<cfloop array="#REQUEST.pageData.countries#" index="country">
												<option value="#country.getCountryId()#">#country.getDisplayName()#</option>
											</cfloop>
										</select>
									</div>
									<a class="button style-18 add-new-address">Add New Address</a>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="accordeon-title"><span class="number">2</span>Shipping Method</div>
				<div class="accordeon-entry">
					<div class="tabs-container">
						<div class="swiper-tabs tabs-switch">
							<div class="title">Products</div>
							<div class="list">
								<cfloop from="1" to="#ArrayLen(REQUEST.pageData.cart.getCartItems())#" index="i">
									<a class="block-title tab-switcher <cfif i EQ 1>active</cfif>">#REQUEST.pageData.cart.getCartItems()[i].getProduct().getDisplayName()#</a>
								</cfloop>
								<div class="clear"></div>
							</div>
						</div>
						<div>
							<cfloop array="#REQUEST.pageData.cart.getCartItems()#" index="item">
								<div class="tabs-entry">
									<div class="products-swiper">
										<div class="swiper-container" data-autoplay="0" data-loop="0" data-speed="500" data-center="0" data-slides-per-view="responsive" data-xs-slides="2" data-int-slides="2" data-sm-slides="3" data-md-slides="4" data-lg-slides="5" data-add-slides="5">
											<div class="swiper-wrapper">
												<div class="article-container style-1">
													<cfloop array="#item.getShippingMethods()#" index="shippingMethod">
														<label class="checkbox-entry radio">
															<input type="radio" name="shipping_method_#shippingMethod.getShippingMethodId()#" productid="#item.getProduct().getProductId()#" shippingmethodid="#shippingMethod.getShippingMethodId()#"> <span class="check" style="margin-bottom: 5px;"></span> <span class="article-container style-1">#shippingMethod.getDisplayName()#</span>
														</label>
													</cfloop>
												</div>
											</div>
											<div class="pagination"></div>
										</div>
									</div>
								</div>
							</cfloop>
							<br/><br/>
							<a class="button style-18 shipping-info">Continute</a>
						</div>
					</div>
				</div>
				<div class="accordeon-title"><span class="number">3</span>Order Review</div>
				<div class="accordeon-entry">
					<div class="article-container style-1">
						<div class="table-responsive">
							<table class="cart-table">
								<tr>
									<th class="column-1">Product Name</th>
									<th class="column-2">Unit Price</th>
									<th class="column-3">Qty</th>
									<th class="column-3">Shipping Method</th>
								</tr>
								<cfloop array="#REQUEST.pageData.cart.getCartItems()#" index="item">
									<cfset product = item.getProduct() />
									<tr>
										<td>
											<div class="traditional-cart-entry">
												<a href="#product.getDetailPageURL()#" class="image"><img src="#product.getDefaultImageLink(type="small")#" alt=""></a>
												<div class="content">
													<div class="cell-view">
														<a href="#product.getCategory().getDetailPageURL()#" class="tag">#product.getCategory().getDisplayName()#</a>
														<a href="#product.getDetailPageURL()#" class="title">#product.getDisplayName()#</a>
														<div class="inline-description"><cfloop from="1" to="#ArrayLen(product.getAttributes())#" index="i">#product.getAttributes()[i].getDisplayName()# <cfif i NEQ ArrayLen(product.getAttributes())>/</cfif></cfloop></div>
														<div class="inline-description">#product.getDisplayName()#</div>
													</div>
												</div>
											</div>
										</td>
										<td>#product.getPrice()#</td>
										<td>#item.getQuantity()#</td>
										<td>$<span id="subtotal-#product.getProductId()#"></span></td>
									</tr>
								</cfloop>
							</table>
						</div><br/>
						<div class="row">
							<div class="col-md-6 information-entry">
								<div class="cart-summary-box" style="text-align:left;">
									<h4>Shipping Address</h4>
									Kevin Pan<br/>
									5940 Yonge St.<br/>
									North York, Ontario, M2M4M6<br/>
									Canada<br/><br/>
									<a class="button style-18" addressid="1">edit</a>
								</div>
							</div>
							<div class="col-md-6 information-entry">
								<div class="cart-summary-box" style="text-align:left;">
									<h4>Payment Information</h4>
									Card Number: xxxx xxxx xxxx 1980<br/>
									Expiry Date: 18/19<br/>
									<br/><br/><br/>
									<a class="button style-18" addressid="3">edit</a>
								</div>
							</div>
						</div><br/>
						<div class="row">
							<div class="col-md-12 information-entry">
								<div class="cart-summary-box">
									<div class="sub-total">Subtotal: $990,00</div>
									<div class="sub-total">Shipping & Handling: $990,00</div>
									<div class="sub-total">Tax: $990,00</div>
									<div class="grand-total">Grand Total $1029,79</div>
									<a class="button style-10" href="#APPLICATION.absoluteUrlSite#checkout/checkout_thankyou.cfm">Pay with PayPal</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-3 information-entry">
			<h3 class="cart-column-title size-2">Your Checkout Progress</h3>
			<div class="checkout-progress-widget">
				<div class="step-entry">1. Shipping Information</div>
				<div class="step-entry">2. Shipping Method</div>
				<div class="step-entry">3. Payment Method</div>
				<div class="step-entry">4. Order Review</div>
			</div>
			<div class="article-container style-1">
				<p>Custom CMS block displayed below the one page checkout progress block. Put your own content here.</p>
			</div>
			<div class="information-blocks">
				<a class="sale-entry vertical" href="##">
					<span class="hot-mark yellow">hot</span>
					<span class="sale-price"><span>-40%</span> Valentine <br/> Underwear Sale</span>
					<span class="sale-description">Lorem ipsum dolor sitamet, conse adipisc sed do eiusmod tempor.</span>
					<img style="" class="sale-image" src="#SESSION.absoluteUrlTheme#images/text-widget-image-3.jpg" alt="" />
				</a>
			</div>
		</div>
	</div>    
</div>
</cfoutput>
