<%------------------------------------------------------------------------------
파일명     : kakao_pc.jsp
기능       : 카카오페이호출 페이지.
-------------------------------------------------------------------------------%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<%@ include file="../../common/cardParameter.jsp" %>

<%
	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","-1");
	response.setHeader("pragma","no-cache");
	
%>
<%
	//기본거래정보
	
	String storeid  	  = request.getParameter("storeid");      //상점아이디
	String ordername      = request.getParameter("BuyerName");    	//주문자명
	String ordernumber    = request.getParameter("Moid");  			//주문번호
	String amount         = request.getParameter("Amt");       		//금액
	String goodname       = request.getParameter("GoodsName");    	//상품명
	String email          = request.getParameter("BuyerEmail");   	//주문자이메일
	String phoneno        = request.getParameter("BuyerTel");     	//주문자휴대폰번호
	String currencytype   = request.getParameter("currencytype");	//통화구분 : "WON" : 원화, "USD" : 미화
	String boss_nm		  = request.getParameter("boss_nm");
	String tel_no		  = request.getParameter("tel_no");
	String addr           = request.getParameter("addr");
	// 상점 정보 설정.           
	/*
	String store_ceo_name = "대표자" ;        // 상점 대표자명        
	String store_phoneno  = "02-555-6666" ;   // 상점 연락처               
	String store_address  = "서울시 강남구" ; // 상점 주소                
	*/                                      
             
%>
<style>

</style>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html charset=utf-8">
<title>KSPay</title>
<script language="javascript">

	function _submit(){
		
		var vfrm = document.kfrm;
		
		document.getElementById("DIV_KAKAOFRAME").innerHTML = "<IFRAME id='KAKAO_IFRM' name='KAKAO_IFRM' width=100% height='100%' scrolling=no frameborder='0' ></IFRAME>";
		document.getElementById("KAKAO_IFRM").style.visibility="visible";
		vfrm.returnUrl.value = getLocalUrl("kakao_return.jsp");
		if (isMobile()){
			vfrm.processtype.value="1";   // PC:1, mobile : 2 -->
		}
		vfrm.target = 'KAKAO_IFRM';
		vfrm.action = "https://kspay.ksnet.to/store/PAY_PROXY/kakao/kakao_rs_o1.jsp" ;
		vfrm.submit();
	}

	function getLocalUrl(mypage){
		
		var myloc = location.href; 
		return myloc.substring(0, myloc.lastIndexOf('/')) + '/' + mypage;
		
	}
	
	function recvResult(proceed,tid ,cid,token ){
		
		var frm = document.KSPayAuthForm;  
		
		if ( token != "" && proceed == "true"){
			frm.tid.value=tid;
			frm.cid.value=cid;
			frm.xid.value=token;
			submitAuth();
			return;
		}else{
			//취소처리부분.
			op_check = false ;
		
			return;
		}
	}
	
	function submitAuth(){  //정상적으로 결제 되었을때....
		
		var frm = document.KSPayAuthForm;
		frm.target="InnoFrame";
		frm.action = "../payConfirm_EPay.jsp";
		frm.submit();
		
	}
	function isMobile(){ //모바일, pc 판별
		var filter = "win16|win32|win64|mac|macintel";
		 
		if (navigator.platform ) {
 			if (filter.indexOf(navigator.platform.toLowerCase()) < 0) {
  			return true;
 			} else {
 				//PC
  			return false;
 			}
		}
	}
function kakao_cancel(){ //카카오 취소버튼 눌렀을 경우....
		
		parent.document.getElementById("SFRAME").style.visibility="hidden";
		parent.install_notice_off();
		
	}
</script>

</head>

<body onload="_submit();" >

