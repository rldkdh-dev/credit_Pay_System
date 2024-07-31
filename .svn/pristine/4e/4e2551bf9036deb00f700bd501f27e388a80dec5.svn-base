<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 에러페이지
*	@ PROGRAM NAME		: error.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2018.01.02
*	@ PROGRAM CONTENTS	: 에러페이지
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*******************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page isErrorPage="true"%>
<%@ page import="java.io.*,util.CommonUtil" %>
<%@ page import="kr.co.infinisoft.web.exception.ExceptionMessage" %>
<%
String msg = "";
String traceInfo = "";
String msgCode = "";
String exceptionMessage = "";
String FORWARD	    	= CommonUtil.getDefaultStr(request.getParameter("FORWARD"), "Y");
String RefererURL    	= CommonUtil.getDefaultStr(request.getParameter("RefererURL"), "");

if( exception != null ) {
	
	msg = exception.getMessage();
	   
	ByteArrayOutputStream osbyte = new ByteArrayOutputStream();
	PrintStream ps = new PrintStream(osbyte);
	exception.printStackTrace(ps);
	traceInfo = osbyte.toString();
	ps.close();
	osbyte.close();
}
if(msg != null) {
	msgCode = msg.substring(msg.lastIndexOf(":") + 1);

	exceptionMessage = ExceptionMessage.getInstance().getExceptionMessage(msgCode.trim());
}
%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="/ipay/css/jquery.mCustomScrollbar.css" />
        <link rel="stylesheet" type="text/css" href="/ipay/css/common.css" />
        <link href='/ipay/css/font.css' rel='stylesheet' type='text/css'>
        <link rel="shortcut icon" href="/ipay/images/favicon.ico" type="image/x-icon">
        <link rel="icon" href="/ipay/images/favicon.ico" type="image/x-icon">
        <script type="text/javascript" src="/ipay/js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="/ipay/js/jquery.mCustomScrollbar.js"></script>
        <script type="text/javascript" src="/ipay/js/common.js"></script>
        <title>INNOPAYPG 결제서비스</title>
    <script type="text/javascript">
        $(document).ready(function(){
            $(".error_notice .popup_cont").center();
        });
        $(window).resize(function() {
            $(".error_notice .popup_cont").center();
        });
        function goClose(){
        	try{
        		if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
        			window.open('', '_self', '');
        		    window.close();
        		}else if((window.parent!=null&&window.parent!=undefined)||('X'=='<%=FORWARD%>')){
        			window.parent.postMessage('close','*');
        		}else{
        			window.location.href='<%=RefererURL%>';
        		}
        	}catch(e){}
        }
    </script>
        
    </head>
    <body>
        <div class="innopay">
            <section class="innopay_wrap">
                <section class="float_wrap error_notice">
                    <div class="popup_cont">
                        <img src="/ipay/images/i_error.png" alt="알림" width="69px" height="auto">
                        <p><%= exceptionMessage %></p>
                        <section class="btn_wrap_fl">
                            <div>
                                <a class="btn_blue btn" href="javascript:goClose()">확인</a>
                            </div>
                        </section>
                    </div>
                </section>
            </section>
        </div>
    </body>

</html>
