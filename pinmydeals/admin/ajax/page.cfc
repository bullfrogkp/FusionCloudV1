<cfcomponent output="false" accessors="true">
	<!------------------------------------------------------------------------------------------------------------>
	<cffunction name="validateFormData" access="remote" returntype="struct" returnformat="json" output="false">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageObj = new "siteDataAdmin.#FORM.pageName#"().init(FORM) />
		<cfset LOCAL.result = LOCAL.pageObj.validateFormData() />
		
		<cfset LOCAL.modules = EntityLoad("page_module", {page = EntityLoad("page",{name = FORM.pageName}, true)}) />
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.moduleResult = LOCAL.pageObj.validateFormData() />
			<cfset LOCAL.result.isValid = LOCAL.moduleResult.isValid />
			<cfset ArrayAppend(LOCAL.result.messageArray, LOCAL.moduleResult.messageArray, true) />
		</cfloop>
		
		<cfreturn LOCAL.result>
	</cffunction>
	<!------------------------------------------------------------------------------------------------------------>
	<cffunction name="processFormData" access="remote" returntype="struct" returnformat="json" output="false">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageObj = new "siteDataAdmin.#FORM.pageName#"().init(FORM) />
		<cfset LOCAL.result = LOCAL.pageObj.processFormData() />
	
		<cfset LOCAL.modules = EntityLoad("page_module", {page = EntityLoad("page",{name = FORM.pageName}, true), result = LOCAL.result}) />
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.result = LOCAL.pageObj.processFormData() />
		</cfloop>
		
		<cfreturn LOCAL.result>
	</cffunction>
	<!------------------------------------------------------------------------------------------------------------>
</cfcomponent>