<cfcomponent extends="core.pages.page">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfif StructKeyExists(URL,"token") AND StructKeyExists(URL,"payerId")>
			<cfset LOCAL.order = EntityLoadByPK("order",URL.order_id) />
			<cfset LOCAL.order.setToken(URL.token) />
			<cfset LOCAL.order.setPayerId(URL.payerId) />
			<cfset EntitySave(LOCAL.order) />
			
			<cfset LOCAL.requestData = StructNew()>
			<cfset LOCAL.requestData.METHOD = "DoExpressCheckoutPayment">		
			<cfset LOCAL.requestData.USER = APPLICATION.paypal.APIUserName>
			<cfset LOCAL.requestData.PWD = APPLICATION.paypal.APIPassword>
			<cfset LOCAL.requestData.SIGNATURE = APPLICATION.paypal.APISignature>
			<cfset LOCAL.requestData.VERSION = APPLICATION.paypal.version>
			<cfset LOCAL.requestData.TOKEN = URL.token>
			<cfset LOCAL.requestData.PAYERID = URL.payerId>
			<cfset LOCAL.requestData.PAYMENTACTION = "sale">
			<cfset LOCAL.requestData.AMT = LOCAL.order.getTotalPrice()>
			<cfset LOCAL.requestData.CURRENCYCODE = SESSION.currency.code>
					
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
			
			<cfif LOCAL.responseStruct.Ack is "Success">
				<cfset LOCAL.orderTransactionType = EntityLoad("order_transaction_type",{name="purchase"},true) />
				<cfset LOCAL.orderTransaction = EntityNew("order_transaction") />
				<cfset LOCAL.orderTransaction.setOrder(LOCAL.order) />
				<cfset LOCAL.orderTransaction.setOrderTransactionType(LOCAL.orderTransactionType) />
				<cfset LOCAL.orderTransaction.setTransactionId(LOCAL.responseStruct.transactionId) />
				<cfset EntitySave(LOCAL.orderTransaction) />
				
				<cfset LOCAL.order.setPaid() />
				<cfset EntitySave(LOCAL.order) />
				
				<cfset LOCAL.trackingRecords = new "#APPLICATION.componentPathRoot#core.services.trackingService"(cfid = COOKIE.cfid, cftoken = COOKIE.cftoken).getTrackingRecords(trackingRecordType = "shopping cart") />
				<cfloop array="#LOCAL.trackingRecords#" index="LOCAL.record">
					<cfset EntityDelete(LOCAL.record) />
				</cfloop>
				
				<!--- send email --->
				<cfset LOCAL.emailService = new "#APPLICATION.componentPathRoot#core.services.emailService"() />
				<cfset LOCAL.emailService.setFromEmail(APPLICATION.emailCustomerService) />
				<cfset LOCAL.emailService.setToEmail(LOCAL.order.getCustomerEmail()) />
				<cfset LOCAL.emailService.setContentName("order confirmation") />
				
				<cfset LOCAL.replaceStruct = {} />
				<cfset LOCAL.replaceStruct.firstName = LOCAL.order.getCustomerFirstName() />
				<cfset LOCAL.emailService.setReplaceStruct(LOCAL.replaceStruct) />
				<cfset LOCAL.emailService.sendEmail() />
				
				<cflocation url="#APPLICATION.absoluteUrlWeb#checkout/checkout_thankyou.cfm" addToken="false" />
			<cfelse>
				<cfdump var="#LOCAL.responseStruct#" abort>
				<!---
				<cfset APPLICATION.utilsSupport.createAnonymousConv(subject = "place order error",
																	content = "error: token=#URL.token#, payerId=#URL.payerId#") />
															
				<cfset logFile = "place_order_failed" & DateFormat(now(), 'yyyymmdd') & ".log" />
				<cfinvoke component="#APPLICATION.db_cfc_path#cfc.logger" method="init" returnvariable="logger">
					<cfinvokeargument name="logFile" value="#APPLICATION.log_path & logFile#">
				</cfinvoke>
				<cfset function = "order express payment failed" />
				<cfset logger.addlog(function, "token=#URL.token#") />
				--->
			</cfif>
			
			<!---
			<cfset replace_struct = StructNew() />
			<cfset replace_struct.first_name = SESSION.new_order.shipping_address.first_name />
			<cfset replace_struct.last_name = SESSION.new_order.shipping_address.last_name />
			
			<cfset replace_struct.shipping_method_name = SESSION.new_order.shipping_method_name />
			<cfset replace_struct.currency_code = SESSION.currency.code />
			
			<cfset replace_struct.track_number = SESSION.new_order.order_track_number />
			<cfset replace_struct.items = "" />
			<cfloop from="1" to="#ArrayLen(SESSION.new_order.items.item_array)#" index="current_i">
					<cfset replace_struct.items = replace_struct.items & "
		#current_i#. #SESSION.new_order.items.item_array[current_i].name_display#      $#cal_price(SESSION.new_order.items.item_array[current_i].price)# x #SESSION.new_order.items.item_array[current_i].quantity#      $#cal_price(SESSION.new_order.items.item_array[current_i].item_total)##chr(13)##chr(10)#" />
			</cfloop>
			
			<cfset replace_struct.subtotal = cal_price(SESSION.new_order.items.sub_total_amount) />
			<cfset replace_struct.shipping_amount = cal_price(SESSION.new_order.items.shipping_amount) />
			<cfset replace_struct.tax_amount = cal_price(SESSION.new_order.items.tax_amount) />
			<cfset replace_struct.total = cal_price(SESSION.new_order.items.sub_total_amount) + cal_price(SESSION.new_order.items.shipping_amount) + cal_price(SESSION.new_order.items.tax_amount) />
			
			<cfset replace_struct.shipping_first_name = SESSION.new_order.shipping_address.first_name />
			<cfset replace_struct.shipping_last_name = SESSION.new_order.shipping_address.last_name />
			<cfset replace_struct.shipping_street = SESSION.new_order.shipping_address.street />
			<cfset replace_struct.shipping_city = SESSION.new_order.shipping_address.city />
			<cfset replace_struct.shipping_province = SESSION.new_order.shipping_address.province_name />
			<cfset replace_struct.shipping_country = SESSION.new_order.shipping_address.country_name />
			<cfset replace_struct.shipping_postal_code = SESSION.new_order.shipping_address.postal_code />
			
			<cfset replace_struct.billing_first_name = SESSION.new_order.billing_address.first_name />
			<cfset replace_struct.billing_last_name = SESSION.new_order.billing_address.last_name />
			<cfset replace_struct.billing_street = SESSION.new_order.billing_address.street />
			<cfset replace_struct.billing_city = SESSION.new_order.billing_address.city />
			<cfset replace_struct.billing_province = SESSION.new_order.billing_address.province_name />
			<cfset replace_struct.billing_country = SESSION.new_order.billing_address.country_name />
			<cfset replace_struct.billing_postal_code = SESSION.new_order.billing_address.postal_code />
				
			<cfinvoke component="#APPLICATION.db_cfc_path#cfc.email" method="sendEmail">
				<cfinvokeargument name="from_email" value="#APPLICATION.customer_service_email#">
				<cfinvokeargument name="to_email" value="#SESSION.new_order.contact.email#">
				<cfinvokeargument name="email_content_name" value="order confirmation">
				<cfinvokeargument name="replace_struct" value="#replace_struct#">
			</cfinvoke>	

			<cfinvoke component="#APPLICATION.db_cfc_path#cfc.email" method="sendDirectEmail">
				<cfinvokeargument name="from_email" value="#APPLICATION.customer_service_email#">
				<cfinvokeargument name="to_email" value="#APPLICATION.customer_service_email#">
				<cfinvokeargument name="email_subject" value="New Order">
				<cfinvokeargument name="email_content" value="#APPLICATION.https_root_url#bg/index.cfm?content=order_maint&submited_order_id=#SESSION.new_order.order_id#">
				<cfinvokeargument name="email_type" value="html">
			</cfinvoke>	
			--->
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>