<%@ page import="java.util.*,java.io.*,java.net.*,java.text.*,kr.co.danal.jsinbi.*"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%
	response.setHeader("Pragma", "No-cache");
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="./css/style.css" type="text/css" rel="stylesheet" media="all" />
<title>*** 신용카드 결제요청 ***</title>
</head>
<%@ include file="inc/function.jsp"%>
<%@ include file="../card/common_card.jsp" %>
<body>
<%

	Box reqDanalCardCode = new Box();
	Box resDanalCardCode = new Box();
	
	reqDanalCardCode.put("col_nm","danal_card_cd");
	reqDanalCardCode.put("code1",CommonUtil.getDefaultStr(request.getParameter("bankcode"), ""));
	
	resDanalCardCode = CommonBiz.getFnNmCode1(reqDanalCardCode);

	/*[ 필수 데이터 ]***************************************/
	Map REQ_DATA = new HashMap();
	Map RES_DATA = null;

	/******************************************************
	 *  RETURNURL 	: CPCGI페이지의 Full URL을 넣어주세요
	 *  CANCELURL 	: BackURL페이지의 Full URL을 넣어주세요
	 ******************************************************/
	String ret = HttpUtils.getRequestURL(request).toString();
	String ret2 = ret.substring(0, ret.lastIndexOf("/"));
	
	String RETURNURL = ret2+"/cardRecive.jsp";
	//String CANCELURL = "http://localhost:8080/ipay/card/index_card.jsp";
	String CANCELURL = ret2+"/Cancel.jsp";

	/**************************************************
	 * SubCP 정보
	 **************************************************/
	REQ_DATA.put("SUBCPID", "");

	/**************************************************
	 * 결제 정보
	 **************************************************/
	REQ_DATA.put("AMOUNT", Amt);
	REQ_DATA.put("CURRENCY", "410");
	REQ_DATA.put("ITEMNAME", GoodsName);
	REQ_DATA.put("USERAGENT", "WP");
	REQ_DATA.put("ORDERID", Moid);
	REQ_DATA.put("OFFERPERIOD", "2015102920151129");

	/**************************************************
	 * 고객 정보
	 **************************************************/
	REQ_DATA.put("USERNAME", BuyerName); // 구매자 이름
	REQ_DATA.put("USERID", "infinisoft"); // 사용자 ID
	REQ_DATA.put("USEREMAIL", BuyerEmail); // 소보법 email수신처

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
	
	REQ_DATA.put("USERAGENT", "WP"); //매뉴얼 참고. WP는 PC환경이란 뜻
	REQ_DATA.put("USESKIPPAGE", "Y"); //다날 표준결제창 Skip = Y 로 보냄.
	
	if(request.getParameter("bankcode").equals("03")){
		REQ_DATA.put("CARDCODE", "0600"); //신한카드 창 띄움. 카드사코드는 매뉴얼 참고.
	}else{
		REQ_DATA.put("CARDCODE", resDanalCardCode.getString("fn_nm_code1", "")); //신한카드 창 띄움. 카드사코드는 매뉴얼 참고.
	}
	
	REQ_DATA.put("QUOTA", CommonUtil.getDefaultStr(request.getParameter("CardQuota"), "")); // 할부 개월 수 00, 02 ~ 12까지

	RES_DATA = CallCredit(REQ_DATA, false, CommonUtil.getDefaultStr(request.getParameter("Pg_Mid"), ""), CommonUtil.getDefaultStr(request.getParameter("PgLicenseKey"), ""));

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
<script Language="JavaScript">
		alert('<%=RETURNMSG%>');
		self.close();
</script>
<%
	}
%>
</form>
</body>
</html>


