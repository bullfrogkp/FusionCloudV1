/*attribute*/
INSERT INTO attribute
(name,display_name)
VALUES
('color','Color'),
('size','Size');

/*calculation type*/
INSERT INTO calculation_type
(name,display_name)
VALUES
('percentage','Percentage'),
('fixed','Fixed');

/*add top selling and group buying category*/
INSERT INTO category
(name,display_name,is_enabled,rank,show_category_on_navigation,display_category_list,display_custom_design,display_filter,is_special,is_deleted, title,keywords,description)
VALUES
('new arrivals','New Arrivals',1,0,0,0,0,0,1,0,'New Arrivals','New Arrivals','New Arrivals'),
('group buying','Group Buying',1,0,0,0,0,0,1,0,'Group Buying','Group Buying','Group Buying'),
('search result','Search Result',1,0,0,0,0,0,0,1,'Search Result','Search Result','Search Result'),
('top sellers','Top Sellers',1,0,0,0,0,0,1,0,'Top Sellers','Top Sellers','Top Sellers');

/*country*/
INSERT INTO country
(code,display_name)
VALUES
('US','USA'),
('CA','Canada');

/*coupon status type*/
INSERT INTO coupon_status_type
(name,display_name)
VALUES
('active','Active'),
('expired','Expired'),
('used','Used'),
('disabled','Disabled');

/*currency*/
INSERT INTO currency
(name,code,display_name,is_default,locale,multiplier,is_enabled,is_deleted)
VALUES
('cad','CAD','CAD',1,'English (Canadian)',1,1,0),
('usd','USD','USD',0,'English (US)',0.81,1,0);

/*customer_group*/
INSERT INTO customer_group
(name,display_name,is_default,is_enabled,is_deleted,discount_type_id)
VALUES
('default','Default',1,1,0,(SELECT discount_type_id FROM discount_type WHERE name = 'no discount')),
('wholesaler','Wholesaler',0,1,0,(SELECT discount_type_id FROM discount_type WHERE name = 'no discount')),
('retailer','Retailer',0,1,0,(SELECT discount_type_id FROM discount_type WHERE name = 'no discount'));

/*discount_type*/
INSERT INTO discount_type
(name,display_name,is_enabled,is_deleted,amount,calculation_type_id)
VALUES
('no discount','No Discount',1,0,0,(SELECT calculation_type_id FROM calculation_type WHERE name = 'fixed'));

/*email_content_type*/
INSERT INTO email_content_type
(name,display_name)
VALUES
('html','HTML'),
('plain text','Plain Text');

/*filter*/
INSERT INTO filter
(name,display_name)
VALUES
('color','Color'),
('size','Size');

/*link_status_type*/
INSERT INTO link_status_type
(name,display_name)
VALUES
('active','Active'),
('processed','Processed');

/*link_type*/
INSERT INTO link_type
(name,display_name,redirect_url)
VALUES
('reset password','Reset Password','reset_password');

/*order_product_status_type*/
/*www.amazon.com/gp/help/customer/display.html?nodeId=200243170*/
INSERT INTO order_product_status_type
(name,display_name)
VALUES
('working','Working'),
('ready_to_ship','Ready to Ship'),
('shipped','Shipped'),
('in_transit','In-Transit'),
('delivered','Delivered'),
('checked_in','Checked-In'),
('directed_to_prep','Directed to Prep'),
('receiving','Receiving'),
('closed','Closed'),
('canceled','Cancelled'),
('deleted','Deleted'),
('placed','Placed'),
('paid','Paid'),
('receiving_with_problems','Receiving with Problems');

/*order_status_type*/
/*www.amazon.com/gp/help/customer/display.html?nodeId=200243170*/
INSERT INTO order_status_type
(name,display_name)
VALUES
('working','Working'),
('ready_to_ship','Ready to Ship'),
('shipped','Shipped'),
('in_transit','In-Transit'),
('delivered','Delivered'),
('checked_in','Checked-In'),
('directed_to_prep','Directed to Prep'),
('receiving','Receiving'),
('closed','Closed'),
('canceled','Cancelled'),
('deleted','Deleted'),
('placed','Placed'),
('paid','Paid'),
('receiving_with_problems','Receiving with Problems');

/*order_transaction_type*/
INSERT INTO order_transaction_type
(name,display_name)
VALUES
('purchase','Purchase');

/*page_section*/
INSERT INTO page
(name,title,keywords,description)
VALUES
('index','index','index','index'),
('products','products','products','products');

