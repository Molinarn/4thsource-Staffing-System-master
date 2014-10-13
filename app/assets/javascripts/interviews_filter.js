$(document).ready(function() {
	$('#interviews_table').dataTable({
		bJQueryUI : true,
		bFilter: true,//cuadro de búsqueda en la tabla
		bLengthChange: false,//opcion de cambiar cantidad de filas de la tabla que se muestran
		//sPaginationType: "full_numbers"//pie de la tabla(muestra la paginacon por números)
		
	});
} )


$(document).ready(function(){
	$('#interviews_table').dataTable().columnFilter({
		sPlaceHolder: "foot:before",
		aoColumns: [
		{sSelector: "#filtroType",type: "select"},
		{sSelector: "#filtroInterviewer",type: "text"},
		{sSelector: "#filtroCandidate",type: "text"},
		{sSelector: "#filtroResult",type: "number-range"},
		{sSelector: "#filtroDate",type: "date-range"},
		null
		]
	});
	 $.datepicker.regional[""].dateFormat = 'yy-mm-dd';
     $.datepicker.setDefaults($.datepicker.regional['']);
})
$(document).ready(function(){
	$('#btnClean').button();
	$('#btnClean').click(function(){		
		$('#interviews_table_select_0').val('');
		$('#interviews_table_filter_input_1').val('');
		$('#interviews_table_filter_input_2').val('');
		$('#interviews_table_range_from_3').val('');
		$('#interviews_table_range_to_3').val('');
		$('#interviews_table_range_from_4').val('');
		$('#interviews_table_range_to_4').val('');
		$('#interviews_table').dataTable().fnFilter('',0);
		$('#interviews_table').dataTable().fnFilter('',1);
		$('#interviews_table').dataTable().fnFilter('',2);
		$('#interviews_table').dataTable().fnFilter('',3);
		//$('#interviews_table_range_from_3').focus();
		//$('#interviews_table_range_from_3').keyup();

	});
})
$(document).ready(function(){
    $("#interviews_table_range_to_3").change(function(){
        var uno = $('#interviews_table_range_from_3').val()
		var dos = $('#interviews_table_range_to_3').val()
		if(parseInt(uno)>parseInt(dos))
		{
			$('#interviews_table_range_to_3').val("");
			$('#interviews_table_range_to_3').css({
				'border-color':'#F72D3A'
			});
			$('#interviews_table_range_to_3').focus();
			alert("Invalid result range.");
			
		}
		else
		{
			$('#interviews_table_range_to_3').css({
				'border-color':'#cccccc'
			});
		}
    });
});
$(document).ready(function(){
	$("#interviews_table_range_to_4").change(function(){
        var uno1 = $('#interviews_table_range_from_4').val();
		var dos2 = $('#interviews_table_range_to_4').val();
		if(Date.parse(uno1)>Date.parse(dos2))
		{
			alert("Invalid date range.");
			$('#interviews_table_range_to_4').val("");
			$('#interviews_table_range_to_4').css({
				'border-color':'#F72D3A'
			});
			$('#interviews_table_range_to_4').focus();
		}
		else
		{
			$('#interviews_table_range_to_4').css({
				'border-color':'#cccccc'
			});
		}
    });
});
function rango()
{
	var uno = $('#interviews_table_range_from_4').val();
	var dos = $('#interviews_table_range_to_4').val();
	if(Date.parse(uno)>Date.parse(dos))
		alert("Invalid date range.("+uno+"/"+dos+")");
}
function clear()
{
	$('#interviews_table_select_0').val('');
	$('#interviews_table_filter_input_1').val('');
	$('#interviews_table_filter_input_2').val('');
}