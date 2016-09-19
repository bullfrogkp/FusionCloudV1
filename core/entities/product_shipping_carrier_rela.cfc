<cfcomponent persistent="true"> 
    <cfproperty name="productShippingCarrierRelaId" column="product_shipping_carrier_rela_id" fieldtype="id" generator="native">
	<cfproperty name="useDefaultPrice" column="use_default_price" ormtype="boolean">
	<cfproperty name="price" column="price" ormtype="float">
	
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="shippingCarrier" fieldtype="many-to-one" cfc="shipping_carrier" fkcolumn="shipping_carrier_id">
</cfcomponent>
