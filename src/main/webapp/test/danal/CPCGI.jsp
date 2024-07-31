<%@ page import="java.util.*,java.io.*,java.net.*,java.text.*,kr.co.danal.jsinbi.*"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%
	response.setHeader("Pragma", "No-cache");
	request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="./css/style.css" type="text/css" rel="stylesheet"
	media="all" />
<title>*** �ſ�ī����� ���ο�û ������ ***</title>
</head>
<%@ include file="inc/function.jsp"%>
<body>
<%
	String RES_STR = toDecrypt((String) request.getParameter("RETURNPARAMS"));
	Map retMap = str2data(RES_STR);
	
	System.out.println("RES_STR [" + RES_STR + "]");

	String returnCode = (String) retMap.get("RETURNCODE");
	String returnMsg = (String) retMap.get("RETURNMSG");

	//*****  �ſ�ī�� ������� Ȯ�� *****************
	if (returnCode == null || !"0000".equals(returnCode)) {
		// returnCode�� ���ų� �Ǵ� �� ����� ������ �ƴ϶�� ���� ó��
		System.out.println("Authentication failed. " + returnMsg + "[" + returnCode + "]");
		return;
	}

	/*[ �ʼ� ������ ]***************************************/
	Map REQ_DATA = new HashMap();
	Map RES_DATA = new HashMap();

	/**************************************************
	 * ���� ����
	 **************************************************/
	REQ_DATA.put("TID", (String) retMap.get("TID"));
	REQ_DATA.put("AMOUNT", TEST_AMOUNT); // ���� ������û(AUTH)�ÿ� ���´� �ݾװ� ������ �ݾ��� ����

	/**************************************************
	 * �⺻ ����
	 **************************************************/
	REQ_DATA.put("TXTYPE", "BILL");
	REQ_DATA.put("SERVICETYPE", "DANALCARD");

	RES_DATA = CallCredit(REQ_DATA, false);
	
	System.out.println("RES_DATA [" + RES_DATA + "]");

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
<%@ include file="Error.jsp"%>
<%
	}
%>
</form>
</body>
</html>