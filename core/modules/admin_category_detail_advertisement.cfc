<cfcomponent extends="core.modules.module">	
	<!------------------------------------------------------------------------------->
    <cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfif StructKeyExists(getUrlData(),"id") AND IsNumeric(getUrlData().id)>
			<cfset LOCAL.retStruct.ads = EntityLoad("module_admin_category_detail_advertisement", {category = EntityLoadByPK("category",getUrlData().id)})> 
			<cfset LOCAL.retStruct.tab_title = "Advertisement"> 
			<cfset LOCAL.retStruct.tab_content = '<div class="form-group"><div class="row">' />
								
			<cfif NOT IsNull(LOCAL.retStruct.ads)>
				<cfloop array="#LOCAL.retStruct.ads#" index="ad">			
					<cfset LOCAL.retStruct.tab_content &= '
						<div class="col-xs-2">
							<div class="box box-warning">
								<div class="box-body table-responsive no-padding">
									<table class="table table-hover">
										<tr class="warning">
											<th style="font-size:11px;line-height:20px;">
												<input type="text" placeholder="Rank" name="advertisement_rank_#ad.getId()#" value="#ad.getRank()#" style="width:40px;text-align:center;" />
											</th>
											<th><a adid="#ad.getId()#" href="" class="delete-ad pull-right" data-toggle="modal" data-target="##delete-ad-modal"><span class="label label-danger">Delete</span></a></th>
										</tr>
										<tr>
											<td colspan="2">
												<img class="img-responsive" src="#ad.getImageLink()#" />
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<input type="text" placeholder="Link" name="advertisement_link_#ad.getId()#" value="#ad.getLink()#" style="width:100%;padding-left:5px;"/>
											</td>
										</tr>
									</table>
								</div><!-- /.box-body -->
							</div><!-- /.box -->
						</div>' />
				</cfloop>
			</cfif>
			<cfset LOCAL.retStruct.tab_content &= '</div>
				<div class="form-group">
					<div id="ads_image">
						<p>Your browser doesn not have Flash, Silverlight or HTML5 support.</p>
					</div>
				</div>
			</div>'> 
		</cfif>
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->	
	<cffunction name="processFormData" access="remote" output="false" returnType="struct" returnformat="json">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.isValid = true />
		<cfset LOCAL.retStruct.messageArray = [] />
		
		<cfif StructKeyExists(FORM,"save_item")>
			<cfset LOCAL.ads = EntityLoad("module_admin_category_detail_advertisement", {category = EntityLoadByPK("category",getId())})> 
			<cfif NOT IsNull(LOCAL.ads)>
				<cfloop array="#LOCAL.products#" index="LOCAL.ad">
					<cfif IsNumeric(FORM["advertisement_rank_#LOCAL.ad.getId()#"])>
						<cfset LOCAL.ad.setRank(FORM["advertisement_rank_#LOCAL.ad.getId()#"]) />
						<cfset EntitySave(LOCAL.ad) />
					</cfif>
					<cfif Trim(FORM["advertisement_link_#LOCAL.ad.getId()#"]) NEQ "">
						<cfset LOCAL.ad.setLink(FORM["advertisement_link_#LOCAL.ad.getId()#"]) />
						<cfset EntitySave(LOCAL.ad) />
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif FORM["ads_image_count"] NEQ 0>
				<cfloop collection="#FORM#" item="LOCAL.key">
					<cfif Find("ADS_IMAGE_",LOCAL.key) AND Find("_STATUS",LOCAL.key)>
						<cfset LOCAL.currentIndex = Replace(Replace(LOCAL.key,"ADS_IMAGE_",""),"_STATUS","") />
						<cfif StructFind(FORM,LOCAL.key) EQ "done">
							<cfset LOCAL.imgName = StructFind(FORM,"ADS_IMAGE_#LOCAL.currentIndex#_NAME") />
							<cfset LOCAL.newAdvertisement = EntityNew("module_admin_category_detail_advertisement") />
							<cfset LOCAL.newAdvertisement.setImageName(LOCAL.imgName) />
							<cfset LOCAL.newAdvertisement.setCategory(LOCAL.category) />
							<cfset EntitySave(LOCAL.newAdvertisement) />
						</cfif>
					</cfif>
				</cfloop>
			</cfif>
		<cfelseif StructKeyExists(FORM,"delete_ad")>
			
			<cfset LOCAL.ad = EntityLoadByPK("page_section_advertisement",FORM.deleted_ad_id) />			
			<cfset LOCAL.advertisementSection.removeAdvertisement(LOCAL.ad) />
			<cfset EntitySave(LOCAL.advertisementSection) />
			
			<cfset ArrayAppend(SESSION.temp.message.messageArray,"Advertise image has been deleted.") />
			<cfset LOCAL.redirectUrl = "#APPLICATION.urlHttpsAdmin##getPageName()#.cfm?id=#LOCAL.category.getCategoryId()#&active_tab_id=tab_7" />
		</cfif>
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
	<!------------------------------------------------------------------------------->
</cfcomponent>