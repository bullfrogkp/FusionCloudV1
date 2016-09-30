<cfcomponent extends="core.pages.page">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif Trim(FORM.coupon_code) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid coupon code.") />
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
			<cfset LOCAL.coupon = EntityLoadByPK("coupon", FORM.id)> 
			<cfset LOCAL.coupon.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.coupon.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.coupon = EntityNew("coupon") />
			<cfset LOCAL.coupon.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.coupon.setCreatedDatetime(Now()) />
			<cfset LOCAL.coupon.setIsDeleted(false) />
		</cfif>
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.coupon.setCouponCode(Trim(FORM.coupon_code)) />
			<cfset LOCAL.coupon.setThresholdAmount(Trim(FORM.threshold_amount)) />
			<cfset LOCAL.coupon.setCouponStatusType(EntityLoadByPK("coupon_status_type", FORM.coupon_status_type_id)) />
			<cfset LOCAL.coupon.setDiscountType(EntityLoadByPK("discount_type",FORM.discount_type_id)) />
			
			<cfif IsDate(Trim(FORM.start_date))>
				<cfset LOCAL.coupon.setStartDate(Trim(FORM.start_date)) />
			</cfif>
			<cfif IsDate(Trim(FORM.end_date))>
				<cfset LOCAL.coupon.setEndDate(Trim(FORM.end_date)) />
			</cfif>
			
			<cfset EntitySave(LOCAL.coupon) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Coupon has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite##getPageName()#.cfm?id=#LOCAL.coupon.getCouponId()#" />
			
		<cfelseif StructKeyExists(FORM,"delete_item")>
			
			<cfset LOCAL.coupon.setIsDeleted(true) />
			<cfset EntitySave(LOCAL.coupon) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Coupon #LOCAL.coupon.getCouponCode()# has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#coupons.cfm" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		<cfset LOCAL.pageData.discountTypes = EntityLoad("discount_type") />
		<cfset LOCAL.pageData.couponStatusTypes = EntityLoad("coupon_status_type") />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.coupon = EntityLoadByPK("coupon", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.coupon.getCouponCode()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />	
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.coupon_code = isNull(LOCAL.pageData.coupon.getCouponCode())?"":LOCAL.pageData.coupon.getCouponCode() />
				<cfset LOCAL.pageData.formData.threshold_amount = isNull(LOCAL.pageData.coupon.getThresholdAmount())?"":LOCAL.pageData.coupon.getThresholdAmount() />
				<cfset LOCAL.pageData.formData.start_date = isNull(LOCAL.pageData.coupon.getStartDate())?"":DateFormat(LOCAL.pageData.coupon.getStartDate(),"mm/dd/yyyy") />
				<cfset LOCAL.pageData.formData.end_date = isNull(LOCAL.pageData.coupon.getEndDate())?"":DateFormat(LOCAL.pageData.coupon.getEndDate(),"mm/dd/yyyy") />
				<cfset LOCAL.pageData.formData.discount_type_id = isNull(LOCAL.pageData.coupon.getDiscountType())?"":LOCAL.pageData.coupon.getDiscountType().getDiscountTypeId() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Coupon | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.coupon_code = "" />
				<cfset LOCAL.pageData.formData.threshold_amount = "" />
				<cfset LOCAL.pageData.formData.start_date = "" />
				<cfset LOCAL.pageData.formData.end_date = "" />
				<cfset LOCAL.pageData.formData.discount_type_id = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>