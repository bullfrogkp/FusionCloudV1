<cfoutput>
<section class="content-header">
	<h1>
		Address Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Address Detail</li>
	</ol>
</section>

<section class="content">
	<div class="row">
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<form role="form">
					<div class="box-body">
						<div class="form-group">
							<label>First Name</label>
							<input type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						 <div class="form-group">
							<label>Last Name</label>
							<input type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						 <div class="form-group">
							<label>Phone</label>
							<input type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						 <div class="form-group">
							<label>Street</label>
							<input type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						 <div class="form-group">
							<label>City</label>
							<input type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						 <div class="form-group">
							<label>Province</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Ontario</option>
								<option value="">Alberta</option>
							</select>
						</div>
						<div class="form-group">
							<label>Postal Code</label>
							<input type="text" class="form-control" placeholder="Enter ..." value=""/>
						</div>
						<div class="form-group">
							<label>Country</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Canada</option>
								<option value="">USA</option>
							</select>
						</div>
						<div class="form-group">
							<label>Type</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Billing</option>
								<option value="">Shipping</option>
							</select>
						</div>
						<div class="form-group">
							<label>Enabled</label>
							<select class="form-control" name="parent_category_id">
								<option value="0">Yes</option>
								<option value="">No</option>
							</select>
						</div>
						<button type="submit" class="btn btn-primary">Submit</button>
					</div><!-- /.box-body -->
				</form>
			</div><!-- /.box -->

		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</cfoutput>