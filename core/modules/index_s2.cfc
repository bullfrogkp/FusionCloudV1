<cfcomponent extends="core.modules.module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.tabs = [] />
		
		<!--- tab 1 --->
		<cfset LOCAL.tab = {} />
		<cfset LOCAL.tab.name = "Featured Products" />
		<cfset LOCAL.tab.products = [] />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 1 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 2 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 3 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 4 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 5 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset ArrayAppend(LOCAL.retStruct.tabs, LOCAL.tab) />
		
		<!--- tab 2 --->
		<cfset LOCAL.tab = {} />
		<cfset LOCAL.tab.name = "Popular Products" />
		<cfset LOCAL.tab.products = [] />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 6 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 7 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 8 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 9 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 10 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset ArrayAppend(LOCAL.retStruct.tabs, LOCAL.tab) />
		
		<!--- tab 3 --->
		<cfset LOCAL.tab = {} />
		<cfset LOCAL.tab.name = "New Arrivals" />
		<cfset LOCAL.tab.products = [] />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 11 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 12 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 13 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 14 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset LOCAL.product = {} />
		<cfset LOCAL.product.id = 15 />
		<cfset LOCAL.product.image1 = "#SESSION.absoluteUrlTheme#images/product-minimal-2.jpg" />
		<cfset LOCAL.product.image2 = "#SESSION.absoluteUrlTheme#images/product-minimal-12.jpg" />
		<cfset LOCAL.product.name = "Blue Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.product.categoryName = "Men clothing" />
		<cfset LOCAL.product.previousPrice = "199,99" />
		<cfset LOCAL.product.currentPrice = "119,99" />
		<cfset LOCAL.product.stars = 5 />
		<cfset ArrayAppend(LOCAL.tab.products, LOCAL.product) />
		
		<cfset ArrayAppend(LOCAL.retStruct.tabs, LOCAL.tab) />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>