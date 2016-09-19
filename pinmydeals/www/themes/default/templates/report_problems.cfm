<cfoutput>
	<div class="info-section">
		<div id="breadcrumb">
			<div class="breadcrumb-home-icon"></div>
			<div class="breadcrumb-arrow-icon"></div>
			<span style="vertical-align:middle">Report Problems</span> 
		</div>
		<div class="info-detail">
			<h2>Report Problems</h2>
			<div id="login-wrapper">
				<div id="login-form"><!--login form-->
					<form action="##">
						<table>
							<tr>
								<td colspan="2">
									<input type="text" placeholder="Name">
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="email" placeholder="Email Address">
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<textarea placeholder="Message" style="height:150px;"></textarea>
								</td>
							</tr>
							<tr>
								<td style="padding-top:10px;">
									<button type="submit" class="btn-signup">Send</button>
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