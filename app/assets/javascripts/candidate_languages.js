(function($){
 window.CandidateLanguage = {
     _init:function(){
      //console.log('here I am the one that you love');

     	var _this = this;
     	this.checkbox = $('#language_notinlist');
        this.input = $('#lang_name');
     	this.input.attr('size',20);
     	this.input.css('display','none');
     	this.checkbox.parent().append(this.input);
     	this.checkbox.click(function(){
     		var checkbox = $(this);
     	if(checkbox.is(':checked')){
     			_this.input.show();
			}else{
				_this.input.hide();
			}
     	});
     },
     start:function(){
            self = this;
            self._init(); 
      }
 };
})(jQuery);