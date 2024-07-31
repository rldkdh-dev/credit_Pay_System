<%
/*****************************************************************************
*
*   @ SYSTEM NAME       : 무이자 페이지
*   @ PROGRAM NAME      : event.jsp
*   @ MAKER             : InnoPay PG
*   @ MAKE DATE         : 2018.01.29
*   @ PROGRAM CONTENTS  : 신용카드 무이자 페이지
*
******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%@ page import="kr.co.infinisoft.pg.common.*" %>
<%@ page import="util.CommonUtil, util.CardUtil, service.*, java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="mobile.DataModel"%>
<%@ page import="mobile.CardEvent"%>

<%
	String currentYM = new SimpleDateFormat("yyyyMM").format(new Date());

	String yyyymm = CommonUtil.getDefaultStr(request.getParameter("yyyymm"), currentYM);
	String pg_cd = CommonUtil.getDefaultStr(request.getParameter("pg_cd"), "");
	String mid = CommonUtil.getDefaultStr(request.getParameter("mid"), "");
	
	//경우1 기존( yyyymm , pg_cd 만 있을경우) 방식 유지 // yyyymm , pg_cd
	//경우2 기존(pg_cd만 있을경우 yyyymm은 그달로 컨버팅후 처리) 경우1로 로직타게 처리 // pg_cd
	//경우3 mid만 있을경우 mid에 해당하는 첫번째 pg를 선택하여 처리 // mid , yyyymm , pg_cd
	//경우4 mid만 있을경우 mid에 해당하는 pg_cd를 채워 yyyymm을 이번달로 지정후 처리 그후 경우3으로 // mid , pg_cd
	//경우5 mid만 있을경우 mid에 해당하는 첫번째 pg를 선택하여 처리 경우4로 // mid 
	//파라메터의 경우 paymethod도 받게 처리
	
	if(yyyymm.equals("")){
		out.println("<script>alert('필수값 오류[년월]');</script>");
		return;
	}
	
	if(yyyymm.length() != 6){
		out.println("<script>alert('필수값 오류[년월 사이즈]');</script>");
		return;
	}
	
	if(pg_cd.equals("")){
		out.println("<script>alert('필수값 오류[PG코드]');</script>");
		return;
	}
	
	if(pg_cd.length() != 2){
		out.println("<script>alert('필수값 오류[PG코드 사이즈]');</script>");
		return;
	}
	
	DataModel req = new DataModel();
	DataModel mainMap = new DataModel();
	req.put("yyyymm", yyyymm);
	req.put("pg_cd", pg_cd);
	
	int year = Integer.parseInt(yyyymm.substring(0,4));
    int month = Integer.parseInt(yyyymm.substring(4,6));
    int day = 1;
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
	Calendar cal = Calendar.getInstance();
	cal.set(year, month-1, day);
	
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	CardEvent cardEvent = new CardEvent();
	
	List<DataModel> eventList = new ArrayList<DataModel>();
	List<DataModel> cardList01 = new ArrayList<DataModel>();
	List<DataModel> cardList02 = new ArrayList<DataModel>();

	eventList = cardEvent.getCardEventMain(req);
	
	if(eventList.size() > 0){
		mainMap = (DataModel) eventList.get(0);
	}else{
		out.println("<script>alert('해당 년월 무이자 데이터 없음');</script>");
		return;
	}
	
	req.put("gubun", "01");
	cardList01 = cardEvent.getCardEventDetail(req);
	
	req.put("gubun", "02");
	cardList02 = cardEvent.getCardEventDetail(req);
	
%>

<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link href='https://cdn.rawgit.com/theeluwin/NotoSansKR-Hestia/master/stylesheets/NotoSansKR-Hestia.css' rel='stylesheet' type='text/css'>
		<title>카드무이자이벤트</title>
		<style type="text/css">
			/* reset */
			*{box-sizing: border-box;word-break: break-all;}
			body,p,h1,h2,h3,h4,h5,h6,ul,ol,li,.side_cate,dt,dd,table,th,td,form,fieldset,legend,input,textarea,button,blockquote{margin:0;padding:0; -webkit-text-size-adjust:none;word-break:keep-all; word-wrap:break-word;}
			body,table{font-size: 14px;font-family: 'Noto Sans Korean', sans-serif; color:#333;letter-spacing:0;}

			body{background:#fff;-webkit-text-size-adjust:none;letter-spacing:-0.02em;}
			fieldset,img,iframe,frame{border:0}

			legend,caption{overflow:hidden;position:absolute;font-size:0;line-height:0;visibility:hidden}
			h1,h2,h3,h4,h5,h6{font-size:1em}
			img{-webkit-tap-highlight-color: rgba(0,0,0,0);-webkit-tap-highlight-color: transparent;}
			img,input,textarea,fieldset{border:0 none;outline:none}
			ul,ol,dl,li,dt,dd{list-style:none;margin:0;padding:0;}
			em,address{font-style:normal}
			a{color:#373e40;text-decoration:none;outline: none;}
			a:link,a:visited,a:hover,a:active{text-decoration:none;outline: none;}
			strong{font-weight:bold}
			legend,hr,caption{display:none}
			table{border-spacing:0; text-align: center;}
			input,textarea,button,select,option{font-family: inherit; text-decoration: none;letter-spacing:-0.05em; outline: 0;-webkit-tap-highlight-color:transparent;}
			article,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section{display:block;}
			select{text-indent:5px;}
			ul{text-decoration:none;}
			figure{margin:0;padding:0;}

			/* layout */
			html {min-height:100%;-ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;background: #fff;font-weight: normal;}
			html::-webkit-scrollbar {width: 0;}
			.wrap{width: 100%;overflow: hidden;}
			.event_t{padding-top: 24px;}
			.event_t li{font-size: 13px; line-height: 16px; padding: 0 0 6px 0;color: #333; text-align: left;font-weight: 500;}
			.event_t li:last-child{padding: 0;}
			.info_set{margin-top: 24px;}
			h3{font-size: 14px; line-height: 20px; padding: 8px; background-color:#aaa;color: #fff; text-align: center; font-weight: bold;height: 36px;position: static;width: 100%;}
			.card_event{border: 1px solid #ddd; border-top: none;}
			.card_event li{width: 100%; border-bottom: 1px solid #eee;display: table;}
			.card_event li:last-child{border-bottom:none;}
			.card_event .title{font-size: 12px; line-height: 32px; padding: 10px 8px; background-color:#f5f6f7;color: #222; text-align: center; font-weight: 500;width: 100px;display: table-cell;vertical-align: middle;}
			.card_event .title img{width: 20px; height: auto;margin: 6px;float: left;}
			.card_event .title div{line-height: 32px;float: left;}
			.card_event .con{font-size: 12px; line-height: 16px; padding: 10px 12px; background-color:#fff;color: #333; text-align: left; font-weight: normal;display: table-cell;vertical-align: middle;}
			
			.card_event .con .t_remark{font-size: 11px; line-height: 15px; color: #2985db;padding-top:2px; }
			.remark{margin-top:6px;}
			.remark li{font-size: 11px; line-height: 15px; color: #999;padding:2px 0 0 8px;background:url(/ipay/images/card_event/dot.png) left center no-repeat;background-size: 2px 2px;}
			.caution{margin-top: 24px;}
			.caution h4{font-size: 14px; font-weight: 500; color:#3890e3;padding-left:20px;background:url(/ipay/images/card_event/caution.png) left 4px no-repeat;background-size: 14px 14px;margin-bottom: 6px;}
			.caution ul{background-color: #f8f7f5; padding: 16px;}
			.caution li{font-size: 12px; line-height: 16px; color: #666;padding:2px 0 0 8px;background:url(/ipay/images/card_event/dot.png) left center no-repeat;background-size: 2px 2px;}
		</style>
	</head>

	<body scroll=auto style="overflow-x:hidden">
		<section class="wrap">
			<ul class="event_t">
				<li>행사기간 : <%out.print(yyyymm.substring(0,4));%>.<%out.print(yyyymm.substring(4,6));%>.01 ~ <%out.print(yyyymm.substring(0,4));%>.<%out.print(yyyymm.substring(4,6));%>.<%=lastDay%></li>
				<li>행사내용 : <%=mainMap.getStrNull("event_content")%></li>
				<li>PG사 : <%=mainMap.getStrNull("pg_nm")%></li>
			</ul>
			<%if(cardList01.size() > 0){%>
				<div class="info_set">
					<h3>무이자 할부</h3>
					<ul class="card_event">
						<%
						for(DataModel map : cardList01) {
						%>
							<li>
								<div class="title">
									<img src="/ipay/images/card_event/0001_<%=map.getStrNull("card_cd")%>.png">
									<div><%=map.getStrNull("card_nm")%></div>
								</div>
								<div class="con">
									<p><%=map.getStrNull("card_month")%></p>
									<%if(!map.getStrNull("card_memo").equals("")){%>
									<p class="t_remark"><%=map.getStrNull("card_memo")%></p>
									<%} %>
								</div>
							</li>
						<%
						}
						%>
					</ul>
					<%
					if(!mainMap.getStrNull("memo").equals("")){
						
						String[] memo_values = mainMap.getStrNull("memo").split("\n");
						
					%>
					
						<ul class="remark">
							<%for(int i=0; i<memo_values.length; i++){%>
							<li><%out.print(memo_values[i]);%></li>
							<%}%>
						</ul> 
					
					<%}%>
				</div>
			<%}%>

			<%if(cardList02.size() > 0){%>
				<div class="info_set">
					<h3>부분무이자 할부 (슬림할부)</h3>
					<ul class="card_event">
						<%
						for(DataModel map : cardList02) {
						%>
							<li>
								<div class="title">
									<img src="/ipay/images/card_event/0001_<%=map.getStrNull("card_cd")%>.png">
									<div><%=map.getStrNull("card_nm")%></div>
								</div>
								<div class="con">
									<p><%=map.getStrNull("card_month")%></p>
									<%if(!map.getStrNull("card_memo").equals("")){%>
									<p class="t_remark"><%=map.getStrNull("card_memo")%></p>
									<%} %>
								</div>
							</li>
						<%
						}
						%>
					</ul>
					
					<%
					if(!mainMap.getStrNull("part_memo").equals("")){
						
						String[] part_memo_values = mainMap.getStrNull("part_memo").split("\n");
						
					%>
					
						<ul class="remark">
							<%for(int i=0; i<part_memo_values.length; i++){%>
							<li><%out.print(part_memo_values[i]);%></li>
							<%}%>
						</ul> 
					
					<%}%>
				</div>
			<%}%>

			<%
			
			if(!mainMap.getStrNull("sub_memo").equals("")){
			
				String[] sub_memo_values = mainMap.getStrNull("sub_memo").split("\n");
				
				%>
				<div class="caution">
					<h4>유의사항</h4>
					<ul>
						<%for(int i=0; i<sub_memo_values.length; i++){%>
						<li><%out.print(sub_memo_values[i]);%></li>
						<%}%>
					</ul>
				</div>
			<%}%>
		</section>
		
		
	</body>

</html>