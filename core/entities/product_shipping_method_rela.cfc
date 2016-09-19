<cfcomponent persistent="true"> 
    <cfproperty name="productShippingMethodRelaId" column="product_shipping_method_rela_id" fieldtype="id" generator="native">
	<cfproperty name="useDefaultPrice" column="use_default_price" ormtype="boolean">
	<cfproperty name="price" column="price" ormtype="float">
	
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="shippingMethod" fieldtype="many-to-one" cfc="shipping_method" fkcolumn="shipping_method_id">
</cfcomponent>
