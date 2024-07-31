<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../../common/cardParameter.jsp" %>
<link rel="stylesheet" type="text/css" href="../../css/common.css" />
<%!
	int MY_SEQ = 0;
%>
<%
    request.setCharacterEncoding("utf-8"); 
	
	String _STOREID    	 = request.getParameter("sndStoreid"); 
	String _ORDERNUMBER	 = request.getParameter("sndOrdernumber");
	String _GOODNAME   	 = request.getParameter("sndGoodname") ;
	String _AMOUNT    	 = request.getParameter("sndAmount");
	String _ORDERNAME  	 = request.getParameter("sndOrdername") ;
	String _EMAIL      	 = request.getParameter("sndEmail");
	String _MOBILE     	 = request.getParameter("sndMobile");
	String sndStorename    = request.getParameter("sndStorename");
	String _BIZNO        = request.getParameter("bizno");
	String _ORDERCHANNEL = "MOBILE";
	String _RT_APP       = request.getParameter("rtapp");     // 앱연동시 앱스키마

	// 리턴페이지에서 load해서 쓰일정보 저장.
	// 파일 처리 등 가맹점 상황에 맞게 처리하면됨.
	int tr_seq = 1000 + (++MY_SEQ % 1000);
	String _PTID = "K" + new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date()) + String.valueOf(tr_seq).substring(1);  // saveindex 샘플.
	
	String	my_url = javax.servlet.http.HttpUtils.getRequestURL(request).toString();
	int li_idx	= my_url.lastIndexOf('/');
	
	String _REPLY      	 = my_url.substring(0,li_idx) + "/payco_return.jsp?PTID=" + _PTID; 
	
	HashMap kv = new HashMap();
	kv.put("STOREID"      ,_STOREID );
	kv.put("ORDERNUMBER"  ,_ORDERNUMBER );
	kv.put("GOODNAME"     ,_GOODNAME );
	kv.put("AMOUNT"       ,_AMOUNT );
	kv.put("ORDERNAME"    ,_ORDERNAME );
	kv.put("EMAIL"        ,_EMAIL );
	kv.put("MOBILE"       ,_MOBILE );   
	kv.put("CURRENCYTYPE" ,"WON" );  

	//  파일에 저장.
	/*File f = new File("/home/webpg/docwebpg/test/payco/mobile", _PTID);  //상점정보를 저장할 디렉토리 지정 (가맹점 디렉토리)

	ObjectOutputStream	oout	= null;
	try
	{
		oout = new ObjectOutputStream(new FileOutputStream(f));
		oout.writeObject(kv);
		oout.close(); oout = null;
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		try{if (oout != null){oout.close(); oout = null;}}catch(Exception e){}
	}*/
%>
<html>
<head>


<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<title>KSPay</title>
<style>
.iphone{      
     -webkit-overflow-scrolling: touch;   
 	 position: fixed;
	 overflow-x: hidden;
	 top:0;
	 left:0;
	 overflow-y: scroll;
     width:100%;
     height:100%;
       
}
    iframe {
    overflow -x:hidden;
        width: 1px;
        min-width: 100%;
        *width: 100%;
    }
</style>
<script type="text/javascript">
function getLocalUrl(mypage){ 
	var myloc = location.href; 
	return myloc.substring(0, myloc.lastIndexOf('/')) + '/' + mypage;
} 

	function excute_payco(){
		 var pf = document.getElementById("PAYCOFRAME2");
		  if(/Android/i.test(navigator.userAgent)) {    // 안드로이드
			   // 안드로이드
	        	 pf.scrolling="yes";
		   }

		 var f = document.paycoFrm;
	
         f.action="https://kspay.ksnet.to/store/PAY_PROXY/payco/payco_p.jsp";
    	 f.target="PAYCOFRAME2";
		 f.submit();
	}
	
	function recvResult_payco(proceed){
		var pay_frm  = document.PaycoAuthForm;
		
		if(proceed == "TRUE"||proceed == "true"||proceed == true){			
			
				pay_frm.action = "./../payConfirm_EPay.jsp";
				pay_frm.submit();	
			
		}else{	
			//PAYCO 인증실패	
		    pay_frm.action="../EPay_mobile.jsp"
			pay_frm.submit();	
				
		}
	}
