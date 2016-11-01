<cfcomponent extends="core.pages.page">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"save_item")>
			<cfif FORM.code EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid code.") />
			</cfif>
			<cfif FORM.multiplier EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter the multiplier.") />
			</cfif>
			<cfif FORM.locale EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter the locale.") />
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
			<cfset LOCAL.currency = EntityLoadByPK("currency", FORM.id)> 
			<cfset LOCAL.currency.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.currency.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.currency = EntityNew("currency") />
			<cfset LOCAL.currency.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.currency.setCreatedDatetime(Now()) />
			<cfset LOCAL.currency.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.currency.setCode(Trim(FORM.code)) />
			<cfset LOCAL.currency.setMultiplier(Trim(FORM.multiplier)) />
			<cfset LOCAL.currency.setLocale(Trim(FORM.locale)) />
			<cfset LOCAL.currency.setIsEnabled(FORM.is_enabled) />
			
			<cfif FORM.is_default EQ 1>
				<cfset LOCAL.allCurrencies = EntityLoad("currency") />
				<cfloop array="#LOCAL.allCurrencies#" index="LOCAL.currentCurrency">
					<cfset LOCAL.currentCurrency.setIsDefault(false) />
				</cfloop>
				<cfset LOCAL.currency.setIsDefault(true) />
			<cfelse>
				<cfset LOCAL.currency.setIsDefault(false) />
			</cfif>
			
			<cfset EntitySave(LOCAL.currency) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Currency has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin##getPageName()#.cfm?id=#LOCAL.currency.getCurrencyId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			
			<cfset LOCAL.currency.setIsDeleted(true) />
			<cfset EntitySave(LOCAL.currency) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Currency '#LOCAL.currency.getCode()#' has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin#currencies.cfm" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>		
	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.currency = EntityLoadByPK("currency", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.currency.getCode()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.code = isNull(LOCAL.pageData.currency.getCode())?"":LOCAL.pageData.currency.getCode() />
				<cfset LOCAL.pageData.formData.multiplier = isNull(LOCAL.pageData.currency.getMultiplier())?"":LOCAL.pageData.currency.getMultiplier() />
				<cfset LOCAL.pageData.formData.locale = isNull(LOCAL.pageData.currency.getLocale())?"":LOCAL.pageData.currency.getLocale() />
				<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.currency.getIsEnabled())?"":LOCAL.pageData.currency.getIsEnabled() />
				<cfset LOCAL.pageData.formData.is_default = isNull(LOCAL.pageData.currency.getIsDefault())?"":LOCAL.pageData.currency.getIsDefault() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Currency | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.code = "" />
				<cfset LOCAL.pageData.formData.multiplier = "" />
				<cfset LOCAL.pageData.formData.locale = "" />
				<cfset LOCAL.pageData.formData.is_enabled = "" />
				<cfset LOCAL.pageData.formData.is_default = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>