<cfcomponent extends="core.pages.page">	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"shipping_to_new_address")>
			<cfif Trim(FORM.shipto_first_name) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your first name.") />
			</cfif>
			<cfif Trim(FORM.shipto_last_name) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter your last name.") />
			</cfif>
			<cfif Trim(FORM.shipto_street) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter the shipping street.") />
			</cfif>
			<cfif Trim(FORM.shipto_city) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter the shipping city.") />
			</cfif>
			<cfif NOT IsNumeric(FORM.shipto_province_id)>
				<cfset ArrayAppend(LOCAL.messageArray,"Please choose your shipping province.") />
			</cfif>
			<cfif Trim(FORM.shipto_postal_code) EQ "">
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter the shipping postal code / zip.") />
			</cfif>
			<cfif NOT IsNumeric(FORM.shipto_country_id)>
				<cfset ArrayAppend(LOCAL.messageArray,"Please choose your shipping country.") />
			</cfif>
			
			<cfif IsValid("email",Trim(FORM.new_email)) EQ false>
				<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid email.") />
			<cfelseif StructKeyExists(FORM,"register_user")>
				<cfset LOCAL.existingCustomer = EntityLoad("customer",{email=Trim(FORM.new_email),isDeleted=false,isEnabled=true},true) />
				<cfif NOT IsNull(LOCAL.existingCustomer)>
					<cfset ArrayAppend(LOCAL.messageArray,"Customer already exists with email:#Trim(FORM.new_email)#.") />
				</cfif>
			</cfif>
			
			<cfif IsNumeric(FORM.shipto_country_id) AND IsNumeric(FORM.shipto_province_id)>
				<cfset LOCAL.shippingAddress = {} />
				<cfset LOCAL.shippingAddress.unit = Trim(FORM.shipto_unit) />
				<cfset LOCAL.shippingAddress.street = Trim(FORM.shipto_street) />
				<cfset LOCAL.shippingAddress.city = Trim(FORM.shipto_city) />
				<cfset LOCAL.shippingAddress.postalCode = Trim(FORM.shipto_postal_code) />
				
				<cfset LOCAL.province = EntityLoadByPK("province",FORM.shipto_province_id) />
				<cfset LOCAL.shippingAddress.provinceId = FORM.shipto_province_id />
				<cfset LOCAL.shippingAddress.provinceCode = LOCAL.province.getCode() />
				
				<cfset LOCAL.country = EntityLoadByPK("country",FORM.shipto_country_id) />
				<cfset LOCAL.shippingAddress.countryId = FORM.shipto_country_id />
				<cfset LOCAL.shippingAddress.countryCode = LOCAL.country.getCode() />
				
				<cfset LOCAL.addressComponent = new "core.shipping.address"() />
				<cfset LOCAL.isValidAddress = LOCAL.addressComponent.isValidAddress(address = LOCAL.shippingAddress) />
				<cfif LOCAL.isValidAddress EQ false>
					<cfset ArrayAppend(LOCAL.messageArray,"Sorry we don't support shipping to this address.") />
				</cfif>
			</cfif>
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset LOCAL.redirectUrl = getCgiData().SCRIPT_NAME />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Customer Information | #APPLICATION.applicationName#" />
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
		
		<cfif StructKeyExists(FORM,"shipping_to_new_address")>
			<!--- set flags --->
			<cfset SESSION.cart.setIsExistingCustomer(false) />
			<cfset SESSION.cart.setSameAddress(true) />
			
			<cfif StructKeyExists(FORM,"register_user")>
				<cfset SESSION.cart.setRegisterCustomer(true) />
				<cfset SESSION.cart.setRegisterCustomerPassword(Hash(Trim(FORM.new_password))) />
			<cfelse>
				<cfset SESSION.cart.setRegisterCustomer(false) />
				<cfset SESSION.cart.setRegisterCustomerPassword("") />
			</cfif>
			
			<!--- set addresses --->
			<cfset LOCAL.shippingAddress = {} />
			<cfset LOCAL.shippingAddress.useExistingAddress = false />
			<cfset LOCAL.shippingAddress.addressId = "" />
			<cfset LOCAL.shippingAddress.company = Trim(FORM.shipto_company) />
			<cfset LOCAL.shippingAddress.firstName = Trim(FORM.shipto_first_name) />
			<cfset LOCAL.shippingAddress.middleName = Trim(FORM.shipto_middle_name) />
			<cfset LOCAL.shippingAddress.lastName = Trim(FORM.shipto_last_name) />
			<cfset LOCAL.shippingAddress.phone = Trim(FORM.shipto_phone) />
			<cfset LOCAL.shippingAddress.unit = Trim(FORM.shipto_unit) />
			<cfset LOCAL.shippingAddress.street = Trim(FORM.shipto_street) />
			<cfset LOCAL.shippingAddress.city = Trim(FORM.shipto_city) />
			<cfset LOCAL.shippingAddress.postalCode = Trim(FORM.shipto_postal_code) />
			
			<cfset LOCAL.province = EntityLoadByPK("province",FORM.shipto_province_id) />
			<cfset LOCAL.shippingAddress.provinceId = FORM.shipto_province_id />
			<cfset LOCAL.shippingAddress.provinceCode = LOCAL.province.getCode() />
			
			<cfset LOCAL.country = EntityLoadByPK("country",FORM.shipto_country_id) />
			<cfset LOCAL.shippingAddress.countryId = FORM.shipto_country_id />
			<cfset LOCAL.shippingAddress.countryCode = LOCAL.country.getCode() />
			<cfset LOCAL.billingAddress = Duplicate(LOCAL.shippingAddress) />
			
			<cfset LOCAL.customerStruct = SESSION.cart.getCustomerStruct() />
			<cfset LOCAL.customerStruct.email = Trim(FORM.new_email) />
			<cfset LOCAL.customerStruct.firstName = Trim(FORM.shipto_first_name) />
			<cfset LOCAL.customerStruct.middleName = Trim(FORM.shipto_middle_name) />
			<cfset LOCAL.customerStruct.lastName = Trim(FORM.shipto_last_name) />
			<cfset LOCAL.customerStruct.company = Trim(FORM.shipto_company) />
			<cfset LOCAL.customerStruct.phone = Trim(FORM.shipto_phone) />
			
			<cfset SESSION.cart.setCustomerStruct(LOCAL.customerStruct) />
			<cfset SESSION.cart.setShippingAddressStruct(LOCAL.shippingAddress) />
			<cfset SESSION.cart.setBillingAddressStruct(LOCAL.billingAddress) />
			<cfset SESSION.cart.calculate() />
			
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin#checkout/checkout_step2.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>