<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="mobile.CardSms"%>
<%@ include file="../common/cardParameter.jsp" %>
<%
Enumeration em = request.getParameterNames();
HashMap paramMap = new HashMap();
while(em.hasMoreElements())
{
    String key = em.nextElement().toString();
    String value = request.getParameter(key);
    paramMap.put(key, value);
}
System.out.println("====Danal response Param "+paramMap.toString());

boolean TEST = false;
boolean errorCheck = false; //true:오류 / false:정상
String resultCode = null;
String resultMsg = null;

Box orderInfo = new Box();
Box pgInfoBox = new Box();

String CoNm             = "";
String TelNo            = "";
String AddrNo           = "";
String Image            = "";
String DeliveryYn       = "";
String ZoneCode         = "";
String Address          = "";
String AddressDetail    = "";
String Mid              = "";
String ShopLicenseKey   = "";
String PgCode          	= "";   // PG사 코드(블루월넛 때문에 추가)
/////// 결제관련 파라미터
String PgTid = CommonUtil.getDefaultStr(request.getParameter("TID"), "");
String EdiDate = TimeUtils.getyyyyMMddHHmmss(); // 전문생성일시
String cardType = CommonUtil.getDefaultStr(request.getParameter("cardType"), "01");

%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="../css/card_conf.css" />
        <link href='https://cdn.rawgit.com/theeluwin/NotoSansKR-Hestia/master/stylesheets/NotoSansKR-Hestia.css' rel='stylesheet' type='text/css'>
        <script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="../js/card_conf.js"></script>
        <title>INNOPAY 전자결제서비스</title>
    </head>
