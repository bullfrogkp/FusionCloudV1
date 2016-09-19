<cfcomponent output="false">
	<!--------------------------------------------------------------------------------------------------------------->	
	<cffunction name="init" access="public" returntype="any" output="false">
	    <cfreturn this />
	</cffunction>
	<!--------------------------------------------------------------------------------------------------------------->	
	<!--------------------------------------------------------------------------------------------------------------->	
	<cffunction name="updateDetailPageCache" access="public" returntype="void">
	    <cfargument name="item_id" type="numeric" required="true">
		
		<cfset var LOCAL = StructNew() />
		
		<!--- may cause racing condition, not in var scope --->
		<cfset current_item_id = ARGUMENTS.item_id />
		
		<cfinvoke component="#APPLICATION.component_path_db#items" method="getItem" returnvariable="LOCAL.item_detail">
			<cfinvokeargument name="item_id" value="#current_item_id#">
		</cfinvoke>
		
		<cfinvoke component="#APPLICATION.component_path_db#categories" method="getCategories" returnvariable="LOCAL.category_detail">
			<cfinvokeargument name="category_id" value="#LOCAL.item_detail.category_id#">
		</cfinvoke>
		
		<cfset current_listing_image_name = LOCAL.item_detail.listing_image_name />
		<cfset current_listing_image_extension = LOCAL.item_detail.listing_image_extension />
		<cfset current_name_display = LOCAL.item_detail.name_display />
		<cfset current_category_id = LOCAL.category_detail.category_id />
		<cfset current_category_name = LOCAL.category_detail.category_name />
		<cfset current_category_name_display = LOCAL.category_detail.category_name_display />
			
		<cfset current_description = LOCAL.item_detail.description />
		
		<cfinvoke component="#APPLICATION.component_path_db#items" method="getRelatedItems" returnvariable="related_items">
			<cfinvokeargument name="item_id" value="#ARGUMENTS.item_id#">
			<cfinvokeargument name="amount" value="8">
		</cfinvoke>	
		
		<cfset var include_category_template = APPLICATION.pageSupport
								.includeTemplate(	cache_file_path = APPLICATION.cache_system_path & "sidebar/index.html"
												,	cache_templatePath = "cache/sidebar/index.html"
												,	template_name = "include_category.cfm") />
												
		<cfsavecontent variable="LOCAL.page_content">
			<cfinclude template="./../cfm/include_item_detail.cfm" />
		</cfsavecontent>
		
		<cfset LOCAL.file_path = APPLICATION.cache_system_path & "items/item_#ARGUMENTS.item_id#.html" />
		
		<cflock timeout = "30"
				scope = "Application"
				throwOnTimeout = "yes"
				type = "Exclusive">
			
			<cfscript>
			  // where are we writing to and what are we writing
			  writeFile = LCase(LOCAL.file_path);
			  writeData = LOCAL.page_content;
			  // create the file stream
			  jFile = createobject("java", "java.io.File").init(writeFile);
			  jStream = createobject("java",
									 "java.io.FileOutputStream").init(jFile);
			  // output the UTF-8 BOM byte by byte directly to the stream
			  jStream.write(239); // 0xEF
			  jStream.write(187); // 0xBB
			  jStream.write(191); // 0xBF
			  // create the UTF-8 file writer and write the file contents
			  jWriter = createobject("java", "java.io.OutputStreamWriter");
			  jWriter.init(jStream, "UTF-8");
			  jWriter.write(writeData);
			  // flush the output, clean up and close
			  jWriter.flush();
			  jWriter.close();
			  jStream.close();
			</cfscript>
		</cflock>
		
	</cffunction>
	<!--------------------------------------------------------------------------------------------------------------->	
	<!--------------------------------------------------------------------------------------------------------------->	
	<cffunction name="updateCategoryPageCache" access="public" returntype="void">
		
		<cfset var LOCAL = StructNew() />
		
		<cfsavecontent variable="LOCAL.page_content">
			<cfinclude template="./../cfm/include_category.cfm" />
		</cfsavecontent>
		
		<cfset LOCAL.file_path = APPLICATION.cache_system_path & "sidebar/index.html" />
		
		<cflock timeout = "30"
				scope = "Application"
				throwOnTimeout = "yes"
				type = "Exclusive">
				
			<cfscript>
			  // where are we writing to and what are we writing
			  writeFile = LCase(LOCAL.file_path);
			  writeData = LOCAL.page_content;
			  // create the file stream
			  jFile = createobject("java", "java.io.File").init(writeFile);
			  jStream = createobject("java","java.io.FileOutputStream").init(jFile);
			  // output the UTF-8 BOM byte by byte directly to the stream
			  jStream.write(239); // 0xEF
			  jStream.write(187); // 0xBB
			  jStream.write(191); // 0xBF
			  // create the UTF-8 file writer and write the file contents
			  jWriter = createobject("java", "java.io.OutputStreamWriter");
			  jWriter.init(jStream, "UTF-8");
			  jWriter.write(writeData);
			  // flush the output, clean up and close
			  jWriter.flush();
			  jWriter.close();
			  jStream.close();
			</cfscript>
			
			
		</cflock>
	</cffunction>
	<!--------------------------------------------------------------------------------------------------------------->	
	<!--------------------------------------------------------------------------------------------------------------->	
	<cffunction name="updateIndexPageCache" access="public" returntype="void">
		
		<cfset var LOCAL = StructNew() />
		
		<cfsavecontent variable="LOCAL.page_content">
			<cfinclude template="./../cfm/include_index_images.cfm" />
		</cfsavecontent>
		
		<cfset LOCAL.file_path = APPLICATION.cache_system_path & "index_images.html" />
		
		<cflock timeout = "30"
				scope = "Application"
				throwOnTimeout = "yes"
				type = "Exclusive">
			
			<cfscript>
			  // where are we writing to and what are we writing
			  writeFile = LCase(LOCAL.file_path);
			  writeData = LOCAL.page_content;
			  // create the file stream
			  jFile = createobject("java", "java.io.File").init(writeFile);
			  jStream = createobject("java","java.io.FileOutputStream").init(jFile);
			  // output the UTF-8 BOM byte by byte directly to the stream
			  jStream.write(239); // 0xEF
			  jStream.write(187); // 0xBB
			  jStream.write(191); // 0xBF
			  // create the UTF-8 file writer and write the file contents
			  jWriter = createobject("java", "java.io.OutputStreamWriter");
			  jWriter.init(jStream, "UTF-8");
			  jWriter.write(writeData);
			  // flush the output, clean up and close
			  jWriter.flush();
			  jWriter.close();
			  jStream.close();
			</cfscript>
		</cflock>
	</cffunction>
	<!--------------------------------------------------------------------------------------------------------------->	
	<!--------------------------------------------------------------------------------------------------------------->	
	<cffunction name="updateFeaturedItemsPageCache" access="public" returntype="void">
		
		<cfset var LOCAL = StructNew() />
		
		<cfsavecontent variable="LOCAL.page_content">
			<cfinclude template="./../cfm/include_featured_items.cfm" />
		</cfsavecontent>
		
		<cfset LOCAL.file_path = APPLICATION.cache_system_path & "index_featured_items.html" />
		
		<cflock timeout = "30"
				scope = "Application"
				throwOnTimeout = "yes"
				type = "Exclusive">
			
			<cfscript>
			  // where are we writing to and what are we writing
			  writeFile = LCase(LOCAL.file_path);
			  writeData = LOCAL.page_content;
			  // create the file stream
			  jFile = createobject("java", "java.io.File").init(writeFile);
			  jStream = createobject("java","java.io.FileOutputStream").init(jFile);
			  // output the UTF-8 BOM byte by byte directly to the stream
			  jStream.write(239); // 0xEF
			  jStream.write(187); // 0xBB
			  jStream.write(191); // 0xBF
			  // create the UTF-8 file writer and write the file contents
			  jWriter = createobject("java", "java.io.OutputStreamWriter");
			  jWriter.init(jStream, "UTF-8");
			  jWriter.write(writeData);
			  // flush the output, clean up and close
			  jWriter.flush();
			  jWriter.close();
			  jStream.close();
			</cfscript>
		</cflock>
	</cffunction>
	<!--------------------------------------------------------------------------------------------------------------->	
	<!--------------------------------------------------------------------------------------------------------------->	
	<cffunction name="includeTemplate" returntype="string" access="public" output="false">
		<cfargument name="cache_file_path" type="string" required="true">
		<cfargument name="cache_templatePath" type="string" required="true">
		<cfargument name="template_name" type="string" required="true">
		
		<cfset var loc = {} />
		
		<cfif APPLICATION.enable_cache EQ TRUE AND FileExists(ARGUMENTS.cache_file_path)>
			<cfset loc.include_template = ARGUMENTS.cache_templatePath />
		<cfelse>
			<!---
			<cfif APPLICATION.enable_cache EQ TRUE>
				<cfset APPLICATION.utilsSupport.createAnonymousConv(subject = "page not cached",
																	content = "page not cached: #ARGUMENTS.cache_file_path#") />
			</cfif>
			--->
			<cfset loc.include_template = ARGUMENTS.template_name />
		</cfif>
		
		<cfreturn loc.include_template />
	</cffunction>
</cfcomponent>