/*page_section*/
INSERT INTO page_section
(name,content,page_id)
VALUES
('slide','',(select page_id from page where name = 'index')),
('advertisement','',(select page_id from page where name = 'index')),
('top selling','',(select page_id from page where name = 'index')),
('group buying','',(select page_id from page where name = 'index')),
('advertisement','',(select page_id from page where name = 'products')),
('best seller','',(select page_id from page where name = 'products'));

/*payment_method*/
INSERT INTO payment_method
(name,display_name)
VALUES
('paypal','PayPal');

/*product_type*/
INSERT INTO product_type
(name,display_name)
VALUES
('single','Single'),
('package','Package'),
('option','Option'),
('configurable','Configurable');

/*province*/
INSERT INTO province
(code,display_name)
VALUES
('AB','Alberta'),
('BC','British Columbia'),
('MB','Manitoba'),
('NB','New Brunswick'),
('NL','Newfoundland and Labrador'),
('NT','Northwest Territories'),
('NS','Nova Scotia'),
('NU','Nunavut'),
('ON','Ontario'),
('PE','Prince Edward Island'),
('QC','Quebec'),
('SK','Saskatchewan'),
('YT','Yukon Territory');

INSERT into province values 
('AL', 'Alabama'),
('AK', 'Alaska'),
('AZ', 'Arizona'),
('AR', 'Arkansas'),
('CA', 'California'),
('CO', 'Colorado'),
('CT', 'Connecticut'),
('DE', 'Delaware'),
('DC', 'District of Columbia'),
('FL', 'Florida'),
('GA', 'Georgia'),
('HI', 'Hawaii'),
('ID', 'Idaho'),
('IL', 'Illinois'),
('IN', 'Indiana'),
('IA', 'Iowa'),
('KS', 'Kansas'),
('KY', 'Kentucky'),
('LA', 'Louisiana'),
('ME', 'Maine'),
('MD', 'Maryland'),
('MA', 'Massachusetts'),
('MI', 'Michigan'),
('MN', 'Minnesota'),
('MS', 'Mississippi'),
('MO', 'Missouri'),
('MT', 'Montana'),
('NE', 'Nebraska'),
('NV', 'Nevada'),
('NH', 'New Hampshire'),
('NJ', 'New Jersey'),
('NM', 'New Mexico'),
('NY', 'New York'),
('NC', 'North Carolina'),
('ND', 'North Dakota'),
('OH', 'Ohio'),
('OK', 'Oklahoma'),
('OR', 'Oregon'),
('PA', 'Pennsylvania'),
('PR', 'Puerto Rico'),
('RI', 'Rhode Island'),
('SC', 'South Carolina'),
('SD', 'South Dakota'),
('TN', 'Tennessee'),
('TX', 'Texas'),
('UT', 'Utah'),
('VT', 'Vermont'),
('VA', 'Virginia'),
('WA', 'Washington'),
('WV', 'West Virginia'),
('WI', 'Wisconsin'),
('WY', 'Wyoming');

/*review_status_type*/
INSERT INTO review_status_type
(name,display_name)
VALUES
('approved','Approved'),
('rejected','Rejected'),
('pending','Pending');

/*shipping_carrier*/
INSERT INTO shipping_carrier
(name,display_name, image_name, component, is_enabled)
VALUES
('ups','UPS','ups.jpg','ups',1),
('fedex','Fedex','fedex.png','fedex',0),
('chinapost','China Post','chinapost.jpg','chinapost',1),
('dhl','DHL','dhl.png','dhl',0),
('ems','EMS','ems.jpg','ems',0),
('canadapost','Canada Post','canadapost.jpg','canadapost',1);

