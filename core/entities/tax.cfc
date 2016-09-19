<cfcomponent persistent="true"> 
    <cfproperty name="taxId" column="tax_id" fieldtype="id" generator="native"> 
	<cfproperty name="rate" column="rate" ormtype="float"> 
	<cfproperty name="province" fieldtype="many-to-one" cfc="province" fkcolumn="province_id">
	<cfproperty name="taxCategory" fieldtype="many-to-one" cfc="tax_category" fkcolumn="tax_category_id">
</cfcomponent>