<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="java.net.SocketException"%>
<%@page import="java.io.IOException"%>
<%@ include file="../../common/cardParameter.jsp" %>
<% 
// Cache 의존 제거
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

String pointUseYN 	= CommonUtil.getDefaultStr(request.getParameter("pointUseYN"), "");
String VbankExpDate = CommonUtil.getDefaultStr(request.getParameter("VbankExpDate"), "");
String co_no 		= CommonUtil.getDefaultStr(request.getParameter("co_no"), "");
String co_nm 		= CommonUtil.getDefaultStr(request.getParameter("co_nm"), "");
String bankCd 		= CommonUtil.getDefaultStr(request.getParameter("formBankCd"), "");
String _spChainCode  = CommonUtil.getDefaultStr(request.getParameter("sp_chain_code"), "0");
String _fnNo         = CommonUtil.getDefaultStr(request.getParameter("fn_no"), "");
///////////////
//System.out.println("co_nm["+co_nm+"]");
//System.out.println("GoodsName["+GoodsName+"]");
//System.out.println("co_nm["+co_nm+"]");

System.out.println("---- Start /card/input_XMPI.jsp ----");

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
    	var bankCd =document.tranMgr.formBankCd.value;
        var purchaseAmt = '<%=Amt%>';   
        var currency = '410';       
        var cardName = '';
        var orderNo = '<%=Moid%>';             
        var orderUserId = '<%=mallUserID%>';    
        var orderSubBizNo = '<%=co_no%>';       
        var orderMallName = '<%=co_nm%>';   
        var orderEtc1;
        var orderEtc2 = ''; 
        var orderGoods = '<%=GoodsName%>';
        var spChainCode = '<%=_spChainCode%>';
        var fnNo = '<%=_fnNo%>';
        var useyn = 'N';
        
        if (orderSubBizNo == '1248702232') { // 자가매출 구분을 위해 추가
              orderEtc1 = 'TOMATO'; // 8.[옵션] 여분 필드1
        } else {
              orderEtc1 = '';           // 8.[옵션] 여분 필드1
        }
    	
        if(fnNo == null || fnNo == ""){  // 카드사 가맹점 번호
            useyn='N';
        }else{
            useyn='Y';
        }
        
        if (bankCd == '<%=CommonConstants.CARD_CD_SAMSUNG%>'){
            cardName = 'SAMSUNGCARD';
        }else if (bankCd == '<%=CommonConstants.CARD_CD_LOTTE%>'){
            cardName = 'LOTTECARD';
        }else if (bankCd == '<%=CommonConstants.CARD_CD_HD%>'){
            cardName = 'HYUNDAICARD';   //(2007.5.30 현대카드 추가)
        }else if (bankCd == '<%=CommonConstants.CARD_CD_SH%>'){
            cardName = 'SHINHANCARD';   //(2007.8.30 신한카드 추가)
        }else if (bankCd == '<%=CommonConstants.CARD_CD_CJ%>'){
            cardName = 'JEJUBANK'; //(2008.8.01 제주은행 추가)
        }else if (bankCd == '<%=CommonConstants.CARD_CD_NH%>'){
            cardName = 'NONGHYUPCARD';
        }
        
        var af = document.getElementById("X_ANSIM_FRAME");
        var widthSize;
        var heightSize;
        
        if (cardName == 'LOTTECARD') {
            widthSize = '96%';
            heightSize = (window.innerHeight-50)+'px';
        }else {
            widthSize = '96%';
            heightSize = (window.innerHeight-50)+'px';
        }
        
        af.style.display = 'block';
        af.style.height = heightSize;
        af.style.width = widthSize;
        
        var result;
        if(cardName == 'LOTTECARD'){
        	result = dosps(purchaseAmt, currency,cardName, orderNo,orderUserId, orderSubBizNo, orderMallName, orderEtc1, orderEtc2, spChainCode);
        }else{
        	//result = doXansim(purchaseAmt,currency,cardName,orderNo,orderUserId,orderSubBizNo,orderMallName,orderEtc1,orderEtc2,orderGoods);
        	var _ansimForm = document.XansimForm;
            
            _ansimForm.order_amount.value = purchaseAmt;
            _ansimForm.order_currency.value = currency;
            _ansimForm.order_cardname.value = cardName;
            _ansimForm.order_no.value = orderNo;
            _ansimForm.order_userid.value = orderUserId;
            _ansimForm.order_business.value = orderSubBizNo;
            _ansimForm.order_mname.value = orderMallName;
            _ansimForm.order_etc1.value = orderEtc1;
            _ansimForm.order_etc2.value = orderEtc2;
            _ansimForm.sp_chain_code.value = spChainCode;    // 0:일반결제, 1:간편(삼성,신한,현대), 3:앱카드
            _ansimForm.order_goods.value = orderGoods;
            _ansimForm.order_fnno.value = fnNo;
            _ansimForm.order_useyn.value = useyn;
        	result = doXansim();
        }
        
        if(!result){
        	returnIndex();
        }
        
    }
  
    function returnIndex(){
    	var _frm = document.tranMgr;
        _frm.action = "../index_card_m.jsp";
        _frm.submit();
    }
    
	// 2016.02.02 by.sbs
    // SMPI 인증 시작 function
    function dosps (purchaseAmt, currency,cardName, orderNo,orderUserId, orderSubBizNo, orderMallName, orderEtc1, orderEtc2, chain_code) {
        var form = document.spsForm;
        form.order_amount.value = purchaseAmt;
        form.order_currency.value = currency;
        form.order_cardname.value = cardName;
        form.order_no.value = orderNo;
        form.order_userid.value = orderUserId;
        form.order_business.value = orderSubBizNo;
        form.order_mname.value = orderMallName;
        
        form.apvl_chain_no_lt.value = '1248702232';
        //form.apvl_seller_id_lt.value = '2068511698';
        
        //form.apvl_chain_no_lt.value = document.mallForm.apvl_chain_no_lt.value;   //가맹점번호?
        //form.apvl_seller_id_lt.value = document.mallForm.apvl_seller_id_lt.value; //사업자번호?
        //form.MBRNO.value = document.mallForm.order_userid.value;                  //가맹점고객번호
        //form.REGNO.value = document.mallForm.REGNO.value;                         //가맹점ID
        //form.IOS_RETURN_APP.value = document.mallForm.IOS_RETURN_APP.value;   
        
        if(chain_code=='3'){
            form.PAY.value='APC';
        }else{
            form.PAY.value='SPS';
        }
        
        form.action = '../rocomo/m_SMPIAgent01.jsp';
        form.submit();
        return true;
    }
	
 // XMPI 인증 시작 function
    //function doXansim (purchaseAmt,currency,cardName,orderNo,orderUserId,orderSubBizNo,orderMallName,orderEtc1,orderEtc2,orderGoods) {
    function doXansim () {
    	var formnm = document.XansimForm;
        /* 
    	formnm.order_amount.value = purchaseAmt;
        formnm.order_currency.value = currency;
        formnm.order_cardname.value = cardName;
        formnm.order_no.value = orderNo;
        formnm.order_userid.value = orderUserId;
        formnm.order_business.value = orderSubBizNo;
        formnm.order_mname.value = orderMallName;
        formnm.order_etc1.value = orderEtc1;
        formnm.order_etc2.value = orderEtc2;
        formnm.order_goods.value = orderGoods;
         */
        formnm.action = "./m_hagent01.jsp";
        formnm.submit();
	 
        return true;	 
    }
	
	function receiveMessage(event)
	{
	  eval(event.data);
	}

	addEventListener("message", receiveMessage, false);
	
	function setCertResult(r0, msg, xid, eci, cavv, cardno, joinCode, hs_useamt_sh) {
		if(r0 != "0000"){
			
			returnIndex();
		}else{
			var formNm = document.tranMgr;
			formNm.xid.value = xid;
			formNm.eci.value = eci;
			formNm.cavv.value = cavv;
			formNm.cardno.value = cardno;
			formNm.joinCode.value = joinCode;
			formNm.hs_useamt_sh.value = hs_useamt_sh;
			if(hs_useamt_sh!=undefined && hs_useamt_sh!="null" && hs_useamt_sh!=''){
				formNm.CardPoint.value = '2';
			}
			goPayment();
		}
	}
	
	function goPayment(){
		var formNm = document.tranMgr;
		formNm.action = "../payConfirm_card_m.jsp";
		formNm.submit();
	} 
