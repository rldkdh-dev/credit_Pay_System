
<%@ include file="../../common/cardParameter.jsp" %>
<%
	String storeid      = request.getParameter("sndStoreid");      //상점아이디
	String ordername    = request.getParameter("sndOrdername");    //주문자명
	String ordernumber  = request.getParameter("sndOrdernumber");  //주문번호
	String amount       = request.getParameter("sndAmount");       //금액
	String goodname     = request.getParameter("sndGoodname");     //상품명
	String email        = request.getParameter("sndEmail");        //주문자이메일
	String phoneno      = request.getParameter("sndMobile");      //주문자휴대폰번호
	String sndCertitype      = request.getParameter("sndCertitype"); 
%>
<html>
<head>
<title>KSPay</title>
<link rel="stylesheet" type="text/css" href="../../css/common.css" />
<script language="javascript">
<!--
// 이중승인의 가능성을 줄이기 위해 몇가지 이벤트를 막는다.
document.onmousedown=right;
document.onmousemove=right;

document.onkeypress = processKey;	
document.onkeydown  = processKey;

function processKey() { 
	if((event.ctrlKey == true && (event.keyCode == 8 || event.keyCode == 78 || event.keyCode == 82)) 
		|| ((typeof(event.srcElement.type) == "undefined" || typeof(event.srcElement.name) == "undefined" || event.srcElement.type != "text" || event.srcElement.name != "sndEmail") && event.keyCode >= 112 && event.keyCode <= 123)) {
		event.keyCode = 0; 
		event.cancelBubble = true; 
		event.returnValue = false; 
	} 
	if(event.keyCode == 8 && typeof(event.srcElement.value) == "undefined") {
		event.keyCode = 0; 
		event.cancelBubble = true; 
		event.returnValue = false; 
	} 
}

