﻿<cfcomponent extends="core.pages.page">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Orders | #APPLICATION.applicationName#" />
		
		<cfset LOCAL.orderService = new "core.services.orderService"() />
		<cfset LOCAL.orderService.setRecordsPerPage(APPLICATION.recordsPerPage) />
		<cfset LOCAL.orderService.setIsDeleted(false) />
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.orderService.setId(URL.id) />
		</cfif>
		<cfif StructKeyExists(URL,"is_enabled") AND IsNumeric(URL.is_enabled)>
			<cfset LOCAL.orderService.setIsEnabled(URL.is_enabled) />
		</cfif>
		<cfif StructKeyExists(URL,"search_keyword") AND Trim(URL.search_keyword) NEQ "">
			<cfset LOCAL.orderService.setSearchKeywords(Trim(URL.search_keyword)) />
		</cfif>
		
		<cfif StructKeyExists(URL,"page") AND IsNumeric(Trim(URL.page))>
			<cfset LOCAL.orderService.setPageNumber(Trim(URL.page)) />
		</cfif>
		
		<cfset LOCAL.recordStruct = LOCAL.orderService.getRecords() />
		<cfset LOCAL.pageData.paginationInfo = _getPaginationInfo(LOCAL.recordStruct) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>