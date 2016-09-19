<cfcomponent extends="core.pages.page">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Products | #APPLICATION.applicationName#" />
		
		<cfset LOCAL.productService = new "#APPLICATION.componentPathRoot#core.services.productService"() />
		<cfset LOCAL.categoryService = new "#APPLICATION.componentPathRoot#core.services.categoryService"() />
				
		<cfset LOCAL.productService.setRecordsPerPage(APPLICATION.recordsPerPage) />
		<cfset LOCAL.productService.setIsDeleted(false) />
		<cfset LOCAL.productService.setSortTypeId(1) />
		<cfset LOCAL.productService.setProductTypeList("single,configurable") />
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.productService.setProductId(URL.id) />
		</cfif>
		<cfif StructKeyExists(URL,"is_enabled") AND IsNumeric(URL.is_enabled)>
			<cfset LOCAL.productService.setIsEnabled(URL.is_enabled) />
		</cfif>
		<cfif StructKeyExists(URL,"search_keyword") AND Trim(URL.search_keyword) NEQ "">
			<cfset LOCAL.productService.setSearchKeywords(Trim(URL.search_keyword)) />
		</cfif>
		
		<cfif StructKeyExists(URL,"page") AND IsNumeric(Trim(URL.page))>
			<cfset LOCAL.productService.setPageNumber(Trim(URL.page)) />
		</cfif>
		
		<cfset LOCAL.recordStruct = LOCAL.productService.getRecords() />
		<cfset LOCAL.pageData.paginationInfo = _getPaginationInfo(LOCAL.recordStruct) />
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>