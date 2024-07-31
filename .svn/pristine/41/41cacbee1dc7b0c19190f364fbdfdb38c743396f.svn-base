<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
// Cache 의존 제거
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>INNOPAY 전자결제서비스</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<link type="text/css" media="screen" rel="stylesheet" href="../../css/common.css">
<script type="text/javascript" src="../../js/isp_mobile.js" charset="UTF-8"></script>
<script type="text/javascript">
    if("IPHONE" === OScheck()) {
        parent.callIOSAppScheme('<%=request.getParameter("TID")%>');
    }
    else {
        parent.callAppScheme('<%=request.getParameter("TID")%>');
    }
</script>
</head>
<body>

</body>
</html>