</script>
</head>
<body onload="excute_payco();">
	<form name="paycoFrm" method="post" accept-charset="euc-kr">
		<input type="hidden" name="sndReply"      	value="<%=_REPLY%>">  
		<input type="hidden" name="sndStoreid"    	value="<%=_STOREID%>">
 		<input type="hidden" name="sndOrdernumber"	value="<%=_ORDERNUMBER%>">
		<input type="hidden" name="sndGoodname"   	value="<%=GoodsName%>">
		<input type="hidden" name="sndAmount"     	value="<%=_AMOUNT%>">
		<input type="hidden" name="sndOrdername"  	value="<%=_ORDERNAME%>">
		<input type="hidden" name="sndEmail"      	value="<%=_EMAIL%>">
		<input type="hidden" name="sndMobile"     	value="<%=_MOBILE%>">
		<input type="hidden" name="sndStorename"    value="<%=sndStorename%>">
		<input type="hidden" name="sndBizNo"        value="<%=_BIZNO%>">
		<input type="hidden" name="sndCharset"      value="euc-kr">
		<input type="hidden" name="orderChannel"    value="<%=_ORDERCHANNEL%>">   
		<input type="hidden" name="rtapp"           value="<%=_RT_APP%>">		

	</form>
	
	<form name="PaycoAuthForm" method=post>
<input type="hidden" name="storeid"         value="<%=_STOREID%>">
<input type="hidden" name="MID"    			value="<%=MID%>">
<input type="hidden" name="device"    		value="<%=device%>">
<input type="hidden" name="TID"             value="<%=TID%>"/>
<input type="hidden" name="MallReserved"    value="<%=MallReserved%>"/>
<input type="hidden" name="ediDate"         value="<%=ediDate%>">
<input type="hidden" name="EncryptData"     value="<%=EncryptData%>">
<input type="hidden" name="BuyerEmail"		value="<%=BuyerEmail%>"> 
<input type="hidden" name="phoneno"         value="<%=BuyerTel%>">
<input type="hidden" name="BuyerName"		value="<%=BuyerName %>">
<input type="hidden" name="GoodsName"		value="<%=GoodsName %>">
<input type="hidden" name="PayMethod"       value="<%=PayMethod%>"/> 
<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
<input type="hidden" name="ResultYN"        value="<%=ResultYN%>"/>
<input type="hidden" name="RetryURL"        value="<%=RetryURL%>"/>
<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/>   
<input type="hidden" name="TID"             value="<%=TID%>"/>
<input type=hidden 	 name="Amt"          	value="<%=Amt%>">
<input type="hidden" name="Moid"			value="<%=Moid %>">         
<input type="hidden" name="mallUserID"      value="<%=mallUserID %>"/>
<input type="hidden" name="svcCd"      		value="<%=svcCd%>">
<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
<input type="hidden" name="User_ID"         value="<%=User_ID%>"/>
<input type="hidden" name="FORWARD"         value="<%=FORWARD%>"/>
<input type="hidden" name="EncodingType"    value="<%=EncodingType%>"/>
<input type="hidden" name="svcPrdtCd"       value="<%=svcPrdtCd%>">
<input type="hidden" name="MallIP"			value="<%=MallIP %>">
<input type="hidden" name="UserIP"          value="<%=UserIP%>">
<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
<input type="hidden" name="Currency"        value="<%=Currency%>"/>
<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
<input type="hidden" name="OfferingPeriod"  value="<%=OfferingPeriod%>"/>
<!-- Payco 변수 -->`
<input type="hidden" name="sellerOrderReferenceKey"       value="">
<input type="hidden" name="reserveOrderNo"       		  value="">
<input type="hidden" name="mccode"     					  value="">
<input type="hidden" name="pccode"     	 				  value="">
<input type="hidden" name="pcnumb"      				  value="">
<input type="hidden" name="paymentCertifyToken"      	  value="">
<input type="hidden" name="sellerKey"  					  value="">		
<input type="hidden" name="CardQuota" 					  value="">
<input type="hidden" name="TransType"       			  value=""/>	
<input type="hidden" name="EPayCl"          			  value="03">	
</form>

<div class="iphone" >
<iframe id="PAYCOFRAME2" name="PAYCOFRAME2" height="100%" width="100%" scrolling="no" frameborder="0"  marginwidth="0" marginheight="0" >
</iframe>
</div>
</body>
</html>