// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {

$('#jqxTree').jqxTree({ height: '400px', hasThreeStates: true, checkboxes: true, width: '630px', theme: 'fresh' });
$("#btnMake").click(function () {
  var items = $('#jqxTree').jqxTree('getCheckedItems');
  var checkedItems = new Array();  
  for (var i = 0; i < items.length; i++)
  {  	
  	var node = items[i];
  	checkedItems.push(node);
  	while (node != null)
  	{
  		var parentI = node.parentElement;
  		if (parentI != null)
  		{
  			node = $('#jqxTree').jqxTree('getItem', parentI);
  			if (checkedItems.indexOf(node) == -1)
  				checkedItems.push(node);
  		}
  		else
  			node = null;  		
  	}
  }
  var filter = "";
  for (i = 0; i < checkedItems.length; i++)
  {
    filter = filter + "{#" + checkedItems[i].value + "#}"; 
  }
  $('#filter').val(filter);
  $('#frmProfile').submit();
});
});