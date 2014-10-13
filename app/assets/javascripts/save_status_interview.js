var currentIndex = -1;
var currentRow = null;
$(document).ready(function() {
    $('#tblEntrevistas').dataTable({
        "bFilter": false,
        "bLengthChange": false
    });

    $('#dialog').dialog({
        autoOpen: false,
        resizable: false,
        width: '380px',
        modal: true,
        closeOnEscape: false,

        buttons: {
            Save: function () {
                if ($("#frmStatus").parsley('validate'))
                 Save();
            },
            Cancel: function() {
                $(this).dialog("close");
            }
        }
    });


} );

function Save()
{
    id = $('#fid').val();
    statuses_id = $('#inteview_status').val();

    data = $("#frmStatus").serialize();
    //data = data + "&rowId=" + currentIndex+", &id="+id+", &statuses_id="+statuses_id;
    $.post(  
        '/candidates/candidates_interviews/editest',  
        //'candidates_interviews',
         data,  
         function(responseText){  
            answer = responseText.split('*M*');
            if (answer[0] == "OK")
            {           
                if (currentIndex != -1) 
                {
                    $('#tblEntrevistas').dataTable().fnUpdate(
                        [
                        answer[1], //id
                        answer[2], //type
                        answer[3], //interviewer
                        answer[4], //result
                        answer[5], //coments
                        answer[6]  //status
                        ],
                        currentIndex,
                        undefined,
                        false                        
                    );                                        
                }
                else
                {
                    datacount = $('#tblEntrevistas').dataTable().fnGetData().length;
                    answer[2] = answer[2].replace('#ROWID#', datacount);
                    answer[3] = answer[3].replace('#ROWID#', datacount);
                    answer[4] = answer[4].replace('#ROWID#', datacount);
                    answer[5] = answer[5].replace('#ROWID#', datacount);
                    answer[6] = answer[6].replace('#ROWID#', datacount);
                    $('#tblEntrevistas').dataTable().fnAddData(
                        [
                        answer[1], //id
                        answer[2], //type
                        answer[3], //interviewer
                        answer[4], //result 
                        answer[5], //coments
                        answer[6]  //status
                        ],
                        true                        
                    );                    
                }
            }
            alert('Status modified successfully');
         },  
         "html"  
    ); 
    $("#dialog").dialog("close");
}
function changeStatuse(index,statuses_id,id)
{
    row = $('#tblEntrevistas').dataTable().fnGetData(index);
    currentIndex = index;
    $('#fid').val(id);
    //$('#fname').val(name);
    $('#inteview_status').val(statuses_id);
    $("#dialog").dialog({title: "Editar status"});
	$("#dialog").dialog("open");

}