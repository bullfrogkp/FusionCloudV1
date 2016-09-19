<cfoutput>
<section class="content-header">
	<h1>
		Discount Type Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Discount Type Detail</li>
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
						<label>Name</label>&nbsp;&nbsp;(required)
						<input name="display_name" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.display_name#"/>
					</div>
					<div class="form-group">
						<label>Amount</label>&nbsp;&nbsp;(required)
						<input name="amount" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.amount#"/>
					</div>
					<div class="form-group">
						<label>Calculation Type</label>
						<select name="Calculation_type_id" class="form-control">
							<cfloop array="#REQUEST.pageData.CalculationTypes#" index="type">
								<option value="#type.getCalculationTypeId()#"
								
								<cfif type.getCalculationTypeId() EQ REQUEST.pageData.formData.calculation_type_id>
								selected
								</cfif>
								
								>#type.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
					<button name="save_item" type="submit" class="btn btn-primary">Submit</button>
					<button type="button" class="btn btn-danger pull-right #REQUEST.pageData.deleteButtonClass#" data-toggle="modal" data-target="##delete-current-entity-modal">Delete Discount Type</button>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
<!-- DELETE ENTITY MODAL -->
<div class="modal fade" id="delete-current-entity-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this discount type?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_item" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</form>
</cfoutput>