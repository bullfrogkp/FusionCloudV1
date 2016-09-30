<cfcomponent extends="core.pages.page">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"save_item")>
			<cfif FORM.display_name EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid name.") />
			</cfif>
			<cfif FORM.title EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter the page title.") />
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
			<cfset LOCAL.content = EntityLoadByPK("site_content", FORM.id)> 
			<cfset LOCAL.content.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.content.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.content = EntityNew("site_content") />
			<cfset LOCAL.content.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.content.setCreatedDatetime(Now()) />
			<cfset LOCAL.content.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.content.setName(Replace(LCase(Trim(FORM.display_name))," ","-","all")) />
			<cfset LOCAL.content.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.content.setSiteContent(Trim(FORM.site_content)) />
			<cfset LOCAL.content.setTitle(Trim(FORM.title)) />
			<cfset LOCAL.content.setDescription(Trim(FORM.description)) />
			<cfset LOCAL.content.setKeywords(Trim(FORM.keywords)) />
			<cfset LOCAL.content.setIsEnabled(FORM.is_enabled) />
			
			<cfset EntitySave(LOCAL.content) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Content has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite##getPageName()#.cfm?id=#LOCAL.content.getSiteContentId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			
			<cfset LOCAL.content.setIsDeleted(true) />
			<cfset EntitySave(LOCAL.content) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Content '#LOCAL.content.getName()#' has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#contents.cfm" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>		
	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.siteContent = EntityLoadByPK("site_content", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.siteContent.getName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.name = isNull(LOCAL.pageData.siteContent.getName())?"":LOCAL.pageData.siteContent.getName() />
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.siteContent.getDisplayName())?"":LOCAL.pageData.siteContent.getDisplayName() />
				<cfset LOCAL.pageData.formData.site_content = isNull(LOCAL.pageData.siteContent.getSiteContent())?"":LOCAL.pageData.siteContent.getSiteContent() />
				<cfset LOCAL.pageData.formData.title = isNull(LOCAL.pageData.siteContent.getTitle())?"":LOCAL.pageData.siteContent.getTitle() />
				<cfset LOCAL.pageData.formData.keywords = isNull(LOCAL.pageData.siteContent.getKeywords())?"":LOCAL.pageData.siteContent.getKeywords() />
				<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.siteContent.getDescription())?"":LOCAL.pageData.siteContent.getDescription() />
				<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.siteContent.getIsEnabled())?"":LOCAL.pageData.siteContent.getIsEnabled() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Content | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.name = "" />
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.site_content = "" />
				<cfset LOCAL.pageData.formData.title = "" />
				<cfset LOCAL.pageData.formData.keywords = "" />
				<cfset LOCAL.pageData.formData.description = "" />
				<cfset LOCAL.pageData.formData.is_enabled = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>