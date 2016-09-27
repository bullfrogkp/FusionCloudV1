<cfcomponent extends="core.modules.module">	
	<cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.products = [] />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.name = "Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.href = "" />
		<cfset LOCAL.product.previousPrice = 999 />
		<cfset LOCAL.product.currentPrice = 111 />
		<cfset LOCAL.product.image = "#getSessionData().absoluteUrlTheme#images/product-image-inline-1.jpg" />
		<cfset ArrayAppend(LOCAL.retStruct.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.name = "Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.href = "" />
		<cfset LOCAL.product.previousPrice = 999 />
		<cfset LOCAL.product.currentPrice = 111 />
		<cfset LOCAL.product.image = "#getSessionData().absoluteUrlTheme#images/product-image-inline-2.jpg" />
		<cfset ArrayAppend(LOCAL.retStruct.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.name = "Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.href = "" />
		<cfset LOCAL.product.previousPrice = 999 />
		<cfset LOCAL.product.currentPrice = 111 />
		<cfset LOCAL.product.image = "#getSessionData().absoluteUrlTheme#images/product-image-inline-3.jpg" />
		<cfset ArrayAppend(LOCAL.retStruct.products, LOCAL.product) />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>