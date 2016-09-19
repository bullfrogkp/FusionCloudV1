<cfcomponent output="false" accessors="true">
	<cfproperty name="trackingEntity" type="any">
    
	<!------------------------------------------------------------------------------->
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="trackingEntity" type="any" required="true" />
		
		<cfset setTrackingEntity(ARGUMENTS.trackingEntity) />
		
		<cfreturn this />
	</cffunction>
	
	<!------------------------------------------------------------------------------->	
	<cffunction name="addHistoryItem" access="public" output="false" returnType="void">
		<cfargument name="productId" type="numeric" required="true" />
		
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.trackingRecord = EntityNew("tracking_record") />
		<cfset LOCAL.trackingRecordType = EntityLoad("tracking_record_type",{name = "history"},true) />
		<cfset LOCAL.product = EntityLoadByPK("product",ARGUMENTS.productId) />
		
		<cfset LOCAL.trackingRecord.setTrackingEntity(getTrackingEntity()) />
		<cfset LOCAL.trackingRecord.setTrackingRecordType(LOCAL.trackingRecordType) />
		<cfset LOCAL.trackingRecord.setProduct(LOCAL.product) />
		<cfset LOCAL.trackingRecord.setQuantity(1) />
		<cfset EntitySave(LOCAL.trackingRecord) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeHistoryItem" access="public" output="false" returnType="any">
		<cfargument name="trackingRecordId" type="integer" required="true" />
		
		<cfset EntityDelete(EntityLoadById("tracking_record",ARGUMENTS.trackingRecordId)) />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getHistoryItems" access="public" output="false" returnType="array">
		<cfset var LOCAL = {} />
		<cfset LOCAL.trackingRecordType = EntityLoad("tracking_record_type",{name = "history"},true) />
		<cfset LOCAL.trackingRecords = EntityLoad("tracking_record",{trackingRecordType = LOCAL.trackingRecordType, trackingEntity = getTrackingEntity()}) />
		
		<cfreturn LOCAL.trackingRecords />
	</cffunction>
	<!------------------------------------------------------------------------------->
</cfcomponent>
