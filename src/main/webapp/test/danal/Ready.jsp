<%@ page import="java.util.*,java.io.*,java.net.*,java.text.*,kr.co.danal.jsinbi.*"%>
<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%
	response.setHeader("Pragma", "No-cache");
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="./css/style.css" type="text/css" rel="stylesheet" media="all" />
<title>*** 신용카드 결제요청 ***</title>
</head>
<%@ include file="inc/function.jsp"%>
<body>
<%
	/*[ 필수 데이터 ]***************************************/
	Map REQ_DATA = new HashMap();
	Map RES_DATA = null;

	/******************************************************
	 *  RETURNURL 	: CPCGI페이지의 Full URL을 넣어주세요
	 *  CANCELURL 	: BackURL페이지의 Full URL을 넣어주세요
	 ******************************************************/
	String RETURNURL = "http://localhost:8080/ipay/test/danal/CPCGI.jsp";
	String CANCELURL = "http://localhost:8080/ipay/test/danal/Cancel.jsp";

	/**************************************************
	 * SubCP 정보
	 **************************************************/
	REQ_DATA.put("SUBCPID", "");

	/**************************************************
	 * 결제 정보
	 **************************************************/
	REQ_DATA.put("AMOUNT", TEST_AMOUNT);
	REQ_DATA.put("CURRENCY", "410");
	REQ_DATA.put("ITEMNAME", (String) request.getParameter("itemname"));
	REQ_DATA.put("USERAGENT", (String) request.getParameter("useragent"));
	REQ_DATA.put("ORDERID", (String) request.getParameter("orderid"));
	REQ_DATA.put("OFFERPERIOD", "2015102920151129");

	/**************************************************
	 * 고객 정보
	 **************************************************/
	REQ_DATA.put("USERNAME", (String) request.getParameter("username")); // 구매자 이름
	REQ_DATA.put("USERID", (String) request.getParameter("userid")); // 사용자 ID
	REQ_DATA.put("USEREMAIL", (String) request.getParameter("useremail")); // 소보법 email수신처

	/**************************************************
	 * URL 정보
	 **************************************************/
	REQ_DATA.put("CANCELURL", CANCELURL);
	REQ_DATA.put("RETURNURL", RETURNURL);

	/**************************************************
	 * 기본 정보
	 **************************************************/
	REQ_DATA.put("TXTYPE", "AUTH");
	REQ_DATA.put("SERVICETYPE", "DANALCARD");
	REQ_DATA.put("ISNOTI", "N");
	REQ_DATA.put("BYPASSVALUE", "this=is;a=test;bypass=value"); // BILL응답 또는 Noti에서 돌려받을 값. '&'를 사용할 경우 값이 잘리게되므로 유의.
	
	/* REQ_DATA.put("USERAGENT", "WP"); //매뉴얼 참고. WP는 PC환경이란 뜻
	REQ_DATA.put("USESKIPPAGE", "Y"); //다날 표준결제창 Skip = Y 로 보냄.
	REQ_DATA.put("CARDCODE", "0200"); //신한카드 창 띄움. 카드사코드는 매뉴얼 참고.
	REQ_DATA.put("QUOTA", "00"); // 할부 개월 수 00, 02 ~ 12까지 */

	RES_DATA = CallCredit(REQ_DATA, false);

	if ("0000".equals(RES_DATA.get("RETURNCODE"))) {
%>
<form name="form" ACTION="<%=RES_DATA.get("STARTURL")%>" METHOD="POST">
	<input TYPE="HIDDEN" NAME="STARTPARAMS" VALUE="<%=RES_DATA.get("STARTPARAMS")%>"> 
</form>
<script>
	document.form.submit();
</script>
<%
	} else {
		String RETURNCODE = (String) RES_DATA.get("RETURNCODE");
		String RETURNMSG = (String) RES_DATA.get("RETURNMSG");
		String BackURL = "Javascript:self.close()";
%>
<%@ include file="Error.jsp"%>
<%
	}
%>
</form>
</body>
</html>


