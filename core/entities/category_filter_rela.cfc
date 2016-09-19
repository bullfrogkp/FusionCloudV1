<cfcomponent persistent="true"> 
    <cfproperty name="categoryFilterRelaId" column="category_filter_rela_id" fieldtype="id" generator="native"> 
	<cfproperty name="filterValues" type="array" fieldtype="one-to-many" cfc="filter_value" fkcolumn="category_filter_rela_id" singularname="filterValue" cascade="delete-orphan">
	
	<cfproperty name="category" fieldtype="many-to-one" cfc="category" fkcolumn="category_id">
	<cfproperty name="filter" fieldtype="many-to-one" cfc="filter" fkcolumn="filter_id">
</cfcomponent>