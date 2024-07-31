<%------------------------------------------------------------------------------
파일명     : KSPayCreditFormI.jsp
기능       : ISP인증승인용 카드정보입력용 페이지
-------------------------------------------------------------------------------%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.text.*" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%
	//신용카드승인종류 - 승인타입 : A-인증없는승인, N-인증승인, M-MPI인증승인, I-ISP인증승인
	String certitype		= "I" ;
	String authcode			= "I000" ;
	
	//기본거래정보
	String storeid      = request.getParameter("storeid");        //상점아이디
	String ordername    = request.getParameter("ordername");      //주문자명
	String ordernumber  = request.getParameter("ordernumber");    //주문번호
	String amount       = request.getParameter("amount");         //금액
	String goodname     = request.getParameter("goodname");       //상품명
	String email        = request.getParameter("email");          //주문자이메일
	String phoneno      = request.getParameter("phoneno");        //주문자휴대폰번호
	String currencytype = request.getParameter("currencytype");   //통화구분 : "WON" : 원화, "USD" : 미화
	String interesttype = request.getParameter("interesttype");
	
	String KVP_QUOTA_INF = "0:2:3:4:5:6:7:8:9:10:11:12";   //ISP용 할부개월수지정
	String KVP_NOINT_INF = "";
	//ISP용 무이자 할부개월 지정(BC:0100 / 국민:0204 / 우리:0700/ 수협:1800/ 전북:1600/ 광주:1500 )
	//Ex ) String KVP_NOINT_INF = "0204-3:4:5:6, 0100-3:4:5:6, 0700-3:4:5:6, 1800-3:4:5:6, 1600-3:4:5:6, 1500-3:4:5:6" ; - 각 카드사에 대해 3,4,5,6개월 할부건만 무이자처리
	//Ex ) String KVP_NOINT_INF ="ALL" - 모든개월수에 대하여 무이자처리함./ "NONE" - 모든개월수에 대하여 무이자처리하지않음.
	String KVP_CURRENCY = "";
	
	//interesttype으로 넘겨진 값으로 무이자처리
	if (interesttype.equals("ALL") || interesttype.equals("NONE"))
		KVP_NOINT_INF = interesttype;
	else if (interesttype.equals(""))
			KVP_NOINT_INF = "NONE";
	else 
			KVP_NOINT_INF = "0100-"+interesttype+", 0204-"+interesttype+", 0700-"+interesttype+", 1800-"+interesttype+", 1600-"+interesttype+", 1500-"+interesttype;
%>
<html>
<head>
<title>KSPay</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language=javascript src="https://www.vpay.co.kr/eISP/Wallet_layer_VP.js" charset="utf-8"></script>
<script language="javascript">
<!--
	StartSmartUpdate();
	
	function submit_isp(form) 
	{
		MakePayMessage(form);
	}
	
	function VP_Ret_Pay(ret) 
	{
		if(ret == true)
		{        
			document.KSPayAuthForm.action= "KSPayCreditPostMNI.jsp";
			document.KSPayAuthForm.submit();
		}
		else
		{
			alert("지불에 실패하였습니다.");
		}
	}
	// KBAPP
	function next() 
	{
		var sIndex = document.KSPayAuthForm.selectcard.value;

		// 카드사 선택 여부 체크
		//if (sIndex == 0) {
		//	alert('결제하실 카드사를 선택하시기 바랍니다.');
		//	document.KSPayAuthForm.selectcard.focus();
		//	return;
		//}
		document.KSPayAuthForm.KVP_CARDCOMPANY.value = document.KSPayAuthForm.selectcard.value ;
		
		if(document.KSPayAuthForm.selectcard.value == "0204"){
			document.kbapp_req.returnUrl.value = getReturnUrl();
			kbapp();
		}else{
			submit_isp(document.KSPayAuthForm) 
		}
	}
	function kbapp()
	{
		document.kbapp_req.submit();
	}
	function kbparamSet(ret, isptype, cardCode, quota,noint, cardPrefix, kb_app_otp)
	{
		if(ret == "TRUE"||ret == "true"||ret == true)
		{
			if(isptype=="2"){
			  submit_isp(document.KSPayAuthForm);
			}else{
				document.KSPayAuthForm.KVP_CARDCODE.value = cardCode;
				document.KSPayAuthForm.KVP_QUOTA.value = quota;
				document.KSPayAuthForm.KVP_NOINT.value = noint;
				document.KSPayAuthForm.KVP_CARD_PREFIX.value = cardPrefix ;
				document.KSPayAuthForm.kb_app_otp.value = kb_app_otp ;
				document.KSPayAuthForm.action= "KSPayCreditPostMNI.jsp";
				document.KSPayAuthForm.submit();
			}
		}else{
			alert("지불에 실패하였습니다.");
		}
	}
	function getReturnUrl()
	{
		var myloc = location.href;
		return myloc.substring(0, myloc.lastIndexOf('/')) + '/kbapp_return.jsp';	
	}
	// KBAPP
