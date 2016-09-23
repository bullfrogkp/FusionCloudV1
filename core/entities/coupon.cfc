<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="couponId" column="coupon_id" fieldtype="id" generator="native"> 
    <cfproperty name="couponCode" column="coupon_code" ormtype="string"> 
    <cfproperty name="startDate" column="start_date" ormtype="date"> 
    <cfproperty name="endDate" column="end_date" ormtype="date"> 
    <cfproperty name="thresholdAmount" column="threshold_amount" ormtype="float"> 
	
	<cfproperty name="customer" fieldtype="many-to-one" cfc="customer" fkcolumn="customer_id">
	<cfproperty name="discountType" fieldtype="many-to-one" cfc="discount_type" fkcolumn="discount_type_id">
    <cfproperty name="order" fieldtype="many-to-one" cfc="order" fkcolumn="order_id">
	<cfproperty name="couponStatusType" fieldtype="many-to-one" cfc="coupon_status_type" fkcolumn="coupon_status_type_id">
</cfcomponent>