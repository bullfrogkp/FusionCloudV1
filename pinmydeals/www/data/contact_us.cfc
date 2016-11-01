<cfcomponent extends="core.pages.page">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"send_message")>
			<cfif Trim(FORM.contact_name) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your name.") />
			</cfif>
			
			<cfif NOT IsValid("email",Trim(FORM.contact_email))>
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid email address.") />
			</cfif>
			
			<cfif Trim(FORM.contact_message) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your message.") />
			</cfif>
			
			<cfif ArrayLen(LOCAL.messageArray) GT 0>
				<cfset SESSION.temp.message = {} />
				<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
				<cfset SESSION.temp.message.messageType = "alert-danger" />
				<cfset LOCAL.redirectUrl = _setRedirectURL() />
			</cfif>
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<!--- send internal email --->
		<cfset LOCAL.emailService = new "core.services.emailService"() />
		<cfset LOCAL.emailService.setFromEmail(APPLICATION.emailCustomerService) />
		<cfset LOCAL.emailService.setToEmail(APPLICATION.emailCustomerService) />
		<cfset LOCAL.emailService.setContentName("contact us internal") />
		
		<cfset LOCAL.replaceStruct = {} />
		<cfset LOCAL.replaceStruct.name = Trim(FORM.contact_name) />
		<cfset LOCAL.replaceStruct.email = Trim(FORM.contact_email) />
		<cfset LOCAL.replaceStruct.message = Trim(FORM.contact_message) />
		
		<cfset LOCAL.emailService.setReplaceStruct(LOCAL.replaceStruct) />
		<cfset LOCAL.emailService.sendEmail() />
		
		<!--- send customer copy --->
		<cfset LOCAL.emailService = new "core.services.emailService"() />
		<cfset LOCAL.emailService.setFromEmail(APPLICATION.emailCustomerService) />
		<cfset LOCAL.emailService.setToEmail(Trim(FORM.contact_email)) />
		<cfset LOCAL.emailService.setContentName("contact us external") />
		
		<cfset LOCAL.replaceStruct = {} />
		<cfset LOCAL.replaceStruct.name = Trim(FORM.contact_name) />
		<cfset LOCAL.replaceStruct.message = Trim(FORM.contact_message) />
		
		<cfset LOCAL.emailService.setReplaceStruct(LOCAL.replaceStruct) />
		<cfset LOCAL.emailService.sendEmail() />
		
		<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin#contact_us_email_sent.cfm" />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Contact Us | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>