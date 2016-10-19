<cfcomponent output="false" accessors="true">
	<!------------------------------------------------------------------------------------------------------------>
	<cffunction name="validate" access="remote" returntype="struct" returnformat="json" output="false">
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageObj = new "siteAdmin.data.#FORM.pageName#"() />
		<cfset LOCAL.pageObj.validate() />
		
		<cfreturn "true">
	</cffunction>
	<!------------------------------------------------------------------------------------------------------------>
	<cffunction name="process" access="remote" returntype="struct" returnformat="json" output="false">
		
		<cfreturn "true">
	</cffunction>
	<!------------------------------------------------------------------------------------------------------------>
</cfcomponent>