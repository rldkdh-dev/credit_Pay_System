$(document).ready(function(){

  if (window.matchMedia("(min-device-width: 737px)").matches) {/*desk top*/

    /*popup 중앙위치하기*/
    jQuery.fn.center = function(){
    var p_width = this.width();
    var p_height = this.height();
    this.css("top", ($(window).height() / 2 ) - ( p_height / 2));
    this.css("left", ($(window).width() / 2 ) - ( p_width / 2));
    return this;
    };
    $(".popup").center(); //201811

  } else {/*Mobile*/

    //스크롤영역 높이
    var popup_scroll_height = function() {
      return window.innerHeight - 91;
    };
    $('.popup_scroll').css('height', popup_scroll_height());

    //스크롤영역 높이
    var popup_iframe_height = function() {
      return window.innerHeight - 196;
    };
    $('.popup_scroll iframe').css('height', popup_iframe_height());

    //모바일 input 타입변경
    function inputSecurity(){
        $('.security').attr('type','number');  
    };
    inputSecurity();
    
    function onResizeCall(){
        window.innerHeight.refresh;
        popup_scroll_height.refresh;
        $('.popup_scroll').css('height', popup_scroll_height());
        $(".popup").center();
    };

    $(window).resize(function(){ 
      onResizeCall();
    });  

    };/*matchMedia 모바일 END**************************************************************************************************************/
  
    $(function() {
    	$('.payment_input .bank_list a').click(function() {  //간편결제 선택시 효과 함수
    		if ( ($(this).children('p').attr('class') == "bank_more") || ($(this).attr('onclick') == "javascript:noService()") ) {
    		} else {
    			$('.payment_input .bank_list a').removeClass('on');
    		    $(this).addClass('on');
    		}
    	});
    });
    $(function() {
    	$('.payment_input .simple_pay_list a').click(function() {
    		if ( ($(this).children('p').attr('class') == "card_more") || ($(this).attr('onclick') == "javascript:noService()") ) {
    		} else {
    			$('.payment_input .simple_pay_list a').removeClass('on');
    		    $(this).addClass('on');
    		}
    	});
    });
  /*약관동의 popup 동작*/
  $(".popup_terms").click(function(){
    var popup_class = $(this).attr('data');
    $(popup_class).css('display','block');
    $(popup_class).find('.pop_dim').css('opacity','0');
    $(popup_class).find('.pop_dim').animate({opacity: '0.7'}, 500);
    scroll_disable();/*201811*/
  });

  /*popup btn 201811*/
  $(".popup_btn").click(function(){
    var popup_class = $(this).attr('data');
    $(popup_class).css('display','block');
    $(popup_class).find('.pop_dim').css('opacity','0');
    $(popup_class).find('.pop_dim').animate({opacity: '0.7'}, 500);
    scroll_disable();/*201811*/
  });
    
  $(".btn_close").click(function(){
    $(".float_wrap").css("display","none");
    $(".dim").css("display","none");
    scroll_enable();/*201811*/
  });



  //a링크 스크롤이동 막기
  $('a[href="#"]').click(function(event) {
    event.preventDefault();      
  });


  //input effect
  $('.input_section').hover(
    function() {
      $(this).css("border-color","#6e91d2");
    },
    function() {
      if($(this).find('input').is(":focus")){
        $(this).css("border-color","#6e91d2");
      }else if($(this).find('select').is(":focus")){
        $(this).css("border-color","#6e91d2");
      }else{
        $(this).css("border-color","#ddd");
      };
    }
  );

  /*popup 중앙위치하기*/  
  jQuery.fn.center = function(){
    var p_width = this.width();
    var p_height = this.height();
    this.css("top", ($(window).height() / 2 ) - ( p_height / 2));
    this.css("left", ($(window).width() / 2 ) - ( p_width / 2));
    return this;
  };
  $(".card_pay").center();
  $(window).resize(function() {
    $(".card_pay").center();
  });
  $(".popup_notice .text").center();
  $(window).resize(function() {
    $(".popup_notice .text").center();
  });
   $(".card_etc").center();
  $(window).resize(function() {
    $(".card_etc").center();
  });


  /*input 포커스*/
  $('input').on('focus',function() {
    $(this).parents(".input_section").css("border-color","#6e91d2");
  });
  $('input').on('blur',function() {
    $(this).parents(".input_section").css("border-color","#ddd");
  });
  $('select').on('focus',function() {
    $(this).parents(".input_section").css("border-color","#6e91d2");
  });
  $('select').on('blur',function() {
    $(this).parents(".input_section").css("border-color","#ddd");
  });

  //약관동의 check 201811
  $(".terms .all_check").click(function(){
    if($(this).find('input[type=checkbox]').prop("checked")) {
      $(this).siblings('ul').find('input[type=checkbox]').prop("checked",true);
      $(this).parents('.terms').find('ul').addClass('off');
    } else {
      $(".terms input[type=checkbox]").prop("checked",false);
      $(this).parents('.terms').find('ul').removeClass('off');
    };  
  });
  $(".terms ul .checks").click(function(){
    var group = $(this).parents('ul'); 
    var check_li = group.find('input[type=checkbox]');
    var check_total = check_li.length;
    var checked_total = group.find('input:checked').length;
    if(check_total==checked_total) {
      $(this).parents('ul').siblings(".terms .all_check").find('input[type=checkbox]').prop("checked",true);
      $(this).parents('.terms').find('ul').addClass('off');
    } else {
      $(this).parents('ul').siblings(".terms .all_check").find('input[type=checkbox]').prop("checked",false);
      $(this).parents('.terms').find('ul').removeClass('off');
    };  
  }); 
  $(".terms ul .terms_li_show").click(function(){
    $(this).parents('.terms').find('ul').removeClass('off');
  });

/*기타카드사 popup 열기*/
  var card_frame_on = function(){
    $(".card_frame").css('display','block');
    $(".card_frame").find('.pop_dim').css('opacity','0');
    $(".card_frame").find('.pop_dim').animate({opacity: '0.7'}, 500);
    $(".card_etc").center();
    scroll_disable();/*201811*/
  };
  $(".card_more").click(function(){
    card_frame_on();
  });

  /*카드사 popup 열기*/
  $(".install_notice_btn").click(function(){
    goNext();
  });


/*기타은행 popup 열기*/
  var bank_frame_on = function(){
    $(".bank_frame").css('display','block');
    $(".bank_frame").find('.pop_dim').css('opacity','0');
    $(".bank_frame").find('.pop_dim').animate({opacity: '0.7'}, 500);
    $(".bank_etc").center();
    scroll_disable();/*201811*/
  };
  $(".bank_more").click(function(){
    bank_frame_on();
  });

  //input 포커스이동
  function customInput(el){
    $('.'+el+' input').on('change keydown keyup',function(e){
    
    var max_length = $('input:focus').attr('maxLength'),
        $focused = $('.'+el+' :focus'),
        key = e.keyCode || e.charCode,
        count = 0;
    
    if(key == 8 && $focused.prev().val() != '' && $focused.val() == '' || key == 46 && $focused.prev().val() != '' && $focused.val() == '' ){
        $focused.prev().focus();
       }

    if($focused){
     
      setTimeout(function(){
        if($focused.val().length == max_length && $focused.next().val().length != max_length){
          $focused.next().focus();
          $('#'+el).attr('id','');
          $focused.next().attr('id',el);
          max_length.refresh;
        }
      },300);
    };
  });
  };

  customInput('phone_num');
  customInput('biz_num');
  customInput('phone_num_r');
  customInput('personal_num');
  customInput('card_num');


  //select input 선택

  /*function showInput(el){
    $('.'+el+' select').change(function(e){
    
    var showClass = $(this).val(),
        allClass = showClass.slice(0,2);
            
        $('.'+allClass).hide();
        $('.'+showClass).css('display','inline-table');

        if(showClass == 's3_2'){
          $('.s3_2').find('select').find("option:eq(0)").prop("selected", true);
        };

    });
  };
*/
//  showInput('select3');

//radio show hide

  function showInput(el){
    $('.'+el+' input').change(function(e){
    
    var showClass = $(this).val(),
        allClass = showClass.slice(0,3);
            
       $('.'+allClass).hide();
        $('.'+showClass).css('display','block');

    });
  };

  showInput('select_sh1');

/*공지사항 슬라이드*/
$('.system_notice').bxSlider({
  slideWidth: 'auto',
  auto:true,
  speed: '500',
  wrapperClass: 'system_notice_wrap',
  infiniteLoop:true,
  useCSS:false,
  controls:false,
  pager:false,
  touchEnabled:false
});






});


