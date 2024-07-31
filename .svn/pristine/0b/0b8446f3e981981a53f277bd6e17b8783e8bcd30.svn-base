<%@ page import="java.util.*,java.io.*,java.net.*,java.text.*,kr.co.danal.jsinbi.*"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	response.setHeader("Pragma", "No-cache");
	request.setCharacterEncoding("utf-8");
	
	System.out.println("DANAL RETURN PARAMS ["+request.getParameter("RETURNPARAMS")+"]");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="./css/style.css" type="text/css" rel="stylesheet"
	media="all" />
<title>*** 신용카드결제 승인요청 페이지 ***</title>
</head>
<body>

<script Language="JavaScript">
	self.close();
	opener.document.tranMgr.DanalParams.value = '<%=request.getParameter("RETURNPARAMS")%>';
	opener.document.tranMgr.action = "payConfirm_card.jsp";
	opener.document.tranMgr.target = opener.name;
	opener.document.tranMgr.cavv = '<%=request.getParameter("RETURNPARAMS")%>';
	opener.document.tranMgr.submit();
</script>
</body>
</html>