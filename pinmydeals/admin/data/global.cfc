<cfcomponent extends="core.pages.page">
	<!------------------------------------------------------------------------------->	
	<cffunction name="validateAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif NOT StructKeyExists(SESSION,"adminUser") AND getPageName() NEQ "login">
			<cfset LOCAL.redirectUrl = "login.cfm" />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="processURLDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
			
		<cfif StructKeyExists(URL,"logout")>
			<cfset StructDelete(SESSION,"adminUser") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/index.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	<!------------------------------------------------------------------------------->	
</cfcomponent>