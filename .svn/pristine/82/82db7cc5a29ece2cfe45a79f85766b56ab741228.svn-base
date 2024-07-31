$(document).ready(function(){
  //a링크 스크롤이동 막기
  $('a[href="#"]').click(function(event) {
    event.preventDefault();      
  });

  //input focus
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

  /*popup 중앙위치하기*/
  jQuery.fn.center = function(){
  var p_width = this.width();
  var p_height = this.height();
  this.css("top", ($(window).height() / 2 ) - ( p_height / 2));
  this.css("left", ($(window).width() / 2 ) - ( p_width / 2));
  return this;
  };
  $(".error_notice .popup_cont").center();

  $(window).resize(function(){
    $(".error_notice .popup_cont").center();
  });
});


