<cfoutput>
<section class="content-header">
	<h1>
		Site Information
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Site Info</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
				<div class="alert #REQUEST.pageData.message.messageType# alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
					#msg#<br/>
					</cfloop>
				</div>
			</cfif>
		</div>
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-body">
					<div class="form-group">
						<label>Company Name</label>
						<input name="name" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.name#"/>
					</div>
					<div class="form-group">
						<label>Email</label>
						<input name="email" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.email#"/>
					</div>
					<div class="form-group">
						<label>Phone</label>
						<input name="phone" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.phone#"/>
					</div>
					<div class="form-group">
						<label>Unit</label>
						<input name="unit" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.unit#"/>
					</div>
					<div class="form-group">
						<label>Street</label>
						<input name="street" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.street#"/>
					</div>
					 <div class="form-group">
						<label>City</label>
						<input name="city" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.city#"/>
					</div>
					<div class="form-group">
						<label>Province</label>
						<select class="form-control" name="province_id">
							<option value="">Please Select Province...</option>
							<cfloop array="#REQUEST.pageData.provinces#" index="province">
								<option value="#province.getProvinceId()#"
								
								<cfif REQUEST.pageData.formData.province_id EQ province.getProvinceId()>
								selected
								</cfif>
								
								>#province.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
					<div class="form-group">
						<label>Country</label>
						<select class="form-control" name="country_id">
							<option value="">Please Select Country...</option>
							<cfloop array="#REQUEST.pageData.countries#" index="country">
								<option value="#country.getCountryId()#"
								
								<cfif REQUEST.pageData.formData.country_id EQ country.getCountryId()>
								selected
								</cfif>
								
								>#country.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
					<div class="form-group">
						<label>Postal Code</label>
						<input name="postal_code" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.postal_code#"/>
					</div>
					<div class="form-group">
						<label>Map</label>
						<textarea class="form-control" rows="6" placeholder="Enter ..." name="map">#REQUEST.pageData.formData.map#</textarea>
					</div>
					<div class="form-group">
						<button type="submit" name="save_item" class="btn btn-primary">Submit</button>
					</div>
					<div class="form-group">
						#REQUEST.pageData.formData.map#
					</div>
					
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</form>
</cfoutput>