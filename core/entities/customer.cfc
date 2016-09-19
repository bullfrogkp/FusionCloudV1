<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="customerId" column="customer_id" fieldtype="id" generator="native"> 
	<cfproperty name="email" column="email" ormtype="string"> 
	<cfproperty name="phone" column="phone" ormtype="string"> 
	<cfproperty name="company" column="company" ormtype="string"> 
    <cfproperty name="password" column="password" ormtype="string"> 
    <cfproperty name="lastLoginDatetime" column="last_login_datetime" ormtype="date"> 
    <cfproperty name="lastLoginIP" column="last_login_ip" ormtype="string"> 
	<cfproperty name="prefix" column="prefix" ormtype="string"> 
	<cfproperty name="firstName" column="first_name" ormtype="string"> 
	<cfproperty name="middleName" column="middle_name" ormtype="string"> 
	<cfproperty name="lastName" column="last_name" ormtype="string"> 
	<cfproperty name="suffix" column="suffix" ormtype="string"> 
	<cfproperty name="dateOfBirth" column="date_of_birth" ormtype="string"> 
	<cfproperty name="gender" column="gender" ormtype="string"> 
	<cfproperty name="website" column="website" ormtype="string"> 
	<cfproperty name="subscribed" column="subscribed" ormtype="boolean">
	<cfproperty name="isNew" column="is_new" ormtype="boolean">
	<cfproperty name="isAnonymous" column="is_anonymous" ormtype="boolean">
	
	<cfproperty name="customerGroup" fieldtype="many-to-one" cfc="customer_group" fkcolumn="customer_group_id">
	
	<cfproperty name="addresses" type="array" fieldtype="one-to-many" cfc="address" fkcolumn="customer_id" singularname="address">
	<cfproperty name="conversations" type="array" fieldtype="one-to-many" cfc="conversation" fkcolumn="customer_id" singularname="conversation">
	<cfproperty name="orders" type="array" fieldtype="one-to-many" cfc="order" fkcolumn="customer_id" singularname="order">
	<cfproperty name="reviews" type="array" fieldtype="one-to-many" cfc="review" fkcolumn="customer_id" singularname="review">
	<cfproperty name="wishlistProducts" type="array" fieldtype="one-to-many" cfc="wishlist_product" fkcolumn="customer_id" singularname="wishlistProduct">
	<cfproperty name="coupons" type="array" fieldtype="one-to-many" cfc="coupon" fkcolumn="customer_id" singularname="coupon">
	
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
	
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
	
	<cffunction name="getActiveOrders" access="public" output="false" returnType="array">
		<cfreturn EntityLoad("order",{customer = this, isDeleted = false}) />
	</cffunction>
	
	<cffunction name="getActiveAddresses" access="public" output="false" returnType="array">
		<cfreturn EntityLoad("address",{customer = this, isDeleted = false}) />
	</cffunction>
	
	<cffunction name="getActiveReviews" access="public" output="false" returnType="array">
		<cfset var LOCAL = {} />
		<cfset LOCAL.approvedStatusType = EntityLoad("review_status_type",{name="approved"},true) />
		
		<cfreturn EntityLoad("review",{customer = this, isDeleted = false, reviewStatusType = LOCAL.approvedStatusType}) />
	</cffunction>
	
	<cffunction name="getActiveCoupons" access="public" output="false" returnType="array">
		<cfset var LOCAL = {} />
		<cfset LOCAL.activeStatusType = EntityLoad("coupon_status_type",{name="active"},true) />
		
		<cfreturn EntityLoad("coupon",{customer = this, isDeleted = false, couponStatusType = LOCAL.activeStatusType}) />
	</cffunction>
	
	<cffunction name="shouldUpdate" access="public" output="false" returnType="boolean">
		<cfif IsNull(getFirstName()) OR Trim(getFirstName()) EQ "">
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>
	
	<cffunction name="setDeleted" access="public" output="false" returnType="void">
		<cfset setIsDeleted(true) />
		<cfset setIsEnabled(false) />
		<cfset setSubscribed(false) />
	</cffunction>
</cfcomponent>