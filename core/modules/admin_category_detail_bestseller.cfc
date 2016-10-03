<cfcomponent extends="core.modules.module">	
    <cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.bestSellerSection = [] />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>