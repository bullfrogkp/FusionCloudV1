<cfcomponent persistent="true"> 
    <cfproperty name="attributeValueId" column="attribute_value_id" fieldtype="id" generator="native">
    <cfproperty name="imageName" column="image_name" ormtype="string">
    <cfproperty name="hasThumbnail" column="has_thumbnail" ormtype="boolean">
    <cfproperty name="value" column="value" ormtype="string">
	<cfproperty name="productAttributeRela" fieldtype="many-to-one" cfc="product_attribute_rela" fkcolumn="product_attribute_rela_id">
	
	<cffunction name="getImageLink" access="public" output="false" returnType="string">
		<cfargument name="type" type="string" required="false" default="" />
		
		<cfset var imageType = "" />
		<cfif Trim(ARGUMENTS.type) NEQ "">
			<cfset imageType = "#Trim(ARGUMENTS.type)#_" />
		</cfif>
		
		<cfset var imageLink = "" />
		
		<cfif NOT IsNull(getProductAttributeRela().getProduct().getParentProduct())>
			<cfset LOCAL.productId = getProductAttributeRela().getProduct().getParentProduct().getProductId() />
		<cfelse>
			<cfset LOCAL.productId = getProductAttributeRela().getProduct().getProductId() />
		</cfif>
		
		<cfif IsNull(getImageName()) OR Trim(getImageName()) EQ "">
			<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/site/no_image_available.png" />
		<cfelse>
			<cfset imageLink = "#APPLICATION.absoluteUrlWeb#images/uploads/product/#LOCAL.productId#/#imageType##getImageName()#" />
		</cfif>
		
		<cfreturn imageLink />
	</cffunction>
</cfcomponent>
