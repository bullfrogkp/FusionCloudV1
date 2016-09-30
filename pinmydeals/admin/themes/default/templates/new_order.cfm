<cfoutput>
<section class="content-header">
	<h1>
		New Order
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">New Order</li>
	</ol>
</section>

<!-- Main content -->
<form method="post">
<input type="hidden" name="id" id="id" value="#REQUEST.pageData.formData.id#" />
<input type="hidden" name="subtotal_amount" id="subtotal_amount" value="#REQUEST.pageData.formData.subtotal_amount#" />
<input type="hidden" name="shipping_amount" id="shipping_amount" value="#REQUEST.pageData.formData.shipping_amount#" />
<input type="hidden" name="tax_amount" id="tax_amount" value="#REQUEST.pageData.formData.tax_amount#" />
<input type="hidden" name="total_amount" id="total_amount" value="#REQUEST.pageData.formData.total_amount#" />
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
		<section class="col-lg-12"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Products</h3>
					<a href="" class="add-product" data-toggle="modal" data-target="##add-product-modal" style="line-height:40px;"><span class="label label-primary">Add Product</span></a>
				</div><!-- /.box-header -->
				<div class="box-body">
					<table class="table table-bordered table-striped">
						<thead>
							<th>Product</th>
							<th>ID</th>
							<th>Name</th>
							<th>Price</th>
							<th>Qty</th>
							<th>Shipping</th>
							<th>Subtotal</th>
						</thead>
						<tbody>
							<cfif NOT IsNull(REQUEST.pageData.order) AND NOT IsNull(REQUEST.pageData.order.getProducts())>
								<cfloop array="#REQUEST.pageData.order.getProducts()#" index="product">
									<cfif NOT IsNull(product.getImageName())>
										<cfset imageLink = "#APPLICATION.absoluteUrlSite#images/uploads/product/#product.getProductId()#/#product.getImageName()#" />
									<cfelse>
										<cfset imageLink = "#APPLICATION.absoluteUrlSite#images/site/no_image_available.png" />
									</cfif>
									<tr>
										<td style="width:110px;"><img class="img-responsive" src="#imageLink#" style="width:100px;" /></td>
										<td>#product.getProductId()#</td>
										<td>#product.getDisplayName()#</td>
										<td>#product.getOrderPrice()#</td>
										<td>#product.getQuantity()#</td>
										<td>#product.getShippingCarrierName()# - #product.getShippingMethodName()#</td>
										<td>#product.getSubtotalAmount()#</td>
									</tr>
								</cfloop>
							<cfelse>
								<tr>
									<td colspan="7">No product.</td>
								</tr>
							</cfif>
						</tbody>
					</table>
				</div>
			</div><!-- /.box (chat box) -->   
		</section>
	</div><!-- /.row (main row) -->
	<div class="row">
		<section class="col-lg-12"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Customer Information</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<label>Prefix</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="prefix" value="#REQUEST.pageData.formData.prefix#"/>
					</div>
					<div class="form-group">
						<label>First Name</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="first_name" value="#REQUEST.pageData.formData.first_name#"/>
					</div>
					<div class="form-group">
						<label>Middle Name</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="middle_name" value="#REQUEST.pageData.formData.middle_name#"/>
					</div>
					<div class="form-group">
						<label>Last Name</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="last_name" value="#REQUEST.pageData.formData.last_name#"/>
					</div>
					<div class="form-group">
						<label>Suffix</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="suffix" value="#REQUEST.pageData.formData.suffix#"/>
					</div>
					<div class="form-group">
						<label>Email</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="email" value="#REQUEST.pageData.formData.email#"/>
					</div>
					<div class="form-group">
						<label>Phone</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="phone" value="#REQUEST.pageData.formData.phone#"/>
					</div>
					<div class="form-group">
						<label>Save Customer and Addresses ?</label>
						<select class="form-control" name="save_customer_and_addresses">
							<option value="1">Yes</option>
							<option value="0">No</option>
						</select>
					</div>
				</div>
			</div><!-- /.box (chat box) -->   
		</section>
	</div><!-- /.row (main row) -->
	
	<div class="row">
		<!-- Left col -->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Billing Address</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<label>Company</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="billing_company" value="#REQUEST.pageData.formData.billing_company#" />
					</div>
					<div class="form-group">
						<label>Unit</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="billing_unit" value="#REQUEST.pageData.formData.billing_unit#" />
					</div>
					<div class="form-group">
						<label>Street Address</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="billing_street" value="#REQUEST.pageData.formData.billing_street#" />
					</div>
					<div class="form-group">
						<label>City</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="billing_city" value="#REQUEST.pageData.formData.billing_city#" />
					</div>
					<div class="form-group">
						<label>State/Province</label>
						<select class="form-control" name="billing_province_id">
							<option value="">Please Select...</option>
							<cfloop array="#REQUEST.pageData.provinces#" index="province">
								<option value="#province.getProvinceId()#"
								
								<cfif province.getProvinceId() EQ REQUEST.pageData.formData.billing_province_id>
								selected
								</cfif>
								
								>#province.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
					<div class="form-group">
						<label>Zip/Postal Code</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="billing_postal_code" value="#REQUEST.pageData.formData.billing_postal_code#" />
					</div>
					<div class="form-group">
						<label>Country</label>
						<select class="form-control" name="billing_country_id">
							<option value="">Please Select...</option>
							<cfloop array="#REQUEST.pageData.countries#" index="country">
								<option value="#country.getCountryId()#"
								
								<cfif country.getCountryId() EQ REQUEST.pageData.formData.billing_country_id>
								selected
								</cfif>
								
								>#country.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
				</div>
			</div><!-- /.box (chat box) -->   
		</section><!-- /.Left col -->
		<!-- right col (We are only adding the ID to make the widgets sortable)-->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Shipping Address</h3>
					<div class="form-group pull-right" style="margin:10px 10px 0 0;">
						<input type="checkbox" class="form-control" #REQUEST.pageData.formData.same_as_shipping_address# />
						<label>Same As Shipping Address</label>
					</div>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<label>Company</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="shipping_company" value="#REQUEST.pageData.formData.shipping_company#" />
					</div>
					<div class="form-group">
						<label>Unit</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="shipping_unit" value="#REQUEST.pageData.formData.shipping_unit#" />
					</div>
					<div class="form-group">
						<label>Street Address</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="shipping_street" value="#REQUEST.pageData.formData.shipping_street#" />
					</div>
					<div class="form-group">
						<label>City</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="shipping_city" value="#REQUEST.pageData.formData.shipping_city#" />
					</div>
					<div class="form-group">
						<label>State/Province</label>
						<select class="form-control" name="shipping_province_id">
							<option value="">Please Select...</option>
							<cfloop array="#REQUEST.pageData.provinces#" index="province">
								<option value="#province.getProvinceId()#"
								
								<cfif province.getProvinceId() EQ REQUEST.pageData.formData.shipping_province_id>
								selected
								</cfif>
								
								>#province.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
					<div class="form-group">
						<label>Zip/Postal Code</label>
						<input type="text" class="form-control" placeholder="Enter ..." name="shipping_postal_code" value="#REQUEST.pageData.formData.shipping_postal_code#" />
					</div>
					<div class="form-group">
						<label>Country</label>
						<select class="form-control" name="shipping_country_id">
							<option value="">Please Select...</option>
							<cfloop array="#REQUEST.pageData.countries#" index="country">
								<option value="#country.getCountryId()#"
								
								<cfif country.getCountryId() EQ REQUEST.pageData.formData.shipping_country_id>
								selected
								</cfif>
								
								>#country.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
				</div>
			</div>
			<!-- /.box -->
		</section><!-- right col -->
	</div><!-- /.row (main row) -->
	
	<div class="row">
		<section class="col-lg-12"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Coupon Code</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Enter ..." name="coupon_code" value="#REQUEST.pageData.formData.coupon_code#" />
					</div>
				</div>
			</div>
			<!-- /.box -->
		</section><!-- right col -->
	</div><!-- /.row (main row) -->
	<div class="row">
		<!-- Left col -->
		<section class="col-lg-12"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Payment Method</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<select class="form-control" name="payment_method_id">
							<option value="">Please Select...</option>
							<cfloop array="#REQUEST.pageData.paymentMethods#" index="method">
								<option value="#method.getPaymentMethodId()#"
								
								<cfif method.getPaymentMethodId() EQ REQUEST.pageData.formData.payment_method_id>
								selected
								</cfif>
								
								>#method.getDisplayName()#</option>
							</cfloop>
						</select>
					</div>
				</div>
			</div><!-- /.box (chat box) -->   
		</section>
	</div><!-- /.row (main row) -->
	<div class="row">
		<!-- Left col -->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Comments</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="form-group">
						<textarea name="comments" class="form-control" rows="8" placeholder="Enter ..." style="height:133px;">#REQUEST.pageData.formData.comments#</textarea>
					</div>
				</div>
			</div><!-- /.box (chat box) -->   
		</section><!-- /.Left col -->
		<!-- right col (We are only adding the ID to make the widgets sortable)-->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Order Totals</h3>
				</div><!-- /.box-header -->
				<div class="box-body">
					<div class="table-responsive">
						<table class="table">
							<tr>
								<th style="width:50%">Subtotal:</th>
								<td>#DollarFormat(REQUEST.pageData.formData.subtotal_amount)#</td>
							</tr>
							<tr>
								<th>Shipping & Handling:</th>
								<td>#DollarFormat(REQUEST.pageData.formData.shipping_amount)#</td>
							</tr>
							<tr>
								<th>Tax:</th>
								<td>#DollarFormat(REQUEST.pageData.formData.tax_amount)#</td>
							</tr>
							<tr>
								<th>Total:</th>
								<td>#DollarFormat(REQUEST.pageData.formData.total_amount)#</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<!-- /.box -->
		</section><!-- right col -->
	</div><!-- /.row (main row) -->
	<button name="submit_order" type="submit" class="btn btn-primary">Submit Order</button>
					
