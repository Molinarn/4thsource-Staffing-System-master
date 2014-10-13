;(function($) {
  $(function() {
    $('#btn-question').bind('click', function(e) {
      e.preventDefault();
      $('#add-question').bPopup({
        transition: 'slideIn',
        transitionClose: 'slideDown',
        speed: 500
      });
    });
    $('#close-popup').bind('click', function(e) {
      e.preventDefault();
      $('#add-question').bPopup().close();
    });
  });
})(jQuery);

function checkMaxlength(object) {
  var iMaxLen = parseInt(object.getAttribute('maxlength'));
  var iCurLen = object.value.length;

  if(object.getAttribute && iCurLen > iMaxLen) {
    object.value = object.value.substring(0, iMaxLen);
  }
}


