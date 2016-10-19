<cfcomponent output="false" accessors="true">
	<!------------------------------------------------------------------------------------------------------------>
	<cffunction name="validate" access="remote" returntype="struct" returnformat="json" output="false">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageObj = new "siteData.#FORM.pageName#"().init(FORM) />
		<cfset LOCAL.result = LOCAL.pageObj.validate() />
		
		<cfset LOCAL.modules = EnityLoad("page_module", {pageName = FORM.pageName, result = LOCAL.result}) />
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.result = LOCAL.pageObj.validate() />
		</cfloop>
		
		<cfreturn LOCAL.result>
	</cffunction>
	<!------------------------------------------------------------------------------------------------------------>
	<cffunction name="process" access="remote" returntype="struct" returnformat="json" output="false">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageObj = new "siteData.#FORM.pageName#"().init(FORM) />
		<cfset LOCAL.result = LOCAL.pageObj.process() />
	
		<cfset LOCAL.modules = EnityLoad("page_module", {pageName = FORM.pageName, result = LOCAL.result}) />
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.result = LOCAL.pageObj.process() />
		</cfloop>
		
		<cfreturn LOCAL.result>
	</cffunction>
	<!------------------------------------------------------------------------------------------------------------>
</cfcomponent>