<cfoutput>
<script>
	$(document).ready(function() {
		
		$(".use-this-address").click(function() {
			$("##existing-address-id").val($(this).attr("addressid"));
		});
		
	});
</script>

<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Checkout</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Change Address</span> 
</div>
	<form method="post">
	<input type="hidden" name="existing_address_id" id="existing-address-id" value="" />
	<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
		<div style="font-size:12px;color:red;margin:20px 0 20px 20px;">
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
			margin-left:-50px;
			margin-bottom:20px;
		}
		
		.current-addresses li {
			float:left;
			line-height:20px;
			margin-left:50px;
			margin-bottom:20px;
		}
	</style>	
	<div id="checkout-info">
		<div style="float:left;width:607px;">
			<div id="checkout-addresses">
				<cfif NOT IsNull(REQUEST.pageData.customer) AND ArrayLen(REQUEST.pageData.customer.getAddresses()) GT 0>
					<ul class="current-addresses">
						<cfloop array="#REQUEST.pageData.customer.getAddresses()#" index="address">
							<li>
								<span style="font-weight:bold;line-height:32px;font-size:14px;">#address.getFullName()#</span><br/>
								#address.getPhone()#<br/>
								#address.getCompany()#<br/>
								#address.getUnit()# #address.getStreet()#<br/>
								#address.getCity()#, #address.getProvince().getDisplayName()# #address.getPostalCode()#<br/>
								#address.getCountry().getDisplayName()#<br/><br/>
								<button class="btn-signup use-this-address" addressid="#address.getAddressId()#" type="submit" name="shipto_this_address" id="shipto_this_address" value="Use this address" style="font-size:12px;"><span>Use this address</span></button>
							</li>
						</cfloop>
					</ul>
					<div style="clear:both;"></div>
				</cfif>
			</div>
			<div style="padding-top:20px;border-top:1px solid ##ccc;" class="single_field">
				<table>	
					<tr>
						<td style="font-weight:bold;width:93px;">Company:</td>
						<td>
							<input name="shipto_company" id="shipto_company" type="text" maxlength="32" size="30" style="width:180px;">
						</td>
						<td style="width:10px;"></td>
						<td style="font-weight:bold;width:93px;">Unit: </td>
						<td>
							<input name="shipto_unit" id="shipto_unit" type="text" maxlength="100" size="25" style="width:180px;">
						</td>
					</tr>
					<tr>
						<td style="font-weight:bold;">Phone:</td>
						<td>
							<input name="shipto_phone" id="shipto_phone" type="text" maxlength="32" size="30" style="width:180px;">
						</td>
						<td style="width:10px;"></td>
						<td style="font-weight:bold;width:93px;">Street: </td>
						<td>
							<input name="shipto_street" id="shipto_street" type="text" maxlength="100" size="25" style="width:180px;">
						</td>
					</tr>
					<tr>
						<td style="font-weight:bold;width:93px;">First Name:</td>
						<td>
							<input name="shipto_first_name" id="shipto_first_name" type="text" maxlength="32" size="30" style="width:180px;">
						</td>
						<td style="width:10px;"></td>
						<td style="font-weight:bold;width:93px;">City: </td>
						<td>
							<input name="shipto_city" id="shipto_city" type="text" maxlength="40" size="25" style="width:180px;">
						</td>
					</tr>
					<tr>
						<td style="font-weight:bold;width:93px;">Middle Name:</td>
						<td>
							<input name="shipto_middle_name" id="shipto_middle_name" type="text" maxlength="32" size="30" style="width:180px;">
						</td>
						<td style="width:10px;"></td>
						<td style="font-weight:bold;width:93px;">Province: </td>
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
						<td style="font-weight:bold;">Last Name:</td>
						<td>
							<input name="shipto_last_name" id="shipto_last_name" type="text" maxlength="32" size="30" style="width:180px;">
							
							&nbsp;&nbsp;<span style="color:red;display:none;" class="validation-falied" id="last-name-validation-shipping">Please enter your last name</span>
						</td>
						<td style="width:10px;"></td>
						<td style="font-weight:bold;width:93px;">Postal Code: </td>
						<td>
							<input name="shipto_postal_code" id="shipto_postal_code" type="text" maxlength="10" size="10" style="width:180px;">
						</td>
					</tr>
					<tr>
						<td style="font-weight:bold;"></td>
						<td></td>
						<td style="width:10px;"></td>
						<td style="font-weight:bold;width:93px;">Country: </td>
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
						<td colspan="5">
							<div style="padding-top:12px;border-top:1px solid ##ccc;margin-top:10px;">
							<button class="btn-signup" type="submit" name="shipping_to_new_address" id="shipping_to_new_address" value="Use this address" style="font-size:12px;"><span>Use this address</span></button>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>		
	<div style="clear:both;"></div>
	</form>
</cfoutput>