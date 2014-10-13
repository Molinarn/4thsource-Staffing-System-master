/*Thursday,Feb 20, 2014*/	
/*created to generate a new behavior in the _personal_info_edit.html.haml this new behavior is used to 
show the availability time when the checkbox inmediate is not checked */

(function($){
	window.Profile = {
		start: function(){
			var chBAvailabilityImmediate = $("#candidate_availability_Immediate"),  _this = this; //This is for the whole object
		       				
		    
		    _this.checkBoxes(chBAvailabilityImmediate,"#availabilityShowHide");
		    

			chBAvailabilityImmediate.click(function(){
				_this.checkBoxes($(this),"#availabilityShowHide");
			});
		
			
		},

		checkBoxes: function(checkBox, itemShowHide){
			if(checkBox.is(":checked")){
				$(itemShowHide).fadeOut();

			}
			else{
				$(itemShowHide).fadeIn();
			}
		}
	}
})(jQuery);