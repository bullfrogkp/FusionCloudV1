
<cfcomponent
	output="false"
	hint="Image utility functions that abstract out complex ColdFusion image manipulation processes.">
	
	
	<cffunction
		name="Init"
		access="public"
		returntype="any"
		output="false"
		hint="Returns an initialized component.">
		
		<!--- Return This reference. --->
		<cfreturn THIS />
	</cffunction>
	

	<!---
		Function: aspectCrop
		Author: Emmet McGovern
		http://www.illequipped.com/blog
		emmet@fullcitymedia.com
		2/29/2008 - Leap Day!
	--->
	<cffunction name="aspectCrop" access="public" returntype="any" output="false" hint="">
		
		<!--- Define arguments. --->
		<cfargument name="image" type="any" required="true" hint="The ColdFusion image object or path to an image file." />
		<cfargument name="cropwidth" type="numeric" required="true" hint="The pixel width of the final cropped image" />
		<cfargument name="cropheight" type="numeric" required="true" hint="The pixel height of the final cropped image" />
		<cfargument name="position" type="string" required="true" default="center" hint="The y origin of the crop area." />
		
		<!--- Define local variables. --->
		<cfset var nPercent = "" />
		<cfset var wPercent = "" />
		<cfset var hPercent = "" />
		<cfset var px = "" />
		<cfset var ycrop = "" />
		<cfset var xcrop = "" />

		<!--- If not image, assume path. --->
		<cfif (
			(NOT isImage(arguments.image)) AND
			(NOT isImageFile(arguments.image))
			)>
			<cfthrow message="The value passed to aspectCrop was not an image." />
		</cfif>
		
		<!--- If we were given a path to an image, read the image into a ColdFusion image object. --->
		<cfif isImageFile(arguments.image)>
			<cfset arguments.image = imageRead(arguments.image) />
		</cfif>

		<!--- Resize image without going over crop dimensions--->
		<cfset wPercent = arguments.cropwidth / arguments.image.width>
		<cfset hPercent = arguments.cropheight / arguments.image.height>
		
		<cfif  wPercent gt hPercent>
			<cfset nPercent = wPercent>
    		<cfset px = arguments.image.width * nPercent + 1>
			<cfset ycrop = ((arguments.image.height - arguments.cropheight)/2)>
			<cfset imageResize(arguments.image,px,"") />
		<cfelse>
    		<cfset nPercent = hPercent>
    		<cfset px = arguments.image.height * nPercent + 1>
			<cfset xcrop = ((arguments.image.width - arguments.cropwidth)/2)>
			<cfset imageResize(arguments.image,"",px) />
		</cfif>

		<!--- Set the xy offset for cropping, if not provided defaults to center --->
		<cfif listfindnocase("topleft,left,bottomleft", arguments.position)>
			<cfset xcrop = 0>
		<cfelseif listfindnocase("topcenter,center,bottomcenter", arguments.position)>
			<cfset xcrop = (arguments.image.width - arguments.cropwidth)/2>
		<cfelseif listfindnocase("topright,right,bottomright", arguments.position)>
			<cfset xcrop = arguments.image.width - arguments.cropwidth>
		<cfelse>
			<cfset xcrop = (arguments.image.width - arguments.cropwidth)/2>
		</cfif>
		
		<cfif listfindnocase("topleft,topcenter,topright", arguments.position)>
			<cfset ycrop = 0>
		<cfelseif listfindnocase("left,center,right", arguments.position)>
			<cfset ycrop = (arguments.image.height - arguments.cropheight)/2>
		<cfelseif listfindnocase("bottomleft,bottomcenter,bottomright", arguments.position)>
			<cfset ycrop = arguments.image.height - arguments.cropheight>
		<cfelse>
			<cfset ycrop = (arguments.image.height - arguments.cropheight)/2>	
		</cfif>	

		<!--- Return new cropped image. --->
		<cfset ImageCrop(arguments.image,xcrop,ycrop,arguments.cropwidth,arguments.cropheight)>
		
		<cfreturn arguments.image>
	</cffunction>
</cfcomponent>