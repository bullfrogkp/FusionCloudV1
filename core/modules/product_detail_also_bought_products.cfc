<cfcomponent extends="core.modules.module">	
	<cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.products = [] />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.name = "Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men Clothing" />
		<cfset LOCAL.product.categoryHref = "" />
		<cfset LOCAL.product.href = "" />
		<cfset LOCAL.product.stars = 4 />
		<cfset LOCAL.product.previousPrice = 999 />
		<cfset LOCAL.product.currentPrice = 111 />
		<cfset LOCAL.product.image1 = "#getSessionData().absoluteUrlTheme#images/product-minimal-1.jpg" />
		<cfset LOCAL.product.image2 = "#getSessionData().absoluteUrlTheme#images/product-minimal-11.jpg" />
		<cfset ArrayAppend(LOCAL.retStruct.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.name = "Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men Clothing" />
		<cfset LOCAL.product.categoryHref = "" />
		<cfset LOCAL.product.href = "" />
		<cfset LOCAL.product.stars = 4 />
		<cfset LOCAL.product.previousPrice = 999 />
		<cfset LOCAL.product.currentPrice = 111 />
		<cfset LOCAL.product.image1 = "#getSessionData().absoluteUrlTheme#images/product-minimal-1.jpg" />
		<cfset LOCAL.product.image2 = "#getSessionData().absoluteUrlTheme#images/product-minimal-11.jpg" />
		<cfset ArrayAppend(LOCAL.retStruct.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.name = "Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men Clothing" />
		<cfset LOCAL.product.categoryHref = "" />
		<cfset LOCAL.product.href = "" />
		<cfset LOCAL.product.stars = 4 />
		<cfset LOCAL.product.previousPrice = 999 />
		<cfset LOCAL.product.currentPrice = 111 />
		<cfset LOCAL.product.image1 = "#getSessionData().absoluteUrlTheme#images/product-minimal-1.jpg" />
		<cfset LOCAL.product.image2 = "#getSessionData().absoluteUrlTheme#images/product-minimal-11.jpg" />
		<cfset ArrayAppend(LOCAL.retStruct.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.name = "Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men Clothing" />
		<cfset LOCAL.product.categoryHref = "" />
		<cfset LOCAL.product.href = "" />
		<cfset LOCAL.product.stars = 4 />
		<cfset LOCAL.product.previousPrice = 999 />
		<cfset LOCAL.product.currentPrice = 111 />
		<cfset LOCAL.product.image1 = "#getSessionData().absoluteUrlTheme#images/product-minimal-1.jpg" />
		<cfset LOCAL.product.image2 = "#getSessionData().absoluteUrlTheme#images/product-minimal-11.jpg" />
		<cfset ArrayAppend(LOCAL.retStruct.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.name = "Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men Clothing" />
		<cfset LOCAL.product.categoryHref = "" />
		<cfset LOCAL.product.href = "" />
		<cfset LOCAL.product.stars = 4 />
		<cfset LOCAL.product.previousPrice = 999 />
		<cfset LOCAL.product.currentPrice = 111 />
		<cfset LOCAL.product.image1 = "#getSessionData().absoluteUrlTheme#images/product-minimal-1.jpg" />
		<cfset LOCAL.product.image2 = "#getSessionData().absoluteUrlTheme#images/product-minimal-11.jpg" />
		<cfset ArrayAppend(LOCAL.retStruct.products, LOCAL.product) />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>