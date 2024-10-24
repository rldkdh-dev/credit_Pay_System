<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.net.InetAddress"%>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%@page import="org.slf4j.LoggerFactory"%>
<%@ page import="java.util.*" %>
<%@page import="org.slf4j.Logger"%>
<%!
	static Logger logger = LoggerFactory.getLogger("appLink.jsp"); //slf4j를 위해
%>
<% 
	//상점 IP 셋팅 <MallIP 셋팅>
	InetAddress inet = InetAddress.getLocalHost();
	//String payActionUrl = "https://pg.innopay.co.kr";
	String payActionUrl = "http://172.16.10.211:8082";
	if (request.getServerPort() == 80 || request.getServerPort() == 443) {
		payActionUrl = request.getScheme() + "://" + request.getServerName();
	} else {
		payActionUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
	}
	Box box = null;
	Box resMerKeyBox = null;
	Box resMerchantInfo = null;
	
	request.setCharacterEncoding("UTF-8");
	String MID = request.getParameter("MID");
	String Moid = request.getParameter("Moid");
	String MerchantKey = request.getParameter("MerchantKey");
	String GoodsName = request.getParameter("GoodsName");
	String webview = request.getParameter("webview");
	String Amt = request.getParameter("Amt");
	String DutyFreeAmt = request.getParameter("DutyFreeAmt");
	String GoodsCnt = request.getParameter("GoodsCnt");
	String PayMethod = request.getParameter("PayMethod");
	String BuyerName = request.getParameter("BuyerName");
	String MallUserID = request.getParameter("MallUserID");
	String BuyerTel = request.getParameter("BuyerTel");
	String BuyerEmail = request.getParameter("BuyerEmail");
	String OfferingPeriod = request.getParameter("OfferingPeriod");
	
	String User_ID = request.getParameter("User_ID");
	String mallReserved = request.getParameter("mallReserved");
	
	if(mallReserved == null || mallReserved == "")
	 	mallReserved = request.getParameter("MallReserved");
	
	logger.info("appLink.jsp start mid: " + MID + ",moid: " + Moid + ",goodsName: " + GoodsName + ",Amt: " + Amt + ",dutyFreeAmt: " + DutyFreeAmt 
			+ ",goodsCnt: " + GoodsCnt + ",buyerName: " + BuyerName + ",mallUserID: " + MallUserID + ",buyerTel: " + BuyerTel + ",buyerEmail: " + BuyerEmail 
			+ ",offeringPeriod: " + OfferingPeriod + ",userId: " + User_ID+ ",mallReserved: " + mallReserved);
	box = new Box();
	box.put("mid", MID);
	
	resMerKeyBox = CommonBiz.getMemberKey(box);
	String resMerchantKey=null;
	if((PayMethod.equals("신용카드(일반)")) || (PayMethod.equals("CARD")))
		PayMethod="CARD";
		else if((PayMethod.equals("계좌이체")) || (PayMethod.equals("BANK")))
			PayMethod="BANK";
		else if((PayMethod.equals("무통장입금")) || (PayMethod.equals("VBANK")))
			PayMethod="VBANK";
		else if((PayMethod.equals("ARSPay Web Link")) || (PayMethod.equals("CARS")))
			PayMethod="CARS";
		else if((PayMethod.equals("SMS카드결제 Web LINK(인증)")) || (PayMethod.equals("CSMS")))
			PayMethod="CSMS";
		else if((PayMethod.equals("SMS카드결제 Web LINK(수기)")) || (PayMethod.equals("DSMS")))
			PayMethod="DSMS";
		else if((PayMethod.equals("간편결제")) || (PayMethod.equals("EPAY")))
			PayMethod="EPAY";
		else{
			PayMethod="CKEYIN";
		}
	
	if(resMerKeyBox == null || resMerKeyBox.getString("mkey") == null) {
		System.out.println("**********[상점 MID Key가 존재하지 않습니다]**********");
		throw new Exception("W003"); 		
	} else {
		
		
		resMerchantKey = resMerKeyBox.getString("mkey");
		
		if(!MerchantKey.equals(resMerchantKey))
		{
			throw new Exception("W009");
		}
	}	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
