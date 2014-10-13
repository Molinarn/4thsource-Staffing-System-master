var container_html;
var languages_container;
var lang_container_height;
var technologies_container;
var tools_container;
var current_tech;
var current_tool;
var current_tech_counter = 0;
var current_lang_counter = 0;
var current_tool_counter = 0;

var arrIdTools = new Array();
var arrIdTechnologies = new Array();
var arrIdLanguages = new Array();
var currentLang = -1;
var oldHTML = "";

function build_report()
{	
	var data = "technologies=" + JSON.stringify(arrIdTechnologies) + 
			   "&tools=" + JSON.stringify(arrIdTools) + 
			   "&languages=" + JSON.stringify(arrIdLanguages);
	$.post(  
        'staff/report/buildlist',  
         data,  
         function(responseText){  
    		oldHTML = jQuery('#content').html();
    	    jQuery('#content').html(responseText);
    });
}

function restore_content_html2(){
	jQuery('#content').html(oldHTML);
}

function display_report_form(){

	jQuery('#reports_side_link').attr("onclick", "return false;");
	jQuery('#repot_shortcut').attr("onclick", "return false;");
	jQuery('#reports_side_link').css('color', '#99CCFF');
	if(current_ajax_request != undefined){
		current_ajax_request.abort();
		jQuery('#loading_image').animate({opacity: 0}, 200);
	}
	content_html = jQuery('#content').html();	
	current_ajax_request = jQuery.ajax({
		type: "POST",
		dataType: 'json',
		data: {over: '0'},
		url: "staff/report",
		beforeSend: function(xhr) {
		  xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		},success: function (response) {
		},fail: function (jqXHR, textStatus) {
			alert("unkown error");           
		},complete: function (response) {
			technologies_container = {};
			tools_container = {};
			container_html = jQuery('#content').html();
			jQuery('#content').stop().animate({opacity: 0}, 400, function(){
				var final = '<button class="btn-primary" onclick="build_report()" style="float: right; margin-right: 25px">Build report</button><div id="resultContent"></div>';
				jQuery('#content').html(response.responseText + final);
				jQuery('#content').animate({opacity: 1}, 400);
			});
		}                     
	});		
}

function restore_content_html(){
	jQuery('#reports_side_link').attr("onclick", "display_report_form(); return false;");	
	jQuery('#reports_side_link').css('color', '#434343');	
	if(current_ajax_request != undefined){
		current_ajax_request.abort();
	}
	jQuery('#content').stop().animate({opacity: 0}, 400, function(){
		jQuery('#content').html(container_html);
		jQuery('#repot_shortcut').attr("onclick", "display_report_form(); return false;");
		$('#select_follower').val('');
		$('#microposts_feed').html('');
		jQuery('#content').animate({opacity: 1}, 400, function(){
			feed_admin_microposts(null); 
		});		
	});
}

function display_obscure(lang_id, lang){
	current_tech = lang;
	currentLang = lang_id;
	jQuery('#tag_' + lang_id).css('background', '#99FF99');	
	languages_container = jQuery('#languages_container').html();

	if(lang_container_height == undefined){
		lang_container_height = jQuery('#languages_container').height();
		jQuery('#languages_container').css('overflow', 'hidden');
		jQuery('#languages_container').css('height', lang_container_height);
		jQuery('#languages_container').append('&nbsp;');
	}

	jQuery('#languages_container').stop().animate({left: '-560px', opacity: 0}, 500, function(){		
		post_data = {over: lang_id, language: lang};
		jQuery('#languages_container').html('');
		current_ajax_request = jQuery.ajax({
			type: "POST",
			dataType: 'json',
			data: post_data,
			url: "staff/report",
			beforeSend: function(xhr) {
			  xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
			},success: function (response) {
			},fail: function (jqXHR, textStatus) {
				alert("unkown error");           
			},complete: function (response) {								
				jQuery('#languages_container').html(response.responseText);
				if(technologies_container[current_tech] != undefined){					
					for(var value in technologies_container[current_tech]){
						tag_id = technologies_container[current_tech][value];
						jQuery('#' + tag_id.name).css('background', '#99FF99');
					}		
				}
				jQuery('#languages_container').stop().animate({left: '0px', opacity: 1}, 500, function(){
					current_height = jQuery('#languages_container')[0].scrollHeight		
					jQuery('#languages_container').animate({height: current_height}, 300);
				});
			}                     
		});	
	});
}

