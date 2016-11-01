<cfcomponent output="false">
	<cffunction name="searchProducts" access="remote" returntype="query" returnformat="json" output="false">
		<cfargument name="productGroupId" type="numeric" required="true">
		<cfargument name="categoryId" type="numeric" required="true">
		<cfargument name="keywords" type="string" required="true">
		
		<cfset var LOCAL = {} />
		
		<cfquery name="LOCAL.getProducts">
			SELECT	p.name
			,		p.product_id
			FROM	product p 
			JOIN	product_type pt ON p.product_type_id = pt.product_type_id
			<cfif ARGUMENTS.categoryId NEQ 0>
			JOIN	category_product_rela cpr ON cpr.product_id = p.product_id 
			JOIN	category c ON c.category_id = cpr.category_id
			AND 	
			(
				c.category_id = <cfqueryparam value="#ARGUMENTS.categoryId#" cfsqltype="cf_sql_integer" />
				OR
				c.parent_category_id = <cfqueryparam value="#ARGUMENTS.categoryId#" cfsqltype="cf_sql_integer" />
				OR
				(SELECT	parent_category_id FROM category c_sub WHERE c_sub.category_id = c.parent_category_id) = <cfqueryparam value="#ARGUMENTS.categoryId#" cfsqltype="cf_sql_integer" />
			)
			</cfif>
			<cfif ARGUMENTS.productGroupId NEQ 0>
			JOIN	product_group_product_rela pgpr ON p.product_id = pgpr.product_id AND pgpr.product_group_id = <cfqueryparam value="#ARGUMENTS.productGroupId#" cfsqltype="cf_sql_integer" />
			</cfif>
			WHERE	pt.name != 'option'
			AND		p.name IS NOT NULL
			AND		p.is_deleted = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />
			AND		p.is_enabled = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
			<cfif ARGUMENTS.keywords NEQ "">
			AND
			(
				p.display_name like <cfqueryparam value="%#Trim(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_string" />
				OR
				p.keywords like <cfqueryparam value="%#Trim(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_string" />
				OR
				p.description like <cfqueryparam value="%#Trim(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_string" />
			)
			</cfif>
		</cfquery>
		
		<cfreturn LOCAL.getProducts>
	</cffunction>
</cfcomponent>