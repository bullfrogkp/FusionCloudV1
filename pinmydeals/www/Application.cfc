<cfcomponent output="false" accessors="true">
	<!------------------------------------------------------------------------------->
	<cfset this.name = Config().name>
	<cfset this.ormEnabled = Config().ormEnabled> 
	<cfset this.ormSettings.dbCreate = Config().ormSettings.dbCreate>
	<cfset this.ormSettings.cfcLocation = Config().ormSettings.cfcLocation>
	<cfset this.dataSource = Config().dataSource> 
	<cfset this.sessionManagement = Config().sessionManagement>
	<cfset this.sessionTimeout = Config().sessionTimeout>
	<!------------------------------------------------------------------------------->
	<cfset this.mappings[ "/core" ] = Config().env.absolutePathCore />
	<cfset this.mappings[ "/siteData" ] = Config().env.absolutePathSiteData />
	<!------------------------------------------------------------------------------->
    <cffunction name="Config" access="public" returntype="struct" output="false" hint="Returns the Application.cfc configuration settings struct based on the execution environment (production, staging, development, etc).">
		<cfargument type="boolean" name="reload" required="false" default="false"/>
		
		<cfif ARGUMENTS.reload EQ true OR NOT StructKeyExists( THIS, "$Config" )>
            <cfset THIS[ "$Config" ] = {} />
			
			<cfset THIS[ "$Config" ].name = "PinMyDeals" />
			<cfset THIS[ "$Config" ].ormEnabled = "true" />
			<cfset THIS[ "$Config" ].ormSettings = {} />
			<cfset THIS[ "$Config" ].ormSettings.dbCreate = "update" />
			<cfset THIS[ "$Config" ].ormSettings.cfcLocation = "/site/core/entities/" />
			<cfset THIS[ "$Config" ].dataSource = "db_eshop" />
			<cfset THIS[ "$Config" ].sessionManagement = "yes" />
			<cfset THIS[ "$Config" ].sessionTimeout = CreateTimeSpan(0,12,0,0) /> 
			
			<cfset THIS[ "$Config" ].env = {} />
            <cfif Find( "127.0.0.1", CGI.server_name ) OR Find( ".loc", CGI.server_name )>
                <cfset THIS[ "$Config" ].isLive = false />
				<cfset THIS[ "$Config" ].env.domain = "www.pinmydeals.loc" />
				<cfset THIS[ "$Config" ].env.apiDomain = "api.pinmydeals.loc" />
				<cfset THIS[ "$Config" ].env.absoluteUrlSite = "/" />
				<cfset THIS[ "$Config" ].env.absolutePathSite = ExpandPath("/site/pinmydeals/www/") />
				<cfset THIS[ "$Config" ].env.absolutePathSiteData = ExpandPath("/site/pinmydeals/www/data/") />
				<cfset THIS[ "$Config" ].env.absolutePathCore = ExpandPath("/site/core/") />
				<cfset THIS[ "$Config" ].env.urlHttp = "http://#THIS[ "$Config" ].env.domain#" />
				<cfset THIS[ "$Config" ].env.urlHttps = "http://#THIS[ "$Config" ].env.domain#" />
				
				<cfset THIS[ "$Config" ].env.ups = {} />
				<cfset THIS[ "$Config" ].env.ups.accesskey = "CC9C9C10118EBCF0">
				<cfset THIS[ "$Config" ].env.ups.upsuserid = "berserk_2nd">
				<cfset THIS[ "$Config" ].env.ups.upspassword = "Shabishini1">
				<cfset THIS[ "$Config" ].env.ups.rate_url = "https://wwwcie.ups.com/ups.app/xml/Rate">
				<cfset THIS[ "$Config" ].env.ups.av_url = "https://wwwcie.ups.com/ups.app/xml/AV">
				<cfset THIS[ "$Config" ].env.ups.tracking_url = "https://wwwcie.ups.com/ups.app/xml/Track">
				
				<cfset THIS[ "$Config" ].env.canadapost = {} />
				<cfset THIS[ "$Config" ].env.canadapost.username = "03ac5bc25c8f08e5">
				<cfset THIS[ "$Config" ].env.canadapost.password = "e87558a6b864af93152ab1">
				<cfset THIS[ "$Config" ].env.canadapost.rate_url = "https://soa-gw.canadapost.ca/rs/ship/price">
				
				<cfset THIS[ "$Config" ].env.paypal = {} >
				<cfset THIS[ "$Config" ].env.paypal.APIuserName = "pqhitp_1341165924_biz_api1.hotmail.com">
				<cfset THIS[ "$Config" ].env.paypal.APIPassword = "1341165955">
				<cfset THIS[ "$Config" ].env.paypal.APISignature = "AiPC9BjkCyDFQXbSkoZcgqH3hpacATbKynOthb8vHNx-Us8jDe7sMzsE"> 
				<cfset THIS[ "$Config" ].env.paypal.version = "60.0">
				<cfset THIS[ "$Config" ].env.paypal.serverURL = "https://api-3t.sandbox.paypal.com/nvp"> 
				<cfset THIS[ "$Config" ].env.paypal.useProxy = "false">
				<cfset THIS[ "$Config" ].env.paypal.proxyName = "">
				<cfset THIS[ "$Config" ].env.paypal.proxyPort = "">
				<cfset THIS[ "$Config" ].env.paypal.PayPalURL = "https://www.sandbox.paypal.com/cgi-bin/soofanscr?cmd=_express-checkout&useraction=commit&token=">
            <cfelse>
                <cfset THIS[ "$Config" ].isLive = true />
				<cfset THIS[ "$Config" ].env.domain = "www.pinmydeals.com" />
				<cfset THIS[ "$Config" ].env.absoluteUrlSite = "/" />
				<cfset THIS[ "$Config" ].env.absolutePathSite = ExpandPath("/site/pinmydeals/www/") />
				<cfset THIS[ "$Config" ].env.absolutePathCore = ExpandPath("/site/core/") />
				<cfset THIS[ "$Config" ].env.urlHttp = "http://#THIS[ "$Config" ].env.domain#" />
				<cfset THIS[ "$Config" ].env.urlHttps = "http://#THIS[ "$Config" ].env.domain#" />
				
				<cfset THIS[ "$Config" ].env.ups = {} />
				<cfset THIS[ "$Config" ].env.ups.accesskey = "CC9C9C10118EBCF0">
				<cfset THIS[ "$Config" ].env.ups.upsuserid = "berserk_2nd">
				<cfset THIS[ "$Config" ].env.ups.upspassword = "Shabishini1">
				<cfset THIS[ "$Config" ].env.ups.rate_url = "https://wwwcie.ups.com/ups.app/xml/Rate">
				<cfset THIS[ "$Config" ].env.ups.av_url = "https://wwwcie.ups.com/ups.app/xml/AV">
				<cfset THIS[ "$Config" ].env.ups.tracking_url = "https://wwwcie.ups.com/ups.app/xml/Track">
				
				<cfset THIS[ "$Config" ].env.canadapost = {} />
				<cfset THIS[ "$Config" ].env.canadapost.username = "03ac5bc25c8f08e5">
				<cfset THIS[ "$Config" ].env.canadapost.password = "e87558a6b864af93152ab1">
				<cfset THIS[ "$Config" ].env.canadapost.rate_url = "https://soa-gw.canadapost.ca/rs/ship/price">
				
				<cfset THIS[ "$Config" ].env.paypal = {} >
				<cfset THIS[ "$Config" ].env.paypal.APIuserName = "pqhitp_1341165924_biz_api1.hotmail.com">
				<cfset THIS[ "$Config" ].env.paypal.APIPassword = "1341165955">
				<cfset THIS[ "$Config" ].env.paypal.APISignature = "AiPC9BjkCyDFQXbSkoZcgqH3hpacATbKynOthb8vHNx-Us8jDe7sMzsE"> 
				<cfset THIS[ "$Config" ].env.paypal.version = "60.0">
				<cfset THIS[ "$Config" ].env.paypal.serverURL = "https://api-3t.sandbox.paypal.com/nvp"> 
				<cfset THIS[ "$Config" ].env.paypal.useProxy = "false">
				<cfset THIS[ "$Config" ].env.paypal.proxyName = "">
				<cfset THIS[ "$Config" ].env.paypal.proxyPort = "">
				<cfset THIS[ "$Config" ].env.paypal.PayPalURL = "https://www.sandbox.paypal.com/cgi-bin/soofanscr?cmd=_express-checkout&useraction=commit&token=">
            </cfif>
			
			<cfset THIS[ "$Config" ].env.emailCustomerService = "customerservice@#THIS[ "$Config" ].env.domain#" />
			<cfset THIS[ "$Config" ].env.emailAdmin = "admin@#THIS[ "$Config" ].env.domain#" />
			<cfset THIS[ "$Config" ].env.emailDevelopment = "dev@#THIS[ "$Config" ].env.domain#" />
			<cfset THIS[ "$Config" ].env.emailInfo = "info@#THIS[ "$Config" ].env.domain#" />
			<cfset THIS[ "$Config" ].env.recordsPerPage = 10 />
			<cfset THIS[ "$Config" ].env.recordsPerPageFrontend = 12 />
        </cfif>
       
        <cfreturn THIS[ "$Config" ] />
    </cffunction>
    <!------------------------------------------------------------------------------->
	<cffunction name="onApplicationStart" returntype="boolean" output="false">
		<cfset SetEncoding("form","utf-8") />
		<cfset SetEncoding("url","utf-8") />
		<cfset StructAppend(APPLICATION, Config().env) />
		<cfset APPLICATION.globalPageObj = new siteData.global(pageName = "", formData = {}, urlData = {}, cgiData = {}, sessionData = {}) />
		<cfreturn true>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="onSessionStart" returnType="void">
		<cfset _setUser() />
		<cfset _setCurrency() />
		<cfset _setTheme("mobile") />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_initPageObject" output="false" access="private" returnType="any">
		<cfargument name="pageName" type="string" required="true"/>
		
		<cfif FileExists("#APPLICATION.absolutePathSiteData#/#ARGUMENTS.pageName#.cfc")>
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
				<cfset StructAppend(LOCAL.dataStruct.moduleData, LOCAL.pageDataStruct.moduleData) />
				<cfset StructAppend(REQUEST, LOCAL.dataStruct) />
			
				<cfif StructKeyExists(SESSION,"temp")>	
					<cfset StructDelete(SESSION,"temp") />
				</cfif>
			
				<cfset REQUEST.pageData.currentPageName = currentPageName />
				<cfset REQUEST.pageData.templatePath = currentPageName & ".cfm" />
			<!---	
				<cfcatch type="any">
					<cfset new "core.utils.utils().handleError(cfcatch = cfcatch) />
					<cflocation url="#APPLICATION.urlAdmin#error.cfm" addtoken="false" />
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
	<cffunction name="_setTheme"  access="private" returnType="void" output="false">
		<cfargument type="string" name="folderNameTheme" required=true /> 
		
		<cfset SESSION.folderNameTheme = ARGUMENTS.folderNameTheme>		
		<cfset SESSION.urlTheme = "#APPLICATION.urlHttpAdmin#themes/#SESSION.folderNameTheme#/">
		<cfset SESSION.absoluteUrlTheme = "#APPLICATION.urlAdmin#themes/#SESSION.folderNameTheme#/">
		<cfset SESSION.absolutePathTheme = "#APPLICATION.pathAdmin#themes\#SESSION.folderNameTheme#\">
	</cffunction>
	<!----------------------------------------------------------------------------
	<cffunction name="onMissingTemplate" returnType="any">
	    <cfargument name="targetPage" type="string" required=true/>
   
		<cflog text="cannot find page: #ARGUMENTS.targetPage#" />
		
		<cflocation url="#APPLICATION.urlAdmin#error.cfm" addtoken="false" />
	</cffunction>--->
	<!------------------------------------------------------------------------------->
</cfcomponent>