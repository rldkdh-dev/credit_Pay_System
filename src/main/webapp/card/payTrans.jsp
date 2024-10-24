<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 전문전송 (신용카드, mpi/key-in/해외)
*	@ PROGRAM NAME		: payTrans.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2009.02.04
*	@ PROGRAM CONTENTS	: 전문전송 (신용카드, mpi/key-in/해외)
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="../common/cardParameter.jsp" %>
<meta charset="utf-8">
<%
System.out.println("**** Start /card/payTrans.jsp ****");
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

	System.out.println("CARD payTrans.jsp  [device check]  " + device);
	Box box = new Box();
	Box resMemberInfo = null;
	Box resMerKeyBox = null;
	
	box.put("mid", MID);
	resMemberInfo = CommonBiz.getMemberInfo(box);
	resMerKeyBox = CommonBiz.getMemberKey(box);

/**
 * 2018.08 거래검증 기능 추가 Hans
**/
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
	
	// ISP 추가 -나라
	String KVP_ENCDATA_ENC = "";
	String KVP_SESSIONKEY_ENC = "";
	
	if(KVP_CARDCODE!=null && KVP_CARDCODE.length() > 0){		
		// KVP_CARDCODE = 05 0204 04 0015536
		// 브랜드(2자리) + 카드사(4자리) + 발행사(2자리) + 제휴코드(4~6자리)
		// 카드사(4자리)가 ‘0100’비씨, ‘0204’ 국민카드
		String strBrandCd	= CommonUtil.getDefaultStr(KVP_CARDCODE.substring(0, 2), "");
		String strCardCd	= CommonUtil.getDefaultStr(KVP_CARDCODE.substring(2, 6), "");
		
		String strComCd		= CommonUtil.getDefaultStr(KVP_CARDCODE.substring(6, 8), "");
		String strOtherCd	= CommonUtil.getDefaultStr(KVP_CARDCODE.substring(8), "");
		
		KVP_ENCDATA_ENC = CommonUtil.getDefaultStr(java.net.URLEncoder.encode(KVP_ENCDATA), "");
		KVP_SESSIONKEY_ENC = CommonUtil.getDefaultStr(java.net.URLEncoder.encode(KVP_SESSIONKEY), "");
		// ISP 추가 -나라
	}
	
    context = PGClient.getInstance().getConext("CARD_BL");
    System.out.println("KVP_ENCDATA_ENC : " + KVP_ENCDATA_ENC);	
    System.out.println("KVP_SESSIONKEY_ENC : " + KVP_SESSIONKEY_ENC);	
    System.out.println("context : " + context);	
	
    req = context.newGiftBox("NPG01WCD01"); // 카드 MPI 승인 요청 전문
	System.out.println("-------- 1step --------");
	// 전문공통
	req.put("Version"		,"NPG01");
	req.put("ID"			,"WCD01");
	req.put("EdiDate"		,TimeUtils.getyyyyMMddHHmmss());
	req.put("TID"			,TID);
	req.put("ErrorSys"		,"WEB");
	req.put("ErrorCD"		,"");
	req.put("ErrorMSG"		,"");
	// 상품정보
	req.put("GoodsCnt"		,GoodsCnt);
	req.put("GoodsName"		,GoodsName);
	// 2019.04 과세 면세 금액 설정 변경
	req.put("Amt"			,TaxAmt);
	req.put("DutyFreeAmt"	,DutyFreeAmt);
	req.put("MOID"			,Moid);
	req.put("Currency"		,"KRW");
	// 상점정보
	req.put("MID"			,MID);
	req.put("LicenseKey"	,resMerKeyBox.getString("mkey"));
	req.put("MallIP"		,MallIP);
	req.put("Language"		,"Kor");
	//out.println("MallReserved["+MallReserved+"]");
	//req.put("MallReserved"	,""); //상점예비
	req.put("ReturnURL"		,ReturnURL);
	//req.put("ResultYN"      ,ResultYN); // 결과창 유무
	req.put("RetryURL"		,RetryURL);
	// 구매자정보
	req.put("MallUserID"	,mallUserID);
	req.put("BuyerName"		,BuyerName);
	req.put("BuyerAuthNum"	,BuyerAuthNum);
	req.put("BuyerTel"		,BuyerTel);
	req.put("BuyerEmail"	,BuyerEmail);
	req.put("BuyerAddr"     ,BuyerAddr);
	req.put("BuyerPostNo"	,BuyerPostNo);
	req.put("ParentEmail"	,ParentEmail);
	req.put("MallReserved"	,MallReserved);
	// 결제자정보
	req.put("BrowserType"	,BrowserType);
	req.put("UserIP"		,UserIP);
	req.put("MAC"			,"");
	req.put("SUB_ID"			,SUB_ID);
	//SUB지불수단 추가
    req.put("SvcPrdtCd"     ,svcPrdtCd);
	
    req.put("User_ID"     ,User_ID);
    req.put("Pg_Mid"     ,Pg_Mid);
    req.put("OrderCode"     ,OrderCode);
    req.put("BuyerCode", BuyerCode);
	// 인터넷에서 휴대폰결제요청된 거래를 결제
	req.put("TransType", TransType);
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
	// 카드이벤트 처리
    // 카드사 무이자인 경우 CardInterest=0:일반
    // 가맹점부담 무이자인 경우에만 CardInterest=1
    // TODO : CardSvc 에서 추후 구현
    boolean isCardInterest = false; // default:일반

	System.out.println("**** CardExpire ["+CardExpire+"]");
	// 신용카드
	// CardBankCode는 일단 formBankCd를 넣어준다.
	req.put("CardType"		,cardType);
	req.put("AuthFlg"		,"02");
	req.put("CardBankCode"	,formBankCd);
	req.put("CardCode"		,formBankCd);
	req.put("CardNum"		,cardno); // 카드번호 MPI
	req.put("CardExpire"	,CardExpire);
	req.put("CardQuota"		,CardQuota);
	System.out.println("isCardInterest["+isCardInterest+"]");
    req.put("CardInterest"  ,isCardInterest == true ? "1" : "0");
	req.put("CardPwd"		,CardPwd);
	req.put("Below1000"		,CommonUtil.isBelow1000(Amt));
	req.put("CardPoint"		,CardPoint);
	// 카드 인증 정보
	req.put("CardXID"		,xid);
	req.put("CardECI"		,eci);
	req.put("CardCAVV"		,cavv);
	// ISP 추가 -나라
	req.put("ISPPGID"		,KVP_PGID);
	req.put("ISPCode"		,KVP_CARDCODE);
	req.put("ISPSessionKey"	,KVP_SESSIONKEY_ENC);
	req.put("ISPEncData"	,KVP_ENCDATA_ENC);
	// 국민앱카드의 경우 CAVV에 OTC번호(KVP_ENCDATA) 를 넣는다.
    KVP_ENCDATA_ENC = CommonUtil.getDefaultStr(KVP_ENCDATA, "");
    if("02".equals(formBankCd) && KVP_ENCDATA_ENC.length()>0){
        req.put("CardCAVV"      ,KVP_ENCDATA_ENC);
    }
    
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
	// 상품정보
	String resGoodsCnt			= rep.getString("GoodsCnt");
	String resGoodsName			= rep.getString("GoodsName");
	// 2019.04 과세금액+면세금액으로 변경
	long resAmt					= rep.getLong("Amt")+req.getLong("DutyFreeAmt", 0);
	String resMOID				= rep.getString("MOID");
	String resCurrency			= rep.getString("Currency");
	// 상점정보
	String resMID				= rep.getString("MID");
	String resLicenseKey		= rep.getString("LicenseKey");
	String resMallIP			= rep.getString("MallIP");
	String resLanguage			= rep.getString("Language");
	String resReturnURL			= rep.getString("ReturnURL");
	String resResultYN          = rep.getString("ResultYN"); // 결제창 유무
	String resRetryURL			= rep.getString("RetryURL");
	String resMallReserved      = rep.getString("MallReserved"); //상점예비
	// 구매자정보
	String resmallUserID		= rep.getString("MallUserID");
	String resBuyerName			= rep.getString("BuyerName");
	String resBuyerAuthNum		= rep.getString("BuyerAuthNum");
	String resBuyerTel			= rep.getString("BuyerTel");
	String resBuyerEmail		= rep.getString("BuyerEmail");
	String resParentEmail		= rep.getString("ParentEmail");
	String resBrowserType		= rep.getString("BrowserType");
	String resBuyerAddr		    = rep.getString("BuyerAddr");
	String resBuyerPostNo		= rep.getString("BuyerPostNo");
	// 결제자정보
	String resUserIP			= rep.getString("UserIP");
	String resMAC				= rep.getString("MAC");
	String resSUB_ID				= rep.getString("SUB_ID");
	// 결과코드
	String resName				= rep.getString("Name");
	String resPayMethod			= rep.getString("PayMethod");
	String resCardPwd			= rep.getString("CardPwd");
	String resAuthDate			= rep.getString("AuthDate");
	String resAuthCode			= rep.getString("AuthCode");
	String resResultCode		= rep.getString("ResultCode");
	String resResultMsg			= rep.getString("ResultMsg");	
	// 매입사코드
	String resAcquCardCode	= rep.getString("AcquCardCode");	
	String resAcquCardName	= rep.getString("AcquCardName");	 
	
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
		<input type="hidden" name="KVP_SESSIONKEY" value="<%=KVP_SESSIONKEY_ENC%>">
		<input type="hidden" name="KVP_ENCDATA" value="<%=KVP_ENCDATA_ENC%>">
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
    }catch(e){}
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
 