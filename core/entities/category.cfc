<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="categoryId" column="category_id" fieldtype="id" generator="native"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
    <cfproperty name="displayCategoryList" column="display_category_list" ormtype="boolean"> 
    <cfproperty name="displayCustomDesign" column="display_custom_design" ormtype="boolean"> 
    <cfproperty name="displayFilter" column="display_filter" ormtype="boolean"> 
    <cfproperty name="isSpecial" column="is_special" ormtype="boolean"> 
    <cfproperty name="showCategoryOnNavigation" column="show_category_on_navigation" ormtype="boolean"> 
	<cfproperty name="title" column="title" ormtype="string"> 
	<cfproperty name="keywords" column="keywords" ormtype="string"> 
	<cfproperty name="customDesign" column="custom_design" ormtype="text"> 
	
	<cfproperty name="parentCategory" fieldtype="many-to-one" cfc="category" fkcolumn="parent_category_id">
	
	<cfproperty name="images" type="array" fieldtype="one-to-many" cfc="category_image" fkcolumn="category_id" singularname="image" orderby="rank">
	<cfproperty name="categoryFilterRelas" type="array" fieldtype="one-to-many" cfc="category_filter_rela" fkcolumn="category_id" singularname="categoryFilterRela">
	<cfproperty name="products" fieldtype="many-to-many" cfc="product" linktable="category_product_rela" fkcolumn="category_id" inversejoincolumn="product_id">
	
	<cfproperty name="isActive" type="boolean" persistent="false"> 
	<cfproperty name="isExpanded" type="boolean" persistent="false"> 
	<cfproperty name="searchKeyword" type="string" persistent="false"> 
	<cfproperty name="subCategories" type="array" persistent="false"> 
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeAllCategoryFilterRelas" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getCategoryFilterRelas())>
			<cfset ArrayClear(getCategoryFilterRelas()) />
		</cfif>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="getDetailPageURL" access="public" output="false" returnType="string">
		<cfreturn "#APPLICATION.absoluteUrlWeb#products.cfm/#URLEncodedFormat(getDisplayName())#/#getCategoryId()#/1/1/-/-/" />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="removeCategoryFilterRelas" access="public" output="false" returnType="void">
		<cfif NOT IsNull(getCategoryFilterRelas())>
			<cfset ArrayClear(getCategoryFilterRelas()) />
		</cfif>
	</cffunction>
</cfcomponent>