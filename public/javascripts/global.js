jQuery(window).load(function() {

	// Easily selectable test within forms
	jQuery('input, textarea').click(function(){ jQuery(this).select(); });
	
	// remove divider from last nav button
	jQuery('#nav_full li:last-child a').css({ 'background' : 'none' });
	
	// Remove border from the last link within a subnav
	jQuery('#nav_full li ul li:last-child a').css({ 'border-bottom' : 'none' });
	
	// Nav dropdown
	jQuery('#nav_full li').hover(
		function() {
		jQuery(this).children('ul').stop(true, true).slideDown('fast');
	},
		function(){
		jQuery(this).children('ul').stop(true, true).hide();
	});
	
	// If subnav
	var subnav = jQuery('#nav_sub').attr('class');
	if (subnav == undefined) { jQuery('#if_sub_nav').addClass('hide'); jQuery('#if_subnav').addClass('hide'); }
	
	// Pull in the {site_url} variable so I can use it as a jquery variable
	var site_url = jQuery('div#site_url').attr('class');
	
	// Nav image buttons
	jQuery('#nav_full li').children('ul').children('li').children('a').parent('li').parent('ul').parent('li').children('a').append(' <img src="'+site_url+'/public/images/arrow-down.png" />');
	jQuery('#nav_full li').children('ul').children('li').children('ul').children('li').children('a').parent('li').parent('ul').parent('li').children('a').append(' <img src="'+site_url+'/public/images/arrow-down-hover.png" />');	
	
	/////////////////////////////////////////////////////////////
	// Conditional Column logic (holy shit this hurt my brain) //
	/////////////////////////////////////////////////////////////
	
	// Establish Column Variables
	var content_length = jQuery('#content').height();
	var sidebar_length = jQuery('#sidebar').height();
	// if the height of the content is more than the sidebar,
	// keep the sidebar content, and extend it's width to match
	if (content_length > sidebar_length) {
		jQuery('#sidebar').height(content_length);
	} else {
		// if it's not then remove the upcoming events
		// the nearshore list, and contact info
		jQuery('#nearshore_solutions').addClass('hide');
		jQuery('#upcoming_events').addClass('hide');
		jQuery('#sidebar_contact').addClass('hide');
		// reestablish variables
		var sidebar_length = jQuery('#sidebar').height();
		// after re-calculation, if the new sidebar is now larger 
		// extend the content area to match the sidebar
		if (content_length < sidebar_length) {
			jQuery('#content').height(sidebar_length);
		// if not then add just one module back, the events
		} else {
			jQuery('#upcoming_events').removeClass('hide');
			// recalculate again 
			var content_length = jQuery('#content').height();
			var sidebar_length = jQuery('#sidebar').height();
			// if after adding the events back, the sidebar 
			// is larger again, then forget it
			if (content_length < sidebar_length) {
				jQuery('#upcoming_events').addClass('hide');
				jQuery('#sidebar').height(content_length);
			} else {
			// if it is not larger, then add it successfully
				jQuery('#sidebar').height(content_length);
			}
		}
	}
	
	// opacity hover to all images located in links
	jQuery('a img').hover(
		function(){ jQuery(this).stop(true, true).animate({ opacity : .5 }, 250); }, 
		function(){ jQuery(this).stop(true, true).animate({ opacity : 1 }, 250);
	});
	
	// sitemap in footer to be dynamic but also three divided columns
	jQuery("#sitemap > li").slice(0,2).wrapAll('<div class="column three first" />');
	jQuery("#sitemap > li").slice(0,2).wrapAll('<div class="column three" />');
	jQuery("#sitemap > li").slice(0,4).wrapAll('<div class="column three last" />');

});