/*shipping_method*/
INSERT INTO shipping_method
(name,display_name,shipping_carrier_id, is_enabled, service_code)
VALUES
('ups regular','UPS - Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),1,11),
('ups express','UPS - Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),1,11),
('fedex regular','Fedex - Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'fedex'),0,11),
('fedex express','Fedex - Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'fedex'),0,11),
('chinapost regular','Chinapost - Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'chinapost'),1,11),
('chinapost express','Chinapost - Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'chinapost'),1,11),
('dhl regular','DHL - Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'dhl'),0,11),
('dhl express','DHL - Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'dhl'),0,11),
('ems regular','EMS - Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ems'),0,11),
('ems express','EMS - Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ems'),0,11),
('canadapost regular','Canadapost - Regular',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),1,11),
('canadapost express','Canadapost - Express',(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),1,11);

/*tax category*/
INSERT INTO tax_category
(name,display_name)
VALUES
('taxable','Taxable'),
('zero-rated','Zero-rated'),
('exempt','Exempt');

/*tracking_record_type*/
INSERT INTO tracking_record_type
(name)
VALUES
('shopping cart'),
('buy later'),
('history'),
('wishlist');

/*admin_user*/
INSERT INTO admin_user
(username,password,is_enabled,is_deleted)
VALUES
('kevin','9D5E3ECDEB4CDB7ACFD63075AE046672',1,0);

/*tax*/
INSERT INTO tax
(province_id, rate, tax_category_id)
SELECT	province_id,0, (SELECT tax_category_id FROM tax_category WHERE name = 'taxable')
FROM province;

INSERT INTO tax
(province_id, rate, tax_category_id)
SELECT	province_id,0, (SELECT tax_category_id FROM tax_category WHERE name = 'zero-rated')
FROM province;

INSERT INTO tax
(province_id, rate, tax_category_id)
SELECT	province_id,0, (SELECT tax_category_id FROM tax_category WHERE name = 'exempt')
FROM province;

/*tax detail page for update*/

/* images folder clean up */
/*order placed email*/

/*ups shipping*/
INSERT INTO shipping_method
(name, display_name, service_code, is_enabled, shipping_carrier_id,is_default)
VALUES
('ups - next day air early','UPS - Next Day Air Early','14',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - next day air','UPS - Next Day Air','01',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - next day saver','UPS - Next Day Saver','13',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - 2nd day air am','UPS - 2nd Day Air AM','59',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - 2nd day air','UPS - 2nd Day Air','02',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - 3 day select','UPS - 3 Day Select','12',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - ground','Ground','UPS - 03',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - standard','UPS - Standard','11',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - worldwide express','UPS - Worldwide Express','07',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - worldwide express plus','UPS - Worldwide Express Plus','54',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - worldwide expedited','UPS - Worldwide Expedited','08',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - saver','UPS - Saver','65',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - today standard','UPS - Today Standard','82',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - today dedicated courier','UPS - Today Dedicated Courier','83',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - today intercity','UPS - Today Intercity','84',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - today express','UPS - Today Express','85',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - today express saver','UPS - Today Express Saver','86',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - world wide express freight','UPS - World Wide Express Freight','96',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),0),
('ups - flat rate','UPS - Flat Rate','',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'ups'),1)
;

/*canadapost shipping*/
INSERT INTO shipping_method
(name, display_name, service_code, is_enabled, shipping_carrier_id,is_default)
VALUES
('canadapost - regular parcel','Canada Post - Regular Parcel','DOM.RP',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - expedited parcel','Canada Post - Expedited Parcel','DOM.EP',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - xpresspost','Canada Post - Xpresspost','DOM.XP',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - xpresspost certified','Canada Post - Xpresspost Certified','DOM.XP.CERT',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - priority','Canada Post - Priority','DOM.PC',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - delivered tonight','Canada Post - Delivered Tonight','DOM.DT',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - library books','Canada Post - Library Books','DOM.LIB',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - expedited parcel usa','Canada Post - Expedited Parcel USA','USA.EP',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - priority worldwide envelope usa','Canada Post - Priority Worldwide Envelope USA','USA.PW.ENV',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - priority worldwide pak usa','Canada Post - Priority Worldwide pak USA','USA.PW.PAK',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - priority worldwide parcel usa','Canada Post - Priority Worldwide Parcel USA','USA.PW.PARCEL',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - small packet usa air','Canada Post - Small Packet USA Air','USA.SP.AIR',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - tracked packet – usa','Canada Post - Tracked Packet – USA','USA.TP',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - tracked packet – usa (lvm)','Canada Post - Tracked Packet – USA (LVM)','USA.TP.LVM',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - xpresspost usa','Canada Post - Xpresspost USA','USA.XP',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - xpresspost international','Canada Post - Xpresspost International','INT.XP',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - international parcel air','Canada Post - International Parcel Air','INT.IP.AIR',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - international parcel surface','Canada Post - International Parcel Surface','INT.IP.SURF',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - priority worldwide envelope int''l','Canada Post - Priority Worldwide Envelope Int''l','INT.PW.ENV',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - priority worldwide pak int''l','Canada Post - Priority Worldwide pak Int''l','INT.PW.PAK',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - priority worldwide parcel int''l','Canada Post - Priority Worldwide parcel Int''l','INT.PW.PARCEL',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - small packet international air','Canada Post - Small Packet International Air','INT.SP.AIR',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - small packet international surface','Canada Post - Small Packet International Surface','INT.SP.SURF',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - tracked packet','Canada Post - Tracked Packet','INT.TP',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),0),
('canadapost - flat rate','Canada Post - Flat Rate','',1,(SELECT shipping_carrier_id FROM shipping_carrier WHERE name = 'canadapost'),1)
;

add anonymous customer for conversation tracking