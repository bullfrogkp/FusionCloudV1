<cfoutput>
<script>
	$(document).ready(function() {
		<cfloop array="#SESSION.cart.getProductArray()#" index="item">
			<cfset product = EntityLoadByPK("product",item.productId) />
			$('##shipping-methods-#product.getProductId()#').ddslick({
				onSelected: function (data) {
					console.log(data);
				}
			});
		</cfloop>
	});
</script>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Checkout</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Shipping</span> 
</div>
<style>
##products {

list-style-type:none;
font-size:12px;
width:100%;
}
##products > li {
float:left;
width: 400px;
text-align:center;
margin-bottom:10px;
}

.dd-select {
  font-size:12px;
}

.dd-option-text, .dd-selected-text {
	font-size:12px;
	float:right;
	margin-right:20px;
}

.dd-option-image, .dd-selected-image {
	height:33px;
}

.dd-option-description, .dd-selected-description {
	float:right;
	text-align:right;
	margin-top:3px;
	margin-right:20px;
	width:160px;
	font-size:12px;
}
</style>
<form method="post">
	<div style="margin-top:20px;">
		<div style="width:607px;float:left;">
			<ul id="products">
				<cfloop array="#SESSION.cart.getProductArray()#" index="item">
					<cfset product = EntityLoadByPK("product",item.productId) />
					<cfset imageLink = product.getDefaultImageLinkMV(type='small') />
					<li>
						<img src="#imageLink#" style="width:53px;float:left;border:1px solid ##ccc;margin-right:5px;">
						<div id="shipping_methods_div" style="text-align:center;float:left;">
							<select id="shipping-methods-#product.getProductId()#" name="shipping_methods_#product.getProductId()#">
								<cfloop array="#item.shippingMethodArray#" index="s">
									<option value="#item.productId#_#s.shippingMethodId#" data-imagesrc="#APPLICATION.absoluteUrlSite#images/uploads/shipping/#s.logo#"
										data-description="
										<cfif s.price EQ 0>
											Free Shipping
										<cfelse>
											#LSCurrencyFormat(s.price,"local",SESSION.currency.locale)#
										</cfif>
										">#s.label#</option>
								</cfloop>
							</select>
						</div>
					</li>
				</cfloop>
			</ul>
			<div style="clear:both;"></div>
			<div style="border-top:1px solid ##CCC;margin-top:1px;">
				<input type="submit" value="Next Step" class="btn-signup" style="margin-top:10px;font-size:12px;">
			</div>
		</div>
		<cfinclude template = "checkout_order_summary.cfm" />
	</div>
</form>
</cfoutput>