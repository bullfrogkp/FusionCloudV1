<cfcomponent extends="admin.application">
	<!------------------------------------------------------------------------------->
	<cffunction name="onSessionStart" returnType="void">
		<cfset _setUser() />
		<cfset _setCurrency() />
		<cfset _setTrackingEntity() />
		<cfset _setCart() />
		<cfset _setHistory() />
		<cfset _setTheme("mobile") />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_initPageObject" output="false" access="private" returnType="any">
		<cfargument name="pageName" type="string" required="true"/>
		
		<cfif FileExists("#APPLICATION.absolutePathRoot#data/#ARGUMENTS.pageName#.cfc")>
			<cfset var pageObj = new "siteData.#ARGUMENTS.pageName#"(pageName = ARGUMENTS.pageName, formData = {}, urlData = {}, cgiData = {}, sessionData = {}) />
		<cfelse>
			<cfset var pageObj = new core.pages.page(pageName = ARGUMENTS.pageName, formData = {}, urlData = {}, cgiData = {}, sessionData = {}) />
		</cfif>
		
		<cfreturn pageObj />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="onRequestStart" returntype="boolean" output="false">
		<cfargument type="String" name="targetPage" required="true"/>
		
		<cfif NOT StructKeyExists(SESSION,"user")>
			<cfset onSessionStart() />
		</cfif>
		
		<cfif StructKeyExists(URL,"sitetheme")>
			<cfset _setTheme(URL.sitetheme) />
			<cfif StructKeyExists(URL,"page") AND Trim(URL.page) NEQ "">
				<cflocation url="#URL.page#" addToken="false" />
			</cfif>
		</cfif>
		
		<!--- exclude ajax request --->
		<cfif NOT StructKeyExists(URL,"method")>
			<cfset var currentPageName = Replace(Replace(CGI.SCRIPT_NAME,GetDirectoryFromPath(CGI.SCRIPT_NAME),""),".cfm","") />
			<!---
			<cftry>		
			--->
				<cfset var args = {} />
				<cfset args.pageName = currentPageName />
				
				<cfset var globalPageObj = APPLICATION.globalPageObj />
				<cfset globalPageObj.setUrlData(URL) />
				<cfset globalPageObj.setCgiData(CGI) />
				<cfset globalPageObj.setSessionData(SESSION) />
				<cfset var pageObj = _initPageObject(argumentCollection = args) />
				<cfset pageObj.setUrlData(URL) />
				<cfset pageObj.setCgiData(CGI) />
				<cfset pageObj.setSessionData(SESSION) />
				<cfset var returnStruct = {} />
			
				<!--- form.file is image upload plugin --->
				<cfif IsDefined("FORM") AND NOT StructIsEmpty(FORM) AND NOT StructKeyExists(FORM,"file")>
					<cfset globalPageObj.setFormData(FORM) />
					<cfset pageObj.setFormData(FORM) />
					
					<!--- global data handler --->
					<cfset returnStruct = globalPageObj.processFormDataBeforeValidation() />
					<cfif returnStruct.redirectUrl NEQ "">
						<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
					</cfif>
					
					<cfset returnStruct = globalPageObj.validateFormData() />
					<cfif returnStruct.redirectUrl NEQ "">
						<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
					<cfelse>
						<cfif IsDefined("SESSION.temp.formData")>
							<cfset StructDelete(SESSION.temp,"formData") />
						</cfif>
					</cfif>
					
					<cfset returnStruct = globalPageObj.processFormDataAfterValidation() />
					<cfif returnStruct.redirectUrl NEQ "">
						<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
					</cfif>
				
					<!--- page data handler --->
					<cfset returnStruct = pageObj.processFormDataBeforeValidation() />
					<cfif returnStruct.redirectUrl NEQ "">
						<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
					</cfif>
					
					<cfset returnStruct = pageObj.validateFormData() />
					<cfif returnStruct.redirectUrl NEQ "">
						<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
					<cfelse>
						<cfif IsDefined("SESSION.temp.formData")>
							<cfset StructDelete(SESSION.temp,"formData") />
						</cfif>
					</cfif>
					
					<cfset returnStruct = pageObj.processFormDataAfterValidation() />
					<cfif returnStruct.redirectUrl NEQ "">
						<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
					</cfif>
					
					<cflocation url = "#_getCurrentURL()#" addToken = "no" />
				</cfif>
						
				<cfset returnStruct = globalPageObj.validateAccessData() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>		
				
				<cfset returnStruct = globalPageObj.processURLDataBeforeValidation() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>		
						
				<cfset returnStruct = pageObj.processURLDataBeforeValidation() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>
				
				<cfset returnStruct = pageObj.validateAccessData() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>
				
				<cfset returnStruct = globalPageObj.processURLDataAfterValidation() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>		
						
				<cfset returnStruct = pageObj.processURLDataAfterValidation() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>
				
				<cfset LOCAL.dataStruct = globalPageObj.loadData() />
				<cfset LOCAL.pageDataStruct = pageObj.loadData() />
				
				<cfset StructAppend(LOCAL.dataStruct.pageData, LOCAL.pageDataStruct.pageData) />
				<cfset StructAppend(LOCAL.dataStruct.pageView, LOCAL.pageDataStruct.pageView) />
				<cfset StructAppend(LOCAL.dataStruct.moduleData, LOCAL.pageDataStruct.moduleData) />
				<cfset StructAppend(LOCAL.dataStruct.moduleView, LOCAL.pageDataStruct.moduleView) />
				<cfset StructAppend(REQUEST, LOCAL.dataStruct) />
			
				<cfif StructKeyExists(SESSION,"temp")>	
					<cfset StructDelete(SESSION,"temp") />
				</cfif>
			
				<cfset REQUEST.pageData.currentPageName = currentPageName />
				<cfset REQUEST.pageData.templatePath = currentPageName & ".cfm" />
			<!---	
				<cfcatch type="any">
					<cfset new "#APPLICATION.componentPathRoot#core.utils.utils().handleError(cfcatch = cfcatch) />
					<cflocation url="#APPLICATION.absoluteUrlWeb#error.cfm" addtoken="false" />
				</cfcatch>
			</cftry>
			--->
		</cfif>
		
		<cfreturn true>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setUser"  access="private" returnType="void" output="false">
		<cfif IsNull(SESSION.user)>
			<cfset var LOCAL = {} />
			<cfset LOCAL.defaultCustomerGroup = EntityLoad("customer_group",{isDefault = true},true) />
			
			<cfset SESSION.user = {} />
			<cfset SESSION.user.userName = CGI.REMOTE_ADDR />
			<cfset SESSION.user.customerId = "" />
			<cfset SESSION.user.customerGroupId = LOCAL.defaultCustomerGroup.getCustomerGroupId() />
			<cfset SESSION.user.customerGroupName = LOCAL.defaultCustomerGroup.getName() />
			<cfset SESSION.user.ip = CGI.REMOTE_ADDR />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setCurrency"  access="private" returnType="void" output="false">
		<cfif IsNull(SESSION.currency)>
			<cfset var defaultCurrency = EntityLoad("currency",{isDefault=true},true) />
		
			<cfset SESSION.currency = {} />
			<cfset SESSION.currency.id = defaultCurrency.getCurrencyId() />
			<cfset SESSION.currency.code = defaultCurrency.getCode() />
			<cfset SESSION.currency.symbol = defaultCurrency.getSymbolText() />
			<cfset SESSION.currency.locale = defaultCurrency.getLocale() />
		</cfif>
	</cffunction>
	
	<!------------------------------------------------------------------------------->
	<cffunction name="_setTrackingEntity"  access="private" returnType="void" output="false">
		<cfif IsNull(SESSION.trackingEntity)>
			<cfset var trackingEntity = EntityLoad("tracking_entity",{cfid = COOKIE.cfid, cftoken = COOKIE.cftoken}, true) />
			<cfif IsNull(trackingEntity)>
				<cfset trackingEntity = EntityNew("tracking_entity") />
				<cfset trackingEntity.setCfid(COOKIE.cfid) />
				<cfset trackingEntity.setCftoken(COOKIE.cftoken) />
				<cfset trackingEntity.setLastAccessDatetime(Now()) />
				<cfset EntitySave(trackingEntity) />
				<cfset ORMFlush() />
			</cfif>
			
			<cfset SESSION.trackingEntity = trackingEntity />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setCart"  access="private" returnType="void" output="false">
		<cfif IsNull(SESSION.cart)>
			<cfset SESSION.cart = new "#APPLICATION.componentPathRoot#core.entities.cart"(	trackingEntity = SESSION.trackingEntity
																						, 	customerGroupId = SESSION.user.customerGroupId
																						, 	currencyId = SESSION.currency.id) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setHistory"  access="private" returnType="void" output="false">
		<cfif IsNull(SESSION.history)>
			<cfset SESSION.history = new "#APPLICATION.componentPathRoot#core.entities.history"(	trackingEntity = SESSION.trackingEntity) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setTheme"  access="private" returnType="void" output="false">
		<cfargument type="string" name="folderNameTheme" required=true /> 
		
		<cfset SESSION.folderNameTheme = ARGUMENTS.folderNameTheme>		
		<cfset SESSION.urlTheme = "#APPLICATION.urlWeb#themes/#SESSION.folderNameTheme#/">
		<cfset SESSION.absoluteUrlTheme = "#APPLICATION.absoluteUrlWeb#themes/#SESSION.folderNameTheme#/">
		<cfset SESSION.absolutePathTheme = "#APPLICATION.absolutePathRoot#themes\#SESSION.folderNameTheme#\">
	</cffunction>
	<!----------------------------------------------------------------------------
	<cffunction name="onMissingTemplate" returnType="any">
	    <cfargument name="targetPage" type="string" required=true/>
   
		<cflog text="cannot find page: #ARGUMENTS.targetPage#" />
		
		<cflocation url="#APPLICATION.absoluteUrlWeb#error.cfm" addtoken="false" />
	</cffunction>--->
	<!------------------------------------------------------------------------------->
</cfcomponent>