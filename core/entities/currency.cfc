<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="currencyId" column="currency_id" fieldtype="id" generator="native"> 
	<cfproperty name="isDefault" column="is_default" ormtype="boolean"> 
	<cfproperty name="code" column="code" ormtype="string"> 
	<cfproperty name="symbolText" column="symbolText" ormtype="string"> 
	<cfproperty name="locale" column="locale" ormtype="string"> 
	<cfproperty name="multiplier" column="multiplier" ormtype="float"> 
</cfcomponent>