$(function(){
	$('#jobs_table').dataTable({
		bJQueryUI: true,
		bFilter: true,
		bLengthChange: false
		//sPaginationType: "full_numbers"
	});
});
$(function(){
    
    var input = $("[id^='t_']")
    validateNumber(input);
    
    function validateNumber(inputId){
        
        $(inputId).keydown(function(event) {
            if(event.target.value.match("\\.5$")){
                if(event.keyCode == 8){
                    event.target.value = '';
                    return;
                } else {
                    event.preventDefault();
                }
            } else {
                if ( $.inArray(event.keyCode,[46,8,9,27,13,190]) 
                !== -1 ||
                (event.keyCode == 65 && event.ctrlKey === true) ||
                (event.keyCode >= 35 && event.keyCode <= 39)) {
                
                    if(event.keyCode == 190){
                        event.target.value = 
                        event.target.value + '.5';
                        event.preventDefault();
                    } else {
                        return;
                    }
                      
                } else {
                    if (event.shiftKey ||
                       (event.keyCode < 48 ||
                        event.keyCode > 57) && 
                       (event.keyCode < 96 ||
                       event.keyCode > 105 )) {
                            event.preventDefault(); 
                        }
                }
            }  
        });
    }
});