</script>
</head>
<body onload="javascript:doProcess();">
<form name="tranMgr" method="post" action="">
<input type="hidden" name="PayMethod"		value="<%=PayMethod%>"/>
<input type="hidden" name="pointUseYN"		value="<%=pointUseYN%>"/>
<input type="hidden" name="formBankCd"		value="<%=bankCd%>"/>
<input type="hidden" name="GoodsCnt"		value="<%=GoodsCnt%>"/>
<input type="hidden" name="GoodsName"		value="<%=GoodsName%>"/>
<input type="hidden" name="GoodsURL"		value="<%=GoodsURL%>"/>
<input type="hidden" name="Amt"				value="<%=Amt%>"/>
<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
<input type="hidden" name="CardInterest"    value="<%=CardInterest%>"/>
<input type="hidden" name="CardQuota"    value="<%=CardQuota%>"/>
<input type="hidden" name="CardPoint"    	value="0"/>
<input type="hidden" name="Moid"			value="<%=Moid%>"/>
<input type="hidden" name="MID"				value="<%=MID%>"/>
<input type="hidden" name="ReturnURL"		value="<%=ReturnURL%>"/>
<input type="hidden" name="ResultYN"        value="<%=ResultYN%>"/>
<input type="hidden" name="RetryURL"		value="<%=RetryURL%>"/>
<input type="hidden" name="mallUserID"		value="<%=mallUserID%>"/>
<input type="hidden" name="BuyerName"		value="<%=BuyerName%>"/>
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
<input type="hidden" name="svcPrdtCd"      value="<%=svcPrdtCd%>">
<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
<input type="hidden" name="User_ID"         value="<%=User_ID%>">
<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
<input type="hidden" name="BuyerCode"      value="<%=BuyerCode%>">
<input type="hidden" name="FORWARD"        value="<%=FORWARD%>">
<input type="hidden" name="EncryptData"    value="<%=EncryptData%>"> <!-- 거래검증값 추가(2018.08 hans) -->
<input type="hidden" name="ediDate"        value="<%=ediDate%>">
<input type="hidden" name="RefererURL"    value="<%=RefererURL%>">
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

