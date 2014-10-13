var currentIndex = -1;
var currentRow = null;
$(document).ready(function() {
    $('#tblTechnologies').dataTable({
        "bFilter": false,
        "bLengthChange": false
    });

    $('#dialog').dialog({
        autoOpen: false,
        resizable: false,
        width: '380px',
        modal: true,
        buttons: {
            Save: function () {
                if ($("#frmTechnologies").parsley('validate'))
                 Save();
            },
            Cancel: function() {
                $(this).dialog("close");
            }
        }
    });

    $('#dlgConfirm').dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        buttons: {
            Yes: function () {
                data = "technologyId=" + currentIndex;
                $.post(  
                    'tech/delete',  
                     data,  
                     function(responseText){  
                        if (responseText == "OK")
                        {           
                            $('#tblTechnologies').dataTable().fnDeleteRow(
                                currentRow
                            );                                        
                        }
                        else
                        {
                            alert('Error while deleting the item');
                        }                        
                     },  
                     "html"  
                ); 
                $(this).dialog("close");    
            },
            No: function() {
                $(this).dialog("close");
            }
        }
    });

    $('#new').click(function() {
        currentIndex = -1;
        $('#fname').val('');
        $("#dialog").dialog({title: "New"});
        $("#dialog").dialog("open");
    });
} );

function Save()
{
    data = $("#frmTechnologies").serialize();
    data = data + "&rowId=" + currentIndex;
    id = $('#fid').val();
    $.post(  
        'tech/process',  
         data,  
         function(responseText){  
            answer = responseText.split('*M*');
            if (answer[0] == "OK")
            {           
                if (currentIndex != -1) 
                {
                    $('#tblTechnologies').dataTable().fnUpdate(
                        [
                        answer[1], //id
                        answer[2], //name
                        answer[4]  //x delete
                        ],
                        currentIndex,
                        undefined,
                        false                        
                    );                                        
                }
                else
                {
                    datacount = $('#tblTechnologies').dataTable().fnGetData().length;
                    answer[2] = answer[2].replace('#ROWID#', datacount);
                    answer[3] = answer[3].replace('#ROWID#', datacount);
                    answer[4] = answer[4].replace('#ROWID#', datacount);
                    $('#tblTechnologies').dataTable().fnAddData(
                        [
                        answer[1], //id
                        answer[2], //name
                        answer[4]  //x delete
                        ],
                        true                        
                    );                    
                }
            }
            alert('New item added successfully');
         },  
         "html"  
    ); 
    $("#dialog").dialog("close");
}

function Edit(index, name)
{
    row = $('#tblTechnologies').dataTable().fnGetData(index);
    currentIndex = index;
    $('#fid').val(row[0]);
    $('#fname').val(name);
    $('#fdescription').val(row[2]);
    $("#dialog").dialog({title: "Edit"});
    $("#dialog").dialog("open");    
}

function Delete(index)
{
    row = $('#tblTechnologies').dataTable().fnGetData(index);
    currentRow = $('#tblTechnologies').dataTable().fnGetNodes(index);
    currentIndex = row[0];
    $("#dlgConfirm").dialog("open");
}