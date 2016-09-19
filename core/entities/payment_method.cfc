<cfcomponent persistent="true"> 
    <cfproperty name="paymentMethodId" column="payment_method_id" fieldtype="id" generator="native"> 
	<cfproperty name="name" column="name" ormtype="string"> 
	<cfproperty name="displayName" column="display_name" ormtype="string"> 
	<cfproperty name="function" column="function" ormtype="string"> 
</cfcomponent>
