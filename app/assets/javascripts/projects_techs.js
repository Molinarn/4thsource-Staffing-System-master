var plat_id, role_id;

$(document).ready(function() {
	$("#dlgTechnologies").dialog({
		autoOpen: false,
		height: 200,
		width: 350,
		modal: true,
		buttons: {
			"Save": function () {
				Save();
			},
			"Cancel": function () {
				$(this).dialog("close");
			}
		}
	});
}
);

function Save()
{
	var data = $('#frmTechs').serialize() + "&role_id=" + role_id + "&platform_id=" + plat_id;
    var newContent = "";
    var chks = $('#frmTechs input:checkbox');
    for (i = 0; i < chks.length; i++)
    {
        if ($(chks[i]).is(":checked"))
        {
            if (newContent == "")
            {
                newContent = $(chks[i]).attr('custom-data');
            }
            else
            {
                newContent = newContent + ", " + $(chks[i]).attr('custom-data');
            }
        }
    }
	$('#techContent').html('Saving...');
	$.post(  
        'projects/techs/save',  
         data,  
         function(responseText){
    		if (responseText != "OK")
    		{
    			alert(responseText);
    		}
    		else
    		{
    			if (newContent == "")
    			{
    				newContent = "( --- )";
    			}
    			else
    			{
    				newContent = "(" + newContent + ")";
    			}
    			$('#techs' + plat_id + '_' + role_id).text(newContent);
    			$('#dlgTechnologies').dialog("close");
    		}    		
    });		
}

function showTechs(platform_id, prjrole_id)
{
	$('#techContent').html('Loading...');
	plat_id = platform_id;
	role_id = prjrole_id;
	var data = "role_id=" + prjrole_id + "&platform_id=" + platform_id;
	$.post(  
        'projects/techs',  
         data,  
         function(responseText){
    		$('#techContent').html(responseText);
    });	
	$('#dlgTechnologies').dialog("open");
}