<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Shopping Cart</a>
</div>

<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
	<div class="information-blocks">
		<ul>
			<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
				<li>#msg#</li>
			</cfloop>
		</ul>
	</div>
</cfif>

<div class="information-blocks">
	<div class="table-responsive">
		<table class="cart-table">
			<tr>
				<th class="column-1">Product Name</th>
				<th class="column-2">Unit Price</th>
				<th class="column-3">Qty</th>
				<th class="column-4">Subtotal</th>
				<th class="column-5"></th>
			</tr>
			
			<cfloop array="#REQUEST.pageData.cart.getCartItems()#" index="item">
				<tr>
					<td>
						<div class="traditional-cart-entry">
							<a href="#item.getDetailPageURL()#" class="image"><img src="#item.getDefaultImageLink()#" alt=""></a>
							<div class="content">
								<div class="cell-view">
									<a href="#item.getDetailPageURL()#" class="title">#item.getDisplayName()#</a>
									<cfloop array="#item.getAttributes()#" index="attr">
										<div class="inline-description">#attr.getDisplayName()#</div>
									</cfloop>
								</div>
							</div>
						</div>
					</td>
					<td>#item.getPrice()#</td>
					<td>
						<div class="quantity-selector detail-info-entry">
							<div class="entry number-minus">&nbsp;</div>
							<div class="entry number">#item.getQuantity()#</div>
							<div class="entry number-plus">&nbsp;</div>
						</div>
					</td>
					<td><div class="subtotal">#item.getDisplaySubTotal()#</div></td>
					<td><a class="remove-button"><i class="fa fa-times"></i></a></td>
				</tr>
			</cfloop>
		</table>
	</div>
	<div class="cart-submit-buttons-box">
		<a class="button style-15">Continue Shopping</a>
		<a class="button style-15">Update Bag</a>
	</div>
	<div class="row">
		<div class="col-md-4 information-entry">
			<h3 class="cart-column-title">Get shipping Estimates</h3>
			<form>
				<label>Country</label>
				<div class="simple-drop-down simple-field size-1">
					<select name="country_id" id="country-id">
						<option value="">Please select...</option>
						<cfloop array="#REQUEST.pageData.countries#" index="country">
							<option value="#country.getCountryId()#">#country.getDisplayName()#</option>
						</cfloop>
					</select>
				</div>
				<label>State</label>
				<div class="simple-drop-down simple-field size-1">
					<select name="province_id" id="province-id">
						<option value="">Please select...</option>
						<cfloop array="#REQUEST.pageData.provinces#" index="province">
							<option value="#province.getProvinceId()#">#province.getDisplayName()#</option>
						</cfloop>
					</select>
				</div>
				<label>Zip Code</label>
				<input type="text" value="" placeholder="Zip/Postal Code" class="simple-field size-1">
				<div class="button style-16" style="margin-top: 10px;">calculate shipping<input type="submit"/></div>
			</form>
		</div>
		<div class="col-md-4 information-entry">
			<h3 class="cart-column-title">Discount Codes <span class="inline-label red">Promotion</span></h3>
			<form>
				<label>Enter your coupon code if you have one.</label>
				<input type="text" value="" id="coupon_code" name="coupon_code" placeholder="" class="simple-field size-1">
				<div class="button style-16" style="margin-top: 10px;">Apply Coupon<input type="submit"/></div>
			</form>
		</div>
		<div class="col-md-4 information-entry">
			<div class="cart-summary-box">
				<div class="grand-total">Subtotal: #REQUEST.pageData.cart.getDisplaySubTotal()#</div>
				<a class="button style-10" href="#APPLICATION.urlAdmin#checkout/checkout_paypal_express.cfm">Proceed To Checkout</a>
			</div>
		</div>
	</div>
</div>
</cfoutput>
