<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="addressId" column="address_id" fieldtype="id" generator="native"> 
    <cfproperty name="company" column="company" ormtype="string"> 
    <cfproperty name="firstName" column="first_name" ormtype="string"> 
    <cfproperty name="middleName" column="middle_name" ormtype="string"> 
    <cfproperty name="lastName" column="last_name" ormtype="string"> 
    <cfproperty name="phone" column="phone" ormtype="string"> 
    <cfproperty name="unit" column="unit" ormtype="string"> 
    <cfproperty name="street" column="street" ormtype="string"> 
    <cfproperty name="city" column="city" ormtype="string"> 
    <cfproperty name="postalCode" column="postal_code" ormtype="string"> 
	<cfproperty name="province" fieldtype="many-to-one" cfc="province" fkcolumn="province_id">
	<cfproperty name="country" fieldtype="many-to-one" cfc="country" fkcolumn="country_id">
	<cfproperty name="customer" fieldtype="many-to-one" cfc="customer" fkcolumn="customer_id">
	
	<cffunction name="getFullName" access="public" output="false" returnType="string">
		
		<cfset var firstName = isNull(getFirstName())?"":getFirstName() />
		<cfset var middleName = isNull(getMiddleName())?"":getMiddleName() />
		<cfset var lastName = isNull(getLastName())?"":getLastName() />
		
		<cfif middleName EQ "">
			<cfset var fullName = firstName & " " & lastName />
		<cfelse>
			<cfset var fullName = firstName & " " & middleName & " " & lastName />
		</cfif>
		
		<cfreturn fullName />
	</cffunction>
</cfcomponent>