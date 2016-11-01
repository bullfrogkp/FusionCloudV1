<cfcomponent extends="core.pages.page">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"send_email")>
			<cfif NOT IsValid("email",Trim(FORM.email))>
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid email.") />
			<cfelse>
				<cfset LOCAL.customer = EntityLoad("customer",{email=Trim(FORM.email),isEnabled=true,isDeleted=false},true) />
				<cfif IsNull(LOCAL.customer)>
					<cfset ArrayAppend(LOCAL.messageArray,"Sorry we cannot find the customer with the email: #Trim(FORM.email)#.") />
				</cfif>
			</cfif>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset SESSION.temp.message.messageType = "alert-danger" />
			<cfset LOCAL.redirectUrl = getCgiData().SCRIPT_NAME />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Password Assistance | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfif StructKeyExists(FORM,"send_email")>
			<cfset LOCAL.customer = EntityLoad("customer",{email=Trim(FORM.email),isEnabled=true,isDeleted=false},true) />
			
			<cfset LOCAL.emailService = new "core.services.emailService"() />
			<cfset LOCAL.emailService.setFromEmail(APPLICATION.emailCustomerService) />
			<cfset LOCAL.emailService.setToEmail(Trim(FORM.email)) />
			<cfset LOCAL.emailService.setContentName("reset password") />
			
			<cfset LOCAL.replaceStruct = {} />
			<cfset LOCAL.replaceStruct.customerName = LOCAL.customer.getFirstname() />
			
			<cfset LOCAL.linkType = EntityLoad("link_type",{name="reset password"},true) />
			<cfset LOCAL.linkStatusType = EntityLoad("link_status_type",{name="active"},true) />
			<cfset LOCAL.linkUUID = CreateUUID() />
			<cfset LOCAL.link = EntityNew("link") />
			<cfset LOCAL.link.setLinkType(LOCAL.linkType) />
			<cfset LOCAL.link.setLinkStatusType(LOCAL.linkStatusType) />
			<cfset LOCAL.link.setUUID(LOCAL.linkUUID) />
			<cfset LOCAL.link.setCustomer(LOCAL.customer) />
			<cfset EntitySave(LOCAL.link) />
			
			<cfset LOCAL.replaceStruct.uuid = LOCAL.linkUUID />
			
			<cfset LOCAL.emailService.setReplaceStruct(LOCAL.replaceStruct) />
			<cfset LOCAL.emailService.sendEmail() />
		
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin#email_sent.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>