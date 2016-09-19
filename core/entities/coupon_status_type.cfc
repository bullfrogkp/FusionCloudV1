<cfcomponent persistent="true"> 
    <cfproperty name="couponStatusTypeId" column="coupon_status_type_id" fieldtype="id" generator="native"> 
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="displayName" column="display_name" ormtype="string"> 
</cfcomponent>