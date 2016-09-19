<cfoutput>
<div id="all-categories">
	<ul>
		<li>
			<span id="all-category-text">All Categories</span>
			<img src="#SESSION.absoluteUrlTheme#images/arrow_down.png" style="float:right;margin-right:10px;margin-top:-5px;width:28px;" />
			<div id="sidenav">
				<ul>
					<cfloop from="1" to="#ArrayLen(REQUEST.pageData.categoryTree)#" index="i">
						<cfset cat = REQUEST.pageData.categoryTree[i] />
						<li class="<cfif ArrayLen(cat.getSubCategories()) NEQ 0>has-sub-menu</cfif> first-level-menu" style="<cfif i EQ 1>margin-top:6px;</cfif><cfif i EQ ArrayLen(REQUEST.pageData.categoryTree)>margin-bottom:6px;</cfif>">
							<a href="#cat.getDetailPageURL()#">#cat.getDisplayName()#</a>
							<cfif ArrayLen(cat.getSubCategories()) NEQ 0>
								<div class="cat-submenu">
									<div style="z-index:1;position: relative;">
										<cfloop array="#cat.getSubCategories()#" index="subCat">
											<dl>
												<div class="clear"></div>
												<dt><a href="#subCat.getDetailPageURL()#">#subCat.getDisplayName()#</a></dt>
												<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
													<dd><a href="#thirdCat.getDetailPageURL()#">#thirdCat.getDisplayName()#</a></dd>
												</cfloop>
											</dl>
										</cfloop>
										<div class="clear"></div>
									</div>
								</div>
							</cfif>
						</li>
					</cfloop>
				</ul>
			</div>
		</li>
	</ul>
</div>
</cfoutput>