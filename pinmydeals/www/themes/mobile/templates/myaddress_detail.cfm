<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Dashboard</a>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-9 col-sm-push-3">
			<div class="information-blocks">
				<div class="row">
					<div class="col-md-12 information-entry">
						<div class="article-container style-1">
							<p><h5>Address Information</h5></p>
							<div class="row">
								<cfloop array="#REQUEST.pageData.customer.getAddreses()#" index="addr">
									<div class="col-md-4 information-entry">
										<div class="article-container style-1">
											#addr.getFirstName()# #addr.getMiddleName()# #addr.getLastName()#<br/>
											#addr.getStreet()# #addr.getUnit()#<br/>
											#addr.getCity()#, #addr.getProvince().getDisplayName()#, #addr.getPostalCode()#<br/>
											#addr.getCountry().getDisplayName()#<br/>
										</div>
									</div>
								</cfloop>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="information-blocks">
				<div class="row">
					<div class="col-md-12 information-entry">
						<div class="article-container style-1">
							<p><h5>Add New Address</h5></p>
							<form>
								<input type="text" name="first_name" value="" placeholder="First Name" class="simple-field">
								<input type="text" name="middle_name" value="" placeholder="Middle Name" class="simple-field">
								<input type="text" name="last_name" value="" placeholder="Last Name" class="simple-field">
								<input type="text" name="phone" value="" placeholder="Phone" class="simple-field">
								<input type="text" name="company" value="" placeholder="Company" class="simple-field">
								<input type="text" name="unit" value="" placeholder="Unit" class="simple-field">
								<input type="text" name="street" value="" placeholder="Street" class="simple-field">
								<input type="text" name="city" value="" placeholder="City" class="simple-field">
								<input type="text" name="postal_code" value="" placeholder="Postal Code" class="simple-field">
								<div class="simple-drop-down simple-field">
									<select name="province_id" id="province-id">
										<option value="">Province</option>
									</select>
								</div>
								<div class="simple-drop-down simple-field">
									<select name="country_id" id="province-id">
										<option value="">Country</option>
									</select>
								</div>
								<div class="button style-14">Add Address<input type="submit" value=""></div>
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