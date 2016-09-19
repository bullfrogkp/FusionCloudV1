<cfcomponent persistent="true"> 
    <cfproperty name="groupBuyingId" column="group_buying_id" fieldtype="id" generator="native">
	<cfproperty name="rank" column="rank" ormtype="float"> 	
	<cfproperty name="product" fieldtype="many-to-one" cfc="product" fkcolumn="product_id">
</cfcomponent>