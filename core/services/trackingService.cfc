<cfcomponent extends="service" output="false" accessors="true">
	<cfproperty name="cfid" type="string"> 
	<cfproperty name="cftoken" type="string"> 
	<!--------------------------------------------------------------------------------------------------------------->	
	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="cfid" type="string" required="true">
		<cfargument name="cftoken" type="string" required="true">
		
		<!--- need to use property values later, instead using cookie values here, current reason is the ajax calls from product detail page --->
		<cfset setCfid(ARGUMENTS.cfid) />
		<cfset setCftoken(ARGUMENTS.cftoken) />
		
	    <cfreturn this />
	</cffunction>
	<!--------------------------------------------------------------------------------------------------------------->
	<cffunction name="addTrackingRecord" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="productId" type="numeric" required="true">
		<cfargument name="trackingRecordType" type="string" required="true">
		<cfargument name="count" type="numeric" required="false" default="0">
		
		<cfset var LOCAL = {} />
		<cfset var retStruct = {} />
		
		<cfset LOCAL.product = EntityLoadByPK("product",ARGUMENTS.productId) />
		<cfset LOCAL.trackingRecordType = EntityLoad("tracking_record_type",{name = ARGUMENTS.trackingRecordType},true) />
		<cfset LOCAL.trackingEntity = EntityLoad("tracking_entity",{cfid = COOKIE.cfid, cftoken = COOKIE.cftoken},true) />
		
		<cfset LOCAL.trackingRecord = EntityLoad("tracking_record", {trackingRecordType = LOCAL.trackingRecordType, trackingEntity = LOCAL.trackingEntity, product = LOCAL.product}, true) />
		
		<cfif NOT IsNull(LOCAL.trackingRecord)>
			<cfset LOCAL.trackingRecord.setQuantity(LOCAL.trackingRecord.getQuantity() + ARGUMENTS.count) />
		<cfelse>
			<cfset LOCAL.trackingRecord = EntityNew("tracking_record") />
			<cfset LOCAL.trackingRecord.setTrackingRecordType(LOCAL.trackingRecordType) />
			<cfset LOCAL.trackingRecord.setTrackingEntity(LOCAL.trackingEntity) />
			<cfset LOCAL.trackingRecord.setProduct(LOCAL.product) />
			<cfset LOCAL.trackingRecord.setQuantity(ARGUMENTS.count) />
			<cfset EntitySave(LOCAL.trackingRecord) />
		</cfif>
		
		<cfset retStruct.trackingRecordId = LOCAL.trackingRecord.getTrackingRecordId() />
		
		<cfreturn retStruct />
	</cffunction>
	
	<cffunction name="getTrackingRecords" access="public" output="false" returnType="array">
		<cfargument name="trackingRecordType" type="string" required="true">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.trackingRecordType = EntityLoad("tracking_record_type",{name = ARGUMENTS.trackingRecordType},true) />
		<cfset LOCAL.trackingEntity = EntityLoad("tracking_entity",{cfid = COOKIE.cfid, cftoken = COOKIE.cftoken},true) />
		<cfset LOCAL.trackingRecords = EntityLoad("tracking_record", {trackingRecordType = LOCAL.trackingRecordType, trackingEntity = LOCAL.trackingEntity}) />
		
		<cfreturn LOCAL.trackingRecords />	
	</cffunction>	
</cfcomponent>