<cfcomponent extends="core.pages.page">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Discount Types | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.discountTypes = EntityLoad("discount_type",{isDeleted = false}) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>