<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 전문전송 (계좌이체)
*	@ PROGRAM NAME		: payTrans.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2018.01.15
*	@ PROGRAM CONTENTS	: 전문전송 (계좌이체)
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="service.SupportIssue" %>
<%@ page import="kr.co.infinisoft.pg.client.PGClientContext" %>
<%@ page import="kr.co.infinisoft.pg.client.PGConnection" %>
<%@ page import="kr.co.infinisoft.pg.client.PGClient" %>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.document.GiftBox" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%@ page import="kr.co.seeroo.spclib.SPCLib, org.json.simple.JSONObject"%>
<%@ page import="kr.co.infinisoft.pg.common.*" %>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%-- 공통 common include --%>
<%@ include file="../common/commonParameter.jsp" %>
<%-- 계좌이체 파라미터 --%>
<%@ include file="../common/bankParameter.jsp" %>
<meta charset="utf-8">
<%
	System.out.println("**** Start /bank/payTrans.jsp ****");
    String TID     = CommonUtil.getDefaultStr(request.getParameter("TID"), "");
    
	Box box = new Box();
	Box resMerKeyBox = null;
	box.put("mid", MID);
	resMerKeyBox = CommonBiz.getMemberKey(box);
	   
    if(resMerKeyBox == null || resMerKeyBox.getString("mkey") == null) {        
        throw new Exception("W009"); // 상점서명키를 확인해 주세요.       
    }
    
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
	        System.out.println("**********bank payTrans [거래검증 데이터가 일치하지 않습니다]**********");
	        throw new Exception("W007");
	    }	
    } else {
    	System.out.println("**********["+MID+"] [거래검증 예외처리]**********");
	}
    
	PGClientContext context = null;
	PGConnection con = null;
	GiftBox req = null;
	
	context = PGClient.getInstance().getConext("BANK_BL");
	
	req = context.newGiftBox("NPG01BNK01");
		
	// 전문공통
	req.put("Version"		,"NPG01");
	req.put("ID"			,"BNK01");
	req.put("EdiDate"		,TimeUtils.getyyyyMMddHHmmss());
	req.put("TID"			,TID);
	req.put("ErrorSys"		,"WEB");
	req.put("ErrorCD"		,"");
	req.put("ErrorMSG"		,"");
	// 상품정보
	req.put("GoodsCnt"		,GoodsCnt);
	req.put("GoodsName"		,GoodsName);
	req.put("Amt"			,Amt);
	req.put("MOID"			,Moid);
	req.put("Currency"		,"KRW");
	// 상점정보	
	req.put("MID"			,MID);
	req.put("LicenseKey"	,resMerKeyBox.getString("mkey"));	
	req.put("MallIP"		,MallIP);
	req.put("Language"		,"Kor");
	req.put("MallReserved"	,java.net.URLDecoder.decode(MallReserved,"UTF-8")); //상점예비
	req.put("ReturnURL"		,ReturnURL);
	req.put("RetryURL"		,RetryURL);
	// 구매자정보
	req.put("MallUserID"	,mallUserID);
	req.put("BuyerName"		,BuyerName);
	req.put("BuyerAuthNum"	,BuyerAuthNum);
	req.put("BuyerTel"		,BuyerTel);
	req.put("BuyerEmail"	,BuyerEmail);
	req.put("ParentEmail"	,ParentEmail);
	req.put("BuyerAddr"	    ,BuyerAddr);
	req.put("BuyerPostNo"   ,BuyerPostNo);
	// 결제자정보
	req.put("BrowserType"	,BrowserType);
	req.put("UserIP"		,UserIP);
	req.put("MAC"			,"");
	req.put("SUB_ID"		,SUB_ID);
	req.put("SvcPrdtCd"     ,svcPrdtCd);
	
	// 계좌이체
	req.put("BankCode"			,BankCode);
	req.put("BankAccount"		,"");
	req.put("BankAccountName"	,"");
	req.put("BankSessionKey"	,hd_ep_type);
	req.put("BankEncData"		,hd_pi);
	req.put("BankRemainAmt"		,"");
	req.put("TransType"		,TransType);
	req.put("User_ID", User_ID);
	System.out.println("payTrans.jsp TransType["+TransType+"]");
	
    System.out.println("**** Bank req:"+req);	
	GiftBox rep = context.send(req);
	System.out.println("**** Bank rep:"+rep);
	
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
	long resAmt					= rep.getLong("Amt");
	String resMOID				= rep.getString("MOID");
	String resCurrency			= rep.getString("Currency");
	// 상점정보
	String resMID				= rep.getString("MID");
	String resLicenseKey		= rep.getString("LicenseKey");
	String resMallIP			= rep.getString("MallIP");
	String resLanguage			= rep.getString("Language");	 
	String resReturnURL			= rep.getString("ReturnURL");	
	String resResultYN          = rep.getString("ResultYN"); // 결제창 보기 유무
	String resRetryURL			= rep.getString("RetryURL");
	String resMallReserved      = java.net.URLEncoder.encode(rep.getString("MallReserved"),"UTF-8");
	// 구매자정보
	String resmallUserID		= rep.getString("MallUserID");
	String resBuyerName			= rep.getString("BuyerName");
	String resBuyerAuthNum		= rep.getString("BuyerAuthNum");
	String resBuyerTel			= rep.getString("BuyerTel");
	String resBuyerEmail		= rep.getString("BuyerEmail");
	String resParentEmail		= rep.getString("ParentEmail");
	String resBuyerAddr		    = rep.getString("BuyerAddr");
	String resBuyerPostNo		= rep.getString("BuyerPostNo");
	// 결제자정보
	String resBrowserType		= rep.getString("BrowserType");
	String resUserIP			= rep.getString("UserIP");
	String resMAC				= rep.getString("MAC");
	String resSUB_ID				= rep.getString("SUB_ID");
	// 결과코드
	String resName				= rep.getString("Name");
	String resOID				= rep.getString("OID");
	String resPayMethod			= rep.getString("PayMethod");
	String resAuthDate			= rep.getString("AuthDate");
	String resAuthCode			= rep.getString("AuthCode");
	String resResultCode		= rep.getString("ResultCode");
	String resResultMsg			= rep.getString("ResultMsg");	
	String wi = rep != null ? rep.getString("WI") : "";
	String resBankCd = "";
	String resBankName = "";
	
	// 계좌이체 결제 정보 
    Box resTransInfo = null;
    Box resFnNmCode1 = null;
    box = new Box();
    box.put("mid" , MID);
    box.put("tid", TID);
    resTransInfo = CommonBiz.getBankTransInfo(box);
    if(resTransInfo!=null){
    	resBankCd = resTransInfo.getString("bank_cd");
    	box.put("col_nm", "bank_cd");
        box.put("code1", resTransInfo.getString("bank_cd"));
        resFnNmCode1 = CommonBiz.getFnNmCode1(box);
        if(resFnNmCode1!=null) resBankName = resFnNmCode1.getString("fn_nm_code1");
    }
    
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
    json.put("BankCd", resBankCd);
    json.put("BankName", java.net.URLEncoder.encode(resBankName,"utf-8"));
    json.put("MerchantReserved", "");
    json.put("MallReserved", java.net.URLEncoder.encode(MallReserved,"utf-8"));
    json.put("SUB_ID", SUB_ID);
    json.put("ErrorCode", resErrorCD);
    json.put("ErrorMsg", java.net.URLEncoder.encode(resErrorMSG,"utf-8"));
    json.put("BuyerAuthNum", BuyerAuthNum);
    json.put("ReceiptType", cashReceiptType);
    json.put("ReceitType", cashReceiptType);
    System.out.println("json Data["+json.toString()+"]");
    String retURL = CommonUtil.getURLStr(ReturnURL, json);
    System.out.println("GET URL["+retURL+"]");   
