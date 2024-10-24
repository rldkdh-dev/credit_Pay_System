<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 결제확인페이지
*	@ PROGRAM NAME		: payConfirm.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2018.01.15
*	@ PROGRAM CONTENTS	: 결제확인페이지
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="service.SupportIssue" %>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.document.GiftBox" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%@ page import="kr.co.seeroo.spclib.SPCLib, org.json.simple.JSONObject"%>
<%@ page import="kr.co.infinisoft.pg.common.*" %>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%-- 공통 common include --%>
<%
request.setCharacterEncoding("utf-8");

Enumeration em = request.getParameterNames();
HashMap paramMap = new HashMap();
while(em.hasMoreElements())
{
    String key = em.nextElement().toString();
    String value = request.getParameter(key);
    paramMap.put(key, value);
}
System.out.println("====KFTC response Param "+paramMap.toString());

    //파라미터 체크
    String PayMethod        = CommonUtil.getDefaultStr(request.getParameter("PayMethod"), "");
    String payType          = CommonUtil.getDefaultStr(request.getParameter("payType"), ""); // 사용안함
    String GoodsCnt         = CommonUtil.getDefaultStr(request.getParameter("GoodsCnt"), "");
    String GoodsName        = CommonUtil.getDefaultStr(request.getParameter("GoodsName"), "");
    String GoodsURL         = CommonUtil.getDefaultStr(request.getParameter("GoodsURL"), ""); // 사용안함
    String GoodsCl          = CommonUtil.getDefaultStr(request.getParameter("GoodsCl"), ""); // 상품구분 (1:컨텐츠/2:현물), 사용안함
    String Amt              = CommonUtil.getDefaultStr(request.getParameter("Amt"), "");   
    String DutyFreeAmt		= CommonUtil.getDefaultStr(request.getParameter("DutyFreeAmt"), "0");	// 면세관련 필드 추가 (2019.04 hans)
    String TaxAmt			= CommonUtil.getDefaultStr(request.getParameter("TaxAmt"), "0");		// 면세관련 필드 추가 (2019.04 hans)
    String Moid             = CommonUtil.getDefaultStr(request.getParameter("Moid"), "");
    String MID              = CommonUtil.getDefaultStr(request.getParameter("MID"), "");
    String ReturnURL        = CommonUtil.getDefaultStr(request.getParameter("ReturnURL"), "");
    String ResultYN         = CommonUtil.getDefaultStr(request.getParameter("ResultYN"), "");
    String RetryURL         = CommonUtil.getDefaultStr(request.getParameter("RetryURL"), "");
    String mallUserID       = CommonUtil.getDefaultStr(request.getParameter("mallUserID"), "");
    String BuyerName        = CommonUtil.getDefaultStr(request.getParameter("BuyerName"), "");
    String BuyerAuthNum     = CommonUtil.getDefaultStr(request.getParameter("BuyerAuthNum"), ""); // 수기결제용
    String BuyerTel         = CommonUtil.getDefaultStr(request.getParameter("BuyerTel"), "");
    String BuyerEmail       = CommonUtil.getDefaultStr(request.getParameter("BuyerEmail"), "");
    String BuyerAddr        = CommonUtil.getDefaultStr(request.getParameter("BuyerAddr"), "");    // 사용안함
    String BuyerPostNo      = CommonUtil.getDefaultStr(request.getParameter("BuyerPostNo"), "");  // 사용안함
    String ParentEmail      = CommonUtil.getDefaultStr(request.getParameter("ParentEmail"), "");  // 사용안함
    String UserIP           = CommonUtil.getDefaultStr(request.getParameter("UserIP"), "");
    String MallIP           = CommonUtil.getDefaultStr(request.getParameter("MallIP"), "");
    String BrowserType      = CommonUtil.getDefaultStr(request.getParameter("BrowserType"), "");
    String ediDate          = CommonUtil.getDefaultStr(request.getParameter("ediDate"), "");
    String EncryptData      = CommonUtil.getDefaultStr(request.getParameter("EncryptData"), "");   
    String MallReserved     = CommonUtil.getDefaultStr(request.getParameter("MallReserved"), "");
    String MallResultFWD    = CommonUtil.getDefaultStr(request.getParameter("MallResultFWD"), "");
    String SUB_ID           = CommonUtil.getDefaultStr(request.getParameter("SUB_ID"), "");     // 사용안함  
    String TransType        = CommonUtil.getDefaultStr(request.getParameter("TransType"), "");  // 결제타입 [0 : 일반결제 , 1 : 에스크로 결제]
    String EncodingType     = CommonUtil.getDefaultStr(request.getParameter("EncodingType"), "");  
    String OfferingPeriod   = CommonUtil.getDefaultStr(request.getParameter("OfferingPeriod"), "");
    String device           = CommonUtil.getDefaultStr(request.getParameter("device"), "");
    String svcCd            = CommonUtil.getDefaultStr(request.getParameter("svcCd"), "");        // 지불수단
    String svcPrdtCd        = CommonUtil.getDefaultStr(request.getParameter("svcPrdtCd"), "");    // sub지불수단
    //card sms
    String OrderCode        = CommonUtil.getDefaultStr(request.getParameter("OrderCode"),"");
    String ExpTerm          = CommonUtil.getDefaultStr(request.getParameter("ExpTerm"),"1440");
    
    String User_ID          = CommonUtil.getDefaultStr(request.getParameter("User_ID"), "");
    String Pg_Mid           = CommonUtil.getDefaultStr(request.getParameter("Pg_Mid"), "");
    String BuyerCode        = CommonUtil.getDefaultStr(request.getParameter("BuyerCode"), "");
    
    // 카드코드 지정 파라미터 관련하여 아래 formBankCd 파라미터 추가 - 2015/11/04 added by GWK
    String formBankCd       = CommonUtil.getDefaultStr(request.getParameter("formBankCd"), "");
    
    // for VBank
    String VbankExpDate     = CommonUtil.getDefaultStr(request.getParameter("VbankExpDate"), ""); // 가상계좌 입금 마감일
    String BankCode         = CommonUtil.getDefaultStr(request.getParameter("BankCode"), "");       // 은행코드
    String VBankAccountName = CommonUtil.getDefaultStr(request.getParameter("VBankAccountName"), "");
    String cashReceiptType  = CommonUtil.getDefaultStr(request.getParameter("cashReceiptType"), "3");       // 현금영수증 발급구분(1:소득공제용,2:지출증빙,3:미발행)
    String receiptTypeNo    = CommonUtil.getDefaultStr(request.getParameter("receiptTypeNo"), "");          // 현금영수증 발급번호
    String receiptType      = CommonUtil.getDefaultStr(request.getParameter("receiptType"), "");            // 발급구분(1:휴대폰,2:주민번호,3:신용카드번호)
    
    String FORWARD	    	= CommonUtil.getDefaultStr(request.getParameter("FORWARD"), "Y");
    String RefererURL    	= CommonUtil.getDefaultStr(request.getParameter("RefererURL"), "");
    
    // 상품명이 긴 경우 38자미만으로 잘라낸다.
    GoodsName = CommonUtil.cutStr(GoodsName, 38);
