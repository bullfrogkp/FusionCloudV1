<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Password</a>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-9 col-sm-push-3">
			<div class="information-blocks">
				<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
					<div class="row">
						<div class="col-md-12 information-entry">
							<div class="article-container style-1">
								<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
									#msg#<br/>
								</cfloop>
							</div>
						</div>
					</div>
				</cfif>
				<div class="row">
					<div class="col-md-12 information-entry">
						<div class="article-container style-1">
							<p><h5>Password</h5></p>
							<form>
								<input type="password" name="current_password" id="current-password" value="" placeholder="Current Password" class="simple-field">
								<input type="password" name="new_password" id="new-password" value="" placeholder="New Password" class="simple-field">
								<input type="password" name="confirm_new_password" id="confirm-new-password" value="" placeholder="Confirm New Password" class="simple-field">
								<div class="button style-14">Save<input type="submit" value=""></div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<cfinclude template="nav.cfm" />
	</div>
</div>
</cfoutput>