<cfcomponent extends="core.pages.page">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif Trim(FORM.display_name) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid name.") />
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
			<cfset LOCAL.filter = EntityLoadByPK("filter", FORM.id)>  
			<cfset LOCAL.filter.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.filter.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.filter = EntityNew("filter") />
			<cfset LOCAL.filter.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.filter.setCreatedDatetime(Now()) />
			<cfset LOCAL.filter.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.filter.setName(LCase(Trim(FORM.display_name))) />
			<cfset LOCAL.filter.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.filter.setAttribute(EntityLoadByPK("attribute",FORM.attribute_id)) />
			
			<cfset EntitySave(LOCAL.filter) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Filter has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite##getPageName()#.cfm?id=#LOCAL.filter.getFilterId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			<cfset LOCAL.filter.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.filter) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Filter has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#filters.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		<cfset LOCAL.pageData.attributes = EntityLoad("attribute", {isDeleted = false}) />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.filter = EntityLoadByPK("filter", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.filter.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.filter.getDisplayName())?"":LOCAL.pageData.filter.getDisplayName() />
				<cfset LOCAL.pageData.formData.attribute_id = isNull(LOCAL.pageData.filter.getAttribute())?"":LOCAL.pageData.filter.getAttribute().getAttributeId() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Filter | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.attribute_id = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>