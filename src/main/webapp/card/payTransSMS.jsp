<%@page import="java.net.URLEncoder"%>
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
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.InetAddress" %>
<%
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
String zoneCode=request.getParameter("zoneCode");
String KeyinCl = request.getParameter("PgKeyInCl");
String address=request.getParameter("address");
String addressDetail=request.getParameter("addressDetail");
BuyerAddr = zoneCode+ " " + address+ " " + addressDetail;
boolean TEST=false;
	System.out.println("CARD payTrans.jsp  [device check]  " + device);
	Box box = new Box();
	Box resMemberInfo = null;
	Box resMerKeyBox = null;
	
	box.put("mid", MID);
	resMemberInfo = CommonBiz.getMemberInfo(box);
	resMerKeyBox = CommonBiz.getMemberKey(box);

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
	System.out.println("---------------------------------------------------------------------------------1step-----");
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
	// 2019.04 과세, 면세금액 설정
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
	//req.put("ReturnURL"		,ReturnURL);
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
	req.put("KeyinCl"	    ,KeyinCl);
	// 결제자정보
	req.put("BrowserType"	,BrowserType);
	req.put("UserIP"		,UserIP);
	req.put("MAC"			,"");
	req.put("SUB_ID"		,SUB_ID);
	//SUB지불수단 추가
    req.put("SvcPrdtCd"     ,svcPrdtCd);
	
    req.put("User_ID"       ,User_ID);
    req.put("Pg_Mid"        ,Pg_Mid);
    req.put("OrderCode"     ,OrderCode);
	// 인터넷에서 휴대폰결제요청된 거래를 결제
	req.put("TransType"     ,TransType);
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

	System.out.println("******** CardExpire : " + CardExpire);
	// 신용카드
	// CardBankCode는 일단 formBankCd를 넣어준다.
	req.put("CardType"		,cardType);
	if("03".equals(svcPrdtCd)){    // 수기결제
		req.put("AuthFlg"     ,"01");
	}else{
		req.put("AuthFlg"      ,resMemberInfo.getString("auth_flg"));	
	}
	req.put("CardBankCode"	,formBankCd);
	req.put("CardCode"		,formBankCd);
	// 가상키패드 적용
	//String card_num1 = CommonUtil.getDefaultStr(request.getParameter("card_num1"), "");
	//String card_num2 = CommonUtil.getDefaultStr(request.getParameter("card_num2"), "");
	//String card_num3 = CommonUtil.getDefaultStr(request.getParameter("card_num3"), "");
	//String card_num4 = CommonUtil.getDefaultStr(request.getParameter("card_num4"), "");
	//cardno = card_num1+card_num2+card_num3+card_num4;
	cardno= CommonUtil.getDefaultStr(request.getParameter("CardNum"), "");
	
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
	System.out.println("req:"+req);
	System.out.println("----------------------------------------------------------------------------Before send----------------");
	GiftBox rep = context.send(req); // 승인 전문 전송
	System.out.println("----------------------------------------------------------------------------After send-----------------");
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
	String resSUB_ID			= rep.getString("SUB_ID");
	// 결과코드
	String resName				= rep.getString("Name");
	String resPayMethod			= rep.getString("PayMethod");
	String resCardPwd			= rep.getString("CardPwd");
	String resAuthDate			= rep.getString("AuthDate");
	String resAuthCode			= rep.getString("AuthCode");
	String resResultCode		= rep.getString("ResultCode");
	String resResultMsg			= rep.getString("ResultMsg");	
	// 매입사코드
	String resAcquCardCode	    = rep.getString("AcquCardCode");	
	String resAcquCardName	    = rep.getString("AcquCardName");	 
	
	Box reqBox = new Box();
	reqBox.put("col_nm", "card_cd");
	reqBox.put("code1", formBankCd);
	Box resFnNmCode1 = CommonBiz.getFnNmCode1(reqBox);
	System.out.println("******** formBankCd ["+formBankCd+"]");
	
	/**
     * For TEST
    **/ 
    if(TEST){
        resTID              = TID;
        resErrorCD          = "0000";
        resErrorMSG         = "";
        resGoodsCnt         = GoodsCnt;
        resGoodsName        = GoodsName;
        resAmt              = Long.parseLong(Amt);
        resMOID             = Moid;
        resCurrency         = "KRW";
        
        // 상점정보
        resMID                = MID;
        resLicenseKey       = req.getString("LicenseKey");
        resMallIP           = MallIP;
        resLanguage         = "Kor"; 
        resReturnURL            = ReturnURL;
        resResultYN          = ResultYN;
        resRetryURL         = RetryURL;
        resMallReserved      = MallReserved; // 상점예비

        // 구매자정보
        resmallUserID     = mallUserID;
        resBuyerName            = BuyerName;
        resBuyerAuthNum     = BuyerAuthNum;
        resBuyerTel         = BuyerTel;
        resBuyerEmail       = BuyerEmail;

        // 결과코드
        resPayMethod        = PayMethod;
        resCardPwd          = "";
        resAuthDate         = TimeUtils.getyyMMddHHmmss();
        resAuthCode         = String.valueOf(System.currentTimeMillis()).substring(4);
        resResultCode       = "3001";
        resResultMsg        = "정상처리";   

    }
    String encText = URLEncoder.encode(resErrorMSG, "utf-8");
