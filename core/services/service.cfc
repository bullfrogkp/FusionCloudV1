<cfcomponent output="false" accessors="true">
    <cfproperty name="id" type="numeric"> 
    <cfproperty name="searchKeywords" type="string"> 
    <cfproperty name="isEnabled" type="boolean"> 
    <cfproperty name="isDeleted" type="boolean"> 
    <cfproperty name="pageNumber" type="numeric"> 
    <cfproperty name="recordsPerPage" type="numeric"> 

    <cffunction name="getPaginationStruct" output="false" access="public" returntype="struct">
		<!--- if use local scope, it will return extra field named 'arguments', it will break cfquery ormoptions value --->
		<cfset var retStruct = {} />
		
	    <cfif NOT IsNull(getPageNumber())>
			<cfset retStruct.offset = getRecordsPerPage() * (getPageNumber() - 1) />
		<cfelse>
			<cfset retStruct.offset = 0 />
		</cfif>
			
		<cfset retStruct.maxResults =  getRecordsPerPage() />
	   
		<cfreturn retStruct />
    </cffunction>
	
	<cffunction name="getRecords" output="false" access="public" returntype="struct">
		<cfset LOCAL = {} />
		
		<cfset LOCAL.records = _getQuery() /> 
		<cfset LOCAL.totalCount = _getQuery(getCount=true)[1] /> 
		<cfset LOCAL.totalPages = Ceiling(LOCAL.totalCount / getRecordsPerPage()) /> 
	
		<cfreturn LOCAL />
    </cffunction>
</cfcomponent>