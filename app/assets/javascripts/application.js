// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require profile
//= require resume
//= require candidates_interviews
//= require interviews_types

jQuery(document).ready(function(){
	set_sidebar_content_size();
	$('.dropdown-toggle').dropdown();
});

var succesfully_requested_micropost_data;
var pages;
var microposts;
var micropost_html;
var reply_form_string;
var page_index; 
var unread_counter;
var current_ajax_request;

$(document).ready(function() {        
    succesfully_requested_micropost_data = true;    

    jQuery('#only_my_posts').attr('disabled', 'disabled');    
    feed_admin_microposts(null);    

    jQuery('#select_follower').change(function(){
      if(jQuery('#select_follower').val()){
        jQuery('#only_my_posts').removeAttr('disabled');      
        feed_admin_microposts(null);        
      }else{
        jQuery('#only_my_posts').attr('disabled', 'disabled');        
        feed_admin_microposts(null);        
      }
    });

    jQuery('#only_my_posts').click(function(){      
      feed_admin_microposts(null);      
    });

    content_height = jQuery('#content').css('height').replace("px", "");    
    jQuery('#pages_container').css('top', content_height - 35);
    jQuery('#content').css('height', content_height );
    //jQuery('#pages_container').css('left', content_width - (content_width / 2) - (page_rail_width / 2));
});

function feed_wall_screen(user_id){
  solomicro = '1';
  onlymine = '0';
  select_value = user_id;
  reply_to_convo = '0';
  user_wall = '1';
  page_url = window.location.origin + '/feed_admin/' + select_value;  
  jQuery('#ajax_loader').stop().animate({opacity: 1}, 200);
  jQuery.ajax({
        type: "POST",
        dataType: 'json',
        data: {solomicro: onlymine, user_followed: select_value, conv_id: reply_to_convo, wall: user_wall},
        url: page_url,
        beforeSend: function(xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        },success: function (response) {

        },fail: function (jqXHR, textStatus) {            
          succesfully_requested_micropost_data = true;
        },complete: function (response) {                                    
          jQuery('#microposts_feed').animate({opacity: 0}, 200, function(){              
            jQuery('#pages_script').html(response.responseText);                
            paginate_microposts(pages);
            succesfully_requested_micropost_data = true;
            jQuery('#ajax_loader').animate({opacity: 0}, 200);
          }); 
        }
  });  
}

function feed_admin_microposts(reply){
  user_wall = '0';
  reply_to_convo = '0';
  
  if(reply != null){
    reply_to_convo = reply;
    jQuery('#reply_button').attr('disasbled', 'disabled');
  }else{
    select_value = jQuery('#select_follower').val();  
  }

  if(!select_value){        
    select_value = 0;  
  }else{    
    jQuery('#only_my_posts').removeAttr('disabled');    
  }
  
  page_url = 'feed_admin/' + select_value;
  
  onlymine = 0;
  
  if (select_value && succesfully_requested_micropost_data || select_value == 0){      
    succesfully_requested_micropost_data = false;    
    if(jQuery('#select_follower').val()){  
      jQuery('#only_my_posts').attr('disabled', 'disabled');
    }

    jQuery('#select_follower').attr('disabled', 'disabled');      

    if(jQuery('#only_my_posts').is(':checked') && reply == null){
      onlymine = 1;
    }else if(reply != null){
      onlymine = 2;
    }
    jQuery('#loading_image').animate({opacity: 1}, 100, function(){ 
      current_ajax_request = jQuery.ajax({
            type: "POST",
            dataType: 'json',
            data: {solomicro: onlymine, user_followed: select_value, conv_id: reply_to_convo, wall: user_wall},
            url: page_url,
            beforeSend: function(xhr) {
              xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
            },success: function (response) {
            },fail: function (jqXHR, textStatus) {
              if(reply_to_convo != '0'){
                if(jQuery('#select_follower').val()){    
                  jQuery('#only_my_posts').removeAttr('disabled');
                }
                jQuery('#select_follower').removeAttr('disabled');
              }
              succesfully_requested_micropost_data = true;
            },complete: function (response) {
              if(response.status == 200){
                if(reply_to_convo == '0'){
                  jQuery('#microposts_feed').stop().animate({opacity: 0}, 200, function(){
                    jQuery('#pages_script').html(response.responseText);
                    if(unread_counter != undefined){
                      jQuery('#unread_microposts').animate({opacity: 0}, 200, function(){                  
                        jQuery('#unread_microposts').html('Unread: ' + unread_counter);
                        jQuery('#loading_image').animate({opacity: 0}, 100, function(){   
                          jQuery('#unread_microposts').animate({opacity: 1}, 200, function(){
                            jQuery('.btn-primary').removeAttr('disabled');
                          });
                        });
                      })
                    }
                    paginate_microposts(pages);
                  });
                }else{
                  jQuery('#microposts_feed').stop().animate({opacity: 0}, 200, function(){
                    jQuery('#pages_script').html(response.responseText);
                    jQuery('#loading_image').animate({opacity: 0}, 100, function(){ 
                      display_reply_form();
                    });
                  });
                }
                succesfully_requested_micropost_data = true;
                if(jQuery('#select_follower').val()){
                  jQuery('#only_my_posts').removeAttr('disabled');
                }
                jQuery('#select_follower').removeAttr('disabled');
              }
            }
      });
    });
  }
}

