<cfcomponent extends="core.pages.page">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "View History | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.categoryService = new "core.services.categoryService"() />
		<cfset LOCAL.pageData.trackingRecords = new "core.services.trackingService"(cfid = COOKIE.cfid, cftoken = COOKIE.cftoken).getTrackingRecords(trackingRecordType = "history") />
		<cfset LOCAL.pageData.subCategoryTree = LOCAL.categoryService.getCategoryTree(isSpecial = false) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>