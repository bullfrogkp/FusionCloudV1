<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">My Account</span> 
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Change Password</span> 
</div>
<cfinclude template="myaccount_sidenav.cfm" />
<form method="post">
<div id="myaccount-content">
	<h1>My Profile</h1>
	<div style="margin-top:20px;" class="single_field">
		<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
			<div style="font-size:12px;color:red;margin:20px 0 20px 20px;">
				<ul>
					<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
						<li>#msg#</li>
					</cfloop>
				</ul>
			</div>
		</cfif>
		<div>
			<table id="current-address-table" class="shipping-address-selected" style="width:100%;margin-top:20px;">
				<tr>
					<th colspan="2" align="left" style="font-size:14px;font-weight:bold;padding-bottom:20px;">Change Password
					</th>
				</tr>
				
				<tr>
					<td style="font-weight:bold;">Current Password: </td>
					<td>
						<input name="current_password" id="current_password" type="password" maxlength="100" size="25" style="width:180px;">
					</td>
				</tr>
				  
				<tr>
					<td style="font-weight:bold;">New Password: </td>
					<td>
						<input name="new_password" id="new_password" type="password" maxlength="40" size="25" style="width:180px;">
					</td>
				</tr>
				
				<tr>
					<td style="font-weight:bold;">Confirm New Password: </td>
					<td>
						<input name="confirm_new_password" id="confirm_new_password" type="password" maxlength="40" size="25" style="width:180px;">
					</td>
				</tr>
				
				<tr>
					<td></td>
					<td style="padding-top:10px;"><input name="update_password" type="submit" value="Update"></td>
				</tr>
			</tbody>
		</table>
	
		</div>
		<div style="clear:both;"></div>
	</div>
</div>
</form>
</cfoutput>