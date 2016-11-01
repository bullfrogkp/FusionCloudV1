<cfcomponent output="false" accessors="true">
	<cfproperty name="cart" type="any"> 
	
	<cffunction name="process" output="false" access="public" returntype="void">
		<cfset var LOCAL = {} />
		<cfset LOCAL.requestData = {}>
		<cfset LOCAL.requestData.METHOD = "SetExpressCheckout">
		<cfset LOCAL.requestData.PAYMENTACTION = "sale">
		<cfset LOCAL.requestData.USER = APPLICATION.paypal.APIUserName>
		<cfset LOCAL.requestData.PWD = APPLICATION.paypal.APIPassword>
		<cfset LOCAL.requestData.SIGNATURE = APPLICATION.paypal.APISignature>
		<cfset LOCAL.requestData.VERSION = APPLICATION.paypal.version>
		<cfset LOCAL.requestData.ADDRESSOVERRIDE = "1">
		<cfset LOCAL.requestData.Email = getCart().getCustomer().getEmail()>
		<cfset LOCAL.requestData.SHIPTONAME = getCart().getCustomer().getFullName()>
		<cfset LOCAL.requestData.SHIPTOSTREET = getCart().getShippingAddress().getStreet()>
		<cfset LOCAL.requestData.SHIPTOCITY = getCart().getShippingAddress().getCity()>
		<cfset LOCAL.requestData.SHIPTOSTATE = getCart().getBillingAddress().getProvince().getCode()>
		<cfset LOCAL.requestData.SHIPTOCOUNTRYCODE = getCart().getBillingAddress().getCountry().getCode()>
		<cfset LOCAL.requestData.CURRENCYCODE = SESSION.currency.code>
		<cfset LOCAL.requestData.SHIPTOZIP = getCart().getShippingAddress().getPostalCode()>
		<cfset LOCAL.requestData.SHIPTOPHONENUM = getCart().getShippingAddress().getPhone()>
		
		<cfloop from="1" to="#ArrayLen(getCart().getProductArray())#" index="LOCAL.i">
			<cfset LOCAL.product = EntityLoadByPK("product",getCart().getProductArray()[LOCAL.i].productId) />
			
			<cfset l_name = LOCAL.product.getDisplayNameMV()>
			
			<cfset l_amt = getCart().getProductArray()[LOCAL.i].singlePrice>
			<cfset l_qty = getCart().getProductArray()[LOCAL.i].count>
			<cfset l_number = getCart().getProductArray()[LOCAL.i].productId>
			<cfset StructInsert(LOCAL.requestData,"L_NAME#LOCAL.i-1#",l_name)>
			<cfset StructInsert(LOCAL.requestData,"L_AMT#LOCAL.i-1#",l_amt)>
			<cfset StructInsert(LOCAL.requestData,"L_QTY#LOCAL.i-1#",l_qty)>
			<cfset StructInsert(LOCAL.requestData,"L_NUMBER#LOCAL.i-1#",l_number)>
		</cfloop>
		<cfset LOCAL.requestData.ITEMAMT = getCart().getSubTotalPrice()>
		<cfset LOCAL.requestData.SHIPPINGAMT = getCart().getTotalShippingFee()>
		<cfset LOCAL.requestData.TAXAMT = getCart().getTotalTax()>
		<cfset LOCAL.requestData.AMT = getCart().getTotalPrice()>
		<cfset LOCAL.requestData.CancelURL = "#APPLICATION.urlHttpsWeb#" >
		<cfset LOCAL.requestData.ReturnURL = "#APPLICATION.urlHttpsWeb#payments/paypal.cfm?order_id=#SESSION.cart.getOrder().getOrderId()#">

		<cfinvoke component="#APPLICATION.componentPathRoot#core.services.callerService" method="doHttppost" returnvariable="LOCAL.response">
			<cfinvokeargument name="requestData" value="#LOCAL.requestData#">
			<cfinvokeargument name="serverURL" value="#APPLICATION.paypal.serverURL#">
			<cfinvokeargument name="proxyName" value="#APPLICATION.paypal.proxyName#">
			<cfinvokeargument name="proxyPort" value="#APPLICATION.paypal.proxyPort#">
			<cfinvokeargument name="useProxy" value="#APPLICATION.paypal.useProxy#">
		</cfinvoke>							
			
		<cfinvoke component="#APPLICATION.componentPathRoot#core.services.callerService" method="getNVPResponse" returnvariable="LOCAL.responseStruct">
			<cfinvokeargument name="nvpString" value="#URLDecode(LOCAL.response)#">
		</cfinvoke>	

		<cfif LOCAL.responseStruct.Ack EQ "Success">
			<cflocation  url="#APPLICATION.paypal.PayPalURL##LOCAL.responseStruct.token#" addtoken="false">
		<cfelse>
			<cfdump var="#LOCAL.responseStruct#" abort>
			<!---
			<cfset APPLICATION.utilsSupport.createAnonymousConv(subject = "http post error",
																content = "error: #LOCAL.responseStruct.L_LONGMESSAGE0#") />

			<cfset getCart().transactionFailedReason = LOCAL.responseStruct.L_LONGMESSAGE0 />	
			<cflocation  url="#APPLICATION.urlHttpsAdmin#checkout/checkout_confirmation.cfm" addtoken="false">
			--->
		</cfif>
    </cffunction>
</cfcomponent>