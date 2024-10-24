<%
/******************************************************************************
*
*	@ SYSTEM NAME     : 쇼핑몰-PG연동페이지
*   @ PROGRAM NAME      : interfaceURL.jsp
*   @ MAKER             : InnopayPG
*   @ MAKE DATE         : 2017.06.23
*   @ PROGRAM CONTENTS  : 쇼핑몰-PG연동페이지
*
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%@ page import="kr.co.infinisoft.pg.common.*" %>
<%@ page import="util.CommonUtil, util.CardUtil, service.*, mobile.CardSms" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ include file="./common/commonParameter.jsp" %>
<%@ page import="java.net.*" %>
<%
System.out.println("Start ipay interfaceURL.jsp*****************["+System.currentTimeMillis()+"]");
/**	FORWARD : N 처리용, 아래 파라미터 검토 후 적용 2019.04 **/
RefererURL = request.getHeader("referer");
System.out.println("**** referer ["+RefererURL+"]");

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

	Box req = new Box();
	List<Box> listMerSvc = null;
	String cookieVal = "";
	Cookie cookie = null;
	
	Box box = null;
	Box resMerKeyBox = null;
	Box resMerchantInfo = null;
	String merchantKey = null;

	/**
	 * OrderCode 가 있는 경우 검증처리
	 */
	if(StringUtils.isNotEmpty(OrderCode)){
	    Box orderInfo = CardSms.selectConfOrderInfo(OrderCode);
	    if(orderInfo!=null && orderInfo.size()>0){ // 주문정보가 있는 경우 검증 처리
	        if(StringUtils.isNotEmpty(orderInfo.getString("STEP")) && !"15".equals(orderInfo.getString("STEP"))){
	            System.out.println("OrderCode["+OrderCode+"] step["+orderInfo.getString("STEP")+"]");
	            throw new Exception("W001");
	        }
	    }
	}
	 
	// MID 정상 데이터 검증
	box = new Box();
	box.put("mid", MID);
	resMerchantInfo = CommonBiz.getMemberInfo(box);
	if(resMerchantInfo == null ){
		System.out.println("**********[존재하지 않는 MID 입니다]**********");
		throw new Exception("W003");
	}
	
	// 상점서명키 가져오기
	if(MID.length() > 0) {
		resMerKeyBox = CommonBiz.getMemberKey(box);
	}
	// 상점서명키 (꼭 해당 상점키로 바꿔주세요)
	if(resMerKeyBox == null || resMerKeyBox.getString("mkey") == null) {
		System.out.println("**********[상점 MID Key가 존재하지 않습니다]**********");
		throw new Exception("W009"); 		
	} else {
		merchantKey = resMerKeyBox.getString("mkey");
	}
	
	try{
	    long DFAmt = Long.parseLong(DutyFreeAmt);
	}catch(Exception e){
	    DutyFreeAmt = "0";
	}
	
	// encrypt data 생성
	String strEncData = CodecUtils.encodeMD5HexBase64(ediDate + MID + String.valueOf(Long.parseLong(Amt)+Long.parseLong(DutyFreeAmt)) + merchantKey);
	System.out.println("strEncData = " + strEncData);
    System.out.println("EncryptData = " + EncryptData);
    System.out.println("ediDate = " + ediDate);
    System.out.println("MID = " + MID);
    System.out.println("Amt = " + Amt);
    System.out.println("merchantKey = " + merchantKey);
    
	boolean isEncryptData = false;
	// 거래검증 데이터 체크
	if(!"pgbcdplatm".equals(MID)) {
		if(EncryptData.equals(strEncData)) {
			isEncryptData = true;
			System.out.println("**********[거래검증 데이터]["+isEncryptData+"]**********");
		}else{
			System.out.println("**********[거래검증 데이터가 일치하지 않습니다]**********");
			throw new Exception("W007"); 
		}
	} else {
		System.out.println("**********["+MID+"] [거래검증 예외처리]**********");
	}
	
	//필수 입력값 체크
	if(resMerchantInfo!=null){
		int seq = resMerchantInfo.getInt("seq", 0);
		
		System.out.println("seq["+seq+"]");
		System.out.println("BuyerName["+BuyerName+"]");
		System.out.println("BuyerTel["+BuyerTel+"]");
		System.out.println("BuyerHp["+BuyerHp+"]");
		System.out.println("BuyerEmail["+BuyerEmail+"]");
		
		if(seq >= 70000){
			if(BuyerName == null || BuyerName.trim().equals("")){
				System.out.println("**********[구매자명은 필수 입력입니다.]**********");
				throw new Exception("W011"); 
			}
			
			if(BuyerTel == null || BuyerTel.trim().equals("")){
				System.out.println("**********[구매자연락처는 필수 입력입니다.]**********");
				throw new Exception("W012"); 
			}
			
			if(BuyerEmail == null || BuyerEmail.trim().equals("")){
				System.out.println("**********[구매자메일주소는 필수 입력입니다.]**********");
				throw new Exception("W013"); 
			}
		}
		// 면세금액이 있는 경우 shop_vat_yn 셋팅 검증
	    long DFAmt = Long.parseLong(DutyFreeAmt);
	    if(DFAmt>0 && resMerchantInfo.getString("shop_vat_yn").equals("Y")){
	        throw new Exception("W014"); // 면세,복합과세 가맹점 아님
	    }		
	} // end(resMerchantInfo!=null)
	
	/**
	 * 지불수단 검증
	 * svcCd, svcPrdtCd 셋팅
	**/
    String actionURL = "";
    String charset = "";
    if(CommonConstants.PAY_METHOD_CARD.equals(PayMethod)){
        svcCd = "01";
        if(device.equals("pc")){
        	actionURL = "./card/index_card.jsp";
        }else{
            actionURL = "./card/index_card_m.jsp";
        }
        if(StringUtils.isEmpty(svcPrdtCd)) svcPrdtCd = "08"; // 08:인증
        /**
         * 수기결제를 수용하는 경우 여기서 분기시킨다.
         */
        if("01".equals(resMerchantInfo.getString("auth_flg"))){
        	// 키인결제 URL inputKeyin.jsp
        	if(StringUtils.isEmpty(svcPrdtCd)) svcPrdtCd = "01"; // 01:수기
        }
        req.put("svc_prdt_cd", svcPrdtCd); // 01:일반 08:인증
    }else if(CommonConstants.PAY_METHOD_BANK.equals(PayMethod)){
        svcCd = "02";
        svcPrdtCd = "01"; // 01:일반
        req.put("svc_prdt_cd", svcPrdtCd); // 01:일반
        if(device.equals("pc")){
            actionURL = "./bank/mainBank.jsp";
        }else{
            actionURL = "./bank/mainBank_m.jsp";
        }
    }else if(CommonConstants.PAY_METHOD_VBANK.equals(PayMethod)){
        svcCd = "03";
        svcPrdtCd = "01"; // 01:일반
        req.put("svc_prdt_cd", svcPrdtCd); // 01:일반
        actionURL = "./vbank/mainVBank.jsp";
    }else if(CommonConstants.PAY_METHOD_CARS.equals(PayMethod)){
    	PayMethod = "CARS";
    	svcCd = "01";
    	svcPrdtCd = "06";
        actionURL = "https://api.innopay.co.kr/api/cardInterface";
    }else if("CSMS".equals(PayMethod)){
    	PayMethod = "CSMS";
    	svcCd = "01";
    	svcPrdtCd = "04";
    	actionURL = "https://api.innopay.co.kr/api/cardInterface";
    }else if("DSMS".equals(PayMethod)){	// SMS 수기
    	PayMethod = "CSMS";
    	svcCd = "01";
    	svcPrdtCd = "03";
    	actionURL = "https://api.innopay.co.kr/api/cardInterface";
    }else if("CKEYIN".equals(PayMethod)){
    	PayMethod = "CKEYIN";
    	svcCd = "01";
    	svcPrdtCd = "01";
        actionURL = "./card/index_card_keyin.jsp";
    }else if("EBANK".equals(PayMethod)){
        svcCd = "12"; // 계좌간편결제
        svcPrdtCd = "01";
        req.put("svc_prdt_cd", svcPrdtCd); // 01:일반
        charset="euc-kr";
        // for TEST    
        //actionURL = "http://172.16.10.10:8080/api/easyBankPay";
        actionURL = "https://openapi.innopay.co.kr:4443/api/easyBankPay";
    }else if("EPAY".equals(PayMethod)) {
    	PayMethod = "EPAY";
    	svcCd = "01";
    	 if(StringUtils.isEmpty(svcPrdtCd)) svcPrdtCd = "08"; // 08:인증
         
         if(device.equals("pc")){
        	 actionURL = "./card/EPay.jsp";
         }else{
        	 actionURL = "./card/EPay_mobile.jsp";
         }
        
        req.put("svc_prdt_cd", svcPrdtCd);
    }
    
    else{
        throw new Exception("W004"); 
    }
	
    /**
     * $$$$ 상점별 지불 수단(신용카드 - PG정보로 확인, 이 외 - tb_mer_svc:status로 확인)
     * PG.tb_mer_svc 테이블에 가상계좌, 계좌이체 서비스가 등록되어 있는지 확인
     * svc_prdt_cd = 01 로 조회한다.
     **/
	
    Box pgMap = new Box();
    req.put("mid", MID);
    // 신용카드
 	if("01".equals(svcCd)){
 	    SupportIssue si = new SupportIssue();
 		req.put("svc_cd", svcCd);
 		req.put("svc_prdt_cd", svcPrdtCd);
 		System.out.println("********"+req.toString());
 		pgMap = si.getPgInfo(req);
 		if(pgMap==null||pgMap.isEmpty()){
 		    System.out.println("********[등록된 PG정보 없음]"+req.toString());
 	        throw new Exception("W004");
 		}    
 	}
    // 가상계좌, 계좌이체
 	else {
		req.put("status", "1"); 
		listMerSvc = CommonBiz.getMerSvcSvcCd(req);
		// svcPrdtCd 가 없는 경우 01:일반으로 설정
	    
		if(listMerSvc == null) {
			System.out.println("**********[결제수단이 유효하지 않습니다]**********");
			throw new Exception("W004"); 
		} else {
			boolean chk = false;
			for(int inx = 0; inx < listMerSvc.size(); inx++) {
				Box resMerSvcBox = (Box)listMerSvc.get(inx);
				// 초기 URL 세팅
				if(svcCd.equals(resMerSvcBox.getString("svc_cd"))) {
					chk=true;
				    break;
				}
			} // end for
			if(!chk){
				System.out.println("**********[결제수단이 유효하지 않습니다]**********");
		        throw new Exception("W004");
			}
		}
    }