%>
<%-- 계좌이체 common parameter include --%>
<%@ include file="../common/bankParameter.jsp" %>
<%
    String TID     = CommonUtil.getDefaultStr(request.getParameter("TID"), "");
    
    String use_cl = "";        // 가맹점 사용여부
    String moid_dup_cl = "";   // 주문번호 중복허용 여부
    String status = "";        // 결제서비스 등록여부
    String actionName = "";    // 결제승인요청 페이지 URL
    String co_no = "";  // 사업자번호
    String co_nm = "";  // 가맹점명
    
    Box req = new Box();
    Box resMemberInfo = null;
    Box resMerSvc = null;
    Box resTransReq = null;
    Box resFnNmCode1 = null;
    
    // 가맹점 정보 가져오기
    req.put("svc_cd",svcCd);
    req.put("svc_prdt_cd",svcPrdtCd);
    req.put("mid", MID);
    resMemberInfo = CommonBiz.getMemberInfo(req);
    if(resMemberInfo == null) {
        System.out.println("**********[상점정보가 없습니다]**********");
        throw new Exception("W006"); // 상점정보가 없습니다.
    }
    
    co_no       = resMemberInfo.getString("co_no");             // 사업자 번호(가맹점)
    co_nm       = resMemberInfo.getString("co_nm");             // 상호(가맹점)
    
    // 가맹점 서비스 정보 가져오기
    // svcPrdtCd=01(일반) 인 것을 가져온다.
    req.put("svc_cd", svcCd);
    req.put("svc_prdt_cd","01");
    resMerSvc = CommonBiz.getMerSvc(req);
    
    // 은행이름 가져오기
    req.put("col_nm", "bank_cd");
    req.put("code1", BankCode);
    resFnNmCode1 = CommonBiz.getFnNmCode1(req);
 
    // use_cl : 상점개시 유무 [0:사용, 1:중지, 2:해지] , moid_dup_cl : 상점주문번호 중복 확인 [0:미사용, 1:사용] , status : 상점결제 서비스 여부   [0: 미사용, 1: 사용]
    use_cl      = resMemberInfo.getString("use_cl");
    moid_dup_cl = resMemberInfo.getString("moid_dup_cl");
    status = resMerSvc.getString("status");
    
    // 해지시 로직 처리
    if(use_cl.equals("2")) {
        throw new Exception("W003"); //상점(MID)가 유효하지 않습니다.
    }
    // 상점 결제 서비스 미사용시 처리
    if(status.equals("0")) {
        System.out.println("**********[결제수단이 유효하지 않습니다]**********");
        throw new Exception("W004");
    }
    
    // 상점주문번호 중복 체크 조회
    if(moid_dup_cl.equals("1")) {
        req = new GiftBox();
        req.put("mid", MID);
        req.put("tid", TID);
        resTransReq = CommonBiz.checkOID(req);
        // 주문번호 중복시 체크
        if(resTransReq != null) {   
            System.out.println("**********[주문번호가 중복됐습니다]**********");
            throw new Exception("W005"); 
        }
    }
    
    SimpleDateFormat sdfyyMMdd = new SimpleDateFormat("yyMMdd");
    SimpleDateFormat sdfyyyyMMdd = new SimpleDateFormat("yyyyMMdd");
    
    // TID 유효성 체크
    String validTID = CommonUtil.isValidTID(TID, MID, svcCd, svcPrdtCd, sdfyyMMdd.format(new java.util.Date()));
    // 정상-00 ,  길이 체크 오류-01 ,  MID 오류-02 ,  지불수단 오류-03 ,  결제매체 오류-04 ,  날짜오류-05
    if(!validTID.equals("00")) {
        throw new Exception("W002");
    }

    // 회원사 ID에 대한 금일 거래 중복건 확인
    Box cardTransDuplicateBox = null;
    if(!StringUtils.isEmpty(mallUserID)){
        Box duplicateChkBox = new Box();
        duplicateChkBox.put("app_dt",sdfyyyyMMdd.format(new java.util.Date()));
        duplicateChkBox.put("mid",MID);
        duplicateChkBox.put("goods_amt",Amt);
        duplicateChkBox.put("goods_nm",GoodsName);
        duplicateChkBox.put("mall_user_id",mallUserID);
        List<Box> cardDulicateList = CommonBiz.getPayCardTransDuplicateHist(duplicateChkBox);
        if(cardDulicateList!=null && cardDulicateList.size() > 0){
            cardTransDuplicateBox = cardDulicateList.get(0);
        }
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="../js/jquery.mCustomScrollbar.js"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
    <script type="text/javascript" src="../js/common.js" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="../css/jquery.mCustomScrollbar.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link href='../css/font.css' rel='stylesheet' type='text/css'>
<script type="text/javascript">
<!--
var submitCnt = 0;
<%-- 확인페이지 --%>
function goConfirm() {
	var formNm = document.tranMgr;

	if(submitCnt > 0) {
		return false;
	}
	
	submitCnt++;
	formNm.action = "payTrans.jsp";
	formNm.submit();
}

<%-- 취소 --%>
function goCancel() {
	try{
		if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
			window.open('', '_self', '');
		    window.close();
		}else if((window.parent!=null&&window.parent!=undefined)||('X'=='<%=FORWARD%>')){
			window.parent.postMessage('close','*');
		}else{
			location.href='<%=RefererURL%>';
		}
	}catch(e){}
}

