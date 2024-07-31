<%
/*****************************************************************************
*
*   @ SYSTEM NAME       : 공지사항 페이지
*   @ PROGRAM NAME      : notice.jsp
*   @ MAKER             : InnoPay PG
*   @ MAKE DATE         : 2018.12.04
*   @ PROGRAM CONTENTS  : 공지사항 페이지
*
******************************************************************************/
%>
<style>
body,html{overflow:auto;}
</style>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="mobile.*, java.util.*"%>
<%
	Notice notice = new Notice();
	DataModel noticeReq = new DataModel();
	List<DataModel> noticeList = new ArrayList<DataModel>();
	
	noticeList = notice.getSubNoticeList(noticeReq);	
%>
<section class="system_notice popup_btn" data=".st_notice_popup">
	<%
		int strCnt = 0;
		if(noticeList.size() > 0){
			for(DataModel map : noticeList) {
	%>
				<p><%=map.getStrNull("sub_notice")%></p> <%strCnt += map.getStrNull("sub_notice").length(); %>
	<%
			}
		}else{
	%>
			<p>이노페이 전자결제 서비스를 이용해 주셔서 감사합니다.</p> <%strCnt += 30; %>
	<%
		}
	%>
</section>
<!--//popup system_notice-->
<section class="float_wrap st_notice_popup">
	<div class="pop_dim"></div>
	<div class="popup st_notice">
		<h3 class="popup_title">공지사항</h3>
		<a href="#" class="btn_close pop_close"></a>
		<div class="popup_cont">
			<div class="popup_scroll">
				<div class="popup_scroll_in">
					<ul>
						<%
							if(noticeList.size() > 0){
								for(DataModel map : noticeList) {
						%>
									<li><%=map.getStrNull("sub_notice")%></li>
						<%
								}
							}else{
						%>
								<li>이노페이 전자결제 서비스를 이용해 주셔서 감사합니다.</li>
						<%
							}
						%>
					</ul>
				</div>
			</div>
		</div>
		<div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>
	</div>
</section>
<!--//popup system_notice-->
<script>
/*공지사항 슬라이드*/
$('.system_notice').bxSlider({
  slideWidth: 'auto',
  ticker: true,
  speed: '<%=strCnt*285%>',
  wrapperClass: 'system_notice_wrap'
});
</script>
