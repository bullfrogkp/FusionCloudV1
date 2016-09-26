<cfcomponent output="false" accessors="true">
	<cffunction name="applyCouponCode" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="couponCode" type="string" required="true">
		<cfargument name="customerId" type="string" required="true">
		<cfargument name="total" type="numeric" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		
		<cfset var LOCAL = {} />
		<cfset var retStruct = {} />
		<cfset retStruct.success = true />
		<cfset retStruct.messageType = "" />
		<cfset retStruct.newTotal = "" />
		<cfset retStruct.thresholdAmount = "" />
		<cfset retStruct.discount = "" />
		<cfset retStruct.couponId = "" />
		
		<cfset LOCAL.couponStatusType = EntityLoad("coupon_status_type",{name="active"},true) />
		<cfset LOCAL.coupon = EntityLoad("coupon",{couponStatusType = LOCAL.couponStatusType, couponCode = Trim(ARGUMENTS.couponCode)},true) />
		<cfset LOCAL.currency = EntityLoadByPK("currency",ARGUMENTS.currencyId) />
		
		<cfif NOT IsNull(LOCAL.coupon)>
			<cfif ARGUMENTS.total LT LOCAL.coupon.getThresholdAmount()>
				<cfset retStruct.success = false />
				<cfset retStruct.messageType = 1 />
				<cfset retStruct.thresholdAmount = LOCAL.coupon.getThresholdAmount() />
			<cfelseif 	IsDate(LOCAL.coupon.getStartDate()) AND DateCompare(Now(), LOCAL.coupon.getStartDate()) EQ -1
						OR
						IsDate(LOCAL.coupon.getEndDate()) AND DateCompare(LOCAL.coupon.getEndDate(), Now()) EQ -1>
				<cfset retStruct.success = false />
				<cfset retStruct.messageType = 2 />
			<cfelseif NOT IsNull(LOCAL.coupon.getCustomer()) AND IsNumeric(ARGUMENTS.customerId)>
				<cfif LOCAL.coupon.getCustomer().getCustomerId() NEQ ARGUMENTS.customerId>
					<cfset retStruct.success = false />
					<cfset retStruct.messageType = 3 />
				</cfif>
			</cfif>
			
			<cfif retStruct.success EQ true>
				<cfif LOCAL.coupon.getDiscountType().getCalculationType().getName() EQ "fixed">
					<cfset retStruct.discount = LOCAL.coupon.getDiscountType().getAmount() * LOCAL.currency.getMultiplier() />
				<cfelseif LOCAL.coupon.getDiscountType().getCalculationType().getName() EQ "percentage">
					<cfset retStruct.discount = ARGUMENTS.total * LOCAL.coupon.getDiscountType().getAmount().getMultiplier() />
				</cfif>
				<cfset retStruct.newTotal = ARGUMENTS.total - retStruct.discount />
				<cfset retStruct.couponId = LOCAL.coupon.getCouponId() />
			<cfelse>
				<cfset retStruct.newTotal = ARGUMENTS.total />
			</cfif>
		<cfelse>
			<cfset retStruct.success = false />
			<cfset retStruct.messageType = 4 />
			<cfset retStruct.newTotal = ARGUMENTS.total />
		</cfif>
		
		<cfset retStruct.newTotal = NumberFormat(retStruct.newTotal,"0.00") />
		<cfset retStruct.discount = NumberFormat(retStruct.discount,"0.00") />
		
		<cfreturn retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------------------------------------>
	<cffunction name="cartLogin" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="username" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.retValue = false />
		
		<cfset LOCAL.customer = EntityLoad("customer",{email = ARGUMNENTS.username, password = Hash(ARGUMNENTS.password),isDeleted=false,isEnabled=true},true) />
		<cfif NOT IsNull(LOCAL.customer)>
			<cfset LOCAL.retValue = true />
		</cfif>
	
		<cfreturn LOCAL.retValue />
	</cffunction>
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
			<cfset LOCAL.product.price = LOCAL.item.getPrice(customerGroupId = ARGUMENTS.customerGroupId, currencyId = ARGUMENTS.currencyId) />
			<cfset LOCAL.product.quantity = LOCAL.item.getQuantity() />
			<cfset LOCAL.product.id = LOCAL.item.getProduct().getProductId() />
			<cfset LOCAL.product.name = LOCAL.item.getProduct().getDisplayNameMV() />
			<cfset LOCAL.product.href = LOCAL.item.getProduct().getDetailPageURLMV() />
			<cfset LOCAL.product.image = LOCAL.item.getProduct().getDefaultImageLinkMV(type = "small") />
			<cfset ArrayAppend(LOCAL.retStruct.products, LOCAL.product) />
		</cfloop>
		
		<cfset LOCAL.retStruct.subTotal = LOCAL.cart.getSubTotalPriceWCInter() />
		<cfset LOCAL.retStruct.total = LOCAL.cart.getTotalPriceWCInter() />
		
		<cfset retString = "#ARGUMENTS.callback#(#SerializeJSON(retStruct)#);" />
		<cfreturn retString>
	</cffunction>
	<!------------------------------------------------------------------------------------------------------------>
</cfcomponent>