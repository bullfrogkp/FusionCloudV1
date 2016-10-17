<!--- code starts --->
<cfcomponent restpath="student" rest="true">
  
 <cffunction name="getHandlerJSON"
                access="remote"
                httpmethod="POST"
                returntype="string" returnformat="plain">
    
        <cfset myQuery = queryNew("id,name", 
                                  "Integer,varchar",
                                  [[1, "Sagar"], [2, "Ganatra"]])>
        <cfquery dbtype="query"
                 name="resultQuery">
            select * from myQuery where id = #arguments.customerID#
        </cfquery>
        <cfset retString = "#URL.callback#(#SerializeJSON(resultQuery)#);" />
		
		<cfreturn retString>
    </cffunction>   
  
</cfcomponent>
<!--- code ends --->