function paginate_microposts(pages_array){
  if(pages_array != undefined){  
    if(pages_array.length > 1){    
      jQuery('#pages_container').stop().animate({opacity: 0}, 200, function(){
        jQuery('#pages_container').html('<div id="pages_rail"></div>');
        jQuery('#pages_rail').append('<div class="page_link" id="move_beggining" onclick="move_static_pages(0)"><<</div><div class="page_link" id="prev_page" onclick="move_forward_or_back(\'back\')">Previous</div>');
        for (i = 0; i < pages_array.length; i++){
          number = i + 1;
          jQuery('#pages_rail').append('<div class="page_link" id="page_' + i + '"" onclick="move_static_pages(' + i + ')"><b>' + number + '</b></div>');
        }
        jQuery('#pages_rail').append('<div class="page_link" id="next_page" onclick="move_forward_or_back(\'forward\')">Next</div><div class="page_link" id="move_end" onclick="move_static_pages('+ (pages.length - 1)+')">>></div></div>');
        jQuery('#pages_container').stop().animate({opacity: 1}, 500);
      });    
    }else{
      jQuery('#pages_container').stop().animate({opacity: 0}, 500, function(){
        jQuery('#pages_container').html('');      
      });
    }

    page_index = null;
    move_static_pages(0);

    if(page_index < pages.length - 1){
      jQuery('#move_end').css('color', '#6699CC');
      jQuery('#move_end').css('cursor', 'pointer');
      jQuery('#move_end').removeAttr('disabled');
      jQuery('#next_page').css('color', '#6699CC');
      jQuery('#next_page').css('cursor', 'pointer');
      jQuery('#next_page').removeAttr('disabled');
      jQuery('#page_' + pages.length - 1).css('color', '#6699CC');
      jQuery('#page_').css('cursor', 'pointer');
      jQuery('#page_' + pages.length - 1).removeAttr('disabled', 'disabled');
    }else if(page_index == pages.length - 1){
      jQuery('#move_end').css('color', '#E0E0E0');
      jQuery('#move_end').css('cursor', 'default');
      jQuery('#move_end').attr('disabled', 'disabled');
      jQuery('#next_page').css('color', '#E0E0E0');
      jQuery('#next_page').css('cursor', 'default');
      jQuery('#next_page').attr('disabled', 'disabled');
      jQuery('#page_' + pages.length - 1).css('color', '#E0E0E0');
      jQuery('#page_' + pages.length - 1).css('cursor', 'default');
      jQuery('#page_' + pages.length - 1).removeAttr('disabled', 'disabled');
    }
    set_content_size();
  }else{
    console.log("data loading failed...");
  }
}

