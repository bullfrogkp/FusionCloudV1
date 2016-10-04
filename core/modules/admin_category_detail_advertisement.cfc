<cfcomponent extends="core.modules.module">	
    <cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.products = EntityLoad("admin_category_detail_advertisement", {category=EntityLoadByPK("category",getUrlData().category_id))> 
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>