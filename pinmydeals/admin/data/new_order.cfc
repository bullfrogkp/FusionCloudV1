<cfcomponent extends="core.pages.page">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
	
		<cfif StructKeyExists(FORM,"submit_order") AND Trim(FORM.first_name) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid first name.") />	
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset SESSION.temp.message.messageType = "alert-danger" />
			<cfset LOCAL.redirectUrl = _setRedirectURL() />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>

	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.order = EntityLoadByPK("order", FORM.id) /> 
		<cfelse>
			<cfset LOCAL.order = EntityNew("order") /> 
			<cfset LOCAL.newOrderTrackingNumber = "OR#DateFormat(Now(),"yyyymmdd")##TimeFormat(Now(),"hhmmss")##LOCAL.order.getOrderId()#" />
			<cfset LOCAL.order.setOrderTrackingNumber(LOCAL.newOrderTrackingNumber) />
			<cfset LOCAL.order.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"submit_order")>
			
			<cfif FORM.save_customer_and_addresses EQ 1>
				<cfset LOCAL.newCustomer = EntityNew("customer") />
				<cfset LOCAL.newCustomer.setFirstName(Trim(FORM.first_name)) />
				<cfset LOCAL.newCustomer.setMiddleName(Trim(FORM.middle_name)) />
				<cfset LOCAL.newCustomer.setLastName(Trim(FORM.last_name)) />
				<cfset LOCAL.newCustomer.setPrefix(Trim(FORM.prefix)) />
				<cfset LOCAL.newCustomer.setSuffix(Trim(FORM.suffix)) />
				<cfset LOCAL.newCustomer.setEmail(Trim(FORM.email)) />
				<cfset LOCAL.newCustomer.setPhone(Trim(FORM.phone)) />
				<cfset LOCAL.newCustomer.setIsEnabled(false) />
				<cfset LOCAL.newCustomer.setIsDeleted(false) />
				<cfset LOCAL.newCustomer.setCreatedDatetime(Now()) />
				<cfset LOCAL.newCustomer.setCreatedUser(SESSION.adminUser) />
				
				<cfset LOCAL.newCustomer.setCustomerGroup(EntityLoad("customer_group",{isDefault=true},true)) />
				
				<cfset LOCAL.newAddress = EntityNew("address") />
				<cfset LOCAL.newAddress.setUnit(Trim(FORM.shipping_unit)) />
				<cfset LOCAL.newAddress.setStreet(Trim(FORM.shipping_street)) />
				<cfset LOCAL.newAddress.setCity(Trim(FORM.shipping_city)) />
				<cfset LOCAL.newAddress.setProvince(EntityLoadByPK("province",FORM.shipping_province_id)) />
				<cfset LOCAL.newAddress.setCountry(EntityLoadByPK("country",FORM.shipping_country_id)) />
				<cfset LOCAL.newAddress.setPostalCode(Trim(FORM.shipping_postal_code)) />
				<cfset LOCAL.newAddress.setCreatedDatetime(Now()) />
				<cfset LOCAL.newAddress.setCreatedUser(SESSION.adminUser) />
				
				<cfset EntitySave(LOCAL.newAddress) />
				<cfset LOCAL.newCustomer.addAddress(LOCAL.newAddress) />
				
				<cfif Trim(FORM.shipping_unit) NEQ Trim(FORM.billing_unit)
				OR	Trim(FORM.shipping_street) NEQ Trim(FORM.billing_street)
				OR	Trim(FORM.shipping_city) NEQ Trim(FORM.billing_city)
				OR	Trim(FORM.shipping_province_id) NEQ Trim(FORM.billing_province_id)
				OR	Trim(FORM.shipping_country_id) NEQ Trim(FORM.billing_country_id)
				OR	Trim(FORM.shipping_postal_code) NEQ Trim(FORM.billing_postal_code)>
					
					<cfset LOCAL.newAddress = EntityNew("address") />
					<cfset LOCAL.newAddress.setUnit(Trim(FORM.billing_unit)) />
					<cfset LOCAL.newAddress.setStreet(Trim(FORM.billing_street)) />
					<cfset LOCAL.newAddress.setCity(Trim(FORM.billing_city)) />
					<cfset LOCAL.newAddress.setProvince(EntityLoadByPK("province",FORM.billing_province_id)) />
					<cfset LOCAL.newAddress.setCountry(EntityLoadByPK("country",FORM.billing_country_id)) />
					<cfset LOCAL.newAddress.setPostalCode(Trim(FORM.billing_postal_code)) />
					<cfset LOCAL.newAddress.setCreatedDatetime(Now()) />
					<cfset LOCAL.newAddress.setCreatedUser(SESSION.adminUser) />
					
					<cfset EntitySave(LOCAL.newAddress) />
					<cfset LOCAL.newCustomer.addAddress(LOCAL.newAddress) />
				</cfif>
				
				<cfset EntitySave(LOCAL.newCustomer) />
			</cfif>
				
			<cfset LOCAL.order.setShippingCompany(Trim(FORM.shipping_company)) />
			<cfset LOCAL.order.setShippingUnit(Trim(FORM.shipping_unit)) />
			<cfset LOCAL.order.setShippingStreet(Trim(FORM.shipping_street)) />
			<cfset LOCAL.order.setShippingCity(Trim(FORM.shipping_city)) />
			<cfset LOCAL.order.setShippingProvince(EntityLoadByPK("province",FORM.shipping_province_id)) />
			<cfset LOCAL.order.setShippingCountry(EntityLoadByPK("country",FORM.shipping_country_id)) />
			<cfset LOCAL.order.setShippingPostalCode(Trim(FORM.shipping_postal_code)) />
					
			<cfset LOCAL.order.setBillingCompany(Trim(FORM.billing_company)) />
			<cfset LOCAL.order.setBillingUnit(Trim(FORM.billing_unit)) />
			<cfset LOCAL.order.setBillingStreet(Trim(FORM.billing_street)) />
			<cfset LOCAL.order.setBillingCity(Trim(FORM.billing_city)) />
			<cfset LOCAL.order.setBillingProvince(EntityLoadByPK("province",FORM.billing_province_id)) />
			<cfset LOCAL.order.setBillingCountry(EntityLoadByPK("country",FORM.billing_country_id)) />
			<cfset LOCAL.order.setBillingPostalCode(Trim(FORM.billing_postal_code)) />
			
			<cfset LOCAL.order.setCreatedDatetime(Now()) />
			<cfset LOCAL.order.setCreatedUser(SESSION.adminUser) />
			
			<cfset LOCAL.order.setPaymentMethod(EntityLoadByPK("payment_method",FORM.payment_method_id)) />
			
			<cfif FORM.coupon_code NEQ "">
				<cfset LOCAL.order.addCoupon(EntityLoad("coupon",{couponCode = FORM.coupon_code}, true)) />
			</cfif>
						
			<cfset LOCAL.newStatusType = EntityLoad("order_status_type",{displayName = "placed"},true) />
			<cfset LOCAL.newStatus = EntityNew("order_status") />
			<cfset LOCAL.newStatus.setStartDatetime(Now()) />
			<cfset LOCAL.newStatus.setCurrent(true) />
			<cfset LOCAL.newStatus.setComments(Trim(FORM.comments)) />
			<cfset LOCAL.newStatus.setOrderStatusType(LOCAL.newStatusType) />
			<cfset EntitySave(LOCAL.newStatus) /> 
			
			<cfset LOCAL.order.addOrderStatus(LOCAL.newStatus) />
			
			<cfset EntitySave(LOCAL.order) />
			
			<cfif FORM.save_customer_and_addresses EQ 1>
				<cfset LOCAL.newCustomer.addOrder(LOCAL.order) />
				<cfset EntitySave(LOCAL.newCustomer) />
			</cfif>
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Order has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/order_detail.cfm?id=#LOCAL.order.getOrderId()#" />
			
		<cfelseif StructKeyExists(FORM,"add_new_product")>
		
			<cfset LOCAL.product = EntityLoadByPK("product",FORM.new_order_product_id) />
			<cfset LOCAL.shippingMethod = EntityLoadByPK("shipping_method",FORM.new_order_product_shipping_method_id) />
			<cfset LOCAL.image = EntityLoad("product_image",{product=LOCAL.product,isDefault=true},true) />
				
			<cfset LOCAL.orderProduct = EntityNew("order_product") />
			<cfset LOCAL.orderProduct.setDisplayName(LOCAL.product.getDisplayName()) />
			<cfset LOCAL.orderProduct.setRegularPrice(LOCAL.product.getPrice()) />
			<cfset LOCAL.orderProduct.setOrderPrice(LOCAL.product.getPrice()) />
			<cfset LOCAL.orderProduct.setTaxCategoryName(LOCAL.product.getTaxCategory().getDisplayName()) />
			<cfset LOCAL.orderProduct.setSubtotalAmount(FORM.new_order_product_quantity * LOCAL.product.getPrice()) />
			<cfset LOCAL.orderProduct.setTaxAmount(FORM.new_order_product_quantity * LOCAL.product.getPrice() * LOCAL.product.getTaxCategory().getRate()) />
			<cfset LOCAL.orderProduct.setShippingAmount(LOCAL.product.getPrice()) />
			<cfset LOCAL.orderProduct.setTotalAmount(FORM.new_order_product_quantity * LOCAL.product.getPrice() * (1+LOCAL.product.getTaxCategory().getRate())) />
			<cfset LOCAL.orderProduct.setQuantity(FORM.new_order_product_quantity) />
			<cfset LOCAL.orderProduct.setShippingCarrierName(LOCAL.shippingMethod.getShippingCarrier().getDisplayName()) />
			<cfset LOCAL.orderProduct.setShippingMethodName(LOCAL.shippingMethod.getDisplayName()) />
			<cfset LOCAL.orderProduct.setProductId(LOCAL.product.getProductId()) />
			<cfset LOCAL.orderProduct.setProductName(LOCAL.product.getDisplayName()) />
			<cfset LOCAL.orderProduct.setSku(LOCAL.product.getSku()) />
			<cfif NOT IsNull(LOCAL.image)>
				<cfset LOCAL.orderProduct.setImageName(LOCAL.image.getName()) />
			</cfif>
			
			<cfset LOCAL.newProductStatusType = EntityLoad("order_product_status_type",{displayName = "added"},true) />
			<cfset LOCAL.newProductStatus = EntityNew("order_product_status") />
			<cfset LOCAL.newProductStatus.setStartDatetime(Now()) />
			<cfset LOCAL.newProductStatus.setCurrent(true) />
			<cfset LOCAL.newProductStatus.setComments(Trim(FORM.new_order_product_comments)) />
			<cfset LOCAL.newProductStatus.setOrderProductStatusType(LOCAL.newProductStatusType) />
			<cfset EntitySave(LOCAL.newProductStatus) /> 
			
			<cfset LOCAL.orderProduct.addOrderProductStatus(LOCAL.newProductStatus) />
			
			<cfset EntitySave(LOCAL.orderProduct) /> 
			
			<cfset LOCAL.order.addProduct(LOCAL.orderProduct) />
			
			<cfset EntitySave(LOCAL.order) /> 
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"New product has been added.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#admin/#getPageName()#.cfm?id=#LOCAL.order.getOrderId()#" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.countries = EntityLoad("country") />
		<cfset LOCAL.pageData.provinces = EntityLoad("province") />
		<cfset LOCAL.pageData.paymentMethods = EntityLoad("payment_method") />
		<cfset LOCAL.pageData.shippingCarriers = EntityLoad("shipping_carrier",{},"displayName") />
		<cfset LOCAL.pageData.title = "New Order | #APPLICATION.applicationName#" />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.order = EntityLoadByPK("order",URL.id) />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
				<cfif NOT StructKeyExists(FORM,"same_as_shipping_address")>
					<cfset LOCAL.pageData.formData.same_as_shipping_address = "" />
				</cfif>
			<cfelse>
				<cfset LOCAL.pageData.formData.id = URL.id />
				<cfset LOCAL.pageData.formData.prefix = isNull(LOCAL.pageData.order.getPrefix())?"":LOCAL.pageData.order.getPrefix() />
				<cfset LOCAL.pageData.formData.suffix = isNull(LOCAL.pageData.order.getSuffix())?"":LOCAL.pageData.order.getSuffix() />
				<cfset LOCAL.pageData.formData.first_name = isNull(LOCAL.pageData.order.getFirstName())?"":LOCAL.pageData.order.getFirstName() />
				<cfset LOCAL.pageData.formData.middle_name = isNull(LOCAL.pageData.order.getMiddleName())?"":LOCAL.pageData.order.getMiddleName() />
				<cfset LOCAL.pageData.formData.last_name = isNull(LOCAL.pageData.order.getLastName())?"":LOCAL.pageData.order.getLastName() />
				<cfset LOCAL.pageData.formData.phone = isNull(LOCAL.pageData.order.getPhone())?"":LOCAL.pageData.order.getPhone() />
				<cfset LOCAL.pageData.formData.email = isNull(LOCAL.pageData.order.getEmail())?"":LOCAL.pageData.order.getEmail() />
				<cfset LOCAL.pageData.formData.coupon_code = isNull(LOCAL.pageData.order.getCoupon())?"":LOCAL.pageData.order.getCoupon().getCouponCode() />
				<cfset LOCAL.pageData.formData.comments = isNull(LOCAL.pageData.order.getComments())?"":LOCAL.pageData.order.getComments() />
				<cfset LOCAL.pageData.formData.same_as_shipping_address = "" />
				
				<cfset LOCAL.pageData.formData.shipping_company = isNull(LOCAL.pageData.order.getShippingCompany())?"":LOCAL.pageData.order.getShippingCompany() />
				<cfset LOCAL.pageData.formData.shipping_unit = isNull(LOCAL.pageData.order.getShippingUnit())?"":LOCAL.pageData.order.getShippingUnit() />
				<cfset LOCAL.pageData.formData.shipping_street = isNull(LOCAL.pageData.order.getShippingStreet())?"":LOCAL.pageData.order.getShippingStreet() />
				<cfset LOCAL.pageData.formData.shipping_city = isNull(LOCAL.pageData.order.getShippingCity())?"":LOCAL.pageData.order.getShippingCity() />
				<cfset LOCAL.pageData.formData.shipping_province_id = isNull(LOCAL.pageData.order.getShippingProvince())?"":LOCAL.pageData.order.getShippingProvince().getProvinceId() />
				<cfset LOCAL.pageData.formData.shipping_postal_code = isNull(LOCAL.pageData.order.getShippingPostalCode())?"":LOCAL.pageData.order.getShippingPostalCode() />
				<cfset LOCAL.pageData.formData.shipping_country_id = isNull(LOCAL.pageData.order.getShippingCountry())?"":LOCAL.pageData.order.getShippingCountry().getCountryId() />
				
				<cfset LOCAL.pageData.formData.billing_company = isNull(LOCAL.pageData.order.getBillingCompany())?"":LOCAL.pageData.order.getBillingCompany() />
				<cfset LOCAL.pageData.formData.billing_unit = isNull(LOCAL.pageData.order.getBillingUnit())?"":LOCAL.pageData.order.getBillingUnit() />
				<cfset LOCAL.pageData.formData.billing_street = isNull(LOCAL.pageData.order.getBillingStreet())?"":LOCAL.pageData.order.getBillingStreet() />
				<cfset LOCAL.pageData.formData.billing_city = isNull(LOCAL.pageData.order.getBillingCity())?"":LOCAL.pageData.order.getBillingCity() />
				<cfset LOCAL.pageData.formData.billing_province_id = isNull(LOCAL.pageData.order.getBillingProvince())?"":LOCAL.pageData.order.getBillingProvince().getProvinceId() />
				<cfset LOCAL.pageData.formData.billing_postal_code = isNull(LOCAL.pageData.order.getBillingPostalCode())?"":LOCAL.pageData.order.getBillingPostalCode() />
				<cfset LOCAL.pageData.formData.billing_country_id = isNull(LOCAL.pageData.order.getBillingCountry())?"":LOCAL.pageData.order.getBillingCountry().getCountryId() />
				
				<cfset LOCAL.pageData.formData.payment_method_id = isNull(LOCAL.pageData.order.getPaymentMethod())?"":LOCAL.pageData.order.getPaymentMethod().getPaymentMethodId() />
			
				<cfset LOCAL.pageData.formData.subtotal_amount = 0 />
				<cfset LOCAL.pageData.formData.shipping_amount = 0 />
				<cfset LOCAL.pageData.formData.tax_amount = 0 />
				<cfset LOCAL.pageData.formData.total_amount = 0 />
				
				<cfif NOT IsNull(LOCAL.pageData.order.getProducts())>
					<cfloop array="#LOCAL.pageData.order.getProducts()#" index="LOCAL.product">
						<cfset LOCAL.pageData.formData.subtotal_amount += LOCAL.product.getSubtotalAmount() />
						<cfset LOCAL.pageData.formData.shipping_amount += LOCAL.product.getShippingAmount() />
						<cfset LOCAL.pageData.formData.tax_amount += LOCAL.product.getTaxAmount() />
						<cfset LOCAL.pageData.formData.total_amount += LOCAL.product.getTotalAmount() />
					</cfloop>
				</cfif>
			</cfif>
		<cfelse>
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
				<cfif NOT StructKeyExists(FORM,"same_as_shipping_address")>
					<cfset LOCAL.pageData.formData.same_as_shipping_address = "" />
				</cfif>
			<cfelse>
				<cfset LOCAL.pageData.formData.id = "" />
				<cfset LOCAL.pageData.formData.prefix = "" />
				<cfset LOCAL.pageData.formData.suffix = "" />
				<cfset LOCAL.pageData.formData.first_name = "" />
				<cfset LOCAL.pageData.formData.middle_name = "" />
				<cfset LOCAL.pageData.formData.last_name = "" />
				<cfset LOCAL.pageData.formData.phone = "" />
				<cfset LOCAL.pageData.formData.email = "" />
				<cfset LOCAL.pageData.formData.coupon_code = "" />
				<cfset LOCAL.pageData.formData.comments = "" />
				<cfset LOCAL.pageData.formData.same_as_shipping_address = "" />
				
				<cfset LOCAL.pageData.formData.shipping_company = "" />
				<cfset LOCAL.pageData.formData.shipping_unit = "" />
				<cfset LOCAL.pageData.formData.shipping_street = "" />
				<cfset LOCAL.pageData.formData.shipping_city = "" />
				<cfset LOCAL.pageData.formData.shipping_province_id = "" />
				<cfset LOCAL.pageData.formData.shipping_postal_code = "" />
				<cfset LOCAL.pageData.formData.shipping_country_id = "" />
				
				<cfset LOCAL.pageData.formData.billing_company = "" />
				<cfset LOCAL.pageData.formData.billing_unit = "" />
				<cfset LOCAL.pageData.formData.billing_street = "" />
				<cfset LOCAL.pageData.formData.billing_city = "" />
				<cfset LOCAL.pageData.formData.billing_province_id = "" />
				<cfset LOCAL.pageData.formData.billing_postal_code = "" />
				<cfset LOCAL.pageData.formData.billing_country_id = "" />
				
				<cfset LOCAL.pageData.formData.payment_method_id = "" />
				
				<cfset LOCAL.pageData.formData.subtotal_amount = 0 />
				<cfset LOCAL.pageData.formData.shipping_amount = 0 />
				<cfset LOCAL.pageData.formData.tax_amount = 0 />
				<cfset LOCAL.pageData.formData.total_amount = 0 />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>