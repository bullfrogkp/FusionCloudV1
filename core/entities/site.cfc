<cfcomponent persistent="true"> 
    <cfproperty name="siteId" column="site_id" fieldtype="id" generator="native"> 
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="displayName" column="display_name" ormtype="string"> 
    <cfproperty name="title" column="title" ormtype="string"> 
    <cfproperty name="keywords" column="keywords" ormtype="text"> 
    <cfproperty name="description" column="description" ormtype="text"> 
	<cfproperty name="modules" type="array" fieldtype="one-to-many" cfc="site_module" fkcolumn="site_id" singularname="module" cascade="delete-orphan">
	<cfproperty name="pages" type="array" fieldtype="one-to-many" cfc="page" fkcolumn="site_id" singularname="page" cascade="delete-orphan">
	
	<cffunction name="getModules" access="public" output="false" returnType="array">
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.siteModules = EntityLoad("site_module",{site = this, isDeleted = false, isEnabled = true}) />
				
		<cfreturn LOCAL.siteModules />
	</cffunction>
</cfcomponent>