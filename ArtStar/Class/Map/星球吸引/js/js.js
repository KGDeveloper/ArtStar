window.onload = function () {
/*获取屏幕的高度*/
var heightH=$(window).height();
$('.beijing').css('height',heightH)

     var string1 = "90.33%"; //你们传的数值 
     var number1 = parseInt(string1)    //转换为数字类型

/* 获取附近的人的距离 */
    function changeTab(){
        var nearby1 = $('.gif_1').offset().left;
        var nearby2 = $('.gif2').offset().left;
        var timer;
        var nearby3 = nearby2 - nearby1;
            if(nearby3<=120 && nearby3>=95 && number1>=90){ //满足匹配度高达90%出现闪电
                $('.lightning').css('display','block')
            
            }else{
                $('.lightning').css('display','none')
            }

    }
    timer=setInterval(changeTab,10);
    
}




