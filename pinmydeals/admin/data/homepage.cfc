<cfcomponent extends="core.pages.page">
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset SESSION.temp.message = {} />
		<cfset SESSION.temp.message.messageArray = [] />
		<cfset SESSION.temp.message.messageType = "alert-success" />
		
		<cfset LOCAL.currentPageName = "index" />
		
		<cfset LOCAL.currentPage = EntityLoad("page", {name = LOCAL.currentPageName},true)> 
		<cfset LOCAL.pageData.modules = _convertModules(EntityLoad("page_module",{page = LOCAL.pageData.currentPage})) />
		
		<cfif StructKeyExists(FORM,"save_item")>
			<cfset LOCAL.currentPage.setTitle(Trim(FORM.title)) />			
			<cfset LOCAL.currentPage.setKeywords(Trim(FORM.keywords)) />			
			<cfset LOCAL.currentPage.setDescription(Trim(FORM.description)) />	
			
			<cfset EntitySave(LOCAL.slideSection) />
			<cfset EntitySave(LOCAL.currentPage) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Content has been saved successfully.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite##getPageName()#.cfm?&active_tab_id=#FORM.tab_id#" />
		<cfreturn LOCAL />	
	</cffunction>	
	
	<cffunction name="_loadPageData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
		
		<cfset LOCAL.pageData.title = "Homepage | #APPLICATION.applicationName#" />
		<cfset LOCAL.pageData.deleteButtonClass = "" />	
		
		<cfset LOCAL.currentPageName = "index" />
		<cfset LOCAL.pageData.currentPage = EntityLoad("page", {name = LOCAL.currentPageName},true)>
		<cfset LOCAL.pageData.productGroups = EntityLoad("product_group") />
		<cfset LOCAL.pageData.modules = _convertModules(EntityLoad("page_module",{page = LOCAL.pageData.currentPage})) />
		
		<cfif IsDefined("SESSION.temp.formData")>
			<cfset LOCAL.pageData.formData = SESSION.temp.formData />
		<cfelse>
			<cfset LOCAL.pageData.formData.title = LOCAL.pageData.currentPage.getTitle() />
			<cfset LOCAL.pageData.formData.keywords = LOCAL.pageData.currentPage.getKeywords() />
			<cfset LOCAL.pageData.formData.description = LOCAL.pageData.currentPage.getDescription() />
			<cfset LOCAL.pageData.formData.slide_content = LOCAL.pageData.slideSection.getContent() />
		</cfif>
		
		<cfset LOCAL.pageData.tabs = _setActiveTab() />
		<cfset LOCAL.pageData.message = _setTempMessage() />
	
		<cfreturn LOCAL.pageData />	
	</cffunction>
</cfcomponent>