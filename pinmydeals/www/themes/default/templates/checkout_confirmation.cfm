<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Checkout</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Confirmation</span> 
</div>
<form method="post">
	<div id="order-confirmation" class="single_field" style="margin-top:20px;">
		<style>
			.myaccount-table td {
			text-align:center;
			}
		</style>
		<div class="myaccount-table" style="width:100%;float:margin-top:30px;">
			<table>
				<tr class="cart_menu">
					<td>Product</td>
					<td>SKU</td>
					<td>Quantity</td>
					<td>Price</td>
					<td>Subtotal</td>
					<td>Tax</td>
					<td>Shipping</td>
				</tr>
				
				<cfloop array="#SESSION.cart.getProductArray()#" index="item">
					<cfset product = EntityLoadByPK("product",item.productId) />
					<cfset shippingMethod = EntityLoadByPK("shipping_method",item.shippingMethodId) />
					<tr>
						<td>
							<h4>#product.getDisplayNameMV()#</h4>
						</td>
						<td>
							<p>SKU: #product.getSku()#</p>
						</td>
						<td>
							<p>#item.count#</p>
						</td>
						<td>
							<p>#item.singlePriceWCLocal#</p>
						</td>
						<td>
							<p>#item.totalPriceWCLocal#</p>
						</td>
						<td>
							<p>#item.totalTaxWCLocal#</p>
						</td>
						<td>
							<p>#shippingMethod.getDisplayName()#: #item.totalShippingFeeWCLocal#</p>
						</td>
					</tr>
				</cfloop>
			</table>
		</div>
		<p style="margin-top:20px;font-weight:bold;">Email:#SESSION.cart.getCustomerStruct().email#</p>
		<div id="shipping-addresses" style="width:27%;float:left;margin-top:17px;line-height:18px;">
			<table>
				<tr>
					<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Shipping Address</th>
				</tr>
				<tbody>
					<tr>
						<td class="first-col">Company:</td>
						<td>#SESSION.cart.getShippingAddressStruct().company#</td>
					</tr>
					<tr>
						<td class="first-col">First Name:</td>
						<td>#SESSION.cart.getShippingAddressStruct().firstName#</td>
					</tr>
					<tr>
						<td class="first-col">Middle Name:</td>
						<td>#SESSION.cart.getShippingAddressStruct().middleName#</td>
					</tr>
					
					<tr>
						<td class="first-col">Last Name:</td>
						<td>#SESSION.cart.getShippingAddressStruct().lastName#</td>
					</tr>
					
					<tr>
						<td class="first-col">Phone:</td>
						<td>#SESSION.cart.getShippingAddressStruct().phone#</td>
					</tr>
					
					<tr>
						<td style="padding-top:3px;padding-bottom:3px;" class="first-col">Street:</td>
						<td style="padding-top:3px;padding-bottom:3px;">#SESSION.cart.getShippingAddressStruct().street#</td>
					</tr>

					<tr>
						<td class="first-col">City:</td>
						<td>#SESSION.cart.getShippingAddressStruct().city#</td>
					</tr>

					<tr>
						<td class="first-col">Province:</td>
						<td>#EntityLoadByPK("province",SESSION.cart.getShippingAddressStruct().provinceId).getDisplayName()#</td>
					</tr>
					<tr>
						<td class="first-col">Postal Code:</td>
						<td>#SESSION.cart.getShippingAddressStruct().postalCode#</td>
					</tr>
					<tr>
						<td class="first-col">Country:</td>
						<td>#EntityLoadByPK("country",SESSION.cart.getShippingAddressStruct().countryId).getDisplayName()#</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="billing-addresses" style="width:27%;float:left;margin-top:17px;line-height:18px;">
			<table>
				<tr>
					<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Billing Address</th>
				</tr>
				<tbody>
					<cfif SESSION.cart.getSameAddress() EQ true>
					<tr>
						<td>Billing address is same as shipping address. If you would like to change it, please click <a href="#APPLICATION.absoluteUrlSite#checkout/checkout_change_address.cfm">here</a>.</td>
					</tr>
					<cfelse>
					<tr>
						<td class="first-col">Company:</td>
						<td>#SESSION.cart.getBillingAddressStruct().company#</td>
					</tr>
					<tr>
						<td class="first-col">First Name:</td>
						<td>#SESSION.cart.getBillingAddressStruct().firstName#</td>
					</tr>
					<tr>
						<td class="first-col">Middle Name:</td>
						<td>#SESSION.cart.getBillingAddressStruct().middleName#</td>
					</tr>
					
					<tr>
						<td class="first-col">Last Name:</td>
						<td>#SESSION.cart.getBillingAddressStruct().lastName#</td>
					</tr>
					
					<tr>
						<td class="first-col">Phone:</td>
						<td>#SESSION.cart.getBillingAddressStruct().phone#</td>
					</tr>
					
					<tr>
						<td style="padding-top:3px;padding-bottom:3px;" class="first-col">Street:</td>
						<td style="padding-top:3px;padding-bottom:3px;">#SESSION.cart.getBillingAddressStruct().street#</td>
					</tr>

					<tr>
						<td class="first-col">City:</td>
						<td>#SESSION.cart.getBillingAddressStruct().city#</td>
					</tr>

					<tr>
						<td class="first-col">Province:</td>
						<td>#EntityLoadByPK("province",SESSION.cart.getBillingAddressStruct().provinceId).getDisplayName()#</td>
					</tr>
					<tr>
						<td class="first-col">Postal Code:</td>
						<td>#SESSION.cart.getBillingAddressStruct().postalCode#</td>
					</tr>
					<tr>
						<td class="first-col">Country:</td>
						<td>#EntityLoadByPK("country",SESSION.cart.getBillingAddressStruct().countryId).getDisplayName()#</td>
					</tr>
					</cfif>
				</tbody>
			</table>
		</div>
		<div id="checkout" style="height:auto;margin-top:20px;">
			<ul>
				<li>Sub Total <span>#SESSION.cart.getSubTotalPriceWCLocal()#</span></li>
				<li>Tax <span>#SESSION.cart.getTotalTaxWCLocal()#</span></li>
				<li>Shipping Cost <span>#SESSION.cart.getTotalShippingFeeWCLocal()#</span></li>
				<cfif SESSION.cart.getDiscount() GT 0>
				<li>Discount <span>- #SESSION.cart.getDiscountWCLocal()#</span></li>
				</cfif>
				<li>Total <span>#SESSION.cart.getTotalPriceWCLocal()#</span></li>
			</ul>
		</div>
	</div>
	<div style="clear:both;"></div>
	
	<div  style="border-top:1px solid ##CCC;margin-top:20px;">
		<input type="submit" name="place_order" value="Place Order" class="btn-signup" style="margin-top:10px;font-size:12px;">
	</div>
</form>
</cfoutput>