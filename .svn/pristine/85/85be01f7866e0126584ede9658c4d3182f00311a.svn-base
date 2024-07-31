<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 전문전송 (가상계좌)
*	@ PROGRAM NAME		: payTrans.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2018.01.05
*	@ PROGRAM CONTENTS	: 전문전송 (가상계좌)
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
<meta charset="utf-8">
<%
System.out.println("**** Start /vbank/payTrans.jsp ****");
    
	String TID     = CommonUtil.getDefaultStr(request.getParameter("TID"), "");
    String resVbankNum = null;
        
	Box box = new Box();
	Box resMerKeyBox = null;

	box.put("mid", MID);
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
	        System.out.println("**********bank payTrans [거래검증 데이터가 일치하지 않습니다]**********");
	        throw new Exception("W007");
	    }   
    } else {
		System.out.println("**********["+MID+"] [거래검증 예외처리]**********");
	}
	
	PGClientContext context = null;
	PGConnection con = null;
	GiftBox req = null;
	
	context = PGClient.getInstance().getConext("VBANK_BL");
	
	req = context.newGiftBox("NPG01VBK01");
	
	// 전문공통
	req.put("Version"		,"NPG01");
	req.put("ID"			,"VBK01");
	req.put("EdiDate"		,TimeUtils.getyyyyMMddHHmmss());
	req.put("TID"			,TID);
	req.put("ErrorSys"		,"WEB");
	req.put("ErrorCD"		,"");
	req.put("ErrorMSG"		,"");
	// 상품정보
	req.put("GoodsCnt"		,GoodsCnt);
	req.put("GoodsName"		,GoodsName);
	req.put("Amt"			,TaxAmt);
	req.put("DutyFreeAmt"	,DutyFreeAmt);
	req.put("MOID"			,Moid);
	req.put("Currency"		,"KRW");
	// 상점정보
	req.put("MID"			,MID);
	req.put("LicenseKey"	,resMerKeyBox.getString("mkey"));
	req.put("MallIP"		,MallIP);
	req.put("Language"		,"Kor");
	req.put("ReturnURL"		,ReturnURL);
	req.put("RetryURL"		,RetryURL);
	req.put("MallReserved"  ,MallReserved);  // 상점예비
	// 구매자정보
	req.put("MallUserID"	,mallUserID);
	req.put("BuyerName"		,BuyerName);
	req.put("BuyerAuthNum"	,BuyerAuthNum);
	req.put("BuyerTel"		,BuyerTel);
	req.put("BuyerEmail"	,BuyerEmail);
	req.put("ParentEmail"	,ParentEmail);
	req.put("BuyerAddr"	    ,BuyerAddr);
	req.put("BuyerPostNo"	,BuyerPostNo);
	// 결제자정보
	req.put("BrowserType"	,BrowserType);
	req.put("UserIP"		,UserIP);
	req.put("MAC"			,"");
	req.put("SUB_ID"	    ,SUB_ID);
	// 가상계좌
	req.put("VbankCnt"				,"1");
	req.put("VbankBankCode"			,BankCode);
	req.put("VbankExpDate"			,VbankExpDate.replace(".", ""));
	req.put("VBankAccountName"		,VBankAccountName);
	req.put("VbankRefundAccount"	,"");
	req.put("VbankRefundBankCode"	,"");
	req.put("VbankRefundName"		,"");
	//현금영수증
	req.put("ReceiptAmt", Amt);								// 현금영수증 총금액
	req.put("ReceiptSupplyAmt", ((long)Math.ceil((new Long(Amt)*10) / 11)));	// 현금영수증 공급가액
	req.put("ReceiptVAT", (new Long(Amt) - (long)Math.ceil((new Long(Amt)*10) / 11)));		// 현금영수증 부가세
	req.put("ReceiptServiceAmt", "");						// 현금영수증 봉사료
	req.put("ReceiptIdentity", receiptTypeNo);					// 현금영수증 인증번호	
	req.put("TransType",TransType);
	//req.put("ReceiptType", receiptType);
	req.put("ReceiptType", cashReceiptType);
	
	// 현금영수증 용도구분		,1 : 발행(개인 소득공제), 2 : 발행(사업자 지출증빙) 3[0]: 미발행
	if(!cashReceiptType.equals("1") && !cashReceiptType.equals("2")){  // 미발행
		req.put("ReceiptAmt", "0");
        req.put("ReceiptSupplyAmt", "0");   
        req.put("ReceiptVAT", "0");     
        req.put("ReceiptServiceAmt", "");
        req.put("ReceiptIdentity", "");                 // 현금영수증 인증번호
	}
   
	req.put("SvcPrdtCd", svcPrdtCd);  // 
	req.put("OrderCode", OrderCode);  //   필요시 설정
	req.put("BuyerCode", BuyerCode);  //   필요시 설정
	req.put("User_ID", User_ID);
    
	
	// 환불시 사용할 계좌번호, 계좌번호 은행 코드, 계좌주명은 추후 확정
	//req.put("VbankRefundAccount"	,VbankRefundAccount);
	//req.put("VbankRefundBankCode"	,VbankRefundBankCode);
	//req.put("VbankRefundName"		,VbankRefundName);
	System.out.print("**** req:"+req);
	GiftBox rep = context.send(req);
	System.out.print("**** rep:"+rep);
	
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
	String resMallReserved		= rep.getString("MallReserved");  // 상점예비
	String resReturnURL			= rep.getString("ReturnURL");
	String resResultYN          = rep.getString("ResultYN");
	String resRetryURL			= rep.getString("RetryURL");
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
//	String resName				= rep.getString("Name");
	String resPayMethod			= rep.getString("PayMethod");
	String resAuthDate			= rep.getString("AuthDate");
	String resAuthCode			= rep.getString("AuthCode");
	String resResultCode		= rep.getString("ResultCode");
	String resResultMsg			= rep.getString("ResultMsg");
	resVbankNum					= rep.getString("VbankNum");
	
    // 은행명 조회
	Box resFnNmCode1 = null;
	box.put("col_nm", "bank_cd");
	box.put("code1", BankCode);
	resFnNmCode1 = CommonBiz.getFnNmCode1(box);
	
	String VbankName = resFnNmCode1.getString("fn_nm_code1");
	
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
    json.put("VbankNum", resVbankNum);
    json.put("VbankName", java.net.URLEncoder.encode(VbankName,"utf-8"));
    json.put("MerchantReserved", "");
    json.put("MallReserved", java.net.URLEncoder.encode(MallReserved,"utf-8"));
    json.put("SUB_ID", SUB_ID);
    json.put("ErrorCode", resErrorCD);
    json.put("ErrorMsg", java.net.URLEncoder.encode(resErrorMSG,"utf-8"));
    json.put("BuyerAuthNum", BuyerAuthNum);
    json.put("ReceiptType", cashReceiptType);
    json.put("ReceitType", cashReceiptType);
    json.put("VbankExpDate", VbankExpDate);
    json.put("VBankAccountName", java.net.URLEncoder.encode(VBankAccountName,"utf-8"));
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
		resultData.VbankNum = '<%=resVbankNum%>';
		resultData.VbankName = '<%=VbankName%>';
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
<%if(resResultCode.equals("4100")){%>
	formNm.action = "payResult.jsp";
<%}else{%>
	formNm.action = "payResultFail.jsp";
<%}%>		
	formNm.submit();
}
</script>
<form name="payMgr" method="post" action="">
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
	<input type="hidden" name="RetryURL" value="<%=RetryURL%>">
	<input type="hidden" name="mallUserID" value="<%=mallUserID%>">
	<input type="hidden" name="BuyerName" value="<%=BuyerName%>">
	<input type="hidden" name="BuyerAuthNum" value="<%=BuyerAuthNum%>">
	<input type="hidden" name="BuyerTel" value="<%=BuyerTel%>">
	<input type="hidden" name="BuyerEmail" value="<%=BuyerEmail%>">
	<input type="hidden" name="ParentEmail" value="<%=ParentEmail%>">
	<input type="hidden" name="BuyerAddr"   value="<%=BuyerAddr%>">
	<input type="hidden" name="BuyerPostNo" value="<%=BuyerPostNo%>">
	<input type="hidden" name="UserIP" value="<%=UserIP%>">
	<input type="hidden" name="MallIP" value="<%=MallIP%>">
	<input type="hidden" name="VbankExpDate" value="<%=VbankExpDate%>">
	<input type="hidden" name="BrowserType" value="<%=BrowserType%>">
	<input type="hidden" name="BankCode"    value="<%=BankCode%>">
	<input type="hidden" name="VBankAccountName" value="<%=VBankAccountName%>">
	<input type="hidden" name="cashReceiptType" value="<%=cashReceiptType%>">
	<input type="hidden" name="receiptTypeNo" value="<%=receiptTypeNo%>">
	<input type="hidden" name="resVbankNum" value="<%=resVbankNum%>">
	<input type="hidden" name="MallReserved" value="<%=MallReserved%>">
	<input type="hidden" name="SUB_ID"       value="<%=SUB_ID%>">
	<input type="hidden" name="EncodingType"    value="<%=EncodingType%>">
    <input type="hidden" name="OfferingPeriod"   value="<%=OfferingPeriod%>"/> 
    <input type="hidden" name="device"      value="<%=device%>">
    <input type="hidden" name="svcCd"      value="<%=svcCd%>">
    <input type="hidden" name="svcPrdtCd"      value="<%=svcPrdtCd%>">
    <input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
    <input type="hidden" name="User_ID"         value="<%=User_ID%>">
    <input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
    <input type="hidden" name="BuyerCode"      value="<%=BuyerCode%>">
	<input type="hidden" name="VbankName" value="<%=resFnNmCode1.getString("fn_nm_code1")%>">
	<input type="hidden" name="FORWARD"        value="<%=FORWARD%>">
	<input type="hidden" name="RefererURL"    value="<%=RefererURL%>">
	<%-- 에러코드 관련 --%>
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
    <input type="hidden" name="BuyerName"			value="<%=BuyerName%>">
    <input type="hidden" name="BuyerEmail"          value="<%=BuyerEmail%>">
    <input type="hidden" name="Amt" value="<%=Amt%>">
    <input type="hidden" name="name" value="<%=BuyerName%>">
    <input type="hidden" name="GoodsName" value="<%=GoodsName%>">
    <input type="hidden" name="OID" value="<%=Moid%>">
    <input type="hidden" name="MOID" value="<%=Moid%>">
    <input type="hidden" name="AuthDate" value="<%=resAuthDate%>">
    <input type="hidden" name="AuthCode" value="<%=resAuthCode%>">
    <input type="hidden" name="ResultCode" value="<%=resResultCode%>">
    <input type="hidden" name="ResultMsg" value="<%=resResultMsg%>">
    <input type="hidden" name="VbankNum" value="<%=resVbankNum%>">
    <input type="hidden" name="VbankName" value="<%=resFnNmCode1.getString("fn_nm_code1")%>">
	<input type="hidden" name="MerchantReserved" value="">
    <input type="hidden" name="MallReserved" value="<%=MallReserved%>">
    <input type="hidden" name="BuyerAuthNum" value="<%=BuyerAuthNum%>">
    <input type="hidden" name="ReceiptType" value="<%=cashReceiptType%>">
    <input type="hidden" name="SUB_ID" value="<%=SUB_ID%>">
    <input type="hidden" name="VbankExpDate" value="<%=VbankExpDate%>">
    <input type="hidden" name="VBankAccountName" value="<%=VBankAccountName%>">
</form>
   
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
	<%	}else{%>
			try{
		    	if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
		    		window.open('', '_self', '');
		    	    window.close();
		    	}else if((window.parent!=null&&window.parent!=undefined)||('X'=='<%=FORWARD%>')){
					window.parent.postMessage('<%=json.toString()%>','*');
				}else{
				}
			}catch(e){}
	<%	}%>
<%	}%>   
</script>