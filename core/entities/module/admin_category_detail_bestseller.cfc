<cfcomponent persistent="true"> 
    <cfproperty name="id" column="id" fieldtype="id" generator="native"> 
	<cfproperty name="label" column="label" ormtype="string">
	<cfproperty name="rank" column="rank" ormtype="integer"> 
	<cfproperty name="category" fieldtype="many-to-one" cfc="category" fkcolumn="category_id">
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
</cfcomponent>