%>
    <form name="payMgr" method="post" action="">
		<input type="hidden" name="PayMethod">
		<input type="hidden" name="formBankCd">
		<input type="hidden" name="GoodsCnt">
		<input type="hidden" name="GoodsName">
		<input type="hidden" name="GoodsURL">
		<input type="hidden" name="GoodsCl">
		<input type="hidden" name="Amt">
		<input type="hidden" name="TaxAmt" value="<%=TaxAmt%>"/>
		<input type="hidden" name="DutyFreeAmt" value="<%=DutyFreeAmt%>"/>
		<input type="hidden" name="CardInterest">	
		<input type="hidden" name="CardQuota">
		<input type="hidden" name="Moid">
		<input type="hidden" name="MID">
		<input type="hidden" name="ReturnURL">
		<input type="hidden" name="ResultYN">
		<input type="hidden" name="RetryURL">
		<input type="hidden" name="mallUserID">
		<input type="hidden" name="BuyerName">
		<input type="hidden" name="BuyerAuthNum">
		<input type="hidden" name="BuyerTel">
		<input type="hidden" name="BuyerEmail">
		<input type="hidden" name="ParentEmail">
		<input type="hidden" name="BuyerAddr">
		<input type="hidden" name="BuyerPostNo">
		<input type="hidden" name="UserIP">
		<input type="hidden" name="MallIP">
		<input type="hidden" name="BrowserType">
		<input type="hidden" name="CardPoint">
		<input type="hidden" name="MallReserved">	
		<input type="hidden" name="MallReserved1">
		<input type="hidden" name="MallReserved2">
		<input type="hidden" name="MallReserved3">
		<input type="hidden" name="MallReserved4">
		<input type="hidden" name="MallReserved5">
		<input type="hidden" name="MallReserved6">
		<input type="hidden" name="MallReserved7">
		<input type="hidden" name="MallReserved8">
		<input type="hidden" name="MallReserved9">
		<input type="hidden" name="MallReserved10">
		<input type="hidden" name="TID">
		<input type="hidden" name="SUB_ID">
		<input type="hidden" name="eci">
		<input type="hidden" name="xid">
		<input type="hidden" name="cavv">
		<input type="hidden" name="cardno">
		<input type="hidden" name="joinCode">
		<input type="hidden" name="resAuthDate">
		<input type="hidden" name="resAuthCode">
		<input type="hidden" name="CardExpire">
		<input type="hidden" name="CardPwd">
		<input type="hidden" name="KVP_PGID">
		<input type="hidden" name="KVP_GOODNAME">
		<input type="hidden" name="KVP_PRICE">
		<input type="hidden" name="KVP_CURRENCY">
		<input type="hidden" name="KVP_NOINT_INF">
		<input type="hidden" name="KVP_QUOTA_INF">
		<input type="hidden" name="KVP_IMGURL">
		<input type="hidden" name="KVP_NOINT">
		<input type="hidden" name="KVP_QUOTA">
		<input type="hidden" name="KVP_CARDCODE">
		<input type="hidden" name="KVP_CONAME">
		<input type="hidden" name="KVP_SESSIONKEY">
		<input type="hidden" name="KVP_ENCDATA">
		<input type="hidden" name="KVP_RESERVED1">
		<input type="hidden" name="KVP_RESERVED2">
		<input type="hidden" name="KVP_RESERVED3">
		<%-- 에러코드 관련 --%>
		<input type="hidden" name="resErrorCD">
		<input type="hidden" name="resErrorMSG">
		<input type="hidden" name="resResultCode">
		<input type="hidden" name="resResultMsg">
		<input type="hidden" name="resAcquCardCode">
		<input type="hidden" name="resAcquCardName">
		
	</form>

	<script type="text/javascript">
		var parentFormNm = document.payMgr;
		parentFormNm.PayMethod.value		= '<%=PayMethod%>';
		parentFormNm.formBankCd.value		= '<%=formBankCd%>';
		parentFormNm.GoodsCnt.value			= '<%=GoodsCnt%>';
		parentFormNm.GoodsName.value		= '<%=GoodsName%>';
		parentFormNm.GoodsURL.value			= '<%=GoodsURL%>';
		parentFormNm.GoodsCl.value			= '<%=GoodsCl%>';
		parentFormNm.Amt.value				= '<%=Amt%>';
		parentFormNm.CardInterest.value     = '<%=CardInterest%>';		
		parentFormNm.CardQuota.value		= '<%=CardQuota%>';
		parentFormNm.Moid.value				= '<%=Moid%>';
		parentFormNm.MID.value				= '<%=MID%>';
		parentFormNm.ReturnURL.value		= '<%=ReturnURL%>';
		parentFormNm.ResultYN.value         = '<%=ResultYN%>';
		parentFormNm.RetryURL.value			= '<%=RetryURL%>';
		parentFormNm.mallUserID.value		= '<%=mallUserID%>';
		parentFormNm.BuyerName.value		= '<%=BuyerName%>';
		parentFormNm.BuyerAuthNum.value		= '<%=BuyerAuthNum%>';
		parentFormNm.BuyerTel.value			= '<%=BuyerTel%>';
		parentFormNm.BuyerEmail.value		= '<%=BuyerEmail%>';
		parentFormNm.BuyerAddr.value		= '<%=BuyerAddr%>';
		parentFormNm.BuyerPostNo.value		= '<%=BuyerPostNo%>';
		parentFormNm.ParentEmail.value		= '<%=ParentEmail%>';
		parentFormNm.UserIP.value			= '<%=UserIP%>';
		parentFormNm.MallIP.value			= '<%=MallIP%>';
		parentFormNm.MallReserved.value     = '<%=MallReserved%>';
		parentFormNm.BrowserType.value		= '<%=BrowserType%>';
		parentFormNm.TID.value				= '<%=TID%>';
		parentFormNm.SUB_ID.value				= '<%=SUB_ID%>';
		parentFormNm.eci.value				= '<%=eci%>';
		parentFormNm.xid.value				= '<%=xid%>';
		parentFormNm.cavv.value				= '<%=cavv%>';
		parentFormNm.cardno.value			= '<%=cardno%>';
		parentFormNm.joinCode.value			= '<%=joinCode%>';
		parentFormNm.CardExpire.value		= '<%=CardExpire%>';
		parentFormNm.CardPwd.value			= '<%=CardPwd%>';
		parentFormNm.resAuthDate.value		= '<%=resAuthDate%>';
		parentFormNm.resAuthCode.value		= '<%=resAuthCode%>';
		// ISP 추가 -나라		
		parentFormNm.KVP_PGID.value			= '<%=KVP_PGID%>';
		parentFormNm.KVP_GOODNAME.value		= '<%=KVP_GOODNAME%>';
		parentFormNm.KVP_PRICE.value		= '<%=KVP_PRICE%>';
		parentFormNm.KVP_CURRENCY.value		= '<%=KVP_CURRENCY%>';
		parentFormNm.KVP_NOINT_INF.value	= '<%=KVP_NOINT_INF%>';
		parentFormNm.KVP_QUOTA_INF.value	= '<%=KVP_QUOTA_INF%>';
		parentFormNm.KVP_IMGURL.value		= '<%=KVP_IMGURL%>';
		parentFormNm.KVP_NOINT.value		= '<%=KVP_NOINT%>';
		parentFormNm.KVP_QUOTA.value		= '<%=KVP_QUOTA%>';
		parentFormNm.KVP_CARDCODE.value		= '<%=KVP_CARDCODE%>';
		parentFormNm.KVP_CONAME.value		= '<%=KVP_CONAME%>';
		parentFormNm.KVP_SESSIONKEY.value	= '<%=KVP_SESSIONKEY_ENC%>';
		parentFormNm.KVP_ENCDATA.value		= '<%=KVP_ENCDATA_ENC%>';
		parentFormNm.KVP_RESERVED1.value	= '<%=KVP_RESERVED1%>';
		parentFormNm.KVP_RESERVED2.value	= '<%=KVP_RESERVED2%>';
		parentFormNm.KVP_RESERVED3.value	= '<%=KVP_RESERVED3%>';
		// ISP 추가 -나라		
		parentFormNm.resErrorCD.value		= '<%=resErrorCD%>';
		parentFormNm.resErrorMSG.value		= '<%=resErrorMSG%>';
		parentFormNm.resResultCode.value	= '<%=resResultCode%>';
		parentFormNm.resResultMsg.value		= '<%=resResultMsg%>';
		parentFormNm.resAcquCardCode.value		= '<%=resAcquCardCode%>';
		parentFormNm.resAcquCardName.value		= '<%=resAcquCardName%>';
	</script>
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
         <input type="hidden" name="AuthDate" value="<%=resAuthDate%>">
         <input type="hidden" name="AuthCode" value="<%=resAuthCode%>">
         <input type="hidden" name="ResultCode" value="<%=resResultCode%>">
         <input type="hidden" name="ResultMsg" value="<%=resResultMsg%>">
         <input type="hidden" name="VbankNum" value="">
         <input type="hidden" name="MerchantReserved" value="">
         <input type="hidden" name="MallReserved" value="<%=MallReserved%>">       
         <input type="hidden" name="SUB_ID" value="<%=SUB_ID%>">
         <input type="hidden" name="fn_cd" value="<%=formBankCd%>">
         <input type="hidden" name="fn_name" value="<%=resFnNmCode1.getString("fn_nm_code1")%>">
         <input type="hidden" name="CardQuota" value="<%=CardQuota%>">
         <input type="hidden" name="BuyerEmail" value="<%=BuyerEmail%>">
         <input type="hidden" name="BuyerAuthNum" value="<%=BuyerAuthNum%>">
         <input type="hidden" name="ErrorCode" value="<%=resErrorCD%>">
         <input type="hidden" name="ErrorMsg" value="<%=resErrorMSG%>">
         <input type="hidden" name="AcquCardCode" value="<%=resAcquCardCode%>">
		 <input type="hidden" name="AcquCardName" value="<%=resAcquCardName%>">
    </form>
    <script type="text/javascript">
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
<%
//상점 IP 셋팅 <MallIP 셋팅>
InetAddress inet = InetAddress.getLocalHost();
String payActionUrl = "https://pg.innopay.co.kr";    

