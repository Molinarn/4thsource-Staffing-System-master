$(document).ready(function(){ 
	$("#date_processing_from").datepicker({changeMonth: true,changeYear: true, dateFormat: 'yy-mm-dd'});
	$("#date_processing_to").datepicker({changeMonth: true,changeYear: true, dateFormat: 'yy-mm-dd'});
	$("#hire_date").datepicker({changeMonth: true,changeYear: true, dateFormat: 'yy-mm-dd'});
	$("#start_date").datepicker({changeMonth: true,changeYear: true, dateFormat: 'yy-mm-dd'});      
});

$(document).ready(function(){
	$('#recruitingProcess').change(function() {
	    $('#date_processing_from').attr('disabled',! this.checked);
	    $('#date_processing_to').attr('disabled', ! this.checked);

	    if(!this.checked){
	    	$('#date_processing_from').val('');
	    	$('#date_processing_to').val('');
		}
	});

	$('#isRecruited').change(function(){
		$('#hire_date').attr('disabled', ! this.checked);
		$('#start_date').attr('disabled', ! this.checked);
		$('#search_office_id').attr('disabled', ! this.checked);

		if(!this.checked){
			$('#hire_date').val('');
	    	$('#start_date').val('');
	    	$('#search_office_id').val(0);
		}
	});	
});