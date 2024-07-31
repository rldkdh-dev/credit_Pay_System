<%@page contentType="text/html; charset=utf-8"
        import="acp.pg.ACPLib
                , kr.co.seeroo.spclib.SPCLib
                , org.json.simple.JSONObject
                , org.json.simple.JSONValue"%>
<%@ include file="../../common/cardParameter.jsp" %>
<%
System.out.println("**** Start input_AppCard.jsp ****");
// acp.pg.ACPLib 패키지 포함(메시지 생성 사용)
//Cache 의존 제거
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);                
    request.setCharacterEncoding("utf-8");
                
    String pointUseYN = "";
    String bankcode = CommonUtil.getDefaultStr(request.getParameter("bankcode"),"");
    String co_no = CommonUtil.getDefaultStr(request.getParameter("co_no"),"");
    String co_nm = CommonUtil.getDefaultStr(request.getParameter("co_nm"),"");
    String fn_no = CommonUtil.getDefaultStr(request.getParameter("fn_no"),"");
    String bankCd_ispm = CommonUtil.getDefaultStr(request.getParameter("bankCd_ispm"),"0204");
  
    final String pgID = "PGID14F495EBD4C";  // PG사 고유 아이디

    String cardsa_name = "KB국민카드";      // 01.카드사명
    String currency = "410";                // 03.통화코드(고정)
    String aff_name = co_nm;                // 04.가맹점명
    String aff_biz_no = co_no;      // 05.가맹점 사업자번호
    String aff_tran_ip = UserIP;        // 06.CLIENT_IP
    String aff_type = "M";                  // 07.가맹점 유형
    String aff_code = fn_no; // 08.가맹점 코드 (카드사에서 부여한 코드 운영시 변경필요)    
    String return_url = "";                 // 09.RETURN URL
    String pg_cp_code = MID;            // 10.PG사 관리 CP 코드
    String pg_req_date = TimeUtils.getyyyyMMdd();       // 11.PG사 요청일자 (yyyyMMdd)
    String pg_req_time = TimeUtils.getHHmmss();         // 12.PG사 요청시각 (HHmmss)
    String pay_type = "2";                  // 15.결제 타입
    String pg_biz_no = "1248702232";        // 16.PG사업자번호
    String tran_user_id = mallUserID;       // 17.거래 사용자 정보
    String merchant_kb = pgID;              // 24.대표 가맹점 ID
    String order_no = TID;  // 28. 가맹점 고유 거래식별번호(주문번호)
    String is_liquidity = "N";              // 29. 환금성 상품 여부 ("Y": 환금성 상품, "N" 또는 "": 환금성 상품 아님)
    
    String decData = "";
    String key = "";
    String encData2 = "";
    String signature = ACPLib.getVersion(); // 전문 생성 라이브러리 버전 정보
    String seedKey = "";
    String affiliateBizNo = "";
    
    try {       
    	// 암복호화에 필요한 seedKey 생성 (16자리 문자열)
        // 생성형식 : aff_biz_no 뒤 4자리 +  pg_req_date 뒤 6자리 + pg_req_time 6자리로
        seedKey = aff_biz_no.substring(6, 10) + pg_req_date.substring(2, 8) + pg_req_time;
        
        // seedKey 세션 저장
        request.getSession().setAttribute("seedKey", seedKey);
        
        // JSON 매핑 후 암호화
        JSONObject json = new JSONObject();
        json.put("cardsaName", cardsa_name);
        json.put("currency", currency);
        json.put("affiliateName", aff_name);
        json.put("affiliateBizNo", aff_biz_no);
        json.put("affiliateTranIP", aff_tran_ip);
        json.put("affiliateType", aff_type);
        json.put("affiliateCode", aff_code);    
        json.put("returnURL", return_url);
        json.put("pgCPcode", pg_cp_code);
        json.put("pgReqDate", pg_req_date);
        json.put("pgReqTime", pg_req_time);
        json.put("payType", pay_type);
        json.put("pgBizNo", pg_biz_no);
        json.put("tranUserID", tran_user_id);
        json.put("merchantKB", merchant_kb);
        json.put("orderNo", order_no);
        json.put("isLiquidity", is_liquidity);
        
        json.put("amount", Amt);                                 // 02.결제금액
        json.put("savePayOption", "");                           // 13.세이브결제 옵션 처리   
        json.put("easyPayOption", "");                   // 14.간편결제 옵션 처리
        json.put("nointInf", KVP_NOINT_INF);    // 18.무이자 할부 정보
        //json.put("quotaInf", KVP_QUOTA_INF);   // 19.일반할부개월수 정보
        json.put("quotaInf", CardQuota);   // 19.일반할부개월수 정보
        json.put("noIntFlag1", "NOINT");                         // 20.무이자 또는 공백 표시
        json.put("noIntFlag2", "TRUE");                         // 21.유무이자 할부 디스플레이 정보 2018-06-22 TRUE로 변경
        json.put("kbSavePointree", "FALSE");                 // 22.KB 세이브포인트리 연동
        json.put("fixPayFlag", "FALSE");                         // 23.복합결제 연동 플래그
        
        
        // 3. JSONString 으로 만든 데이터를 암호화합니다.
        String[] ret = ACPLib.getACPReqV1(json.toJSONString());     // 인증 데이터 생성
        
        if("ACPR0000".equals(ret[0])) { // 인증 데이터 생성 성공
            key = ret[1];       // 암호화 키
            encData2 = ret[2];  // 암호화 된 데이터
            request.getSession().setAttribute("xid", ret[3]);   // XID 세션에 저장
        } else {                // 예외처리
            System.out.println("fail to encrypt data..");
            out.print("<script>alert('인증 데이터 처리에 실패 하였습니다. 다시 시도해 주십시오.(2011)');</script>");
            return;
        }
    } catch(Exception e) {      // 예외처리     
        e.printStackTrace();    
        out.print("<script>alert('인증 데이터 처리에 실패 하였습니다. 다시 시도해 주십시오.(2012)');</script>");
        return;
    }
    
    String resUrl = "";
    if (request.getServerPort() == 80 || request.getServerPort() == 443) {
    	resUrl = request.getScheme() + "://" + request.getServerName() +"/ipay/card/kb/result_m.jsp";
    } else {
    	resUrl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort()+"/ipay/card/kb/result_m.jsp";
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
        <script type="text/javascript" src="https://srcode.net/tcode/js/json2.js"></script>
        <script type="text/javascript" src="https://srcode.net/tcode/js/acpay.js"></script>
        <link rel="stylesheet" type="text/css" href="../../css/jquery.mCustomScrollbar.css" />
        <link rel="stylesheet" type="text/css" href="../../css/common.css" />
        <link href='../../css/font.css' rel='stylesheet' type='text/css'>
<script type="text/javascript">
    window.onload = function(){
    	  
        doOrder();
        
    };
    // 결제 요청 
    function doOrder() {
    	doACPAYMW5('<%=key%>'
                , '<%=encData2%>'
                , './accpreqMW.jsp'
                , './accpres_m.jsp'
                , '<%=resUrl%>'
                , 'TRUE'
                , 'FALSE'
                , '<%=aff_biz_no%>'
        );
    }
    <%-- 결제요청 --%>
    function goPayment() {
        var formNm = document.tranMgr;
        formNm.action = "../payConfirm_card_m.jsp";
        formNm.submit();
    }
    // 결제창에서 ISP 결제 선택 시 호출 되는 함수
    function goISP() {
        // ISP 결제 모듈을 호출하셔야 합니다.
        // alert('ISP 결제 모듈 호출!!');
        //install_notice_on();
        var formNm = document.tranMgr;
        //formNm.target='AppFrame';
        formNm.action = "../isp/sendMISPTrans.jsp";
        formNm.submit();
    }

    // 결제 성공 시 호출 되는 함수
    function onACPAYResult(resultCode) {
    	if('0000' == resultCode) {
            goPayment();
        } else {
            alert('결제에 실패하였습니다. (' + resultCode + ')');
            window.parent.postMessage('close','*'); 
        }
    }
    
    // 결제 도중 오류 발생 시 호출되는 함수
    function onACPAYError(code) {

        switch(code) {
            case 1001: alert('팝업 차단 설정 해제 후 다시 결제를 해 주십시오.(1001)');         break;  // 팝업 차단 설정이 되어 있는 경우
            case 2001: alert('인증 데이터 처리에 실패 하였습니다. 다시 시도해 주십시오.(2001)'); break; // 인증 데이터 암호화 실패
            case 2011: alert('인증 데이터 처리에 실패 하였습니다. 다시 시도해 주십시오.(2011)'); break; // 인증 데이터 암호화 실패
            case 2012: alert('인증 데이터 처리에 실패 하였습니다. 다시 시도해 주십시오.(2012)'); break; // 인증 데이터 암호화 실패
            case 3001: alert('거래키 발급에 실패하였습니다. 다시 시도해 주십시오.(3001)');    break;  // 거래키 발급 실패
            case 3002: alert('인증 데이터 처리에 실패하였습니다. 다시 시도해 주십시오.(3002)');     break;  // 인증 데이터 복호화 실패
            case 9101: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9101)');  break;  // 결제 코드 발급 실패 - 시스템 오류
            case 9102: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9102)');  break;  // 결제 코드 발급 실패 - acpKey 복호화 오류
            case 9103: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9103)');  break;  // 결제 코드 발급 실패 - acpKey 타임아웃
            case 9104: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9104)');  break;  // 결제 코드 발급 실패 - acpReq 복호화 오류
            case 9105: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9105)');  break;  // 결제 코드 발급 실패 - Hash mac 불일치
            case 9106: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9106)');  break;  // 결제 코드 발급 실패 - acpReq json 형식 오류
            case 9199: alert('거래 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9199)');  break;  // 거래 코드 발급 실패 - 시스템 오류
            case 9201: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9201)');    break;  // 거래키 요청 실패 - 시스템 오류
            case 9202: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9202)');    break;  // 거래키 요청 실패 - 유효하지 않은 pollingToken (pollingToken 복호화 오류)
            case 9203: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9203)');    break;  // 거래키 요청 실패 - 유효하지 않은 pollingToken (pollingToken 타임아웃)
            case 9204: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9204)');    break;  // 거래키 요청 실패 - 해당 결제코드가 유효하지 않습니다. (결제코드가 존재하지 않음)
            case 9205: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9205)');    break;  // 거래키 요청 실패 - 유효하지 않은 pollingToken (결제코드 불일치) 
            case 9206: alert('결제 인증 시간이 만료되었습니다. 다시 시도해 주십시오.(9206)');  break;  // 거래키 요청 실패 - 해당 결제코드의 거래시간이 만료 (결제코드 타임아웃)
            case 9207: alert('이미 결제된 코드입니다. 다시 시도해 주십시오.(9207)');       break;  // 거래키 요청 실패 - 해당 결제코드는 처리완료 되었습니다. (이미 결제 완료 처리됨)
            case 9299: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9299)');    break;  // 거래키 요청 실패 - 시스템 오류
            default: alert('결제 도중 오류가 발생하였습니다. 다시 시도해 주십시오.('+code+')');    break;  // 기타 오류
        }
        window.parent.postMessage('close','*'); 
    }
