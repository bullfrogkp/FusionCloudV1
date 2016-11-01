<cfoutput>

 <!-- Morris.js charts -->
<script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="#SESSION.urlThemeAdmin#js/plugins/morris/morris.min.js" type="text/javascript"></script>

<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="#SESSION.urlThemeAdmin#js/AdminLTE/dashboard.js" type="text/javascript"></script>
<!-- Content Header (Page header) -->
<section class="content-header">
	<h1>
		Dashboard
	</h1>
	<ol class="breadcrumb">
		<li><a href="##"><i class="fa fa-dashboard"></i> Home</a></li>
		<li class="active">Dashboard</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">

	<!-- Small boxes (Stat box) -->
	<div class="row">
		<div class="col-lg-3 col-xs-6">
			<!-- small box -->
			<div class="small-box bg-aqua">
				<div class="inner">
					<h3>
						#ArrayLen(REQUEST.pageData.newOrders)#
					</h3>
					<p>
						New Orders
					</p>
				</div>
				<div class="icon">
					<i class="ion ion-bag"></i>
				</div>
				<a href="#APPLICATION.urlHttpsAdmin#orders.cfm" class="small-box-footer">
					More info <i class="fa fa-arrow-circle-right"></i>
				</a>
			</div>
		</div><!-- ./col -->
		<div class="col-lg-3 col-xs-6">
			<!-- small box -->
			<div class="small-box bg-yellow">
				<div class="inner">
					<h3>
						#ArrayLen(REQUEST.pageData.newCustomers)#
					</h3>
					<p>
						New Customers
					</p>
				</div>
				<div class="icon">
					<i class="ion ion-person-add"></i>
				</div>
				<a href="#APPLICATION.urlHttpsAdmin#customers.cfm" class="small-box-footer">
					More info <i class="fa fa-arrow-circle-right"></i>
				</a>
			</div>
		</div><!-- ./col -->
		<div class="col-lg-3 col-xs-6">
			<!-- small box -->
			<div class="small-box bg-green">
				<div class="inner">
					<h3>
						#ArrayLen(REQUEST.pageData.newReviews)#
					</h3>
					<p>
						New Reviews
					</p>
				</div>
				<div class="icon">
					<i class="ion ion-stats-bars"></i>
				</div>
				<a href="#APPLICATION.urlHttpsAdmin#reviews.cfm" class="small-box-footer">
					More info <i class="fa fa-arrow-circle-right"></i>
				</a>
			</div>
		</div><!-- ./col -->
		<div class="col-lg-3 col-xs-6">
			<!-- small box -->
			<div class="small-box bg-red">
				<div class="inner">
					<h3>
						0
					</h3>
					<p>
						New Messages
					</p>
				</div>
				<div class="icon">
					<i class="ion ion-pie-graph"></i>
				</div>
				<a href="#APPLICATION.urlHttpsAdmin#conversations.cfm" class="small-box-footer">
					More info <i class="fa fa-arrow-circle-right"></i>
				</a>
			</div>
		</div><!-- ./col -->
	</div><!-- /.row -->

	<!-- Main row -->
	<div class="row">
		<section class="col-lg-12">
			<!-- Custom tabs (Charts with tabs)-->
			<div class="nav-tabs-custom">
				<!-- Tabs within a box -->
				<ul class="nav nav-tabs pull-right">
					<li class="active"><a href="##revenue-chart" data-toggle="tab">Visitors</a></li>
					<li><a href="##revenue-chart" data-toggle="tab">Sales</a></li>
					<li class="pull-left header">Trends</li>
				</ul>
				<div class="tab-content no-padding">
					<!-- Morris chart - Sales -->
					<div class="chart tab-pane active" id="revenue-chart" style="position: relative; height: 300px;"></div>
					<div class="chart tab-pane" id="sales-chart" style="position: relative; height: 300px;"></div>
				</div>
			</div><!-- /.nav-tabs-custom -->
		</section>
		<!-- Left col -->
		<section class="col-lg-6"> 
			<div class="box box-danger">
				<div class="box-header">
					<h3 class="box-title">Latest Orders</h3>
				</div><!-- /.box-header -->
				<div class="box-body no-padding">
					<table class="table table-striped">
						<tr>
							<th>Customer</th>
							<th>Grand Total</th>
							<th></th>
						</tr>
						<cfloop array="#REQUEST.pageData.LastestOrders#" index="order">
							<tr>
								<td>#order.getCustomerFullName()#</td>
								<td>#LSCurrencyFormat(order.getSubTotalPrice(),"international",order.getCurrency().getLocale())#</td>
								<td><a href="#APPLICATION.urlHttpsAdmin#order_detail.cfm?id=#order.getOrderId()#">Detail</a></td>
							</tr>
						</cfloop>
					</table>
				</div>
			</div><!-- /.box (chat box) -->   
		</section><!-- /.Left col -->
		<!-- right col (We are only adding the ID to make the widgets sortable)-->
		<section class="col-lg-6"> 
			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">Latest Reviews</h3>
				</div><!-- /.box-header -->
				<div class="box-body no-padding">
					<table class="table table-striped">
						<tr>
							<th>Product</th>
							<th>Review</th>
							<th></th>
						</tr>
						<cfloop array="#REQUEST.pageData.LastestReviews#" index="review">
							<tr>
								<td>#review.getReviewerName()#</td>
								<td>#review.getSubject()#</td>
								<td><a href="#APPLICATION.urlHttpsAdmin#review_detail.cfm?id=#review.getReviewId()#">Detail</a></td>
							</tr>
						</cfloop>
					</table>
				</div>
			</div>
			<!-- /.box -->
		</section><!-- right col -->
	</div><!-- /.row (main row) -->
	<div class="row">
		<!-- Left col -->
		<section class="col-lg-6"> 
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">Bestsellers</h3>
				</div><!-- /.box-header -->
				<div class="box-body no-padding">
					<table class="table table-striped">
						<tr>
							<th>Product</th>
							<th>Sold</th>
							<th></th>
						</tr>
						<cfloop array="#REQUEST.pageData.bestSellerProducts#" index="product">
							<tr>
								<td>#product.getDisplayName()#</td>
								<td>#product.getSoldCount()#</td>
								<td><a href="#APPLICATION.urlHttpsAdmin#product_detail.cfm?id=#product.getProductId()#">Detail</a></td>
							</tr>
						</cfloop>
					</table>
				</div>
			</div><!-- /.box (chat box) -->   
		</section><!-- /.Left col -->
		<!-- right col (We are only adding the ID to make the widgets sortable)-->
		<section class="col-lg-6"> 
			<div class="box box-warning">
				<div class="box-header">
					<h3 class="box-title">Most Viewed Products</h3>
				</div><!-- /.box-header -->
				<div class="box-body no-padding">
					<table class="table table-striped">
						<tr>
							<th>Product</th>
							<th>Viewed</th>
							<th></th>
						</tr>
						<cfloop array="#REQUEST.pageData.topViewedProducts#" index="product">
							<tr>
								<td>#product.getDisplayName()#</td>
								<td>#product.getViewCount()#</td>
								<td><a href="#APPLICATION.urlHttpsAdmin#product_detail.cfm?id=#product.getProductId()#">Detail</a></td>
							</tr>
						</cfloop>
					</table>
				</div>
			</div>
			<!-- /.box -->

		</section><!-- right col -->
	</div><!-- /.row (main row) -->
</section><!-- /.content -->
</cfoutput>
