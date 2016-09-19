<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="orderProductId" column="order_product_id" fieldtype="id" generator="native">
	<cfproperty name="productName" column="product_name" ormtype="string">
	<cfproperty name="sku" column="sku" ormtype="string">
	<cfproperty name="price" column="price" ormtype="float"> 
	<cfproperty name="quantity" column="quantity" ormtype="integer"> 
	<cfproperty name="taxCategoryName" column="tax_category_name" ormtype="string">
	<cfproperty name="taxRate" column="tax_rate" ormtype="float"> 
	<cfproperty name="imageName" column="image_name" ormtype="string">
	<cfproperty name="shippingCarrierName" column="shipping_carrier" ormtype="string">
	<cfproperty name="shippingMethodName" column="shipping_method" ormtype="string">
	<cfproperty name="shippingTrackingNumber" column="shipping_tracking_number" ormtype="string">
	<cfproperty name="comments" column="comments" ormtype="string">
	
	<cfproperty name="taxAmount" column="tax_amount" ormtype="float"> 
	<cfproperty name="shippingAmount" column="shipping_amount" ormtype="float"> 
	<cfproperty name="totalAmount" column="total_amount" ormtype="float"> 
	<cfproperty name="subtotalAmount" column="subtotal_amount" ormtype="float"> 
	
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	
	<cfproperty name="orderProductStatus" type="array" fieldtype="one-to-many" cfc="order_product_status" fkcolumn="order_product_id">
</cfcomponent>
