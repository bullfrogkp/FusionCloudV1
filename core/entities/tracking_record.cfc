<cfcomponent persistent="true"> 
    <cfproperty name="trackingRecordId" column="tracking_record_id" fieldtype="id" generator="native"> 
	<cfproperty name="quantity" column="quantity" ormtype="integer">
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="trackingEntity" fieldtype="many-to-one" cfc="tracking_entity" fkcolumn="tracking_entity_id">
	<cfproperty name="trackingRecordType" fieldtype="many-to-one" cfc="tracking_record_type" fkcolumn="tracking_record_type_id">
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDetailPageURL" access="public" output="false" returnType="string">		
		<cfreturn getProduct().getDetailPageURLMV() />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDefaultImageURL" access="public" output="false" returnType="string">		
		<cfreturn getProduct().getDefaultImageLinkMV(type='small') />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDisplayName" access="public" output="false" returnType="string">		
		<cfreturn getProduct().getDisplayName() />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getPrice" access="public" output="false" returnType="string">
		<cfargument name="customerGroupId" type="numeric" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		
		<cfreturn getProduct().getPrice(customerGroupId = ARGUMENTS.customerGroupId, currencyId = ARGUMENTS.currencyId) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getPriceWCLocal" access="public" output="false" returnType="string">
		<cfargument name="customerGroupId" type="numeric" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		
		<cfset LOCAL.currency = EntityLoadByPK("currency", ARGUMENTS.currencyId) />
		<cfreturn LSCurrencyFormat(getPrice(customerGroupId = ARGUMENTS.customerGroupId, currencyId = ARGUMENTS.currencyId),"local",LOCAL.currency.getLocale()) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getPriceWCInter" access="public" output="false" returnType="string">
		<cfargument name="customerGroupId" type="numeric" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		
		<cfset LOCAL.currency = EntityLoadByPK("currency", ARGUMENTS.currencyId) />
		<cfreturn LSCurrencyFormat(getPrice(customerGroupId = ARGUMENTS.customerGroupId, currencyId = ARGUMENTS.currencyId),"international",LOCAL.currency.getLocale()) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getSubTotal" access="public" output="false" returnType="string">
		<cfargument name="customerGroupId" type="numeric" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		
		<cfreturn getProduct().getPrice(customerGroupId = ARGUMENTS.customerGroupId, currencyId = ARGUMENTS.currencyId) * getQuantity() />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getSubTotalWCLocal" access="public" output="false" returnType="string">
		<cfargument name="customerGroupId" type="numeric" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		
		<cfset LOCAL.currency = EntityLoadByPK("currency", ARGUMENTS.currencyId) />
		<cfreturn LSCurrencyFormat(getSubTotal(argumentCollection = ARGUMENTS),"local",LOCAL.currency.getLocale()) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getSubTotalWCInter" access="public" output="false" returnType="string">
		<cfargument name="customerGroupId" type="numeric" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		
		<cfset LOCAL.currency = EntityLoadByPK("currency", ARGUMENTS.currencyId) />
		<cfreturn LSCurrencyFormat(getSubTotal(argumentCollection = ARGUMENTS),"international",LOCAL.currency.getLocale()) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getAttributes" access="public" output="false" returnType="array">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retArray = [] />
		
		<cfloop array="#getProduct().getProductAttributeRelas()#" index="LOCAL.rela">
			<cfset ArrayAppend(LOCAL.retArray,LOCAL.rela.getAttribute()) />
		</cfloop>
		
		<cfreturn LOCAL.retArray />
	</cffunction>
	<!------------------------------------------------------------------------------->	
</cfcomponent>
