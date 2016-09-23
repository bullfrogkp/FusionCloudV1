<cfcomponent>
	<cffunction name="sendRequest" access="remote" returntype="string" output="false">
		<cfargument name="contact_name" type="string" required="true">
		<cfargument name="contact_phone" type="string" required="true">
		<cfargument name="contact_email" type="string" required="true">
		<cfargument name="user" type="string" required="true">
		<cfargument name="contact_message" type="string" required="false" default="">
		 
		<cfset var LOCAL = {} />
		<cfset var LOCAL.ret_val = "0" />
		
		<cfif IsValid("email",ARGUMENTS.contact_email) AND Trim(ARGUMENTS.contact_phone) NEQ "" AND Trim(ARGUMENTS.contact_name) NEQ "">
			<cfinvoke component="admin.core.utils.email" method="sendDirectEmail">
				<cfinvokeargument name="from_email" value="#APPLICATION.email_info#">
				<cfinvokeargument name="to_email" value="#APPLICATION.email_info#">
				<cfinvokeargument name="email_subject" value="客户咨询 (#Trim(ARGUMENTS.contact_name)#:#Trim(ARGUMENTS.contact_phone)#)">
				<cfinvokeargument name="email_content" value="#Trim(ARGUMENTS.contact_email)#<br/>#Trim(ARGUMENTS.contact_message)#">
				<cfinvokeargument name="email_type" value="html">
			</cfinvoke>
			<cfset LOCAL.ret_val = "1" />
		</cfif>
						
		<cfreturn LOCAL.ret_val /> 
	</cffunction>
</cfcomponent>