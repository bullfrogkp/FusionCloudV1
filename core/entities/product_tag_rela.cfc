<cfcomponent persistent="true"> 
    <cfproperty name="productTagRelaId" column="product_tag_rela_id" fieldtype="id" generator="native">
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="tag" fieldtype="many-to-one" cfc="tag" fkcolumn="tag_id">
</cfcomponent>