//************************************* end document.ready




/*201811 스크롤& 스크롤 이동 막기*/
    var posY;
    var posY2;
    var scroll_disable = function(){
      posY = $(window).scrollTop();
      $("html, body").addClass("not_scroll");
      $(".innopay").css("top",-posY);
      posY2 = posY;
    };
    var scroll_enable = function(){
      $("html, body").removeClass("not_scroll");
      $(window).scrollTop(posY2);
    };
function error_notice_on(){
  window.open('auto_payment_error.html','_blank', 'toolbar=no,location=no,directories=no, status=no,menubar=no,scrollbars=no, resizable=no,width=600,height=600,top=0,left=0');
};

$(window).on("beforeunload",function(){
    if(opener&&opener!=this){
      try{
          var obj = opener.document.body;
          var _layer = opener.document.getElementById("infiniPopLayer");
          if(_layer!=null && _layer!=undefined) obj.removeChild(_layer);
      }catch(exception){
        
      }
    }
});

//이메일 주소 유효성 검사
function chkEmail(mail){
  var check = 1;
  var check1 = 1;
  var cont = 0;
  var c;
  if( mail == "" ) return true;
    
  c = mail.charAt(0);
  if( !( (c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || (c == '-') ) ){
    return false;
  }
  
  c = mail.charAt(mail.length-1 );
  if( !( (c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z')) ){
    return false;
  }
            
  for(var i=1; i<mail.length; i++){
    c = mail.charAt(i);     
    if( !((c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z')) ){
      if(c == '.' || c == '-' || c == '_' ){
        if(cont==1){
          return false;
        }else{
          check++ ;
        }
      }else if( c == '@'){
        if( check1 == 5 ){
          return false;
        }else{
          check1 =5;
          cont=1;
        }
      }else{
        return false;
      }
    }else{
      cont = 0;
    }
  }

  if( check == 1 ||  check1 == 1){
    return false;
  }
  return true;
}

function cellNumCheck(number){
  var val = number.substring(0 , 3);
  if(val == "010" || val == "011" || val == "016" || val == "017" || val == "018" || val == "019" ){ 
    return true;
  }else return false;
 }

function isJuminNo(juminNo1, juminNo2) {
  var f1 = juminNo1.substring(0, 1);
  var f2 = juminNo1.substring(1, 2);
  var f3 = juminNo1.substring(2, 3);
  var f4 = juminNo1.substring(3, 4);
  var f5 = juminNo1.substring(4, 5);
  var f6 = juminNo1.substring(5, 6);  
  
  var l1 = juminNo2.substring(0, 1);
  var l2 = juminNo2.substring(1, 2);
  var l3 = juminNo2.substring(2, 3);
  var l4 = juminNo2.substring(3, 4);
  var l5 = juminNo2.substring(4, 5);
  var l6 = juminNo2.substring(5, 6);
  var l7 = juminNo2.substring(6, 7);
  
  var sum = f1 * 2 + f2 * 3 + f3 * 4 + f4 * 5 + f5 * 6 + f6 * 7;
  sum = sum + l1 * 8 + l2 * 9 + l3 * 2 + l4 * 3 + l5 * 4 + l6 * 5;
  sum = sum % 11;
  sum = 11 - sum;
  sum = sum % 10;
  
  if (sum != l7) {return false;}
  
  return true;
}

function isBusiNoByValue(strNo) { 
  var sum = 0;
  var getlist =new Array(10);
  var chkvalue =new Array('1','3','7','1','3','7','1','3','5'); 

  for(var i = 0; i < 10; i++){
    getlist[i] = strNo.substring(i, i+1); 
  }
  for(var i = 0; i < 9; i++) {
    sum += getlist[i]*chkvalue[i];
  }

  sum = sum + parseInt((getlist[8]*5)/10); 
  sidliy = sum%10;
  sidchk = 0;

  if(sidliy != 0){
    sidchk = 10 - sidliy; 
  }else{
    sidchk = 0; 
  }
  if(sidchk != getlist[9]) return false;
  
  return true;
}


 