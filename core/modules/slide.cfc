<cfcomponent extends="core.modules.module">	
    <cffunction name="getFrontEndData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.slideSection = '
		<div class="swiper-slide no-shadow active" data-val="0" style="background-image: url(#getSessionData().absoluteUrlTheme#images/fullwidth-1.jpg);"> 
				<div class="parallax-vertical-align">
					<div class="parallax-article left-align">
						<h2 class="subtitle">Check out this weekend</h2>
						<h1 class="title">Big sale</h1>
						<div class="description">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore.</div>
						<div class="info">
							<a href="##" class="button style-8">shop now</a>
							<a href="##" class="button style-8">features</a>
						</div>
					</div>
				</div>
			</div>
			<div class="swiper-slide no-shadow" data-val="1" style="background-image: url(#getSessionData().absoluteUrlTheme#images/fullwidth-2.jpg);"> 
				<div class="parallax-vertical-align">
					<div class="parallax-article left-align">
						<h2 class="subtitle">Check out this weekend</h2>
						<h1 class="title">Big sale</h1>
						<div class="description">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore.</div>
						<div class="info">
							<a href="##" class="button style-8">shop now</a>
							<a href="##" class="button style-8">features</a>
						</div>
					</div>
				</div>
			</div>' />
		<cfreturn LOCAL.retStruct />
	</cffunction>
	
	<cffunction name="getBackEndView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.slideSection = "<p>aaa</p>" />
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>