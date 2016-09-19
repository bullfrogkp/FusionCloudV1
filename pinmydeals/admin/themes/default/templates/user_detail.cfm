<cfoutput>
<script>
	$(document).ready(function() {
	
		$(".tab-title").click(function() {
		  $("##tab_id").val($(this).attr('tabid'));
		});
	});
</script>
<section class="content-header">
	<h1>
		User Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">User Detail</li>
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
			<div class="nav-tabs-custom">
				<ul class="nav nav-tabs">
					<li class="tab-title #REQUEST.pageData.tabs['tab_1']#" tabid="tab_1"><a href="##tab_1" data-toggle="tab">General Information</a></li>
					<li class="tab-title #REQUEST.pageData.tabs['tab_2']#" tabid="tab_2"><a href="##tab_2" data-toggle="tab">Password</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane #REQUEST.pageData.tabs['tab_1']#" id="tab_1">
						<cfif IsNumeric(REQUEST.pageData.formData.id)>
						<div class="form-group">
							<label>Last Login: #REQUEST.pageData.user.getLastLoginDatetime()#</label>
						</div>
						</cfif>
						<div class="form-group">
							<label>Username</label>&nbsp;&nbsp;(required)
							<input name="username" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.username#"/>
						</div>
						<div class="form-group">
							<label>Name</label>&nbsp;&nbsp;(required)
							<input name="display_name" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.display_name#"/>
						<div class="form-group">
							<label>Email</label>
							<input name="email" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.email#"/>
						</div>
						<div class="form-group">
							<label>Phone</label>
							<input name="phone" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.phone#"/>
						</div>
						<div class="form-group">
							<label>Administrator</label>
							 <select class="form-control" name="is_administrator">
								<option value="1" <cfif REQUEST.pageData.formData.is_administrator EQ TRUE>selected</cfif>>No</option>
								<option value="0" <cfif REQUEST.pageData.formData.is_administrator EQ FALSE>selected</cfif>>Yes</option>
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
							<label>Avatar</label>
							<div class="row">
								<div class="col-md-2" style="text-align:center;">
									<img src="#SESSION.absoluteUrlThemeAdmin#img/avatar/avatar1.png" class="img-responsive"><br/>
									<input class="form-control" type="radio" name="avatar_name" value="avatar1" <cfif REQUEST.pageData.formData.avatar_name EQ "avatar1">checked</cfif>/>
								</div>
								<div class="col-md-2" style="text-align:center;">
									<img src="#SESSION.absoluteUrlThemeAdmin#img/avatar/avatar2.png" class="img-responsive"><br/>
									<input class="form-control" type="radio" name="avatar_name" value="avatar2" <cfif REQUEST.pageData.formData.avatar_name EQ "avatar2">checked</cfif>/>
								</div>
								<div class="col-md-2" style="text-align:center;">
									<img src="#SESSION.absoluteUrlThemeAdmin#img/avatar/avatar3.png" class="img-responsive"><br/>
									<input class="form-control" type="radio" name="avatar_name" value="avatar3" <cfif REQUEST.pageData.formData.avatar_name EQ "avatar3">checked</cfif>/>
								</div>
								<div class="col-md-2" style="text-align:center;">
									<img src="#SESSION.absoluteUrlThemeAdmin#img/avatar/avatar4.png" class="img-responsive"><br/>
									<input class="form-control" type="radio" name="avatar_name" value="avatar4" <cfif REQUEST.pageData.formData.avatar_name EQ "avatar4">checked</cfif>/>
								</div>
								<div class="col-md-2" style="text-align:center;">
									<img src="#SESSION.absoluteUrlThemeAdmin#img/avatar/avatar5.png" class="img-responsive"><br/>
									<input class="form-control" type="radio" name="avatar_name" value="avatar5" <cfif REQUEST.pageData.formData.avatar_name EQ "avatar5">checked</cfif>/>
								</div>
								<div class="col-md-2" style="text-align:center;">
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane #REQUEST.pageData.tabs['tab_2']#" id="tab_2">
						<cfif IsNumeric(REQUEST.pageData.formData.id)>
							<div class="form-group">
								<label>Current Password</label>
								<input name="current_password" type="password" class="form-control" placeholder="Enter ..." value=""/>
							</div>
							<div class="form-group">
								<label>New Password</label>
								<input name="new_password" type="password" class="form-control" placeholder="Enter ..." value=""/>
							</div>
							<div class="form-group">
								<label>Confirm New Password</label>
								<input name="confirm_new_password" type="password" class="form-control" placeholder="Enter ..." value=""/>
							</div>
						<cfelse>
							<div class="form-group">
								<label>Password</label>
								<input name="password" type="password" class="form-control" placeholder="Enter ..." value=""/>
							</div>
							<div class="form-group">
								<label>Confirm Password</label>
								<input name="confirm_password" type="password" class="form-control" placeholder="Enter ..." value=""/>
							</div>
						</cfif>
					</div>
				</div>
			</div>
			<div class="form-group">
				<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save User</button>
				<button type="button" class="btn btn-danger pull-right #REQUEST.pageData.deleteButtonClass#" data-toggle="modal" data-target="##delete-current-entity-modal">Delete User</button>
			</div>
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
<!-- DELETE ENTITY MODAL -->
<div class="modal fade" id="delete-current-entity-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this user?</h4>
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