<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="newsletterId" column="newsletter_id" fieldtype="id" generator="native"> 
    <cfproperty name="subject" column="subject" ormtype="string"> 
    <cfproperty name="content" column="content" ormtype="string"> 
    <cfproperty name="type" column="type" ormtype="string"> 
</cfcomponent>