<cfcomponent extends="core.pages.page"> 
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif StructKeyExists(FORM,"add_review")>
			<cfset LOCAL.review = EntityNew("review") />
			<cfset LOCAL.review.setReviewerName(Trim(FORM.reviewer_name)) />
			<cfset LOCAL.review.setSubject(Trim(FORM.review_subject)) />
			<cfset LOCAL.review.setRating(FORM.review_rating) />
			<cfset LOCAL.review.setMessage(Trim(FORM.review_message)) />			
			<cfset LOCAL.review.setCreatedDatetime(Now()) />			
			<cfset LOCAL.review.setCreatedUser(SESSION.user.userName) />			
			<cfset LOCAL.review.setIsNew(true) />			
			<cfset LOCAL.review.setIsDeleted(false) />			
			<cfset LOCAL.review.setProduct(EntityLoadByPK("product",FORM.current_product_id)) />			
			<cfset LOCAL.review.setReviewStatusType(EntityLoad("review_status_type",{name = "pending"},true)) />
			<cfset EntitySave(LOCAL.review) />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="_loadPageData" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.productId = ListGetAt(getCgiData().PATH_INFO,2,"/")>
		
		<cfset LOCAL.pageData.product = EntityLoadByPK("product",LOCAL.productId) />
		<cfset LOCAL.pageData.product.setViewCount(LOCAL.pageData.product.getViewCount() + 1) />

		<cfset LOCAL.pageData.title = LOCAL.pageData.product.getTitleMV() />
		<cfset LOCAL.pageData.description = LOCAL.pageData.product.getDescriptionMV() />
		<cfset LOCAL.pageData.keywords = LOCAL.pageData.product.getKeywordsMV() />
		
		<cfset LOCAL.trackingEntity = EntityLoad("tracking_entity",{cfid = COOKIE.cfid, cftoken = COOKIE.cftoken}, true) />
		<cfset LOCAL.history = new "core.entities.history"(	trackingEntity = LOCAL.trackingEntity) />
		<cfset LOCAL.history.addHistoryItem(productId = LOCAL.productId) />
														
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>