<cfcomponent extends="core.pages.page">	
	<cffunction name="validateAccessData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.messageArray = [] />
		
		<cfif NOT(StructKeyExists(URL,"u") AND Trim(URL.u) NEQ "")>
			<cfset ArrayAppend(LOCAL.messageArray,"The link is not valid.") />
		</cfif>
		
		<cfif ArrayLen(LOCAL.messageArray) GT 0>
			<cfset SESSION.temp.message = {} />
			<cfset SESSION.temp.message.messageArray = LOCAL.messageArray />
			<cfset SESSION.temp.message.messageType = "alert-danger" />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#invalid_link.cfm" />
		</cfif>
		
		<cfreturn LOCAL />
	</cffunction>
	
	<cffunction name="processURLDataAfterValidation" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.redirectUrl = "" />
		
		<cfset LOCAL.linkStatusType = EntityLoad("link_status_type",{name="active"},true) />
		<cfset LOCAL.link = EntityLoad("link",{uuid = Trim(URL.u), linkStatusType = LOCAL.linkStatusType}, true) />
		<cfif IsNull(LOCAL.link)>
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#invalid_link.cfm" />
		<cfelse>
			<cfset SESSION.temp.linkId = LOCAL.link.getLinkId() />
			<cfset LOCAL.redirectUrl = "#APPLICATION.absoluteUrlWeb#links/#LOCAL.link.getLinkType().getRedirectURL()#.cfm" />
		</cfif>
		
		<cfreturn LOCAL />	
	</cffunction>	
</cfcomponent>