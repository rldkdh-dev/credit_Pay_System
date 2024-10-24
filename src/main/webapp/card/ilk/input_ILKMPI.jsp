<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="java.net.SocketException"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.httpclient.HttpStatus"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@ include file="../../common/cardParameter.jsp" %>
<% 

	// Cache 의존 제거
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	System.out.println("-------- input_ILKMPI.jsp Start --------");
	
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
	
	String pointUseYN 	= CommonUtil.getDefaultStr(request.getParameter("pointUseYN"), "");
	String VbankExpDate = CommonUtil.getDefaultStr(request.getParameter("VbankExpDate"), "");
	String co_no 		= CommonUtil.getDefaultStr(request.getParameter("co_no"), "");
	String co_nm 		= CommonUtil.getDefaultStr(request.getParameter("co_nm"), "");
	String bankCd 		= CommonUtil.getDefaultStr(request.getParameter("formBankCd"), "");
	String fn_no 		= CommonUtil.getDefaultStr(request.getParameter("fn_no"),"");
	String bankCd_ispm  = CommonUtil.getDefaultStr(request.getParameter("bankCd_ispm"),"");
	String prot 		= request.getScheme();
	String curPage 		= HttpUtils.getRequestURL(request).toString();
	String returnPage 	= prot + curPage.substring(curPage.indexOf(':'), curPage.lastIndexOf('/')) + "/mobileReturn.jsp";  
	
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
	
	function goSelectDummyCardNo(bankCd) {
		if ( bankCd == '<%=CommonConstants.CARD_CD_CITI%>' ) {
			return "4539350000000007";
		} else if ( bankCd == '<%=CommonConstants.CARD_CD_KEB%>' ) {
	        return "4599300000000000";
		} else if ( bankCd == '<%=CommonConstants.CARD_CD_HANA%>' ) {
			return "4570473000000007";
		} else if ( bankCd == '<%=CommonConstants.CARD_CD_SUHYUP%>' ) {
			return "4567029000000006";
		} else if ( bankCd == '<%=CommonConstants.CARD_CD_JB%>' ) {
			return "4599030000000000";
		} else if ( bankCd == '<%=CommonConstants.CARD_CD_KDB%>' ) {
	        return "4655230000000000";
	    } else if ( bankCd == '<%=CommonConstants.CARD_CD_WOORI%>' ) {
	        return "5387200000000001";
	    }
	}
	 
	function submitPage() {
         var frm = document.Visa3d;
         var bankCd = document.tranMgr.formBankCd.value;
         var cardNo = goSelectDummyCardNo(bankCd);
         
         var af = document.getElementById("ILK");
         af.style.display = 'block';
         af.style.height = '75%';
         af.style.width = '100%';

         frm.purchase_amount.value = '<%=Amt%>';
         frm.pan.value = cardNo;
         frm.action = '../ilk/veri_host_mobile.jsp';
         frm.submit();
         return true;
         
	 }
	
	function goPayment(){		
		var formNm = document.tranMgr;
		formNm.action = "../payConfirm_card_m.jsp";
		formNm.submit();
	 } 
	
	//ILK => 실제 결제페이지로 넘겨주는 form에 xid, eci, cavv, cardno를 세팅한다.
	function paramSet(xid, eci, cavv, realPan, proceed) {
		if(proceed  == "true"){
			var frm = document.tranMgr;
			frm.xid.value = xid;
			frm.eci.value = eci;
			frm.cavv.value = cavv;
			frm.cardno.value = realPan;
			/*
			if(!(ss_useyn_ke == "null")){
				frm.CardPoint.value = '2';
		    }	   
			if(savekind == '41'){
		    	frm.CardQuota.value = "41";
		    }else if(savekind == '40'){
		        frm.CardQuota.value = 40+parseInt(formNm.CardQuota.value);
		    }
			*/
			goPayment(); 
		}
	}
