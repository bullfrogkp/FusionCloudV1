<cfcomponent output="false">
	<!------------------------------------------------------------------------------------------------------------>
	<cffunction name="validateFormData" access="remote" returntype="struct" returnformat="json" output="false">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageObj = new "dataAdmin.#FORM.pageName#"().init(FORM) />
		<cfset LOCAL.result = LOCAL.pageObj.validateFormData() />
		
		<cfset LOCAL.modules = EntityLoad("page_module", {page = EntityLoad("page",{name = FORM.pageName}, true)}) />
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.moduleObj = new "core.modules.#LOCAL.module.getName()#"() />
			<cfset LOCAL.moduleResult = LOCAL.moduleObj.validateFormData() />
			<cfif LOCAL.result.isValid EQ true>
				<cfset LOCAL.result.isValid = LOCAL.moduleResult.isValid />
			</cfif>
			<cfif NOT ArrayIsEmpty(LOCAL.moduleResult.messageArray)>
				<cfset ArrayAppend(LOCAL.result.messageArray, LOCAL.moduleResult.messageArray, true) />
			</cfif>
		</cfloop>
		
		<cfreturn LOCAL.result>
	</cffunction>
	<!------------------------------------------------------------------------------------------------------------>
	<cffunction name="processFormData" access="remote" returntype="struct" returnformat="json" output="false">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageObj = new "dataAdmin.#FORM.pageName#"().init(FORM) />
		<cfset LOCAL.result = LOCAL.pageObj.processFormData() />
	
		<cfset LOCAL.modules = EntityLoad("page_module", {page = EntityLoad("page",{name = FORM.pageName}, true)}) />
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.moduleObj = new "core.modules.#LOCAL.module.getName()#"() />
			<cfset LOCAL.moduleObj.setEntityId(LOCAL.result.id) />
			<cfset LOCAL.moduleResult = LOCAL.moduleObj.processFormData() />
			<cfif LOCAL.result.isValid EQ true>
				<cfset LOCAL.result.isValid = LOCAL.moduleResult.isValid />
			</cfif>
			<cfif NOT ArrayIsEmpty(LOCAL.moduleResult.messageArray)>
				<cfset ArrayAppend(LOCAL.result.messageArray, LOCAL.moduleResult.messageArray, true) />
			</cfif>
		</cfloop>
		
		<cfreturn LOCAL.result>
	</cffunction>
	<!------------------------------------------------------------------------------------------------------------>
</cfcomponent>