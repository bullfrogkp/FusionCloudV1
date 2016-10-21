<cfcomponent extends="core.modules.module">	
    <cffunction name="getData" access="public" output="false" returnType="struct">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retStruct = {} />
		<cfif StructKeyExists(getUrlData(),"id") AND IsNumeric(getUrlData().id)>
			<cfset LOCAL.retStruct.products = EntityLoad("module_admin_category_detail_advertisement", {category=EntityLoadByPK("category",getUrlData().id)})> 
			<cfset LOCAL.retStruct.javascript = "
				$(document).ready(function() {
					$('##ads_image').plupload({
						// General settings
						runtimes: 'html5,flash,silverlight,html4',
						
						url: '#APPLICATION.absoluteUrlSite#ajax/upload_ads.cfm',

						// Maximum file size
						max_file_size: '1000mb',

						// User can upload no more then 20 files in one go (sets multiple_queues to false)
						max_file_count: 20,
						
						chunk_size: '1mb',

						// Specify what files to browse for
						filters: [
							{ title: 'Image files', extensions: 'jpg,gif,png' }
						],

						// Rename files by clicking on their titles
						rename: true,
						
						// Sort files
						sortable: true,

						// Enable ability to drag'n'drop files onto the widget (currently only HTML5 supports that)
						dragdrop: true,

						// Views to activate
						views: {
							thumbs: true,
							list: false,
							active: 'thumbs'
						},

						// Flash settings
						flash_swf_url : 'http://rawgithub.com/moxiecode/moxie/master/bin/flash/Moxie.cdn.swf',

						// Silverlight settings
						silverlight_xap_url : 'http://rawgithub.com/moxiecode/moxie/master/bin/silverlight/Moxie.cdn.xap'
					});
					
					$( '.delete-ad' ).click(function() {
						$('##deleted_ad_id').val($(this).attr('adid'));
					});
				});"> 
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
		</cfif>
		
		<cfreturn LOCAL.retStruct />
	</cffunction>
</cfcomponent>