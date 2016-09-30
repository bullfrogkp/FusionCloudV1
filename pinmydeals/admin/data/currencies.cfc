<cfcomponent extends="core.pages.page">	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Currencies | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.currencies = EntityLoad("currency",{isDeleted = false}) /> />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>