<!-- InnoPay 결제연동 스크립트(필수) -->
<script type="text/javascript" src="js/innopay-2.0.js"></script>
<title>INNOPAY 전자결제서비스</title>
</head>
<body>
	<form action="" name="frm" id="frm" method="post" style="">
		<input type="hidden" name="MID" value="<%=MID%>"> 
		<input type="hidden" name="Moid" value="<%=Moid%>">
		<input type="hidden" name="GoodsName" value="<%=GoodsName%>">
		<input type="hidden" name="Amt" value="<%=Amt%>">
		<input type="hidden" name="DutyFreeAmt" value="<%=DutyFreeAmt%>"> 
		<input type="hidden" name="GoodsCnt" value="<%=GoodsCnt%>"> 
		<input type="hidden" name="BuyerName" value="<%=BuyerName%>"> 
		<input type="hidden" name="mallUserID" value="<%=MallUserID%>"> 
		<input type="hidden" name="BuyerTel" value="<%=BuyerTel%>"> 
		<input type="hidden" name="webview" value="<%=webview%>"> 
		<input type="hidden" name="BuyerEmail" value="<%=BuyerEmail%>"> 
		<input type="hidden" name="OfferingPeriod" value="<%=OfferingPeriod%>">
		<input type="hidden" name="User_ID" value="<%=User_ID%>">
		<input type="hidden" name="PayMethod" value="<%=PayMethod%>"> 
		<input type="hidden" name="ReturnURL" value="dsdsds"> 
		<input type="hidden" name="ResultYN" value=""> 
		<input type="hidden" name="RetryURL" value="dsdada"> 
		<input type="hidden" name="EncodingType" value=""> 
		<input type="hidden" name="FORWARD" value="X">
		<!--hidden 데이타 필수-->
		<input type="hidden" name="ediDate" value="">
		<!-- 결제요청일시 제공된 js 내 setEdiDate 함수를 사용하거나 가맹점에서 설정 yyyyMMddHHmmss-->
		<input type="hidden" name="MerchantKey" value="<%=MerchantKey%>">
		<!-- 발급된 가맹점키 -->
		<input type="hidden" name="EncryptData" value="">
		<!-- 암호화데이터 -->
		<input type="hidden" name="MallIP" value="<%=inet.getHostAddress()%>" />
		<!-- 가맹점서버 IP 가맹점에서 설정-->
		<input type="hidden" name="UserIP" value="<%=request.getRemoteAddr()%>">
		<!-- 구매자 IP 가맹점에서 설정-->
		<!-- <input type="hidden" name="FORWARD" value="Y"> Y:팝업연동 N:페이지전환 -->
		<input type="hidden" name="MallResultFWD" value="N">
		<!-- Y 인 경우 PG결제결과창을 보이지 않음 -->
		<input type="hidden" name="device" value="">
		<!-- 자동셋팅 -->
		<!--hidden 데이타 옵션-->
		<input type="hidden" name="BrowserType" value="">
		<input type="hidden" name="MallReserved" value="<%=mallReserved%>">
		<!-- 현재는 사용안함 -->
		<input type="hidden" name="SUB_ID" value="">
		<!-- 서브몰 ID -->
		<input type="hidden" name="BuyerPostNo" value="">
		<!-- 배송지 우편번호 -->
		<input type="hidden" name="BuyerAddr" value="">
		<!-- 배송지주소 -->
		<input type="hidden" name="BuyerAuthNum">
	</form>
	<script type="text/javascript">
	    $(document).ready(function(){  	
	    	setPayActionUrl('<%=payActionUrl%>');
	    	innopay.goPayForm(frm);
		});
	</script>
</body>
</html>