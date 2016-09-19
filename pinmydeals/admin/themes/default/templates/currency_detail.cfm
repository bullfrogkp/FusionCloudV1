<cfoutput>
<section class="content-header">
	<h1>
		Currency Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Currency Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="id" value="#REQUEST.pageData.formData.id#" />
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
						<label>Code</label>
						<input type="text" name="code" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.code#"/>
					</div>
					 <div class="form-group">
						<label>Multiplier</label>
						<input name="multiplier" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.multiplier#"/>
					</div>
					 <div class="form-group">
						<label>Locale</label>
						<input name="locale" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.locale#"/>
					</div>
					
					<div class="form-group">
						<label>Default</label>
						 <select class="form-control" name="is_default">
							<option value="1" <cfif REQUEST.pageData.formData.is_default EQ TRUE>selected</cfif>>Yes</option>
							<option value="0" <cfif REQUEST.pageData.formData.is_default EQ FALSE>selected</cfif>>No</option>
						</select>
					</div>
					<div class="form-group">
						<label>Status</label>
						 <select class="form-control" name="is_enabled">
							<option value="1" <cfif REQUEST.pageData.formData.is_enabled EQ TRUE>selected</cfif>>Enabled</option>
							<option value="0" <cfif REQUEST.pageData.formData.is_enabled EQ FALSE>selected</cfif>>Disabled</option>
						</select>
					</div>
					<div class="form-group">
						<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Currency</button>
						<button type="button" class="btn btn-danger pull-right #REQUEST.pageData.deleteButtonClass#" data-toggle="modal" data-target="##delete-current-entity-modal">Delete Currency</button>
					</div>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</form>
</cfoutput>