function show_tags_again(lang_id){	
	jQuery('#languages_container').stop().animate({height: lang_container_height}, 300, function(){
		jQuery('#languages_container').animate({left: '-560px', opacity: 0}, 500, function(){
			jQuery('#languages_container').html(languages_container);
			selection_counter = 0;

			for(var value in technologies_container[current_tech]){
				selection_counter++;				
			}

			if(selection_counter <= 0){
				jQuery('#tag_' + lang_id).css('background', '#9999FF');	
				jQuery('#tag_' + lang_id).css({transition: 'background 1s'});
				delete technologies_container[current_tech];
				current_lang_counter--;		
			}
			jQuery('#languages_container').animate({left: '0px', opacity: 1}, 500, function(){				
				//jQuery('#tags_container').animate({opacity: 1}, 400);
			});
		});
	})
}

function handle_tech_pick(pick, pick_type, pick_id){	
	var SearchId;
	pick_object = jQuery('#' + pick);		
	test_picked = null;

	if(pick_type == 'tech'){
		SearchId = $.inArray(pick_id, arrIdTechnologies);
		if (SearchId == -1)
			arrIdTechnologies.push(pick_id);
		else
			arrIdTechnologies.splice(SearchId, 1);
		pick_id = pick_object.attr('id');
		test_picked = technologies_container[current_tech];
	}else if(pick_type == 'tool'){
		SearchId = $.inArray(pick_id, arrIdTools);
		if (SearchId == -1)
			arrIdTools.push(pick_id);
		else
			arrIdTools.splice(SearchId, 1);
		current_tool = pick;
		test_picked = tools_container[current_tool];
	}
	if (pick == 'plain')
	{
		SearchId = $.inArray(currentLang, arrIdLanguages);
		if (SearchId == -1)
			arrIdLanguages.push(currentLang);
		else
			arrIdLanguages.splice(SearchId, 1);		
	}

	if(test_picked == undefined){
		if(pick_type == 'tech'){
			jQuery('#' + pick).css('background', '#99FF99');			
			technologies_container[current_tech] = {};
			technologies_container[current_tech]["name" + pick] = {name: pick.replace(' ', ''), nodeid: pick_id};
			current_lang_counter++;
		}else if(pick_type == 'tool'){
			jQuery('#tag_' + pick).css('background', '#99FF99');			
			tools_container[current_tool] = {};
			tools_container[current_tool] = {name: pick.replace(' ', ''), nodeid: pick_id};
			current_tool_counter++;
		}
	}else{		
		if(search_existing_tag(test_picked, pick, pick_type)){			
			if(pick_type == 'tech'){				
				jQuery('#' + pick).css('background', '#9999FF');				
				insert_or_delete_node(pick, 'delete', 'tech', pick_id);				
			}else{
				jQuery('#tag_' + pick).css('background', '#9999FF');			
				insert_or_delete_node(pick, 'delete', 'tool', pick_id);				
			}
		}else{					
			if(pick_type == 'tech'){				
				jQuery('#' + pick).css('background', '#99FF99');
				insert_or_delete_node(pick, 'insert', 'tech', pick_id);
			}
		}
	}	
	if(pick_type == 'tech'){
		build_selection_tree(pick, 'tech');
	}else if(pick_type == 'tool'){
		build_selection_tree(pick, 'tool');
	}
}

