<cfcomponent extends="core.pages.page">	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Order Tracking | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"check_order")>
			<cfif Trim(FORM.order_number) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid order number.") />
			</cfif>
			<cfif NOT IsValid("email",FORM.email)>
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your email.") />
			</cfif>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset SESSION.temp.message.messageType = "alert-danger" />
			<cfset LOCAL.redirectUrl = getCgiData().SCRIPT_NAME />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		
		<cfif StructKeyExists(FORM,"check_order")>
			<cfset LOCAL.order = EntityLoad("order",{orderTrackingNumber = Trim(FORM.order_number), customerEmail = Trim(FORM.email)},true) />
			<cfif NOT IsNull(LOCAL.order)>
				<cfset SESSION.temp.orderId = LOCAL.order.getOrderId() />
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#order_tracking_detail.cfm" />
			<cfelse>
				<cfset LOCAL.messageArray = [] />
				<cfset ArrayAppend(LOCAL.messageArray,"Sorry we cannot find this order.") />
				<cfset SESSION.temp.message = {} />
				<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
				<cfset SESSION.temp.message.messageType = "alert-danger" />
				<cfset LOCAL.redirectUrl = getCgiData().SCRIPT_NAME />
			</cfif>
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>