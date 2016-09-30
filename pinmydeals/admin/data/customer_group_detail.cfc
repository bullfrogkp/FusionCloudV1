<cfcomponent extends="core.pages.page">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif Trim(FORM.group_name) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid group name.") />
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
			<cfset LOCAL.customerGroup = EntityLoadByPK("customer_group", FORM.id)> 
		<cfelse>
			<cfset LOCAL.customerGroup = EntityNew("customer_group") />
			<cfset LOCAL.customerGroup.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.customerGroup.setCreatedDatetime(Now()) />
			<cfset LOCAL.customerGroup.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
		
			<cfset LOCAL.customerGroup.setDisplayName(Trim(FORM.group_name)) />
			
			<cfif FORM.is_default EQ 1>
				<cfset LOCAL.defaultCustomerGroup = EntityLoad("customer_group",{isDefault=true},true) />
				<cfif NOT IsNull(LOCAL.defaultCustomerGroup)>
					<cfset LOCAL.defaultCustomerGroup.setIsDefault(false) />
				</cfif>
				<cfset LOCAL.customerGroup.setIsDefault(true) />
			<cfelse>
				<cfset LOCAL.customerGroup.setIsDefault(false) />
			</cfif>
			
			<cfif IsNumeric(FORM.discount_type_id)>
				<cfset LOCAL.customerGroup.setDiscountType(EntityLoadByPK("discount_type",FORM.discount_type_id)) />
			</cfif>
			
			<cfset EntitySave(LOCAL.customerGroup) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Customer group has been saved successfully.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#admin/#getPageName()#.cfm?id=#LOCAL.customerGroup.getCustomerGroupId()#" />
		<cfelseif StructKeyExists(FORM,"delete_item")>
			
			<cfset LOCAL.customerGroup.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.customerGroup) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Customer group #LOCAL.customerGroup.getDisplayName()# has been deleted.") />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#admin/customer_groups.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		<cfset LOCAL.pageData.discountTypes = EntityLoad("discount_type") />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.customerGroup = EntityLoadByPK("customer_group", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.customerGroup.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.group_name = isNull(LOCAL.pageData.customerGroup.getDisplayName())?"":LOCAL.pageData.customerGroup.getDisplayName() />
				<cfset LOCAL.pageData.formData.is_default = isNull(LOCAL.pageData.customerGroup.getIsDefault())?"":LOCAL.pageData.customerGroup.getIsDefault() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Customer Group | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.group_name = "" />
				<cfset LOCAL.pageData.formData.is_default = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>