function move_static_pages(_page_index){
  if(page_index != _page_index && pages != undefined){
    jQuery('#pages_rail').attr('disabled', 'disabled');
    jQuery('#microposts_feed').animate({opacity: 0}, 200, function(){
      jQuery('#microposts_feed').html('');
      current_page = pages[_page_index]
      for(i = 0; i < current_page.length; i++){
        jQuery('#microposts_feed').append('</br>');
        jQuery('#microposts_feed').append(current_page[i]);
        jQuery('#microposts_feed').append('</br>');
        jQuery('#microposts_feed').append('</br>');
      }
      jQuery('#microposts_feed').animate({opacity: 1}, 200, function(){
        jQuery('#pages_rail').removeAttr('disabled');
        page_index = _page_index
        analyze_page_movement();
      });
    });
  }
}

function analyze_page_movement(){
  if(page_index == 0){
    jQuery('#move_beggining').css('color', '#E0E0E0');
    jQuery('#move_beggining').css('cursor', 'default');
    jQuery('#move_beggining').attr('disabled', 'disabled');
    jQuery('#prev_page').css('color', '#E0E0E0');
    jQuery('#prev_page').css('cursor', 'default');
    jQuery('#prev_page').attr('disabled', 'disabled');
    jQuery('#page_0').css('color', '#E0E0E0');
    jQuery('#page_0').css('cursor', 'default');
    jQuery('#page_0').attr('disabled', 'disabled');
  }
  if(page_index > 0){
    jQuery('#move_beggining').css('color', '#6699CC');
    jQuery('#move_beggining').css('cursor', 'pointer');
    jQuery('#move_beggining').removeAttr('disabled');
    jQuery('#prev_page').css('color', '#6699CC');
    jQuery('#prev_page').css('cursor', 'pointer');
    jQuery('#prev_page').removeAttr('disabled');
    jQuery('#page_0').css('color', '#6699CC');
    jQuery('#page_0').css('cursor', 'pointer');
    jQuery('#page_0').removeAttr('disabled');    
  }
  if(page_index < pages.length){
    jQuery('#move_end').css('color', '#6699CC');
    jQuery('#move_end').css('cursor', 'pointer');
    jQuery('#move_end').removeAttr('disabled');
    jQuery('#next_page').css('color', '#6699CC');
    jQuery('#next_page').css('cursor', 'pointer');
    jQuery('#next_page').removeAttr('disabled');
    jQuery('#page_' + (pages.length - 1)).css('color', '#6699CC');
    jQuery('#page_' + (pages.length - 1)).css('cursor', 'pointer');
    jQuery('#page_' + (pages.length - 1)).removeAttr('disabled', 'disabled');
  }
  if(page_index == pages.length - 1){
    jQuery('#move_end').css('color', '#E0E0E0');
    jQuery('#move_end').css('cursor', 'default');
    jQuery('#move_end').attr('disabled', 'disabled');
    jQuery('#next_page').css('color', '#E0E0E0');
    jQuery('#next_page').css('cursor', 'default');
    jQuery('#next_page').attr('disabled', 'disabled');
    jQuery('#page_' + (pages.length - 1)).css('color', '#E0E0E0');
    jQuery('#page_' + (pages.length - 1)).css('cursor', 'default');
    jQuery('#page_' + (pages.length - 1)).attr('disabled', 'disabled');    
  }

  for(i = 0; i < pages.length; i++){
    if(i == page_index){
      jQuery('#page_' + (i)).css('color', '#FF33CC');
    }else{
      jQuery('#page_' + (i)).css('color', '#6699CC');
    }   
  }  
}

