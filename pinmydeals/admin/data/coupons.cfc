<cfcomponent extends="core.pages.page">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Coupons | #APPLICATION.applicationName#" />
		
		<cfset LOCAL.couponService = new "#APPLICATION.componentPathRoot#core.services.couponService"() />
		<cfset LOCAL.couponService.setRecordsPerPage(APPLICATION.recordsPerPage) />
		<cfset LOCAL.couponService.setIsDeleted(false) />
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.couponService.setId(URL.id) />
		</cfif>
		<cfif StructKeyExists(URL,"is_enabled") AND IsNumeric(URL.is_enabled)>
			<cfset LOCAL.couponService.setIsEnabled(URL.is_enabled) />
		</cfif>
		<cfif StructKeyExists(URL,"search_keyword") AND Trim(URL.search_keyword) NEQ "">
			<cfset LOCAL.couponService.setSearchKeywords(Trim(URL.search_keyword)) />
		</cfif>
		
		<cfif StructKeyExists(URL,"page") AND IsNumeric(Trim(URL.page))>
			<cfset LOCAL.couponService.setPageNumber(Trim(URL.page)) />
		</cfif>
		
		<cfset LOCAL.recordStruct = LOCAL.couponService.getRecords() />
		<cfset LOCAL.pageData.paginationInfo = _getPaginationInfo(LOCAL.recordStruct) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>