function chkKeyEvent(){
    if (event.keyCode == 116) {
        alert('새로고침 할수 없습니다..');
        event.keyCode = 38;
        event.returnValue=false;
        return false;
    }else if (event.ctrlKey == true) {
        alert('ctrlKey를 사용할 수 없습니다.');
        return false;
    }else if ((event.keyCode == 82) && (event.ctrlKey == true)){ //ctrl & r
        alert('새로고침 할수 없습니다..');
        event.keyCode = 2;
        return false;
    }else if (event.keyCode == 0x8) {
        alert('뒤로 돌아갈 수 없습니다.');
        return false;
    }else if (event.keyCode == 0x7A ) {
        alert('F11를 사용할 수 없습니다.');
        event.keyCode = 2;
        return false;
    }else if ( event.button=='2'){
        alert('마우스 오른쪽 버튼을 사용할 수 없습니다.');
        return false;
    }
} 
function enableEvent(obj){
    if(obj=='1'){
        document.onmousedown='';
        document.onmouseup='';
        document.onkeydown='';
        document.onkeypress='';
    }else{
        document.onmousedown=chkKeyEvent;
        document.onmouseup=chkKeyEvent;
        document.onkeydown=chkKeyEvent;
        document.onkeypress=chkKeyEvent;        
    }
}
//-->
</script>
<title>INNOPAY 전자결제서비스</title>
</head>
<body onload="enableEvent('')">
<form name="tranMgr" id="tranMgr" method="post" action="">
<input type="hidden" name="PayMethod"       value="<%=PayMethod%>">
<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>">
<input type="hidden" name="GoodsName"       value="<%=GoodsName%>">
<input type="hidden" name="GoodsURL"        value="<%=GoodsURL%>">
<input type="hidden" name="Amt"             value="<%=Amt%>">
<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
<input type="hidden" name="Moid"            value="<%=Moid%>">
<input type="hidden" name="MID"             value="<%=MID%>">
<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>">
<input type="hidden" name="RetryURL"        value="<%=RetryURL%>">
<input type="hidden" name="mallUserID"      value="<%=mallUserID%>">
<input type="hidden" name="BuyerName"       value="<%=BuyerName%>">
<input type="hidden" name="BuyerAuthNum"    value="<%=BuyerAuthNum%>">
<input type="hidden" name="BuyerTel"        value="<%=BuyerTel%>">
<input type="hidden" name="BuyerEmail"      value="<%=BuyerEmail%>">
<input type="hidden" name="ParentEmail"     value="<%=ParentEmail%>">
<input type="hidden" name="BuyerAddr"       value="<%=BuyerAddr%>">
<input type="hidden" name="BuyerPostNo"     value="<%=BuyerPostNo%>">
<input type="hidden" name="UserIP"          value="<%=UserIP%>">
<input type="hidden" name="MallIP"          value="<%=MallIP%>">
<input type="hidden" name="BrowserType"     value="<%=BrowserType%>">
<input type="hidden" name="TID"             value="<%=TID%>">
<input type="hidden" name="VbankExpDate"    value="<%=VbankExpDate%>">
<input type="hidden" name="MallReserved"    value="<%=MallReserved%>">
<input type="hidden" name="MallResultFWD"   value="<%=MallResultFWD%>">
<input type="hidden" name="TransType"       value="<%=TransType%>">
<input type="hidden" name="SUB_ID"          value="<%=SUB_ID%>">
<input type="hidden" name="EncodingType"    value="<%=EncodingType%>">
<input type="hidden" name="OfferingPeriod"   value="<%=OfferingPeriod%>"/> 
<input type="hidden" name="device"      value="<%=device%>">
<input type="hidden" name="svcCd"      value="<%=svcCd%>">
<input type="hidden" name="svcPrdtCd"      value="<%=svcPrdtCd%>">
<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
<input type="hidden" name="User_ID"         value="<%=User_ID%>">
<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
<input type="hidden" name="BuyerCode"      value="<%=BuyerCode%>">
<input type="hidden" name="FORWARD"        value="<%=FORWARD%>">
<input type="hidden" name="ResultYN"        value="<%=ResultYN%>">
<input type="hidden" name="EncryptData"    value="<%=EncryptData%>"> <!-- 거래검증값 추가(2018.08 hans) -->
<input type="hidden" name="ediDate"        value="<%=ediDate%>">
<input type="hidden" name="RefererURL"     value="<%=RefererURL%>">
<!-- VBank -->
<input type="hidden" name="BankCode"   value="<%=BankCode%>"/>
<input type="hidden" name="VBankAccountName"   value="<%=VBankAccountName%>"/>
<input type="hidden" name="cashReceiptType"   value="<%=cashReceiptType%>"/>
<input type="hidden" name="receiptTypeNo"   value="<%=receiptTypeNo%>"/>
<input type="hidden" name="receiptType"   value="<%=receiptType%>"/>

