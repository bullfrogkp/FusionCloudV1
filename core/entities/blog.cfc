<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="blogId" column="blog_id" fieldtype="id" generator="native"> 
	<cfproperty name="subject" column="subject" ormtype="string"> 
	<cfproperty name="content" column="content" ormtype="text">
	
	<cfproperty name="blogCategory" fieldtype="many-to-one" cfc="blog_category" fkcolumn="blog_category_id">
</cfcomponent>