// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
	$("#certification_chBNotInList").change(function() {
	    if(this.checked) {
	      $("#certification_name").removeAttr('readonly');	
	    }
	    else {
	    	$("#certification_name").val('');
	    	$("#certification_name").prop('readonly', 'true');
	    }	    	
	 });
});