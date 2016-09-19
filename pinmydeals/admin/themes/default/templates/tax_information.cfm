<cfoutput>
<script>
	$(document).ready(function() {
		$( ".update-tax" ).click(function() {
			$("##tax_id").val($(this).attr('taxid'));
		});
	});
</script>
<section class="content-header">
	<h1>
		Tax Information
		<small>tax information</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Tax Information</li>
	</ol>
</section>
<form method="post">
<input type="hidden" name="tax_id" id="tax_id" value="" />
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
		<div class="col-xs-12">
			<div class="box">
				<div class="box-body table-responsive">
					<table class="table table-bordered table-striped data-table">
						<thead>
							<tr>
								<th>Province/State</th>
								<th>Tax Category</th>
								<th>Tax Rate</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<cfloop array="#REQUEST.pageData.taxes#" index="tax">
								<tr>
									<td>#tax.getProvince().getDisplayName()#</td>
									<td>#tax.getTaxCategory().getDisplayName()#</td>
									<td>
										<input type="text" name="rate_#tax.getTaxId()#" value="#tax.getRate()#" />
									</td>
									<td style="width:54px;">
										<button name="update_tax" taxid="#tax.getTaxId()#" type="submit" class="btn btn-sm btn-primary update-tax pull-right">Update</button>
									</td>
								</tr>
							</cfloop>
						</tbody>
						<tfoot>
							<tr>
								<th>Province/State</th>
								<th>Tax Rate</th>
								<th>Action</th>
							</tr>
						</tfoot>
					</table>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div>
	</div>
</section><!-- /.content -->
</form>
</cfoutput>
