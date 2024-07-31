$(document).ready(function(){


//a링크 스크롤이동 막기
  $('a[href="#"]').click(function(event) {
    event.preventDefault();      
  });


 $('.table').DataTable({
 	fixedHeader: true,
 	paging: false,
 	"dom": '<"top"if>rt<"clear">'
 });

 /*$(".col-sm-12").mCustomScrollbar({
 	scrollbarPosition:"inside",
 	theme:"dark",
 	axis:"x"
 });*/

var menu = document.querySelector('.sticky')
var menuPosition = menu.getBoundingClientRect().top;
window.addEventListener('scroll', function() {
    if (window.pageYOffset >= menuPosition) {
        menu.style.position = 'fixed';
        menu.style.top = '0px';
        menu.style.left = '0px';
    } else {
        menu.style.position = 'static';
        menu.style.top = '';
        menu.style.left = '';
    }
});

});