%>
<body>
<form name="tranMgr" method="post" action="" accept-charset="<%=charset%>">
<input type="hidden" name="PayMethod"		value="<%=PayMethod%>">
<input type="hidden" name="GoodsCnt"		value="<%=GoodsCnt%>">
<input type="hidden" name="GoodsName"		value="<%=GoodsName%>">
<input type="hidden" name="GoodsURL"		value="<%=GoodsURL%>">
<input type="hidden" name="Amt"				value="<%=Amt%>">
<input type="hidden" name="GoodsCl"		    value="<%=GoodsCl%>">
<input type="hidden" name="Moid"			value="<%=Moid%>">
<input type="hidden" name="MID"				value="<%=MID%>">
<input type="hidden" name="ReturnURL"		value="<%=ReturnURL%>">
<input type="hidden" name="ResultYN"        value="<%=ResultYN%>">
<input type="hidden" name="RetryURL"		value="<%=RetryURL%>">
<input type="hidden" name="mallUserID"		value="<%=mallUserID%>">
<input type="hidden" name="BuyerName"		value="<%=BuyerName%>">
<input type="hidden" name="BuyerAuthNum"	value="<%=BuyerAuthNum%>">
<input type="hidden" name="BuyerTel"		value="<%=BuyerTel%>">
<input type="hidden" name="BuyerHp"			value="<%=BuyerHp%>">
<input type="hidden" name="BuyerEmail"		value="<%=BuyerEmail%>">
<input type="hidden" name="BuyerAddr"		value="<%=BuyerAddr%>">
<input type="hidden" name="BuyerPostNo"		value="<%=BuyerPostNo%>">
<input type="hidden" name="ParentEmail"		value="<%=ParentEmail%>">
<input type="hidden" name="UserIP"			value="<%=UserIP%>">
<input type="hidden" name="MallIP"			value="<%=MallIP%>">
<input type="hidden" name="BrowserType"		value="<%=BrowserType%>">
<input type="hidden" name="MallReserved"    value="<%=MallReserved%>">
<input type="hidden" name="MallResultFWD"   value="<%=MallResultFWD%>">                         
<input type="hidden" name="SUB_ID" 		    value="<%=SUB_ID%>">    
<input type="hidden" name="EncodingType" 	value="<%=EncodingType%>"> 
<input type="hidden" name="OfferingPeriod" 	value="<%=OfferingPeriod%>">
<input type="hidden" name="webview" 	    value="<%=CommonUtil.getDefaultStr(request.getParameter("webview"),"")%>">
<input type="hidden" name="device" 		    value="<%=device%>">
<input type="hidden" name="svcCd"           value="<%=svcCd%>">
<input type="hidden" name="svcPrdtCd"       value="<%=svcPrdtCd%>">
<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
<input type="hidden" name="User_ID"         value="<%=User_ID%>">
<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
<input type="hidden" name="BuyerCode"       value="<%=BuyerCode%>">
<input type="hidden" name="FORWARD"         value="<%=FORWARD%>">
<input type="hidden" name="VbankExpDate"    value="<%=VbankExpDate%>"> <!-- 가상계좌입금마감일(YYYYMMDD) -->
<input type="hidden" name="EncryptData"    value="<%=EncryptData%>"> <!-- 거래검증값 추가(2018.08 hans) -->
<input type="hidden" name="ediDate"        value="<%=ediDate%>">
<input type="hidden" name="Currency"       value="<%=Currency%>">
<!-- 웹링크 추가 -->
<input type="hidden" name="ServiceMode"     value="PY0">
<input type="hidden" name="PgMID"       	value="<%=(pgMap.getString("pg_mid")!=null)?pgMap.getString("pg_mid"):""%>">
<input type="hidden" name="Mid"     		value="<%=MID%>">
<input type="hidden" name="LicenseKey"      value="<%=merchantKey%>">
<input type="hidden" name="returnUrl"       value="<%=ReturnURL%>">
<input type="hidden" name="RequestType"     value="<%=RequestType%>">
<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>">
<input type="hidden" name="UserId"     		value="<%=User_ID%>">
<input type="hidden" name="ArsConnType"     value="<%=CommonUtil.getDefaultStr(request.getParameter("ArsConnType"),"")%>">
<input type="hidden" name="Encoding"        value="url_euc-kr">
<input type="hidden" name="UserAgent"       value="">
<input type="hidden" name="RefererURL"       value="<%=RefererURL%>">

<!-- 웹링크 추가 끝-->
</form>
</body>

<%if(CommonConstants.PAY_METHOD_CARS.equals(PayMethod) || "CSMS".equals(PayMethod)){%>
<script type="text/javascript">
    if(typeof <%=BuyerHp%> == "undefined")
    	document.tranMgr.BuyerHp.value = document.tranMgr.BuyerTel.value;
	document.tranMgr.GoodsName.value = '<%=URLEncoder.encode(GoodsName, "euc-kr")%>';
	document.tranMgr.BuyerName.value = '<%=URLEncoder.encode(BuyerName, "euc-kr")%>';
	document.tranMgr.MallReserved.value = '<%=URLEncoder.encode(MallReserved, "euc-kr")%>';
</script>
<%}%>
<script type="text/javascript">
	document.tranMgr.UserAgent.value = navigator.userAgent;
	document.tranMgr.action = "<%=actionURL%>";
<%if("EBANK".equals(PayMethod)){%>
try{document.charset="euc-kr";}catch(e){}
<%}%>
	document.tranMgr.submit();
</script>
