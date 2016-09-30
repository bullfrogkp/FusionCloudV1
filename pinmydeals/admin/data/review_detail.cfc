<cfcomponent extends="core.pages.page">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfset LOCAL.review = EntityLoadByPK("review", FORM.id)>
			<cfset LOCAL.reviewStatusType = EntityLoadByPK('review_status_type',FORM.review_status_type_id) />
			<cfset LOCAL.review.setReviewStatusType(LOCAL.reviewStatusType) />
			<!--- add code when review is deleted too later --->
			<!--- for product sorting --->
			<cfif LOCAL.reviewStatusType.getName() EQ "approved">
				<cfset LOCAL.product = LOCAL.review.getProduct() />
				<cfif IsNull(LOCAL.product.getReviewCountMV())>
					<cfset LOCAL.product.setReviewCountMV(1) />
				<cfelse>
					<cfset LOCAL.product.setReviewCountMV(LOCAL.product.getReviewCountMV() + 1) />
				</cfif>
				
				<cfset LOCAL.pageData.stars = 0 />
				<cfloop array="#LOCAL.product.getReviews()#" index="review">
					<cfset LOCAL.pageData.stars += review.getRating() />
				</cfloop>
				<cfset LOCAL.product.setReviewCountMV(Ceiling(LOCAL.pageData.stars / ArrayLen(LOCAL.product.getReviews()))) />
				
				<cfset EntitySave(LOCAL.product) />
			</cfif>
			
			<cfset EntitySave(LOCAL.review) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Review has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite##getPageName()#.cfm?id=#LOCAL.review.getReviewId()#" />
			
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.review = EntityLoadByPK("review", URL.id)> 
		<cfset LOCAL.pageData.reviewStatusTypes = EntityLoad("review_status_type")> 
		<cfset LOCAL.pageData.title = "#LOCAL.pageData.review.getSubject()# | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.deleteButtonClass = "" />	
		
		<cfif LOCAL.pageData.review.getIsNew() EQ true>
			<cfset LOCAL.pageData.review.setIsNew(false) />
			<cfset EntitySave(LOCAL.pageData.review) />
		</cfif>
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.subject = isNull(LOCAL.pageData.review.getSubject())?"":LOCAL.pageData.review.getSubject() />
			<cfset LOCAL.pageData.formData.rating = isNull(LOCAL.pageData.review.getRating())?"":LOCAL.pageData.review.getRating() />
			<cfset LOCAL.pageData.formData.message = isNull(LOCAL.pageData.review.getMessage())?"":LOCAL.pageData.review.getMessage() />
		</cfif>
		
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>