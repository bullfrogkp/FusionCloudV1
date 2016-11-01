<cfcomponent extends="core.pages.page">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"update_count")>
			<cfloop collection="#FORM#" item="LOCAL.field">
				<cfif FindNoCase("product_count_", LOCAL.field) AND (NOT IsNumeric(FORM["#LOCAL.field#"]) OR FORM["#LOCAL.field#"] LT 1)>
					<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid value for the number of products in the order.") />
					<cfbreak />
				</cfif>
			</cfloop>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset LOCAL.redirectUrl = getCgiData().SCRIPT_NAME />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="_loadPageData" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Shopping Cart | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.provinces = EntityLoad("province") />
		<cfset LOCAL.pageData.countries = EntityLoad("country") />
		
		<cfif IsDefined("SESSION.temp.message") AND NOT ArrayIsEmpty(SESSION.temp.message.messageArray)>
			<cfset LOCAL.pageData.message.messageArray = SESSION.temp.message.messageArray />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(FORM,"submit_cart") OR StructKeyExists(FORM,"submit_cart.x")>
	
			<cfset SESSION.cart = new "core.entities.cart"() />
			<cfset SESSION.cart.setCfId(COOKIE.cfid) />
			<cfset SESSION.cart.setCfToken(COOKIE.cftoken) />
			<cfset SESSION.cart.setCurrencyId(SESSION.currency.id) />
			<cfset SESSION.cart.setCustomerGroupId(SESSION.user.customerGroupId) />
			
			<cfset LOCAL.customerStruct = {} />
			<cfset LOCAL.customerStruct.customerId = SESSION.user.customerId />
			<cfset SESSION.cart.setCustomerStruct(LOCAL.customerStruct) />
			
			<!--- may add google checkout later --->
			<cfset LOCAL.payment = EntityLoad("payment_method",{name="paypal"},true) />
			<cfset SESSION.cart.setPaymentMethodId(LOCAL.payment.getPaymentMethodId()) />
			<cfif Trim(FORM.coupon_code_applied) NEQ "">
				<cfset LOCAL.coupon = EntityLoad("coupon", {couponCode = Trim(FORM.coupon_code_applied)}, true) />
				<cfset SESSION.cart.setCouponId(LOCAL.coupon.getCouponId()) />
			</cfif>
			<cfset SESSION.cart.calculate() />
		
			<cfif IsNumeric(SESSION.user.customerId)>
				<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin#checkout/checkout_step1_customer.cfm" />
			<cfelse>
				<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin#checkout/checkout_signin.cfm" />
			</cfif>
		<cfelseif StructKeyExists(FORM,"update_count")>
			<cfset LOCAL.trackingRecord = EntityLoadByPK("tracking_record",FORM.tracking_record_id) />
			<cfset LOCAL.trackingRecord.setCount(FORM["product_count_#FORM.tracking_record_id#"]) />
			<cfset EntitySave(LOCAL.trackingRecord) />
		<cfelseif StructKeyExists(FORM,"remove_product")>
			<cfset LOCAL.trackingRecord = EntityLoadByPK("tracking_record",FORM["remove_product"]) />
			<cfset EntityDelete(LOCAL.trackingRecord) />
		<cfelseif StructKeyExists(FORM,"remove_product.x")>
			<cfset LOCAL.trackingRecord = EntityLoadByPK("tracking_record",FORM["remove_product.x"]) />
			<cfset EntityDelete(LOCAL.trackingRecord) />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>
</cfcomponent>