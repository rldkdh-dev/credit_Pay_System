<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="java.net.SocketException"%>
<%@page import="java.io.IOException"%>
<%@ include file="../../common/cardParameter.jsp" %>
<% 
// Cache 의존 제거
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

String sndStoreid = request.getParameter("sndStoreid");
String sndEmail = request.getParameter("sndEmail");
String sndMobile = request.getParameter("sndMobile");
String sndOrdernumber = request.getParameter("sndOrdernumber");
String sndOrdername = request.getParameter("sndOrdername");
String sndGoodname = request.getParameter("sndGoodname");
String sndAmount = request.getParameter("sndAmount");
String sndReply = request.getParameter("sndReply");
String sndCharset = request.getParameter("sndCharset");

///////////////
//System.out.println("co_nm["+co_nm+"]");
//System.out.println("GoodsName["+GoodsName+"]");
//System.out.println("co_nm["+co_nm+"]");

Enumeration eNames = request.getParameterNames();
if (eNames.hasMoreElements()) {
	Map entries = new TreeMap();
	while (eNames.hasMoreElements()) {
		String name = (String) eNames.nextElement();
		String[] values = request.getParameterValues(name);
		if (values.length > 0) {
			String value = values[0];
			for (int i = 1; i < values.length; i++) {
				value += "," + values[i];
			}
			System.out.println(name + "[" + value +"]");
		}
	}
}
%>
<!DOCTYPE html>
<html>
    <head>
    <title>INNOPAY 전자결제서비스</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <script type="text/javascript" src="../../js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="../../js/jquery.mCustomScrollbar.js"></script>
        <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
        <script type="text/javascript" src="../../js/common.js" charset="utf-8"></script>
        <script type="text/javascript" src="../../js/card_pay_m.js" charset="utf-8"></script>
        <link rel="stylesheet" type="text/css" href="../../css/jquery.mCustomScrollbar.css" />
        <link rel="stylesheet" type="text/css" href="../../css/common.css" />
        <link href='../../css/font.css' rel='stylesheet' type='text/css'>

<script type="text/javascript">
    function doProcess(){
    	
    	 var call_url = "https://kspay.ksnet.to/store/PAY_PROXY/lpay/lpayp.jsp";  	  
    	 var f=document.lpayForm2;
    	 var lf = document.getElementById("LPAYFRAME_M");
    	 lf.style.visibility="visible";
         var widthSize;
         var heightSize;
         widthSize = '96%';
         heightSize = (window.innerHeight-50)+'px';
         lf.style.display = 'block';
         lf.style.height = heightSize;
         lf.style.width = widthSize;
    	 f.target="LPAYFRAME_M";
    	 f.action=call_url;
    	
    	 f.submit();
    }

	function goPayment(){
		var formNm = document.tranMgr;
		formNm.action = "../payConfirm_card_m.jsp";
		formNm.submit();
	} 
	function recvResult(proceed){	     
		if(proceed == "TRUE"||proceed == "true"||proceed == true){
			
				kspayForm.action = "./../payConfirm_EPay.jsp";
				kspayForm.submit();
				
		}else{
			//LPAY 인증실패	
			var a=document.kspayForm;
			a.action="../EPay_mobile.jsp"
			a.submit();	
			
		}
	}	
</script>
</head>

<body onload="javascript:doProcess();">
<!-- lpay 응답 파라미터-->
<form name="lpayForm2"  method="post" id="lpayForm2">
	<input type="hidden" name="sndStoreid"    	value="<%=sndStoreid%>">           <!-- 상점아이디 -->
	<input type="hidden" name="sndEmail"		value="<%=sndEmail%>">           <!-- 이메일 -->
	<input type="hidden" name="sndMobile"		value="<%=sndMobile%>">           <!-- 연락처 -->
	<input type="hidden" name="sndOrdernumber"	value="<%=sndOrdernumber %>">           <!-- 주문번호 -->
	<input type="hidden" name="sndOrdername"	value="<%=sndOrdername %>">           <!-- 주문자명 -->
	<input type="hidden" name="sndGoodname"		value="<%=sndGoodname %>">           <!-- 상품명 -->
	<input type="hidden" name="sndAmount"		value="<%=sndAmount%>">           <!-- 결제금액 -->
	<input type="hidden" name="sndReply"    	value="<%=sndReply %>" >          <!-- returnUrl -->
	<input type="hidden" name="sndCharset"      value="<%=sndCharset%>" >          <!-- 가맹점 charset -->	
	<input type="hidden" name="svcPrdtCd"       value="<%=svcPrdtCd%>">
