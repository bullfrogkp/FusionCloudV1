<cfcomponent extends="core.pages.page">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif Trim(FORM.subject) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter the subject.") />
		</cfif>
		
		<cfif Trim(FORM.display_name) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter the name.") />
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
			<cfset LOCAL.systemEmail = EntityLoadByPK("system_email", FORM.id)> 
			<cfset LOCAL.systemEmail.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.systemEmail.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.systemEmail = EntityNew("system_email") />
			<cfset LOCAL.systemEmail.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.systemEmail.setCreatedDatetime(Now()) />
			<cfset LOCAL.systemEmail.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.systemEmail.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.systemEmail.setName(LCase(Trim(FORM.display_name))) />
			<cfset LOCAL.systemEmail.setSubject(Trim(FORM.subject)) />
			<cfset LOCAL.systemEmail.setContent(Trim(FORM.content)) />
			<cfset LOCAL.systemEmail.setType(Trim(FORM.type)) />
			<cfset LOCAL.systemEmail.setIsEnabled(FORM.is_enabled) />
			
			<cfset EntitySave(LOCAL.systemEmail) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"System email has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite##getPageName()#.cfm?id=#LOCAL.systemEmail.getSystemEmailId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			
			<cfset LOCAL.systemEmail.setIsDeleted(true) />
			<cfset LOCAL.systemEmail.setIsEnabled(false) />
			
			<cfset EntitySave(LOCAL.systemEmail) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"System Email '#LOCAL.systemEmail.getSubject()#' has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#system_emails.cfm" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.systemEmail = EntityLoadByPK("system_email", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.systemEmail.getSubject()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.subject = isNull(LOCAL.pageData.systemEmail.getSubject())?"":LOCAL.pageData.systemEmail.getSubject() />
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.systemEmail.getDisplayName())?"":LOCAL.pageData.systemEmail.getDisplayName() />
				<cfset LOCAL.pageData.formData.content = isNull(LOCAL.pageData.systemEmail.getContent())?"":LOCAL.pageData.systemEmail.getContent() />
				<cfset LOCAL.pageData.formData.type = isNull(LOCAL.pageData.systemEmail.getType())?"":LOCAL.pageData.systemEmail.getType() />
				<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.systemEmail.getIsEnabled())?"":LOCAL.pageData.systemEmail.getIsEnabled() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "System Email | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.subject = "" />
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.content = "" />
				<cfset LOCAL.pageData.formData.type = "" />
				<cfset LOCAL.pageData.formData.is_enabled = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>