<form name="KSPayAuthForm" method="post">
<!--기본-------------------------------------------------------------->
<input type="hidden" name="storeid"    		value="<%=storeid%>">
<!--일반신용카드------------------------------------------------------>
<input type="hidden" name="currencytype"    value="<%=currencytype%>">
<input type="hidden" name="tid"	            value="">                   <!-- 카카오페이 TID -->
<input type="hidden" name="cid"	            value="">
<input type="hidden" name="xid"        		value="">                   <!-- 카카오페이 결제승인 토큰 -->
<input type="hidden" name="storeid"        	value="<%=storeid%>">
<input type="hidden" name="email"          	value="<%=BuyerEmail%>">
<input type="hidden" name="MID"    			value="<%=MID%>">
<input type="hidden" name="svcPrdtCd"       value="<%=svcPrdtCd%>">
<input type="hidden" name="TID"             value="<%=TID%>"/>
<input type="hidden" name="MallReserved"    value="<%=MallReserved%>"/>
<input type="hidden" name="formBankCd"      value="<%=formBankCd%>"/>
<input type="hidden" name="ediDate"         value="<%=ediDate%>">
<input type="hidden" name="EncryptData"     value="<%=EncryptData%>">
<input type="hidden" name="PayMethod"       value="<%=PayMethod%>"/>
<input type="hidden" name="FORWARD"     	value="<%=FORWARD%>">
<input type="hidden" name="BuyerEmail"		value="<%=BuyerEmail%>"> 
<input type="hidden" name="BuyerTel"		value="<%=BuyerTel%>">
<input type="hidden" name="OrderCode"    	value="<%=OrderCode%>">
<input type="hidden" name="BuyerName"		value="<%=BuyerName %>">
<input type="hidden" name="GoodsName"		value="<%=GoodsName %>"> 
<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
<input type="hidden" name="ResultYN"        value="<%=ResultYN%>"/>
<input type="hidden" name="RetryURL"        value="<%=RetryURL%>"/>
<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
<input type="hidden" name="Amt"         	value="<%=Amt%>">
<input type="hidden" name="Moid"			value="<%=Moid %>">         
<input type="hidden" name="mallUserID"      value="<%=mallUserID%>"/>
<input type="hidden" name="svcCd"      		value="<%=svcCd%>">
<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/>            
<input type="hidden" name="CardInterest"    value="<%=CardInterest%>"/>
<input type="hidden" name="EncodingType"    value="<%=EncodingType%>"/>
<input type="hidden" name="TransType"       value="<%=TransType%>"/>	
<input type="hidden" name="PrdtAmt"         value=""/>
<input type="hidden" name="MallIP"			value="<%=MallIP %>">  
<input type="hidden" name="UserIP"          value="<%=UserIP%>">
<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
<input type="hidden" name="User_ID"         value="<%=User_ID%>"/>
<input type="hidden" name="PrdtDutyFreeAmt" value=""/>
<input type="hidden" name="CardExpire"      value="<%=CardExpire%>">
<input type="hidden" name="CardQuota"       value="<%=CardQuota%>">
<input type="hidden" name="EPayCl"          value="01">	
<input type="hidden" name="device"          value="<%=device%>">	
<input type="hidden" name="OfferingPeriod"  value="<%=OfferingPeriod%>"/>
</form>
	
<form name="kfrm" target="_blank" method="post">
	<INPUT type="hidden" name="returnUrl"      value="" >                 <!-- returnUrl -->
	<INPUT type="hidden" name="storeid"        value="<%=storeid%>" >     <!-- PG 상점아이디 -->
	<INPUT type="hidden" name="ordername"      value="<%=BuyerName%>" >   <!-- 주문자명 -->
	<INPUT type="hidden" name="ordernumber"    value="<%=Moid%>" > <!-- 주문번호 -->
	<INPUT type="hidden" name="amount"         value="<%=Amt%>" >      <!-- 총승인금액 -->
	<INPUT type="hidden" name="goodname"       value="<%=GoodsName%>" >    <!-- 상품명 -->
	<INPUT type="hidden" name="email"          value="<%=BuyerEmail%>" >       <!-- email -->
	<INPUT type="hidden" name="phoneno"        value="<%=BuyerTel%>" >     <!-- 휴대폰번호 -->
	<INPUT type="hidden" name="paymenttype"    value="" >                 <!-- 결제수단 CARD,MONEY 없는경우 모두노출--> 
	<INPUT type="hidden" name="installment"    value="00" >                 <!-- 카드할부개월수 0~12(개월)사이의 값 -->
	<INPUT type="hidden" name="availcard"      value="11,06,04,14,12,03,34,41,43" > <!-- (없을경우 전체),   11: 비씨 , 06: 국민, 34:하나, 12:삼성, 14: 신한, 04:현대, 03: 롯데,41: 농협, 43: 씨티   -->
	<INPUT type="hidden" name="processtype"    value="1" >                 <!-- PC:1, mobile : 2 -->
	<input type="hidden" name="store_ceo_name" value="<%=boss_nm %>" >
	<input type="hidden" name="store_phoneno"  value="<%=tel_no %>" >
	<input type="hidden" name="store_address"  value="<%=addr %>" >
	<input type="hidden" name="char_set"  	   value="utf-8" >

</form>
<div id="DIV_KAKAOFRAME"  style="border-width:0px;" > 

</div>
</body>
</html>