<cfcomponent extends="core.pages.page">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Filters | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.filters = EntityLoad("filter",{isDeleted = false}) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>