%>
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
		resultData.BuyerAuthNum = '<%=BuyerAuthNum%>';
		resultData.BankCd = '<%=resBankCd%>';
		resultData.BankName = '<%=resBankName%>';
		resultData.VbankExpDate = '<%=VbankExpDate%>';
		resultData.VBankAccountName = '<%=VBankAccountName%>';
		resultData.ResultCode = '<%=resResultCode%>';
		resultData.ResultMsg = '<%=resResultMsg%>';
		resultData.ReceiptType = '<%=cashReceiptType%>';
		resultData.ReceitType = '<%=cashReceiptType%>';
		resultData.MerchantReserved = '';
		resultData.MallReserved = '<%=MallReserved%>';
		resultData.fn_cd = '<%=formBankCd%>';
		resultData.BuyerName = '<%=BuyerName%>';
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
<%if(resResultCode.equals("4000")){%>
	formNm.action = "payResult.jsp";
<%}else{%>
	formNm.action = "payResultFail.jsp";
<%}%>	
	payMgr.submit();
	return true;
}
<%-- 계좌이체후 나온 결과값 전송 --%>
function JsResult() {
	var jswi = document.payMgr.wi.value;	
	payResult(jswi);
}
</script>
<form name="payMgr" method="post" action="">
    <%-- 상점에서 입력하는 파라미터 --%>
    <input type="hidden" name="PayMethod" value="<%=PayMethod%>">
    <input type="hidden" name="TID" value="<%=TID%>">
    <input type="hidden" name="GoodsCnt" value="<%=GoodsCnt%>">
    <input type="hidden" name="GoodsName" value="<%=GoodsName%>">
    <input type="hidden" name="GoodsURL" value="<%=GoodsURL%>">
    <input type="hidden" name="GoodsCl" value="<%=GoodsCl%>">
    <input type="hidden" name="Amt"    value="<%=Amt%>">
    <input type="hidden" name="Moid"   value="<%=Moid%>">
    <input type="hidden" name="MID"    value="<%=MID%>">
    <input type="hidden" name="ReturnURL" value="<%=ReturnURL%>">
    <input type="hidden" name="ResultYN" value="<%=ResultYN%>">
    <input type="hidden" name="FORWARD"    value="<%=FORWARD%>">
    <input type="hidden" name="RetryURL" value="<%=RetryURL%>">
    <input type="hidden" name="mallUserID" value="<%=mallUserID%>">
    <input type="hidden" name="BuyerName" value="<%=BuyerName%>">
    <input type="hidden" name="BuyerAuthNum" value="<%=BuyerAuthNum%>">
    <input type="hidden" name="BuyerTel" value="<%=BuyerTel%>">
    <input type="hidden" name="BuyerEmail" value="<%=BuyerEmail%>">
    <input type="hidden" name="BuyerAddr"   value="<%=BuyerAddr%>">
    <input type="hidden" name="BuyerPostNo" value="<%=BuyerPostNo%>">   

    <input type="hidden" name="UserIP" value="<%=UserIP%>">
    <input type="hidden" name="MallIP" value="<%=MallIP%>">
    <input type="hidden" name="BrowserType" value="<%=BrowserType%>">
    <input type="hidden" name="BankCode"    value="<%=BankCode%>">
    <input type="hidden" name="cashReceiptType" value="<%=cashReceiptType%>">
    <input type="hidden" name="receiptTypeNo" value="<%=receiptTypeNo%>">
    <input type="hidden" name="MallReserved" value="<%=MallReserved%>">
    <input type="hidden" name="SUB_ID"       value="<%=SUB_ID%>">
    <input type="hidden" name="RefererURL"   value="<%=RefererURL%>">
    
    <%-- 계좌이체에서 사용하는 파라미터 --%>
    <input type="hidden" name="hd_pre_msg_type" value="<%=hd_pre_msg_type%>">
	<input type="hidden" name="hd_msg_code" value="<%=hd_msg_code%>">
	<input type="hidden" name="hd_msg_type" value="<%=hd_msg_type%>">
	<input type="hidden" name="hd_ep_type" value="<%=hd_ep_type%>">
	<input type="hidden" name="hd_pi" value="<%=hd_pi%>">
	<input type="hidden" name="hd_approve_no" value="<%=hd_approve_no%>">
	<input type="hidden" name="hd_serial_no" value="<%=hd_serial_no%>">
	<input type="hidden" name="hd_firm_name" value="<%=hd_firm_name%>">
	<input type="hidden" name="tx_amount" value="<%=tx_amount%>">
    <input type=hidden   name="tx_user_define" value="<%=tx_user_define%>">
    <input type=hidden   name="tx_user_key" value=""><!-- 승인요청시 TID -->
    <input type=hidden   name="tx_receipt_bank" value="<%=tx_receipt_bank%>">
	<input type="hidden" name="hd_input_option" value="<%=hd_input_option%>">
	<input type="hidden" name="hd_ep_option" value="<%=hd_ep_option%>">
	<input type="hidden" name="hd_timeout_yn" value="<%=hd_timeout_yn%>">
	<input type="hidden" name="hd_timeout" value="<%=hd_timeout%>">
	<input type="hidden" name="tx_email_addr" value="<%=tx_email_addr%>">
    <input type="hidden" name="wi" value="<%=wi%>">
    <%-- 결과페이지에 사용하는 파라미터  --%>
    <input type="hidden" name="resAuthDate" value="<%=resAuthDate%>">
    <input type="hidden" name="resAuthCode" value="<%=resAuthCode%>">
    <input type="hidden" name="resErrorCD" value="<%=resErrorCD%>">
    <input type="hidden" name="resErrorMSG" value="<%=resErrorMSG%>">
    <input type="hidden" name="resResultCode" value="<%=resResultCode%>">
    <input type="hidden" name="resResultMsg" value="<%=resResultMsg%>">   
    <input type="hidden" name="receiptType" value="<%=receiptType%>">
