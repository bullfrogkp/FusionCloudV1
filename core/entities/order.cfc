<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="orderId" column="order_id" fieldtype="id" generator="native">
	<cfproperty name="comments" column="comments" ormtype="string">
	<cfproperty name="orderTrackingNumber" column="order_tracking_number" ormtype="string">
	
	<cfproperty name="customerFirstName" column="customer_first_name" ormtype="string"> 
	<cfproperty name="customerMiddleName" column="customer_middle_name" ormtype="string"> 
	<cfproperty name="customerLastName" column="customer_last_name" ormtype="string"> 
	<cfproperty name="customerCompany" column="customer_company" ormtype="string"> 
	<cfproperty name="customerPhone" column="customer_phone" ormtype="string"> 
	<cfproperty name="customerEmail" column="customer_email" ormtype="string">
	<cfproperty name="customerGroupId" column="customer_group_id" ormtype="string">
	
	<cfproperty name="paymentMethodName" column="payment_method_name" ormtype="string"> 
	<cfproperty name="isComplete" column="is_complete" ormtype="boolean"> 
	<cfproperty name="isNew" column="is_new" ormtype="boolean"> 
	
	<cfproperty name="token" column="token" ormtype="string"> 
	<cfproperty name="payerId" column="payerId" ormtype="string"> 
		
	<cfproperty name="shippingFirstName" column="shipping_first_name" ormtype="string"> 
	<cfproperty name="shippingMiddleName" column="shipping_middle_name" ormtype="string"> 
	<cfproperty name="shippingLastName" column="shipping_last_name" ormtype="string">
    <cfproperty name="shippingCompany" column="shipping_company" ormtype="string"> 
    <cfproperty name="shippingPhone" column="shipping_phone" ormtype="string"> 
    <cfproperty name="shippingUnit" column="shipping_unit" ormtype="string"> 
    <cfproperty name="shippingStreet" column="shipping_street" ormtype="string"> 
    <cfproperty name="shippingCity" column="shipping_city" ormtype="string"> 
    <cfproperty name="shippingPostalCode" column="shipping_postal_code" ormtype="string"> 
	<cfproperty name="shippingCountry" fieldtype="many-to-one" cfc="country" fkcolumn="shipping_country_id">
	<cfproperty name="shippingProvince" fieldtype="many-to-one" cfc="province" fkcolumn="shipping_province_id">	
	
	<cfproperty name="billingFirstName" column="billing_first_name" ormtype="string"> 
	<cfproperty name="billingMiddleName" column="billing_middle_name" ormtype="string"> 
	<cfproperty name="billingLastName" column="billing_last_name" ormtype="string">
    <cfproperty name="billingCompany" column="billing_company" ormtype="string"> 
    <cfproperty name="billingPhone" column="billing_phone" ormtype="string"> 
    <cfproperty name="billingUnit" column="billing_unit" ormtype="string"> 
    <cfproperty name="billingStreet" column="billing_street" ormtype="string"> 
    <cfproperty name="billingCity" column="billing_city" ormtype="string"> 
    <cfproperty name="billingPostalCode" column="billing_postal_code" ormtype="string"> 
	<cfproperty name="billingCountry" fieldtype="many-to-one" cfc="country" fkcolumn="billing_country_id">
	<cfproperty name="billingProvince" fieldtype="many-to-one" cfc="province" fkcolumn="billing_province_id">
	
	<cfproperty name="customer" fieldtype="many-to-one" cfc="customer" fkcolumn="customer_id">	
	<cfproperty name="currency" fieldtype="many-to-one" cfc="currency" fkcolumn="currency_id">	
	
	<cfproperty name="subTotalPrice" column="sub_total_price" ormtype="float"> 
	<cfproperty name="totalShippingFee" column="total_shipping_fee" ormtype="float"> 
	<cfproperty name="totalTax" column="total_tax" ormtype="float"> 
	<cfproperty name="totalPrice" column="total_price" ormtype="float"> 
	<cfproperty name="discount" column="discount" ormtype="float"> 	
	<cfproperty name="couponCode" column="coupon_code" ormtype="string"> 
	
	<cfproperty name="orderStatus" type="array" fieldtype="one-to-many" cfc="order_status" fkcolumn="order_id" singularname="orderStatus">
	<cfproperty name="orderTransactions" type="array" fieldtype="one-to-many" cfc="order_transaction" fkcolumn="order_id" singularname="orderTransaction">
	<cfproperty name="products" type="array" fieldtype="one-to-many" cfc="order_product" fkcolumn="order_id" singularname="product">

	<cffunction name="getCustomerFullName" access="public" output="false" returnType="string">
		
		<cfset var firstName = isNull(getCustomerFirstName())?"":getCustomerFirstName() />
		<cfset var middleName = isNull(getCustomerMiddleName())?"":getCustomerMiddleName() />
		<cfset var lastName = isNull(getCustomerLastName())?"":getCustomerLastName() />
		
		<cfif middleName EQ "">
			<cfset var fullName = firstName & " " & lastName />
		<cfelse>
			<cfset var fullName = firstName & " " & middleName & " " & lastName />
		</cfif>
		
		<cfreturn fullName />
	</cffunction>
		
	<cffunction name="getCurrentOrderStatus" access="public" output="false" returnType="any">
		<cfreturn EntityLoad("order_status",{order=this, current=true},true) />
	</cffunction>
	
	
	<!------------------------------------------------------------------------------->
	<cffunction name="setPaid" access="public" output="false" returnType="void">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.orderId = getOrderId() />
		<cfset LOCAL.order = EntityLoadByPK("order",LOCAL.orderId) />
		<cfset LOCAL.currentOrderStatus = EntityLoad("order_status",{order = LOCAL.order, current = true},true) />
		<cfset LOCAL.currentOrderStatus.setCurrent(false) />
		<cfset LOCAL.currentOrderStatus.setEndDatetime(Now()) />
		<cfset EntitySave(LOCAL.currentOrderStatus) /> 
		
		<cfset LOCAL.orderStatusType = EntityLoad("order_status_type",{name = "paid"},true) />
		<cfset LOCAL.orderStatus = EntityNew("order_status") />
		<cfset LOCAL.orderStatus.setStartDatetime(Now()) />
		<cfset LOCAL.orderStatus.setCurrent(true) />
		<cfset LOCAL.orderStatus.setOrderStatusType(LOCAL.orderStatusType) />
		<cfset EntitySave(LOCAL.orderStatus) /> 
		<cfset LOCAL.order.addOrderStatus(LOCAL.orderStatus) />
		<cfset LOCAL.order.setIsComplete(true) />
		
		<cfset EntitySave(LOCAL.order) />
	</cffunction>
</cfcomponent>
