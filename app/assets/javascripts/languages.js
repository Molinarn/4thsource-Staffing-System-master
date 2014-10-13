var currentIndex = -1;
var currentRow = null;
$(document).ready(function() {
    $('#tblLanguages').dataTable({
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
                if ($("#frmLanguages").parsley('validate'))
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
                data = "languageId=" + currentIndex;
                $.post(  
                    'languages/delete',  
                     data,  
                     function(responseText){  
                        if (responseText == "OK")
                        {           
                            $('#tblLanguages').dataTable().fnDeleteRow(
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
        $('#fid').val('');
        $('#fname').val('');
        $('#fdescription').val('');
        $("#dialog").dialog({title: "New"});
        $("#dialog").dialog("open");
    });
} );

function Save()
{
    data = $("#frmLanguages").serialize();
    data = data + "&rowId=" + currentIndex;
    id = $('#fid').val();
    $.post(  
        'languages/process',  
         data,  
         function(responseText){  
            answer = responseText.split('*M*');
            if (answer[0] == "OK")
            {           
                if (currentIndex != -1) 
                {
                    $('#tblLanguages').dataTable().fnUpdate(
                        [
                        answer[1], //id
                        answer[2], //name
                        answer[3], //description 
                        answer[4],  //View
                        answer[5]  //x delete
                        ],
                        currentIndex,
                        undefined,
                        false                        
                    );                                        
                }
                else
                {
                    datacount = $('#tblLanguages').dataTable().fnGetData().length;
                    answer[2] = answer[2].replace('#ROWID#', datacount);
                    answer[3] = answer[3].replace('#ROWID#', datacount);
                    answer[5] = answer[5].replace('#ROWID#', datacount);
                    $('#tblLanguages').dataTable().fnAddData(
                        [
                        answer[1], //id
                        answer[2], //name
                        answer[3], //description 
                        answer[4],  //View
                        answer[5]  //x delete
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
    row = $('#tblLanguages').dataTable().fnGetData(index);
    currentIndex = index;
    $('#fid').val(row[0]);
    $('#fname').val(name);
    $('#fdescription').val(row[2]);
    $("#dialog").dialog({title: "Edit"});
    $("#dialog").dialog("open");    
}

function Delete(index)
{
    row = $('#tblLanguages').dataTable().fnGetData(index);
    currentRow = $('#tblLanguages').dataTable().fnGetNodes(index);
    currentIndex = row[0];
    $("#dlgConfirm").dialog("open");
}