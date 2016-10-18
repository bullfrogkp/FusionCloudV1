<cfcomponent persistent="true"> 
    <cfproperty name="filterValueId" column="filter_value_id" fieldtype="id" generator="native"> 
    <cfproperty name="imageName" column="image_name" ormtype="string"> 
    <cfproperty name="value" column="value" ormtype="string"> 
	<cfproperty name="categoryFilterRela" fieldtype="many-to-one" cfc="category_filter_rela" fkcolumn="category_filter_rela_id">
	
	<cffunction name="getImageLink" access="public" output="false" returnType="string">
				
		<cfset var imageLink = "" />
		<cfset LOCAL.categoryId = getCategoryFilterRela().getCategory().getCategoryId() />
		
		<cfif IsNull(getImageName()) OR Trim(getImageName()) EQ "">
			<cfset imageLink = "#APPLICATION.imagesDomain#/no_image_available.png" />
		<cfelse>
			<cfset imageLink = "#APPLICATION.imagesDomain#/category/#LOCAL.categoryId#/filters/#getImageName()#" />
		</cfif>
		
		<cfreturn imageLink />
	</cffunction>
</cfcomponent>