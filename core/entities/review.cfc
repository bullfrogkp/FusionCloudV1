<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="reviewId" column="review_id" fieldtype="id" generator="native"> 
    <cfproperty name="reviewerName" column="reviewer_name" ormtype="string"> 
    <cfproperty name="subject" column="subject" ormtype="string"> 
    <cfproperty name="rating" column="rating" ormtype="integer"> 
    <cfproperty name="message" column="message" ormtype="string"> 
	<cfproperty name="isNew" column="is_new" ormtype="boolean">
	
	<cfproperty name="customer" fieldtype="many-to-one" cfc="customer" fkcolumn="customer_id">
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	<cfproperty name="reviewStatusType" fieldtype="many-to-one" cfc="review_status_type" fkcolumn="review_status_type_id">
</cfcomponent>