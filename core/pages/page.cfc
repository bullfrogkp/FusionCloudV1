<cfcomponent output="false" accessors="true">
	<cfproperty name="section" type="string" required="true"> 
	<cfproperty name="formData" type="struct" required="true"> 
	<cfproperty name="urlData" type="struct" required="true"> 
	<cfproperty name="cgiData" type="struct" required="true"> 
	<cfproperty name="sessionData" type="struct" required="true"> 
	<cfproperty name="pageName" type="string" required="false"> 
	<!------------------------------------------------------------------------------->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="formData" type="struct" required="true" />
		<cfargument name="urlData" type="struct" required="true" />
		<cfargument name="cgiData" type="struct" required="true" />
		<cfargument name="sessionData" type="struct" required="true" />
		<cfargument name="pageName" type="string" required="false" />
		
		<cfset setFormData(ARGUMENTS.formData) />
		<cfset setUrlData(ARGUMENTS.urlData) />
		<cfset setCgiData(ARGUMENTS.cgiData) />
		<cfset setSessionData(ARGUMENTS.sessionData) />
		<cfif StructKeyExists(ARGUMENTS,"pageName")>
			<cfset setPageName(ARGUMENTS.pageName) />
		</cfif>
		
		<cfreturn this />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="validateAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="processFormDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfif NOT StructIsEmpty(FORM)>
			<cfset SESSION.temp.formdata = Duplicate(FORM) />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
	<!------------------------------------------------------------------------------->	
	<cffunction name="validateFormData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="processFormDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>	
	<!------------------------------------------------------------------------------->
	<cffunction name="processURLDataBeforeValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>	
	<!------------------------------------------------------------------------------->
	<cffunction name="processURLDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfreturn LOCAL />	
	</cffunction>	
	<!------------------------------------------------------------------------------->
	<cffunction name="_setRedirectURL" access="private" output="false" returnType="string">
		<cfif StructKeyExists(URL,"id") AND IsNumeric(URL.id)>	
			<cfif StructKeyExists(URL,"active_tab_id")>	
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#admin/#getPageName()#.cfm?id=#URL.id#&active_tab_id=#URL.active_tab_id#" />
			<cfelse>
				<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#admin/#getPageName()#.cfm?id=#URL.id#" />
			</cfif>
		<cfelse>
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlSite#admin/#getPageName()#.cfm" />
		</cfif>
		
		<cfreturn LOCAL.redirectUrl />	
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setActiveTab" access="private" output="false" returnType="struct">
		<cfargument name="defaultActiveTabId" type="string" required="false">
		
		<cfset var LOCAL = {} />
	
		<cfset LOCAL.tabs = {} />
		<cfset LOCAL.tabs["tab_1"] = "" />
		<cfset LOCAL.tabs["tab_2"] = "" />
		<cfset LOCAL.tabs["tab_3"] = "" />
		<cfset LOCAL.tabs["tab_4"] = "" />
		<cfset LOCAL.tabs["tab_5"] = "" />
		<cfset LOCAL.tabs["tab_6"] = "" />
		<cfset LOCAL.tabs["tab_7"] = "" />
		<cfset LOCAL.tabs["tab_8"] = "" />
		<cfset LOCAL.tabs["tab_9"] = "" />
		<cfset LOCAL.tabs["tab_10"] = "" />
				
		<cfif StructKeyExists(URL,"active_tab_id")>	
			<cfset LOCAL.tabs["activeTabId"] = URL.active_tab_id />
			<cfset LOCAL.tabs["#URL.active_tab_id#"] = "active" />
		<cfelse>
			<cfset LOCAL.tabs["activeTabId"] = "tab_1" />
			<cfif StructKeyExists(ARGUMENTS,"defaultActiveTabId")>
				<cfset LOCAL.tabs["#ARGUMENTS.defaultActiveTabId#"] = "active" />
			<cfelse>
				<cfset LOCAL.tabs["tab_1"] = "active" />
			</cfif>
		</cfif>
		
		<cfreturn LOCAL.tabs /> 
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setTempMessage" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.message = {} />
	
		<cfif IsDefined("SESSION.temp.message") AND NOT ArrayIsEmpty(SESSION.temp.message.messageArray)>
			<cfset LOCAL.message.messageArray = SESSION.temp.message.messageArray />
			<cfset LOCAL.message.messageType = SESSION.temp.message.messageType />
		</cfif>
		
		<cfreturn LOCAL.message /> 
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_getPaginationInfo" access="private" output="false" returnType="struct">
		<cfargument name="recordStruct" type="struct" required="true"> 
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.records = ARGUMENTS.recordStruct.records />
		<cfset LOCAL.totalCount = ARGUMENTS.recordStruct.totalCount />
		<cfset LOCAL.totalPages = ARGUMENTS.recordStruct.totalPages />
		
		<cfset LOCAL.currentQueryString = "" />
		<cfloop collection="#URL#" item="LOCAL.key">
			<cfif LOCAL.key NEQ "page" AND LOCAL.key NEQ "active_tab_id">
				<cfset LOCAL.currentQueryString &= LOCAL.key & "=" & URL["#LOCAL.key#"] & "&" />
			</cfif>
		</cfloop>
		
		<cfif NOT IsNull(URL.page) AND IsNumeric(URL.page)>
			<cfset LOCAL.currentPage = URL.page />
		<cfelse>
			<cfset LOCAL.currentPage = 1 />
		</cfif>
		
		<cfreturn LOCAL /> 
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_createImages" access="private" output="false" returnType="void">
		<cfargument name="imagePath" type="string" required="true">
		<cfargument name="imageNameWithExtension" type="string" required="true">
		<cfargument name="sizeArray" type="array" required="true">
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.imageUtils = new "#APPLICATION.componentPathRoot#core.utils.imageUtils"() />
		<cfset LOCAL.image = ImageRead(ARGUMENTS.imagePath & ARGUMENTS.imageNameWithExtension)>
		
		<cfloop array="#ARGUMENTS.sizeArray#" index="LOCAL.size">
			<cfset LOCAL.newImage = ImageNew(LOCAL.image)>
				
			<cfif LOCAL.size.crop EQ true>
				<cfset LOCAL.newImage = LOCAL.imageUtils.aspectCrop(LOCAL.newImage, LOCAL.size.width, LOCAL.size.height, LOCAL.size.position)>
			<cfelseif  IsNumeric(LOCAL.size.width) AND IsNumeric(LOCAL.size.height)>
				<cfset ImageResize(LOCAL.newImage, LOCAL.size.width, LOCAL.size.height) />
			<cfelseif  IsNumeric(LOCAL.size.width)>
				<cfset ImageResize(LOCAL.newImage, LOCAL.size.width, "") />
			<cfelseif  IsNumeric(LOCAL.size.height)>
				<cfset ImageResize(LOCAL.newImage, "", LOCAL.size.height) />
			</cfif>
						
			<cfset ImageWrite(LOCAL.newImage,"#ARGUMENTS.imagePath##LOCAL.size.name#_#ARGUMENTS.imageNameWithExtension#")> 
		</cfloop>
		
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="loadData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.pageData = _loadPageData() />
		<cfset LOCAL.retStruct.pageView = _loadPageView() />
		<cfset LOCAL.retStruct.moduleData = _loadModuleData() />
		<cfset LOCAL.retStruct.moduleView = _loadModuleView() />
		
		<cfreturn LOCAL.retStruct />	
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="_loadPageData" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageData = {} />
				
		<cfset LOCAL.pageData.title = "" />
		<cfset LOCAL.pageData.description = "" />
		<cfset LOCAL.pageData.keywords = "" />
				
		<cfreturn LOCAL.pageData />	
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="_loadPageView" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageView = {} />
				
		<cfreturn LOCAL.pageView />	
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="_loadModuleData" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.site = EntityLoad("site",{name = APPLICATION.applicationName},true) />
		<cfset LOCAL.pageEntity = EntityLoad("page",{name = getPageName(), site = LOCAL.site},true) />
		<cfset LOCAL.modules = LOCAL.pageEntity.getModules() />
		
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.moduleObj =_initModuleObject(moduleName = LOCAL.module.getName()) />
			<cfset StructInsert(LOCAL.retStruct, LOCAL.module.getName(), LOCAL.moduleObj.getData()) />
		</cfloop>
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="_loadModuleView" access="private" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.site = EntityLoad("site",{name = APPLICATION.applicationName},true) />
		<cfset LOCAL.pageEntity = EntityLoad("page",{name = getPageName(), site = LOCAL.site},true) />
		<cfset LOCAL.modules = LOCAL.pageEntity.getModules() />
		
		<cfloop array="#LOCAL.modules#" index="LOCAL.module">
			<cfset LOCAL.moduleObj =_initModuleObject(moduleName = LOCAL.module.getName()) />
			<cfset StructInsert(LOCAL.retStruct, LOCAL.module.getName(), LOCAL.moduleObj.getFrontendView()) />
		</cfloop>
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="_initModuleObject" output="false" access="private" returnType="any">
		<cfargument type="string" name="moduleName" required="true"/>
		
		<cfset var moduleObj = new "core.modules.#ARGUMENTS.moduleName#"(pageName = getPageName(), formData = getFormData(), urlData = getUrlData(), cgiData = getCgiData(), sessionData = getSessionData()) />
		<cfreturn moduleObj />
	</cffunction>
	<!------------------------------------------------------------------------------->		
	<cffunction name="getModuleData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.pageEntity = EntityLoad("page",{name = getPageName()},true) />
		<cfloop array="#LOCAL.pageEntity.getModules()#" index="LOCAL.module">
			<cfset LOCAL.moduleObj =_initModuleObject(pageName = getPageName(), moduleName = LOCAL.module.getName()) />
			<cfset StructInsert(LOCAL.retStruct, LOCAL.module.getName(), LOCAL.moduleObj.geBackendData()) />
		</cfloop>
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->	
</cfcomponent>