<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">My Account</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Profile</span> 
</div>
<cfinclude template="myaccount_sidenav.cfm" />
<form method="post">
<div id="myaccount-content">
	<h1>My Profile</h1>
	<div style="margin-top:30px;" class="single_field">
		<div>
			<table id="current-address-table" class="shipping-address-selected" style="width:100%;margin-top:20px;">	
				<tr>
					<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:10px;">Account Information
					</th>
				</tr>
				<tbody>
				<tr>
					<td style="font-weight:bold;line-height:30px;">Email: </td>
					<td style="line-height:30px;">#REQUEST.pageData.customer.getEmail()#</td>
				</tr>
				<tr>
					<td style="font-weight:bold;">First Name: </td>
					<td>
						<input name="first_name" id="first_name" type="text" maxlength="100" size="25" style="width:180px;" value="#REQUEST.pageData.formData.first_name#">
					</td>
				</tr>
				<tr>
					<td style="font-weight:bold;">Middle Name: </td>
					<td>
						<input name="middle_name" id="middle_name" type="text" maxlength="100" size="25" style="width:180px;" value="#REQUEST.pageData.formData.middle_name#">
					</td>
				</tr>  
				<tr>
					<td style="font-weight:bold;">Last Name: </td>
					<td>
						<input name="last_name" id="last_name" type="text" maxlength="40" size="25" style="width:180px;" value="#REQUEST.pageData.formData.last_name#">
					</td>
				</tr>
				<tr>
					<td style="font-weight:bold;">Phone: </td>
					<td><input name="phone" id="phone" type="text" maxlength="40" size="25" style="width:180px;" value="#REQUEST.pageData.formData.phone#"></td>
				</tr>
				<tr>
					<td style="font-weight:bold;">Date of Birth: </td>
					<td>
						<input name="date_of_birth" id="date_of_birth" type="text" maxlength="100" size="25" style="width:180px;" value="#REQUEST.pageData.formData.date_of_birth#">
					</td>
				</tr>
				<tr>
					<td style="font-weight:bold;">Company: </td>
					<td>
						<input name="company" id="company" type="text" maxlength="100" size="25" style="width:180px;" value="#REQUEST.pageData.formData.company#">
					</td>
				</tr>
				<tr>
					<td style="font-weight:bold;">Website: </td>
					<td>
						<input name="website" id="website" type="text" maxlength="100" size="25" style="width:180px;" value="#REQUEST.pageData.formData.website#">
					</td>
				</tr>
				<tr>
					<td colspan="2" style="padding-top:10px;">
					<table style="margin-left:-3px;">
						<tbody><tr>
							<td>
								<input type="checkbox" name="subscribed" id="subscribed" value="1" <cfif REQUEST.pageData.formData.subscribed EQ true>checked</cfif>>
							</td>
							<td>&nbsp;Check here if you want to subscribe our new product information</td>
						</tr>
					</tbody></table>
					</td>
				</tr>
				<tr>
					<td></td>
					<td style="padding-top:10px;"><input name="update_profile" type="submit" value="Update"></td>
				</tr>
				
			</tbody>
		</table>
	
		</div>
		<div style="clear:both;"></div>
	</div>
</div>
</form>
</cfoutput>