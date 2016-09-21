<cfcomponent extends="core.modules.module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.retStruct.left = {} />
		<cfset LOCAL.retStruct.left.name = "Featured products1" />
		<cfset LOCAL.retStruct.left.links = [] />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.image = "#SESSION.absoluteUrlTheme#images/product-image-inline-1.jpg" />
		<cfset LOCAL.link.text = "Ladies Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.link.previousPrice = "199,99" />
		<cfset LOCAL.link.currentPrice = "119,99" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.left.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.image = "#SESSION.absoluteUrlTheme#images/product-image-inline-1.jpg" />
		<cfset LOCAL.link.text = "Ladies Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.link.previousPrice = "199,99" />
		<cfset LOCAL.link.currentPrice = "119,99" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.left.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.image = "#SESSION.absoluteUrlTheme#images/product-image-inline-1.jpg" />
		<cfset LOCAL.link.text = "Ladies Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.link.previousPrice = "199,99" />
		<cfset LOCAL.link.currentPrice = "119,99" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.left.links, LOCAL.link) />
		
		<cfset LOCAL.retStruct.middle = {} />
		<cfset LOCAL.retStruct.middle.name = "Featured products2" />
		<cfset LOCAL.retStruct.middle.links = [] />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.image = "#SESSION.absoluteUrlTheme#images/product-image-inline-1.jpg" />
		<cfset LOCAL.link.text = "Ladies Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.link.previousPrice = "199,99" />
		<cfset LOCAL.link.currentPrice = "119,99" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.middle.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.image = "#SESSION.absoluteUrlTheme#images/product-image-inline-1.jpg" />
		<cfset LOCAL.link.text = "Ladies Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.link.previousPrice = "199,99" />
		<cfset LOCAL.link.currentPrice = "119,99" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.middle.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.image = "#SESSION.absoluteUrlTheme#images/product-image-inline-1.jpg" />
		<cfset LOCAL.link.text = "Ladies Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.link.previousPrice = "199,99" />
		<cfset LOCAL.link.currentPrice = "119,99" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.middle.links, LOCAL.link) />
		
		<cfset LOCAL.retStruct.right = {} />
		<cfset LOCAL.retStruct.right.name = "Featured products3" />
		<cfset LOCAL.retStruct.right.links = [] />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.image = "#SESSION.absoluteUrlTheme#images/product-image-inline-1.jpg" />
		<cfset LOCAL.link.text = "Ladies Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.link.previousPrice = "199,99" />
		<cfset LOCAL.link.currentPrice = "119,99" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.right.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.image = "#SESSION.absoluteUrlTheme#images/product-image-inline-1.jpg" />
		<cfset LOCAL.link.text = "Ladies Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.link.previousPrice = "199,99" />
		<cfset LOCAL.link.currentPrice = "119,99" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.right.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.image = "#SESSION.absoluteUrlTheme#images/product-image-inline-1.jpg" />
		<cfset LOCAL.link.text = "Ladies Pullover Batwing Sleeve Zigzag" />
		<cfset LOCAL.link.previousPrice = "199,99" />
		<cfset LOCAL.link.currentPrice = "119,99" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.right.links, LOCAL.link) />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>