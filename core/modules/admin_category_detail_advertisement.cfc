﻿<cfcomponent extends="core.modules.module">	
    <cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.products = EntityLoad("module_admin_category_detail_advertisement", {category=EntityLoadByPK("category",getUrlData().id)})> 
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>