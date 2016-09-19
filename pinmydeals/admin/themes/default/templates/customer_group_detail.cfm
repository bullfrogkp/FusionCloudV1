<cfoutput>
<section class="content-header">
	<h1>
		Customer Group Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Customer Group Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.formData.id#" />
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
							<label>Group Name</label>&nbsp;&nbsp;(required)
							<input type="text" name="group_name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.group_name#"/>
						</div>
						<div class="form-group">
							<label>Default</label>
							 <select class="form-control" name="is_default">
								<option value="1" <cfif REQUEST.pageData.formData.is_default EQ TRUE>selected</cfif>>Yes</option>
								<option value="0" <cfif REQUEST.pageData.formData.is_default EQ FALSE>selected</cfif>>No</option>
							</select>
						</div>
						<div class="form-group">
							<label>Discount Type</label>
							<select class="form-control" name="discount_type_id">
								<option value="">Please Select...</option>
								<cfloop array="#REQUEST.pageData.discountTypes#" index="type">
									<option value="#type.getDiscountTypeId()#"
									
									<cfif NOT IsNull(REQUEST.pageData.customerGroup) AND NOT IsNull(REQUEST.pageData.customerGroup.getDiscountType()) AND type.getDiscountTypeId() EQ REQUEST.pageData.customerGroup.getDiscountType().getDiscountTypeId()>
									selected
									</cfif>
									
									>#type.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
						<button name="save_item" type="submit" class="btn btn-primary">Submit</button>
					</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</form>
</cfoutput>