</section><!-- /.content -->
<!-- ADD PRODUCT MODAL -->
<div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Add New Product</h4>
			</div>
		
			<div class="modal-body">
				<div class="form-group">
					<input id="new_order_product_id" name="new_order_product_id" type="text" class="form-control" placeholder="Product ID">
				</div>
				<div class="form-group">
					<input id="new_order_product_quantity" name="new_order_product_quantity" type="text" class="form-control" placeholder="Quantity">
				</div>
				<div class="form-group">
					<textarea name="new_order_product_comments" class="form-control" rows="8" placeholder="Enter ..." style="height:160px;"></textarea>
				</div>
				<div class="form-group">
					<select class="form-control" name="new_order_product_shipping_method_id">
						<option value="">Please Select Shipping...</option>
						<cfloop array="#REQUEST.pageData.shippingCarriers#" index="shippingCarrier">
							<cfloop array="#shippingCarrier.getShippingMethods()#" index="method">
								<option value="#method.getShippingMethodId()#">#shippingCarrier.getDisplayName()# - #method.getDisplayName()#</option>
							</cfloop>
						</cfloop>
					</select>
				</div>
			</div>
			<div class="modal-footer clearfix">
				<button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Cancel</button>
				<button name="add_new_product" type="submit" class="btn btn-primary pull-left"><i class="fa fa-check"></i> Add</button>
			</div>
		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</cfoutput>