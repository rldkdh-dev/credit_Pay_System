<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 전문전송 (신용카드, 해외)
*	@ PROGRAM NAME		: payTransForeign.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2018.09.03
*	@ PROGRAM CONTENTS	: 전문전송 (신용카드, 해외)
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="../common/cardParameter.jsp" %>
<%
System.out.println("**** Start /card/payTransForeign.jsp ****");
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

boolean TEST=false;
	System.out.println("CARD payTransForeign.jsp  [device check]  " + device);
	Box box = new Box();
	Box resMemberInfo = null;
	Box resMerKeyBox = null;
	
	box.put("mid", MID);
	resMemberInfo = CommonBiz.getMemberInfo(box);
	resMerKeyBox = CommonBiz.getMemberKey(box);

    String merchantKey = resMerKeyBox.getString("mkey");
    String strEncData = CodecUtils.encodeMD5HexBase64(ediDate + MID + Amt + merchantKey);
    System.out.println("strEncData = " + strEncData);
    System.out.println("EncryptData = " + EncryptData);
    System.out.println("ediDate = " + ediDate);
    System.out.println("MID = " + MID);
    System.out.println("Amt = " + Amt);
    System.out.println("merchantKey = " + merchantKey);
    
    if(!"pgbcdplatm".equals(MID)) {
	    if(!EncryptData.equals(strEncData)){
	    	System.out.println("**********payTrans [거래검증 데이터가 일치하지 않습니다]**********");
	    	throw new Exception("W007");
	    }
    } else {
    	System.out.println("**********["+MID+"] [거래검증 예외처리]**********");
	}
	
	PGClientContext context = null;
	PGConnection con = null;
	GiftBox req = null;
	
    context = PGClient.getInstance().getConext("CARD_BL");	
    System.out.println("context : " + context);	
	
    req = context.newGiftBox("NPG01OCD01"); // 카드 해외 승인 요청 전문
	System.out.println("---------------------------------------------------------------------------------1step-----");
    
	String cardType = "";
	// cardType
	// 01: 개인, 02: 법인
	if(BuyerAuthNum.length() == 10) { // 법인
		cardType = "02";
	} else if(BuyerAuthNum.length() == 13) { // 개인
		cardType = "01";
	} else {
		cardType = "01";
	}

    //전문공통
	req.put("Version"		, "NPG01");
	req.put("ID"			, "OCD01");
	req.put("EdiDate"		, TimeUtils.getyyyyMMddHHmmss());
	req.put("TID"			, TID);
	req.put("ErrorSys"		, "WEB");
	req.put("ErrorCD"		, "");
	req.put("ErrorMSG"		, "");
	req.put("GoodsCnt"		, GoodsCnt);
	req.put("GoodsName"		, GoodsName);
	// 2019.04 과세 면세 금액 설정 변경
	req.put("Amt"			,TaxAmt);
	req.put("DutyFreeAmt"	,DutyFreeAmt);
	req.put("MOID"			, Moid);
	req.put("Currency"		, Currency);
	req.put("MID"			, MID);
	req.put("LicenseKey"	, resMerKeyBox.getString("mkey"));
	req.put("MallIP"		, MallIP);
	req.put("Language"		, "Kor");
	req.put("RetryURL"		, RetryURL);
	req.put("MallUserID"	, mallUserID);
	req.put("BuyerName"		, BuyerName);
	req.put("BuyerAuthNum"	, BuyerAuthNum);
	req.put("BuyerTel"		, BuyerTel);
	req.put("BuyerEmail"	, BuyerEmail);
	req.put("BuyerAddr"     , BuyerAddr);
	req.put("BuyerPostNo"	, BuyerPostNo);
	req.put("ParentEmail"	, ParentEmail);
	req.put("MallReserved"	, MallReserved);
	req.put("BrowserType"	, BrowserType);
	req.put("UserIP"		, UserIP);
	req.put("MAC"			, "");
	req.put("SUB_ID"		, SUB_ID);
    req.put("SvcPrdtCd"     , svcPrdtCd);
    req.put("User_ID"     	, User_ID);
    req.put("Pg_Mid"     	, Pg_Mid);
    req.put("OrderCode"     , OrderCode);
    req.put("BuyerCode"		, BuyerCode);
    
	req.put("CardType"		, cardType); //카드구분
	req.put("AuthFlg"		, "02"); //인증구분
	req.put("CardBankCode"	, formBankCd); //계열은행코드
	req.put("CardCode"		, formBankCd); //카드코드
	req.put("CardNum"		, EB_CARDNO); //카드번호
	req.put("CardExpire"	, EB_EXPIRYDT); //유효기간
	req.put("CardQuota"		, CardQuota); //할부개월
	
	// 카드이벤트 처리
    // 카드사 무이자인 경우 CardInterest=0:일반
    // 가맹점부담 무이자인 경우에만 CardInterest=1
    // TODO : CardSvc 에서 추후 구현
    boolean isCardInterest = false; // default:일반
    
	System.out.println("isCardInterest["+isCardInterest+"]");
    req.put("CardInterest"  ,isCardInterest == true ? "1" : "0"); //무이자여부

	req.put("CardPwd"		, CardPwd); //카드비밀번호
	req.put("Below1000"		, CommonUtil.isBelow1000(Amt)); //1000원 미만 사용 여부
	req.put("CardPoint"		, CardPoint); //카드사 포인트
	req.put("CardXID"		, EB_XID); //XID
	req.put("CardECI"		, EB_ECI); //ECI
	req.put("CardCAVV"		, EB_CAVV); //CAVV
	req.put("KeyinCl"		, ""); //key_in_cl
	req.put("TransType"		, TransType); //거래형태 
	req.put("SvcPrdtCd"		, svcPrdtCd); //SUB지불수단
	req.put("Cvc"			, EB_CVC); //카드CVC <!--  -->
	req.put("DccRateId"		, EB_BDCCRATEID); //DccRate시 수신받은ID
	req.put("AuthorizedId"	, EB_AUTHORIZEDID); //Enrollment시 수신받은ID
	req.put("DccCur"		, EB_BFOREIGNCUR); //고객에게 청구할 통화
	//req.put("DccCur"		, "KRW"); //고객에게 청구할 통화
	req.put("STCity"		, ""); //배송지도시
	req.put("STCountry"		, ""); //배송지국가
	req.put("STFirstName"	, ""); //배송지수신자명
	req.put("STLastName"	, ""); //배송지수신자명
	req.put("STPhoneNum"	, ""); //배송지수신자연락처
	req.put("STPostCode"	, ""); //배송지우편번호
	req.put("STState"		, ""); //배송지 주
	req.put("STStreet"		, ""); //배송지상세주소
    
	// 승인요청전문전송 
	System.out.println("-------- Before send --------");
	System.out.println("req:"+req);
	GiftBox rep = context.send(req); // 승인 전문 전송
	System.out.println("-------- After send --------");
	System.out.println("rep:"+rep);
	
	// 전문공통
	String resVersion			= rep.getString("Version");
	String resID				= rep.getString("ID");
	String resEdiDate			= rep.getString("EdiDate");
	String resLength			= rep.getString("Length");
	String resTID				= rep.getString("TID");
	String resErrorSys			= rep.getString("ErrorSys");
	String resErrorCD			= rep.getString("ErrorCD");
	String resErrorMSG			= rep.getString("ErrorMSG");
	String resGoodsCnt			= rep.getString("GoodsCnt");
	String resGoodsName			= rep.getString("GoodsName");
	// 2019.04 과세금액+면세금액으로 변경
	long resAmt					= rep.getLong("Amt")+req.getLong("DutyFreeAmt", 0);
	String resMOID				= rep.getString("MOID");
	String resCurrency			= rep.getString("Currency");
	String resMID				= rep.getString("MID");
	String resLicenseKey		= rep.getString("LicenseKey");
	String resMallIP			= rep.getString("MallIP");
	String resLanguage			= rep.getString("Language");
	String resReturnURL			= rep.getString("ReturnURL");
	String resResultYN          = rep.getString("ResultYN"); // 결제창 유무
	String resRetryURL			= rep.getString("RetryURL");
	String resMallReserved      = rep.getString("MallReserved"); //상점예비
	String resmallUserID		= rep.getString("MallUserID");
	String resBuyerName			= rep.getString("BuyerName");
	String resBuyerAuthNum		= rep.getString("BuyerAuthNum");
	String resBuyerTel			= rep.getString("BuyerTel");
	String resBuyerEmail		= rep.getString("BuyerEmail");
	String resParentEmail		= rep.getString("ParentEmail");
	String resBrowserType		= rep.getString("BrowserType");
	String resBuyerAddr		    = rep.getString("BuyerAddr");
	String resBuyerPostNo		= rep.getString("BuyerPostNo");
	String resUserIP			= rep.getString("UserIP");
	String resMAC				= rep.getString("MAC");
	String resSUB_ID			= rep.getString("SUB_ID");
	
	// 결과코드
	String resPayMethod         = rep.getString("PayMethod");
	String resAuthDate          = rep.getString("AuthDate");
	String resAuthCode          = rep.getString("AuthCode");
	String resResultCode        = rep.getString("ResultCode");
	String resResultMsg         = rep.getString("ResultMsg");
	String resUsePoint          = rep.getString("UsePoint");
	String resBalancePoint      = rep.getString("BalancePoint");
	String resAppCardCode       = rep.getString("AppCardCode");
	String resAppCardName       = rep.getString("AppCardName");
	String resAcquCardCode      = rep.getString("AcquCardCode");
	String resAcquCardName      = rep.getString("AcquCardName");
	String resCardMerchantNo    = rep.getString("CardMerchantNo");
	String resCardNum           = rep.getString("CardNum");
	String resCardQuota         = rep.getString("CardQuota");
	String resPgTid             = rep.getString("PgTid");
	String resBaseCur           = rep.getString("BaseCur");
	String resBaseAmt           = rep.getString("BaseAmt");
	String resBaseRate          = rep.getString("BaseRate");
	String resForeignCur        = rep.getString("ForeignCur");
	String resForeignAmt        = rep.getString("ForeignAmt");
	String resForeignRate       = rep.getString("ForeignRate");
	String resDccRate           = rep.getString("DccRate");

	Box reqBox = new Box();
	reqBox.put("col_nm", "card_cd");
	reqBox.put("code1", formBankCd);
	Box resFnNmCode1 = CommonBiz.getFnNmCode1(reqBox);
	System.out.println("**** formBankCd ["+formBankCd+"]");
	String card_nm = resFnNmCode1.getString("fn_nm_code1");
	
	JSONObject json = new JSONObject();
    json.put("action", "pay");
    json.put("PayMethod", PayMethod);
    json.put("MID", MID);
    json.put("TID", TID);
    json.put("mallUserID", mallUserID);
    json.put("BuyerName", java.net.URLEncoder.encode(BuyerName,"utf-8"));
    json.put("BuyerEmail", BuyerEmail);
    json.put("Amt", Amt);
    json.put("name", java.net.URLEncoder.encode(BuyerName,"utf-8"));
    json.put("GoodsName", java.net.URLEncoder.encode(GoodsName,"utf-8"));
    json.put("OID", Moid);
    json.put("MOID", Moid);
    json.put("AuthDate", resAuthDate);
    json.put("AuthCode", resAuthCode);
    json.put("ResultCode", resResultCode);
    json.put("ResultMsg", java.net.URLEncoder.encode(resResultMsg,"utf-8"));
    json.put("VbankNum", "");
    json.put("VbankName", "");
    json.put("MerchantReserved", "");
    json.put("MallReserved", java.net.URLEncoder.encode(MallReserved,"utf-8"));
    json.put("SUB_ID", SUB_ID);
    json.put("fn_cd", formBankCd);
    json.put("fn_name", java.net.URLEncoder.encode(card_nm,"utf-8"));
    json.put("CardQuota", CardQuota);
    json.put("AcquCardCode", resAcquCardCode);
    json.put("AcquCardName", java.net.URLEncoder.encode(resAcquCardName,"utf-8"));
    json.put("ErrorCode", resErrorCD);
    json.put("ErrorMsg", java.net.URLEncoder.encode(resErrorMSG,"utf-8"));
    json.put("BuyerAuthNum", BuyerAuthNum);
    json.put("ReceitType", "");
    json.put("VbankExpDate", "");
    json.put("VBankAccountName", "");
    System.out.println("json Data["+json.toString()+"]");
    String retURL = CommonUtil.getURLStr(ReturnURL, json);
    System.out.println("GET URL["+retURL+"]");
