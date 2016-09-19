<cfoutput>

<script>
	$(document).ready(function() {
		CKEDITOR.replace( 'content',
		{
			filebrowserBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserImageBrowseUrl : '#SESSION.absoluteUrlThemeAdmin#js/plugins//ckeditor/filemanager/index.html',
			filebrowserFlashBrowseUrl :'#SESSION.absoluteUrlThemeAdmin#js/plugins//ckeditor/filemanager/index.html'}
		 );
	});
</script>
<section class="content-header">
	<h1>
		Newsletter Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Newsletter Detail</li>
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
						<label>Subject</label>&nbsp;&nbsp;(required)
						<input type="text" name="subject" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.subject#"/>
					</div>
					 <div class="form-group">
						<label>Name</label>&nbsp;&nbsp;(required)
						<input type="text" name="display_name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.display_name#"/>
					</div>
					<div class="form-group">
						<label>Type</label>
						<select class="form-control" name="type">
							<option value="html" <cfif REQUEST.pageData.formData.type EQ "html">selected</cfif>>HTML</option>
							<option value="plaintext" <cfif REQUEST.pageData.formData.type EQ "plaintext">selected</cfif>>Plaintext</option>
						</select>
					</div>
					<div class="form-group">
						<label>Status</label>
						<select class="form-control" name="is_enabled">
							<option value="1" <cfif REQUEST.pageData.formData.is_enabled EQ 1>selected</cfif>>Enabled</option>
							<option value="0" <cfif REQUEST.pageData.formData.is_enabled EQ 0>selected</cfif>>Disabled</option>
						</select>
					</div>
					<div class="form-group">
						<label>Content</label>
						<textarea name="content" id="content" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.content#</textarea>
					</div>
					<div class="form-group">
						<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Newsletter</button>
						<button type="button" class="btn btn-danger pull-right #REQUEST.pageData.deleteButtonClass#" data-toggle="modal" data-target="##delete-current-entity-modal">Delete Newsletter</button>
					</div>
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
				<h4 class="modal-title"> Delete this newsletter?</h4>
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