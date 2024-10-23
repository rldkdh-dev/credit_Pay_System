<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Enumeration" %>
<%@ include file="errorCode.jsp" %>
<%
    response.setHeader("P3P", "CP='NOI CURa ADMa DEVa TAIa OUR DELa BUS IND PHY ONL UNI COM NAV INT DEM PRE'");

    request.setCharacterEncoding("EUC-KR");
    response.setHeader("cache-control","no-cache");
    response.setHeader("expires","-1");
    response.setHeader("pragma","no-cache");

    System.out.println("m_hagent02.jsp start----");
    
    String X_RESP = request.getParameter("X_RESP");
//    String X_MSG = request.getParameter("X_MSG");
    String X_MSG = getXMpiMsg(X_RESP);
    String X_XID = request.getParameter("X_XID");
    String X_ECI = request.getParameter("X_ECI");
    String X_CAVV = request.getParameter("X_CAVV"); 
    String X_CARDNO = request.getParameter("X_CARDNO"); 
    String X_JOINCODE = request.getParameter("X_JOINCODE"); 
  
    System.out.println("X_RESP ["+X_RESP+"]");
    System.out.println("X_MSG ["+X_MSG+"]");
    System.out.println("X_XID ["+X_XID+"]");
    System.out.println("X_ECI ["+X_ECI+"]");
    System.out.println("X_CAVV ["+X_CAVV+"]");
    System.out.println("X_CARDNO ["+X_CARDNO+"]");
    System.out.println("X_JOINCODE ["+X_JOINCODE+"]");
%>
<html>
<head>
<title>안심클릭 서비스 진행중</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<style type="text/css">
<!--
BODY {  font-size: 9pt; line-height: 140%; text-decoration: none}
-->
</style>
<script type="text/javascript">
    function setCertResult() {
        var r0           = '<%=X_RESP%>'; 
        var msg          = '<%=X_MSG%>'; 
        var xid          = '<%=X_XID%>'; 
        var eci          = '<%=X_ECI%>'; 
        var cavv         = '<%=X_CAVV%>'; 
        var cardno       = '<%=X_CARDNO%>'; 
        var joinCode     = '<%=X_JOINCODE%>';
        
        parent.postMessage("setCertResult('"+r0+"','"+msg+"','"+xid+"','"+eci+"','"+cavv+"','"+cardno+"','"+joinCode+"','')", "*");
   
    }
</script>
</head>
<body onload="setCertResult();">
카드사로 부터 받은 인증 결과 받아 처리중입니다.
<br>잠시만 기다리시기 바랍니다.
</body>
</html>