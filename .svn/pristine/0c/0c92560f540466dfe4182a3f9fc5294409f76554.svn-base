<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 가상계좌 결제확인페이지
*	@ PROGRAM NAME		: payConfirm.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2018.01.04
*	@ PROGRAM CONTENTS	: 결제확인페이지
*
************************** 변 경 이 력 *****************************************
*	번호	작업자		작업일				변경내용
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
<%@ include file="../common/commonParameter.jsp" %>
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
//    System.out.println("svcCd=============="+svcCd);
    
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
    
    String strVbankExpDate = VbankExpDate.substring(0,4) + ". " + VbankExpDate.substring(4,6) + ". " + VbankExpDate.substring(6,8) ;
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
    var submitCnt = 0;
    // 확인 완료 결제 요청 function 
    function goConfirm() {
        var formNm = document.tranMgr;
    
        if(submitCnt > 0) {
            return false;
        }
        
        submitCnt++;
        formNm.action = "payTrans.jsp";
        formNm.submit();
        return false;
    }
    
    // 결제 과정 취소 function 
    function goCancel() {
    	try{
    		if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
    			window.open('', '_self', '');
    		    window.close();
    		}else if((window.parent!=null&&window.parent!=undefined)||('X'=='<%=FORWARD%>')){
    			window.parent.postMessage('close','*');
    		}else{
    			windows.location.href='<%=RefererURL%>';
    		}
    	}catch(e){}
    }
    
    // 이메일 입력 key 이벤트 처리 function 
    function pressKey() {
      if(event.keyCode == 13) { 
        return goConfirm(); 
        event.returnValue=false; 
      }
      return true;
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
<input type="hidden" name="OfferingPeriod"  value="<%=OfferingPeriod%>"/> 
<input type="hidden" name="device"      	value="<%=device%>">
<input type="hidden" name="svcCd"      		value="<%=svcCd%>">
<input type="hidden" name="svcPrdtCd"       value="<%=svcPrdtCd%>">
<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
<input type="hidden" name="User_ID"         value="<%=User_ID%>">
<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
<input type="hidden" name="BuyerCode"       value="<%=BuyerCode%>">
<input type="hidden" name="FORWARD"         value="<%=FORWARD%>">
<input type="hidden" name="ResultYN"        value="<%=ResultYN%>">
<input type="hidden" name="EncryptData"     value="<%=EncryptData%>"> <!-- 거래검증값 추가(2018.08 hans) -->
<input type="hidden" name="ediDate"         value="<%=ediDate%>">
<input type="hidden" name="RefererURL"      value="<%=RefererURL%>">
<!-- VBank -->
<input type="hidden" name="BankCode"   		value="<%=BankCode%>"/>
<input type="hidden" name="VBankAccountName" value="<%=VBankAccountName%>"/>
<input type="hidden" name="cashReceiptType" value="<%=cashReceiptType%>"/>
<input type="hidden" name="receiptTypeNo"   value="<%=receiptTypeNo%>"/>
<input type="hidden" name="receiptType"   	value="<%=receiptType%>"/>
    
    <div class="innopay">
        <div class="dim"></div>
        <section class="innopay_wrap">
            <header class="gnb">
                <h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="../images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
                <div class="kind">
                    <span>가상계좌결제</span>
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
                            <li class="term">
                                <div class="info_title">입금기한</div>
                                <div><%=strVbankExpDate %></div>
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
                                <div class="info_title">입금은행</div>
                                <div><%=resFnNmCode1.getString("fn_nm_code1")%></div>
                            </li>
                            <li>
                                <div class="info_title">입금계좌</div>
                                <div>다음페이지에서 확인 가능합니다.</div>
                            </li>
                            <li>
                                <div class="info_title">입금자명</div>
                                <div><%=VBankAccountName%></div>
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
                    	<p>상기내용은 예약상태입니다. 가상계좌 발급을 원하시면 <b>다음</b> 버튼을 클릭하십시요.</p>   
                        <!-- <p>상기내용은 예약상태이며, 결제정보를 받으실<br> E-mail을 입력하시고 <b>다음</b> 버튼을 클릭하십시요.</p> -->   
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