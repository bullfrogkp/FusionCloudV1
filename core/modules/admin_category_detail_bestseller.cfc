<cfcomponent extends="core.modules.module">	
    <cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.bestSellers = EntityLoad("page_section", {name="best seller",page="category_detail"},true)> 
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>