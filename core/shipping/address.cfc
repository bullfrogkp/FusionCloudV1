<cfcomponent output="false" accessors="true">
	<!------------------------------------------------------------------------------->
	<cffunction name="isValidAddress" access="public" returntype="boolean">
		<cfargument name="address" type="struct" required="true">
		
		<cfset var LOCAL = {} />
		<cfset LOCAL.siteInfo = EntityLoad("site_info",{},true) /> 
		<cfset LOCAL.xmlData = _createShippingRateXml(	fromAddress = LOCAL.siteInfo.getAddress()
													,	toAddress = ARGUMENTS.address)>										
										
		<cfset LOCAL.response = _submitXml(xmlData = LOCAL.xmlData, submitUrl = APPLICATION.ups.rate_url)>		
		<cfset LOCAL.responseXml = XmlParse(LOCAL.response.Filecontent)>

		<cfif LOCAL.responseXml["RatingServiceSelectionResponse"]["Response"]["ResponseStatusCode"].XmlText EQ 1>
			<cfset LOCAL.addressIsValid = true />
		<cfelse>
			<cfset LOCAL.addressIsValid = false />
		</cfif>
		
		<cfreturn LOCAL.addressIsValid />
	</cffunction>	
	<!------------------------------------------------------------------------------->
	<cffunction name="_submitXml" displayname="Submit XML" description="Submits XML documents to UPS to get the response data" access="private" output="false" returntype="any">
		<cfargument name="submitUrl" type="string" required="true">
		<cfargument name="xmlData" type="string" required="true">
				
		<cfhttp url="#ARGUMENTS.submitUrl#" method="post" result="LOCAL.response">
			<cfhttpparam type="xml" value="#ARGUMENTS.xmlData#">
		</cfhttp>
		
		<cfreturn LOCAL.response>
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="_createShippingRateXml" displayname="Create XML Documents" description="Creates the XML needed to send to UPS" access="private" output="false" returntype="Any">
		<cfargument name="fromAddress" type="struct" required="true">
		<cfargument name="toAddress" type="struct" required="true">
		
		<cfset var LOCAL = {} />
		
		<cfxml variable="LOCAL.xmlShippingRequest" casesensitive="true">
			<cfoutput>
			<RatingServiceSelectionRequest>
				<Request>
					<RequestAction>Rate</RequestAction>
					<RequestOption>Shop</RequestOption>
				</Request>
				<Shipment>
					<Shipper>
						<Address>
							<AddressLine1>#ARGUMENTS.fromAddress.street#</AddressLine1>
							<City>#ARGUMENTS.fromAddress.city#</City>
							<StateProvinceCode>#ARGUMENTS.fromAddress.provinceCode#</StateProvinceCode>
							<PostalCode>#ARGUMENTS.fromAddress.postalCode#</PostalCode>
							<CountryCode>#ARGUMENTS.fromAddress.countryCode#</CountryCode>
						</Address>
					</Shipper>
					<ShipTo>
						<Address>
							<AddressLine1>#ARGUMENTS.toAddress.street#</AddressLine1>
							<City>#ARGUMENTS.toAddress.city#</City>
							<StateProvinceCode>#ARGUMENTS.toAddress.provinceCode#</StateProvinceCode>
							<PostalCode>#ARGUMENTS.toAddress.postalCode#</PostalCode>
							<CountryCode>#ARGUMENTS.toAddress.countryCode#</CountryCode>
						</Address>
					</ShipTo>												
					<Package>
						<PackagingType>
							<Code>02</Code>
							<Description>Package</Description>
						</PackagingType>
						<PackageWeight>
							<UnitOfMeasurement>
								<Code>LBS</Code>
							</UnitOfMeasurement>
							<Weight>1</Weight>
						</PackageWeight>
					</Package>
					<ShipmentServiceOptions/>
				</Shipment>
			</RatingServiceSelectionRequest>
			</cfoutput>
		</cfxml>

		<cfsavecontent variable="LOCAL.xmlShippingData">
			<?xml version="1.0"?>
			<AccessRequest xml:lang="en-US">
				<cfoutput>
					<AccessLicenseNumber>#xmlFormat(APPLICATION.ups.accesskey)#</AccessLicenseNumber>
					<UserId>#xmlFormat(APPLICATION.ups.upsuserid)#</UserId>
					<Password>#xmlFormat(APPLICATION.ups.upspassword)#</Password>
				</cfoutput>
			</AccessRequest>
			<cfoutput>#LOCAL.xmlShippingRequest#</cfoutput>
		</cfsavecontent>	
		<cfreturn LOCAL.xmlShippingData>
	</cffunction>
	<!------------------------------------------------------------------------------->
</cfcomponent>