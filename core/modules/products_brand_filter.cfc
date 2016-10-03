<cfcomponent extends="core.modules.module">	
    <cffunction name="getView" access="public" output="false" returnType="string">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retVal = '<div class="information-blocks">
					<div class="block-title size-2">Sort by brands</div>
					<div class="row">
						<div class="col-xs-6">
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Armani
							</label>
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Bershka Co
							</label>
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Nelly.com
							</label>
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Zigzag Inc
							</label>  
						</div>
						<div class="col-xs-6">
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Armani
							</label>
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Bershka Co
							</label>
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Nelly.com
							</label>
							<label class="checkbox-entry">
								<input type="checkbox" /> <span class="check"></span> Zigzag Inc
							</label> 
						</div>
					</div>
				</div>' />
		
		<cfreturn LOCAL.retVal />
	</cffunction>
</cfcomponent>