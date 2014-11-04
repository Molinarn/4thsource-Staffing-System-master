// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//***CORRECTO, CAMBIA COLOR,TAMAÑO Y FONDO DE 'FLASH' CUANDO ES EXITOSO***
//$(document).ready(function(){
//	$("#flash").css({'color':'Black','font-size':'16px','background':'#58ACFA', 'font-weight':'Bold'});
//});

//***ABRE POPUP AL GUARDAR

$(document).ready(function(){
  
    $("#flash").css({
        'color':'Black',
        //'background':'#CEF6F5',
        'font-size':'14px',
        'font-weight':'Bold'
    });//cierra flash .css
    $( "#flash" ).dialog({
        //z-index: 9999,//Es para evitar que algun elemento se sobreponga
        title: "4th Source says:",
        autoOpen: true,
        height: 150,
        width: 300,
        modal: true,
        closeOnEscape: false,
        resizable:false,
        buttons: {
            Ok: function() {
                $( this ).dialog( "close" );
            }
        }
    });//cierra flash .dialog
});//cierra documentready

//>>>>>>> a01198ba0ba91827105c9d3db48ac39430ba2780
