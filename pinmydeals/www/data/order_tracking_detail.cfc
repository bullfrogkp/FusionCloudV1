<cfcomponent extends="core.pages.page">	
	<cffunction name="validateAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif IsNull(SESSION.temp.orderId)>
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#order_tracking.cfm" />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Order Tracking Detail | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.order = EntityLoadByPK("order",SESSION.temp.orderId) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>