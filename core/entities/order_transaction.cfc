<cfcomponent extends="entity" persistent="true"> 
    <cfproperty name="orderTransactionId" column="order_transaction_id" fieldtype="id" generator="native">	
	<cfproperty name="transactionId" column="transactionId" ormtype="string"> 
	<cfproperty name="order" fieldtype="many-to-one" cfc="order" fkcolumn="order_id">	
	<cfproperty name="orderTransactionType" fieldtype="many-to-one" cfc="order_transaction_type" fkcolumn="order_transaction_type_id">	
</cfcomponent>
