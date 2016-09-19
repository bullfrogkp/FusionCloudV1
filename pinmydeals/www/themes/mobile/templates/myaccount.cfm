<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Account</a>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-9 col-sm-push-3">
			<div class="information-blocks">
				<div class="row">
					<div class="col-md-12 information-entry">
						<div class="article-container style-1">
							<p><h5>Account Settings</h5></p>
							<form>
								<input type="text" name="email" value="#REQUEST.pageData.customer.getEmail()#" placeholder="Enter Email Address" class="simple-field">
								<input type="text" name="first_name" value="#REQUEST.pageData.customer.getFirstName()#" placeholder="Enter First Name" class="simple-field">
								<input type="text" name="middle_name" value="#REQUEST.pageData.customer.getMiddleName()#" placeholder="Enter Middle Name" class="simple-field">
								<input type="text" name="last_name" value="#REQUEST.pageData.customer.getLastName()#" placeholder="Enter Last Name" class="simple-field">
								<input type="text" name="phone" value="#REQUEST.pageData.customer.getPhone()#" placeholder="Enter Phone" class="simple-field">
								<input type="text" name="company" value="#REQUEST.pageData.customer.getCompany()#" placeholder="Enter Company" class="simple-field">
								<input type="text" name="website" value="#REQUEST.pageData.customer.getWebsite()#" placeholder="Enter Website" class="simple-field">
								<label class="checkbox-entry checkbox">
									<input type="checkbox" name="subscribed" <cfif REQUEST.pageData.customer.getSubscribed() EQ true>checked</cfif>> <span class="check"></span> <b>Subscribe Newsletters</b>
								</label><br/>
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