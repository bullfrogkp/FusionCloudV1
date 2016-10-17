<cfcomponent restpath="category_detail" rest="true">
	 <cffunction name="add" access="remote" httpmethod="POST" returntype="void">
        <cfset myQuery = queryNew("id,name", 
                                  "Integer,varchar",
                                  [[1, "Sagar"], [2, "Ganatra"]])>
        <cfquery dbtype="query"
                 name="resultQuery">
            select * from myQuery where id = #arguments.customerID#
        </cfquery>
        <cfreturn resultQuery>
    </cffunction>  
	<!---
	<cffunction name="add" access="remote" httpmethod="POST" returntype="void">
		<cfargument name="name" required="true" restargsource="Form" type="string"/>

		<cfset var LOCAL = {} />
		<cfset LOCAL.category = EntityNew("category")> 
		<cfset LOCAL.category.setCreatedUser(SESSION.adminUser) />
		<cfset LOCAL.category.setCreatedDatetime(Now()) />
		<cfset LOCAL.category.setIsDeleted(false) />
		<cfset LOCAL.category.setName(LCase(Trim(FORM.display_name))) />
		<cfset LOCAL.category.setDisplayName(Trim(FORM.display_name)) />
		<cfset LOCAL.category.setRank(Val(Trim(FORM.rank))) />
		<cfset LOCAL.category.setIsEnabled(FORM.is_enabled) />
		<cfset LOCAL.category.setDisplayCategoryList(FORM.display_category_list) />
		<cfset LOCAL.category.setIsSpecial(FORM.is_special) />
		<cfset LOCAL.category.setDisplayCustomDesign(FORM.display_custom_design) />
		<cfset LOCAL.category.setDisplayFilter(FORM.display_filter) />
		<cfset LOCAL.category.setShowCategoryOnNavigation(FORM.show_category_on_navigation) />
		<cfset LOCAL.category.setTitle(Trim(FORM.title)) />
		<cfset LOCAL.category.setKeywords(Trim(FORM.keywords)) />
		<cfset LOCAL.category.setDescription(Trim(FORM.description)) />
		<cfset LOCAL.category.setCustomDesign(Trim(FORM.custom_design)) />
		<cfset EntitySave(LOCAL.category) />
	</cffunction> 
	
	<cffunction name="addStudent" access="remote" returntype="void" httpmethod="POST">
		<cfargument name="name" type="string" required="yes" restargsource="Form"/>
		<cfargument name="age" type="numeric" required="yes" restargsource="Form"/>
		<!--- Adding the student to data base. --->
		</cffunction>
		<cffunction name="getStudent" access="remote" returntype="student" restpath="{name}-{age}">
		<cfargument name="name" type="string" required="yes" restargsource="Path"/>
		<cfargument name="age" type="string" required="yes" restargsource="Path"/>
		<!--- Create a student object and return the object. This object will handle the request now. --->
		<cfset var myobj = createObject("component", "student")>
		<cfset myobj.name = name>
		<cfset myobj.age = age>
		<cfreturn myobj>
	</cffunction>
	--->
</cfcomponent>