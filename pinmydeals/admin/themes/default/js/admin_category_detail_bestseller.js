$(document).ready(function() {
	$('#add-all').click(function() {  
		$('#products-searched').each(function() {
			$('#products-searched option').remove().appendTo('#products-selected'); 
		});
	});  
	
	$('#remove-all').click(function() {  
		$('#products-selected').each(function() {
			$('#products-selected option').remove().appendTo('#products-searched'); 
		});  
	}); 

	$('#add').click(function() {  
		return !$('#products-searched option:selected').remove().appendTo('#products-selected').removeAttr('selected'); 
	});  
	
	$('#remove').click(function() {  
		return !$('#products-selected option:selected').remove().appendTo('#products-searched').removeAttr('selected'); 
	});	
	
	$('#search-product').click(function() {
		$.ajax({
					type: 'get',
					url: urlHttpsAdmin + 'ajax/product.cfc',
					dataType: 'json',
					data: {
						method: 'searchProducts',
						productGroupId: $('#search-product-group-id').val(),
						categoryId: $('#search-category-id').val(),
						keywords: $('#search-keywords').val()
					},		
					success: function(response) {
						var productArray = response.DATA;
						var productName = '';
						var productId = '';
						
						$('#products-searched').empty();
						for (var i = 0, len = productArray.length; i < len; i++) {
							productName = productArray[i][0];
							productId = productArray[i][1];
							
							$('#products-searched').append('<option value="' + productId + '">' + productName + '</option>');
						}
					}
		});
	});
	
	$('#save-item').click(function() {  
		selectBox = document.getElementById('products-selected');

		for (var i = 0; i < selectBox.options.length; i++) 
		{ 
			 selectBox.options[i].selected = true; 
		} 
	});
});