<%-- 계좌이체에서 사용하는 파라미터 --%>
<input type="hidden" name="hd_pre_msg_type"	value="<%=hd_pre_msg_type%>">
<input type="hidden" name="hd_msg_code"		value="<%=hd_msg_code%>">
<input type="hidden" name="hd_msg_type"		value="<%=hd_msg_type%>">
<input type="hidden" name="hd_ep_type"		value="<%=hd_ep_type%>">
<input type="hidden" name="hd_pi"			value="<%=hd_pi%>">
<input type="hidden" name="hd_approve_no"	value="<%=hd_approve_no%>">
<input type="hidden" name="hd_serial_no"	value="<%=hd_serial_no%>">
<input type="hidden" name="hd_firm_name"	value="<%=hd_firm_name%>">
<input type="hidden" name="tx_amount"		value="<%=tx_amount%>">
<input type="hidden" name="tx_user_key"     value="<%=tx_user_key%>">
<input type="hidden" name="tx_user_define"  value="<%=tx_user_define%>">
<input type="hidden" name="tx_receipt_bank" value="<%=tx_receipt_bank%>">
<input type="hidden" name="hd_input_option"	value="<%=hd_input_option%>">
<input type="hidden" name="hd_ep_option"	value="<%=hd_ep_option%>">
<input type="hidden" name="hd_timeout_yn"	value="<%=hd_timeout_yn%>">
<input type="hidden" name="hd_timeout"		value="<%=hd_timeout%>">
<input type="hidden" name="tx_email_addr"   value="<%=tx_email_addr%>">
<input type="hidden" name="TransType" 		value="<%=TransType %>">


