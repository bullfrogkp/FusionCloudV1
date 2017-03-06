<cfcomponent persistent="true"> 
    <cfproperty name="id" column="id" fieldtype="id" generator="native"> 
	<cfproperty name="rank" column="rank" ormtype="integer"> 
	<cfproperty name="link" column="link" ormtype="string"> 
	<cfproperty name="imageName" column="image_name" ormtype="string"> 
	<cfproperty name="category" fieldtype="many-to-one" cfc="category" fkcolumn="category_id">
</cfcomponent>