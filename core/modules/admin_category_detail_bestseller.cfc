<cfcomponent extends="core.modules.module">	
    <cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.products = EntityLoad("module_admin_category_detail_bestseller", {category=EntityLoadByPK("category",getUrlData().id)})>  
		<cfset LOCAL.retStruct.javascript = "good"> 
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>