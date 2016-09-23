<cfcomponent persistent="true"> 
    <cfproperty name="tagId" column="tag_id" fieldtype="id" generator="native"> 
	<cfproperty name="label" column="label" ormtype="string"> 
	<cfproperty name="productTags" type="array" fieldtype="one-to-many" cfc="product_tag_rela" fkcolumn="tag_id" singularname="productTag" cascade="delete-orphan">
	
	<!------------------------------------------------------------------------------->	
	<cffunction name="getTagPageURL" access="public" output="false" returnType="string">
		<cfreturn "#APPLICATION.absoluteUrlSite#products.cfm/#URLEncodedFormat(getLabel())#/#getTagId()#/1/1/-/-/" />
	</cffunction>
	<!------------------------------------------------------------------------------->	
</cfcomponent>
