<cfcomponent extends="core.pages.page">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		<cfset LOCAL.pageData.title = "Thank you | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>