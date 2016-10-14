<cfcomponent restpath="category" rest="true">
	<cffunction name="get"
				access="remote"
				httpmethod="GET"
				restpath="{categoryID}"
				returntype="any"
				produces="application/json">
					
		<cfargument name="categoryID"
					required="true"
					restargsource="Path"
					type="numeric"/>

		<cfset var LOCAL = {} />
		<cfset LOCAL.category = EntityLoadByPK("category", ARGUMENTS.categoryID) />
		
		<cfreturn LOCAL.category>
	</cffunction> 
	
	<cffunction name="add"
				access="remote"
				httpmethod="POST"
				restpath="{categoryID}"
				returntype="any"
				produces="application/json">
					
		<cfargument name="categoryID"
					required="true"
					restargsource="Form"
					type="numeric"/>

		<cfset var LOCAL = {} />
		<cfset LOCAL.category = EntityLoadByPK("category", ARGUMENTS.categoryID) />
		
		<cfreturn LOCAL.category>
	</cffunction> 
</cfcomponent>