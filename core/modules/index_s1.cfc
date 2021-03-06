﻿<cfcomponent extends="core.modules.module">	
    <cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.categories = [] />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.name = "Jackets" />
		<cfset LOCAL.category.image = "#getSessionData().absoluteUrlTheme#images/special-item-1.jpg" />
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.name = "Jackets" />
		<cfset LOCAL.category.image = "#getSessionData().absoluteUrlTheme#images/special-item-2.jpg" />
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		
		<cfset LOCAL.category = {} />
		<cfset LOCAL.category.name = "Jackets" />
		<cfset LOCAL.category.image = "#getSessionData().absoluteUrlTheme#images/special-item-3.jpg" />
		<cfset ArrayAppend(LOCAL.retStruct.categories, LOCAL.category) />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>