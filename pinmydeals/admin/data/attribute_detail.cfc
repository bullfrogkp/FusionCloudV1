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
			<cfset LOCAL.attribute = EntityLoadByPK("attribute", FORM.id)> 
			<cfset LOCAL.attribute.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.attribute.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.attribute = EntityNew("attribute") />
			<cfset LOCAL.attribute.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.attribute.setCreatedDatetime(Now()) />
			<cfset LOCAL.attribute.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.attribute.setName(LCase(Trim(FORM.display_name))) />
			<cfset LOCAL.attribute.setDisplayName(Trim(FORM.display_name)) />
			
			<cfset EntitySave(LOCAL.attribute) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Attribute has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite##getPageName()#.cfm?id=#LOCAL.attribute.getAttributeId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			<cfset LOCAL.attribute.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.attribute) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Attribute has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#attributes.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.attribute = EntityLoadByPK("attribute", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.attribute.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.attribute.getDisplayName())?"":LOCAL.pageData.attribute.getDisplayName() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Attribute | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>