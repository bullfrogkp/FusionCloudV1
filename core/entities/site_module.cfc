<cfcomponent persistent="true"> 
    <cfproperty name="siteModuleId" column="site_module_id" fieldtype="id" generator="native">
    <cfproperty name="name" column="name" ormtype="string">  
    <cfproperty name="site" fieldtype="many-to-one" cfc="site" fkcolumn="site_id">
    <cfproperty name="isDeleted" column="is_deleted" ormtype="boolean">  
    <cfproperty name="isEnabled" column="is_enabled" ormtype="boolean">  
</cfcomponent>