<cfcomponent output="false" accessors="true">
	<cfproperty name="shippingMethodId" type="numeric"> 
	<cfproperty name="productId" type="numeric"> 
    <cfproperty name="address" type="struct"> 
	<!------------------------------------------------------------------------------->
	<cffunction name="getShippingFee" access="public" returntype="numeric">
		<cfset var LOCAL = {} />
		<cfset LOCAL.rate = 0 />
		<cfreturn LOCAL.rate />
	</cffunction>	
	<!------------------------------------------------------------------------------->
</cfcomponent>