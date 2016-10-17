<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
$.ajax({
		type: "post",
		url: "http://admin.pinmydeals.loc:8500/rest/aa/student/",
		dataType: 'jsonp',
		data: {
				customerID: 1
			}
})
.done(function(data) {		
	console.log(data);
});
</script>