<cfoutput>
<section class="content-header">
	<h1>
		Users
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Users</li>
	</ol>
</section>
<form method="post">
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
								<th>Name</th>
								<th>Username</th>
								<th>Email</th>
								<th>Phone</th>
								<th>Last Login</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<cfloop array="#REQUEST.pageData.users#" index="user">
								<tr>
									<td>#user.getDisplayName()#</td>
									<td>#user.getUsername()#</td>
									<td>#user.getEmail()#</td>
									<td>#user.getPhone()#</td>
									<td>#Dateformat(user.getLastLoginDatetime(),"mmm dd, yyyy")# #Timeformat(user.getLastLoginDatetime(),"hh:mm:ss")#</td>
									<td><a href="#APPLICATION.absoluteUrlSite#admin/user_detail.cfm?id=#user.getAdminUserId()#">View Detail</a></td>
								</tr>
							</cfloop>
						</tbody>
						<tfoot>
							<tr>
								<th>Name</th>
								<th>Username</th>
								<th>Email</th>
								<th>Phone</th>
								<th>Last Login</th>
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
