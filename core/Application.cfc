<cfcomponent output="false" accessors="true">
	<!------------------------------------------------------------------------------->
	<cfset this.name = Config().name>
	<cfset this.ormEnabled = Config().ormEnabled> 
	<cfset this.ormSettings.dbCreate = Config().ormSettings.dbCreate>
	<cfset this.ormSettings.cfcLocation = Config().ormSettings.cfcLocation>
	<cfset this.dataSource = Config().dataSource> 
	<cfset this.sessionManagement = Config().sessionManagement>
	<cfset this.sessionTimeout = Config().sessionTimeout>
	<cfset this.restsettings.cfclocation = "./webservice">
    <cfset this.restsettings.skipcfcwitherror = false>
	<!------------------------------------------------------------------------------->
	<cfset this.mappings[ "/core" ] = Config().env.absolutePathCore />
	<cfset this.mappings[ "/siteData" ] = Config().env.absolutePathSiteData />
	<!------------------------------------------------------------------------------->
    <cffunction name="Config" access="public" returntype="struct" output="false" hint="Returns the Application.cfc configuration settings struct based on the execution environment (production, staging, development, etc).">
		<cfargument type="boolean" name="reload" required="false" default="false"/>
		
		<cfif ARGUMENTS.reload EQ true OR NOT StructKeyExists( THIS, "$Config" )>
            <cfset THIS[ "$Config" ] = {} />
			
			<cfset THIS[ "$Config" ].name = "PinMyDeals-API" />
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
</cfcomponent>