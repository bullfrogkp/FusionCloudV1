<cfoutput>

<script>
	$(document).ready(function() {
		CKEDITOR.replace( 'content',
		{
			filebrowserBrowseUrl :'#SESSION.urlThemeAdmin#js/plugins/ckeditor/filemanager/index.html',
			filebrowserImageBrowseUrl : '#SESSION.urlThemeAdmin#js/plugins//ckeditor/filemanager/index.html',
			filebrowserFlashBrowseUrl :'#SESSION.urlThemeAdmin#js/plugins//ckeditor/filemanager/index.html'}
		 );
		 
		 $('##reservation').datepicker();
		
		$(".tab-title").click(function() {
		  $("##tab_id").val($(this).attr('tabid'));
		});
	});
</script>
<section class="content-header">
	<h1>
		Page Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Newsletter Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.formData.id#" />
<input type="hidden" name="tab_id" id="tab_id" value="#REQUEST.pageData.tabs.activeTabId#" />
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
			<!-- Custom Tabs -->
			<div class="nav-tabs-custom">
				<ul class="nav nav-tabs">
					<li class="tab-title #REQUEST.pageData.tabs['tab_1']# tabid="tab_1"><a href="##tab_1" data-toggle="tab">Page Information</a></li>
					<cfloop array="#REQUEST.page.getModules()#" index="module">
						<li class="tab-title #REQUEST.pageData.tabs['tab_2']#" tabid="tab_2"><a href="##tab_2" data-toggle="tab">#module.getDisplayName()#</a></li>
					</cfloop>
				</ul>
				<div class="tab-content">
					<div class="tab-pane" id="tab_1">
						<div class="form-group">
							<label>Name</label>
							<input type="text" name="name" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.name#"/>
						</div>
						<div class="form-group">
							<label>Title</label>
							<input type="text" name="title" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.title#"/>
						</div>
						<div class="form-group">
							<label>Keywords</label>
							<input type="text" name="keywords" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.keywords#"/>
						</div>
						<div class="form-group">
							<label>Description</label>
							<input type="text" name="description" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.description#"/>
						</div>
						<div class="form-group">
							<label>Status</label>
							<input type="text" name="description" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.description#"/>
						</div>
					</div><!-- /.tab-pane -->
					<cfloop array="#REQUEST.page.getModules()#" index="module">
						<div class="tab-pane" id="tab_#i#">
							#module.getView()#
						</div>
					</cfloop>
				</div>	
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_new_address" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- DELETE ENTITY MODAL -->
<div class="modal fade" id="delete-current-entity-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this customer?</h4>
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