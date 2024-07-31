<%@ page import="java.util.*,java.io.*,java.net.*,java.text.*,kr.co.danal.jsinbi.*"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	response.setHeader("Pragma", "No-cache");
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="./css/style.css" type="text/css" rel="stylesheet"
	media="all" />
<title>*** 신용카드결제 승인요청 페이지 ***</title>
</head>
<%@ include file="inc/function.jsp"%>
<body>
<%
	String RES_STR = toDecrypt((String) request.getParameter("RETURNPARAMS"));
	Map retMap = str2data(RES_STR);

	String returnCode = (String) retMap.get("RETURNCODE");
	String returnMsg = (String) retMap.get("RETURNMSG");
	String AMOUNT = (String) retMap.get("AMOUNT");
	
	System.out.println("RES_STR ["+RES_STR+"]");

	//*****  신용카드 인증결과 확인 *****************
	if (returnCode == null || !"0000".equals(returnCode)) {
		// returnCode가 없거나 또는 그 결과가 성공이 아니라면 실패 처리
%>
		<script Language="JavaScript">
			//alert(opener.tranMgr.MID.value);
			alert('인증 도중 오류가 발생하였습니다.');
			self.close();
		</script>
<%
	}

	/*[ 필수 데이터 ]***************************************/
	Map REQ_DATA = new HashMap();
	Map RES_DATA = new HashMap();

	/**************************************************
	 * 결제 정보
	 **************************************************/
	REQ_DATA.put("TID", (String) retMap.get("TID"));
	REQ_DATA.put("AMOUNT", TEST_AMOUNT); // 최초 결제요청(AUTH)시에 보냈던 금액과 동일한 금액을 전송

	/**************************************************
	 * 기본 정보
	 **************************************************/
	REQ_DATA.put("TXTYPE", "BILL");
	REQ_DATA.put("SERVICETYPE", "DANALCARD");

	RES_DATA = CallCredit(REQ_DATA, false);
	
	System.out.println("RES_DATA==================="+RES_DATA);

	if ("0000".equals(RES_DATA.get("RETURNCODE"))) {
%>
<form name="form" ACTION="./Success.jsp" METHOD="POST">
	<input TYPE="HIDDEN" NAME="RETURNCODE" VALUE="<%=RES_DATA.get("RETURNCODE")%>">
	<input TYPE="HIDDEN" NAME="RETURNMSG" VALUE="<%=RES_DATA.get("RETURNMSG")%>">
</form>
<script Language="JavaScript">
	document.form.submit();
</script>
<%
	} else {
		String RETURNCODE = (String) RES_DATA.get("RETURNCODE");
		String RETURNMSG = (String) RES_DATA.get("RETURNMSG");
%>
<script Language="JavaScript">
		//alert(opener.tranMgr.MID.value);
		alert('<%=RETURNMSG%>');
		self.close();
</script>
<%
	}
%>
</form>
</body>
</html>