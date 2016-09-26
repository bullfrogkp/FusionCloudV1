<cfcomponent extends="service" output="false" accessors="true">
    <cfproperty name="parentProductId" type="numeric"> 
    <cfproperty name="categoryId" type="numeric"> 
    <cfproperty name="sortTypeId" type="numeric"> 
    <cfproperty name="productTypeList" type="string"> 
    <cfproperty name="filters" type="struct"> 

	<cffunction name="_getQuery" output="false" access="private" returntype="array">
		<cfargument name="getCount" type="boolean" required="false" default="false" />
		<cfset LOCAL = {} />
		
		<cfif ARGUMENTS.getCount EQ false>
			<cfset LOCAL.ormOptions = getPaginationStruct() />
		<cfelse>
			<cfset LOCAL.ormOptions = {} />
		</cfif>
	   
		<cfquery name="LOCAL.query" ormoptions="#LOCAL.ormOptions#" dbtype="hql">	
			<cfif ARGUMENTS.getCount EQ true>
			SELECT COUNT(p.productId) 
			</cfif>
			FROM product p
			WHERE 1=1
			<cfif getSearchKeywords() NEQ "">	
			AND	(p.displayName like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" /> OR keywords like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" /> OR description like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" />)
			</cfif>
			
			<cfif getProductTypeList() NEQ "">
			AND	p.productType.name IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#getProductTypeList()#" />)
			</cfif>
			
			<cfif NOT IsNull(getId())>
			AND p.productId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
			AND p.isEnabled = <cfqueryparam cfsqltype="cf_sql_bit" value="#getIsEnabled()#" />
			</cfif>
			<cfif NOT IsNull(getIsDeleted())>
			AND p.isDeleted = <cfqueryparam cfsqltype="cf_sql_bit" value="#getIsDeleted()#" />
			</cfif>
			<cfif NOT IsNull(getCategoryId())>
			AND	(
					EXISTS (FROM  p.categories c WHERE c.categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getCategoryId()#" />)
					OR
					EXISTS (FROM  p.categories c WHERE c.parentCategory.categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getCategoryId()#" />)
					OR
					EXISTS (FROM  p.categories c WHERE c.parentCategory.parentCategory.categoryId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getCategoryId()#" />)
				)
			</cfif>
			<cfif NOT IsNull(getFilters())>
				<cfloop collection="#getFilters()#" item="LOCAL.filterId">
				AND	EXISTS (FROM    p.productAttributeRelas par 
							JOIN	par.attributeValues av
							WHERE	av.value = (SELECT	fv.value
												FROM	filter_value fv
												JOIN	fv.categoryFilterRela cfr
												JOIN	cfr.filter f
												WHERE	f.filterId = <cfqueryparam cfsqltype="cf_sql_integer" value="#LOCAL.filterId#" />
												AND		f.attribute = par.attribute
												AND		fv.filterValueId = <cfqueryparam cfsqltype="cf_sql_integer" value="#StructFind(getFilters(),LOCAL.filterId)#" />))
				</cfloop>
			</cfif>
			<cfif ARGUMENTS.getCount EQ false>
				ORDER BY 
				<cfswitch expression="#getSortTypeId()#">
					<cfcase value="1">
					p.createdDatetime DESC
					</cfcase>
					<cfcase value="2">
					p.soldCount DESC
					</cfcase>
					<cfcase value="3">
					p.price 
					</cfcase>
					<cfcase value="4">
					p.reviewCount DESC
					</cfcase>
					<cfdefaultcase>
					p.createdDatetime DESC
					</cfdefaultcase>
				</cfswitch>
			</cfif>
		</cfquery>

		<cfreturn LOCAL.query />
    </cffunction>
	
	<cffunction name="getCustomerGroupPrices" output="false" access="public" returntype="query">
		<cfset var LOCAL = {} />
			   
	    <cfquery name="LOCAL.getProductGroupPrices">
			SELECT	cg.customer_group_id AS customerGroupId
			,		cg.is_default AS isDefault
			,		cg.display_name AS groupDisplayName
			,		dis.display_name AS discountTypeName
			,		(	SELECT	pcgr.product_customer_group_rela_id
						FROM	product_customer_group_rela pcgr
						WHERE 	pcgr.product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
						AND 	cg.customer_group_id = pcgr.customer_group_id) AS productCustomerGroupRelaId
			FROM	customer_group cg 
			JOIN	discount_type dis ON cg.discount_type_id = dis.discount_type_id
			ORDER BY cg.is_default DESC, cg.display_name
		</cfquery>
 
		<cfreturn LOCAL.getProductGroupPrices />
    </cffunction>
	
	<cffunction name="getProductShippingMethods" output="false" access="public" returntype="query">
		<cfset var LOCAL = {} />
	   
		<cfif NOT IsNull(getId())>
			<cfset LOCAL.product = EntityLoadByPK("product",getId()) />
		</cfif>
	   
		<cfquery name="LOCAL.getProductShippingMethods">
			SELECT		sc.display_name AS shippingCarrierName
			,			sc.image_name AS imageName
			,			sm.display_name AS shippingMethodName
			,			sm.shipping_method_id AS shippingMethodId
			,			(
							SELECT	product_shipping_method_rela_id 
							FROM 	product_shipping_method_rela psmr
							WHERE 	psmr.product_id = 
							<cfif NOT IsNull(LOCAL.product) AND LOCAL.product.getProductType().getName() EQ "option">
								<cfqueryparam cfsqltype="cf_sql_integer" value="#LOCAL.product.getParentProduct().getProductId()#" />	
							<cfelse>
								<cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
							</cfif>
							AND		psmr.shipping_method_id = sm.shipping_method_id
						) AS productShippingMethodRelaId
			FROM		shipping_carrier sc
			JOIN		shipping_method sm ON sc.shipping_carrier_id = sm.shipping_carrier_id
			WHERE		sc.is_enabled = <cfqueryparam cfsqltype="cf_sql_bit" value="1" />
			AND			sm.is_enabled = <cfqueryparam cfsqltype="cf_sql_bit" value="1" />
			ORDER BY	sc.shipping_carrier_id
		</cfquery>
		 
		<cfreturn LOCAL.getProductShippingMethods />
    </cffunction>
	
	<cffunction name="getProduct" access="remote" returntype="string" returnformat="plain" output="false">
		<cfargument name="callback" type="string" required="true">
		<cfargument name="parentProductId" type="numeric" required="true">
		<cfargument name="attributeValueIdList" type="string" required="true">
		<cfargument name="customerGroupId" type="numeric" required="true">
		
		<cfset var LOCAL = {} />
		<cfset var retStruct = {} />
		<cfset var retString = "" />
		
		<cfquery name="LOCAL.getProduct">
			SELECT	p.product_id
			FROM	product_customer_group_rela pcgr
			JOIN	product p ON p.product_id = pcgr.product_id
			JOIN	customer_group cg ON cg.customer_group_id = pcgr.customer_group_id
			WHERE	p.parent_product_id = <cfqueryparam value="#ARGUMENTS.parentProductId#" cfsqltype="cf_sql_integer" />
			<cfif StructKeyExists(ARGUMENTS,"groupName")>
			AND		cg.name = <cfqueryparam value="#ARGUMENTS.groupName#" cfsqltype="cf_sql_varchar" />
			</cfif>
			<cfloop list="#ARGUMENTS.attributeValueIdList#" index="LOCAL.attributeValueId">
			AND		EXISTS	(	SELECT	1
								FROM	product_attribute_rela par
								JOIN	attribute_value av ON av.product_attribute_rela_id = par.product_attribute_rela_id
								WHERE	par.product_id = p.product_id
								AND		par.attribute_id = 
								(
									SELECT	par_sub.attribute_id
									FROM	product_attribute_rela par_sub
									JOIN	attribute_value av_sub ON av_sub.product_attribute_rela_id = par_sub.product_attribute_rela_id
									WHERE	av_sub.attribute_value_id = <cfqueryparam value="#LOCAL.attributeValueId#" cfsqltype="cf_sql_integer" />
								)
								AND		av.value = 
								(
									SELECT	av_sub.value
									FROM	attribute_value av_sub 
									WHERE	av_sub.attribute_value_id = <cfqueryparam value="#LOCAL.attributeValueId#" cfsqltype="cf_sql_integer" />
								)
							)
			</cfloop>
		</cfquery>
		
		<cfif IsNumeric(LOCAL.getProduct.product_id)>
			<cfset LOCAL.product = EntityLoadByPK("product", LOCAL.getProduct.product_id) />
			<cfset retStruct.productid = LOCAL.product.getProductId() />
			<cfif NOT IsNull(LOCAL.product.getStock())>
				<cfset retStruct.stock = LOCAL.product.getStock() />
			<cfelse>
				<cfset retStruct.stock = 0 />
			</cfif>
			<cfset LOCAL.currency = EntityLoad("currency",{isDefault=true},true) />
			
			<cfset retStruct.currentPrice = LOCAL.product.getPrice(customerGroupId = ARGUMENTS.customerGroupId, currencyId = LOCAL.currency.getCurrencyId()) />
			<cfset retStruct.originalPrice = LOCAL.product.getOriginalPrice(customerGroupId = ARGUMENTS.customerGroupId, currencyId = LOCAL.currency.getCurrencyId()) />
		<cfelse>
			<cfset retStruct.productid = "" />
			<cfset retStruct.stock = 0 />
			<cfset retStruct.currentPrice = 0 />
			<cfset retStruct.originalPrice = 0 />
		</cfif>
		
		<cfset var retString = "#ARGUMENTS.callback#(#SerializeJSON(retStruct)#);" />
		
		<cfreturn retString>
	</cffunction>
	
	<cffunction name="searchProducts" access="remote" returntype="query" returnformat="json" output="false">
		<cfargument name="productGroupId" type="numeric" required="true">
		<cfargument name="categoryId" type="numeric" required="true">
		<cfargument name="keywords" type="string" required="true">
		
		<cfset var LOCAL = {} />
		
		<cfquery name="LOCAL.getProducts">
			SELECT	p.name
			,		p.product_id
			FROM	product p 
			JOIN	product_type pt ON p.product_type_id = pt.product_type_id
			<cfif ARGUMENTS.categoryId NEQ 0>
			JOIN	category_product_rela cpr ON cpr.product_id = p.product_id 
			JOIN	category c ON c.category_id = cpr.category_id
			AND 	
			(
				c.category_id = <cfqueryparam value="#ARGUMENTS.categoryId#" cfsqltype="cf_sql_integer" />
				OR
				c.parent_category_id = <cfqueryparam value="#ARGUMENTS.categoryId#" cfsqltype="cf_sql_integer" />
				OR
				(SELECT	parent_category_id FROM category c_sub WHERE c_sub.category_id = c.parent_category_id) = <cfqueryparam value="#ARGUMENTS.categoryId#" cfsqltype="cf_sql_integer" />
			)
			</cfif>
			<cfif ARGUMENTS.productGroupId NEQ 0>
			JOIN	product_group_product_rela pgpr ON p.product_id = pgpr.product_id AND pgpr.product_group_id = <cfqueryparam value="#ARGUMENTS.productGroupId#" cfsqltype="cf_sql_integer" />
			</cfif>
			WHERE	pt.name = 'simple'
			AND		p.name IS NOT NULL
			AND		p.is_deleted = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />
			AND		p.is_enabled = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
			<cfif ARGUMENTS.keywords NEQ "">
			AND
			(
				p.display_name like <cfqueryparam value="%#Trim(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_string" />
				OR
				p.keywords like <cfqueryparam value="%#Trim(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_string" />
				OR
				p.description like <cfqueryparam value="%#Trim(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_string" />
			)
			</cfif>
		</cfquery>
		
		<cfreturn LOCAL.getProducts>
	</cffunction>
</cfcomponent>