function right(e) {
	if(navigator.appName=='Netscape'&&(e.which==3||e.which==2)){
		alert('마우스 오른쪽 버튼을 사용할수 없습니다.');
		return;
	}else if(navigator.appName=='Microsoft Internet Explorer'&&(event.button==2||event.button==3)) {
		alert('마우스 오른쪽 버튼을 사용할수 없습니다.');
		return;
	}
}
-->
</script>
<script language="javascript">
       
	var go_flag = false; 
	/* 실제 승인페이지로 넘겨주는 form에 세팅한다 */
	function getLocalUrl(mypage){ 
		var myloc = location.href; 
		return myloc.substring(0, myloc.lastIndexOf('/')) + '/' + mypage;
	}
	function submitAuth(){
		
		var ssgfrm = document.ssgFrm;	
		    ssgfrm.sndReply.value     = getLocalUrl('ssg_return.jsp');
			ssgfrm.target = 'SSG_IFRM';			 
			document.getElementById("SSG_IFRM").style.visibility="visible";
				
		ssgfrm.action ='https://kspay.ksnet.to/store/PAY_PROXY/ssg/ssg_proxy.jsp'; 
		ssgfrm.submit();
		EPay_btn_on();
  }

	function paramSet(CARD_TRADE_AMT,TERMID,MGIFT_CARD_YN,CARD_DATE_NO,MGIFT_CONFIRM_NO,CARD_CERT_FLAG,CARD_ETC_DATA,DELEGATE_CERTIFY_CODE,MGIFT_CARD_NO,INSTALL_MONTH,OID,MGIFT_TRADE_AMT,CARD_CERTFY_NO,CARD_TRACK2_DATA,CARD_NO, SSGPAY_CARD_YN, SSGPAY_PAYMETHOD, SSGPAY_PLATFORM_MID){
		var frm = document.KSPayAuthForm;
		frm.SSGPAY_CARD_TRADE_AMT.value        =  CARD_TRADE_AMT		 ;	
		frm.SSGPAY_TERMID.value                =  TERMID                 ;
		frm.SSGPAY_MGIFT_CARD_YN.value         =  MGIFT_CARD_YN          ;
		frm.CardExpire.value         		   =  CARD_DATE_NO           ;
		frm.SSGPAY_MGIFT_CONFIRM_NO.value      =  MGIFT_CONFIRM_NO       ;
		frm.SSGPAY_CARD_CERT_FLAG.value        =  CARD_CERT_FLAG         ;
		frm.SSGPAY_CARD_ETC_DATA.value         =  CARD_ETC_DATA          ;
		frm.SSGPAY_DELEGATE_CERTIFY_CODE.value =  DELEGATE_CERTIFY_CODE  ;
		frm.SSGPAY_MGIFT_CARD_NO.value         =  MGIFT_CARD_NO          ;
		frm.CardQuota.value        			   =  INSTALL_MONTH          ;
		frm.SSGPAY_OID.value                   =  OID                    ;
		frm.SSGPAY_MGIFT_TRADE_AMT.value       =  MGIFT_TRADE_AMT        ;
		frm.SSGPAY_CARD_CERTFY_NO.value        =  CARD_CERTFY_NO         ;
		frm.SSGPAY_CARD_TRACK2_DATA.value      =  CARD_TRACK2_DATA       ;
		frm.SSGPAY_CARD_NO.value               =  CARD_NO                ;
		frm.SSGPAY_CARD_YN.value               =  SSGPAY_CARD_YN         ;		
		frm.SSGPAY_PAYMETHOD.value             =  SSGPAY_PAYMETHOD       ;	
		frm.SSGPAY_PLATFORM_MID.value          =  SSGPAY_PLATFORM_MID    ;	
	}
	function proceed(arg){

		if ((arg == "TRUE"||arg == "true"||arg == true)){
			var pay_frm = document.KSPayAuthForm;
			pay_frm.target="InnoFrame";
			pay_frm.action = "./../payConfirm_EPay.jsp";
			pay_frm.submit();	
		}
		else{
			go_flag = false;
			
		}
	}
	function EPay_btn_on(){  //SSG전용 버튼 출력 함수.
		var btn=document.getElementById('bt');
		btn.style.display="block";
		btn.style.top="0px";
		btn.style.left="585px";
		btn.style.padding="10px";
		
	};
	function EPay_btn_off(){  //SSG전용 버튼 숨김 함수.
	  var btn=document.getElementById('bt');
	  btn.style.display="none";
	  parent.document.getElementById("SSGFRAME").style.visibility="hidden";
	  parent.install_notice_off();
	}
	/* realSubmit을 진행할 것인가 아닌가를 판단하는 함수. 이 함수의 호출은 승인 페이지가 아닌 ssg_return.jsp에서 하게 되며, 
	페이지가 받아두었던 인증값 파라메터들과 리얼서브밋진행여부를 받아 승인페이지로 되넘겨준다. */
</script>
</head>

<body onload="submitAuth();">

<form name=KSPayAuthForm method=post>
<!--기본-------------------------------------------------------------->
	<input type="hidden" name="storeid"        	value="<%=storeid%>">
	<input type="hidden" name="email"          	value="<%=BuyerEmail%>">
	<input type="hidden" name="MID"    			value="<%=MID%>">
	<input type="hidden" name="svcPrdtCd"       value="<%=svcPrdtCd%>">
	<input type="hidden" name="TID"             value="<%=TID%>"/>
	<input type="hidden" name="MallReserved"    value="<%=MallReserved%>"/>
	<input type="hidden" name="mallUserID"      value="<%=mallUserID%>"/>
	<input type="hidden" name="formBankCd"      value="<%=formBankCd%>"/>
	<input type="hidden" name="ediDate"         value="<%=ediDate%>">
	<input type="hidden" name="FORWARD"         value="<%=FORWARD%>">
	<input type="hidden" name="EncryptData"     value="<%=EncryptData%>">
	<input type="hidden" name="BuyerEmail"		value="<%=BuyerEmail%>"> 
	<input type="hidden" name="BuyerTel"		value="<%=BuyerTel%>">
	<input type="hidden" name="BuyerName"		value="<%=BuyerName %>">
	<input type="hidden" name="GoodsName"		value="<%=GoodsName %>"> 
	<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
	<input type="hidden" name="ResultYN"        value="<%=ResultYN %>"/>
	<input type="hidden" name="ReturnURL"        value="<%=ReturnURL%>"/>
	<input type="hidden" name="RetryURL"        value="<%=RetryURL%>"/>
	<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
	<input type="hidden" name="User_ID"         value="<%=User_ID%>"/>
	<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
	<input type="hidden" name="Amt"         	value="<%=Amt%>">
	<input type="hidden" name="MallIP"			value="<%=MallIP %>">
	<input type="hidden" name="UserIP"          value="<%=UserIP%>">
	<input type="hidden" name="PayMethod"       value="<%=PayMethod%>"/>  
	<input type="hidden" name="Moid"			value="<%=Moid %>">         
	<input type="hidden" name="svcCd"     		value="<%=svcCd%>">
	<input type="hidden" name="CardInterest"    value="<%=CardInterest%>"/>
	<input type="hidden" name="EncodingType"    value="<%=EncodingType%>"/>
	<input type="hidden" name="CardExpire"      value="">
	<input type="hidden" name="CardQuota"       value="">
	<input type="hidden" name="EPayCl"          value="04">	
	<input type="hidden" name="device"    		value="<%=device%>">
	<input type="hidden" name="OfferingPeriod"  value="<%=OfferingPeriod%>"/>
