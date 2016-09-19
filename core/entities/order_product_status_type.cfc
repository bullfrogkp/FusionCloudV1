<cfcomponent persistent="true"> 
    <cfproperty name="orderProductStatusTypeId" column="order_product_status_type_id" fieldtype="id" generator="native"> 
    <cfproperty name="name" column="name" ormtype="string">
	<cfproperty name="displayName" column="display_name" ormtype="string"> 
</cfcomponent>