<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="attributeId" column="attribute_id" fieldtype="id" generator="native">
	<cfproperty name="filters" type="array" fieldtype="one-to-many" cfc="filter" fkcolumn="attribute_id" singularname="filter">
</cfcomponent>
