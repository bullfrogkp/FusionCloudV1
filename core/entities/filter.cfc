<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="filterId" column="filter_id" fieldtype="id" generator="native"> 
	<cfproperty name="attribute" fieldtype="many-to-one" cfc="attribute" fkcolumn="attribute_id">
</cfcomponent>