function build_selection_tree(pick, selection_type){	
	if(selection_type == 'tech'){
		display_sub_name = "";	
		display_tech_name = current_tech.replace('-', '.')
		display_tech_name = display_tech_name.replace('_', ' ')
		sharp_string = current_tech.replace('#', '5h4rp');
		
		if(pick == 'plain'){
			pick = pick + "_" + sharp_string;
			display_name = "Plain " + display_tech_name;	
		}else{
			display_name = pick.replace('-', '.');
			display_name = display_name.replace('_', ' ');
		}

		tmp_id = 'tree_' + pick;
		counter = 0;
		should_show = false;
		html_string = "";
		will_remove = false;

		special_string = current_tech.replace('_', ' ');
		special_string = special_string.replace('-', '.');

		for(var value in technologies_container[current_tech]){
			for(var val in value){
				counter++;
			}
		}

		if(counter <= 0){
			should_show = false;
		}else if(counter > 0){
			should_show = true;
		}

		if(!jQuery('#picks_tree').find(jQuery('#tree_' + sharp_string)).length){
			jQuery('#picks_tree').append("<div style='padding-left: 5px;' id='tree_" + sharp_string + "'><b>" + display_tech_name + "</b><ul class='super_list' id='sub_tree_" + sharp_string + "'></ul></div>")
		}

		if(should_show){
			new_height = 0;
			current_height = parseInt(jQuery('#picks_tree')[0].scrollHeight);

			if(jQuery('#sub_tree_' + sharp_string).find(jQuery('#' + tmp_id)).length){
				jQuery('#' + tmp_id).animate({height: '0px', opacity: 0}, 100, function(){										
				});
				will_remove = true;		
				new_height = (parseInt(jQuery('#picks_tree')[0].scrollHeight)) - 30;	
			}else{
				html_string = "<li id='" + tmp_id + "' style='opacity: 0; height: 0px'>" + display_name + "</li>";	
				jQuery('#sub_tree_' + sharp_string).append(html_string);
				jQuery('#' + tmp_id).animate({height: '25px', opacity: 1}, 100, function(){
				
				});				
				new_height = (parseInt(jQuery('#picks_tree')[0].scrollHeight)) + 20;	
			}

			jQuery('#picks_tree').animate({height: new_height,opacity: 1}, 300, function(){
				if(will_remove){
					jQuery('#' + tmp_id).remove();	
				}
			});		
		}else if(!should_show){		
			jQuery('#tree_'+ sharp_string).animate({height: '0px', opacity: 0}, 300);		
			jQuery('#tree_'+ sharp_string).empty();
			jQuery('#tree_'+ sharp_string).remove();

			var complete_counter = jQuery('.super_list').length;
			var new_size_tree = 0;	
			if(complete_counter > 0){
				jQuery('.super_list').each(function(index, element){			
					new_size_tree = (new_size_tree + parseInt($(this).css('height'))) + 20;			
					complete_counter--;

					if(complete_counter == 0){
						jQuery('#picks_tree').stop().animate({height: new_size_tree}, 200);
					}
				});
			}else{
				jQuery('#picks_tree').stop().animate({height: 0, opacity: 0}, 500);
			}
			current_tech_counter = 0;
		}
	}else if(selection_type == 'tool'){			
		display_tool_name = current_tool.replace('-', '.')
		display_tool_name = display_tool_name.replace('_', ' ')
		sharp_string = current_tool.replace('#', '5h4rp');

		tmp_id = 'tree_' + pick;
		counter = 0;
		should_show = false;
		html_string = "";
		will_remove = false;

		for(var value in tools_container){		
			counter++;
		}

		if(counter < 0){
			should_show = false;
		}else if(counter > 0){
			should_show = true;
		}

		var new_height = 0;

		if(jQuery('.super_tools').find(jQuery('#tree_' + sharp_string)).length){
			jQuery('#tree_' + sharp_string).stop().animate({height: 0, opacity: 0}, 200);
		}

		if(!jQuery('#tools_pick').find(jQuery('#tree_' + sharp_string)).length){			
			jQuery('#tools_pick').append("<div class='super_tools' style='padding-left: 5px;padding-bottom: 5px;opacity: 0' id='tree_" + sharp_string + "'>" + display_tool_name + "</div>");
			jQuery('#tree_' + sharp_string).stop().animate({opacity: 1}, 200);
			console.log(parseInt(jQuery('#tree_' + sharp_string)[0].scrollHeight));
			//new_height = (parseInt(jQuery('#tools_pick')[0].scrollHeight)) + parseInt(jQuery('#tree_' + sharp_string)[0].scrollHeight) ;
		}else{
			new_height = new_height - parseInt(jQuery('#tree_' + sharp_string).css('height'));
					
			jQuery('#tree_' + sharp_string).remove();
		}
		
		if(should_show){
			jQuery('#tools_pick').stop().animate({height: new_height, opacity: 1}, 200);
		}else if(!should_show){			
			jQuery('#tools_pick').stop().animate({height: 0, opacity: 0}, 200);
		}
	}

	counter = 0;
	general_height = 0;

	for(var value in tools_container){
		counter++;
	}

	if(counter > 0){
		general_height = parseInt(jQuery('#tools_pick')[0].scrollHeight) + 7.5;
	}

	for(var value in technologies_container){
		counter++;
	}

	if(counter > 0){
		general_height = general_height + parseInt(jQuery('#picks_tree')[0].scrollHeight) + 7.5;
	}

	general_height =  general_height;

	jQuery('#selection_containers').stop().animate({height: general_height}, 200);
}

function search_existing_tag(tmp_obj, pick, tag_type){
	if(tag_type == 'tech'){
		for(var value in tmp_obj){
			if(tmp_obj[value].name == pick){
				return true;
			}
		}
	}else{
		for(var value in tools_container){			
			if(value == pick){
				return true;
			}
		}
	}
	return false;
}

function insert_or_delete_node(pick, action, node_type, node_id){
	if(action == 'insert'){
		if(node_type == 'tech'){
			technologies_container[current_tech]['name' + pick] = {name: pick.replace(' ', ''), nodeid: node_id};
		}
	}else if(action == 'delete'){		
		if(node_type == 'tech'){
			delete technologies_container[current_tech]['name' + pick];
		}else if(node_type == 'tool'){			
			delete tools_container[current_tool];			
		}
	}
}