</script>
</head>
<body>
<form name="tranMgr" method="post" action="">
<input type="hidden" name="PayMethod"       value="<%=PayMethod%>"/>
<input type="hidden" name="pointUseYN"      value="<%=pointUseYN%>"/>
<input type="hidden" name="formBankCd"      value="<%=formBankCd%>"/>
<input type="hidden" name="bankcode"        value="<%=bankcode%>"/>
<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
<input type="hidden" name="GoodsName"       value="<%=GoodsName%>"/>
<input type="hidden" name="GoodsURL"        value="<%=GoodsURL%>"/>
<input type="hidden" name="Amt"             value="<%=Amt%>"/>
<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
<input type="hidden" name="CardInterest"    value="<%=CardInterest%>"/>
<input type="hidden" name="CardQuota"    value="<%=CardQuota%>"/>
<input type="hidden" name="CardPoint"       value="0"/>
<input type="hidden" name="Moid"            value="<%=Moid%>"/>
<input type="hidden" name="MID"             value="<%=MID%>"/>
<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/>
<input type="hidden" name="ResultYN"        value="<%=ResultYN%>"/>
<input type="hidden" name="RetryURL"        value="<%=RetryURL%>"/>
<input type="hidden" name="mallUserID"      value="<%=mallUserID%>"/>
<input type="hidden" name="BuyerName"       value="<%=BuyerName%>"/>
<input type="hidden" name="BuyerAuthNum"    value="<%=BuyerAuthNum%>"/>
<input type="hidden" name="BuyerTel"        value="<%=BuyerTel%>"/>
<input type="hidden" name="BuyerEmail"      value="<%=BuyerEmail%>"/>
<input type="hidden" name="ParentEmail"     value="<%=ParentEmail%>"/>
<input type="hidden" name="BuyerAddr"       value="<%=BuyerAddr%>"/>
<input type="hidden" name="BuyerPostNo"     value="<%=BuyerPostNo%>"/>
<input type="hidden" name="UserIP"          value="<%=UserIP%>"/>
<input type="hidden" name="MallIP"          value="<%=MallIP%>"/>
<input type="hidden" name="BrowserType"     value="<%=BrowserType%>"/>
<input type="hidden" name="TID"             value="<%=TID%>"/>
<input type="hidden" name="quotabase"       value="<%=quotabase%>"/>
<input type="hidden" name="MallReserved"    value="<%=MallReserved%>"/>
<input type="hidden" name="MallResultFWD"   value="<%=MallResultFWD%>"/> 
<input type="hidden" name="EncodingType"   value="<%=EncodingType%>"/> 
<input type="hidden" name="OfferingPeriod"   value="<%=OfferingPeriod%>"/> <%-- 제공 기간 변수 --%>
<input type="hidden" name="device"      value="<%=device%>"><%-- 테스트 모드 변수 --%>
<input type="hidden" name="svcCd"      value="<%=svcCd%>">
<input type="hidden" name="svcPrdtCd"      value="<%=svcPrdtCd%>">
<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
<input type="hidden" name="User_ID"         value="<%=User_ID%>">
<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
<input type="hidden" name="BuyerCode"      value="<%=BuyerCode%>">
<input type="hidden" name="MerchantNo_ispm" value="<%=fn_no%>">
<input type="hidden" name="bankCd_ispm" value="<%=bankCd_ispm%>">
<input type="hidden" name="Noint_Inf" value="<%=CardQuota%>" >
<input type="hidden" name="co_no" value="<%=co_no%>">
<input type="hidden" name="co_nm" value="<%=co_nm%>">
<input type="hidden" name="sp_chain_code" value="">
<input type="hidden" name="fn_no" value="<%=fn_no%>">
<input type="hidden" name="FORWARD"        value="<%=FORWARD%>">
<input type="hidden" name="EncryptData"    value="<%=EncryptData%>"> <!-- 거래검증값 추가(2018.08 hans) -->
<input type="hidden" name="ediDate"        value="<%=ediDate%>">
<input type="hidden" name="RefererURL"    value="<%=RefererURL%>">

<%-- 결제처리후 받을 파라미터값 (from mpi) --%>
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
</form>
<div style="height:50px;">
    <section class="innopay_wrap">

        <header class="gnb">
            <h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="../../images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
            <div class="kind">
                <span>신용카드결제</span>
            </div>
        </header>
    </section>
    <!-- Notice -->
		<%@ include file="/common/notice.jsp" %>
</div>
<!--// ISP안내 popup-->
<!--                 <section class="float_wrap install_notice">
                    <div class="dim_blue"></div>
                    <div class="popup_cont">
                        <img src="../images/i_info.png" alt="알림" width="60px" height="auto">
                        <p>해당 카드는 ISP인증 결제 카드 입니다.<br>카드 ISP인증 후 결제 바랍니다.</p>
                        <br>
                        <section class="btn_wrap_multi">
                            <div id="btn_wrap">
                                <a class="btn_black btn dim_btn" href="javascript:install_notice_off()">취소</a>
                                <a class="btn_black btn install_notice_btn" href="#" onclick="return goPayment()">다음</a>
                            </div>
                        </section>
                    </div>
                </section> -->

</body>
</html>