$(document).ready(function() {
  $("#education_educ_degree_id_new").hide();

  $("#addButton").click(function() {
    if($("#education_educ_degree_id").is(":visible")) {
      $("#education_educ_degree_id").hide();
      $("#education_educ_degree_id_new").show();
      $("#addButton").text('*');
    }

    else {
	    $("#education_educ_degree_id").show();
      $("#education_educ_degree_id_new").hide();
      $("#addButton").text('+');
      $("#education_educ_degree_id_new").val('');
    }
  });
});

$(document).ready(function() {
  $('#newEducationForm').submit(function(e) { 
    var $inputs = $('#newEducationForm :input');
    var flag = true;
    
    for(var i = 0; i < $inputs.length; i++) {
      if($inputs[i].id === 'education_title') {
        if($inputs[i].value === '') {
          $('#requiredTitle').text('* This Field is Mandatory');
          flag = false;
        }

        else {
          $('#requiredTitle').text('');
        }
      }

      if($("#education_educ_degree_id").is(":visible")) {
        if ($inputs[i].id === 'education_educ_degree_id') {
          if($inputs[i].value === '') {
            $('#requiredEducationD').text('* This Field is Mandatory');
            flag = false;
          }

          else {
            $('#requiredEducationD').text('');
          }
        }
      }

      else {
        if($inputs[i].id === 'education_educ_degree_id_new') {
          if($inputs[i].value === '') {
            $('#requiredEducationD').text('* This Field is Mandatory');
            flag = false;
          }

          else {
            $('#requiredEducationD').text('');
          }
        }
      }

      if($inputs[i].id === 'education_university') {
        if($inputs[i].value === '') {
          $('#requiredUniversity').text('* This Field is Mandatory');
          flag = false;
        }

        else {
          $('#requiredUniversity').text('');
        }
      }
    }

    if(flag) {
      e.submit();
    }

    else {
      e.preventDefault();
    }
    
    return false;
  });
});
/*
$(document).ready(function() {
  $('#EducationDegreeForm').submit(function(e) { 
    var $inputs = $('#EducationDegreeForm :input');
    var flag = true;
    
    for(var i = 0; i < $inputs.length; i++) {
      if($inputs[i].id === 'language_name') {
      	if($inputs[i].value.trim() === '') {
          $('#requiredName').text('* This Field is Mandatory');
          flag = false;
        }
        else {
          $('#requiredName').text('');
        }
      }	
      if($inputs[i].id === 'degree_name') {
        if($inputs[i].value.trim() === '') {
          $('#requiredName').text('* This Field is Mandatory');
          flag = false;
        }
        else {
          $('#requiredName').text('');
        }
      }
    }

    if(flag) {
      e.submit();
    }

    else {
      e.preventDefault();
    }
    
    return false;
  });
});
*/
$(document).ready(function() {
  $('#education_degree_table').dataTable({
      "bPaginate": false,
      "bLengthChange": false,
      "bFilter": true,
      "bInfo": false
    });
} );

$(document).ready(function() {
  $("#approved_flag_all").click(function() {
    var $inputs = $('#education_degree_table :input');
    var checked_status = this.checked;
    
    for(var i = 0; i < $inputs.length; i++) {
      $inputs[i].checked = checked_status;
    }
  });         
});

$(document).ready(function() {
  $('#candidates_table').dataTable({
      "bPaginate": false,
      "bLengthChange": false,
      "bFilter": true,
      "bInfo": false
    });
});

$(document).ready(function() {
  $('#candidates_search_table').dataTable({
      "bPaginate": false,
      "bLengthChange": false,
      "bFilter": true,
      "bInfo": false
    });
});

$(document).ready(function() {
  $('#EducationDegreeTableForm').submit(function(e) { 
    var $inputs = $('#EducationDegreeTableForm :input');
    var boxes = "";
    
    for(var i = 0; i < $inputs.length; i++) {
      if($inputs[i].name==='approved_flag') {
        boxes = boxes + $inputs[i].value + "," + $inputs[i].checked + ":";
      }
    }

    $('#EducationDegreeTableForm :input:last').append('<input type="text" id="Selected_ID" name="Selected_ID" value="' + boxes + '" />');

    e.submit();
    
    return false;
  });
});