<!-- ssg 변수 -->
	<input type="hidden" name="SSGPAY_CARD_TRADE_AMT"        value="">
	<input type="hidden" name="SSGPAY_TERMID"                value="">
	<input type="hidden" name="SSGPAY_MGIFT_CARD_YN"         value="">
	<input type="hidden" name="SSGPAY_CARD_DATE_NO"          value="">
	<input type="hidden" name="SSGPAY_MGIFT_CONFIRM_NO"      value="">
	<input type="hidden" name="SSGPAY_CARD_CERT_FLAG"        value="">
	<input type="hidden" name="SSGPAY_CARD_ETC_DATA"         value="">
	<input type="hidden" name="SSGPAY_DELEGATE_CERTIFY_CODE" value="">
	<input type="hidden" name="SSGPAY_MGIFT_CARD_NO"         value="">
	<input type="hidden" name="SSGPAY_INSTALL_MONTH"         value="">
	<input type="hidden" name="SSGPAY_OID"                   value="">
	<input type="hidden" name="SSGPAY_MGIFT_TRADE_AMT"       value="">
	<input type="hidden" name="SSGPAY_CARD_CERTFY_NO"        value="">
	<input type="hidden" name="SSGPAY_CARD_TRACK2_DATA"      value="">
	<input type="hidden" name="SSGPAY_CARD_NO"               value="">
	<input type="hidden" name="SSGPAY_CARD_YN"               value="">
	<input type="hidden" name="SSGPAY_PAYMETHOD"             value="">
	<input type="hidden" name="SSGPAY_PLATFORM_MID"          value="">
<!-- -->
</form>

<form name=ssgFrm method=post>
	<input type=hidden name="sndReply"      	value="">                      <!-- 인증후 호출주소  -->
	<input type=hidden name="sndStoreid"    	value="<%=storeid%>">
 	<input type=hidden name="sndOrdernumber"	value="<%=ordernumber%>">
	<input type=hidden name="sndGoodname"   	value="<%=goodname%>">
	<input type=hidden name="sndAmount"     	value="<%=amount%>">
	<input type=hidden name="sndOrdername"  	value="<%=ordername%>">
	<input type=hidden name="sndEmail"      	value="<%=email%>">
	<input type=hidden name="sndMobile"     	value="<%=phoneno%>">
	<input type=hidden name="sndCharSet"		value="utf-8">                      <!-- default euc-kr , utf-8 -->	
	<input type=hidden name="sndCertitype"   	value="<%=sndCertitype%>">

</form>
<span id="bt" class="card_layer_close" onclick="EPay_btn_off();"><img src="../../images/x_white.png" width="20" height="auto"></span>
<IFRAME id='SSG_IFRM' name='SSG_IFRM' scrolling=no frameborder='0' ></IFRAME>
</body>
</html>