<cfcomponent extends="core.pages.page">
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Dashboard | #APPLICATION.applicationName#" />
		
		<cfset LOCAL.pageData.newOrders = EntityLoad("order",{isNew = true, isDeleted = false}, "createdDatetime Desc") />
		<cfset LOCAL.pageData.newCustomers = EntityLoad("customer",{isNew = true, isDeleted = false}, "createdDatetime Desc") />
		<cfset LOCAL.pageData.newReviews = EntityLoad("review",{isNew = true, isDeleted = false}, "createdDatetime Desc") />
		
		<cfset LOCAL.pageData.LastestOrders = EntityLoad("order",{isDeleted = false, isComplete = true}, "createdDatetime Desc", {maxResults=10}) />
		<cfset LOCAL.pageData.LastestReviews = EntityLoad("review",{}, "createdDatetime Desc", {maxResults=10}) />
		<cfset LOCAL.pageData.topViewedProducts = EntityLoad("product",{isDeleted = false}, "viewCount Desc", {maxResults=10}) />
		<cfset LOCAL.pageData.bestSellerProducts = EntityLoad("product",{isDeleted = false}, "soldCount Desc", {maxResults=10}) />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>