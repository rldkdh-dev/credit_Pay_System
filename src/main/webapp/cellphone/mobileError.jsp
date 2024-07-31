<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ include file="../common/ipgwebCommon.jsp" %>
<%
String exceptionMessage = "";
// 상점에서 사용하는 파라미터
String PayMethod	= getDefaultStr(request.getParameter("PayMethod"), CommonConstants.PAY_METHOD_BANK);
String payType		= getDefaultStr(request.getParameter("payType"), "");
String GoodsCnt		= getDefaultStr(request.getParameter("GoodsCnt"), "");
String GoodsName	= getDefaultStr(request.getParameter("GoodsName"), "");
String GoodsURL		= getDefaultStr(request.getParameter("GoodsURL"), "");
String GoodsCl		= getDefaultStr(request.getParameter("GoodsCl"), "");
String Amt			= getDefaultStr(request.getParameter("Amt"), "");	
String Moid			= getDefaultStr(request.getParameter("Moid"), "");
String MID			= getDefaultStr(request.getParameter("MID"), "");
String TID			= getDefaultStr(request.getParameter("TID"), "");
String ReturnURL	= getDefaultStr(request.getParameter("ReturnURL"), "");
String ResultYN     = getDefaultStr(request.getParameter("ResultYN"), "");
String RetryURL		= getDefaultStr(request.getParameter("RetryURL"), "");
String mallUserID	= getDefaultStr(request.getParameter("mallUserID"), "");
String BuyerName	= getDefaultStr(request.getParameter("BuyerName"), "");
String BuyerAuthNum	= getDefaultStr(request.getParameter("BuyerAuthNum"), "");
String BuyerTel		= getDefaultStr(request.getParameter("BuyerTel"), "");
String BuyerEmail	= getDefaultStr(request.getParameter("BuyerEmail"), "");
String BuyerAddr	= getDefaultStr(request.getParameter("BuyerAddr"), "");
String BuyerPostNo	= getDefaultStr(request.getParameter("BuyerPostNo"), "");
String ParentEmail	= getDefaultStr(request.getParameter("ParentEmail"), "");
String UserIP		= getDefaultStr(request.getParameter("UserIP"), "");
String MallIP		= getDefaultStr(request.getParameter("MallIP"), "");
String BrowserType	= getDefaultStr(request.getParameter("BrowserType"), "");
String VbankExpDate = getDefaultStr(request.getParameter("VbankExpDate"), "");
String MallReserved = getDefaultStr(request.getParameter("MallReserved"), "");
String MallReserved1 = getDefaultStr(request.getParameter("MallReserved1"), "");
String MallReserved2 = getDefaultStr(request.getParameter("MallReserved2"), "");
String MallReserved3 = getDefaultStr(request.getParameter("MallReserved3"), "");
String MallReserved4 = getDefaultStr(request.getParameter("MallReserved4"), "");
String MallReserved5 = getDefaultStr(request.getParameter("MallReserved5"), "");
String MallReserved6 = getDefaultStr(request.getParameter("MallReserved6"), "");
String MallReserved7 = getDefaultStr(request.getParameter("MallReserved7"), "");
String MallReserved8 = getDefaultStr(request.getParameter("MallReserved8"), "");
String MallReserved9 = getDefaultStr(request.getParameter("MallReserved9"), "");
String MallReserved10 = getDefaultStr(request.getParameter("MallReserved10"), "");
String MallResultFWD = getDefaultStr(request.getParameter("MallResultFWD"), "");
String TransType = getDefaultStr(request.getParameter("TransType"), "");
String errorCode = getDefaultStr(request.getParameter("ErrorCode"), "");
String errorMsg = getDefaultStr(request.getParameter("ErrorMsg"), "");
String backURL = getDefaultStr(request.getParameter("BackURL"), "");
String SUB_ID = getDefaultStr(request.getParameter("SUB_ID"), "");

String Carrier = getDefaultStr(request.getParameter("Carrier"), "");
String ServerInfo = getDefaultStr(request.getParameter("ServerInfo"), "");

String DstAddr0 = getDefaultStr(request.getParameter("DstAddr0"), "");
String DstAddr1 = getDefaultStr(request.getParameter("DstAddr1"), "");
String DstAddr2 = getDefaultStr(request.getParameter("DstAddr2"), "");

String Iden0 = getDefaultStr(request.getParameter("Iden0"), "");
String Iden1 = getDefaultStr(request.getParameter("Iden1"), "");

String OTP = getDefaultStr(request.getParameter("OTP"), "");
String cap = getDefaultStr(request.getParameter("CAP"), "");
String buttonName = "";
%>

<html>
<head>
<title>:::에러가 발생했습니다.:::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/payment.css" rel="stylesheet" type="text/css">
<script language="javascript">
	function forwardPage(){

<%
   if(!backURL.equals("") && errorCode.equals("482")){
	   buttonName = "재시도";
%>
   document.errorMgr.Retry.value="Y";
   document.errorMgr.action = "<%=backURL%>";
   document.errorMgr.submit();
<%
   }else{
	   buttonName = "취소";
%>
   self.close();
<%
  }
%>
	}
