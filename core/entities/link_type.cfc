<cfcomponent persistent="true"> 
    <cfproperty name="linkTypeId" column="link_type_id" fieldtype="id" generator="native"> 
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="redirectURL" column="redirect_url" type="string" />
</cfcomponent>