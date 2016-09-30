<cfcomponent extends="core.pages.page">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
				
		<cfif StructKeyExists(FORM,"update_tax")>
			<cfset LOCAL.tax = EntityLoadByPK("tax",FORM.tax_id) /> 
			<cfset LOCAL.tax.setRate(Trim(FORM["rate_#FORM.tax_id#"])) />
			<cfset EntitySave(LOCAL.tax) />		
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Tax information has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite##getPageName()#.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Tax Information | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.taxes = EntityLoad("tax") />
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>