<%@ page contentType="text/html; charset=utf-8"%>
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
  String storename = request.getParameter("sndStorename");
%>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head>
<title>KSPay</title>
<link rel="stylesheet" type="text/css" href="../../css/common.css" />
<script language="javascript" >
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
<script type="text/javascript" charset="utf-8">
  var flag= false;
  var go_flag = false; 
  /* 실제 승인페이지로 넘겨주는 form에 세팅한다 */
  function getLocalUrl(mypage){ 
    var myloc = location.href; 
    return myloc.substring(0, myloc.lastIndexOf('/')) + '/' + mypage;
  }
  
  function popupIsClosed(){
    if(op){
      if(op.closed && flag == false) {
     	goBack();
    } else{
      self.setTimeout("popupIsClosed()", 1000);
      }
    }
  }
    
  function submitAuth(){
    
      var naverfrm = document.naverFrm; 
      naverfrm.returnUrl.value  = getLocalUrl('naver_return.jsp');
        
      var width_  = 750;
      var height_ = 850;
      var left_ = screen.width;
      var top_  = screen.height;
        
      left_ = left_/2 - (width_/2);
      top_ = top_/2 - (height_/2);
      
      op = window.open("",'AuthFrmUp',
           'height='+height_+',width='+width_+',status=yes,scrollbars=no,resizable=no,left='+left_+',top='+top_+'');
      
      if (op == null){
			alert("팝업이 차단되어 결제를 진행할 수 없습니다.");
			goBack();
		}
       
      naverfrm.target="AuthFrmUp";
      naverfrm.action ='http://kspay.ksnet.to/store/PAY_PROXY/npay/naver_rs_o1.jsp'; 
      naverfrm.submit();
      popupIsClosed();
  }
  
  function goBack(){
	  var form = document.KSPayAuthForm;
	  form.target="InnoFrame";
	  form.action="../EPay_mobile.jsp";
	  form.submit();
  }

  function recvResult(proceed,cardNumber,cardExpiredDate,cardCode,paymentId, installment,cavv,xid,eci,trid){
	  flag=true;
	  var frm = document.KSPayAuthForm;
	  
	  frm.cardNumber.value = cardNumber;
	  frm.cardExpiredDate.value = cardExpiredDate;
	  frm.cardCode.value = cardCode;
	  frm.paymentId.value = paymentId;
	  frm.installment.value = installment;
	  frm.cavv.value = cavv;
	  frm.xid.value = xid;
	  frm.eci.value = eci;
	  frm.trid.value = trid;	  
	 
	  confirm(proceed);
		
	}
  
  function confirm(arg){	
    if ((arg == "TRUE"||arg == "true"||arg == true)){
      var pay_frm = document.KSPayAuthForm;
      pay_frm.target="InnoFrame";
      pay_frm.action = "./../payConfirm_EPay.jsp";
      pay_frm.submit(); 
    }
  }
</script>
</head>
<body onload="submitAuth();">
<form name=KSPayAuthForm method=post>
<!--기본-------------------------------------------------------------->
  <input type="hidden" name="storeid"         value="<%=storeid%>">
  <input type="hidden" name="email"           value="<%=BuyerEmail%>">
  <input type="hidden" name="MID"         	  value="<%=MID%>">
  <input type="hidden" name="svcPrdtCd"       value="<%=svcPrdtCd%>">
  <input type="hidden" name="TID"             value="<%=TID%>"/>
  <input type="hidden" name="MallReserved"    value="<%=MallReserved%>"/>
  <input type="hidden" name="mallUserID"      value="<%=mallUserID%>"/>
  <input type="hidden" name="formBankCd"      value="<%=formBankCd%>"/>
  <input type="hidden" name="ediDate"         value="<%=ediDate%>">
  <input type="hidden" name="FORWARD"         value="<%=FORWARD%>">
  <input type="hidden" name="EncryptData"     value="<%=EncryptData%>">
  <input type="hidden" name="BuyerEmail"      value="<%=BuyerEmail%>"> 
  <input type="hidden" name="BuyerTel"    	  value="<%=BuyerTel%>">
  <input type="hidden" name="BuyerName"   	  value="<%=BuyerName %>">
  <input type="hidden" name="GoodsName"  	  value="<%=GoodsName %>"> 
  <input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
  <input type="hidden" name="ResultYN"        value="<%=ResultYN %>"/>
  <input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/>
  <input type="hidden" name="RetryURL"        value="<%=RetryURL%>"/>
  <input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
  <input type="hidden" name="User_ID"         value="<%=User_ID%>"/>
  <input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
  <input type="hidden" name="Amt"             value="<%=Amt%>">
  <input type="hidden" name="MallIP"          value="<%=MallIP %>">
  <input type="hidden" name="UserIP"          value="<%=UserIP%>">
  <input type="hidden" name="PayMethod"       value="<%=PayMethod%>"/>  
  <input type="hidden" name="Moid"      	  value="<%=Moid %>">         
  <input type="hidden" name="svcCd"           value="<%=svcCd%>">
  <input type="hidden" name="CardInterest"    value="<%=CardInterest%>"/>
  <input type="hidden" name="EncodingType"    value="<%=EncodingType%>"/>
  <input type="hidden" name="CardExpire"      value="">
  <input type="hidden" name="CardQuota"       value="">
  <input type="hidden" name="EPayCl"          value="06"> 
  <input type="hidden" name="device"          value="<%=device%>">
  <input type="hidden" name="OfferingPeriod"  value="<%=OfferingPeriod%>"/>
<!-- naver 변수 -->
 <input type="hidden" name="cardNumber"  	 value=""/>
 <input type="hidden" name="cardExpiredDate" value=""/>
 <input type="hidden" name="cardCode"  	 	 value=""/>
 <input type="hidden" name="paymentId"  	 value=""/>
 <input type="hidden" name="installment"  	 value=""/>
 <input type="hidden" name="cavv"  		 	 value=""/>
 <input type="hidden" name="xid"  		 	 value=""/>
 <input type="hidden" name="eci"  			 value=""/>
 <input type="hidden" name="trid"  			 value=""/>
</form>

<form name=naverFrm method=post accept-charset="utf-8">
  <input type=hidden 	name="returnUrl"     value="">                      <!-- 인증후 호출주소  -->
  <input type=hidden 	name="storeid"       value="<%=storeid%>">
  <input type=hidden 	name="ordernumber" 	 value="<%=ordernumber%>">
  <input type=hidden 	name="goodname"    	 value="<%=goodname%>">
  <input type=hidden 	name="amount"      	 value="<%=amount%>">
  <input type=hidden 	name="ordername"   	 value="<%=ordername%>">
  <input type=hidden 	name="email"       	 value="<%=email%>">
  <input type=hidden 	name="processtype"   value="2">
  <input type=hidden 	name="phoneno"       value="<%=phoneno%>">
  <input type=hidden    name="charset"   	 value="utf-8">                        <!-- default euc-kr , utf-8 --> 
  <input type="hidden"  name="storename"     value="<%=storename %>"  >   
  <input type="hidden"  name="productcount"  value="<%=GoodsCnt%>"/>
</form>
</body>
</html>