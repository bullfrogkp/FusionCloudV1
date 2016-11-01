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
			<cfset LOCAL.newsletter = EntityLoadByPK("newsletter", FORM.id)> 
			<cfset LOCAL.newsletter.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.newsletter.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.newsletter = EntityNew("newsletter") />
			<cfset LOCAL.newsletter.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.newsletter.setCreatedDatetime(Now()) />
			<cfset LOCAL.newsletter.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.newsletter.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.newsletter.setSubject(Trim(FORM.subject)) />
			<cfset LOCAL.newsletter.setContent(Trim(FORM.content)) />
			<cfset LOCAL.newsletter.setType(Trim(FORM.type)) />
			<cfset LOCAL.newsletter.setIsEnabled(FORM.is_enabled) />
			
			<cfset EntitySave(LOCAL.newsletter) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Newsletter has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin##getPageName()#.cfm?id=#LOCAL.newsletter.getNewsletterId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			
			<cfset LOCAL.newsletter.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.newsletter) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Newsletter '#LOCAL.newsletter.getSubject()#' has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin#newsletters.cfm" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.newsletter = EntityLoadByPK("newsletter", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.newsletter.getSubject()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.subject = isNull(LOCAL.pageData.newsletter.getSubject())?"":LOCAL.pageData.newsletter.getSubject() />
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.newsletter.getDisplayName())?"":LOCAL.pageData.newsletter.getDisplayName() />
				<cfset LOCAL.pageData.formData.content = isNull(LOCAL.pageData.newsletter.getContent())?"":LOCAL.pageData.newsletter.getContent() />
				<cfset LOCAL.pageData.formData.type = isNull(LOCAL.pageData.newsletter.getType())?"":LOCAL.pageData.newsletter.getType() />
				<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.newsletter.getIsEnabled())?"":LOCAL.pageData.newsletter.getIsEnabled() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Newsletter | #APPLICATION.applicationName#" />
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