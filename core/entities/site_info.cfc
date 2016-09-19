<cfcomponent persistent="true"> 
    <cfproperty name="siteInfoId" column="site_info_id" fieldtype="id" generator="native"> 
	<cfproperty name="name" column="name" ormtype="string"> 
	<cfproperty name="unit" column="unit" ormtype="string"> 
	<cfproperty name="street" column="street" ormtype="string"> 
	<cfproperty name="city" column="city" ormtype="string"> 
	<cfproperty name="postalCode" column="postal_code" ormtype="string"> 
	<cfproperty name="phone" column="phone" ormtype="string"> 
	<cfproperty name="email" column="email" ormtype="string"> 
	<cfproperty name="map" column="map" ormtype="text"> 
	<cfproperty name="province" fieldtype="many-to-one" cfc="province" fkcolumn="province_id">
	<cfproperty name="country" fieldtype="many-to-one" cfc="country" fkcolumn="country_id">
	
	<cffunction name="getAddress" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.address = {} />
		<cfset LOCAL.address.street = getStreet() />
		<cfset LOCAL.address.city = getCity() />
		<cfset LOCAL.address.provinceCode = getProvince().getCode() />
		<cfset LOCAL.address.postalCode = getPostalCode() />
		<cfset LOCAL.address.countryCode = getCountry().getCode() />
		
		<cfreturn LOCAL.address />
	</cffunction>
</cfcomponent>
