<cfoutput>
<script>
	$(document).ready(function() {
		
		$(".use-this-address").click(function() {
			$("##existing-address-id").val($(this).attr("addressid"));
		});
		
		$("##register-user").click(function() {
			$("##new-passwords").toggle();
		});
	});
</script>

<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Checkout</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Customer Information</span> 
</div>
	<form method="post">
	<input type="hidden" name="existing_address_id" id="existing-address-id" value="" />
	<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
		<div style="font-size:12px;color:red;margin:20px 0 0 20px;line-height:20px;">
			<ul>
				<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
					<li>#msg#</li>
				</cfloop>
			</ul>
		</div>
	</cfif>
	<style>
		.current-addresses {
			list-style-type:none;
			margin-left:-20px;
			margin-bottom:20px;
		}
		
		.current-addresses li {
			border:1px solid ##ccc;
			float:left;
			padding:20px;
			line-height:20px;
			margin-left:20px;
		}
	</style>	
	
	<div style="font-size:12px;margin:30px 0 10px 0;font-weight:bold;">* is required field</div>
	<div id="checkout-info" class="single_field">
		<div id="checkout-addresses" style="float:left;">
			<table>	
				<tr>
					<td style="font-weight:bold;width:103px;">Email:</td>
					<td style="width:10px;">*</td>
					<td>
						<input name="new_email" id="new_email" type="text" style="width:180px;"> 
					</td>
					<td style="width:10px;"></td>
					<td style="font-weight:bold;width:103px;">Unit: </td>
					<td style="width:10px;"></td>
					<td>
						<input name="shipto_unit" id="shipto_unit" type="text"style="width:180px;">
					</td>
				</tr>
				<tr>
					<td style="font-weight:bold;width:103px;">First Name:</td>
					<td style="width:10px;">*</td>
					<td>
						<input name="shipto_first_name" id="shipto_first_name" type="text" style="width:180px;">
					</td>
					<td style="width:10px;"></td>
					<td style="font-weight:bold;width:103px;">Street: </td>
					<td style="width:10px;">*</td>
					<td>
						<input name="shipto_street" id="shipto_street" type="text" style="width:180px;">
					</td>
				</tr>
				<tr>
					<td style="font-weight:bold;width:103px;">Middle Name:</td>
					<td style="width:10px;"></td>
					<td>
						<input name="shipto_middle_name" id="shipto_middle_name" type="text" style="width:180px;">
					</td>
					<td style="width:10px;"></td>
					<td style="font-weight:bold;width:103px;">City: </td>
					<td style="width:10px;">*</td>
					<td>
						<input name="shipto_city" id="shipto_city" type="text" style="width:180px;">
					</td>
				</tr>
				<tr>
					<td style="font-weight:bold;">Last Name:</td>
					<td style="width:10px;">*</td>
					<td>
						<input name="shipto_last_name" id="shipto_last_name" type="text" style="width:180px;">
					</td>
					<td style="width:10px;"></td>
					<td style="font-weight:bold;width:103px;">Province: </td>
					<td style="width:10px;">*</td>
					<td>
						<select name="shipto_province_id" id="shipto_province_id" style="width:190px;">
							<option value="">Please select...</option>
							<cfloop array="#REQUEST.pageData.provinces#" index="province">
								<option value="#province.getProvinceId()#">#province.getDisplayName()#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr>
					<td style="font-weight:bold;width:103px;">Company:</td>
					<td style="width:10px;"></td>
					<td>
						<input name="shipto_company" id="shipto_company" type="text" style="width:180px;">
					</td>
					<td style="width:10px;"></td>
					<td style="font-weight:bold;width:103px;">Postal Code/ZIP: </td>
					<td style="width:10px;">*</td>
					<td>
						<input name="shipto_postal_code" id="shipto_postal_code" type="text"style="width:180px;">
					</td>
				</tr>
				<tr>
					<td style="font-weight:bold;">Phone:</td>
					<td style="width:10px;"></td>
					<td>
						<input name="shipto_phone" id="shipto_phone" type="text" style="width:180px;">
					</td>
					<td style="width:10px;"></td>
					<td style="font-weight:bold;width:103px;">Country: </td>
					<td style="width:10px;">*</td>
					<td>
						<select name="shipto_country_id" id="shipto_country_id" style="width:190px;">
							<option value="">Please select...</option>
							<cfloop array="#REQUEST.pageData.countries#" index="country">
								<option value="#country.getCountryId()#">#country.getDisplayName()#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr>
					<td style="font-weight:bold;padding-top:15px;" colspan="5">
						<table>
							<tr>
								<td style="width:20px;">
									<input type="checkbox" name="register_user" id="register-user" />
								</td>
								<td>
									Register for member
								</td>
							</tr>
							<tr>
								<td colspan="2" style="display:none;" id="new-passwords">
									<table>
										<tr>
											<td style="font-weight:bold;width:120px;">Password:</td>
											<td>
												<input name="new_password" id="new-password" type="password" style="width:180px;">
											</td>
										</tr>
										<tr>
											<td style="font-weight:bold;">Confirm Password:</td>
											<td>
												<input name="confirm_new_password" id="confirm-new-password" type="password" style="width:180px;">
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr>
					<td colspan="7">
						<div style="padding-top:12px;border-top:1px solid ##ccc;margin-top:10px;">
						<button class="btn-signup" type="submit" name="shipping_to_new_address" id="shipping_to_new_address" value="Ship to this address" style="font-size:12px;"><span>Ship to this address</span></button>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<cfinclude template = "checkout_order_summary.cfm" />
	<div style="clear:both;"></div>
	</form>
</cfoutput>