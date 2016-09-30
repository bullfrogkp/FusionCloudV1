<cfoutput>

<script>
	$(document).ready(function() {		
		$( ".delete-product" ).click(function() {
			$("##product_id").val($(this).attr('productid'));
		});
		
		$("##search-product").click(function() {
			$.ajax({
						type: "get",
						url: "#APPLICATION.absoluteUrlSite#core/services/productService.cfc",
						dataType: 'json',
						data: {
							method: 'searchProducts',
							productGroupId: $("##search-product-group-id").val(),
							categoryId: $("##search-category-id").val(),
							keywords: $("##search-keywords").val()
						},		
						success: function(response) {
							var productArray = response.DATA;
							var productName = '';
							var productId = '';
							
							$("##products-searched").empty();
							for (var i = 0, len = productArray.length; i < len; i++) {
								productName = productArray[i][0];
								productId = productArray[i][1];
								
								$("##products-searched").append('<option value="' + productId + '">' + productName + '</option>');
							}
						}
			});
		});
		
		$('##save-item').click(function() {  
			selectBox = document.getElementById("products-selected");

			for (var i = 0; i < selectBox.options.length; i++) 
			{ 
				 selectBox.options[i].selected = true; 
			} 
		}); 
		
		$('##add-all').click(function() {  
			$("##products-searched").each(function() {
				$('##products-searched option').remove().appendTo('##products-selected'); 
			});
		});  
		
		$('##remove-all').click(function() {  
			$("##products-selected").each(function() {
				$('##products-selected option').remove().appendTo('##products-searched'); 
			});  
		}); 

		$('##add').click(function() {  
			return !$('##products-searched option:selected').remove().appendTo('##products-selected').removeAttr("selected"); 
		});  
		
		$('##remove').click(function() {  
			return !$('##products-selected option:selected').remove().appendTo('##products-searched').removeAttr("selected"); 
		});		
	});
</script>
<section class="content-header">
	<h1>
		Product Group Detail
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Product Group Detail</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.formData.id#" />
<input type="hidden" name="product_id" id="product_id" value="" />
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<cfif IsDefined("REQUEST.pageData.message") AND NOT StructIsEmpty(REQUEST.pageData.message)>
				<div class="alert #REQUEST.pageData.message.messageType# alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					<cfloop array="#REQUEST.pageData.message.messageArray#" index="msg">
					#msg#<br/>
					</cfloop>
				</div>
			</cfif>
		</div>
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-body">
					<div class="form-group">
						<label>Product Group Name</label>&nbsp;&nbsp;(required)
						<input name="display_name" type="text" class="form-control" placeholder="Enter ..." value="#REQUEST.pageData.formData.display_name#"/>
					</div>
					<div class="row">
						<div class="col-xs-3" style="padding-right:0;">
							<select name="search_product_group_id" id="search-product-group-id" class="form-control">
								<option value="0">Choose Product Group ...</option>
								<cfloop array="#REQUEST.pageData.productGroups#" index="group">
									<option value="#group.getProductGroupId()#">#group.getDisplayName()#</option>
								</cfloop>
							</select>
						</div>
						<div class="col-xs-4" style="padding-right:0;">
							<select class="form-control" name="search_category_id" id="search-category-id">
								<option value="0">Choose Category ...</option>
								<cfloop array="#REQUEST.pageData.categoryTree#" index="cat">
									<option value="#cat.getCategoryId()#"
									<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),cat)>
									selected
									</cfif>
									>#RepeatString("&nbsp;",1)##cat.getDisplayName()#</option>
									<cfloop array="#cat.getSubCategories()#" index="subCat">
										<option value="#subCat.getCategoryId()#"
										<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),subCat)>
										selected
										</cfif>
										>#RepeatString("&nbsp;",11)##subCat.getDisplayName()#</option>
										<cfloop array="#subCat.getSubCategories()#" index="thirdCat">
											<option value="#thirdCat.getCategoryId()#"
											<cfif NOT IsNull(REQUEST.pageData.product) AND NOT IsNull(REQUEST.pageData.product.getCategoriesMV()) AND ArrayContains(REQUEST.pageData.product.getCategoriesMV(),thirdCat)>
											selected
											</cfif>
											>#RepeatString("&nbsp;",21)##thirdCat.getDisplayName()#</option>
										</cfloop>
										</li>
									</cfloop>
									</li>
								</cfloop>
							</select>
						</div>
						<div class="col-xs-4" style="padding-right:0;padding-left:10px;">
							<input type="text" name="search_keywords" id="search-keywords" class="form-control" placeholder="Keywords">
						</div>
						<div class="col-xs-1" style="padding-left:10px;">
							<button name="search_product" id="search-product" type="button" class="btn btn-sm btn-primary search-button" style="width:100%">Search</button>
						</div>
					</div>
					<div class="row" style="margin-top:18px;">
						<div class="col-xs-5">	
							<select name="products_searched" id="products-searched" multiple class="form-control" style="height:270px;">
							</select>
						</div>
						<div class="col-xs-2" style="text-align:center;">
							<a class="btn btn-app" id="add-all">
								<i class="fa fa-angle-double-right"></i> Add All
							</a>
							<a class="btn btn-app" id="add">
								<i class="fa fa-angle-right"></i> Add
							</a>
							<a class="btn btn-app" id="remove">
								<i class="fa fa-angle-left"></i> Remove
							</a>
							<a class="btn btn-app" id="remove-all">
								<i class="fa fa-angle-double-left"></i> Remove All
							</a>
						</div>
						<div class="col-xs-5">	
							<select name="products_selected" id="products-selected" multiple class="form-control" style="height:270px;">
								<cfif NOT IsNull(REQUEST.pageData.productGroup)>
									<cfloop array="#REQUEST.pageData.productGroup.getProducts()#" index="product">
										<option value="#product.getProductId()#">#product.getDisplayName()#</option>
									</cfloop>
								</cfif>
							</select>
						</div>
					</div>
				</div><!-- /.box-body -->
			</div><!-- /.box -->
			<div class="form-group">
				<button name="save_item" id="save-item" type="submit" class="btn btn-primary top-nav-button">Save Product Group</button>
				<button type="button" class="btn btn-danger pull-right #REQUEST.pageData.deleteButtonClass#" data-toggle="modal" data-target="##delete-current-entity-modal">Delete Product Group</button>
			</div>
		</div><!--/.col (left) -->
	</div>   <!-- /.row -->
</section><!-- /.content -->
<!-- DELETE ENTITY MODAL -->
<div class="modal fade" id="delete-current-entity-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Delete this product group?</h4>
			</div>
			<div class="modal-body clearfix">
				<button type="button" class="btn btn-danger pull-right" data-dismiss="modal"><i class="fa fa-times"></i> No</button>
				<button name="delete_item" type="submit" class="btn btn-primary"><i class="fa fa-check"></i> Yes</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</form>
</cfoutput>