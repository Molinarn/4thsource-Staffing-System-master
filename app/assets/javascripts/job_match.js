// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){	  
	var $selectType = $( "#jobSearch" ); 
  $selectType.change(function(){    
    strVal = $selectType.val();    
    if (strVal.length == 0)
      strVal = 0;    
    url = '/job_match/search/' + strVal;    
    $.ajax({
      type: "GET",
      url: url,
      success: function(data) {          
          $('#tableJobs').html(data);          
      }
    });
    return false;
  });
  
  var $searchMatch = $("#btnSearch");
  var $percentage = $("#matchPercentage");
  //$('body').on('click', '#btnSearch', function(){
  $searchMatch.click(function(){ 
    var values = getTextValues('#tableJobs');       
  	strVal = $selectType.val();
  	strPercentage = $percentage.val();
  	if (strVal.length == 0 && strPercentage == 0)
  	{
  		strVal = 0;
  		strPercentage = 0;
  	}
  	url = '/job_match/match/' + strVal + '/' +strPercentage + '&' + values;
    //alert(url);
    //url = '/job_match/match/' 	
  	$.ajax({
  		type: "GET",
  		url: url,
  		success: function(data){
  			$('#tableMatch').html(data);        
  		}
  	});
  });

  //Funcion para traer los datos de las cajas de texto para pasar por la url         
  function getTextValues(parentDivId){
        
            var inputText = $(parentDivId).find('input[type=text]'),
            textValues = [],
            valuesString = '';
        inputText.each(function(index, Element){
            var $this = $(this),
                id = $this.attr("id"),
                value = $this.val();
            if(value.search(/\./g) != -1){
                value = value.replace(/\./g, "");
            } else{
                value = value + '0';
            }
            textValues[index] = {
                'id': id,
                'value': value
            }
        });
        
        for(i in textValues){
            valuesString +=
                textValues[i].id + '=' + 
                textValues[i].value + '&';
        }
        
        valuesString = valuesString.replace(/&$/, "");
        
        return valuesString;
    }

});