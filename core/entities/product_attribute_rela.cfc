<cfcomponent persistent="true"> 
    <cfproperty name="productAttributeRelaId" column="product_attribute_rela_id" fieldtype="id" generator="native"> 
	<cfproperty name="attributeValues" type="array" fieldtype="one-to-many" cfc="attribute_value" fkcolumn="product_attribute_rela_id" singularname="attributeValue" cascade="delete-orphan">
	
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="attribute" fieldtype="many-to-one" cfc="attribute" fkcolumn="attribute_id">
</cfcomponent>