<cfcomponent extends="core.pages.page">	
	<cffunction name="_loadPageData" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.site = EntityLoad("site", {name=APPLICATION.applicationName}, true) />
		<cfset LOCAL.page = EntityLoad("page",{name="index", site=LOCAL.site},true) />
		<cfset LOCAL.pageData.title = LOCAL.page.getTitle() />
		<cfset LOCAL.pageData.description = LOCAL.page.getDescription() />
		<cfset LOCAL.pageData.keywords = LOCAL.page.getKeywords() />
				
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>