</script>
</head>
<body onload="javascript:submitPage();">
<form style="height:100%" name="tranMgr" method="post" action="">
<input type="hidden" name="PayMethod"		value="<%=PayMethod%>"/>
<input type="hidden" name="pointUseYN"		value="<%=pointUseYN%>"/>
<input type="hidden" name="formBankCd"		value="<%=formBankCd%>"/>
<input type="hidden" name="GoodsCnt"		value="<%=GoodsCnt%>"/>
<input type="hidden" name="GoodsName"		value="<%=GoodsName%>"/>
<input type="hidden" name="GoodsURL"		value="<%=GoodsURL%>"/>
<input type="hidden" name="Amt"				value="<%=Amt%>"/>
<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
<input type="hidden" name="CardInterest"    value="<%=CardInterest%>"/>
<input type="hidden" name="CardQuota"       value="<%=CardQuota%>"/>
<input type="hidden" name="CardPoint"    	value="0"/>
<input type="hidden" name="Moid"			value="<%=Moid%>"/>
<input type="hidden" name="MID"				value="<%=MID%>"/>
<input type="hidden" name="ReturnURL"		value="<%=ReturnURL%>"/>
<input type="hidden" name="ResultYN"        value="<%=ResultYN%>"/>
<input type="hidden" name="RetryURL"		value="<%=RetryURL%>"/>
<input type="hidden" name="mallUserID"		value="<%=mallUserID%>"/>
<input type="hidden" name="BuyerName"		value="<%=BuyerName%>"/>
<input type="hidden" name="Noint_Inf" 		value="<%=CardQuota%>" >
<input type="hidden" name="BuyerAuthNum"	value="<%=BuyerAuthNum%>"/>
<input type="hidden" name="BuyerTel"		value="<%=BuyerTel%>"/>
<input type="hidden" name="BuyerEmail"		value="<%=BuyerEmail%>"/>
<input type="hidden" name="ParentEmail"		value="<%=ParentEmail%>"/>
<input type="hidden" name="BuyerAddr"		value="<%=BuyerAddr%>"/>
<input type="hidden" name="BuyerPostNo"		value="<%=BuyerPostNo%>"/>
<input type="hidden" name="UserIP"			value="<%=UserIP%>"/>
<input type="hidden" name="MallIP"			value="<%=MallIP%>"/>
<input type="hidden" name="BrowserType"		value="<%=BrowserType%>"/>
<input type="hidden" name="VbankExpDate"    value="<%=VbankExpDate%>"/>
<input type="hidden" name="TID"				value="<%=TID%>"/>
<input type="hidden" name="quotabase"	    value="<%=quotabase%>"/>
<input type="hidden" name="MallReserved"    value="<%=MallReserved%>"/>
<input type="hidden" name="MallResultFWD"   value="<%=MallResultFWD%>"/> 
<input type="hidden" name="EncodingType"   	value="<%=EncodingType%>"/> 
<input type="hidden" name="OfferingPeriod"  value="<%=OfferingPeriod%>"/> <%-- 제공 기간 변수 --%>
<input type="hidden" name="device" 			value="<%=device%>"><%-- 테스트 모드 변수 --%>
<input type="hidden" name="svcCd"           value="<%=svcCd%>">
<input type="hidden" name="bankCd_ispm" 	value="<%=bankCd_ispm%>">
<input type="hidden" name="svcPrdtCd"       value="<%=svcPrdtCd%>">
<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
<input type="hidden" name="User_ID"         value="<%=User_ID%>">
<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
<input type="hidden" name="BuyerCode"       value="<%=BuyerCode%>">
<input type="hidden" name="MerchantNo_ispm" value="<%=fn_no%>">
<input type="hidden" name="FORWARD"         value="<%=FORWARD%>">
<input type="hidden" name="EncryptData"     value="<%=EncryptData%>"> <!-- 거래검증값 추가(2018.08 hans) -->
<input type="hidden" name="ediDate"         value="<%=ediDate%>">
<input type="hidden" name="RefererURL" 		value="<%=RefererURL%>">
<input type="hidden" name="issuerCode" 		value="">
<!-- MPI Data -->
<input type="hidden" name="eci"/>
<input type="hidden" name="xid"/>
<input type="hidden" name="cavv"/>
<input type="hidden" name="cardno"/>
<input type="hidden" name="joinCode"/>
<input type="hidden" name="hs_useamt_sh">
<input type="hidden" name="realPan"/>
<input type="hidden" name="ss_useyn">
<input type="hidden" name="savekind">
<input type="hidden" name="ss_useyn_ke">
<%-- 결제처리후 받을 파라미터값 (from isp) --%>
<input type=hidden name="KVP_PGID"        value="<%=KVP_PGID%>"/>
<input type=hidden name="KVP_GOODNAME"    />
<input type=hidden name="KVP_PRICE"       value="<%=KVP_PRICE%>"/>
<input type=hidden name="KVP_CURRENCY"    />
<input type=hidden name="KVP_NOINT_INF"   />
<input type=hidden name="KVP_QUOTA_INF"   />
<input type=hidden name="KVP_IMGURL"      />
<input type=hidden name="KVP_NOINT"       />
<input type=hidden name="KVP_QUOTA"       />
<input type=hidden name="KVP_CARDCODE"    />
<input type=hidden name="KVP_CONAME"      />
<input type=hidden name="KVP_SESSIONKEY"  />
<input type=hidden name="KVP_ENCDATA"     />
<input type=hidden name="KVP_RESERVED1"   />
<input type=hidden name="KVP_RESERVED2"   />
<input type=hidden name="KVP_RESERVED3"   />
<div class="innopay" >
    <section class="innopay_wrap" style="height:100%">
        <header class="gnb">
            <h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="../../images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
            <div class="kind">
                <span>신용카드결제</span>
            </div>
        </header>
          <div class="contents iPhone_scroll" style="height:100%; width:100%;padding-top:51px;" align="center;position:absolute;">
            <iframe id="ILK" name="ILK" align="middle" style="height:100%; min-height:100%; display:none;margin-bottom:16px;" frameborder="0" src="../xansim/iframe.jsp"></iframe>      
        </div>
        <!-- Notice -->
		<%@ include file="/common/notice.jsp" %>        
    </section>
