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
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#index.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	<!------------------------------------------------------------------------------->	
	<cffunction name="_loadModuleData" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.site = EntityLoad("site", {name = APPLICATION.applicationName}, true) />
		<cfset LOCAL.modules = EntityLoad("site_module",{site = LOCAL.site, isDeleted = false, isEnabled = true}) />
		
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.moduleObj = new "core.modules.#LOCAL.module.getName()#"(formData = getFormData(), urlData = getUrlData(), cgiData = getCgiData(), sessionData = getSessionData()) />
			<cfset StructInsert(LOCAL.retStruct, LOCAL.module.getName(), LOCAL.moduleObj.getData()) />
		</cfloop>
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="_loadModuleView" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.site = EntityLoad("site", {name = APPLICATION.applicationName}, true) />
		<cfset LOCAL.modules = EntityLoad("site_module",{site = LOCAL.site, isDeleted = false, isEnabled = true}) />
		
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.moduleObj = new "core.modules.#LOCAL.module.getName()#"(formData = getFormData(), urlData = getUrlData(), cgiData = getCgiData(), sessionData = getSessionData()) />
			<cfset StructInsert(LOCAL.retStruct, LOCAL.module.getName(), LOCAL.moduleObj.getView()) />
		</cfloop>
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->	
</cfcomponent>