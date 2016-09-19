<cfcomponent persistent="true"> 
    <cfproperty name="emailContentId" column="email_content_id" fieldtype="id" generator="native"> 
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="displayName" column="display_name" ormtype="string"> 
    <cfproperty name="subject" column="subject" ormtype="string"> 
    <cfproperty name="content" column="content" ormtype="text"> 
	<cfproperty name="emailContentType" fieldtype="many-to-one" cfc="email_content_type" fkcolumn="email_content_type_id">
</cfcomponent>