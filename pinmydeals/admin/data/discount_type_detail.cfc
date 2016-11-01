<cfcomponent extends="core.pages.page">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif Trim(FORM.amount) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid amount.") />
		</cfif>
		
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
			<cfset LOCAL.discountType = EntityLoadByPK("discount_type", FORM.id)>  
			<cfset LOCAL.discountType.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.discountType.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.discountType = EntityNew("discount_type") />
			<cfset LOCAL.discountType.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.discountType.setCreatedDatetime(Now()) />
			<cfset LOCAL.discountType.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.discountType.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.discountType.setCalculationType(EntityLoadByPK("calculation_type",FORM.calculation_type_id)) />
			<cfset LOCAL.discountType.setAmount(Trim(FORM.amount)) />
			
			<cfset EntitySave(LOCAL.discountType) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Discount type has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin##getPageName()#.cfm?id=#LOCAL.discountType.getDiscountTypeId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			<cfset LOCAL.discountType.setIsDeleted(true) />
			
			<cfset EntitySave(LOCAL.discountType) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Discount type has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin#discount_types.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		<cfset LOCAL.pageData.calculationTypes = EntityLoad("calculation_type") />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.discountType = EntityLoadByPK("discount_type", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.discountType.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.discountType.getDisplayName())?"":LOCAL.pageData.discountType.getDisplayName() />
				<cfset LOCAL.pageData.formData.amount = isNull(LOCAL.pageData.discountType.getAmount())?"":LOCAL.pageData.discountType.getAmount() />
				<cfset LOCAL.pageData.formData.id = URL.id />
				<cfset LOCAL.pageData.formData.calculation_type_id =  isNull(LOCAL.pageData.discountType.getCalculationType())?"":LOCAL.pageData.discountType.getCalculationType().getCalculationTypeId() />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Discount Type | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.amount = "" />
				<cfset LOCAL.pageData.formData.id = "" />
				<cfset LOCAL.pageData.formData.calculation_type_id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>