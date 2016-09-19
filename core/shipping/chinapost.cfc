<cfcomponent output="false" accessors="true">
	<!------------------------------------------------------------------------------->
	<cffunction name="getShippingMethodsArray" access="public" returntype="array">
		<cfargument name="toAddress" type="struct" required="true">
		<cfargument name="productId" type="numeric" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		<cfargument name="shippingCarrierId" type="numeric" required="true">
		<cfargument name="productShippingCarrierRelaId" type="numeric" required="true">
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.shippingMethods = [] />
			
		<cfset LOCAL.productShippingCarrierRela = EntityLoadByPK("product_shipping_carrier_rela",ARGUMENTS.productShippingCarrierRelaId) />
		
		<cfset LOCAL.shippingMethod = EntityLoad("shipping_method",{shippingCarrier = LOCAL.productShippingCarrierRela.getShippingCarrier(), isDefault = true},true) />
		<cfset LOCAL.currency = EntityLoadByPK("currency",ARGUMENTS.currencyId) />
		
		<cfset LOCAL.shippingMethodStruct = {} />
		<cfset LOCAL.shippingMethodStruct.shippingMethodId = LOCAL.shippingMethod.getShippingMethodId() />
		<cfset LOCAL.shippingMethodStruct.name = LOCAL.shippingMethod.getDisplayName() />
		<cfif LOCAL.productShippingCarrierRela.getUseDefaultPrice() EQ true>
			<cfset LOCAL.shippingMethodStruct.price = NumberFormat(LOCAL.productShippingCarrierRela.getPrice() * LOCAL.currency.getMultiplier(),"0.00") />
		<cfelse>
			<cfset LOCAL.shippingMethodStruct.price = 0 />
		</cfif>
		<cfset LOCAL.shippingMethodStruct.description = LOCAL.shippingMethod.getDescription() />
		
		<cfset ArrayAppend(LOCAL.shippingMethods, LOCAL.shippingMethodStruct) />
		
		<cfreturn LOCAL.shippingMethods />
	</cffunction>	
	<!------------------------------------------------------------------------------->
</cfcomponent>