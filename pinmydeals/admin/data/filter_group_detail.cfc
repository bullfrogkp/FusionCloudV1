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
			<cfset LOCAL.filterGroup = EntityLoadByPK("filter_group", FORM.id)> 
			<cfset LOCAL.filterGroup.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.filterGroup.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.filterGroup = EntityNew("filter_group") />
			<cfset LOCAL.filterGroup.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.filterGroup.setCreatedDatetime(Now()) />
			<cfset LOCAL.filterGroup.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.filterGroup.setName(LCase(Trim(FORM.display_name))) />
			<cfset LOCAL.filterGroup.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.filterGroup.removeFilters() />
			
			<cfloop list="#FORM.filter_id#" index="LOCAL.filterId">
				<cfset LOCAL.newFilter = EntityLoadByPK("filter",LOCAL.filterId) />
				<cfset LOCAL.filterGroup.addFilter(LOCAL.newFilter) />
			</cfloop>
			
			<cfset EntitySave(LOCAL.filterGroup) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Filter group has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlHttpsAdmin##getPageName()#.cfm?id=#LOCAL.filterGroup.getFilterGroupId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			<cfset LOCAL.filterGroup.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.filterGroup) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Filter group has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlHttpsAdmin#filter_groups.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.filters = EntityLoad("filter",{isDeleted=false}) />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.filterGroup = EntityLoadByPK("filter_group", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.filterGroup.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.filterGroup.getDisplayName())?"":LOCAL.pageData.filterGroup.getDisplayName() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Filter Group | #APPLICATION.applicationName#" />
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