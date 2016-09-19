<cfcomponent extends="core.pages.page">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Orders | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.customer = EntityLoadByPK("customer",SESSION.user.customerId) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>