<cfcomponent output="false" accessors="true">
	<cfproperty name="formData" type="struct" required="false"> 
	<cfproperty name="urlData" type="struct" required="false"> 
	<cfproperty name="cgiData" type="struct" required="false"> 
	<cfproperty name="sessionData" type="struct" required="false"> 
	<cfproperty name="pageName" type="string" required="false"> 
	<!------------------------------------------------------------------------------->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="formData" type="struct" required="false" />
		<cfargument name="urlData" type="struct" required="false" />
		<cfargument name="cgiData" type="struct" required="false" />
		<cfargument name="sessionData" type="struct" required="false" />
		<cfargument name="pageName" type="string" required="false" />
		
		<cfif StructKeyExists(ARGUMENTS,"formData")>
			<cfset setFormData(ARGUMENTS.formData) />
		</cfif>
		
		<cfif StructKeyExists(ARGUMENTS,"urlData")>
			<cfset setUrlData(ARGUMENTS.urlData) />
		</cfif>
		
		<cfif StructKeyExists(ARGUMENTS,"cgiData")>
			<cfset setCgiData(ARGUMENTS.cgiData) />
		</cfif>
		
		<cfif StructKeyExists(ARGUMENTS,"sessionData")>
			<cfset setSessionData(ARGUMENTS.sessionData) />
		</cfif>
		
		<cfif StructKeyExists(ARGUMENTS,"pageName")>
			<cfset setPageName(ARGUMENTS.pageName) />
		</cfif>
		
		<cfreturn this />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfreturn LOCAL />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="validateFormData" access="remote" output="false" returnType="struct" returnformat="json">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.isValid = true />
		<cfset LOCAL.retStruct.messageArray = [] />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="processFormData" access="remote" output="false" returnType="struct" returnformat="json">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.isValid = true />
		<cfset LOCAL.retStruct.messageArray = [] />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>