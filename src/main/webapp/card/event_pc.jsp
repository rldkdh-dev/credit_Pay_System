<%
/*****************************************************************************
*
*   @ SYSTEM NAME       : 무이자 페이지
*   @ PROGRAM NAME      : event_pc.jsp
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
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="mobile.DataModel"%>
<%@ page import="mobile.CardEvent"%>

<%
	String yyyymm = CommonUtil.getDefaultStr(request.getParameter("yyyymm"), "");
	String pg_cd = CommonUtil.getDefaultStr(request.getParameter("pg_cd"), "");
	String mid = CommonUtil.getDefaultStr(request.getParameter("mid"), "");
	String pay_method = CommonUtil.getDefaultStr(request.getParameter("pay_method"), "");
	
	String svc_prdt_cd = pay_method;//
	
	String join_type = CommonUtil.getDefaultStr(request.getParameter("join_type"), "");
%>

<style>

button {
    height: 30px;
    line-height: 28px;
    padding: 0 12px;
    border-radius: 2px;
    font-family: sans-serif;
    font-size: 12px;
    border-color: transparent;
    background: #888;
    color: #fff;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
    -webkit-transition: all 0.3s ease-in-out;
    -moz-transition: all 0.3s ease-in-out;
    -ms-transition: all 0.3s ease-in-out;
    -o-transition: all 0.3s ease-in-out;
    padding: 0 12px!important
}

</style>

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
			.wrap{max-width: 400px;padding: 30px 20px 30px;}
			h1{font-size: 16px; line-height: 16px; padding: 0; color: #222; text-align: center; font-weight: bold;width: 100%;margin-bottom: 20px;}
			iframe{border-top: 1px solid #888;}
		</style>
	</head>

	<body scroll=auto style="overflow-x:hidden">
		<section class="wrap">
			<h1>이달의 카드 무이자 이벤트 안내</h1>
			<iframe src="event.jsp?yyyymm=<%=yyyymm%>&pg_cd=<%=pg_cd%>&mid=<%=mid%>&svc_prdt_cd=<%=svc_prdt_cd%>&join_type=<%=join_type%>" width="360px" height="500px"></iframe>
		</section>
		<center>
		<button type="button" onclick="window.close();"><span>닫기</span></button>
		</center>
		<br><br>
	</body>

</html>