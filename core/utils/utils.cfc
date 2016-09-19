<cfcomponent output="false">
	<cffunction name="handleError" access="public" returntype="void" output="false">
		<cfargument type="any" name="cfcatch" required=true /> 
		
		<cfset var errorString = "" />
		<cfset var exceptionString = "" />
		<cfset var sessionString = "" />
			
		<cfif IsDefined("SESSION")>
			<cfinvoke component="#APPLICATION.componentPathRoot#core.utils" method="struct2string" returnvariable="sessionString">
				<cfinvokeargument name="inputStruct" value="#SESSION#">
			</cfinvoke>
		</cfif>

		<cfinvoke component="#APPLICATION.componentPathRoot#core.utils" method="exception2string" returnvariable="exceptionString">
			<cfinvokeargument name="ex" value="#cfcatch#">
		</cfinvoke>
		
		<cfset errorString = exceptionString & session_string />
		
		<cflog text="#errorString#" />
		
		<cfif cfcatch.type NEQ "urlSrror">
			<cfinvoke component="#APPLICATION.componentPathRoot#core.utils.email" method="sendDirectEmail">
				<cfinvokeargument name="fromEmail" value="#APPLICATION.emailDevelopment#">
				<cfinvokeargument name="toEmail" value="#APPLICATION.emailAdmin#">
				<cfinvokeargument name="emailSubject" value="Exception">
				<cfinvokeargument name="emailContent" value="#errorString#">
				<cfinvokeargument name="emailType" value="text">
			</cfinvoke>	
		</cfif>
	</cffunction>
</cfcomponent>