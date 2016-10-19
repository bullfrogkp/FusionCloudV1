<cfcomponent output="false" accessors="true">
	<!------------------------------------------------------------------------------------------------------------>
	<cffunction name="addProductToCart" access="remote" returntype="string" returnformat="plain" output="false">
		<cfargument name="callback" type="string" required="true">
		<cfargument name="productId" type="numeric" required="true">
		<cfargument name="trackingEntityId" type="numeric" required="true">
		<cfargument name="customerGroupId" type="numeric" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		<cfargument name="quantity" type="string" required="true">
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.products = [] />
		
		<cfset LOCAL.trackingRecord = EntityNew("tracking_record") />
		<cfset LOCAL.trackingEntity = EntityLoadByPK("tracking_entity",ARGUMENTS.trackingEntityId) />
		<cfset LOCAL.trackingRecordType = EntityLoad("tracking_record_type",{name = "shopping cart"},true) />
		<cfset LOCAL.product = EntityLoadByPK("product",ARGUMENTS.productId) />
		
		<cfset LOCAL.existingRecord = EntityLoad("tracking_record",{product = LOCAL.product, trackingEntity = LOCAL.trackingEntity},true) />
		
		<cfif IsNull(LOCAL.existingRecord)>
			<cfset LOCAL.trackingRecord.setTrackingEntity(LOCAL.trackingEntity) />
			<cfset LOCAL.trackingRecord.setTrackingRecordType(LOCAL.trackingRecordType) />
			<cfset LOCAL.trackingRecord.setProduct(LOCAL.product) />
			<cfset LOCAL.trackingRecord.setQuantity(ARGUMENTS.quantity) />
			<cfset EntitySave(LOCAL.trackingRecord) />
		<cfelse>
			<cfset LOCAL.existingRecord.setQuantity(LOCAL.existingRecord.getQuantity() + ARGUMENTS.quantity) />
			<cfset EntitySave(LOCAL.existingRecord) />
		</cfif>
		
		<cfset LOCAL.cart = new "core.entities.cart"(	trackingEntityId = ARGUMENTS.trackingEntityId
													, 	customerGroupId = ARGUMENTS.customerGroupId
													, 	currencyId = ARGUMENTS.currencyId) />
		<cfset LOCAL.cart.calculate() />
		
		<cfloop array="#LOCAL.cart.getCartItems()#" index="LOCAL.item"> 
			<cfset LOCAL.product = {} />
			<cfset LOCAL.product.price = LOCAL.item.getPriceWCLocal(customerGroupId = ARGUMENTS.customerGroupId, currencyId = ARGUMENTS.currencyId) />
			<cfset LOCAL.product.quantity = LOCAL.item.getQuantity() />
			<cfset LOCAL.product.id = LOCAL.item.getProduct().getProductId() />
			<cfset LOCAL.product.name = LOCAL.item.getProduct().getDisplayNameMV() />
			<cfset LOCAL.product.href = LOCAL.item.getProduct().getDetailPageURLMV() />
			<cfset LOCAL.product.image = LOCAL.item.getProduct().getDefaultImageLinkMV(type = "small") />
			<cfset ArrayAppend(LOCAL.retStruct.products, LOCAL.product) />
		</cfloop>
		
		<cfset LOCAL.retStruct.subTotal = LOCAL.cart.getSubTotalPriceWCLocal() />
		<cfset LOCAL.retStruct.total = LOCAL.cart.getTotalPriceWCLocal() />
		
		<cfset retString = "#ARGUMENTS.callback#(#SerializeJSON(retStruct)#);" />
		<cfreturn retString>
	</cffunction>
	<!------------------------------------------------------------------------------------------------------------>
</cfcomponent>