</script>
</head>
<body onload="window.focus(); window.resizeTo(380, 315);" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
<form name="errorMgr" method="post">
<input type="hidden" name="PayMethod"       value="<%=PayMethod%>">
	<input type="hidden" name="TID"             value="<%=TID%>">
	<input type="hidden" name="payType"         value="<%=payType%>">
	<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>">
	<input type="hidden" name="GoodsName"       value="<%=GoodsName%>">
	<input type="hidden" name="GoodsURL"        value="<%=GoodsURL%>">
	<input type="hidden" name="GoodsCl"        value="<%=GoodsCl%>">
	<input type="hidden" name="Amt"             value="<%=Amt%>">
	<input type="hidden" name="Moid"            value="<%=Moid%>">
	<input type="hidden" name="MID"             value="<%=MID%>">
	<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>">
	<input type="hidden" name="ResultYN"        value="<%=ResultYN%>">
	<input type="hidden" name="RetryURL"        value="<%=RetryURL%>">
	<input type="hidden" name="mallUserID"      value="<%=mallUserID%>">
	<input type="hidden" name="BuyerAuthNum"    value="<%=BuyerAuthNum%>">
	<input type="hidden" name="BuyerTel"        value="<%=BuyerTel%>">
	<input type="hidden" name="BuyerName"       value="<%=BuyerName%>">
	<input type="hidden" name="BuyerEmail"      value="<%=BuyerEmail%>">
	<input type="hidden" name="BuyerAddr"       value="<%=BuyerAddr%>">
	<input type="hidden" name="BuyerPostNo"     value="<%=BuyerPostNo%>">
	<input type="hidden" name="ParentEmail"     value="<%=ParentEmail%>">
	<input type="hidden" name="UserIP"          value="<%=UserIP%>">
	<input type="hidden" name="MallIP"          value="<%=MallIP%>">
	<input type="hidden" name="BrowserType"     value="<%=BrowserType%>">
	<input type="hidden" name="VbankExpDate"    value="<%=VbankExpDate%>">
	<input type="hidden" name="MallReserved"    value="<%=MallReserved%>">
	<input type="hidden" name="MallReserved1"   value="<%=MallReserved1%>">
	<input type="hidden" name="MallReserved2"   value="<%=MallReserved2%>">
	<input type="hidden" name="MallReserved3"   value="<%=MallReserved3%>">
	<input type="hidden" name="MallReserved4"   value="<%=MallReserved4%>">
	<input type="hidden" name="MallReserved5"   value="<%=MallReserved5%>">
	<input type="hidden" name="MallReserved6"   value="<%=MallReserved6%>">
	<input type="hidden" name="MallReserved7"   value="<%=MallReserved7%>">
	<input type="hidden" name="MallReserved8"   value="<%=MallReserved8%>">
	<input type="hidden" name="MallReserved9"   value="<%=MallReserved9%>">
	<input type="hidden" name="MallReserved10"  value="<%=MallReserved10%>">
	<input type="hidden" name="MallResultFWD"   value="<%=MallResultFWD%>">
	<input type="hidden" name="ErrorCode"       value="<%=errorCode%>">
	<input type="hidden" name="ErrorMsg"        value="<%=errorMsg%>">
	<input type="hidden" name="Carrier"        value="<%=Carrier%>">
	<input type="hidden" name="ServerInfo"        value="<%=ServerInfo%>">
	<input type=hidden name="TransType" value="<%=TransType%>">
	<input type="hidden" name="DstAddr0"        value="<%=DstAddr0%>">
	<input type="hidden" name="DstAddr1"        value="<%=DstAddr1%>">
	<input type="hidden" name="DstAddr2"        value="<%=DstAddr2%>">
	<input type="hidden" name="Iden0"        value="<%=Iden0%>">
	<input type="hidden" name="Iden1"        value="<%=Iden1%>">
	<input type="hidden" name="Retry"        value="">
	<input type="hidden" name="CAP"        value="<%=cap%>">
	<input type="hidden" name="SUB_ID"        value="<%=SUB_ID%>">
	
<table width="370" height="244" border="0" align="center" cellpadding="0" cellspacing="0" background="../images/Error_page.gif" >  
	<tr>
		<td width="350" height="180" valign="top">
			<table width="350" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr> 
					<td height="100">&nbsp;</td>
				</tr>
				<tr>
					<td width="20">&nbsp;</td>
					<td><%= errorMsg %>(<%= errorCode %>)</td>
					<td width="20">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr align="center">
		<td>
		  <input name="submit22224" type="button"  class="mmtnL02c" value="<%=buttonName%>" onclick="javascript:forwardPage()">
		</td>
	</tr>
</table>
</form>
</body>
</html>