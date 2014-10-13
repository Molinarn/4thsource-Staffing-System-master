var currentIndex = -1;
var currentRow = null;
$(document).ready(function() {
    $('#tblKnowledges').dataTable({
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
                if ($("#frmKnowledge").parsley('validate'))
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
                data = "knowledgeId=" + currentIndex;
                $.post(  
                    'knowledges/delete',  
                     data,  
                     function(responseText){  
                        if (responseText == "OK")
                        {           
                            $('#tblKnowledges').dataTable().fnDeleteRow(
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
    data = $("#frmKnowledge").serialize();
    data = data + "&rowId=" + currentIndex;
    id = $('#fid').val();
    $.post(  
        'knowledges/process',  
         data,  
         function(responseText){  
            answer = responseText.split('*M*');
            if (answer[0] == "OK")
            {           
                if (currentIndex != -1) 
                {
                    $('#tblKnowledges').dataTable().fnUpdate(
                        [
                        answer[1], //id
                        answer[2], //name
                        answer[3], //description 
                        answer[4]  //x delete
                        ],
                        currentIndex,
                        undefined,
                        false                        
                    );                                        
                }
                else
                {
                    datacount = $('#tblKnowledges').dataTable().fnGetData().length;
                    answer[2] = answer[2].replace('#ROWID#', datacount);
                    answer[3] = answer[3].replace('#ROWID#', datacount);
                    answer[4] = answer[4].replace('#ROWID#', datacount);
                    $('#tblKnowledges').dataTable().fnAddData(
                        [
                        answer[1], //id
                        answer[2], //name
                        answer[3], //description 
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
    row = $('#tblKnowledges').dataTable().fnGetData(index);
    currentIndex = index;
    $('#fid').val(row[0]);
    $('#fname').val(name);
    $('#fdescription').val(row[2]);
    $("#dialog").dialog({title: "Edit"});
    $("#dialog").dialog("open");    
}

function Delete(index)
{
    row = $('#tblKnowledges').dataTable().fnGetData(index);
    currentRow = $('#tblKnowledges').dataTable().fnGetNodes(index);
    currentIndex = row[0];
    $("#dlgConfirm").dialog("open");
}