<body>
<%if(errorCheck==true){%>
    <section id="wrap">
        <section class="float_wrap error_notice">
            <div class="popup_cont">
                <img src="../images/i_error.png" alt="알림" width="69px" height="auto">
                <p><%=resultMsg %></p>
                <section class="btn_wrap_fl">
                    <div>
                        <a class="btn_blue btn" href="javascript:window.close()">확인</a>
                    </div>
                </section>
            </div>
        </section>
    </section>
<%}else{
    PGClientContext context = null;
    PGConnection con = null;
    GiftBox req = null;
    
    context = PGClient.getInstance().getConext("CARD_BL");
    req = context.newGiftBox("NPG01ISP01");
    TID = KeyUtils.genTID(MID, "01", svcPrdtCd);
    // 전문공통
    req.put("Version"       ,"NPG01");
    req.put("ID"            ,"ISP01");
    req.put("EdiDate"       ,EdiDate);
    req.put("TID"           ,TID);
    req.put("ErrorSys"      ,"WEB");
    req.put("ErrorCD"       ,"");
    req.put("ErrorMSG"      ,"");
    // 상품정보
    req.put("GoodsCnt"      ,GoodsCnt);
    req.put("GoodsName"     ,GoodsName);
    req.put("Amt"           ,Amt);
    req.put("MOID"          ,Moid);
    req.put("Currency"      ,"KRW");
    // 상점정보
    req.put("MID"           ,MID);
    req.put("LicenseKey"    ,ShopLicenseKey);
    req.put("MallIP"        ,MallIP);
    req.put("Language"      ,"Kor");
    req.put("MallReserved"  ,""); //상점예비
    req.put("ReturnURL"     ,ReturnURL);
    req.put("RetryURL"      ,RetryURL);
    // 구매자정보
    req.put("MallUserID"    ,mallUserID);
    req.put("BuyerName"     ,BuyerName);
    req.put("BuyerAuthNum"  ,BuyerAuthNum);
    req.put("BuyerTel"      ,BuyerTel);
    req.put("BuyerEmail"    ,BuyerEmail);
    req.put("BuyerAddr"     ,BuyerAddr);
    req.put("BuyerPostNo"   ,BuyerPostNo);
    // 결제자정보
    req.put("BrowserType"   ,BrowserType);
    req.put("UserIP"        ,UserIP);
    req.put("MAC"           ,"");
    req.put("TransType"     ,TransType);
    req.put("SvcPrdtCd"     ,svcPrdtCd);    //sub 지불수단
    req.put("User_ID"       ,User_ID);
    req.put("Pg_Mid"        ,Pg_Mid);
    req.put("OrderCode"     ,OrderCode);
    req.put("BuyerCode"     ,BuyerCode);

    boolean isCardInterest = false; // default:일반
    // 신용카드
    req.put("CardType"      ,cardType);
    req.put("AuthFlg"       ,"02");  // 인증코드 01:일반 02:인증
    req.put("CardBankCode"  ,formBankCd);    // 2018.01 파라미터 추가 반영
    req.put("CardCode"      ,formBankCd);   // 2018.01 파라미터 추가 반영
    //req.put("CardNum"     ,"*****************");  // 카드코드 ISP 
    req.put("CardExpire"    ,CardExpire);   // 없음 ""
    req.put("CardQuota"     ,CardQuota);    
    req.put("CardInterest"  ,isCardInterest == true ? "1" : "0");
    req.put("CardPwd"       ,CardPwd);
    req.put("Below1000"     ,CommonUtil.isBelow1000(Amt));
    req.put("CardPoint"     ,CardPoint);
    req.put("ISPPGID"       ,"");
    req.put("ISPCardCode"   ,PgCode);   // 다날은 PgCode(34,24) 를 보냄
    req.put("ISPEncData"    ,PgTid);
    req.put("ISPSessionKey" ,PgTid);  	 
    req.put("ParentEmail"   ,PgTid);    // 블루월넛, 다날은 ParentEmail에 PGTID를 보냄
    
    System.out.println("-------- DANAL CARD AUTH Trans req: "+req);
    GiftBox rep = context.send(req);
    System.out.println("-------- DANAL CARD AUTH Trans rep: "+rep);
    
    // 전문공통
    String resVersion           = rep.getString("Version");
    String resID                = rep.getString("ID");
    String resEdiDate           = rep.getString("EdiDate");
    String resLength            = rep.getString("Length");
    String resTID               = rep.getString("TID");
    String resErrorSys          = rep.getString("ErrorSys");
    String resErrorCD           = rep.getString("ErrorCD");
    String resErrorMSG          = rep.getString("ErrorMSG");
    // 상품정보
    String resGoodsCnt          = rep.getString("GoodsCnt");
    String resGoodsName         = rep.getString("GoodsName");
    long resAmt                 = rep.getLong("Amt");
    String resMOID              = rep.getString("MOID");
    String resCurrency          = rep.getString("Currency");
    // 상점정보
    String resMID               = rep.getString("MID");
    String resLicenseKey        = rep.getString("LicenseKey");
    String resMallIP            = rep.getString("MallIP");
    String resLanguage          = rep.getString("Language");    
    String resReturnURL         = rep.getString("ReturnURL");
    String resResultYN          = rep.getString("ResultYN");
    String resRetryURL          = rep.getString("RetryURL");
    String resMallReserved      = rep.getString("MallReserved"); // 상점예비
    // 구매자정보
    String resmallUserID        = rep.getString("MallUserID");
    String resBuyerName         = rep.getString("BuyerName");
    String resBuyerAuthNum      = rep.getString("BuyerAuthNum");
    String resBuyerTel          = rep.getString("BuyerTel");
    String resBuyerEmail        = rep.getString("BuyerEmail");
    String resParentEmail       = rep.getString("ParentEmail");
    String resBuyerAddr         = rep.getString("BuyerAddr");
    String resBuyerPostNo       = rep.getString("BuyerPostNo");
    String resBrowserType       = rep.getString("BrowserType");
    // 결제자정보
    String resUserIP            = rep.getString("UserIP");
    String resMAC               = rep.getString("MAC");
    // 결과코드
    String resPayMethod         = rep.getString("PayMethod");
    String resCardPwd           = rep.getString("CardPwd");
    String resAuthDate          = rep.getString("AuthDate");
    String resAuthCode          = rep.getString("AuthCode");
    String resResultCode        = rep.getString("ResultCode");
    String resResultMsg         = rep.getString("ResultMsg");
    // 발급사,매입사코드
    String resAppCardCode   	= rep.getString("AppCardCode");
    String resAppCardName   	= rep.getString("AppCardName");
    String resAcquCardCode  	= rep.getString("AcquCardCode");    
    String resAcquCardName  	= rep.getString("AcquCardName");
    
    String resUsePoint      	= rep.getString("UsePoint");
    String resBalancePoint  	= rep.getString("BalancePoint");
    String resCardNum  			= rep.getString("CardNum");
%>    
<form name="payMgr" method="post" action="">
    <input type="hidden" name="PayMethod" 		value="<%=PayMethod%>">
    <input type="hidden" name="TID" 			value="<%=resTID%>">
    <input type="hidden" name="GoodsCnt" 		value="<%=resGoodsCnt%>">
    <input type="hidden" name="GoodsName" 		value="<%=resGoodsName%>">
    <input type="hidden" name="GoodsURL" 		value="<%=GoodsURL%>">
    <input type="hidden" name="GoodsCl" 		value="<%=GoodsCl%>">
    <input type="hidden" name="Amt"    			value="<%=resAmt%>">
    <input type="hidden" name="Moid"   			value="<%=resMOID%>">
    <input type="hidden" name="MID"    			value="<%=resMID%>">
    <input type="hidden" name="ReturnURL" 		value="<%=resReturnURL%>">
    <input type="hidden" name="ResultYN" 		value="<%=resResultYN%>">
    <input type="hidden" name="RetryURL" 		value="<%=resRetryURL%>">
    <input type="hidden" name="mallUserID" 		value="<%=resmallUserID%>">
    <input type="hidden" name="BuyerName" 		value="<%=resBuyerName%>">
    <input type="hidden" name="BuyerAuthNum" 	value="<%=BuyerAuthNum%>">
    <input type="hidden" name="BuyerTel" 		value="<%=resBuyerTel%>">
    <input type="hidden" name="BuyerEmail" 		value="<%=resBuyerEmail%>">
    <input type="hidden" name="ParentEmail" 	value="">
    <input type="hidden" name="BuyerAddr"   	value="<%=resBuyerAddr%>">
    <input type="hidden" name="BuyerPostNo" 	value="<%=resBuyerPostNo%>">
    <input type="hidden" name="UserIP" 			value="<%=UserIP%>">
    <input type="hidden" name="MallIP" 			value="<%=MallIP%>">
    <input type="hidden" name="BrowserType" 	value="<%=BrowserType%>">
    <input type="hidden" name="BankCode"    	value="">
    <input type="hidden" name="MallReserved" 	value="<%=resMallReserved%>">
    <input type="hidden" name="EncodingType"    value="<%=EncodingType%>">
    <input type="hidden" name="OfferingPeriod"  value="<%=OfferingPeriod%>"/> 
    <input type="hidden" name="device"      	value="<%=device%>">
    <input type="hidden" name="svcCd"      		value="<%=svcCd%>">
    <input type="hidden" name="svcPrdtCd"      	value="<%=svcPrdtCd%>">
    <input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
    <input type="hidden" name="User_ID"         value="<%=User_ID%>">
    <input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
    <input type="hidden" name="BuyerCode"      	value="<%=BuyerCode%>">
    <input type="hidden" name="FORWARD"         value="<%=FORWARD%>">
    
    <%-- 에러코드 관련 --%>
    <input type="hidden" name="resAuthDate" 	value="<%=resAuthDate%>">
    <input type="hidden" name="resAuthCode" 	value="<%=resAuthCode%>">
    <input type="hidden" name="resErrorCD" 		value="<%=resErrorCD%>">
    <input type="hidden" name="resErrorMSG" 	value="<%=resErrorMSG%>">
    <input type="hidden" name="resResultCode" 	value="<%=resResultCode%>">
    <input type="hidden" name="resResultMsg" 	value="<%=resResultMsg%>">
    <input type="hidden" name="resAppCardCode" 	value="<%=resAppCardCode%>">
    <input type="hidden" name="resAppCardName" 	value="<%=resAppCardName%>">
    <input type="hidden" name="resAcquCardCode" value="<%=resAcquCardCode%>">
    <input type="hidden" name="resAcquCardName" value="<%=resAcquCardName%>">
</form>
<script type="text/javascript">
function goPayMgrSubmit() {
    var formNm = document.payMgr;
    formNm.action = "../card/payResult_card.jsp";
    formNm.submit();
    return true;
}
<%-- 결제 로직 전송실패후 form submit --%>
function goPayFailMgrSubmit() {
	var formNm = document.payMgr;
	formNm.target='payWindow';
	formNm.action = "../card/payResultFail_card.jsp";
	payMgr.submit();
    return true;
}
</script>
<% if(resResultCode.equals("3001")) { // 성공시 처리로직 %>      
		<script type="text/javascript">
		    goPayMgrSubmit();   
		</script>
<% }else{ // 실패시 처리로직%>
		<script type="text/javascript">
    		goPayFailMgrSubmit();
		</script>
<% 
   }
} //end if %>
</body>
</html>