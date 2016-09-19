<cfcomponent>
	<cffunction name="sendRequest" access="remote" returntype="string" output="false">
		<cfargument name="contactName" type="string" required="true">
		<cfargument name="contactPhone" type="string" required="true">
		<cfargument name="contactEmail" type="string" required="true">
		<cfargument name="user" type="string" required="true">
		<cfargument name="contactMessage" type="string" required="false" default="">
		 
		<cfset var LOCAL = {} />
		<cfset var LOCAL.retVal = "0" />
		
		<cfif IsValid("email",ARGUMENTS.contactEmail) AND Trim(ARGUMENTS.contactPhone) NEQ "" AND Trim(ARGUMENTS.contactName) NEQ "">
		
			<cfset sendDirectEmail(	fromEmail = APPLICATION.customerServiceEmail
								,	toEmail = APPLICATION.customerServiceEmail
								,	emailSubject = "(#Trim(ARGUMENTS.contactName)#:#Trim(ARGUMENTS.contactPhone)#)"
								,	emailContent = Trim(ARGUMENTS.contactMessage)
								,	emailType = "html") />							
			<cfset LOCAL.retVal = "1" />
		</cfif>
						
		<cfreturn LOCAL.retVal /> 
	</cffunction>
	
	<cffunction name="sendDirectEmail" access="public" returntype="void">
	    <cfargument name="fromEmail" type="string" required="true" />
	    <cfargument name="toEmail" type="string" required="true" />
		<cfargument name="emailSubject" type="string" required="true" />
		<cfargument name="emailContent" type="string" required="true" />
		<cfargument name="emailType" type="string" required="true" />
				
		<cfmail from="#Trim(ARGUMENTS.fromEmail)#" 
				to="#Trim(ARGUMENTS.toEmail)#" 
				type="#ARGUMENTS.emailType#"
				subject="#Trim(ARGUMENTS.emailSubject)#">#Trim(ARGUMENTS.emailContent)#</cfmail>
		
	</cffunction>
</cfcomponent>