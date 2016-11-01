<cfoutput>
<script>
	$(document).ready(function() {
		CKEDITOR.replace( 'site_content',
		{
			filebrowserBrowseUrl :'#SESSION.urlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserImageBrowseUrl : '#SESSION.urlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserFlashBrowseUrl :'#SESSION.urlThemeAdmin#js/plugins/ckeditor/filemanager/index.html'}
		 );
	});
</script>
<section class="content-header">
	<h1>
		Content Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Content Detail</li>
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
					<cfif IsNumeric(REQUEST.pageData.formData.id)>
						<div class="form-group">
							<label>Link:</label>
							<a href="#APPLICATION.urlWeb#site_content.cfm/#REQUEST.pageData.formData.name#" target="_blank">#APPLICATION.urlWeb#site_content.cfm/#REQUEST.pageData.formData.name#</a>
						</div>
					</cfif>
					<div class="form-group">
						<label>Name</label>&nbsp;&nbsp;(required)
						<input type="text" name="display_name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.display_name#"/>
					</div>
					 <div class="form-group">
						<label>Title</label>&nbsp;&nbsp;(required)
						<input name="title" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.title#"/>
					</div>
					<div class="form-group">
						<label>Description</label>
						<textarea name="description" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.formData.description#</textarea>
					</div>
					<div class="form-group">
						<label>Keywords</label>
						<textarea name="keywords" class="form-control" rows="3" placeholder="Enter ...">#REQUEST.pageData.formData.keywords#</textarea>
					</div>
					<div class="form-group">
						<label>Status</label>
						 <select class="form-control" name="is_enabled">
							<option value="1" <cfif REQUEST.pageData.formData.is_enabled EQ TRUE>selected</cfif>>Enabled</option>
							<option value="0" <cfif REQUEST.pageData.formData.is_enabled EQ FALSE>selected</cfif>>Disabled</option>
						</select>
					</div>
					<div class="form-group">
						<label>Content</label>
						<textarea name="site_content" id="site_content" class="textarea" placeholder="Message" style="width: 100%; height: 125px; font-size: 14px; line-height: 18px; border: 1px solid ##dddddd; padding: 10px;">#REQUEST.pageData.formData.site_content#</textarea>
					</div>
					<div class="form-group">
						<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Content</button>
						<button type="button" class="btn btn-danger pull-right #REQUEST.pageData.deleteButtonClass#" data-toggle="modal" data-target="##delete-current-entity-modal">Delete Content</button>
					</div>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</form>
</cfoutput>