-->
</script>
<style type="text/css">
	BODY{font-size:9pt; line-height:160%}
	TD{font-size:9pt; line-height:160%}
	A {color:blue;line-height:160%; background-color:#E0EFFE}
	INPUT{font-size:9pt;}
	SELECT{font-size:9pt;}
	.emp{background-color:#FDEAFE;}
	.white{background-color:#FFFFFF; color:black; border:1x solid white; font-size: 9pt;}
</style>
</head>

<body onload="" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onFocus="" >
<form name=KSPayAuthForm method=post action="" onSubmit="">
<!--기본------------------------------------------------------------------>
<input type=hidden name="storeid"        value="<%=storeid%>">
<input type=hidden name="authty"         value="<%=authcode%>">
<input type=hidden name="certitype"      value="<%=certitype%>">

<!--일반신용카드---------------------------------------------------------->
<input type=hidden name="email"          value="<%=email%>">
<input type=hidden name="phoneno"        value="<%=phoneno%>">
<input type=hidden name="ordernumber"    value="<%=ordernumber%>">
<input type=hidden name="ordername"      value="<%=ordername%>">
<input type=hidden name="goodname"       value="<%=goodname%>">
<input type=hidden name="amount"         value="<%=amount%>">
<input type=hidden name="currencytype"   value="<%=currencytype%>">

<input type=hidden name="expdt"          value="">
<input type=hidden name="cardno"         value="">     <!--카드번호-->
<input type=hidden name="expyear"        value="">     <!--유효년-->
<input type=hidden name="expmon"         value="">     <!--유효월-->
<input type=hidden name="installment"    value="">     <!--할부-->
<input type=hidden name="lastidnum"      value="">     <!--생년월일-->
<input type=hidden name="passwd"         value="">     <!--비밀번호-->

<!--ISP------------------------------------------------------------>
<input type=hidden name=KVP_PGID         value="A0029">               <!-- PG -->
<input type=hidden name=KVP_SESSIONKEY   value="">                    <!-- 세션키  --> 
<input type=hidden name=KVP_ENCDATA      value="">                    <!-- 암호된데이터 -->
<input type=hidden name=KVP_CURRENCY     value="<%=currencytype%>">   <!-- 지불 화폐 단위 (WON/USD) : 한화 - WON, 미화 - USD-->
<input type=hidden name=KVP_NOINT        value="">                    <!-- 무이자구분(1:무이자,0:일반) -->
<input type=hidden name=KVP_QUOTA        value="">                    <!-- 할부 -->
<input type=hidden name=KVP_CARDCODE     value="">                    <!-- 카드코드 -->
<input type=hidden name=KVP_CONAME       value="">                    <!-- 카드명 -->
<input type=hidden name=KVP_RESERVED1    value="">                    <!-- 예비1 -->
<input type=hidden name=KVP_RESERVED2    value="">                    <!-- 예비2 -->
<input type=hidden name=KVP_RESERVED3    value="">                    <!-- 예비3 -->
<input type=hidden name=KVP_IMGURL       value="">
<input type=hidden name=KVP_QUOTA_INF    value="<%=KVP_QUOTA_INF%>">  <!--할부값-->
<input type=hidden name=KVP_GOODNAME     value="<%=goodname%>">       <!--상품명-->
<input type=hidden name=KVP_PRICE        value="<%=amount%>">         <!--금액-->
<input type=hidden name=KVP_NOINT_INF    value="<%=KVP_NOINT_INF%>">  <!--일반, 무이자-->
<input type=hidden name=KVP_CARDCOMPANY   value="">
<!--ISP------------------------------------------------------------>
<!--KBAPP------------------------------------------------------------>
<input type=hidden name=KVP_CARD_PREFIX  value="">
<input type=hidden name=kb_app_otp       value="">
<!--KBAPP------------------------------------------------------------>
<table border=0 width=0>
<tr>
<td align=center>
<table width=280 cellspacing=0 cellpadding=0 border=0 bgcolor=#4F9AFF>
<tr>
<td>
<table width=100% cellspacing=1 cellpadding=2 border=0>
<tr bgcolor=#4F9AFF height=25>
<td align=left><font color="#FFFFFF">
KSPay 신용카드 승인
<%
	if(certitype.equals("A"))        out.println("(인증없는승인)") ;
	else if(certitype.equals("N"))   out.println("(인증승인)") ;
	else if(certitype.equals("M"))   out.println("(M-MPI인증승인)") ;
	else if(certitype.equals("I"))   out.println("(I-ISP인증승인)") ;
%>
</font></td>
</tr>
<tr bgcolor=#FFFFFF>
<td valign=top>
<table width=100% cellspacing=0 cellpadding=2 border=0>
<tr>
<td align=left>
<table>
<tr>
	<td>상품명 :</td>
	<td><%=goodname%></td>
</tr>
<tr>
	<td>금액 :</td>
	<td><%=amount%></td>
</tr>
<tr>
	<td>신용카드종류 :</td>
	<td>
		<select name="selectcard">
			<option value="0" selected>카드를 선택하세요</option>
			<option value="0100">비씨</option>
			<option value="0204">국민</option>
			<option value="1800">수협</option>
			<option value="1600">전북</option>
			<option value="1500">광주</option>     
			<option value="0700">우리</option> 
		</select>
	</td>
</tr>
<tr>
	<td colspan=3><hr noshade size=1></td>
</tr>
<tr>
	<td colspan=2>
		<input type=button name=ISP onclick="next()" value="결제 ">
	</td>
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
<!-- kbapp카드 추가 START -->
<form id="kbapp_req" name="kbapp_req" method="post" target="kframe" action="http://kspay.ksnet.to/store/PAY_PROXY/credit/KBAPP/KSPayKbapp.jsp">
	<input type="hidden" name="storeid"             value="<%=storeid%>"/>                                                         <!-- 상점아이디 -->
	<input type="hidden" name="returnUrl"           value=""/>                                                                     <!-- returnUrl --> 
	<input type="hidden" name="kbapp_pay_type"      value="1"/>                                                                    <!-- 1. 온라인, 2. 모바일, 3: 오프라인 -->
	<input type="hidden" name="kbapp_shop_name"     value="테스트상점"/>                                                           <!-- 상점명  --> 
	<input type="hidden" name="kbapp_amount"        value="<%=amount%>"/>                                                          <!-- 승인금액  --> 
	<input type="hidden" name="kbapp_currency_type" value="410"/>                                                                  <!-- 통화코드 840 , 410 -->
	<input type="hidden" name="kbapp_entr_numb"     value="1208197322"/>                                                           <!-- 사업자 번호 -->
	<input type="hidden" name="kbapp_noint_inf"     value="<%=KVP_NOINT_INF%>"/>                                                   <!-- 일반, 무이자  -->
	<input type="hidden" name="kbapp_quota_inf"     value="<%=KVP_QUOTA_INF%>"/>                                                   <!-- 할부값  -->
	<input type="hidden" name="kbapp_order_no"      value="<%=ordernumber%>"/>                                                     <!-- 주문번호  -->
	<input type="hidden" name="kbapp_is_liquidity"  value=""/>                                                                     <!-- 환금성 상품 여부 ("Y": 환금성 상품, "N" 또는 "": 환금성 상품 아님)  -->
	<input type="hidden" name="kbapp_good_name"     value="<%=goodname%>"/>   																										 <!-- 상품명  -->
</form>
<iframe name="kframe" id="kframe" src="" width="0" height="0" frameBorder="0" style="display:none"></iframe>
<!-- kbapp카드 추가 END -->
</body>
</html>