</form>
<!-- 가맹점으로 바로 전송되는 파라미터 -->
<form name="transMgr" method="post" action="<%=ReturnURL%>">
    <input type="hidden" name="PayMethod" value="<%=PayMethod%>">
    <input type="hidden" name="MID" value="<%=MID%>">
    <input type="hidden" name="TID" value="<%=TID%>">
    <input type="hidden" name="mallUserID" value="<%=mallUserID%>">
    <input type="hidden" name="BuyerName"	value="<%=BuyerName%>">
    <input type="hidden" name="BuyerEmail"  value="<%=BuyerEmail%>">
    <input type="hidden" name="Amt" value="<%=Amt%>">
    <input type="hidden" name="name" value="<%=BuyerName%>">
    <input type="hidden" name="GoodsName" value="<%=GoodsName%>">
    <input type="hidden" name="OID" value="<%=Moid%>">
    <input type="hidden" name="MOID" value="<%=Moid%>">
    <input type="hidden" name="AuthDate" value="<%=resAuthDate%>">
    <input type="hidden" name="AuthCode" value="<%=resAuthCode%>">
    <input type="hidden" name="ResultCode" value="<%=resResultCode%>">
    <input type="hidden" name="ResultMsg" value="<%=resResultMsg%>">
    <input type="hidden" name="BankCd"   value="<%=resBankCd%>">
    <input type="hidden" name="BankName"   value="<%=resBankName%>">
    <input type="hidden" name="MerchantReserved" value="">
    <input type="hidden" name="MallReserved" value="<%=MallReserved%>">
    <input type="hidden" name="SUB_ID" value="<%=SUB_ID%>">
    <input type="hidden" name="ErrorCode" value="<%=resErrorCD%>">
    <input type="hidden" name="ErrorMsg" value="<%=resErrorMSG%>">
    <input type="hidden" name="BuyerAuthNum" value="<%=BuyerAuthNum%>">
    <input type="hidden" name="ReceiptType" value="<%=cashReceiptType%>">
