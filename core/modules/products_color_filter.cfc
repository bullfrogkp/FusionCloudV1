<cfcomponent extends="modules.module">	
    <cffunction name="getFrontendView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retVal = '<div class="information-blocks">
					<div class="block-title size-2">Sort by colours</div>
					<div class="color-selector detail-info-entry">
						<div style="background-color: ##cf5d5d;" class="entry active"></div>
						<div style="background-color: ##c9459f;" class="entry"></div>
						<div style="background-color: ##689dd4;" class="entry"></div>
						<div style="background-color: ##68d4aa;" class="entry"></div>
						<div style="background-color: ##a8d468;" class="entry"></div>
						<div style="background-color: ##d4c368;" class="entry"></div>
						<div style="background-color: ##c2c2c2;" class="entry"></div>
						<div style="background-color: ##000000;" class="entry"></div>
						<div style="background-color: ##f0f0f0;" class="entry"></div>
						<div class="spacer"></div>
					</div>
				</div>' />
		
		<cfreturn LOCAL.retVal />
	</cffunction>
</cfcomponent>