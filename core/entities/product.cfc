<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productId" column="product_id" fieldtype="id" generator="native">
	<cfproperty name="sku" column="sku" ormtype="string"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="logo" column="logo" ormtype="string"> 
	<cfproperty name="stock" column="stock" ormtype="integer"> 
	<cfproperty name="description" column="description" ormtype="string"> 
	<cfproperty name="detail" column="detail" ormtype="text"> 
	<cfproperty name="length" column="length" ormtype="float"> 
	<cfproperty name="width" column="width" ormtype="float"> 
	<cfproperty name="height" column="height" ormtype="float"> 
	<cfproperty name="weight" column="weight" ormtype="float"> 
	<cfproperty name="shippingFee" column="shipping_fee" ormtype="float"> 
	<cfproperty name="viewCount" column="view_count" ormtype="integer"> 
	<cfproperty name="useAdvancedPrices" column="use_advanced_prices" ormtype="boolean"> 
	<cfproperty name="brand" fieldtype="many-to-one" cfc="brand" fkcolumn="brand_id">
	<cfproperty name="productType" fieldtype="many-to-one" cfc="product_type" fkcolumn="product_type_id">
	<cfproperty name="taxCategory" fieldtype="many-to-one" cfc="tax_category" fkcolumn="tax_category_id">
	<cfproperty name="productAttributeRelas" type="array" fieldtype="one-to-many" cfc="product_attribute_rela" fkcolumn="product_id" singularname="productAttributeRela" cascade="delete-orphan">
	<cfproperty name="productTags" type="array" fieldtype="one-to-many" cfc="product_tag_rela" fkcolumn="product_id" singularname="productTag" cascade="delete-orphan">
	<cfproperty name="productVideos" type="array" fieldtype="one-to-many" cfc="product_video" fkcolumn="product_id" singularname="productVideo" cascade="delete-orphan">
	<cfproperty name="parentProduct" fieldtype="many-to-one" cfc="product" fkcolumn="parent_product_id">
	<cfproperty name="subProducts" type="array" fieldtype="one-to-many" cfc="product" fkcolumn="parent_product_id" singularname="subProduct" cascade="delete-orphan">
	<cfproperty name="reviews" type="array" fieldtype="one-to-many" cfc="review" fkcolumn="product_id" singularname="review" cascade="delete-orphan">
	<cfproperty name="images" type="array" fieldtype="one-to-many" cfc="product_image" fkcolumn="product_id" singularname="image" cascade="delete-orphan" orderby="rank">
	<cfproperty name="productCustomerGroupRelas" type="array" fieldtype="one-to-many" cfc="product_customer_group_rela" fkcolumn="product_id" singularname="productCustomerGroupRela" cascade="delete-orphan">
	<cfproperty name="productShippingCarrierRelas" type="array" fieldtype="one-to-many" cfc="product_shipping_carrier_rela" fkcolumn="product_id" singularname="productShippingCarrierRela" cascade="delete-orphan">
	<cfproperty name="categories" fieldtype="many-to-many" cfc="category" linktable="category_product_rela" fkcolumn="product_id" inversejoincolumn="category_id" singularname="category">
	<cfproperty name="relatedProducts" fieldtype="many-to-many" cfc="product" linktable="related_product_rela" fkcolumn="product_id" inversejoincolumn="related_parent_product_id" singularname="relatedProduct">
	<cfproperty name="relatedParentProducts" fieldtype="many-to-many" cfc="product" linktable="related_product_rela" fkcolumn="related_parent_product_id" inversejoincolumn="product_id" singularname="relatedParentProduct">
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
	<!--- for sorting only --->
	<cfproperty name="price" column="price" ormtype="float"> 
	<cfproperty name="soldCount" column="sold_count" ormtype="integer"> 
	<cfproperty name="reviewCount" column="review_count" ormtype="integer"> 
	<cfproperty name="starCount" column="star_count" ormtype="integer"> 
	
	<!------------------------------------------------------------------------------->	
	<cffunction name="setPriceMV" access="public" output="false" returnType="void">
		<cfargument name="price" type="numeric" required="true">
		
		<cfif getProductType().getName() EQ "option">
			<cfset getParentProduct().setPrice(ARGUMENTS.price) />
		<cfelse>
			<cfset setPrice(ARGUMENTS.price) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="setSoldCountMV" access="public" output="false" returnType="void">
		<cfargument name="soldCount" type="numeric" required="true">
		
		<cfif getProductType().getName() EQ "option">
			<cfset getParentProduct().setSoldCount(ARGUMENTS.soldCount) />
		<cfelse>
			<cfset setSoldCount(ARGUMENTS.soldCount) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="setReviewCountMV" access="public" output="false" returnType="void">
		<cfargument name="reviewCount" type="numeric" required="true">
		
		<cfif getProductType().getName() EQ "option">
			<cfset getParentProduct().setReviewCount(ARGUMENTS.reviewCount) />
		<cfelse>
			<cfset setReviewCount(ARGUMENTS.reviewCount) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getSoldCountMV" access="public" output="false" returnType="numeric">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getSoldCount() />
		<cfelse>
			<cfreturn getSoldCount() />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getReviewCountMV" access="public" output="false" returnType="numeric">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getReviewCount() />
		<cfelse>
			<cfreturn getReviewCount() />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="setStarCountMV" access="public" output="false" returnType="void">
		<cfargument name="starCount" type="numeric" required="true">
		
		<cfif getProductType().getName() EQ "option">
			<cfset getParentProduct().setStarCount(ARGUMENTS.starCount) />
		<cfelse>
			<cfset setStarCount(ARGUMENTS.starCount) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getStarCountMV" access="public" output="false" returnType="numeric">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getStarCount() />
		<cfelse>
			<cfreturn getStarCount() />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDescriptionMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getDescription() />
		<cfelse>
			<cfreturn getDescription() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getNameMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getName() />
		<cfelse>
			<cfreturn getName() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDisplayNameMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getDisplayName() />
		<cfelse>
			<cfreturn getDisplayName() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getIsEnabledMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getIsEnabled() />
		<cfelse>
			<cfreturn getIsEnabled() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getTitleMV" access="public" output="false" returnType="any">
		<cfset var LOCAL = {} />
		<cfset LOCAL.title = "" />
		
		<cfif getProductType().getName() EQ "option">
			<cfif NOT IsNull(getParentProduct().getTitle())>
				<cfset LOCAL.title = getParentProduct().getTitle() />
			<cfelse>
				<cfset LOCAL.title = "#getParentProduct().getDisplayName()# | #APPLICATION.applicationName#" />
			</cfif>
		<cfelse>
			<cfif NOT IsNull(getTitle())>
				<cfset LOCAL.title =getTitle() />
			<cfelse>
				<cfset LOCAL.title = "#getDisplayName()# | #APPLICATION.applicationName#" />
			</cfif>
		</cfif>
		
		<cfreturn LOCAL.title />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getKeywordsMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getKeywords() />
		<cfelse>
			<cfreturn getKeywords() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDetailMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getDetail() />
		<cfelse>
			<cfreturn getDetail() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getLengthMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getLength() />
		<cfelse>
			<cfreturn getLength() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getWidthMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getWidth() />
		<cfelse>
			<cfreturn getWidth() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getHeightMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getHeight() />
		<cfelse>
			<cfreturn getHeight() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getWeightMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getWeight() />
		<cfelse>
			<cfreturn getWeight() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getTaxCategoryMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getTaxCategory() />
		<cfelse>
			<cfreturn getTaxCategory() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getProductVideosMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getProductVideos() />
		<cfelse>
			<cfreturn getProductVideos() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getReviewsMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getReviews() />
		<cfelse>
			<cfreturn getReviews() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getImagesMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getImages() />
		<cfelse>
			<cfreturn getImages() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getProductShippingCarrierRelasMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getProductShippingCarrierRelas() />
		<cfelse>
			<cfreturn getProductShippingCarrierRelas() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getCategoriesMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getCategories() />
		<cfelse>
			<cfreturn getCategories() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getRelatedProductsMV" access="public" output="false" returnType="any">
		
		<cfif getProductType().getName() EQ "option">
			<cfreturn getParentProduct().getRelatedProducts() />
		<cfelse>
			<cfreturn getRelatedProducts() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeAllCategories" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getCategories())>
			<cfset ArrayClear(getCategories()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeSubProducts" access="public" output="false" returnType="void">
		<cfset var LOCAL = {} />
		<cfif NOT IsNull(getSubProducts())>
			<cfloop array="#getSubProducts()#" index="LOCAL.product">
				<cfset LOCAL.product.setIsDeleted(true) />
				<cfset EntitySave(LOCAL.product) />
			</cfloop>
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getSubProducts" access="public" output="false" returnType="array">
		<cfreturn EntityLoad("product",{parentProduct = this}) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeProductAttributeRelas" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getProductAttributeRelas())>
			<cfset ArrayClear(getProductAttributeRelas()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeProductCustomerGroupRelas" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getProductCustomerGroupRelas())>
			<cfset ArrayClear(getProductCustomerGroupRelas()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeProductShippingCarrierRelas" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getProductShippingCarrierRelas())>
			<cfset ArrayClear(getProductShippingCarrierRelas()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getPrice" access="public" output="false" returnType="numeric">
		<cfargument name="customerGroupId" type="numeric" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		
		<cfset var customerGroup = EntityLoadByPK("customer_group",ARGUMENTS.customerGroupId) />
		<cfset var product = EntityLoadByPK("product",getProductId()) />
		<cfset var productCustomeGroupRela = EntityLoad("product_customer_group_rela",{customerGroup=customerGroup,product=product},true) />
		<cfset var currency = EntityLoadByPK("currency",ARGUMENTS.currencyId) />
		<cfset var price = 0 />
		
		<cfif NOT IsNull(productCustomeGroupRela)>
			<cfif IsNumeric(productCustomeGroupRela.getSpecialPrice())>
				<cfif IsDate(productCustomeGroupRela.getSpecialPriceFromDate()) AND IsDate(productCustomeGroupRela.getSpecialPriceToDate())>
					<cfif 	DateCompare(productCustomeGroupRela.getSpecialPriceFromDate(), DateFormat(Now())) LTE 0
							AND
							DateCompare(DateFormat(Now()), productCustomeGroupRela.getSpecialPriceToDate()) LTE 0>
						<cfset price = productCustomeGroupRela.getSpecialPrice() />
					<cfelse>
						<cfset price = productCustomeGroupRela.getPrice() />
					</cfif>
				<cfelseif IsDate(productCustomeGroupRela.getSpecialPriceFromDate())>
					<cfif DateCompare(productCustomeGroupRela.getSpecialPriceFromDate(), DateFormat(Now())) LTE 0>
						<cfset price = productCustomeGroupRela.getSpecialPrice() />
					<cfelse>
						<cfset price = productCustomeGroupRela.getPrice() />
					</cfif>
				<cfelseif IsDate(productCustomeGroupRela.getSpecialPriceToDate())>
					<cfif 	DateCompare(DateFormat(Now()), productCustomeGroupRela.getSpecialPriceToDate()) LTE 0>
						<cfset price = productCustomeGroupRela.getSpecialPrice() />
					<cfelse>
						<cfset price = productCustomeGroupRela.getPrice() />
					</cfif>
				<cfelse>
					<cfset price = productCustomeGroupRela.getPrice() />
				</cfif>
			<cfelse>
				<cfset price = productCustomeGroupRela.getPrice() />
			</cfif>
		</cfif>
		
		<cfreturn NumberFormat(price * currency.getMultiplier(),"0.00") />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getOriginalPrice" access="public" output="false" returnType="numeric">
		<cfargument name="customerGroupId" type="numeric" required="true">
		<cfargument name="currencyId" type="numeric" required="true">
		
		<cfset var customerGroup = EntityLoadByPK("customer_group",ARGUMENTS.customerGroupId) />
		<cfset var product = EntityLoadByPK("product",getProductId()) />
		<cfset var productCustomeGroupRela = EntityLoad("product_customer_group_rela",{customerGroup=customerGroup,product=product},true) />
		<cfset var currency = EntityLoadByPK("currency",ARGUMENTS.currencyId) />
		<cfset var price = 0 />
		
		<cfif NOT IsNull(productCustomeGroupRela)>
				<cfset price = productCustomeGroupRela.getPrice() />
		</cfif>
		
		<cfreturn NumberFormat(price * currency.getMultiplier(),"0.00") />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDefaultImageLinkMV" access="public" output="false" returnType="string">
		<cfargument name="type" type="string" required="false" default="" />
		
		<cfif getProductType().getName() EQ "option">
			<cfset var imageLink = getParentProduct().getDefaultImageLink(argumentCollection = ARGUMENTS) />
		<cfelse>
			<cfset var imageLink = getDefaultImageLink(argumentCollection = ARGUMENTS) />
		</cfif>
		
		<cfreturn imageLink />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDefaultImageLink" access="public" output="false" returnType="string">
		<cfargument name="type" type="string" required="false" default="" />
	
		<cfset var imageType = "" />
		<cfif Trim(ARGUMENTS.type) NEQ "">
			<cfset imageType = "#Trim(ARGUMENTS.type)#_" />
		</cfif>
		
		<cfset var imageLink = "" />
		<cfset var productImg = EntityLoad("product_image",{product = this, isDefault = true},true) />
		
		<cfif IsNull(productImg)>
			<cfif NOT IsNull(getImages()) AND ArrayLen(getImages()) GT 0>
				<cfset imageLink = "#APPLICATION.urlAdmin#images/uploads/product/#getProductId()#/#imageType##getImages()[1].getName()#" />
			<cfelse>
				<cfset imageLink = "#APPLICATION.urlAdmin#images/site/no_image_available.png" />
			</cfif>
		<cfelse>
			<cfset imageLink = "#APPLICATION.urlAdmin#images/uploads/product/#getProductId()#/#imageType##productImg.getName()#" />
		</cfif>
		
		<cfreturn imageLink />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="isFreeShippingMV" access="public" output="false" returnType="boolean">
		
		<cfif getProductType().getName() EQ "option">
			<cfset var retValue = getParentProduct().isFreeShipping() />
		<cfelse>
			<cfset var retValue = isFreeShipping() />
		</cfif>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="isFreeShipping" access="public" output="false" returnType="boolean">
		<cfset var LOCAL = {} />
		<cfset var retValue = false />
		
		<cfquery name="LOCAL.checkFreeShipping">
			SELECT	1
			FROM	product_shipping_method_rela psmr
			JOIN	shipping_method sm ON psmr.shipping_method_id = sm.shipping_method_id
			WHERE	sm.name = 'free shipping'
			AND		psmr.product_id = #getProductId()#
		</cfquery>
		
		<cfif LOCAL.checkFreeShipping.recordCount GT 0>
			<cfset retValue = true />
		</cfif>
		
		<cfreturn retValue />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDetailPageURLMV" access="public" output="false" returnType="string">
		
		<cfif getProductType().getName() EQ "option">
			<cfset var pageUrl = getParentProduct().getDetailPageURL() />
		<cfelse>
			<cfset var pageUrl = getDetailPageURL() />
		</cfif>
		
		<cfreturn pageUrl />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDetailPageURL" access="public" output="false" returnType="string">
		<cfreturn "#APPLICATION.urlAdmin#product_detail.cfm/#URLEncodedFormat(getName())#/#getProductId()#" />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getTaxRateMV" access="public" output="false" returnType="numeric">
		<cfargument name="provinceId" type="numeric" required="true" />
		<cfargument name="currencyId" type="numeric" required="true">
		
		<cfset var currency = EntityLoadByPK("currency",ARGUMENTS.currencyId) />
		
		<cfif getProductType().getName() EQ "option">
			<cfset var taxRate = getParentProduct().getTaxRate(argumentCollection = ARGUMENTS) />
		<cfelse>
			<cfset var taxRate = getTaxRate(argumentCollection = ARGUMENTS) />
		</cfif>
		
		<cfreturn NumberFormat(taxRate * currency.getMultiplier(),"0.00") />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getTaxRate" access="public" output="false" returnType="numeric">
		<cfargument name="provinceId" type="numeric" required="true" />
		
		<cfset var tax = EntityLoad("tax",{province=EntityLoadByPK("province",ARGUMENTS.provinceId), taxCategory=getTaxCategory()},true) />
		
		<cfreturn tax.getRate() />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getShippingFeeMV" access="public" output="false" returnType="numeric">
		<cfargument name="address" type="struct" required="true" />
		<cfargument name="shippingMethodId" type="numeric" required="true" />
		<cfargument name="customerGroupId" type="numeric" required="true" />
		<cfargument name="currencyId" type="numeric" required="true">
		
		<cfset var currency = EntityLoadByPK("currency",ARGUMENTS.currencyId) />
		
		<cfif getProductType().getName() EQ "option">
			<cfset var shippingFee = getParentProduct().getShippingFee(argumentCollection = ARGUMENTS) />
		<cfelse>
			<cfset var shippingFee = getShippingFee(argumentCollection = ARGUMENTS) />
		</cfif>
		
		<cfreturn NumberFormat(shippingFee * currency.getMultiplier(),"0.00") />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getShippingFee" access="public" output="false" returnType="numeric">
		<cfargument name="address" type="struct" required="true" />
		<cfargument name="shippingMethodId" type="numeric" required="true" />
		<cfargument name="customerGroupId" type="numeric" required="true" />
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.shippingMethod = EntityLoadByPK("shipping_method",ARGUMENTS.shippingMethodId) />
		<cfset LOCAL.productShippingMethodRela = EntityLoad("product_shipping_method_rela",{product = this,shippingMethod = LOCAL.shippingMethod},true) />
			
		<cfif LOCAL.productShippingMethodRela.getUseDefaultPrice() EQ false AND NOT IsNull(getWeight())>
			<cfset LOCAL.componentName = LOCAL.shippingMethod.getShippingCarrier().getComponent() />
			<cfset LOCAL.shippingComponent = new "#APPLICATION.componentPathRoot#core.shipping.#LOCAL.componentName#"() />
						
			<cfset LOCAL.shippingComponent.setShippingMethodId(ARGUMENTS.shippingMethodId) />
			<cfset LOCAL.shippingComponent.setAddress(ARGUMENTS.address) />
			<cfset LOCAL.shippingComponent.setProductId(getProductId()) />
			
			<cfset LOCAL.shippingFee = LOCAL.shippingComponent.getShippingFee() />
		<cfelse>
			<cfset LOCAL.shippingFee = LOCAL.productShippingMethodRela.getPrice() />
		</cfif>
		
		<cfreturn LOCAL.shippingFee />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="removeAllRelatedProducts" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getRelatedProducts())>
			<cfset ArrayClear(getRelatedProducts()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getLogoURL" access="public" output="false" returnType="string">
		<cfreturn "#APPLICATION.urlAdmin#products/#getProductId()#/logo/#getLogo()#" />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getApprovedReviews" access="public" output="false" returnType="array">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.reviewStatusType = EntityLoad("review_status_type", {name = "approved"}, true)> 
		<cfset LOCAL.reviews = EntityLoad("review", {product = this, reviewStatusType = LOCAL.reviewStatusType})>
		
		<cfreturn  LOCAL.reviews />
	</cffunction>
	<!------------------------------------------------------------------------------->
</cfcomponent>