</form>

<form name="kspayForm" method="post" id="kspayAuth">
    <input type="hidden" name="ordernumber" 		value="<%=Moid %>"  maxlength="50">
	<input type="hidden" name="LPAY_P_REQ_ID"       value="" >
	<input type="hidden" name="LPAY_PG_ID"          value="" >
	<input type="hidden" name="LPAY_F_CO_CD"        value="" >
	<input type="hidden" name="LPAY_MEM_M_NUM"      value="" >
	<input type="hidden" name="CardQuota"           value="" >
	<input type="hidden" name="LPAY_REQ_AMT"        value="" >
	<input type="hidden" name="cavv"                value="" >
	<input type="hidden" name="CardNum"             value="" >
	<input type="hidden" name="xid"                	value="" >
	<input type="hidden" name="eci"                 value="" >
	<input type="hidden" name="LPAY_OTC_NUM"        value="" >
	<input type="hidden" name="LPAY_TR_ID"          value="" >
	<input type="hidden" name="CardExpire"          value="" >
	<input type="hidden" name="svcPrdtCd"    	  	value="<%=svcPrdtCd%>">
	<input type="hidden" name="MID"   				value="<%=MID%>">
	<input type="hidden" name="svcCd"      			value="<%=svcCd%>">
	<input type="hidden" name="OrderCode"      	 	value="<%=OrderCode%>">
	<input type="hidden" name="TID"            		value="<%=TID%>"/>
	<input type="hidden" name="MallReserved"    	value="<%=MallReserved%>"/>
	<input type="hidden" name="ediDate"        		value="<%=ediDate%>">
	<input type="hidden" name="EncryptData"    		value="<%=EncryptData%>">
	<input type="hidden" name="BuyerEmail"			value="<%=BuyerEmail%>">           <!-- 이메일 -->
	<input type="hidden" name="BuyerTel"			value="<%=BuyerTel%>">           <!-- 연락처 -->
	<input type="hidden" name="Moid"				value="<%=Moid %>">           <!-- 주문번호 -->
	<input type="hidden" name="BuyerName"			value="<%=BuyerName %>">           <!-- 주문자명 -->
	<input type="hidden" name="GoodsName"			value="<%=GoodsName %>">           <!-- 상품명 -->
	<input type="hidden" name="Amt"					value="<%=Amt%>">           <!-- 결제금액 -->
	<input type="hidden" name="GoodsCnt"        	value="<%=GoodsCnt%>"/>
	<input type="hidden" name="ResultYN"        	value="<%=ResultYN%>"/>
	<input type="hidden" name="RetryURL"        	value="<%=RetryURL%>"/>
	<input type="hidden" name="EncodingType"    	value="<%=EncodingType%>"/>
	<input type="hidden" name="Pg_Mid"          	value="<%=Pg_Mid%>">
	<input type="hidden" name="MallIP"				value="<%=MallIP %>">
	<input type="hidden" name="UserIP"          	value="<%=UserIP%>">  
	<input type="hidden" name="FORWARD"         	value="<%=FORWARD%>"/>
	<input type="hidden" name="DutyFreeAmt"     	value="<%=DutyFreeAmt%>"/>
	<input type="hidden" name="User_ID"         	value="<%=User_ID%>"/>
	<input type="hidden" name="ReturnURL"       	value="<%=ReturnURL%>"/>
	<input type="hidden" name="Currency"        	value="<%=Currency%>"/>
	<input type="hidden" name="CardInterest"    	value="<%=CardInterest%>"/>
	<input type="hidden" name="TaxAmt"          	value="<%=TaxAmt%>"/>
	<input type="hidden" name="TransType"       	value="<%=TransType%>"/>	
	<input type="hidden" name="EPayCl"          	value="02">
	<input type="hidden" name="OfferingPeriod"  	value="<%=OfferingPeriod%>"/>
		
</form>	
    <iframe id="LPAYFRAME_M" name="LPAYFRAME_M" align="middle" style=" width:100%; height:100%; margin-bottom:0px;" frameborder="0" ></iframe>
</body>        
</html>