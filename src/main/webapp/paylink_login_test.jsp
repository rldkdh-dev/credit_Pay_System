<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress" %>
<%
InetAddress inet = InetAddress.getLocalHost();
String ActionUrl = "https://admin.innopay.co.kr";    
// For TEST
ActionUrl = "http://localhost:8080";
//ActionUrl = "http://117.52.91.132:8181";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>페이링크 로그인 테스트</title>
<script type="text/javascript">
    function loginProc(){
    	var frm = document.loginform;
        var user_id = '';
        var pass = '';
        user_id = encode64(frm.MerID.value);
        pass = encode64(frm.MerPass.value);
        frm.userID.value = user_id;
        frm.passwd.value = pass;
        frm.submit();
    }
</script>
</head>
<body>
<form name="loginform" action="<%=ActionUrl%>/mer/PayLinkLoginProc.do" method="post">
    <table width="400" border="1" cellspacing="0" cellpadding="3">
        <tr><td>User ID</td>
            <td><input type="text" name="MerID" value="" maxlength="20" style="width:200px"></td>
        </tr>
        <tr><td>Password</td>
            <td><input type="password" name="MerPass" value="" maxlength="20" style="width:200px"></td>
        </tr>
        <tr><td colspan="2" align="center"><input type="button" name="btn" value="가맹점 로그인" onclick="loginProc()"></td>
        </tr>
    </table>
    <input type="hidden" name="userID" value="">
    <input type="hidden" name="passwd" value="">
</form>
</body>
</html>