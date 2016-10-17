<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
$.ajax({
		type: "post",
		url: "http://api.pinmydeals.loc/rest/admin/student",
		dataType: 'jsonp',
		data: {
				customerID: 1
			}
})
.done(function(data) {		
	console.log(data);
});
</script>