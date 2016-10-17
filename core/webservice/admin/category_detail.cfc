<cfcomponent restpath="category" rest="true">
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
</cfcomponent>