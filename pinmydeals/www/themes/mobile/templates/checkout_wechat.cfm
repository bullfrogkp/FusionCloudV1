<cfoutput>
<div class="breadcrumb-box">
	<a href="##">Home</a>
	<a href="##">Checkout</a>
</div>

<div class="information-blocks">
	<div class="row">
		<div class="col-sm-9 information-entry">
			<div class="accordeon size-1">
				<div class="accordeon-title active"><span class="number">1</span>Checkout Method</div>
				<div class="accordeon-entry" style="display: block;">
					<div class="row">
						<div class="col-md-6 information-entry">
							<div class="article-container style-1">
								<h3>Checkout as a Guest or Register</h3>
								<p>Lorem ipsum dolor amet, conse adipiscing, eiusmod tempor incididunt ut labore et dolore magna aliqua. 
								</p>
								<p>
									<label class="checkbox-entry radio">
										<input type="radio" name="custom-name" checked> <span class="check"></span> <b>Checkout as Guest</b>
									</label>
									<label class="checkbox-entry radio">
										<input type="radio" name="custom-name"> <span class="check"></span> <b>Register</b>
									</label>
								</p>
								<p>Register with us for future convenience:</p>                                                
								<ul>
									<li>Fast and easy check out</li>
									<li>Easy access to your order history and status</li>
								</ul>
								<a class="button style-18">continue</a>
							</div>
						</div>
						<div class="col-md-6 information-entry">
							<div class="article-container style-1">
								<h3>Registered Customers</h3>
								<p>Lorem ipsum dolor amet, conse adipiscing, eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
								<form>
									<label>Email Address</label>
									<input type="text" value="" placeholder="Enter Email Address" class="simple-field">
									<label>Password</label>
									<input type="password" value="" placeholder="Enter Password" class="simple-field">
									<div class="button style-10">Login Page<input type="submit" value=""></div>
									<a class="forgot-password" href="##">Forgot password?</a>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="accordeon-title"><span class="number">2</span>Shipping Information</div>
				<div class="accordeon-entry">
					<div class="row">
						<div class="col-md-6 information-entry">
							<div class="article-container style-1">
								<h3>Shipping Address</h3>
								<form>
									<input type="text" value="" placeholder="Company" class="simple-field">
									<input type="text" value="" placeholder="Phone" class="simple-field">
									<input type="text" value="" placeholder="First Name" class="simple-field">
									<input type="text" value="" placeholder="Middle Name" class="simple-field">
									<input type="text" value="" placeholder="Unit" class="simple-field">
									<input type="text" value="" placeholder="Street" class="simple-field">
									<input type="text" value="" placeholder="City" class="simple-field">
									<div class="simple-drop-down simple-field">
										<select name="province_id" id="province-id">
											<option value="">Province</option>
											<cfloop array="#REQUEST.pageData.provinces#" index="province">
												<option value="#province.getProvinceId()#">#province.getDisplayName()#</option>
											</cfloop>
										</select>
									</div>
									<input type="text" value="" placeholder="Postal Code" class="simple-field">
									<div class="simple-drop-down simple-field">
										<select name="country_id" id="country-id">
											<option value="">Country</option>
											<cfloop array="#REQUEST.pageData.countries#" index="country">
												<option value="#country.getCountryId()#">#country.getDisplayName()#</option>
											</cfloop>
										</select>
									</div>
									<a class="button style-18">continue</a>
								</form>
							</div>
						</div>
						<div class="col-md-6 information-entry">
							<div class="article-container style-1">
								<h3>Billing Address</h3>
								<form>
									<input type="text" value="" placeholder="Company" class="simple-field">
									<input type="text" value="" placeholder="Phone" class="simple-field">
									<input type="text" value="" placeholder="First Name" class="simple-field">
									<input type="text" value="" placeholder="Middle Name" class="simple-field">
									<input type="text" value="" placeholder="Unit" class="simple-field">
									<input type="text" value="" placeholder="Street" class="simple-field">
									<input type="text" value="" placeholder="City" class="simple-field">
									<div class="simple-drop-down simple-field">
										<select name="province_id" id="province-id">
											<option value="">Province</option>
											<cfloop array="#REQUEST.pageData.provinces#" index="province">
												<option value="#province.getProvinceId()#">#province.getDisplayName()#</option>
											</cfloop>
										</select>
									</div>
									<input type="text" value="" placeholder="Postal Code" class="simple-field">
									<div class="simple-drop-down simple-field">
										<select name="country_id" id="country-id">
											<option value="">Country</option>
											<cfloop array="#REQUEST.pageData.countries#" index="country">
												<option value="#country.getCountryId()#">#country.getDisplayName()#</option>
											</cfloop>
										</select>
									</div>
								</form>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4 information-entry">
							<div class="article-container style-1">
								Kevin Pan<br/>
								5940 Yonge St.<br/>
								North York, Ontario, M2M4M6<br/>
								Canada<br/><br/>
								<a class="button style-18">use this address</a>
							</div>
						</div>
						<div class="col-md-4 information-entry">
							<div class="article-container style-1">
								Kevin Pan<br/>
								5940 Yonge St.<br/>
								North York, Ontario, M2M4M6<br/>
								Canada<br/><br/>
								<a class="button style-18">use this address</a>
							</div>
						</div>
						<div class="col-md-4 information-entry">
							<div class="article-container style-1">
								Kevin Pan<br/>
								5940 Yonge St.<br/>
								North York, Ontario, M2M4M6<br/>
								Canada<br/><br/>
								<a class="button style-18">use this address</a>
							</div>
						</div>
					</div>
				</div>
				<div class="accordeon-title"><span class="number">3</span>Shipping Method</div>
				<div class="accordeon-entry">
					<div class="article-container style-1">
						<label class="checkbox-entry radio">
							<input type="radio" name="custom-name" checked> <span class="check"></span> <b>Free Shipping</b>
						</label>
						<label class="checkbox-entry radio">
							<input type="radio" name="custom-name"> <span class="check"></span> <b>Standard Shipping</b>
						</label>
						<label class="checkbox-entry radio">
							<input type="radio" name="custom-name"> <span class="check"></span> <b>1-Day Shipping</b>
						</label>
						<label class="checkbox-entry radio">
							<input type="radio" name="custom-name"> <span class="check"></span> <b>2-Days Shipping</b>
						</label>
					</div>
				</div>
				<div class="accordeon-title"><span class="number">4</span>Payment Information</div>
				<div class="accordeon-entry">
					<div class="article-container style-1">
						<p>By creating an account with our store, you will be able to move through the checkout process faster, store multiple shipping addresses, view and track your orders in your account and more.Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
					</div>
				</div>
				<div class="accordeon-title"><span class="number">5</span>Order Review</div>
				<div class="accordeon-entry">
					<div class="article-container style-1">
						<p>By creating an account with our store, you will be able to move through the checkout process faster, store multiple shipping addresses, view and track your orders in your account and more.Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-3 information-entry">
			<h3 class="cart-column-title size-2">Your Checkout Progress</h3>
			<div class="checkout-progress-widget">
				<div class="step-entry">1. Billing Address</div>
				<div class="step-entry">2. Shipping Address</div>
				<div class="step-entry">3. Shipping Method</div>
				<div class="step-entry">4. Payment Method</div>
			</div>
			<div class="article-container style-1">
				<p>Custom CMS block displayed below the one page checkout progress block. Put your own content here.</p>
			</div>
			<div class="information-blocks">
				<a class="sale-entry vertical" href="##">
					<span class="hot-mark yellow">hot</span>
					<span class="sale-price"><span>-40%</span> Valentine <br/> Underwear Sale</span>
					<span class="sale-description">Lorem ipsum dolor sitamet, conse adipisc sed do eiusmod tempor.</span>
					<img style="" class="sale-image" src="#SESSION.absoluteUrlTheme#images/text-widget-image-3.jpg" alt="" />
				</a>
			</div>
		</div>
	</div>    
</div>
</cfoutput>
