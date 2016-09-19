<cfcomponent output="false">
	<cffunction name="getUser" access="public" returntype="struct">
	    <cfset var LOCAL = {} />
		<cfset var defaultCustomerGroup = EntityLoad("customer_group",{isDefault = true},true) />
		
		<cfset LOCAL.userName = CGI.REMOTE_ADDR />
		<cfset LOCAL.customerGroupName = defaultCustomerGroup.getName() />
		<cfset LOCAL.customerGroupId = defaultCustomerGroup.getCustomerGroupId() />
	   
		<cfreturn LOCAL />
	</cffunction>
</cfcomponent>