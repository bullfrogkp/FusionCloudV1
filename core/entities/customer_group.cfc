<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="customerGroupId" column="customer_group_id" fieldtype="id" generator="native"> 
	<cfproperty name="isDefault" column="is_default" ormtype="boolean"> 
	<cfproperty name="discountType" fieldtype="many-to-one" cfc="discount_type" fkcolumn="discount_type_id">
	<cfproperty name="productCustomerGroupRelas" type="array" fieldtype="one-to-many" cfc="product_customer_group_rela" fkcolumn="customer_group_id">
</cfcomponent>