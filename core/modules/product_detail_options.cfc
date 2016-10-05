<cfcomponent extends="core.modules.module">	
    <cffunction name="getData" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		
		<cfset LOCAL.retVal = "" />
		
		<cfset LOCAL.productId = ListGetAt(getCgiData().PATH_INFO,2,"/")>
		<cfset LOCAL.product = EntityLoadByPK("product",LOCAL.productId) />	
		
		<cfloop array="#LOCAL.product.getProductAttributeRelas()#" index="LOCAL.rela">
			<cfset LOCAL.attribute = rela.getAttribute() />
			
			<cfset LOCAL.retVal &= '<div class="' />
			<cfif LOCAL.attribute.getName() EQ "color">
				<cfset LOCAL.retVal &= 'color-selector' />
			<cfelse>
				<cfset LOCAL.retVal &= 'size-selector' />
			</cfif>
			<cfset LOCAL.retVal &= ' detail-info-entry"><div class="detail-info-entry-title">' & LOCAL.attribute.getDisplayName() & '</div>' />
			
			<cfloop from="1" to="#ArrayLen(LOCAL.rela.getAttributeValues())#" index="LOCAL.idx">
				<cfset LOCAL.attrValue = LOCAL.rela.getAttributeValues()[LOCAL.idx] />
				
				<cfset LOCAL.retVal &= '<div aid="#LOCAL.attribute.getAttributeId()#" avid="#LOCAL.attrValue.getAttributeValueId()#" id="attr-val-#LOCAL.attrValue.getAttributeValueId()#" class="entry attr-#LOCAL.attribute.getAttributeId()#' />
				<!---
				<cfif LOCAL.idx EQ 1>
					<cfset LOCAL.retVal &= ' active' />
				</cfif>
				--->
				<cfif LOCAL.attribute.getName() EQ "color">
					<cfset LOCAL.retVal &= '" style="background-color: ' & LOCAL.attrValue.getValue() & ';">&nbsp;</div>' />
				<cfelse>
					<cfset LOCAL.retVal &= '">' & LOCAL.attrValue.getValue() & '</div>' />
				</cfif>
			</cfloop>
			
			<cfset LOCAL.retVal &= '<div class="spacer"></div></div>' />
		</cfloop>
	
		<cfreturn LOCAL.retVal />
	</cffunction>
</cfcomponent>