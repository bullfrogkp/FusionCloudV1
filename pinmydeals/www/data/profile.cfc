<cfcomponent extends="core.pages.page">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Profile | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		<!---
		<cfset LOCAL.pageData.customer = EntityLoadByPK("customer",SESSION.user.customerId) />
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.first_name = isNull(LOCAL.pageData.customer.getFirstName())?"":LOCAL.pageData.customer.getFirstName() />
			<cfset LOCAL.pageData.formData.middle_name = isNull(LOCAL.pageData.customer.getMiddleName())?"":LOCAL.pageData.customer.getMiddleName() />
			<cfset LOCAL.pageData.formData.last_name = isNull(LOCAL.pageData.customer.getLastName())?"":LOCAL.pageData.customer.getLastName() />
			<cfset LOCAL.pageData.formData.email = isNull(LOCAL.pageData.customer.getEmail())?"":LOCAL.pageData.customer.getEmail() />
			<cfset LOCAL.pageData.formData.phone = isNull(LOCAL.pageData.customer.getPhone())?"":LOCAL.pageData.customer.getPhone() />
			<cfset LOCAL.pageData.formData.date_of_birth = isNull(LOCAL.pageData.customer.getDateOfBirth())?"":LOCAL.pageData.customer.getDateOfBirth() />
			<cfset LOCAL.pageData.formData.company = isNull(LOCAL.pageData.customer.getCompany())?"":LOCAL.pageData.customer.getCompany() />
			<cfset LOCAL.pageData.formData.website = isNull(LOCAL.pageData.customer.getWebsite())?"":LOCAL.pageData.customer.getWebsite() />
			<cfset LOCAL.pageData.formData.subscribed = isNull(LOCAL.pageData.customer.getSubscribed())?"":LOCAL.pageData.customer.getSubscribed() />
		</cfif>
		--->
		<cfreturn LOCAL.pageData />	
	</cffunction>
	<!----------------------------------------------------------------------------------------------------------------------------------------------------->
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfif StructKeyExists(FORM,"update_profile")>
			<cfset LOCAL.customer = EntityLoadByPK("customer",SESSION.user.customerId) />
			<cfset LOCAL.customer.setFirstName(Trim(FORM.first_name)) />
			<cfset LOCAL.customer.setMiddleName(Trim(FORM.middle_name)) />
			<cfset LOCAL.customer.setLastName(Trim(FORM.last_name)) />
			<cfset LOCAL.customer.setPhone(Trim(FORM.phone)) />
			<cfset LOCAL.customer.setWebsite(Trim(FORM.website)) />
			<cfset LOCAL.customer.setCompany(Trim(FORM.company)) />
			<cfset LOCAL.customer.setDateOfBirth(Trim(FORM.date_of_birth)) />
			<cfset LOCAL.customer.setUpdatedUser(SESSION.user.userName) />
			<cfset LOCAL.customer.setUpdatedDatetime(Now()) />
			<cfif StructKeyExists(FORM,"subscribed")>
				<cfset LOCAL.customer.setSubscribed(true) />
			<cfelse>
				<cfset LOCAL.customer.setSubscribed(false) />
			</cfif>
			<cfset EntitySave(LOCAL.customer) />
		</cfif>
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#myaccount/profile.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>