function move_forward_or_back(move_where){  
  if(move_where == 'forward' && page_index < pages.length - 1){    
    move_static_pages(page_index + 1);
  }else if(move_where == 'back' && page_index > 0){    
    move_static_pages(page_index - 1);
  }  
}

function submit_reply(conversation_id){
  jQuery('.btn-primary').attr('disabled', 'disabled');
  page_url = 'reply/' + conversation_id;
  reply_content = jQuery.trim(jQuery('#reply_text').val());
  
  if(reply_content && reply_content != ""){
    jQuery('#loading_image').animate({opacity: 1}, 100, function(){     
      jQuery.ajax({
              type: "POST",
              dataType: 'json',
              data: {reply_id: conversation_id, reply_text: reply_content},
              url: page_url,
              beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
              },success: function (response) {                        
              },fail: function (jqXHR, textStatus) {
              },complete: function (response) {                          
                feed_admin_microposts(null);
              }
      });
    });
  }
}

function cancel_reply(){
  jQuery('#cancel_reply').attr('disabled', 'disabled');
  jQuery('#loading_image').animate({opacity: 1}, 100, function(){ 
    feed_admin_microposts(null);
  });
}

function display_reply_form(){
  jQuery('#pages_container').stop().animate({opacity: 0}, 200, function(){
    jQuery('#pages_container').html('');
    jQuery('#microposts_feed').html('');
    jQuery('#microposts_feed').append(reply_form_string);
    jQuery('#microposts_feed').animate({opacity: 1}, 200, function(){
      jQuery('.btn-primary').removeAttr('disabled');
    });
  });
}

function set_content_size(){
  var content = $("#content");
  var shortcuts = $("#shortcuts");

  height = content.height() + shortcuts.height();
  content.stop().animate({height: height + 'px'}, 200);
}

function set_sidebar_content_size(){
  var content = $("#content");
  var sidebar = $("#sidebar");
  var height;
  var breadcrumbs = $("#breadcrumbs");
  var subheader = $("img.subheader");    

  sidebar.height(content.height());
}

function checkForm() {  
  var pass = jQuery.trim($('#candidate_password').val());
  var confirmation = jQuery.trim($('#candidate_password_confirmation').val());
  console.log(pass + " -> " + confirmation);
  var regularExpression = (/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{6,16}$/);
  var error_message = "";


  if (regularExpression.test(pass) && pass === confirmation && pass != "" && confirmation != "") {
    return true;
  }else if(pass == "" && confirmation == ""){
    return true
  }else if(pass == "" && confirmation != ""){
    error_message = "<b>Please confirm the password in the confirmation field</b>";
  }else if(pass != "" && confirmation == ""){
    error_message = "<b>PAssword field cannot be empty</b>";
  }else if(pass !== confirmation){    
    error_message = "<b>Password did not match confirmation field</b>";
  }else if(!regularExpression.test(pass)){
    error_message = "<b>Invalid password.</b><br>Password should:<ul><li>contain at least one digit</li><li>contain at least one lower case</li><li>contain at least one upper case</li><li>only aplphanumeric charachters</li><li>should be 6 to 16 charachters long</li></ul>";
  }

  jQuery("#password_message").stop().animate({height: "0px"},100,function(){
    jQuery("#password_message").animate({opacity: 0},100,function(){
      jQuery("#content").animate({height: content_height}, 500, function(){
        jQuery("#password_message").html(error_message + "</br>");
        new_heignt = parseInt(jQuery("#content").css('height')) + jQuery("#password_message")[0].scrollHeight  + "px";      
        jQuery("#content").animate({height: new_heignt}, 500, function(){
          set_sidebar_content_size();
          jQuery("#password_message").animate({height: jQuery("#password_message")[0].scrollHeight},100,function(){
            jQuery("#password_message").animate({opacity: 1}, 100);
          });
        });
      });
    });
  });    

  return false;
}