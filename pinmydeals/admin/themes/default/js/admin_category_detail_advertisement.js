$(document).ready(function() {
	$('#ads_image').plupload({
		// General settings
		runtimes: 'html5,flash,silverlight,html4',
		
		url: urlHttpsAdmin + 'ajax/upload_ads.cfm',

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
		$('#deleted_ad_id').val($(this).attr('adid'));
	});
});