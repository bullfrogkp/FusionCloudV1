<cfcomponent extends="core.pages.page">	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Product Groups | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.productGroups = EntityLoad("product_group",{isDeleted = false}) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>