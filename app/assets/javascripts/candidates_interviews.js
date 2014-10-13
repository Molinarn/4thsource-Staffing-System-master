// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
;$(document).ready(function() {

  var $selectType = $( "#cand_inter_interviews_type_id" ); 

  /*$selectType.change(function() {
   
    strVal = $selectType.val();

    if (strVal.length == 0)
      strVal = 0;

    url = '/interviews_types/search/' + strVal;
    $('#interviewer').hide();
    $('#imgloading').show();
    $.ajax({
      type: "GET",
      url: url,
      success: function(data) { 
          $('#imgloading').hide();
          $('#interviewer').empty();
          $('#interviewer').html(data);
          $('#interviewer').show();
      }
    });
    return false;
  });*/
});

$(document).ready(function() {
  $("#filter-date-start").datepicker("option", "showAnim", "slideDown");
  $("#filter-date-end").datepicker("option", "showAnim", "slideDown");
  return false;
});

