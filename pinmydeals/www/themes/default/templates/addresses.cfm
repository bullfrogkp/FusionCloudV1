<cfoutput>
<script>
	$(document).ready(function() {
		$(".update-address").click(function() {
			$("##submitted-address-id").val($(this).attr("addressid"));
		});
	});
</script>

<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">My Account</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Addresses</span> 
</div>	
			
<cfinclude template="myaccount_sidenav.cfm" />
<div id="myaccount-content">
	<h1>My Addresses</h1>
	<div style="margin-top:25px;" class="single_field">
		<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
			<div style="font-size:12px;color:red;margin:20px 0 20px 20px;">
				<ul>
					<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
						<li>#msg#</li>
					</cfloop>
				</ul>
			</div>
		</cfif>
		<cfif ArrayLen(REQUEST.pageData.customer.getAddresses()) GT 0>
			<form method="post">
			<input type="hidden" name="submitted_address_id" id="submitted-address-id" value="" />
			<cfloop array="#REQUEST.pageData.customer.getActiveAddresses()#" index="address">
				<div style="width:49%;float:left;">
					<table id="current-address-table" class="shipping-address-selected" style="width:100%;">	
						<tr>
							<td style="font-weight:bold;">First Name: </td>
							<td>
								<input name="first_name_#address.getAddressId()#" id="first-name-#address.getAddressId()#" type="text" maxlength="100" size="25" style="width:180px;" value="#address.getFirstName()#">
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Middle Name: </td>
							<td>
								<input name="middle_name_#address.getAddressId()#" id="middle-name-#address.getAddressId()#" type="text" maxlength="100" size="25" style="width:180px;" value="#address.getMiddleName()#">
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Last Name: </td>
							<td>
								<input name="last_name_#address.getAddressId()#" id="last-name-#address.getAddressId()#" type="text" maxlength="100" size="25" style="width:180px;" value="#address.getLastName()#">
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Phone: </td>
							<td>
								<input name="phone_#address.getAddressId()#" id="phone-#address.getAddressId()#" type="text" maxlength="100" size="25" style="width:180px;" value="#address.getPhone()#">
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Company: </td>
							<td>
								<input name="company_#address.getAddressId()#" id="company-#address.getAddressId()#" type="text" maxlength="100" size="25" style="width:180px;" value="#address.getCompany()#">
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Unit: </td>
							<td>
								<input name="unit_#address.getAddressId()#" id="unit-#address.getAddressId()#" type="text" maxlength="100" size="25" style="width:180px;" value="#address.getUnit()#">
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Street: </td>
							<td>
								<input name="street_#address.getAddressId()#" id="street-#address.getAddressId()#" type="text" maxlength="100" size="25" style="width:180px;" value="#address.getStreet()#">
							</td>
						</tr>
						  
						<tr>
							<td style="font-weight:bold;">City: </td>
							<td>
								<input name="city_#address.getAddressId()#" id="city-#address.getAddressId()#" type="text" maxlength="40" size="25" style="width:180px;" value="#address.getCity()#">
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Postal Code: </td>
							<td>
								<input name="postal_code_#address.getAddressId()#" id="postal-code-#address.getAddressId()#" type="text" maxlength="10" size="10" style="width:180px;" value="#address.getPostalCode()#">
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Province: </td>
							<td>
								<select name="province_id_#address.getAddressId()#" id="province-id-#address.getAddressId()#" style="width:186px;">
									<option value="">Please select...</option>
									<cfloop array="#REQUEST.pageData.provinces#" index="province">
										<option value="#province.getProvinceId()#"
										<cfif address.getProvince().getProvinceId() EQ province.getProvinceId()>
										selected
										</cfif>
										>#province.getDisplayName()#</option>
									</cfloop>
								</select>
							</td>
						</tr>
						<tr>
							<td style="font-weight:bold;">Country: </td>
							<td>
								<select name="country_id_#address.getAddressId()#" id="country-id-#address.getAddressId()#" style="width:186px;">
									<option value="">Please select...</option>
									<cfloop array="#REQUEST.pageData.countries#" index="country">
										<option value="#country.getCountryId()#"
										<cfif address.getCountry().getCountryId() EQ country.getCountryId()>
										selected
										</cfif>
										>#country.getDisplayName()#</option>
									</cfloop>
								</select>
							</td>
						</tr>
						<tr>
							<td></td>
							<td style="padding-top:10px;">
								<input type="submit" name="update_address" addressid="#address.getAddressId()#" class="update-address" value="Update">
							</td>
						</tr>
					</table>
				</div>
			</cfloop>
			</form>
		<cfelse>
			No address found.
		</cfif>
	</div>
	<div style="clear:both;"></div>
</div>
		
</cfoutput>