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
	<cfset this.mappings[ "/siteDataAdmin" ] = Config().env.absolutePathSiteData />
	<!------------------------------------------------------------------------------->
    <cffunction name="Config" access="public" returntype="struct" output="false" hint="Returns the Application.cfc configuration settings struct based on the execution environment (production, staging, development, etc).">
		<cfargument type="boolean" name="reload" required="false" default="false"/>
		
		<cfif ARGUMENTS.reload EQ true OR NOT StructKeyExists( THIS, "$Config" )>
            <cfset THIS[ "$Config" ] = {} />
			
			<cfset THIS[ "$Config" ].name = "PinMyDeals Admin" />
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
				<cfset THIS[ "$Config" ].env.domain = "admin.pinmydeals.loc" />
				<cfset THIS[ "$Config" ].env.apiDomain = "api.pinmydeals.loc" />
				<cfset THIS[ "$Config" ].env.imagesDomain = "images.pinmydeals.loc" />
				<cfset THIS[ "$Config" ].env.absoluteUrlSite = "/" />
				<cfset THIS[ "$Config" ].env.absolutePathSite = ExpandPath("/site/pinmydeals/admin/") />
				<cfset THIS[ "$Config" ].env.absolutePathSiteData = ExpandPath("/site/pinmydeals/admin/data/") />
				<cfset THIS[ "$Config" ].env.absolutePathImages = ExpandPath("/site/pinmydeals/images/") />
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
	<!----------------------------------------------------------------------------
	<cferror type="Exception" template="/error.cfm" >
	<cferror type="Request" template="/error.cfm" >--->
	<!------------------------------------------------------------------------------->
	<cffunction name="onApplicationStart" returntype="boolean" output="false">
		<cfset SetEncoding("form","utf-8") />
		<cfset SetEncoding("url","utf-8") />
		<cfset StructAppend(APPLICATION, Config().env) />
		<cfset APPLICATION.globalPageObjAdmin = new siteDataAdmin.global(pageName = "", formData = {}, urlData = {}, cgiData = {}, sessionData = {}) />
		<cfreturn true>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="onSessionStart" returnType="void">
		<cfset _setAdminTheme("default") />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_initPageObject" output="false" access="private" returnType="any">
		<cfargument name="pageName" type="string" required="true"/>
		
		<cfif FileExists("#APPLICATION.absolutePathSiteData#/#ARGUMENTS.pageName#.cfc")>
			<cfset var pageObj = new "siteDataAdmin.#ARGUMENTS.pageName#"(pageName = ARGUMENTS.pageName, formData = {}, urlData = {}, cgiData = {}, sessionData = {}) />
		<cfelse>
			<cfset var pageObj = new core.pages.page(pageName = ARGUMENTS.pageName, formData = {}, urlData = {}, cgiData = {}, sessionData = {}) />
		</cfif>
		
		<cfreturn pageObj />
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="onRequestStart" returntype="boolean" output="false">
		<cfargument type="String" name="targetPage" required="true"/>

		<cfif NOT StructKeyExists(SESSION,"absoluteUrlThemeAdmin")>
			<cfset onSessionStart() />
		</cfif>
		
		<!--- add code for only admin can do it --->
		<cfif StructKeyExists(URL,"resetappvars")>
			<cfset StructAppend(APPLICATION, Config(reload = true).env,true) />
			<cfif reFindNoCase("android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino",CGI.HTTP_USER_AGENT) GT 0 OR reFindNoCase("1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|e\-|e\/|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\-|2|g)|yas\-|your|zeto|zte\-",Left(CGI.HTTP_USER_AGENT,4)) GT 0>
				<cfset _setAdminTheme("default") />
			<cfelse>
				<cfset _setAdminTheme("default") />
			</cfif>
		<cfelseif StructKeyExists(URL,"ormreload")>
			<cfset ORMReload() />
		<cfelseif StructKeyExists(URL,"logout")>
			<cfset StructDelete(SESSION,"adminUser") />
			<cflocation url="login.cfm" addToken="false" />
		<cfelseif StructKeyExists(URL,"admintheme")>
			<cfset _setAdminTheme(URL.admintheme) />
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
				
				<cfset var globalPageObj = APPLICATION.globalPageObjAdmin />
				<cfset globalPageObj.setUrlData(URL) />
				<cfset globalPageObj.setCgiData(CGI) />
				<cfset globalPageObj.setSessionData(SESSION) />
				<cfset globalPageObj.setPageName(currentPageName) />
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
				
				<cfset returnStruct = globalPageObj.processURLDataBeforeValidation() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>		
						
				<cfset returnStruct = pageObj.processURLDataBeforeValidation() />
				<cfif returnStruct.redirectUrl NEQ "">
					<cflocation url = "#returnStruct.redirectUrl#" addToken = "no" />
				</cfif>
				
				<cfset returnStruct = globalPageObj.validateAccessData() />
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
					<cfset new "#APPLICATION.componentPathRoot#core.utils.utils().handleError(cfcatch = cfcatch) />
					<cflocation url="#APPLICATION.absoluteUrlSite#error.cfm" addtoken="false" />
				</cfcatch>
			</cftry>
			--->
		</cfif>
			
		<cfreturn true>
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_setAdminTheme"  access="private" returnType="void" output="false">
		<cfargument type="string" name="folderNameTheme" required=true /> 
		
		<cfset var folderNameThemeAdmin = ARGUMENTS.folderNameTheme>		
		<cfset SESSION.urlThemeAdmin = "#APPLICATION.urlHttp#themes/#folderNameThemeAdmin#/">
		<cfset SESSION.absoluteUrlThemeAdmin = "#APPLICATION.absoluteUrlSite#themes/#folderNameThemeAdmin#/">
		<cfset SESSION.absolutePathThemeAdmin = "#APPLICATION.absolutePathSite#themes\#folderNameThemeAdmin#\">
	</cffunction>
	<!------------------------------------------------------------------------------->
	<cffunction name="_getCurrentURL" output="false" access="private" returnType="string">
		<cfset var theURL = getPageContext().getRequest().GetRequestUrl().toString()>
			<cfif len( CGI.query_string )>
				<cfset theURL = theURL & "?" & CGI.query_string>
			</cfif>
		<cfreturn theURL>
	</cffunction>
	<!----------------------------------------------------------------------------
	<cffunction name="onMissingTemplate" returnType="any">
	    <cfargument name="targetPage" type="string" required=true/>
   
		<cflog text="cannot find page: #ARGUMENTS.targetPage#" />
		
		<cflocation url="#APPLICATION.absoluteUrlSite#error.cfm" addtoken="false" />
	</cffunction>--->
	<!------------------------------------------------------------------------------->
</cfcomponent>