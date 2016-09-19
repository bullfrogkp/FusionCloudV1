<cfcomponent persistent="true"> 
    <cfproperty name="taxCategoryId" column="tax_category_id" fieldtype="id" generator="native"> 
    <cfproperty name="name" column="name" ormtype="string"> 
    <cfproperty name="displayName" column="display_name" ormtype="string"> 
    <cfproperty name="rate" column="rate" ormtype="float"> 
</cfcomponent>