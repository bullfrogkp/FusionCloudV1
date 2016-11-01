<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productImageId" column="product_image_id" fieldtype="id" generator="native"> 
    <cfproperty name="isDefault" column="is_default" ormtype="boolean"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
	
	<cffunction name="getImageLink" access="public" output="false" returnType="string">
		<cfargument name="type" type="string" required="false" default="" />
		
		<cfset var imageType = "" />
		<cfif Trim(ARGUMENTS.type) NEQ "">
			<cfset imageType = "#Trim(ARGUMENTS.type)#_" />
		</cfif>
		
		<cfreturn "#APPLICATION.urlAdmin#images/uploads/product/#getProduct().getProductId()#/#imageType##getName()#" />
	</cffunction>
</cfcomponent>