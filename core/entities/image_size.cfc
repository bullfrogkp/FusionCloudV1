<cfcomponent persistent="true"> 
    <cfproperty name="imageSizeId" column="image_size_id" fieldtype="id" generator="native"> 
	<cfproperty name="width" column="width" ormtype="integer"> 
	<cfproperty name="height" column="height" ormtype="integer">
</cfcomponent>
