// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  $('#adminusers_table').dataTable({
      "bPaginate": true,
      "bLengthChange": false,
      "bFilter": true,
      "bInfo": false,
      "aaSorting": [[2,'asc'],[0,'asc']]
    });
  $('#adminusersnew_table').dataTable({
      "bPaginate": true,
      "bLengthChange": false,
      "bFilter": true,
      "bInfo": false,
      "aaSorting": [[2,'asc'],[0,'asc']]
    });
  
  $( "#searchCandidates" ).change(function() {
    if ($("#searchCandidates").val().length == 0)
      return false;
    strVal = $("#searchCandidates").val();
    url = '/admin_users/search/' + strVal;
    $('#datatbl').hide();
    $('#imgloading').show();
    $.ajax({
      type: "GET",
      url: url,
      success: function(data) {
           // data is ur summary
          $('#imgloading').hide();
          $('#adminusersnew_table').empty();
          $('#adminusersnew_table').html('<tbody></tbody>');
          $('#adminusersnew_table tbody').html(data);
          $('#datatbl').show();
          $('#adminusersnew_table').dataTable({
            "bPaginate": false,
            "bLengthChange": false,
            "bFilter": false,
            "bDestroy": true,
            "bInfo": false,
            "aaSorting": [[2,'asc'],[0,'asc']]
          });
      }
    });
    return false;
  });
});

function updateValue(url, id)
{
  $('#datatbl').hide();
  $('#imgloading').show();
  $.ajax({
    type: "GET",
    url: url,
    success: function(data) {
         // data is ur summary
        $('#imgloading').hide();
        $('#adminusers_table').empty();
        $('#adminusers_table').html('<tbody></tbody>');
        $('#adminusers_table tbody').html(data);
        $('#datatbl').show();
        $('#adminusers_table').dataTable({
          "bPaginate": true,
          "bLengthChange": false,
          "bFilter": true,
          "bDestroy": true,
          "bInfo": false,
          "aaSorting": [[2,'asc'],[0,'asc']]
        });
    }
  });
  return false;
}

function addToAdmin(url, id)
{
  $('#datatbl').hide();
  $('#imgloading').show();
  $.ajax({
    type: "GET",
    url: url,
    success: function(data) {
         // data is ur summary
        $('#imgloading').hide();
        $('#datatbl').show();
        alert(data);
    }
  });
  return false;
}
