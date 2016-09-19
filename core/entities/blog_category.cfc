<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="blogCategoryId" column="blog_category_id" fieldtype="id" generator="native"> 
	<cfproperty name="blogs" type="array" fieldtype="one-to-many" cfc="blog" fkcolumn="blog_category_id" singularname="blog">
</cfcomponent>