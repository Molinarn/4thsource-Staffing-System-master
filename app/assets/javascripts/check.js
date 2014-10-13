$(function(){
    var input = $("input[class^='id']"),
        check = $("#approved_flag_all");
    
    check.on("change", function(){
        if($(this).is(":checked")){
            checkAll(true);
        }else{
            checkAll(false);
        }
    });
    
    input.on("change", function(){
        var checkedBoxes = 0;
        input.each(function(){
            if($(this).is(":checked")){
                checkedBoxes++;
            }
        });
        if(checkedBoxes < input.length){
            check.prop("checked", false);
        }else if(checkedBoxes == input.length){
            check.prop("checked", true);
        }
    });
    
    function checkAll(isOn){
        input.each(function(index){
            var $this = $(this);
            if(isOn){
                if(!$this.is(":checked")){
                    $this.prop("checked", true);
                }
            }else{
                if($this.is(":checked")){
                    $this.prop("checked", false);
                }
            }
        });
    }
});

