<cfcomponent extends="core.modules.module">	
    <cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfset LOCAL.retStruct.products = EntityLoad("module_admin_category_detail_advertisement", {category=EntityLoadByPK("category",getUrlData().id)})> 
		<cfset LOCAL.retStruct.javascript = "ok"> 
		<cfset LOCAL.retStruct.tab_title = "hahaha"> 
		<cfset LOCAL.retStruct.tab_view = '<div class="form-group"><div class="row">' />
							
		<cfif NOT IsNull(LOCAL.retStruct.products)>
			<cfloop array="#LOCAL.retStruct.products#" index="ad">			
				<cfset LOCAL.retStruct.tab_view &= '
					<div class="col-xs-2">
						<div class="box box-warning">
							<div class="box-body table-responsive no-padding">
								<table class="table table-hover">
									<tr class="warning">
										<th style="font-size:11px;line-height:20px;">
											<input type="text" placeholder="Rank" name="advertisement_rank_#ad.getPageSectionAdvertisementId()#" value="#ad.getRank()#" style="width:40px;text-align:center;" />
										</th>
										<th><a adid="#ad.getPageSectionAdvertisementId()#" href="" class="delete-ad pull-right" data-toggle="modal" data-target="##delete-ad-modal"><span class="label label-danger">Delete</span></a></th>
									</tr>
									<tr>
										<td colspan="2">
											<img class="img-responsive" src="#ad.getImageLink(type = "small")#" />
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<input type="text" placeholder="Link" name="advertisement_link_#ad.getPageSectionAdvertisementId()#" value="#ad.getLink()#" style="width:100%;padding-left:5px;"/>
										</td>
									</tr>
								</table>
							</div><!-- /.box-body -->
						</div><!-- /.box -->
					</div>' />
			</cfloop>
		</cfif>
		<cfset LOCAL.retStruct.tab_view &= '</div>
			<div class="form-group">
				<div id="ads_image">
					<p>Your browser doesn not have Flash, Silverlight or HTML5 support.</p>
				</div>
			</div>
		</div>'> 
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>