</form>
<%
	if(resResultCode.equals("4000")) {
				// 성공시 처리로직
				// 현금영수증 발행
				if(cashReceiptType.equals("1")
						|| cashReceiptType.equals("2")
						|| cashReceiptType.equals("4")
						|| cashReceiptType.equals("5")
						|| cashReceiptType.equals("7")
						|| cashReceiptType.equals("8")) {
					
					context = PGClient.getInstance().getConext("CASH_BL");
					
					req = context.newGiftBox("NPG01RCP01");
		    		
		    		//전문공통
		    		req.put("Version", "NPG01");							// 버전
		    		req.put("ID", "RCP01");									// 전문ID
		    		req.put("PayMethod", "CASHRCPT");                       // 전문ID
		    		req.put("EdiDate", TimeUtils.getyyyyMMddHHmmss());		// 전문생성일시
		    		req.put("TID", TID);									// 거래아이디
		    		req.put("ErrorSys", "WEB");								// 에러시스템명	,상점MALL, 웹서버:WEB, PG서버: PGS
		    		req.put("ErrorCD", "");									// 에러코드		,정상:00000 에러: 전문ID 
		    		req.put("ErrorMSG", "");								// 에러메세지	,전문 에러
		    		//상품정보
		    		req.put("GoodsCnt", GoodsCnt);							// 상품갯수
		    		req.put("GoodsName", GoodsName);						// 상품명
		    		req.put("Amt",TaxAmt);									// 과세금액
		    		req.put("DutyFreeAmt",DutyFreeAmt);						// 면세금액
		    		req.put("MOID", Moid);									// 상품주문번호
		    		req.put("Currency", "KRW");								// 통화구분
		    		//상점정보
		    		req.put("MID", MID);									// 상점아이디
		    		req.put("LicenseKey", resMerKeyBox.getString("mkey"));	// 상점서명인증키
		    		req.put("MallIP", MallIP);								// 상점서버IP
		    		req.put("Language", "Kor");								// 사용언어
		    		req.put("MallReserved", MallReserved);					// 상점예비정보
		    		req.put("ReturnURL", ReturnURL);						// 상점 결제결과 전송 URL
		    		req.put("RetryURL", RetryURL);							// 상점 결제결과 Retry URL
		    		//구매자정보
		    		req.put("MallUserID", mallUserID);						// 회원사고객ID
		    		req.put("BuyerName", BuyerName);						// 구매자명
		    		req.put("BuyerAuthNum", BuyerAuthNum);					// 구매자인증번호
		    		req.put("BuyerTel", BuyerTel);							// 구매자연락처
		    		req.put("BuyerEmail", BuyerEmail);						// 구매자메일주소
		    		req.put("ParentEmail", ParentEmail);					// 보호자메일주소
		    		req.put("BuyerAddr", BuyerAddr);						// 배송지주소
		    		req.put("BuyerPostNo", BuyerPostNo);					// 우편번호
		    		//결제자정보
		    		req.put("BrowserType", BrowserType);					// 브라우저 종류 및 버전
		    		req.put("UserIP", UserIP);								// 회원사고객 IP
		    		req.put("MAC", "");										// 회원사고객 MAC
		    		req.put("SUB_ID", SUB_ID);								// 서브몰아이디
		    		req.put("SvcPrdtCd", svcPrdtCd);                             // 현금영수증 서브지불수단 01 고정
		    		//현금영수증
		    		req.put("ReceiptAmt", Amt);								// 현금영수증 총금액
		    		req.put("ReceiptSupplyAmt", ((long)Math.ceil((new Long(Amt)*10) / 11)));	// 현금영수증 공급가액
		    		req.put("ReceiptVAT", (new Long(Amt) - (long)Math.ceil((new Long(Amt)*10) / 11)));		// 현금영수증 부가세
		    		req.put("ReceiptServiceAmt", "");						// 현금영수증 봉사료
		    		req.put("ReceiptIdentity", receiptTypeNo);					// 현금영수증 인증번호
		    		
		    		// 현금영수증 용도구분		,0: 미발행, 1 : 발행(개인 소득공제), 2 : 발행(사업자 지출증빙) 3: 자진발급
		    		if(cashReceiptType.equals("2")
		    				|| cashReceiptType.equals("5")
		    				|| cashReceiptType.equals("8")) {
		    			req.put("ReceiptType", "2");
		    			receiptType = "2";
		    		} else if(cashReceiptType.equals("1")
		    				|| cashReceiptType.equals("4")
		    				|| cashReceiptType.equals("7")) {
		    			req.put("ReceiptType", "1");
		    			receiptType = "1";
		    		}else{
		    			req.put("ReceiptType", "0");
		    			receiptType = "0";
		    		}
		    		
                    System.out.println("**** NPG01RCP01 req {}"+req);		    		
		    		rep = context.send(req);
					System.out.println("**** NPG01RCP01 rep {}"+rep);
			}else{
				receiptType = "0";
			}
	}
%>
<script type="text/javascript">
//Webview Bridge 추가 
try{
    if( /Android/i.test(navigator.userAgent)) { // 안드로이드
        Javascript:window.PayAppBridge.PayResult('<%=json.toString()%>');
    } else if (/iPhone|iPad|iPod/i.test(navigator.userAgent)) { // iOS 아이폰, 아이패드, 아이팟
         window.webkit.messageHandlers.payResult.postMessage('<%=json.toString()%>');
    }
}catch(e){}


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
