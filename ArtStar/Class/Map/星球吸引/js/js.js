window.onload = function () {
/*获取屏幕的高度*/
var heightH=$(window).height();
$('.beijing').css('height',heightH);

    var timer;

    var flag = true;

    $.ajax({
        headers:{
            "Content-type":"application/json",
        },
        url:"a207665u90.51mypc.cn:53274/user/filtratebycdn",
        type:"post",
        data:{
            "tokenCode":"5b8afd03-c0de-4584-ae20-9721fecb17ee541534929570919",
            "searchType":1,
            "longitude":40.222012,
            "distance":1000,
            "similarity":"0%",
            "ageMax":40,
            "ageMin":5,
            "sex":1,
            "query":{"page":1,"rows":20},
            "myLabelIds":[2]
        },
        success:function (data) {
            console.log(data);
        }

    });

    var upData = [
            {id:"0xfd23ffs",num:20,dis:"独自等待"},
            {id:"0xfd23ffd",num:91,dis:"牡丹"},
            {id:"0xfd23ffa",num:90,dis:"午后骄阳"},
            {id:"0xfd23ffb",num:98,dis:"屌丝"},
            {id:"0xfd23ffc",num:88,dis:"忘不掉"},
            {id:"0xfd23ffs",num:20,dis:"一般小女"},
            {id:"0xfd23ffd",num:92,dis:"芸儿Y头"},
            {id:"0xfd23ffa",num:99,dis:"蓝精灵"},
            {id:"0xfd23ffb",num:97,dis:"喵喵喵"},
            {id:"0xfd23ffc",num:88,dis:"周周"},
            {id:"0xfd23ffc",num:87,dis:"爱在何方"},
            {id:"0xfd23ffc",num:86,dis:"梦癌"},
            {id:"0xfd23ffc",num:85,dis:"迷梦初醒"},
            {id:"0xfd23ffc",num:84,dis:"烟花短暂却.."},
            {id:"0xfd23ffc",num:83,dis:"玛雅"},
            {id:"0xfd23ffc",num:82,dis:"够狠才女Ren"},
            {id:"0xfd23ffc",num:81,dis:"0o小月o0"},
            {id:"0xfd23ffc",num:80,dis:"90后小姐姐"},
            {id:"0xfd23ffc",num:79,dis:"! ! !"},
            {id:"0xfd23ffc",num:78,dis:"无聊"}
        ];

    initData(upData);// upData 你们传的数值,

    function initData(arr) {
        var string1 = arr;
        var max =   Math.max.apply(Math, string1.map(function(o) {return o.num}));
        var number1 = null;
        var data = "";
        var data2 = "";
        for(var i = 0; i < string1.length; i++){
            if(string1[i].num == max){
                number1 = string1[i];
                data2 = '<div class="gif2 step1 current" data-num=" '+number1.num+' " data-id = " '+ number1.id +' "  data-dis = " '+number1.dis+' "><img src="img/'+ random(1,12) +'.png" alt=""></div>';
            }
            // data +=  '<span class="img'+ random(1,16) +'"   "><img src="img/('+ random(4,12) +').png" alt=""></span>';
        }
        $(".ball").append(data2);
        // $(".ball").append(data);
    }

    function initData2(arr) {
        var string1 = arr;
        var max =   Math.max.apply(Math, string1.map(function(o) {return o.num}));
        var number1 = null;
        var data = "";



        for(var i = 0; i < string1.length; i++){
            if(string1[i].num == max){
                number1 = string1[i];
                data = '<div class="gif2 step1 current" data-num=" '+number1.num+' " data-id = " '+ number1.id +' "  data-dis = " '+number1.dis+' "><img src="img/'+ random(1,12) +'.png" alt=""></div>';
            }
        }
        $(".ball").append(data);

        if(flag){
            $(".gif2").css({"top":"64%","right":"50%"});
            flag = false;
        }else{
            $(".gif2").css({"top":"48%","right":"20%"});
            flag = true;
        }

    }

    function changeTab(){
        var nearby1 = $('.gif_1').offset().left;
        var nearby2 = $('.gif2').offset().left;

        var nums = $('.gif2').attr("data-num");
        var nearby3 = nearby2 - nearby1;
        if($('.gif2').offset().top > Math.ceil(heightH * 0.32)){
            $('.lightning').css({
                'top': '57%',
                'left': '23%',
                'width':'155px',
                'transform': 'rotate(50deg)'
            });
        }
        if($('.gif2').offset().top > Math.ceil(heightH * 0.32) && $('.gif2').offset().top < Math.floor(heightH * 0.64)){
            $('.lightning').css({
                'top': '49%',
                'left': '28%',
                'width':'120px',
                'transform': 'rotate(12deg)'
            });
        }
        if(nearby3<=120 && nearby3>=95 && nums>=90){ //满足匹配度高达90%出现闪电

             $('.lightning').css('display','block');
             setTimeout(function () {
                 $('.beijing_1').css('animation-play-state', 'paused'); //动画暂停
                 $('.popBox').slideDown();
                 clearInterval(timer);
            },800);
        }else{
            $('.lightning').css('display','none')
        }
    }

    $(".miss").on('click',function () {
        missClick(this);
    });

    /* 设置卡片内容 */
    $('.popBox .zzz .dis-name> h3').text($('.gif2').attr("data-dis"));
    $('.popBox .zzz .dis-name> span').text($('.gif2').attr("data-num")+"%匹配");

    function missClick(that) {
        $('.lightning').css('display','none');
        $('.popBox').slideUp();
        $('.beijing_1').css('animation-play-state', 'running'); //动画开始

        var _thisNum =parseInt( $(that).parent().prev().children(".dis-name").find(".similarity").text());

        $(".step1").attr("data-num",""+-_thisNum+"").removeClass("gif2");


        for (var i = upData.length-1; i>0; i--)
            if (upData[i].num==_thisNum)
                upData.splice(i,1);

        initData2(upData);

        timer=setInterval(changeTab,10);
        setTimeout(function () {
            $('.popBox .zzz .dis-name> h3').text($('.gif2').attr("data-dis"));
            $('.popBox .zzz .dis-name> span').text($('.gif2').attr("data-num")+"%匹配");
        },500)

    }

    function random(lower, upper) {
        return Math.floor(Math.random() * (upper - lower+1)) + lower;
    }
    timer=setInterval(changeTab,10);


    /*
    * 点击刷新图标 请求你们的API
    * success 回调函数 里调用initData 方法 传data参数
    * 
    * */

    $("#refresh").on('click',function () {
        var fl = confirm("试试换一批吗？");
        if(fl){
            $.ajax({
                headers:{
                    "Content-type":"application/json",
                },
                url:"**************",
                type:"post",
                data:{

                },
                success:function (data) {
                    initData(data);
                }
            })
        }else{
            return false;
        }

    })
};







