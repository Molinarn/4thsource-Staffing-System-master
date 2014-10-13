;$(document).ready(function() {
  
  var fButton = $("#follow_button");
  var msgDiv = $("#slidingDiv");

  fButton.click(function() {

    if(fButton.val() == 'Follow'){
      $.ajax({ 
        type: 'POST', 
        url: 'followings',  
        success: function(data) {
          msgDiv.html(data);
          msgDiv.show();
          fButton.text('Unfollow');
          fButton.val('Unfollow');
        }
      });
    } else {
      fButton.text('Follow');
      fButton.val('Follow');
      msgDiv.empty();
      $.ajax({ 
        type: 'POST', 
        url: 'unfollow',  
      });
    }
  });
});
