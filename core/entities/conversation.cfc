<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="conversationId" column="conversation_id" fieldtype="id" generator="native"> 
    <cfproperty name="subject" column="subject" ormtype="string"> 
    <cfproperty name="description" column="description" ormtype="string"> 
    <cfproperty name="content" column="content" ormtype="text">
	<cfproperty name="isNew" column="is_new" ormtype="boolean">
	<cfproperty name="customer" fieldtype="many-to-one" cfc="customer" fkcolumn="customer_id">
</cfcomponent>