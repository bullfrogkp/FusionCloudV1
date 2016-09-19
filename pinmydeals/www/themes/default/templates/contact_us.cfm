<cfoutput>
	<div class="info-section">
		<div id="breadcrumb">
			<div class="breadcrumb-home-icon"></div>
			<div class="breadcrumb-arrow-icon"></div>
			<span style="vertical-align:middle">Contact Us</span> 
		</div>
		<div class="info-detail">
			<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
				<div style="font-size:12px;color:red;margin:20px 0 20px 20px;">
					<ul>
						<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
							<li>#msg#</li>
						</cfloop>
					</ul>
				</div>
			</cfif>
			<h2>Contact Us</h2>
			<div id="login-wrapper">
				<div id="login-form"><!--login form-->
					<form method="post">
						<table>
							<tr>
								<td colspan="2">
									<input name="contact_name" type="text" placeholder="Name">
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input name="contact_email" type="email" placeholder="Email Address">
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<textarea name="contact_message" placeholder="Message" style="height:150px;"></textarea>
								</td>
							</tr>
							<tr>
								<td style="padding-top:10px;">
									<button name="send_message" type="submit" class="btn-signup">Send</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
	</div>		
	<cfinclude template="info_sidebar.cfm" />
</cfoutput>