<cfcomponent output="false" accessors="true">
	<cfproperty name="pageName" type="string" required="true"> 
	<cfproperty name="formData" type="struct" required="true"> 
	<cfproperty name="urlData" type="struct" required="true"> 
	<cfproperty name="cgiData" type="struct" required="true"> 
	<cfproperty name="sessionData" type="struct" required="true"> 
	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="pageName" type="string" required="true" />
		<cfargument name="formData" type="struct" required="true" />
		<cfargument name="urlData" type="struct" required="true" />
		<cfargument name="cgiData" type="struct" required="true" />
		<cfargument name="sessionData" type="struct" required="true" />
		
		<cfset setPageName(ARGUMENTS.pageName) />
		<cfset setFormData(ARGUMENTS.formData) />
		<cfset setUrlData(ARGUMENTS.urlData) />
		<cfset setCgiData(ARGUMENTS.cgiData) />
		<cfset setSessionData(ARGUMENTS.sessionData) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getFrontendData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfreturn LOCAL />
	</cffunction>

	<cffunction name="getBackendData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="getFrontendView" access="public" output="false" returnType="string">
		<cfreturn "" />
	</cffunction>

	<cffunction name="getBackendView" access="public" output="false" returnType="string">
		<cfreturn "" />
	</cffunction>
	
	<cffunction name="processFrontendModuleFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="processBackendModuleFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>
</cfcomponent>