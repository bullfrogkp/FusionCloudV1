<cfcomponent extends="core.pages.page">
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />

		<cfset LOCAL.messageArray = [] />

		<cfif Trim(FORM.display_name) EQ "">
			<cfset ArrayAppend(LOCAL.messageArray,"Please enter a valid product name.") />
		</cfif>
		
		<cfif NOT StructKeyExists(FORM,"category_id")>
			<cfset ArrayAppend(LOCAL.messageArray,"Please choose at least one category.") />
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

		<cfset LOCAL.productService = new "core.services.productService"() />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />

		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.product = EntityLoadByPK("product", FORM.id)> 
			<cfset LOCAL.product.setUpdatedUser(SESSION.adminUser) />
			<cfset LOCAL.product.setUpdatedDatetime(Now()) />
			<cfset LOCAL.tab_id = FORM.tab_id />
		<cfelse>
			<cfset LOCAL.product = EntityNew("product") />
			<cfset LOCAL.product.setProductType(EntityLoad("product_type",{name="single"},true)) />
			<cfset LOCAL.product.setSoldCount(0) />
			<cfset LOCAL.product.setReviewCount(0) />
			<cfset LOCAL.product.setCreatedUser(SESSION.adminUser) />
			<cfset LOCAL.product.setCreatedDatetime(Now()) />
			<cfset LOCAL.product.setIsDeleted(false) />
			<cfset LOCAL.product.setViewCount(0) />
			<cfset LOCAL.tab_id = "tab_1" />
		</cfif>
		
		<cfif StructKeyExists(FORM,"id")>
			<!--- general information --->
			<cfset LOCAL.product.setName(LCase(Trim(Replace(FORM.display_name,"/","-","all")))) />
			<cfset LOCAL.product.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.product.setIsEnabled(FORM.is_enabled) />
			<cfset LOCAL.product.setTitle(Trim(FORM.title)) />
			<cfset LOCAL.product.setSku(Trim(FORM.single_sku)) />
			<cfif IsNumeric(Trim(FORM.single_stock))>
				<cfset LOCAL.product.setStock(Trim(FORM.single_stock)) />
			</cfif>
			<cfset LOCAL.product.setKeywords(Trim(FORM.keywords)) />
			<cfset LOCAL.product.setDetail(Trim(FORM.detail)) />
			<cfset LOCAL.product.setDescription(Trim(FORM.description)) />
				
			<!--- price information --->
			<cfset LOCAL.customerGroups = EntityLoad("customer_group",{isDeleted = false, isEnabled = true}) />
								
			<cfif FORM.product_type EQ "single">
				<cfset LOCAL.product.setProductType(EntityLoad("product_type",{name="single"},true)) />
				
				<cfif IsNumeric(FORM.id)>
					<cfset LOCAL.product.removeSubProducts() />
					<cfset LOCAL.product.removeProductAttributeRelas() />
				</cfif>
			
				<cfset LOCAL.product.setSku(Trim(FORM.single_sku)) />
				<cfset LOCAL.product.setStock(Trim(FORM.single_stock)) />
				
				<cfif StructKeyExists(FORM,"single_advanced_price_settings")>
					<cfset LOCAL.product.setUseAdvancedPrices(true) />
				<cfelse>
					<cfset LOCAL.product.setUseAdvancedPrices(false) />
				</cfif>
				
				<cfset EntitySave(LOCAL.product) />
				
				<cfloop array="#LOCAL.customerGroups#" index="LOCAL.group">
					<cfset LOCAL.productCustomerGroupRela = EntityLoad("product_customer_group_rela",{product=LOCAL.product,customerGroup=LOCAL.group},true) />
					<cfif IsNull(LOCAL.productCustomerGroupRela)>
						<cfset LOCAL.productCustomerGroupRela = EntityNew("product_customer_group_rela") />
						<cfset LOCAL.productCustomerGroupRela.setProduct(LOCAL.product) />
						<cfset LOCAL.productCustomerGroupRela.setCustomerGroup(LOCAL.group) /> 
					</cfif>
					
					<cfif StructKeyExists(FORM,"single_advanced_price_settings")>
						<cfset LOCAL.newPrice = Trim(FORM["single_advanced_price_#LOCAL.group.getCustomerGroupId()#"]) />
						<cfset LOCAL.newSpecialPrice = Trim(FORM["single_advanced_special_price_#LOCAL.group.getCustomerGroupId()#"]) />
						<cfset LOCAL.newSpecialPriceFromDate = Trim(FORM["single_advanced_from_date_#LOCAL.group.getCustomerGroupId()#"]) />
						<cfset LOCAL.newSpecialPriceToDate = Trim(FORM["single_advanced_to_date_#LOCAL.group.getCustomerGroupId()#"]) />
					<cfelse>
						<cfset LOCAL.newPrice = Trim(FORM.single_simple_price) />
						<cfset LOCAL.newSpecialPrice = Trim(FORM.single_simple_special_price) />
						<cfset LOCAL.newSpecialPriceFromDate = "" />
						<cfset LOCAL.newSpecialPriceToDate = "" />
					</cfif>
					
					<cfset LOCAL.productCustomerGroupRela.setPrice(LOCAL.newPrice) />
					<cfif IsNumeric(LOCAL.newSpecialPrice)>
						<cfset LOCAL.productCustomerGroupRela.setSpecialPrice(LOCAL.newSpecialPrice) />
					<cfelse>
						<cfset LOCAL.productCustomerGroupRela.setSpecialPrice(JavaCast("NULL","")) />
					</cfif>
					<cfif IsDate(LOCAL.newSpecialPriceFromDate)>
						<cfset LOCAL.productCustomerGroupRela.setSpecialPriceFromDate(LOCAL.newSpecialPriceFromDate) />
					<cfelse>
						<cfset LOCAL.productCustomerGroupRela.setSpecialPriceFromDate(JavaCast("NULL","")) />
					</cfif>
					<cfif IsDate(LOCAL.newSpecialPriceToDate)>
						<cfset LOCAL.productCustomerGroupRela.setSpecialPriceToDate(LOCAL.newSpecialPriceToDate) />
					<cfelse>
						<cfset LOCAL.productCustomerGroupRela.setSpecialPriceToDate(JavaCast("NULL","")) />
					</cfif>
					
					<!--- for listing page sorting --->
					<cfif LOCAL.group.getIsDefault() EQ true>
						<cfset LOCAL.product.setPriceMV(LOCAL.newPrice) />
					</cfif>
					
					<cfset EntitySave(LOCAL.productCustomerGroupRela) />
				</cfloop>
				
			<cfelseif FORM.product_type EQ "configurable">
				<cfset LOCAL.product.setProductType(EntityLoad("product_type",{name="configurable"},true)) />
				
				<cfif IsNumeric(FORM.id)>
					<!--- doesn't need single prices any more --->
					<cfset LOCAL.product.removeProductCustomerGroupRelas() />
					
					<!--- product attributes and values --->
					<cfset LOCAL.product.removeProductAttributeRelas() />
				</cfif>
				
				<cfset LOCAL.product.setSku(JavaCast("NULL","")) />
				<cfset LOCAL.product.setStock(JavaCast("NULL","")) />
				<cfset LOCAL.product.setUseAdvancedPrices(JavaCast("NULL","")) />
				
				<cfset EntitySave(LOCAL.product) />
				
				<cfloop list="#FORM.c_attribute_id#" index="LOCAL.attribute_id">
					<cfset LOCAL.productAttributeRela = EntityNew("product_attribute_rela") />
					<cfset LOCAL.productAttributeRela.setProduct(LOCAL.product) />
					<cfset LOCAL.productAttributeRela.setAttribute(EntityLoadByPK("attribute",LOCAL.attribute_id)) />
					<cfset LOCAL.product.addProductAttributeRela(LOCAL.productAttributeRela) /> 
					
					<cfif StructKeyExists(FORM,"c_attribute_option_id_#LOCAL.attribute_id#")>
						<cfloop list="#FORM["c_attribute_option_id_#LOCAL.attribute_id#"]#" index="LOCAL.aoid">
							<cfset LOCAL.attributeValue = EntityNew("attribute_value") />
							<cfset LOCAL.attributeValue.setValue(Trim(FORM["c_attribute_option_value_#LOCAL.attribute_id#_#LOCAL.aoid#"])) />
							<cfset LOCAL.attributeValue.setHasThumbnail(FORM["c_attribute_option_hasthumbnail_#LOCAL.attribute_id#_#LOCAL.aoid#"]) />
							<cfif NOT Find("no_image_available.png", FORM["c_attribute_option_imagename_#LOCAL.attribute_id#_#LOCAL.aoid#"])>
								<cfset LOCAL.attributeValue.setImageName(FORM["c_attribute_option_imagename_#LOCAL.attribute_id#_#LOCAL.aoid#"]) />
							</cfif>
							<cfset LOCAL.attributeValue.setProductAttributeRela(LOCAL.productAttributeRela) />
							
							<cfset EntitySave(LOCAL.attributeValue) />
							<cfset LOCAL.productAttributeRela.addAttributeValue(LOCAL.attributeValue) />
						</cfloop>
					</cfif>
					
					<cfset EntitySave(LOCAL.productAttributeRela) />
				</cfloop>
				
				<cfset EntitySave(LOCAL.product) />
				
				<!--- attribute option images --->
				<cfif FORM.image_count_hidden GT 0>
					<cfset LOCAL.imageDir = "#APPLICATION.absolutePathRoot#images\uploads\product\#LOCAL.product.getProductId()#\" />
					<cfif NOT DirectoryExists(LOCAL.imageDir)>
						<cfdirectory action = "create" directory = "#LOCAL.imageDir#" />
					</cfif>	
					<cfloop from="1" to="#FORM.image_count_hidden#" index="LOCAL.i">
						<cffile action = "upload"  
								fileField = "new_attribute_option_image_#LOCAL.i - 1#"
								destination = "#LOCAL.imageDir#"
								nameConflict = "MakeUnique"> 
						
						<cfset LOCAL.productImage = EntityNew("product_image") />
						<cfset LOCAL.productImage.setName(cffile.serverFile) />
						<cfset EntitySave(LOCAL.productImage) />
						<cfset LOCAL.product.addImage(LOCAL.productImage) />
						
						<cfset LOCAL.sizeArray = [{name = "medium", width = "410", height = "410", position="", crop = false}
												, {name = "small", width = "200", height = "200", position="center", crop = true}
												, {name = "thumbnail", width = "30", height = "30", position="center", crop = true}
												] />			
						<cfset _createImages(	imagePath = LOCAL.imageDir,
												imageNameWithExtension = cffile.serverFile,
												sizeArray = LOCAL.sizeArray) />
					</cfloop>
				</cfif>
				
				<cfset EntitySave(LOCAL.product) />
				
				<!--- sub products --->
				
				<!--- remove sub products --->
				<cfloop array="#LOCAL.product.getSubProducts()#" index="LOCAL.subProduct">
					<cfif NOT ListFind(FORM.c_sub_product_id, LOCAL.subProduct.getProductId())>
						<cfset LOCAL.subProduct.setIsDeleted(true) />
						<cfset EntitySave(LOCAL.subProduct) />
					</cfif>
				</cfloop>
				
				<!--- add/update sub products --->
				<cfloop list="#FORM.c_sub_product_id#" index="LOCAL.sub_product_id">
					<cfif IsNumeric(LOCAL.sub_product_id)>
						<cfset LOCAL.subProduct = EntityLoadByPK("product",LOCAL.sub_product_id)>
					<cfelse>
						<cfset LOCAL.subProduct = EntityNew("product")>
						<cfset LOCAL.subProduct.setParentProduct(LOCAL.product) />
						<cfset LOCAL.subProduct.setProductType(EntityLoad("product_type",{name="option"},true)) />
						<cfset LOCAL.subProduct.setIsDeleted(false) />
						<cfset LOCAL.subProduct.setCreatedUser(SESSION.adminUser) />
						<cfset LOCAL.subProduct.setCreatedDatetime(Now()) />
					</cfif>
					
					<cfset LOCAL.subProduct.setSku(FORM["c_sub_product_sku_#LOCAL.sub_product_id#"]) />
					<cfset LOCAL.subProduct.setStock(FORM["c_sub_product_stock_#LOCAL.sub_product_id#"]) />
					
					<cfif StructKeyExists(FORM,"c_sub_product_enabled_#LOCAL.sub_product_id#")>
						<cfset LOCAL.subProduct.setIsEnabled(true) />
					<cfelse>
						<cfset LOCAL.subProduct.setIsEnabled(false) />
					</cfif>
					
					<cfif StructKeyExists(FORM,"c_sub_product_use_advanced_price_#LOCAL.sub_product_id#")>
						<cfset LOCAL.subProduct.setUseAdvancedPrices(true) />
					<cfelse>
						<cfset LOCAL.subProduct.setUseAdvancedPrices(false) />
					</cfif>
					
					<cfloop array="#LOCAL.customerGroups#" index="LOCAL.group">
						<cfif StructKeyExists(FORM,"c_sub_product_use_advanced_price_#LOCAL.sub_product_id#")>
							<cfset LOCAL.newPrice = Trim(FORM["c_sub_product_price_#LOCAL.sub_product_id#_sub_#LOCAL.group.getCustomerGroupId()#"]) />
							<cfset LOCAL.newSpecialPrice =Trim(FORM["c_sub_product_specialprice_#LOCAL.sub_product_id#_sub_#LOCAL.group.getCustomerGroupId()#"]) />
							<cfset LOCAL.newSpecialPriceFromDate = Trim(FORM["c_sub_product_fromdate_#LOCAL.sub_product_id#_sub_#LOCAL.group.getCustomerGroupId()#"]) />
							<cfset LOCAL.newSpecialPriceToDate = Trim(FORM["c_sub_product_todate_#LOCAL.sub_product_id#_sub_#LOCAL.group.getCustomerGroupId()#"]) />
						<cfelse>
							<cfset LOCAL.newPrice = Trim(FORM["c_sub_product_simple_price_#LOCAL.sub_product_id#"]) />
							<cfset LOCAL.newSpecialPrice = Trim(FORM["c_sub_product_simple_special_price_#LOCAL.sub_product_id#"]) />
							<cfset LOCAL.newSpecialPriceFromDate = "" />
							<cfset LOCAL.newSpecialPriceToDate = "" />
						</cfif>
					
						<cfif IsNumeric(LOCAL.sub_product_id)>
							<cfset LOCAL.productCustomerGroupRela = EntityLoad("product_customer_group_rela",{product = LOCAL.subProduct, customerGroup = LOCAL.group},true) />
						<cfelse>
							<cfset LOCAL.productCustomerGroupRela = EntityNew("product_customer_group_rela") />
							<cfset LOCAL.productCustomerGroupRela.setProduct(LOCAL.subProduct) />
							<cfset LOCAL.productCustomerGroupRela.setCustomerGroup(LOCAL.group) />
						</cfif>
						
						<cfset LOCAL.productCustomerGroupRela.setPrice(LOCAL.newPrice) />
						<cfif IsNumeric(LOCAL.newSpecialPrice)>
							<cfset LOCAL.productCustomerGroupRela.setSpecialPrice(LOCAL.newSpecialPrice) />
						<cfelse>
							<cfset LOCAL.productCustomerGroupRela.setSpecialPrice(JavaCast("NULL","")) />
						</cfif>
						<cfif IsDate(LOCAL.newSpecialPriceFromDate)>
							<cfset LOCAL.productCustomerGroupRela.setSpecialPriceFromDate(LOCAL.newSpecialPriceFromDate) />
						<cfelse>
							<cfset LOCAL.productCustomerGroupRela.setSpecialPriceFromDate(JavaCast("NULL","")) />
						</cfif>
						<cfif IsDate(LOCAL.newSpecialPriceToDate)>
							<cfset LOCAL.productCustomerGroupRela.setSpecialPriceToDate(LOCAL.newSpecialPriceToDate) />
						<cfelse>
							<cfset LOCAL.productCustomerGroupRela.setSpecialPriceToDate(JavaCast("NULL","")) />
						</cfif>
						
						<!--- update: for listing page sorting --->
						<cfif LOCAL.group.getIsDefault() EQ true>
							<cfset LOCAL.product.setPriceMV(LOCAL.newPrice) />
						</cfif>
						
						<cfset EntitySave(LOCAL.productCustomerGroupRela) />
					</cfloop>
				
					<cfif NOT IsNumeric(LOCAL.sub_product_id)>
						<!--- attribute and values --->
						<cfset LOCAL.attribute_option_id_list = FORM["c_sub_product_attribute_option_id_#LOCAL.sub_product_id#"] />
						<cfloop list="#LOCAL.attribute_option_id_list#" index="LOCAL.attribute_option_id">
							<cfset LOCAL.attribute_id = FORM["c_sub_product_attribute_option_attribute_id_#LOCAL.sub_product_id#_#LOCAL.attribute_option_id#"] />
							<cfset LOCAL.productAttributeRela = EntityNew("product_attribute_rela") />
							<cfset LOCAL.productAttributeRela.setProduct(LOCAL.subProduct) />
							<cfset LOCAL.productAttributeRela.setAttribute(EntityLoadByPK("attribute",LOCAL.attribute_id)) />
							<cfset EntitySave(LOCAL.productAttributeRela) />
						
							<cfset LOCAL.value = Trim(FORM["c_sub_product_attribute_option_value_#LOCAL.sub_product_id#_#LOCAL.attribute_option_id#"]) />
							<cfset LOCAL.attributeValue = EntityNew("attribute_value") />
							<cfset LOCAL.attributeValue.setValue(LOCAL.value) />
							<cfset LOCAL.attributeValue.setProductAttributeRela(LOCAL.productAttributeRela) />
							<cfset EntitySave(LOCAL.attributeValue) />
						</cfloop>
					</cfif>
					
					<cfset EntitySave(LOCAL.subProduct) />
				</cfloop>
			</cfif>
			
			<cfif FORM.tax_category_id NEQ "">
				<cfset LOCAL.product.setTaxCategory(EntityLoadByPK("tax_category",FORM.tax_category_id)) />
			</cfif>
			
			<!--- update: not necessary for each time --->
			<cfset LOCAL.product.removeAllCategories() />
			
			<cfloop list="#FORM.category_id#" index="LOCAL.categoryId">
				<cfset LOCAL.newCategory = EntityLoadByPK("category",LOCAL.categoryId) />
				<cfset LOCAL.product.addCategory(LOCAL.newCategory) />
			</cfloop>
						
			<cfif FORM.shipping_method EQ "free">
				<cfif IsNumeric(FORM.id)>
					<cfset LOCAL.product.removeProductShippingCarrierRelas() />
				</cfif>
				<cfset LOCAL.product.setShippingFee(0) />
			<cfelseif FORM.shipping_method EQ "flat">
				<cfif IsNumeric(FORM.id)>
					<cfset LOCAL.product.removeProductShippingCarrierRelas() />
				</cfif>
				<cfset LOCAL.product.setShippingFee(FORM.flat_rate_price) />
			<cfelseif FORM.shipping_method EQ "carrier">
				<cfif IsNumeric(Trim(FORM.length))>
					<cfset LOCAL.product.setLength(Trim(FORM.length)) />
				</cfif>
				<cfif IsNumeric(Trim(FORM.width))>
					<cfset LOCAL.product.setWidth(Trim(FORM.width)) />
				</cfif>
				<cfif IsNumeric(Trim(FORM.height))>
					<cfset LOCAL.product.setHeight(Trim(FORM.height)) />
				</cfif>
				<cfset LOCAL.product.setWeight(Trim(FORM.weight)) />
				<cfloop list="#FORM.shipping_carrier_id#" index="LOCAL.shippingCarrierId">
					<cfset LOCAL.shippingCarrier = EntityLoadByPK("shipping_carrier",LOCAL.shippingCarrierId) />
					<cfset LOCAL.newProductShippingCarrierRela = EntityNew("product_shipping_carrier_rela") />
					<cfset LOCAL.newProductShippingCarrierRela.setShippingCarrier(LOCAL.shippingCarrier) />
					<cfset LOCAL.newProductShippingCarrierRela.setProduct(LOCAL.product) />					
					<cfset EntitySave(LOCAL.newProductShippingCarrierRela) />
					<cfset LOCAL.product.addProductShippingCarrierRela(LOCAL.newProductShippingCarrierRela) />
				</cfloop>
				
				<cfset LOCAL.product.setShippingFee(-1) />
			</cfif>
			
			<!--- product images --->
			<cfif NOT IsNull(LOCAL.product.getImages())>
				<cfloop array="#LOCAL.product.getImages()#" index="LOCAL.img">
					<cfif StructKeyExists(FORM,"rank_#LOCAL.img.getProductImageId()#") AND IsNumeric(FORM["rank_#LOCAL.img.getProductImageId()#"])>
						<cfset LOCAL.img.setRank(FORM["rank_#LOCAL.img.getProductImageId()#"]) />
						<cfset EntitySave(LOCAL.img) />
					</cfif>
				</cfloop>
			</cfif>
		
			<cfif FORM["uploader_count"] NEQ 0>
				<cfloop collection="#FORM#" item="LOCAL.key">
					<cfif Find("UPLOADER_",LOCAL.key) AND Find("_STATUS",LOCAL.key)>
						<cfset LOCAL.currentIndex = Replace(Replace(LOCAL.key,"UPLOADER_",""),"_STATUS","") />
						<cfif StructFind(FORM,LOCAL.key) EQ "done">
							<cfset LOCAL.imgName = StructFind(FORM,"UPLOADER_#LOCAL.currentIndex#_NAME") />
							<cfset LOCAL.imagePath = ExpandPath("#APPLICATION.urlAdmin#images/uploads/product/") />
						
							<cfset LOCAL.imageDir = LOCAL.imagePath & LOCAL.product.getProductId() />
							<cfif NOT DirectoryExists(LOCAL.imageDir)>
								<cfdirectory action = "create" directory = "#LOCAL.imageDir#" />
							</cfif>
							
							<cffile action = "move" source = "#LOCAL.imagePath##LOCAL.imgName#" destination = "#LOCAL.imagePath##LOCAL.product.getProductId()#\#LOCAL.imgName#">
						
							<cfset LOCAL.sizeArray = [{name = "medium", width = "410", height = "410", position="", crop = false}
													, {name = "small", width = "200", height = "200", position="center", crop = true}
													, {name = "thumbnail", width = "30", height = "30", position="center", crop = true}
													] />					
							<cfset _createImages(	imagePath = "#LOCAL.imagePath##LOCAL.product.getProductId()#\",
													imageNameWithExtension = LOCAL.imgName,
													sizeArray = LOCAL.sizeArray) />
															
							<cfset LOCAL.productImage = EntityNew("product_image") />
							<cfset LOCAL.productImage.setName(LOCAL.imgName) />
							<cfset EntitySave(LOCAL.productImage) />
							<cfset LOCAL.product.addImage(LOCAL.productImage) />
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif StructKeyExists(FORM,"default_image_id") AND FORM.default_image_id NEQ "">
				<cfset LOCAL.currentDefaultImage = EntityLoad("product_image",{product=LOCAL.product,isDefault=true},true) />
				<cfif NOT IsNull(LOCAL.currentDefaultImage)>
					<cfset LOCAL.currentDefaultImage.setIsDefault(false) />
					<cfset EntitySave(LOCAL.currentDefaultImage) />
				</cfif>
				<cfset LOCAL.newDefaultImage = EntityLoadByPK("product_image", FORM.default_image_id) />
				<cfset LOCAL.newDefaultImage.setIsDefault(true) />
				<cfset EntitySave(LOCAL.newDefaultImage) />
			</cfif>
			
			<!--- related product --->
			<cfset LOCAL.product.removeAllRelatedProducts() />
		
			<cfif StructKeyExists(FORM,"products_selected") AND FORM.products_selected NEQ "">
				<cfloop list="#FORM.products_selected#" index="LOCAL.productId">
					<cfset LOCAL.product.addRelatedProduct(EntityLoadByPK("product",LOCAL.productId)) />
				</cfloop>
			</cfif>
			
			<!--- videos --->
			<cfif NOT IsNumeric(FORM.id)>
				<cfloop from="1" to="5" index="LOCAL.i">
					<cfif Trim(FORM["video#LOCAL.i#"]) NEQ "">
						<cfset LOCAL.newProductVideo = EntityNew("product_video") />
						<cfset LOCAL.newProductVideo.setURL(Trim(FORM["video#LOCAL.i#"])) />
						<cfset LOCAL.newProductVideo.setProduct(LOCAL.product) />
						<cfset EntitySave(LOCAL.newProductVideo) />
					</cfif>
				</cfloop>
			</cfif>
			
			<cfset EntitySave(LOCAL.product) />
										
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin##getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=#LOCAL.tab_id#" />
		
		<cfelseif StructKeyExists(FORM,"delete_item")>
		
			<cfset LOCAL.product.setIsDeleted(true) />
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Product #LOCAL.product.getDisplayName()# has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin#products.cfm" />
			
		<cfelseif StructKeyExists(FORM,"delete_image")>
		
			<cfset LOCAL.image = EntityLoadByPK("product_image",FORM.deleted_image_id) />
			<cfset LOCAL.product.removeImage(LOCAL.image) />
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Image has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin##getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=tab_4" />	
		
		<cfelseif StructKeyExists(FORM,"add_new_video")>
		
			<cfset LOCAL.newProductVideo = EntityNew("product_video") />
			<cfset LOCAL.newProductVideo.setURL(Trim(FORM.new_video_url)) />
			<cfset EntitySave(LOCAL.newProductVideo) />
			<cfset LOCAL.product.addProductVideo(LOCAL.newProductVideo) />
			<cfset EntitySave(LOCAL.product) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Video has been added.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin##getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=tab_9" />
		
		
		<cfelseif StructKeyExists(FORM,"delete_video")>
		
			<cfset LOCAL.productVideo = EntityLoadByPK("product_video",FORM.deleted_product_video_id) />
			<cfset EntityDelete(LOCAL.productVideo) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Video has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin##getPageName()#.cfm?id=#LOCAL.product.getProductId()#&active_tab_id=tab_9" />
		
		<cfelseif StructKeyExists(FORM,"delete_attribute_option_value")>
		
			<cfset LOCAL.product.removeSubProduct(EntityLoadByPK("product",FORM.sub_product_id)) />
			<cfset EntitySave(LOCAL.product) />
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Attribute value has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlAdmin##getPageName()#.cfm?id=#FORM.id#&active_tab_id=tab_5" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryService = new "core.services.categoryService"() />
		<cfset LOCAL.productService = new "core.services.productService"() />
		
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree(isSpecial=false) />
		<cfset LOCAL.pageData.customerGroups = EntityLoad("customer_group",{isDeleted = false, isEnabled = true},"isDefault Desc") />
		<cfset LOCAL.pageData.taxCategories = EntityLoad("tax_category") />
		<cfset LOCAL.pageData.productGroups = EntityLoad("product_group") />
		<cfset LOCAL.pageData.attributes = EntityLoad("attribute",{isDeleted = false}, "attributeId ASC") />
		<cfset LOCAL.pageData.defaultCustomerGroup = EntityLoad("customer_group",{isDefault = true},true) />
		<cfset LOCAL.pageData.specialCategories = EntityLoad("category",{isDeleted = false, isSpecial = true, isEnabled = true},"rank Asc") />
		<cfset LOCAL.pageData.shippingCarriers = EntityLoad("shipping_carrier",{isEnabled = true}) />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.productService.setId(URL.id) />
			<cfset LOCAL.pageData.product = EntityLoadByPK("product", URL.id)>
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.product.getDisplayNameMV()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />
			<cfif LOCAL.pageData.product.getProductType().getName() EQ "single" OR LOCAL.pageData.product.getProductType().getName() EQ "configurable">
				<cfset LOCAL.pageData.defaultCustomerGroupPrice = EntityLoad("product_customer_group_rela", {product = LOCAL.pageData.product, customerGroup = EntityLoad("customer_group",{isDefault = true},true)},true) />
			</cfif>
			<cfset LOCAL.pageData.attributeList = "" />
			<cfloop array="#LOCAL.pageData.product.getProductAttributeRelas()#" index="LOCAL.productAttributeRela">
				<cfset LOCAL.pageData.attributeList &= "#LOCAL.productAttributeRela.getAttribute().getAttributeId()#," />
			</cfloop>
			
			<cfset LOCAL.pageData.subProducts = EntityLoad("product",{parentProduct = LOCAL.pageData.product, isDeleted = false},"productId Asc") />
						
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.product.getDisplayNameMV())?"":LOCAL.pageData.product.getDisplayNameMV() />
				<cfset LOCAL.pageData.formData.detail = isNull(LOCAL.pageData.product.getDetailMV())?"":LOCAL.pageData.product.getDetailMV() />
				<cfset LOCAL.pageData.formData.single_sku = isNull(LOCAL.pageData.product.getSku())?"":LOCAL.pageData.product.getSku() />
				<cfset LOCAL.pageData.formData.single_stock = isNull(LOCAL.pageData.product.getStock())?"":LOCAL.pageData.product.getStock() />
				<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.product.getIsEnabledMV())?"":LOCAL.pageData.product.getIsEnabledMV() />
				<cfset LOCAL.pageData.formData.title = isNull(LOCAL.pageData.product.getTitleMV())?"":LOCAL.pageData.product.getTitleMV() />
				<cfset LOCAL.pageData.formData.keywords = isNull(LOCAL.pageData.product.getKeywordsMV())?"":LOCAL.pageData.product.getKeywordsMV() />
				<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.product.getDescriptionMV())?"":LOCAL.pageData.product.getDescriptionMV() />
				<cfset LOCAL.pageData.formData.tax_category_id = isNull(LOCAL.pageData.product.getTaxCategoryMV())?"":LOCAL.pageData.product.getTaxCategoryMV().getTaxCategoryId() />
				<cfset LOCAL.pageData.formData.length = isNull(LOCAL.pageData.product.getLengthMV())?"":LOCAL.pageData.product.getLengthMV() />
				<cfset LOCAL.pageData.formData.height = isNull(LOCAL.pageData.product.getHeightMV())?"":LOCAL.pageData.product.getHeightMV() />
				<cfset LOCAL.pageData.formData.width = isNull(LOCAL.pageData.product.getWidthMV())?"":LOCAL.pageData.product.getWidthMV() />
				<cfset LOCAL.pageData.formData.weight = isNull(LOCAL.pageData.product.getWeightMV())?"":LOCAL.pageData.product.getWeightMV() />
		
				<cfif NOT isNull(LOCAL.pageData.defaultCustomerGroupPrice)>
					<cfset LOCAL.pageData.formData.single_simple_price = isNull(LOCAL.pageData.defaultCustomerGroupPrice.getPrice())?"":LOCAL.pageData.defaultCustomerGroupPrice.getPrice() />
					<cfset LOCAL.pageData.formData.single_simple_special_price = isNull(LOCAL.pageData.defaultCustomerGroupPrice.getSpecialPrice())?"":LOCAL.pageData.defaultCustomerGroupPrice.getSpecialPrice() />
				<cfelse>
					<cfset LOCAL.pageData.formData.single_simple_price = "" />
					<cfset LOCAL.pageData.formData.single_simple_special_price = "" />
				</cfif>
				
				<cfloop array="#LOCAL.pageData.customerGroups#" index="LOCAL.group">
					<cfset LOCAL.productCustomerGroupRela = EntityLoad("product_customer_group_rela",{product = LOCAL.pageData.product, customerGroup = LOCAL.group},true) />
					<cfif NOT isNull(LOCAL.productCustomerGroupRela)>
						<cfset LOCAL.pageData.formData["single_advanced_price_#LOCAL.group.getCustomerGroupId()#"] = LOCAL.productCustomerGroupRela.getPrice() />
						<cfset LOCAL.pageData.formData["single_advanced_special_price_#LOCAL.group.getCustomerGroupId()#"] = isNull(LOCAL.productCustomerGroupRela.getSpecialPrice())?"":LOCAL.productCustomerGroupRela.getSpecialPrice() />
						<cfset LOCAL.pageData.formData["single_advanced_from_date_#LOCAL.group.getCustomerGroupId()#"] = isNull(LOCAL.productCustomerGroupRela.getSpecialPriceFromDate())?"":LOCAL.productCustomerGroupRela.getSpecialPriceFromDate() />
						<cfset LOCAL.pageData.formData["single_advanced_to_date_#LOCAL.group.getCustomerGroupId()#"] = isNull(LOCAL.productCustomerGroupRela.getSpecialPriceToDate())?"":LOCAL.productCustomerGroupRela.getSpecialPriceToDate() />
					<cfelse>
						<cfset LOCAL.pageData.formData["single_advanced_price_#LOCAL.group.getCustomerGroupId()#"] = "" />
						<cfset LOCAL.pageData.formData["single_advanced_special_price_#LOCAL.group.getCustomerGroupId()#"] = "" />
						<cfset LOCAL.pageData.formData["single_advanced_from_date_#LOCAL.group.getCustomerGroupId()#"] = "" />
						<cfset LOCAL.pageData.formData["single_advanced_to_date_#LOCAL.group.getCustomerGroupId()#"] = "" />
					</cfif>
				</cfloop>
				
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Product | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			<cfset LOCAL.pageData.attributeList = "" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.detail = "" />
				<cfset LOCAL.pageData.formData.single_sku = "" />
				<cfset LOCAL.pageData.formData.single_stock = "" />
				<cfset LOCAL.pageData.formData.is_enabled = "" />
				<cfset LOCAL.pageData.formData.title = "" />
				<cfset LOCAL.pageData.formData.keywords = "" />
				<cfset LOCAL.pageData.formData.description = "" />
				<cfset LOCAL.pageData.formData.tax_category_id = "" />
				<cfset LOCAL.pageData.formData.length = "" />
				<cfset LOCAL.pageData.formData.height = "" />
				<cfset LOCAL.pageData.formData.width = "" />
				<cfset LOCAL.pageData.formData.weight = "" />
				
				<cfset LOCAL.pageData.formData.single_simple_price = "" />
				<cfset LOCAL.pageData.formData.single_simple_special_price = "" />
				
				<cfset LOCAL.pageData.formData.video1 = "" />
				<cfset LOCAL.pageData.formData.video2 = "" />
				<cfset LOCAL.pageData.formData.video3 = "" />
				<cfset LOCAL.pageData.formData.video4 = "" />
				<cfset LOCAL.pageData.formData.video5 = "" />
				
				<cfloop array="#LOCAL.pageData.customerGroups#" index="LOCAL.group">
					<cfset LOCAL.pageData.formData["single_advanced_price_#LOCAL.group.getCustomerGroupId()#"] = "" />
					<cfset LOCAL.pageData.formData["single_advanced_special_price_#LOCAL.group.getCustomerGroupId()#"] = "" />
					<cfset LOCAL.pageData.formData["single_advanced_from_date_#LOCAL.group.getCustomerGroupId()#"] = "" />
					<cfset LOCAL.pageData.formData["single_advanced_to_date_#LOCAL.group.getCustomerGroupId()#"] = "" />
				</cfloop>
				
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
	
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>