<cfcomponent extends="core.pages.page">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
				
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.siteInfoArray = EntityLoad("site_info") /> 
			
			<cfif ArrayLen(LOCAL.siteInfoArray) GT 0>
				<cfset LOCAL.siteInfo = LOCAL.siteInfoArray[1] /> 
			<cfelse>
				<cfset LOCAL.siteInfo = EntityNew("site_info") /> 
			</cfif>
			
			<cfset LOCAL.siteInfo.setName(Trim(FORM.name)) />
			<cfset LOCAL.siteInfo.setUnit(Trim(FORM.unit)) />
			<cfset LOCAL.siteInfo.setStreet(Trim(FORM.street)) />
			<cfset LOCAL.siteInfo.setCity(Trim(FORM.city)) />
			<cfset LOCAL.siteInfo.setProvince(EntityLoadByPK("province",FORM.province_id)) />
			<cfset LOCAL.siteInfo.setCountry(EntityLoadByPK("country",FORM.country_id)) />
			<cfset LOCAL.siteInfo.setPostalCode(Trim(FORM.postal_code)) />
			<cfset LOCAL.siteInfo.setPhone(Trim(FORM.phone)) />
			<cfset LOCAL.siteInfo.setEmail(Trim(FORM.email)) />
			<cfset LOCAL.siteInfo.setMap(Trim(FORM.map)) />
			
			<cfset EntitySave(LOCAL.siteInfo) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Company information has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite##getPageName()#.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Company Information | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.provinces = EntityLoad("province") />
		<cfset LOCAL.pageData.countries = EntityLoad("country") />
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.siteInfo = EntityLoad("site_info",{},true) /> 
			
			<cfif NOT IsNull(LOCAL.pageData.siteInfo)>
				<cfset LOCAL.pageData.formData.name = LOCAL.pageData.siteInfo.getName() />
				<cfset LOCAL.pageData.formData.unit = LOCAL.pageData.siteInfo.getUnit() />
				<cfset LOCAL.pageData.formData.street = LOCAL.pageData.siteInfo.getStreet() />
				<cfset LOCAL.pageData.formData.city = LOCAL.pageData.siteInfo.getCity() />
				<cfset LOCAL.pageData.formData.province_id = LOCAL.pageData.siteInfo.getProvince().getProvinceId() />
				<cfset LOCAL.pageData.formData.country_id = LOCAL.pageData.siteInfo.getCountry().getCountryId() />
				<cfset LOCAL.pageData.formData.postal_code = LOCAL.pageData.siteInfo.getPostalCode() />
				<cfset LOCAL.pageData.formData.phone = LOCAL.pageData.siteInfo.getPhone() />
				<cfset LOCAL.pageData.formData.email = LOCAL.pageData.siteInfo.getEmail() />
				<cfset LOCAL.pageData.formData.map = isNull(LOCAL.pageData.siteInfo.getMap())?"":LOCAL.pageData.siteInfo.getMap() />
			<cfelse>
				<cfset LOCAL.pageData.formData.name = "" />
				<cfset LOCAL.pageData.formData.unit = "" />
				<cfset LOCAL.pageData.formData.street = "" />
				<cfset LOCAL.pageData.formData.city = "" />
				<cfset LOCAL.pageData.formData.province_id = "" />
				<cfset LOCAL.pageData.formData.country_id = "" />
				<cfset LOCAL.pageData.formData.postal_code = "" />
				<cfset LOCAL.pageData.formData.phone = "" />
				<cfset LOCAL.pageData.formData.email = "" />
				<cfset LOCAL.pageData.formData.map = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>