<div class="innopay">
    <section class="innopay_wrap">

        <header class="gnb">
            <h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="../../images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
            <div class="kind">
                <span>신용카드결제</span>
            </div>
        </header>
        
        <div class="contents" style="height:100%;margin-top:45px;padding-top:5px;background-color:#FFFFFF" align="center">
            <iframe id="X_ANSIM_FRAME" name="X_ANSIM_FRAME" align="middle" style="display:none;margin-bottom:16px;" frameborder="0" src="../xansim/iframe.jsp" ></iframe>
            
            <section class="footer">
        		<span>INNOPAY 1688 - 1250</span>
    		</section>
                
        </div>
            
        <!-- Notice -->
		<%@ include file="/common/notice.jsp" %>
        
    </section>
</div>
</form>
<form name="XansimForm" method="POST" target="X_ANSIM_FRAME">
	<input type="hidden" name=order_amount value="">
	<input type="hidden" name=order_currency value="">
	<input type="hidden" name=order_cardname value="">
	<input type="hidden" name=order_no value="">
	<input type="hidden" name=order_userid value="">
	<input type="hidden" name=order_business value="">
	<input type="hidden" name=order_mname value="">
	<input type="hidden" name=order_etc1 value="">
	<input type="hidden" name=order_etc2 value="">
	<input type="hidden" name="sp_chain_code" value="">
	<input type="hidden" name="order_goods" value="">
	<input type="hidden" name="order_fnno" value="">
    <input type="hidden" name="order_useyn" value="">
</form>
<!-- 2016.02.02 by.sbs  -->
<!-- SMPI Form & iframe 영역시작 -->
<form name="spsForm" method="POST" target="X_ANSIM_FRAME">
<input type="hidden" name=order_amount value="">
<input type="hidden" name=order_currency value="">
<input type="hidden" name=order_cardname value="">
<input type="hidden" name=order_no value="">
<input type="hidden" name=MBRNO value="">
<input type="hidden" name=order_userid value="">
<input type="hidden" name=MOBILE value="Y">
<input type="hidden" name="REGNO" value="M201602032232P">
<input type="hidden" name="mId" value="M201602032232P">
<input type="hidden" name=order_business value="">
<input type="hidden" name=order_mname value="">
<input type="hidden" name=apvl_chain_no_lt value="">
<input type="hidden" name=apvl_seller_id_lt value="">
<input type="hidden" name=PAY value="SPS">
<input type="hidden" name=IOS_RETURN_APP value="">
</form>
</body>
</html>