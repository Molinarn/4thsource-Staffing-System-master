$(document).ready(function() {
  $("#date_processing_from").attr('disabled', 'disabled');
  $("#date_processing_to").attr('disabled', 'disabled');
  $("#hire_date").attr('disabled', 'disabled');
  $("#start_date").attr('disabled', 'disabled');

  $("#search_type_tag").change(function() {
    var state = $('select#search_type_tag :selected').val();
    if(state == "") state="0";
    jQuery.getJSON('/staff/1/report/search/?state=' + state, function(data){
        $("#search_category_textbox").val(data.message + data.state);
    })
    return false;
  });

  /*$("#recruitingProcess").click(function() {
    if(this.checked) {
      $("#search_date_processing_from_2i").removeAttr('disabled');
      $("#search_date_processing_from_3i").removeAttr('disabled');
      $("#search_date_processing_from_1i").removeAttr('disabled');
      $("#search_date_processing_to_2i").removeAttr('disabled');
      $("#search_date_processing_to_3i").removeAttr('disabled');
      $("#search_date_processing_to_1i").removeAttr('disabled');
    }

    else {
      $("#search_date_processing_from_2i").attr('disabled', 'disabled');
      $("#search_date_processing_from_3i").attr('disabled', 'disabled');
      $("#search_date_processing_from_1i").attr('disabled', 'disabled');
      $("#search_date_processing_to_2i").attr('disabled', 'disabled');
      $("#search_date_processing_to_3i").attr('disabled', 'disabled');
      $("#search_date_processing_to_1i").attr('disabled', 'disabled');
    }
  });  */       

  $("#recruitingProcess").click(function() {
    if(this.checked) {
      $("#date_processing_from").removeAttr('disabled');
      $("#date_processing_to").removeAttr('disabled');
    }else {
      $("#date_processing_from").attr('disabled', 'disabled');
      $("#date_processing_to").attr('disabled', 'disabled');
    }
  });         

  $("#isRecruited").click(function() {
    if(this.checked) {
      $("#hire_date").removeAttr('disabled');
      $("#start_date").removeAttr('disabled');
    }else {
      $("#hire_date").attr('disabled', 'disabled');
      $("#start_date").attr('disabled', 'disabled');
    }
  });         

  $('#reportSearchForm').submit(function(e) { 
    var $inputs = $('#reportSearchForm :input');
    var flag = true;

    if(flag) {
      e.submit();
    }

    else {
      e.preventDefault();
    }
    
    return false;
  });

  $('#summaryForm').submit(function(e) { 
    var $input = $('#candidate_prof_summary_summary');
    var flag = false;

    if($input.val().length >= 150)
    { 
    if ($input.val().length < 255) 
      {
       e.submit();
      }
    else
      {
       alert("You can't exceed 255 characters in the summary");
      }
    }

    else {
      alert("You have to capture at least 150 characters in the summary");
      e.preventDefault();
    }
    return false;
  });  
});