if (request.getServerPort() == 80 || request.getServerPort() == 443) {
    payActionUrl = request.getScheme() + "://" + request.getServerName() ;
} else {
    payActionUrl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort();
}   
%>    
<%
	if(MallResultFWD.equals("Y")){
%>
    <script type="text/javascript">
    	try{
	<%    if("euc-kr".equals(EncodingType)){%>
            document.charset = "euc-kr";
    <%    }else {  %>
            document.charset = "utf-8";
    <%    }%>
    	}catch(e){}
   	<%if("X".equals(FORWARD)){%>
		document.transMgr.target="_parent";
	<%}%>
      document.transMgr.submit();
    </script>

<% 
	}else{

	    if( ResultYN.equals("N") ) { // 결제 결과창 안보이기, 이 경우 바로  URL CALL
	    	
	    	if(resResultCode.equals("3001")) {
	    	%>
	    		<script>
		            alert('결제 정상 처리 되었습니다.');
		           
					//parent.document.location.reload();
					//parent.location.href="https://admin.innopay.co.kr/mer/trans/orderCardRegist.do";
					//window.parent.close();
					
					parent.location.href= '<%=payActionUrl%>'+'/ipay/PayResult.jsp?TID=<%=TID%>';
					
		        </script>
		    <%
	    	}else{
	    		if(resErrorMSG != null && !resErrorMSG.equals("")){
	    	%>
	    		<script>
	    			alert('결제 처리중 오류가 발생 되었습니다.\n[<%=resErrorMSG%>]');
					//parent.document.location.reload();
					//parent.location.href="https://admin.innopay.co.kr/mer/trans/orderCardRegist.do";
					parent.location.href= '<%=payActionUrl%>' + '/ipay/PayFailResult.jsp?TID=<%=TID%>&resErrorMSG=<%=encText%>&OrderCode=<%=OrderCode%>&MID=<%=MID%>';
		        </script>	    	
		    <%
	    		}else if(resResultMsg != null && !resResultMsg.equals("")){
	    	%>
	    		<script>
	    			alert('결제 처리중 오류가 발생 되었습니다.\n[<%=resResultMsg%>]');
					//parent.document.location.reload();
					//parent.location.href="https://admin.innopay.co.kr/mer/trans/orderCardRegist.do";
					parent.location.href= '<%=payActionUrl%>' + '/ipay/PayFailResult.jsp?TID=<%=TID%>&resErrorMSG=<%=encText%>&OrderCode=<%=OrderCode%>&MID=<%=MID%>';
		        </script>
		    <%
	    		}else{
		    %>
		    	<script>
	    			alert('결제 처리중 오류가 발생 되었습니다.');
					//parent.document.location.reload();
					//parent.location.href="https://admin.innopay.co.kr/mer/trans/orderCardRegist.do";
                    parent.location.href= '<%=payActionUrl%>' + '/ipay/PayFailResult.jsp?TID=<%=TID%>&resErrorMSG=<%=encText%>&OrderCode=<%=OrderCode%>&MID=<%=MID%>';
		        </script>
	    	<%
	    		}
	    	}
	    
	    	/*
	    	try{
	    	    if(ReturnURL!=null){ 
	    	       	LinkedHashMap<String,String> values = new LinkedHashMap<String,String>();
					values.put("PayMethod",PayMethod); //지불수단
					values.put("MID",MID); //상점ID				
					values.put("mallUserID",mallUserID); //상점고객ID
					values.put("Amt",Amt ); //금액
					values.put("GoodsName",GoodsName); //상품명				
					values.put("OID",Moid); //주문번호
					values.put("TID",TID); //TID				
					values.put("AuthDate",resAuthDate); //승인일시
					values.put("AuthCode",resAuthCode); //승인번호 TID
					values.put("fn_cd",StringUtils.defaultString(formBankCd));
					values.put("fn_name",StringUtils.defaultString(noti.getFn_name()));
					values.put("card_no",StringUtils.defaultString(cardno));
					values.put("ResultCode",ResultCode); // 결제성공
					values.put("ResultMsg",resResultMsg);
				    values.put("StateCd","0");
	    		    HttpBean httpBean = new HttpBean();
	    	        int httpResponseCode = httpBean.doPost(ReturnURL,values);
	    	        
	    	        if(httpResponseCode == 200){
	    	         // URL 호출 성공시 DB UPDATE , 실패시 BATCH에서 처리.
	    	         	
	    	         
	    	        }else{
	    	        // 실패시 DB UPDATE, BATCH에서 처리하도록 함.
	    	        	
	    	        }
	    	    }
	    	}catch(Exception e){
	    		e.printStackTrace();
	    	}
	    	*/
	    	
	%>      
	        <script>
	            window.close();            
	        </script>
	<%
	    } else {
	%>		
			<script type="text/javascript">
				goPayMgrSubmit();	
			</script>
	<%
	    }
	}
%>
