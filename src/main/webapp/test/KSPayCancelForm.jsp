<%------------------------------------------------------------------------------
 FILE NAME : KSPayCancelForm.jsp
 AUTHOR : kspay@ksnet.co.kr
 DATE : 2006/09/01
                                                         http:'www.kspay.co.kr
                                                         http:'www.ksnet.co.kr
                                  Copyright 2003 KSNET, Co. All rights reserved
-------------------------------------------------------------------------------%>
<%@ page contentType="text/html;charset=euc-kr" %>

<html>
<head>
<title>KSPay</title>
<meta http-equiv="Content-Type" content="text/html charset=euc-kr">
<style type="text/css">
	BODY{font-size:9pt line-height:160%}
	TD{font-size:9pt line-height:160%}
	A {color:blueline-height:160% background-color:#E0EFFE}
	INPUT{font-size:9pt}
	SELECT{font-size:9pt}
	.emp{background-color:#FDEAFE}
	.white{background-color:#FFFFFF color:black border:1x solid white font-size: 9pt}
</style>
</head>

<body onload="" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onFocus="" >
<form name=KSPayAuthForm method=post action="./KSPayCancelPost.jsp">
<!--기본-------------------------------------------------->
<table border=0 width=0>
<tr>
<td align=center>
<table width=280 cellspacing=0 cellpadding=0 border=0 bgcolor=#4F9AFF>
<tr>
<td>
<table width=100% cellspacing=1 cellpadding=2 border=0>
<tr bgcolor=#4F9AFF height=25>
<td align=left><font color="#FFFFFF">
KSPay 신용카드 취소
</font></td>
</tr>
<tr bgcolor=#FFFFFF>
<td valign=top>
<table width=100% cellspacing=0 cellpadding=2 border=0>
<tr>
<td align=left>
<table>
<tr>
	<td>결제유형 :</td>
	<td>
		<input type=hidden name="authty" value="1010">신용카드취소</option>
	</td>
</tr>
<tr>
	<td>상점아이디 :</td>
	<td>
		<input type="text" name="storeid" value="2999199999" maxlength="10">
	</td>
</tr>
<tr>
	<td>승인구분 :</td>
	<td>
		<input type=radio name="canc_type" value="0">신용카드전체취소</option>
		<input type=radio name="canc_type" value="3">신용카드부분취소</option>
	</td>
</tr>
<tr>
	<td>거래번호 :</td>
	<td>
		<input type=text name=trno size=15 maxlength=12 value="131382001951">
	</td>
</tr>

<tr>
	<td>취소금액 :</td>
	<td>
		<input type="text" name="canc_amt" value="1000" maxlength="9">
		</td>
</tr>
<tr>
	<td>취소일련번호(1~99) :</td>
	<td>
		<input type="text" name="canc_seq" value="1" size="2" maxlength="2">
	</td>
</tr>
<tr>
<td colspan=2 align=center>
		<input type=submit  value=" 취 소 ">
</tr>
</td>
</tr>
</table>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</table>
</form>
</body>
</html>