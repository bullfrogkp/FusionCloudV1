<cfcomponent persistent="true"> 
    <cfproperty name="pageId" column="page_id" fieldtype="id" generator="native">
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="title" column="title" ormtype="string"> 
    <cfproperty name="keywords" column="keywords" ormtype="text"> 
    <cfproperty name="description" column="description" ormtype="text"> 
	<cfproperty name="section" fieldtype="many-to-one" cfc="section" fkcolumn="section_id">
	<cfproperty name="modules" type="array" fieldtype="one-to-many" cfc="page_module" fkcolumn="page_id" singularname="module" cascade="delete-orphan">
	
	<cffunction name="getModules" access="public" output="false" returnType="array">
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.pageModules = EntityLoad("page_module",{page = this, isDeleted = false, isEnabled = true}) />
				
		<cfreturn LOCAL.pageModules />
	</cffunction>
</cfcomponent>