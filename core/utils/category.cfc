<cfcomponent output="false">
	<cffunction name="getCategoryArray" access="public" returntype="array">
		<cfargument name="parent_category_id" type="numeric" required="false" />
	    <cfargument name="display_sub_categories" type="boolean" required="false" />
		
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.category_array = ArrayNew(1) />
	      
		<cfinvoke component="#APPLICATION.component_path_db#category" method="getCategories" returnvariable="LOCAL.categories">
			<cfinvokeargument name="parent_category_id" value="#ARGUMENTS.parent_category_id#">
			<cfinvokeargument name="category_enabled" value="TRUE">
			<cfinvokeargument name="display" value="TRUE">
		</cfinvoke>
		
		<cfloop query="LOCAL.categories">
			<cfset LOCAL.category_struct = {} />
		
			<cfset LOCAL.category_struct.category_id = LOCAL.categories.category_id />
			<cfset LOCAL.category_struct.category_name = LOCAL.categories.category_name />
			<cfset LOCAL.category_struct.category_name_display = LOCAL.categories.category_name_display />
			
			<cfif StructKeyExists(ARGUMENTS,"display_sub_categories") AND ARGUMENTS.display_sub_categories EQ TRUE>
				<cfset LOCAL.category_struct.sub_category_array = getCategoryArray(parent_category_id = LOCAL.category_struct.category_id,display_sub_categories=TRUE) />
			</cfif>
			
			<cfset ArrayAppend(LOCAL.category_array, LOCAL.category_struct) />
		</cfloop>
		
        <cfreturn LOCAL.category_array />
	</cffunction>
</cfcomponent>