</div>
</form>
<FORM name=Visa3d target=ILK method=post>
	<INPUT type="hidden" name=pan             value="">    <!-- 카드번호(필수) -->
	<INPUT type="hidden" name=expiry          value="">    <!-- 유효기간(국내:4912, 해외비자:카드유효기간) -->
	<INPUT type="hidden" name=purchase_amount value="">    <!-- 금액(필수, 오로지 숫자로만, 콤마, 소수점 불가) -->
	<INPUT type="hidden" name=amount          size="20" maxlength="20" value="1000">
	<INPUT type="hidden" name=description     size="80" maxlength="80" value="none">
	<INPUT type="hidden" name=currency        value="410"> <!-- 통화코드(원화(한):410, 달러(미):840) -->
	<INPUT type="hidden" name=device_category size="20" maxlength="20" value="0">
	<INPUT type="hidden" name="hostid" size="20"  value="">
	<INPUT type="hidden" name="goodsname" size="20"  value="<%=GoodsName%>">
	<INPUT type="hidden" name="hostpwd" size="20" value="">
	<INPUT type="hidden" name="name" size="20"    value="<%=co_nm%>">
	<INPUT type="hidden" name="url" size="20"     value="http://www.ilkr.com">
	<INPUT type="hidden" name="country" size="20" value="410">
	<INPUT type="hidden" name="useActiveX" value="Y">
	<INPUT type="hidden" name="returnUrl" value="<%=returnPage%>">
	<INPUT type="hidden" name="apvl_chain_no" value="">	<!-- 가맹점번호 -->
	<INPUT type="hidden" name="apvl_seller_id" value="<%=co_no%>">	<!-- 사업자번호 -->
	<INPUT type="hidden" name="apvl_halbu" value="00">	<!-- 할부 -->
</FORM>
</body>
</html>