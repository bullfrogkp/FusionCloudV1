<cfoutput>
<section class="content-header">
	<h1>
		Conversation Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Conversation Detail</li>
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
							<label>Customer <a href="#APPLICATION.urlHttpsAdmin#customer_detail.cfm?id=#REQUEST.pageData.conversation.getCustomer().getCustomerId()#" class="form-link" style="margin-left:18px;">#REQUEST.pageData.conversation.getCustomer().getFullName()#</a></label>
						</div>
						<div class="form-group">
							<label>Post By <a href="" class="form-link">#REQUEST.pageData.conversation.getCreatedUser()# (#REQUEST.pageData.conversation.getCreatedDatetime()#)</a></label>
						</div>
					<cfelse>
						<div class="form-group">
							<label>Customer ID</label>
							<input type="text" name="customer_id" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.customer_id#"/>
						</div>
					</cfif>
					
					<div class="form-group">
						<label>Subject</label>
						<input type="text" name="subject" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.subject#"/>
					</div>
					<div class="form-group">
						<label>Description</label>
						<textarea name="description" class="form-control" rows="5" placeholder="Enter ...">#REQUEST.pageData.formData.description#</textarea>
					</div>
					<div class="form-group">
						<label>Content</label>
						<textarea name="content" class="form-control" rows="5" placeholder="Enter ...">#REQUEST.pageData.formData.content#</textarea>
					</div>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
			<cfif NOT IsNumeric(REQUEST.pageData.formData.id)>
				<div class="form-group">
					<button name="save_item" type="submit" class="btn btn-primary top-nav-button">Save Conversation</button>
				</div>
			</cfif>
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
</form>
</cfoutput>