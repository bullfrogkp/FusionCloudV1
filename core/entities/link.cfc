<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="linkId" column="link_id" fieldtype="id" generator="native"> 
    <cfproperty name="uuid" column="uuid" ormtype="string"> 
	<cfproperty name="customer" fieldtype="many-to-one" cfc="customer" fkcolumn="customer_id">
	<cfproperty name="linkType" fieldtype="many-to-one" cfc="link_type" fkcolumn="link_type_id">
	<cfproperty name="linkStatusType" fieldtype="many-to-one" cfc="link_status_type" fkcolumn="link_status_type_id">
</cfcomponent>