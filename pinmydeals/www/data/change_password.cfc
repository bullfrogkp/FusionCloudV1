<cfcomponent extends="core.pages.page">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"update_password")>
			<cfif Trim(FORM.current_password) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your current password.") />
			</cfif>
			<cfif Trim(FORM.new_password) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your new password.") />
			</cfif>
			<cfif Trim(FORM.confirm_new_password) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please confirm your new password.") />
			</cfif>
			<cfif Trim(FORM.new_password) NEQ "" AND Trim(FORM.confirm_new_password) NEQ "" AND Trim(FORM.new_password) NEQ Trim(FORM.confirm_new_password)>
				<cfset ArrayAppend(LOCAL.messageArray,"Passwords don't match.") />
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
	<!----------------------------------------------------------------------------------------------------------------------------------------------------->
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Change Password | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.customer = EntityLoadByPK("customer",SESSION.user.customerId) />
		
		<cfif IsDefined("SESSION.temp.message") AND NOT ArrayIsEmpty(SESSION.temp.message.messageArray)>
			<cfset LOCAL.pageData.message.messageArray = SESSION.temp.message.messageArray />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<!----------------------------------------------------------------------------------------------------------------------------------------------------->
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.customer = EntityLoadByPK("customer",SESSION.user.customerId) />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(FORM,"update_password")>
			<cfset LOCAL.messageArray = [] />
			<cfset LOCAL.customer = EntityLoad("customer",{customerId = SESSION.user.customerId, password = Hash(Trim(FORM.current_password)), isEnabled = true, isDeleted = false}, true) /> />
			<cfif IsNull(LOCAL.customer)>
				<cfset ArrayAppend(LOCAL.messageArray,"Password is not correct.") />
			<cfelse>
				<cfset LOCAL.customer.setPassword(Hash(Trim(FORM.new_password))) />
				<cfset EntitySave(LOCAL.customer) />
				
				<cfset ArrayAppend(LOCAL.messageArray,"Your password has been updated") />
			</cfif>
			<cfif ArrayLen(LOCAL.messageArray) GT 0>
				<cfset SESSION.temp.message = {} />
				<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			</cfif>
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>