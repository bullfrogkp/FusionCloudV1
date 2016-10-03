<cfcomponent extends="core.modules.module">	
    <cffunction name="getView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retVal = '<div class="information-blocks">
					<div class="block-title size-2">Sort by sizes</div>
					<div class="size-selector">
						<div class="entry active">xs</div>
						<div class="entry">s</div>
						<div class="entry">m</div>
						<div class="entry">l</div>
						<div class="entry">xl</div>
						<div class="spacer"></div>
					</div>
				</div>' />
		
		<cfreturn LOCAL.retVal />
	</cffunction>
</cfcomponent>