<cfcomponent persistent="true"> 
    <cfproperty name="shippingMethodId" column="shipping_method_id" fieldtype="id" generator="native"> 
	<cfproperty name="name" column="name" ormtype="string"> 
	<cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="function" column="function" ormtype="string"> 
	<cfproperty name="description" column="description" ormtype="string"> 
	<cfproperty name="serviceCode" column="service_code" ormtype="string"> 
	<cfproperty name="isEnabled" column="is_enabled" ormtype="boolean"> 
	<cfproperty name="isDefault" column="is_default" ormtype="boolean"> 
	<cfproperty name="shippingCarrier" fieldtype="many-to-one" cfc="shipping_carrier" fkcolumn="shipping_carrier_id">
	<cfproperty name="productShippingMethodRelas" type="array" fieldtype="one-to-many" cfc="product_customer_group_rela" fkcolumn="shipping_method_id">
</cfcomponent>
