<cfcomponent extends="core.pages.page">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Categories | #APPLICATION.applicationName#" />
		
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
		<cfset LOCAL.categoryService.setRecordsPerPage(APPLICATION.recordsPerPage) />
		<cfset LOCAL.categoryService.setIsDeleted(false) />
		<cfif StructKeyExists(URL,"category_id") AND IsNumeric(URL.category_id)>
			<cfset LOCAL.categoryService.setId(URL.category_id) />
		</cfif>
		<cfif StructKeyExists(URL,"is_enabled") AND IsNumeric(URL.is_enabled)>
			<cfset LOCAL.categoryService.setIsEnabled(URL.is_enabled) />
		</cfif>
		<cfif StructKeyExists(URL,"search_keyword") AND Trim(URL.search_keyword) NEQ "">
			<cfset LOCAL.categoryService.setSearchKeywords(Trim(URL.search_keyword)) />
		</cfif>
		
		<cfif StructKeyExists(URL,"page") AND IsNumeric(Trim(URL.page))>
			<cfset LOCAL.categoryService.setPageNumber(Trim(URL.page)) />
		</cfif>
		
		<cfset LOCAL.recordStruct = LOCAL.categoryService.getRecords() />
		<cfset LOCAL.pageData.paginationInfo = _getPaginationInfo(LOCAL.recordStruct) /> 
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>