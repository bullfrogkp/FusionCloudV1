<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="systemEmailId" column="system_email_id" fieldtype="id" generator="native"> 
    <cfproperty name="subject" column="subject" ormtype="string"> 
    <cfproperty name="content" column="content" ormtype="string"> 
    <cfproperty name="type" column="type" ormtype="string"> 
</cfcomponent>