%>
    <form name="payMgr" method="post" action="">
    	<input type="hidden" name="PayMethod" value="<%=PayMethod%>">
		<input type="hidden" name="formBankCd" value="<%=formBankCd%>">
		<input type="hidden" name="GoodsCnt" value="<%=GoodsCnt%>">
		<input type="hidden" name="GoodsName" value="<%=GoodsName%>">
		<input type="hidden" name="GoodsURL" value="<%=GoodsURL%>">
		<input type="hidden" name="GoodsCl" value="<%=GoodsCl%>">
		<input type="hidden" name="Amt" value="<%=Amt%>">
		<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
		<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
		<input type="hidden" name="CardInterest" value="<%=CardInterest%>">	
		<input type="hidden" name="CardQuota" value="<%=CardQuota%>">
		<input type="hidden" name="Moid" value="<%=Moid%>">
		<input type="hidden" name="MID" value="<%=MID%>">
		<input type="hidden" name="ReturnURL" value="<%=ReturnURL%>">
		<input type="hidden" name="ResultYN" value="<%=ResultYN%>">
		<input type="hidden" name="RetryURL" value="<%=RetryURL%>">
		<input type="hidden" name="mallUserID" value="<%=mallUserID%>">
		<input type="hidden" name="BuyerName" value="<%=BuyerName%>">
		<input type="hidden" name="BuyerAuthNum" value="<%=BuyerAuthNum%>">
		<input type="hidden" name="BuyerTel" value="<%=BuyerTel%>">
		<input type="hidden" name="BuyerEmail" value="<%=BuyerEmail%>">
		<input type="hidden" name="ParentEmail" value="<%=ParentEmail%>">
		<input type="hidden" name="BuyerAddr" value="<%=BuyerAddr%>">
		<input type="hidden" name="BuyerPostNo" value="<%=BuyerPostNo%>">
		<input type="hidden" name="UserIP" value="<%=UserIP%>">
		<input type="hidden" name="MallIP" value="<%=MallIP%>">
		<input type="hidden" name="BrowserType" value="<%=BrowserType%>">
		<input type="hidden" name="CardPoint" value="<%=CardPoint%>">
		<input type="hidden" name="MallReserved" value="<%=MallReserved%>">
		<input type="hidden" name="TID" value="<%=TID%>">
		<input type="hidden" name="SUB_ID" value="<%=SUB_ID%>">
		<input type="hidden" name="eci" value="<%=eci%>">
		<input type="hidden" name="xid" value="<%=xid%>">
		<input type="hidden" name="cavv" value="<%=cavv%>">
		<input type="hidden" name="cardno" value="<%=cardno%>">
		<input type="hidden" name="joinCode" value="<%=joinCode%>">
		<input type="hidden" name="resAuthDate" value="<%=resAuthDate%>">
		<input type="hidden" name="resAuthCode" value="<%=resAuthCode%>">
		<input type="hidden" name="CardExpire" value="<%=CardExpire%>">
		<input type="hidden" name="CardPwd" value="<%=CardPwd%>">
		<input type="hidden" name="RefererURL" value="<%=RefererURL%>">
		<input type="hidden" name="FORWARD" value="<%=FORWARD%>">

		<input type="hidden" name="KVP_PGID" value="<%=KVP_PGID%>">
		<input type="hidden" name="KVP_GOODNAME" value="<%=KVP_GOODNAME%>">
		<input type="hidden" name="KVP_PRICE" value="<%=KVP_PRICE%>">
		<input type="hidden" name="KVP_CURRENCY" value="<%=KVP_CURRENCY%>">
		<input type="hidden" name="KVP_NOINT_INF" value="<%=KVP_NOINT_INF%>">
		<input type="hidden" name="KVP_QUOTA_INF" value="<%=KVP_QUOTA_INF%>">
		<input type="hidden" name="KVP_IMGURL" value="<%=KVP_IMGURL%>">
		<input type="hidden" name="KVP_NOINT" value="<%=KVP_NOINT%>">
		<input type="hidden" name="KVP_QUOTA" value="<%=KVP_QUOTA%>">
		<input type="hidden" name="KVP_CARDCODE" value="<%=KVP_CARDCODE%>">
		<input type="hidden" name="KVP_CONAME" value="<%=KVP_CONAME%>">
		<input type="hidden" name="KVP_SESSIONKEY" value="">
		<input type="hidden" name="KVP_ENCDATA" value="">
		<input type="hidden" name="KVP_RESERVED1" value="<%=KVP_RESERVED1%>">
		<input type="hidden" name="KVP_RESERVED2" value="<%=KVP_RESERVED2%>">
		<input type="hidden" name="KVP_RESERVED3" value="<%=KVP_RESERVED3%>">
		<%-- 에러코드 관련 --%>
		<input type="hidden" name="resErrorCD" value="<%=resErrorCD%>">
		<input type="hidden" name="resErrorMSG" value="<%=resErrorMSG%>">
		<input type="hidden" name="resResultCode" value="<%=resResultCode%>">
		<input type="hidden" name="resResultMsg" value="<%=resResultMsg%>">
		<input type="hidden" name="resAcquCardCode" value="<%=resAcquCardCode%>">
		<input type="hidden" name="resAcquCardName" value="<%=resAcquCardName%>">
	</form>
	
	<form name="transMgr" method="post" action="<%=ReturnURL%>">
         <input type="hidden" name="PayMethod" value="<%=PayMethod%>">
         <input type="hidden" name="MID" value="<%=MID%>">
         <input type="hidden" name="TID" value="<%=TID%>">
         <input type="hidden" name="mallUserID" value="<%=mallUserID%>">
         <input type="hidden" name="Amt" value="<%=Amt%>">
         <input type="hidden" name="TaxAmt" value="<%=TaxAmt%>"/>
		 <input type="hidden" name="DutyFreeAmt" value="<%=DutyFreeAmt%>"/>
         <input type="hidden" name="name" value="<%=BuyerName%>">
         <input type="hidden" name="GoodsName" value="<%=GoodsName%>">
         <input type="hidden" name="OID" value="<%=Moid%>">
         <input type="hidden" name="MOID" value="<%=Moid%>">
         <input type="hidden" name="AuthDate" value="<%=resAuthDate%>">
         <input type="hidden" name="AuthCode" value="<%=resAuthCode%>">
         <input type="hidden" name="ResultCode" value="<%=resResultCode%>">
         <input type="hidden" name="ResultMsg" value="<%=resResultMsg%>">
         <input type="hidden" name="VbankNum" value="">
         <input type="hidden" name="MerchantReserved" value="">
         <input type="hidden" name="MallReserved" value="<%=MallReserved%>">       
         <input type="hidden" name="SUB_ID" value="<%=SUB_ID%>">
         <input type="hidden" name="fn_cd" value="<%=formBankCd%>">
         <input type="hidden" name="fn_name" value="<%=card_nm%>">
         <input type="hidden" name="CardQuota" value="<%=CardQuota%>">
         <input type="hidden" name="BuyerEmail" value="<%=BuyerEmail%>">
         <input type="hidden" name="BuyerAuthNum" value="<%=BuyerAuthNum%>">
         <input type="hidden" name="ErrorCode" value="<%=resErrorCD%>">
         <input type="hidden" name="ErrorMsg" value="<%=resErrorMSG%>">
         <input type="hidden" name="AcquCardCode" value="<%=resAcquCardCode%>">
		 <input type="hidden" name="AcquCardName" value="<%=resAcquCardName%>">
		 <input type="hidden" name="FORWARD" value="<%=FORWARD%>">
    </form>
    <script type="text/javascript">
    <%-- WebView 결제결과 전송 --%>
    try {
    	var resultData = new Object();
    	
 		resultData.PayMethod = '<%=PayMethod%>';
 		resultData.MID = '<%=MID%>';
 		resultData.TID = '<%=TID%>';
 		resultData.mallUserID = '<%=mallUserID%>';
 		resultData.Amt = '<%=Amt%>';
 		resultData.name = '<%=BuyerName%>';
 		resultData.GoodsName = '<%=GoodsName%>';
 		resultData.OID = '<%=Moid%>';
 		resultData.MOID = '<%=Moid%>';
 		resultData.AuthDate = '<%=resAuthDate%>';
 		resultData.AuthCode = '<%=resAuthCode%>';
 		resultData.ResultCode = '<%=resResultCode%>';
 		resultData.ResultMsg = '<%=resResultMsg%>';
 		resultData.MerchantReserved = '';
 		resultData.MallReserved = '<%=MallReserved%>';
 		resultData.fn_cd = '<%=formBankCd%>';
 		resultData.fn_name = '<%=card_nm%>';
 		resultData.CardQuota = '<%=CardQuota%>';
 		resultData.BuyerEmail = '<%=BuyerEmail%>';
 		resultData.BuyerAuthNum = '<%=BuyerAuthNum%>';
 		resultData.ErrorCode = '<%=resErrorCD%>';
 		resultData.ErrorMsg = '<%=resErrorMSG%>';
          
         var jsonData = JSON.stringify(resultData);
         
	    if( /Android/i.test(navigator.userAgent)) {	// 안드로이드
	     	Javascript:window.PayAppBridge.PayResult(jsonData);
	   	} else if (/iPhone|iPad|iPod/i.test(navigator.userAgent)) {	// iOS 아이폰, 아이패드, 아이팟
	         window.webkit.messageHandlers.payResult.postMessage(jsonData);
	   	} else {	// 그 외 디바이스
	   	}
    } catch (e) {
	}
    <%-- 결제로직 전송후 form submit --%>
    function goPayMgrSubmit() {
    	var formNm = document.payMgr;
    <%if(resResultCode.equals("3001")){%>
       	formNm.action = "payResult_card.jsp";
    <%}else{%>
       	formNm.action = "payResultFail_card.jsp";
    <%}%>    	
    	formNm.submit();
    	return true;
    }
    </script>
	<script type="text/javascript">
		if("euc-kr"=="<%=EncodingType%>"){
			try{document.charset="euc-kr";}catch(exception){}
		}else{
			try{document.charset="utf-8";}catch(exception){}
		}
	<%	if("Y".equals(ResultYN)){%>
			goPayMgrSubmit();	
	<%	}else{
			if(StringUtils.isNotEmpty(ReturnURL)){%>
				var url = "<%=retURL%>";
		       	try{
			    	if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
			    		opener.location.href=url;
			    		window.open('', '_self', '');
			    	    window.close();
			    	}else if((window.parent!=null&&window.parent!=undefined)||('X'=='<%=FORWARD%>')){
			    		parent.location.href= url;
					}else{
						location.href = url;
					}
				}catch(e){}
	<%		}else{%>
				try{
			    	if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
			    		window.open('', '_self', '');
			    	    window.close();
			    	}else if((window.parent!=null&&window.parent!=undefined)||('X'=='<%=FORWARD%>')){
						window.parent.postMessage('<%=json.toString()%>','*');
					}else{
					}
				}catch(e){}
	<%		}%>
	<%	}%>
	</script>