<cfcomponent extends="core.pages.page">
	<!------------------------------------------------------------------------------->	
	<cffunction name="_loadPageData" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.categories = EntityLoad("category",{isSpecial = false, isEnabled = true, isDeleted = false},"rank Asc") />
		<cfset LOCAL.pageData.currencies =  EntityLoad("currency", {isEnabled=true}) />
		<cfset LOCAL.pageData.slogan =  "FREE SHIPPING ON ALL US ORDERS this week!" />
		
		<!--- set tracking entity --->
		<cfset LOCAL.trackingEntity = EntityLoad("tracking_entity",{cfid = COOKIE.cfid, cftoken = COOKIE.cftoken}, true) />
		<cfif IsNull(LOCAL.trackingEntity)>
			<cfset LOCAL.trackingEntity = EntityNew("tracking_entity") />
			<cfset LOCAL.trackingEntity.setCfid(COOKIE.cfid) />
			<cfset LOCAL.trackingEntity.setCftoken(COOKIE.cftoken) />
		</cfif>
		<cfset LOCAL.trackingEntity.setLastAccessDatetime(Now()) />
		<cfset EntitySave(LOCAL.trackingEntity) />
		
		<cfset LOCAL.pageData.trackingEntityId = LOCAL.trackingEntity.getTrackingEntityId() />
		
		<!--- set cart --->
		<cfset LOCAL.pageData.cart = new "core.entities.cart"(	trackingEntityId = LOCAL.trackingEntity.getTrackingEntityId()
															, 	customerGroupId = getSessionData().user.customerGroupId
															, 	currencyId = getSessionData().currency.id) />
		<cfif 	ListLen(getCgiData().PATH_INFO,"/") EQ 6 
				AND
				(
					Trim(ListGetAt(getCgiData().PATH_INFO,6,"/")) NEQ "-"
					OR
					Trim(ListGetAt(getCgiData().PATH_INFO,2,"/")) NEQ "-"
				)>
				
			<cfif Trim(ListGetAt(getCgiData().PATH_INFO,6,"/")) EQ "-">
				<cfset LOCAL.pageData.searchText = "" />
			<cfelse>
				<cfset LOCAL.pageData.searchText = Trim(ListGetAt(getCgiData().PATH_INFO,6,"/")) />
			</cfif>
			
			<cfif Trim(ListGetAt(getCgiData().PATH_INFO,2,"/")) EQ "-">
				<cfset LOCAL.pageData.categoryId = 0 />
			<cfelse>
				<cfset LOCAL.pageData.categoryId = ListGetAt(getCgiData().PATH_INFO,2,"/") />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.searchText = "" />
			<cfset LOCAL.pageData.categoryId = 0 />
		</cfif>
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="_loadModuleData" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.site = EntityLoad("site", {name = APPLICATION.applicationName}, true) />
		<cfset LOCAL.modules = EntityLoad("site_module",{site = LOCAL.site, isDeleted = false, isEnabled = true}) />
		
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.moduleObj = new "core.modules.#LOCAL.module.getName()#"(formData = getFormData(), urlData = getUrlData(), cgiData = getCgiData(), sessionData = getSessionData()) />
			<cfset StructInsert(LOCAL.retStruct, LOCAL.module.getName(), LOCAL.moduleObj.getFrontendData()) />
		</cfloop>
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="_loadModuleView" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.site = EntityLoad("site", {name = APPLICATION.applicationName}, true) />
		<cfset LOCAL.modules = EntityLoad("site_module",{site = LOCAL.site, isDeleted = false, isEnabled = true}) />
		
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.moduleObj = new "core.modules.#LOCAL.module.getName()#"(formData = getFormData(), urlData = getUrlData(), cgiData = getCgiData(), sessionData = getSessionData()) />
			<cfset StructInsert(LOCAL.retStruct, LOCAL.module.getName(), LOCAL.moduleObj.getFrontendView()) />
		</cfloop>
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
	
		<cfif (StructKeyExists(FORM,"search_product") OR StructKeyExists(FORM,"search_product.x")) AND (Trim(getFormaData().search_text) NEQ "" OR getFormaData().search_category_id NEQ 0)>
		
			<cfif Trim(getFormaData().search_text) EQ "">
				<cfset LOCAL.searchText = "-" />
			<cfelse>
				<cfset LOCAL.searchText = URLEncodedFormat(Trim(getFormaData().search_text)) />
			</cfif>
			
			<cfif getFormaData().search_category_id EQ 0>
				<cfset LOCAL.searchCategoryId = "-" />
				<cfset LOCAL.searchCategoryName = "-" />
			<cfelse>
				<cfset LOCAL.category = EntityLoadByPK("category",getFormaData().search_category_id) />
				<cfset LOCAL.searchCategoryId = getFormaData().search_category_id />
				<cfset LOCAL.searchCategoryName = URLEncodedFormat(LOCAL.category.getName()) />
			</cfif>
		
			<cfset LOCAL.pathInfo = "/#LOCAL.searchCategoryName#/#LOCAL.searchCategoryId#/1/1/-/#LOCAL.searchText#/" />
				
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#products.cfm#LOCAL.pathInfo#" />
			
		<cfelseif StructKeyExists(FORM,"currency_id")>
		
			<cfset LOCAL.newCurrency = EntityLoadByPK("currency",getFormaData().currency_id) />
			<cfset SESSION.currency.id = LOCAL.newCurrency.getCurrencyId() />
			<cfset SESSION.currency.code = LOCAL.newCurrency.getCode() />
			<cfset SESSION.currency.locale = LOCAL.newCurrency.getLocale() />
			
			<cfif StructKeyExists(SESSION,"cart")>
				<cfset SESSION.cart.setCurrencyId(SESSION.currency.id) />
				<cfset SESSION.cart.calculate() />
			</cfif>
		
		<cfelseif StructKeyExists(FORM,"subscribe_customer")>
		
			<cfif IsValid("email",Trim(getFormaData().subscribe_email))>
				<!--- get the enabled customer with the same email --->
				<cfset LOCAL.existingActiveCustomer = EntityLoad("customer",{email = Trim(getFormaData().subscribe_email), isEnabled = true, isDeleted = false}, true) />
				<cfif NOT IsNull(LOCAL.existingActiveCustomer)>
					<cfset LOCAL.existingActiveCustomer.setSubscribed(true) />
					<cfset EntitySave(LOCAL.existingActiveCustomer) />
				<cfelse>
					<!--- get the latest disable customer with the same email --->
					<cfset LOCAL.existingInActiveCustomerArray = EntityLoad("customer",{email = Trim(getFormaData().subscribe_email), isEnabled = false, isDeleted = false}, "createdDatetime Desc") />
					<cfif NOT ArrayIsEmpty(LOCAL.existingInActiveCustomerArray)>
						<cfset LOCAL.existingInActiveCustomer = LOCAL.existingInActiveCustomerArray[1] />
						<cfset LOCAL.existingInActiveCustomer.setSubscribed(true) />
						<cfset EntitySave(LOCAL.existingInActiveCustomer) />
					<cfelse>
						<cfset LOCAL.customer = EntityNew("customer") />
						<cfset LOCAL.customer.setCreatedUser(SESSION.user.userName) />
						<cfset LOCAL.customer.setCreatedDatetime(Now()) />
						<cfset LOCAL.customer.setIsDeleted(false) />
						<cfset LOCAL.customer.setIsNew(true) />
						<cfset LOCAL.customer.setIsEnabled(false) />
						<cfset LOCAL.customer.setEmail(Trim(getFormaData().subscribe_email)) />
						<cfset LOCAL.customer.setSubscribed(true) />
						
						<cfset LOCAL.defaultCustomerGroup = EntityLoad("customer_group",{isDefault=true},true) />
						<cfset LOCAL.customer.setCustomerGroup(LOCAL.defaultCustomerGroup) />
						
						<cfset EntitySave(LOCAL.customer) />
					</cfif>
				</cfif>
				
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#subscription_done.cfm" />
			</cfif>
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	<!------------------------------------------------------------------------------->	
	<cffunction name="processURLDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(getUrlData(),"logout")>
			<cfset SESSION.user.customerId = "" />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#index.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	<!------------------------------------------------------------------------------->	
</cfcomponent>