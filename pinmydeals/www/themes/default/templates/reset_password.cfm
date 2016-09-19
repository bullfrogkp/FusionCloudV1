<cfoutput>
<div id="breadcrumb">
	<div class="breadcrumb-home-icon"></div>
	<div class="breadcrumb-arrow-icon"></div>
	<span style="vertical-align:middle">Password Assistance</span> 
</div>
			
<div id="login-wrapper">
	<form method="post">
		<input type="hidden" name="u" value="#REQUEST.pageData.linkId#" />
		<h2>Reset Password</h2>
		<table>
			<tr>
				<td colspan="2">
					<input type="password" name="new_password" placeholder="New Password" style="width:300px;">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="password" name="confirm_new_password" placeholder="Confirm New Password" style="width:300px;">
				</td>
			</tr>
			<tr>
				<td style="padding-top:10px;">
					<input name="reset_password" type="submit" class="btn-signup" value="Reset Password">
				</td>
			</tr>
		</table>
	</form>
</div>
</cfoutput>