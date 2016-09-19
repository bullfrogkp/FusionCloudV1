<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="wishlistProductId" column="wishlist_product_id" fieldtype="id" generator="native">
	
	<cfproperty name="customer" fieldtype="many-to-one" cfc="customer" fkcolumn="customer_id">
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
</cfcomponent>