<cfcomponent extends="core.pages.page">	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Filter Groups | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.filterGroups = EntityLoad("filter_group",{isDeleted = false}) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>