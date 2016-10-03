<cfcomponent extends="core.modules.module">	
    <cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		
		<cfset LOCAL.retStruct.left = {} />
		<cfset LOCAL.retStruct.left.name = "Woman category" />
		<cfset LOCAL.retStruct.left.description = "Lorem ipsum dolor sit amet, consectetur adipisc elit, sed do eiusmod tempor incididunt ut labore consectetur." />
		<cfset LOCAL.retStruct.left.image = "#getSessionData().absoluteUrlTheme#images/image-text-widget-2.jpg" />
		<cfset LOCAL.retStruct.left.links = [] />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.text = "Evening dresses" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.left.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.text = "Jackets and coats" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.left.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.text = "Tops and Sweatshirts" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.left.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.text = "Blouses and shirts" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.left.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.text = "Trousers and Shorts" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.left.links, LOCAL.link) />
		
		<cfset LOCAL.retStruct.right = {} />
		<cfset LOCAL.retStruct.right.name = "Man category" />
		<cfset LOCAL.retStruct.right.description = "Lorem ipsum dolor sit amet, consectetur adipisc elit, sed do eiusmod tempor incididunt ut labore consectetur." />
		<cfset LOCAL.retStruct.right.image = "#getSessionData().absoluteUrlTheme#images/image-text-widget-1.jpg" />
		<cfset LOCAL.retStruct.right.links = [] />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.text = "Evening dresses" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.right.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.text = "Jackets and coats" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.right.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.text = "Tops and Sweatshirts" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.right.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.text = "Blouses and shirts" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.right.links, LOCAL.link) />
		
		<cfset LOCAL.link = {} />
		<cfset LOCAL.link.text = "Trousers and Shorts" />
		<cfset LOCAL.link.href = "" />
		<cfset ArrayAppend(LOCAL.retStruct.right.links, LOCAL.link) />
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>