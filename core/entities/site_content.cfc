<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="siteContentId" column="site_content_id" fieldtype="id" generator="native"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="siteContent" column="site_content" ormtype="text"> 
</cfcomponent>
