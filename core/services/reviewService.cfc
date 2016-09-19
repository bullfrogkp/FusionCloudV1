<cfcomponent extends="service" output="false" accessors="true">
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
			SELECT COUNT(reviewId) 
			</cfif>
			FROM review 
			WHERE 1=1
			<cfif getSearchKeywords() NEQ "">	
			AND	(subject like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" /> OR content like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#getSearchKeywords()#%" />)
			</cfif>
			<cfif NOT IsNull(getId())>
			AND reviewId = <cfqueryparam cfsqltype="cf_sql_integer" value="#getId()#" />
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
</cfcomponent>