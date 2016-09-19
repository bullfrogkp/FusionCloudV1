<cfcomponent persistent="true"> 
    <cfproperty name="shippingCarrierId" column="shipping_carrier_id" fieldtype="id" generator="native"> 
	<cfproperty name="name" column="name" ormtype="string"> 
	<cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="imageName" column="image_name" ormtype="string"> 
	<cfproperty name="component" column="component" ormtype="string"> 
	<cfproperty name="description" column="description" ormtype="string"> 
	<cfproperty name="isEnabled" column="is_enabled" ormtype="boolean"> 
	<cfproperty name="shippingMethods" type="array" fieldtype="one-to-many" cfc="shipping_method" fkcolumn="shipping_carrier_id" singularname="shippingMethod" cascade="delete-orphan">
</cfcomponent>
