(function($){
	window.Profile = {
		start: function(){
			var chBHasVisa = $("#candidate_has_visa"),
			    chBHasPassport = $("#candidate_has_passport"),
			    chBWillingToRelocate = $("#candidate_is_willing_to_relocate"),
			    chBCurrentlyEmployed = $("#candidate_currently_employed"),  _this = this; //This is for the whole object
		    
		    _this.checkBoxes(chBHasVisa,"#visaShowHide");
		    _this.checkBoxes(chBHasPassport,"#passportShowHide");
		    _this.checkBoxes(chBWillingToRelocate,"#relocateListShowHide");
		    _this.checkBoxes(chBCurrentlyEmployed,".employedShowHide");
		    

			chBHasVisa.click(function(){
				_this.checkBoxes($(this),"#visaShowHide");
			});

			chBHasPassport.click(function(){
				_this.checkBoxes($(this),"#passportShowHide");
			});

					chBWillingToRelocate.click(function(){
				_this.checkBoxes($(this),"#relocateListShowHide");
			});

			chBCurrentlyEmployed.click(function(){
				_this.checkBoxes($(this),".employedShowHide");
			});
		
			
		},

		checkBoxes: function(checkBox, itemShowHide){
			if(checkBox.is(":checked")){
				$(itemShowHide).fadeIn();

			}
			else{
				$(itemShowHide).fadeOut();
			}
		}
	}
})(jQuery);