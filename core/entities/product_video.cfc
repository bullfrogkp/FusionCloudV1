<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="productVideoId" column="product_video_id" fieldtype="id" generator="native"> 
    <cfproperty name="url" column="url" ormtype="string"> 
    <cfproperty name="rank" column="rank" ormtype="float"> 
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
</cfcomponent>