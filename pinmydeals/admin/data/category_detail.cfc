<cfcomponent extends="core.pages.page">
	<cffunction name="validateFormData" access="remote" output="false" returnType="struct" returnformat="json">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.isValid = true />
		<cfset LOCAL.retStruct.messageArray = [] />
		
		<cfif Trim(FORM.displayName) EQ "">
			<cfset ArrayAppend(LOCAL.retStruct.messageArray,"Please enter a valid category name.") />
			<cfset LOCAL.retStruct.isValid = false />
		</cfif>
		
		<cfreturn LOCAL.retStruct />
	</cffunction>

	<cffunction name="processFormData" access="remote" output="false" returnType="struct" returnformat="json">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.isValid = true />
		<cfset LOCAL.retStruct.messageArray = [] />
				
		<cfif IsNumeric(FORM.id)>
			<cfset LOCAL.category = EntityLoadByPK("category", FORM.id)> 
			<cfset LOCAL.category.setUpdatedUser(FORM.user) />
			<cfset LOCAL.category.setUpdatedDatetime(Now()) />
		<cfelse>
			<cfset LOCAL.category = EntityNew("category")> 
			<cfset LOCAL.category.setCreatedUser(FORM.user) />
			<cfset LOCAL.category.setCreatedDatetime(Now()) />
			<cfset LOCAL.category.setIsDeleted(false) />
		</cfif>
		
		<cfset ArrayAppend(LOCAL.retStruct.messageArray,"Category information has been saved successfully.") />
		
		<cfset EntitySave(LOCAL.category) />
		
		<cfreturn LOCAL.retStruct />	
		<!---
		<cfset LOCAL.currentPageName = "products" />
		<cfset LOCAL.pageData.currentPage = EntityLoad("page", {name = LOCAL.currentPageName},true)>
		<cfset LOCAL.advertisementSection = EntityLoad("page_section", {name="advertisement",page=LOCAL.pageData.currentPage},true)> 
		<cfset LOCAL.advertisementSection.setCategory(LOCAL.category)> 
		<cfset LOCAL.bestSellerSection = EntityLoad("page_section", {name="best seller",page=LOCAL.pageData.currentPage},true)> 
		<cfset LOCAL.bestSellerSection.setCategory(LOCAL.category)> 
		
		<cfif StructKeyExists(FORM,"save_item")>
			
			<cfif FORM.parent_category_id NEQ "">
				<cfset LOCAL.category.setParentCategory(EntityLoadByPK("category",FORM.parent_category_id)) />
			</cfif>
			<cfset LOCAL.category.setName(LCase(Trim(FORM.display_name))) />
			<cfset LOCAL.category.setDisplayName(Trim(FORM.display_name)) />
			<cfset LOCAL.category.setRank(Val(Trim(FORM.rank))) />
			<cfset LOCAL.category.setIsEnabled(FORM.is_enabled) />
			<cfset LOCAL.category.setDisplayCategoryList(FORM.display_category_list) />
			<cfset LOCAL.category.setIsSpecial(FORM.is_special) />
			<cfset LOCAL.category.setDisplayCustomDesign(FORM.display_custom_design) />
			<cfset LOCAL.category.setDisplayFilter(FORM.display_filter) />
			<cfset LOCAL.category.setShowCategoryOnNavigation(FORM.show_category_on_navigation) />
			<cfset LOCAL.category.setTitle(Trim(FORM.title)) />
			<cfset LOCAL.category.setKeywords(Trim(FORM.keywords)) />
			<cfset LOCAL.category.setDescription(Trim(FORM.description)) />
			<cfset LOCAL.category.setCustomDesign(Trim(FORM.custom_design)) />
			
			<!--- attribute information --->
			<!--- to get the category id for image path, extra entitysave here --->
			<cfset EntitySave(LOCAL.category) />
		
			<cfif NOT IsNull(LOCAL.category.getImages())>
				<cfloop array="#LOCAL.category.getImages()#" index="LOCAL.img">
					<cfif IsNumeric(FORM["rank_#LOCAL.img.getCategoryImageId()#"])>
						<cfset LOCAL.img.setRank(FORM["rank_#LOCAL.img.getCategoryImageId()#"]) />
						<cfset EntitySave(LOCAL.img) />
					</cfif>
				</cfloop>
			</cfif>
					
			<cfif NOT IsNull(LOCAL.advertisementSection.getSectionData())>
				<cfloop array="#LOCAL.advertisementSection.getSectionData()#" index="LOCAL.ad">
					<cfif IsNumeric(FORM["advertisement_rank_#LOCAL.ad.getPageSectionAdvertisementId()#"])>
						<cfset LOCAL.ad.setRank(FORM["advertisement_rank_#LOCAL.ad.getPageSectionAdvertisementId()#"]) />
						<cfset EntitySave(LOCAL.ad) />
					</cfif>
					<cfif Trim(FORM["advertisement_link_#LOCAL.ad.getPageSectionAdvertisementId()#"]) NEQ "">
						<cfset LOCAL.ad.setLink(FORM["advertisement_link_#LOCAL.ad.getPageSectionAdvertisementId()#"]) />
						<cfset EntitySave(LOCAL.ad) />
					</cfif>
				</cfloop>
			</cfif>
		
			<cfif FORM["uploader_count"] NEQ 0>
				<cfloop collection="#FORM#" item="LOCAL.key">
					<cfif Find("UPLOADER_",LOCAL.key) AND Find("_STATUS",LOCAL.key)>
						<cfset LOCAL.currentIndex = Replace(Replace(LOCAL.key,"UPLOADER_",""),"_STATUS","") />
						<cfif StructFind(FORM,LOCAL.key) EQ "done">
							<cfset LOCAL.imgName = StructFind(FORM,"UPLOADER_#LOCAL.currentIndex#_NAME") />
							<cfset LOCAL.imagePath = ExpandPath("#APPLICATION.absoluteUrlSite#images/uploads/category/") />
						
							<cfset LOCAL.imageDir = LOCAL.imagePath & LOCAL.category.getCategoryId() />
							<cfif NOT DirectoryExists(LOCAL.imageDir)>
								<cfdirectory action = "create" directory = "#LOCAL.imageDir#" />
							</cfif>
							
							<cffile action = "move" source = "#LOCAL.imagePath##LOCAL.imgName#" destination = "#LOCAL.imagePath##LOCAL.category.getCategoryId()#\#LOCAL.imgName#">
						
							<cfset LOCAL.categoryImage = EntityNew("category_image") />
							<cfset LOCAL.categoryImage.setName(LOCAL.imgName) />
							<cfset LOCAL.categoryImage.setIsDefault(false) />
							<cfset EntitySave(LOCAL.categoryImage) />
							<cfset LOCAL.category.addImage(LOCAL.categoryImage) />
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif FORM["ads_image_count"] NEQ 0>
				<cfloop collection="#FORM#" item="LOCAL.key">
					<cfif Find("ADS_IMAGE_",LOCAL.key) AND Find("_STATUS",LOCAL.key)>
						<cfset LOCAL.currentIndex = Replace(Replace(LOCAL.key,"ADS_IMAGE_",""),"_STATUS","") />
						<cfif StructFind(FORM,LOCAL.key) EQ "done">
							<cfset LOCAL.imgName = StructFind(FORM,"ADS_IMAGE_#LOCAL.currentIndex#_NAME") />
							<cfset LOCAL.newAdvertisement = EntityNew("page_section_advertisement") />
							<cfset LOCAL.newAdvertisement.setName(LOCAL.imgName) />
							<cfset LOCAL.newAdvertisement.setSection(LOCAL.advertisementSection) />
							<cfset LOCAL.newAdvertisement.setCategory(LOCAL.category) />
							<cfset EntitySave(LOCAL.newAdvertisement) />
							<cfset LOCAL.advertisementSection.addAdvertisement(LOCAL.newAdvertisement) />
							
							<cfset LOCAL.sizeArray = [{name = "small", width = "200", height = "200", position="center", crop = true}] />	
							<cfset LOCAL.imagePath = ExpandPath("#APPLICATION.absoluteUrlSite#images/uploads/advertise/") />
							<cfset _createImages(	imagePath = LOCAL.imagePath,
													imageNameWithExtension = LOCAL.imgName,
													sizeArray = LOCAL.sizeArray) />
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif StructKeyExists(FORM,"default_image_id") AND FORM.default_image_id NEQ "">
				<cfset LOCAL.currentDefaultImage = EntityLoad("category_image",{category=LOCAL.category,isDefault=true},true) />
				<cfif NOT IsNull(LOCAL.currentDefaultImage)>
					<cfset LOCAL.currentDefaultImage.setIsDefault(false) />
					<cfset EntitySave(LOCAL.currentDefaultImage) />
				</cfif>
				<cfset LOCAL.newDefaultImage = EntityLoadByPK("category_image", FORM.default_image_id) />
				<cfset LOCAL.newDefaultImage.setIsDefault(true) />
				<cfset EntitySave(LOCAL.newDefaultImage) />
			</cfif>
			
			<cfset LOCAL.sectionProducts = EntityLoad("page_section_product", {section = LOCAL.bestSellerSection, category = LOCAL.category})> 
			<cfloop array="#LOCAL.sectionProducts#" index="LOCAL.sectionProduct">
				<cfset EntityDelete(LOCAL.sectionProduct) />
			</cfloop>
			<cfif StructKeyExists(FORM,"products_selected") AND FORM.products_selected NEQ "">
				<cfloop list="#FORM.products_selected#" index="LOCAL.productId">
					<cfset LOCAL.newSectionProduct = EntityNew("page_section_product") />
					<cfset LOCAL.newSectionProduct.setSection(LOCAL.bestSellerSection) />
					<cfset LOCAL.newSectionProduct.setProduct(EntityLoadByPK("product",LOCAL.productId)) />
					<cfset LOCAL.newSectionProduct.setCategory(LOCAL.category) />
					<cfset EntitySave(LOCAL.newSectionProduct) />
				</cfloop>
			</cfif>
			
			<!--- filters --->
			<cfif IsNumeric(FORM.id)>
				<!--- category filters and values --->
				<cfset LOCAL.category.removeCategoryFilterRelas() />
			</cfif>
			
			<cfloop list="#FORM.c_filter_id#" index="LOCAL.filter_id">
				<cfset LOCAL.categoryFilterRela = EntityNew("category_filter_rela") />
				<cfset LOCAL.categoryFilterRela.setCategory(LOCAL.category) />
				<cfset LOCAL.categoryFilterRela.setFilter(EntityLoadByPK("filter",LOCAL.filter_id)) />
				<cfset LOCAL.category.addCategoryFilterRela(LOCAL.categoryFilterRela) /> 
				
				<cfif StructKeyExists(FORM,"c_filter_option_id_#LOCAL.filter_id#")>
					<cfloop list="#FORM["c_filter_option_id_#LOCAL.filter_id#"]#" index="LOCAL.foid">
						<cfset LOCAL.filterValue = EntityNew("filter_value") />
						<cfset LOCAL.filterValue.setValue(Trim(FORM["c_filter_option_value_#LOCAL.filter_id#_#LOCAL.foid#"])) />
						<cfif NOT Find("no_image_available.png", FORM["c_filter_option_imagename_#LOCAL.filter_id#_#LOCAL.foid#"])>
							<cfset LOCAL.filterValue.setImageName(FORM["c_filter_option_imagename_#LOCAL.filter_id#_#LOCAL.foid#"]) />
						</cfif>
						<cfset LOCAL.filterValue.setCategoryFilterRela(LOCAL.categoryFilterRela) />
						
						<cfset EntitySave(LOCAL.filterValue) />
						<cfset LOCAL.categoryFilterRela.addFilterValue(LOCAL.filterValue) />
					</cfloop>
				</cfif>
				
				<cfset EntitySave(LOCAL.categoryFilterRela) />
			</cfloop>
			
			<cfset EntitySave(LOCAL.category) />
						
			<!--- filter option images --->
			<cfif FORM.image_count_hidden GT 0>
				<cfset LOCAL.imageDir = "#APPLICATION.absolutePathRoot#images\uploads\category\#LOCAL.category.getCategoryId()#\filters\" />
				<cfif NOT DirectoryExists(LOCAL.imageDir)>
					<cfdirectory action = "create" directory = "#LOCAL.imageDir#" />
				</cfif>	
				<cfloop from="1" to="#FORM.image_count_hidden#" index="LOCAL.i">
					<cffile action = "upload"  
							fileField = "new_filter_option_image_#LOCAL.i - 1#"
							destination = "#LOCAL.imageDir#"
							nameConflict = "MakeUnique"> 
					
					<cfset LOCAL.categoryImage = EntityNew("category_image") />
					<cfset LOCAL.categoryImage.setName(cffile.serverFile) />
					<cfset EntitySave(LOCAL.categoryImage) />
					<cfset LOCAL.category.addImage(LOCAL.categoryImage) />
					
					<cfset LOCAL.sizeArray = [{name = "thumbnail", width = "30", height = "30", position="center", crop = true}
											] />			
					<cfset _createImages(	imagePath = LOCAL.imageDir,
											imageNameWithExtension = cffile.serverFile,
											sizeArray = LOCAL.sizeArray) />
				</cfloop>
			</cfif>
			
			<cfset EntitySave(LOCAL.category) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Category has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite##getPageName()#.cfm?id=#LOCAL.category.getCategoryId()#&active_tab_id=#LOCAL.tab_id#" />
		
		<cfelseif StructKeyExists(FORM,"delete_item")>
		
			<cfset LOCAL.category.setIsDeleted(true) />
			<cfset EntitySave(LOCAL.category) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Category: #LOCAL.category.getDisplayName()# has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#categories.cfm" />
		
		<cfelseif StructKeyExists(FORM,"delete_image")>
		
			<cfset LOCAL.image = EntityLoadByPK("category_image",FORM.deleted_image_id) />
			<cfset LOCAL.category.removeImage(LOCAL.image) />
			<cfset EntitySave(LOCAL.category) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Image has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite##getPageName()#.cfm?id=#LOCAL.category.getCategoryId()#&active_tab_id=tab_5" />
		
		<cfelseif StructKeyExists(FORM,"delete_ad")>
			
			<cfset LOCAL.ad = EntityLoadByPK("page_section_advertisement",FORM.deleted_ad_id) />			
			<cfset LOCAL.advertisementSection.removeAdvertisement(LOCAL.ad) />
			<cfset EntitySave(LOCAL.advertisementSection) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Advertise image has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite##getPageName()#.cfm?id=#LOCAL.category.getCategoryId()#&active_tab_id=tab_7" />
		</cfif>
		--->
		
	</cffunction>	
	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.categoryService = new "core.services.categoryService"() />
		<cfset LOCAL.productService = new "core.services.productService"() />
		
		<cfset LOCAL.pageData.categoryTree = LOCAL.categoryService.getCategoryTree() />
		<cfset LOCAL.pageData.filters = EntityLoad("filter",{isDeleted = false}, "filterId ASC") />
		<cfset LOCAL.pageData.totalTabs = 6 />
		
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>
			<cfset LOCAL.pageData.category = EntityLoadByPK("category", URL.id)> 
			<cfset LOCAL.pageData.title = "#LOCAL.pageData.category.getDisplayName()# | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "" />
			
			<cfset LOCAL.pageData.filterList = "" />
			<cfloop array="#LOCAL.pageData.category.getCategoryFilterRelas()#" index="LOCAL.categoryFilterRela">
				<cfset LOCAL.pageData.filterList &= "#LOCAL.categoryFilterRela.getFilter().getFilterId()#," />
			</cfloop>
			
			<cfset LOCAL.categoryService.setId(URL.id) />
			<cfset LOCAL.categoryService.setRecordsPerPage(APPLICATION.recordsPerPage) />
			<cfif StructKeyExists(URL,"page") AND IsNumeric(Trim(URL.page))>
				<cfset LOCAL.categoryService.setPageNumber(Trim(URL.page)) />
			</cfif>
			<cfset LOCAL.recordStruct = LOCAL.categoryService.getProducts() />
			<cfset LOCAL.pageData.paginationInfo = _getPaginationInfo(LOCAL.recordStruct) />
						
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = isNull(LOCAL.pageData.category.getDisplayName())?"":LOCAL.pageData.category.getDisplayName() />
				<cfset LOCAL.pageData.formData.parent_category_id = isNull(LOCAL.pageData.category.getParentCategory())?"":LOCAL.pageData.category.getParentCategory().getCategoryId() />
				<cfset LOCAL.pageData.formData.rank = isNull(LOCAL.pageData.category.getRank())?"":LOCAL.pageData.category.getRank() />
				<cfset LOCAL.pageData.formData.is_enabled = isNull(LOCAL.pageData.category.getIsEnabled())?"":LOCAL.pageData.category.getIsEnabled() />
				<cfset LOCAL.pageData.formData.display_category_list = isNull(LOCAL.pageData.category.getDisplayCategoryList())?"":LOCAL.pageData.category.getDisplayCategoryList() />
				<cfset LOCAL.pageData.formData.is_special = isNull(LOCAL.pageData.category.getIsSpecial())?"":LOCAL.pageData.category.getIsSpecial() />
				<cfset LOCAL.pageData.formData.display_custom_design = isNull(LOCAL.pageData.category.getDisplayCustomDesign())?"":LOCAL.pageData.category.getDisplayCustomDesign() />
				<cfset LOCAL.pageData.formData.display_filter = isNull(LOCAL.pageData.category.getDisplayFilter())?"":LOCAL.pageData.category.getDisplayFilter() />
				<cfset LOCAL.pageData.formData.show_category_on_navigation = isNull(LOCAL.pageData.category.getShowCategoryOnNavigation())?"":LOCAL.pageData.category.getShowCategoryOnNavigation() />
				<cfset LOCAL.pageData.formData.title = isNull(LOCAL.pageData.category.getTitle())?"":LOCAL.pageData.category.getTitle() />
				<cfset LOCAL.pageData.formData.keywords = isNull(LOCAL.pageData.category.getKeywords())?"":LOCAL.pageData.category.getKeywords() />
				<cfset LOCAL.pageData.formData.description = isNull(LOCAL.pageData.category.getDescription())?"":LOCAL.pageData.category.getDescription() />
				<cfset LOCAL.pageData.formData.custom_design = isNull(LOCAL.pageData.category.getCustomDesign())?"":LOCAL.pageData.category.getCustomDesign() />
				<cfset LOCAL.pageData.formData.id = URL.id />
			</cfif>
		<cfelse>
			<cfset LOCAL.pageData.title = "New Category | #APPLICATION.applicationName#" />
			<cfset LOCAL.pageData.deleteButtonClass = "hide-this" />
			<cfset LOCAL.pageData.filterList = "" />
			
			<cfif IsDefined("SESSION.temp.formData")>
				<cfset LOCAL.pageData.formData = SESSION.temp.formData />
			<cfelse>
				<cfset LOCAL.pageData.formData.display_name = "" />
				<cfset LOCAL.pageData.formData.parent_category_id = "" />
				<cfset LOCAL.pageData.formData.rank = "" />
				<cfset LOCAL.pageData.formData.is_enabled = "" />
				<cfset LOCAL.pageData.formData.display_category_list = "" />
				<cfset LOCAL.pageData.formData.is_special = "" />
				<cfset LOCAL.pageData.formData.display_custom_design = "" />
				<cfset LOCAL.pageData.formData.display_filter = "" />
				<cfset LOCAL.pageData.formData.show_category_on_navigation = "" />
				<cfset LOCAL.pageData.formData.title = "" />
				<cfset LOCAL.pageData.formData.keywords = "" />
				<cfset LOCAL.pageData.formData.description = "" />
				<cfset LOCAL.pageData.formData.custom_design = "" />
				<cfset LOCAL.pageData.formData.id = "" />
			</cfif>
		</cfif>
		
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
		
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>