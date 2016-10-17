<!--- code starts --->
<cfcomponent restpath="student" rest="true">
  
 <cffunction name="getHandlerJSON"
                access="remote"
                httpmethod="GET"
                restpath="{customerID}"
                returntype="query"
                produces="application/json">
                    
        <cfargument name="customerID"
                    required="true"
                    restargsource="Path"
                    type="numeric"/>
    
        <cfset myQuery = queryNew("id,name", 
                                  "Integer,varchar",
                                  [[1, "Sagar"], [2, "Ganatra"]])>
        <cfquery dbtype="query"
                 name="resultQuery">
            select * from myQuery where id = #arguments.customerID#
        </cfquery>
        <cfreturn resultQuery>
    </cffunction>   
  
</cfcomponent>
<!--- code ends --->