<div class="innopay">
        <div class="dim"></div>
        <section class="innopay_wrap">
            <header class="gnb">
                <h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="../images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
                <div class="kind">
                    <span>계좌이체결제</span>
                </div>
            </header>

            <section class="contents">
                <section class="order_info">
                    <ol class="step">
                        <li>입력</li>
                        <li class="on">확인</li>
                        <li>완료</li>
                    </ol>
                    <div class="product_info">
                        <ul>
                            <li class="company_name">
                                    <div class="info_title">상점명</div>
                                    <div><%=resMemberInfo.getString("co_nm") %></div>
                            </li>
                            <li class="product_name">
                                <div class="info_title">상품명</div>
                                <div><%=GoodsName%></div>
                            </li>
                            <li class="price">
                                <div class="info_title">상품가격</div>
                                <div><%=CommonUtil.setComma(Amt)%><span>원</span></div>
                            </li>
                            <li class="term">
                                <div class="info_title">제공기간</div>
                                <div><%if(OfferingPeriod.equals("")||OfferingPeriod.equals("0")){out.print("별도 제공기간 없음");
                                           }else{ out.print(OfferingPeriod); } %></div>
                            </li>
                            
                        </ul>
                    </div>
                </section>
                
                <section class="con_wrap">
                <div class="con_scroll">
                    <section class="payment_info">
                        <h2>결제요청 내역</h2>
                        <ul>
                            <li>
                                <div class="info_title">구매자명</div>
                                <div><%=BuyerName%></div>
                            </li>
                            <li>
                                <div class="info_title">결제방법</div>
                                <div>계좌이체</div>
                            </li>
                            <li>
                                <div class="info_title">현금영수증</div>
                                <div><%if(cashReceiptType.equals("1")||cashReceiptType.equals("2")){%>
                                                            발행
                                                        <%}else{%>
                                                            미발행
                                                        <%} %></div>
                            </li>
                            <li>
                                <div class="info_title">이메일</div>
                                <div><%=BuyerEmail%></div>
                            </li>
                        </ul>
                    </section>
                    <section class="confirm_notice">
                        <p>결제요청 내역을 확인하시고<br>동의하면 하단의 <b>다음</b> 버튼을 클릭하시어<br>결제를 진행하여 주세요.</p>   
                    </section>
                    </div>

                    <section class="btn_wrap_multi">
                        <div>
                            <a class="btn_gray btn" href="#" onclick="return goCancel()">취소</a>
                            <a class="btn_blue btn" href="#" onclick="return goConfirm()">다음</a>
                        </div>
                    </section>
                </section>

          <section class="footer pc">
                      <p>INNOPAY 1688 - 1250</p>                 
                    </section>

            </section>
            
            <!-- Notice -->
			<%@ include file="/common/notice.jsp" %>
            
        </section>
    </div>
</form>
</body>
</html>