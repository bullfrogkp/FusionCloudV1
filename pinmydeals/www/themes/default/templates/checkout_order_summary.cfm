<cfoutput>
<div class="info-sidebar" style="margin-top:3px;">
	<strong>Order Summary</strong>
	<table style="width:100%;margin-top:13px;line-height:20px;">	
		<tr>
			<td style="font-weight:bold;width:173px;">Items(#REQUEST.pageData.shoppingCartItemTotalCount#):</td>
			<td>
				#SESSION.cart.getSubTotalPriceWCLocal()#
			</td>
		</tr>
		<tr>
			<td style="font-weight:bold;width:173px;">Tax:</td>
			<td>
				<cfif SESSION.cart.getTotalTax() NEQ 0>
					#SESSION.cart.getTotalTaxWCLocal()#
				<cfelse>
					-
				</cfif>
			</td>
		</tr>
		<tr>
			<td style="font-weight:bold;width:173px;">Shipping & Handling:</td>
			<td>
				-
			</td>
		</tr>
		<tr>
			<td style="font-weight:bold;width:173px;">Total:</td>
			<td>
				#SESSION.cart.getSubTotalPriceWCLocal()#
			</td>
		</tr>
	</table>			
</div>	
</cfoutput>