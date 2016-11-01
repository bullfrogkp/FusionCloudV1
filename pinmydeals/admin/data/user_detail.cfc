<cfcomponent extends="core.pages.page">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif Trim(FORM.display_name) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid name.") />
		</cfif>		
		
		<cfif Trim(FORM.username) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid username.") />
		<cfelse>
			<cfset LOCAL.existingUser = EntityLoad("admin_user",{username=Trim(FORM.username)},true) />
			<cfif NOT IsNull(LOCAL.existingUser) AND LOCAL.existingUser.getAdminUserId() NEQ FORM.id>
				<cfset ArrayAppend(LOCAL.messageArray,"Username already exists.") />
			</cfif>
		</cfif>
	
		<cfif IsNumeric(FORM.id)>
			<cfif Trim(FORM.current_password) NEQ "">
				<cfif Trim(FORM.new_password) NEQ Trim(FORM.confirm_new_password)>
					<cfset ArrayAppend(LOCAL.messageArray,"Passwords don't match") />
				<cfelse>
					<cfset LOCAL.userService = new "core.services.userService"() />
					<cfset LOCAL.userService.setUsername(Trim(FORM.username)) />
					<cfset LOCAL.userService.setPassword(Trim(FORM.current_password)) />
					<cfif LOCAL.userService.isUserValid() EQ false>
						<cfset ArrayAppend(LOCAL.messageArray,"The current password is not correct.") />
					</cfif>
				</cfif>
			</cfif>
		<cfelse>
			<!--- password is required for new user --->
			<cfif Trim(FORM.password) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please choose a password") />
			<cfelseif Trim(FORM.password) NEQ Trim(FORM.confirm_password)>
				<cfset ArrayAppend(LOCAL.messageArray,"Passwords don't match") />
			</cfif>
		</cfif>
			
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset SESSION.temp.message.messageType = "alert-danger" />
			<cfset LOCAL.redirectUrl = _setRedirectURL() />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.user = EntityLoadByPK("admin_user", FORM.id)> 
			<cfset LOCAL.user.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.user.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.user = EntityNew("admin_user") />
			<cfset LOCAL.user.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.user.setCreatedDatetime(Now()) />
			<cfset LOCAL.user.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.user.setUsername(Trim(FORM.username)) />
			<cfset LOCAL.user.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.user.setIsAdministrator(FORM.is_administrator) />
			<cfset LOCAL.user.setIsEnabled(FORM.is_enabled) />
			<cfif StructKeyExists(FORM,"avatar_name")>
				<cfset LOCAL.user.setAvatarName(FORM.avatar_name) />
			<cfelse>
				<cfset LOCAL.user.setAvatarName("avatar1") />
			</cfif>
			<cfif StructKeyExists(FORM,"new_password")>
				<cfset LOCAL.user.setPassword(Hash(Trim(FORM.new_password))) />
			<cfelse>
				<cfset LOCAL.user.setPassword(Hash(Trim(FORM.password))) />
			</cfif>
			<cfset LOCAL.user.setEmail(Trim(FORM.email)) />
			<cfset LOCAL.user.setPhone(Trim(FORM.phone)) />
			
			<cfset EntitySave(LOCAL.user) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"User has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin##getPageName()#.cfm?id=#LOCAL.user.getAdminUserId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			
			<cfset LOCAL.user.setIsDeleted(true) />
			<cfset EntitySave(LOCAL.user) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"User has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin#users.cfm" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.user = EntityLoadByPK("admin_user", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.user.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
				<cfif NOT StructKeyExists(LOCAL.pageData,"avatar_name")>
					<cfset LOCAL.pageData.formData.avatar_name = "" />
				</cfif>
			<cfelse>
				<cfset LOCAL.pageData.formData.username = isNull(LOCAL.pageData.user.getUsername())?"":LOCAL.pageData.user.getUsername() />
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.user.getDisplayName())?"":LOCAL.pageData.user.getDisplayName() />
				<cfset LOCAL.pageData.formData.email = isNull(LOCAL.pageData.user.getEmail())?"":LOCAL.pageData.user.getEmail() />
				<cfset LOCAL.pageData.formData.phone = isNull(LOCAL.pageData.user.getPhone())?"":LOCAL.pageData.user.getPhone() />
				<cfset LOCAL.pageData.formData.is_administrator = isNull(LOCAL.pageData.user.getIsAdministrator())?"":LOCAL.pageData.user.getIsAdministrator() />
				<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.user.getIsEnabled())?"":LOCAL.pageData.user.getIsEnabled() />
				<cfset LOCAL.pageData.formData.avatar_name = isNull(LOCAL.pageData.user.getAvatarName())?"":LOCAL.pageData.user.getAvatarName() />
				<cfset LOCAL.pageData.formData.last_login_datetime = isNull(LOCAL.pageData.user.getLastLoginDatetime())?"":LOCAL.pageData.user.getLastLoginDatetime() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "User Detail | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
				<cfif NOT StructKeyExists(LOCAL.pageData,"avatar_name")>
					<cfset LOCAL.pageData.formData.avatar_name = "" />
				</cfif>
			<cfelse>
				<cfset LOCAL.pageData.formData.username = "" />
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.email = "" />
				<cfset LOCAL.pageData.formData.phone = "" />
				<cfset LOCAL.pageData.formData.last_login_datetime = "" />
				<cfset LOCAL.pageData.formData.is_administrator = "" />
				<cfset LOCAL.pageData.formData.is_enabled = "" />
				<cfset LOCAL.pageData.formData.avatar_name = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>