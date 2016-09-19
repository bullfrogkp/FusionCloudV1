<cfcomponent extends="service" output="false" accessors="true">	
	<cfproperty name="username" type="string"> 
    <cfproperty name="password" type="string"> 
	<!------------------------------------------------------------------------------------------------------------>
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
			SELECT COUNT(customerId) 
			</cfif>
			FROM customer 
			WHERE 1=1
			<cfif getSearchKeywords() NEQ "">	
			AND	(firstName like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" /> OR middleName like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" /> OR lasyName like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" />)
			</cfif>
			<cfif NOT IsNull(getId())>
			AND customerId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
			</cfif>
			<cfif NOT IsNull(getIsEnabled())>
			AND isEnabled = <cfqueryparam cfsqltype="cf_sql_bit" value="#getIsEnabled()#" />
			</cfif>
			<cfif NOT IsNull(getIsDeleted())>
			AND isDeleted = <cfqueryparam cfsqltype="cf_sql_bit" value="#getIsDeleted()#" />
			</cfif>
			<cfif ARGUMENTS.getCount EQ false>
			ORDER BY createdDatetime DESC
			</cfif>
		</cfquery>
	
		<cfreturn LOCAL.query />
    </cffunction>
	<!------------------------------------------------------------------------------------------------------------>
	<cffunction name="isUserValid" output="false" access="public" returntype="boolean">
		<cfset LOCAL = {} />
		<cfset LOCAL.retValue = false />
		
		<cfset LOCAL.customer = EntityLoad("customer",{email=getUsername(),password=Hash(getPassword()),isDeleted=false,isEnabled=true},true) />
		<cfif NOT IsNull(LOCAL.customer)>
			<cfset LOCAL.retValue = true />
		</cfif>
	
		<cfreturn LOCAL.retValue />
    </cffunction>
</cfcomponent>