<%
/*****************************************************************************
*
*	@ SYSTEM NAME		: 신용카드 수기결제 요청 확인 페이지
*	@ PROGRAM NAME		: payConfirm_card_keyin.jsp
*	@ MAKER				: InnoPay PG
*	@ MAKE DATE			: 2019.01.17
*	@ PROGRAM CONTENTS	: 신용카드 수기결제 요청 확인 페이지
*
******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="../common/cardParameter.jsp" %>
<%@ include file="../danal/inc/function.jsp"%>
<%
	System.out.println("**** Start /card/payConfirm_card_keyin.jsp ****");
	
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
	
	PayMethod = "CKEYIN";
	
	String use_cl = "";        // 가맹점 사용여부
	String moid_dup_cl = "";   // 주문번호 중복허용 여부
	String status = "";        // 결제서비스 등록여부
	String actionName = "";    // 결제승인요청 페이지 URL

	Box req = new Box();
	Box resMemberInfo = null;
	Box resMerSvc = null;
	Box resTransReq = null;
	
	// 가맹점 정보 가져오기
	req.put("mid", MID);
	resMemberInfo = CommonBiz.getMemberInfo(req);
	
	// 가맹점 서비스 정보 가져오기
	// svcPrdtCd=01(일반) 인 것을 가져온다.
	req.put("svc_cd", svcCd);
	req.put("svc_prdt_cd","01");
	resMerSvc = CommonBiz.getMerSvc(req);
	
	// use_cl : 상점개시 유무 [0:사용, 1:중지, 2:해지] , moid_dup_cl : 상점주문번호 중복 확인 [0:미사용, 1:사용] , status : 상점결제 서비스 여부   [0: 미사용, 1: 사용]
	use_cl		= resMemberInfo.getString("use_cl");
	moid_dup_cl	= resMemberInfo.getString("moid_dup_cl");
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
	
	// 가상키패드 적용
	String card_num1 = CommonUtil.getDefaultStr(request.getParameter("card_num1"), "");
	String card_num2 = CommonUtil.getDefaultStr(request.getParameter("card_num2"), "");
	String card_num3 = CommonUtil.getDefaultStr(request.getParameter("card_num3"), "");
	String card_num4 = CommonUtil.getDefaultStr(request.getParameter("card_num4"), "");
	cardno = card_num1+card_num2+card_num3+card_num4;
	
	//System.out.println("card_num1 ["+card_num1+"]");
	//System.out.println("card_num2 ["+card_num2+"]");
	//System.out.println("card_num3 ["+card_num3+"]");
	//System.out.println("card_num4 ["+card_num4+"]");
	//System.out.println("cardno ["+cardno+"]");
	
	// 카드사명 조회
    Box reqBox = new Box();
    reqBox.put("col_nm", "card_cd");
    reqBox.put("code1", formBankCd);
    Box resBox = CardSms.getCardBinList(cardno.substring(0, 6));
    String cardName = resBox.getString("issue_org");
    
    formBankCd = resBox.getString("fn_cd");
    
    String dispCardNo = null;
    
    if(cardno.length() > 0){
    	dispCardNo = cardName + " ("+cardno.substring(0,4)+"-****-****-"+cardno.substring(cardno.length()-4,cardno.length())+")";
	}
    
	actionName = "payTransKeyin.jsp";
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
    <script type="text/javascript" src="../js/card_pay.js" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="../css/jquery.mCustomScrollbar.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link href='../css/font.css' rel='stylesheet' type='text/css'>
    <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
	<script type="text/javascript">
		function googleTranslateElementInit() {
			new google.translate.TranslateElement({pageLanguage: 'ko', includedLanguages: 'ar,de,en,es,fr,hi,ja,mn,ms,ru,th,tr,vi,zh-CN', layout: google.translate.TranslateElement.InlineLayout.SIMPLE, autoDisplay: false}, 'google_translate_element');
		}
	</script>    
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
		formNm.action = "<%=actionName%>";
		
		if('<%=FORWARD%>' == 'Y'){
    		formNm.target='payWindow';
    	}else{
    		formNm.target='_self';
    	}

		formNm.submit();
		return false;
	}
	
	// 결제로직 전송후 form submit function
	function goPayMgrSubmit() {
	
		var formNm = document.tranMgr;
	
	    formNm.action = "payResult_card.jsp";
	    formNm.submit();
		
		return false;
	}
	
	// 결제 로직 전송실패후 form submit function 
	function goPayFailMgrSubmit() {
		
		var formNm = document.tranMgr;
	
		formNm.action = "payResultFail_card.jsp";
		formNm.submit();
	
	    return false;
	}
	
	// 결제 과정 취소 function 
	function goCancel() {
		document.tranMgr.action = "index_card_keyin.jsp";
		document.tranMgr.submit();
		
		return false;
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
	
	function focusNextItem(field, limit, next) {
		if (field.value.length == limit) {
			document.getElementById(next).focus();
		}
	}
	
</script>
<title>INNOPAY 전자결제서비스</title>
</head>
<body onload="enableEvent('')">
<form name="tranMgr" id="tranMgr" method="post" action="">
<input type="hidden" name="PayMethod"		value="<%=PayMethod%>">
<input type="hidden" name="formBankCd"		value="<%=formBankCd%>">
<input type="hidden" name="GoodsCnt"		value="<%=GoodsCnt%>">
<input type="hidden" name="GoodsName"		value="<%=GoodsName%>">
<input type="hidden" name="GoodsURL"		value="<%=GoodsURL%>">
<input type="hidden" name="GoodsCl"			value="<%=GoodsCl%>">
<input type="hidden" name="Amt"				value="<%=Amt%>">
<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
<input type="hidden" name="CardInterest"    value="<%=CardInterest%>">
<input type="hidden" name="CardQuota"		value="<%=CardQuota%>">
<input type="hidden" name="Moid"			value="<%=Moid%>">
<input type="hidden" name="MID"				value="<%=MID%>">
<input type="hidden" name="ReturnURL"		value="<%=ReturnURL%>">
<input type="hidden" name="ResultYN"        value="<%=ResultYN%>">
<input type="hidden" name="RetryURL"		value="<%=RetryURL%>">
<input type="hidden" name="mallUserID"		value="<%=mallUserID%>">
<input type="hidden" name="BuyerName"		value="<%=BuyerName%>">
<input type="hidden" name="BuyerAuthNum"	value="<%=BuyerAuthNum%>">
<input type="hidden" name="BuyerTel"		value="<%=BuyerTel%>">
<input type="hidden" name="BuyerEmail"        value="<%=BuyerEmail%>">
<input type="hidden" name="ParentEmail"		value="<%=ParentEmail%>">
<input type="hidden" name="BuyerAddr"		value="<%=BuyerAddr%>">
<input type="hidden" name="BuyerPostNo"		value="<%=BuyerPostNo%>">
<input type="hidden" name="UserIP"			value="<%=UserIP%>">
<input type="hidden" name="MallIP"			value="<%=MallIP%>">
<input type="hidden" name="BrowserType"		value="<%=BrowserType%>">
<input type="hidden" name="CardPoint"		value="<%=CardPoint%>">
<input type="hidden" name="MallReserved"    value="<%=MallReserved%>"> 
<input type="hidden" name="SUB_ID"          value="<%=SUB_ID%>"> 
<input type="hidden" name="EncodingType"    value="<%=EncodingType%>">
<input type="hidden" name="RefererURL"       value="<%=RefererURL%>">
<%-- from mpi --%>
<input type="hidden" name="TID"				value="<%=TID%>">
<input type="hidden" name="eci"				value="<%=eci%>">
<input type="hidden" name="xid"				value="<%=xid%>">
<input type="hidden" name="cavv"			value="<%=cavv%>">
<input type="hidden" name="cardno"			value="<%=cardno%>">
<input type="hidden" name="joinCode"		value="<%=joinCode%>">
<%-- from direct input jsp page --%>
<input type="hidden" name="CardExpire"		value="<%=CardExpire%>">
<input type="hidden" name="CardPwd"			value="<%=CardPwd%>">
<input type="hidden" name="quotabase"	    value="<%=quotabase%>">
<%-- from isp --%>
<input type="hidden" name="KVP_PGID"		value="<%=KVP_PGID%>">
<input type="hidden" name="KVP_GOODNAME"	value="<%=KVP_GOODNAME%>">
<input type="hidden" name="KVP_PRICE"		value="<%=KVP_PRICE%>">
<input type="hidden" name="KVP_CURRENCY"	value="<%=KVP_CURRENCY%>">
<input type="hidden" name="KVP_NOINT_INF"	value="<%=KVP_NOINT_INF%>">
<input type="hidden" name="KVP_QUOTA_INF"	value="<%=KVP_QUOTA_INF%>">
<input type="hidden" name="KVP_IMGURL"		value="<%=KVP_IMGURL%>">
<input type="hidden" name="KVP_NOINT"		value="<%=KVP_NOINT%>">
<input type="hidden" name="KVP_QUOTA"		value="<%=KVP_QUOTA%>">
<input type="hidden" name="KVP_CARDCODE"	value="<%=KVP_CARDCODE%>">
<input type="hidden" name="KVP_CONAME"		value="<%=KVP_CONAME%>">
<input type="hidden" name="KVP_SESSIONKEY"	value="<%=KVP_SESSIONKEY%>">
<input type="hidden" name="KVP_ENCDATA"		value="<%=KVP_ENCDATA%>">
<input type="hidden" name="KVP_RESERVED1"	value="<%=KVP_RESERVED1%>">
<input type="hidden" name="KVP_RESERVED2"	value="<%=KVP_RESERVED2%>">
<input type="hidden" name="KVP_RESERVED3"	value="<%=KVP_RESERVED3%>">
<input type="hidden" name="MallResultFWD"   value="<%=MallResultFWD%>">		
<input type="hidden" name="TransType" 		value="<%=TransType%>">	
<input type="hidden" name="OfferingPeriod" 		value="<%=OfferingPeriod%>"> 
<input type="hidden" name="device" 		value="<%=device%>">
<input type="hidden" name="svcCd"      value="<%=svcCd%>">
<input type="hidden" name="svcPrdtCd"      value="<%=svcPrdtCd%>">
<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
<input type="hidden" name="User_ID"         value="<%=User_ID%>">
<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
<input type="hidden" name="BuyerCode"      value="<%=BuyerCode%>">
<input type="hidden" name="FORWARD"        value="<%=FORWARD%>">
<input type="hidden" name="EncryptData"    value="<%=EncryptData%>"> <!-- 거래검증값 추가(2018.08 hans) -->
<input type="hidden" name="ediDate"        value="<%=ediDate%>">
<input type="hidden" name="resErrorCD">
<input type="hidden" name="resErrorMSG">
<input type="hidden" name="resResultCode">
<input type="hidden" name="resResultMsg">
<input type="hidden" name="DanalParams"	value="<%=DanalParams%>">

<!-- EXIMBAY -->
<input type="hidden" name="EB_CARDNO" value="<%=EB_CARDNO%>">
<input type="hidden" name="EB_EXPIRYDT" value="<%=EB_EXPIRYDT%>">
<input type="hidden" name="EB_AUTHORIZEDID" value="<%=EB_AUTHORIZEDID%>">
<input type="hidden" name="EB_PARES" value="<%=EB_PARES%>">
<input type="hidden" name="EB_BASECUR" value="<%=EB_BASECUR%>">
<input type="hidden" name="EB_BASEAMT" value="<%=EB_BASEAMT%>">
<input type="hidden" name="EB_BASERATE" value="<%=EB_BASERATE%>">
<input type="hidden" name="EB_BFOREIGNCUR" value="<%=EB_BFOREIGNCUR%>">
<input type="hidden" name="EB_BFOREIGNAMT" value="<%=EB_BFOREIGNAMT%>">
<input type="hidden" name="EB_BFOREIGNRATE" value="<%=EB_BFOREIGNRATE%>">
<input type="hidden" name="EB_BDCCRATE" value="<%=EB_BDCCRATE%>">
<input type="hidden" name="EB_BDCCRATEID" value="<%=EB_BDCCRATEID%>">
<input type="hidden" name="EB_ECI" value="<%=EB_ECI%>">
<input type="hidden" name="EB_XID" value="<%=EB_XID%>">
<input type="hidden" name="EB_CAVV" value="<%=EB_CAVV%>">
<input type="hidden" name="EB_PARESSTATUS" value="<%=EB_PARESSTATUS%>">
<input type="hidden" name="EB_MD" value="<%=EB_MD%>">
<input type="hidden" name="EB_CVC" value="<%=EB_CVC%>">
    <div class="innopay">
        <div class="dim"></div>
        <section class="innopay_wrap">
            <header class="gnb">
                <h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="../images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
                <div class="kind">
                    <span>신용카드결제</span>
                </div>
                <div id="google_translate_element"></div>
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
                            <li class="faq_wrap">
								<a href="#" data=".faq" class="btn_bd_white faq_btn btn popup_btn">결제문제해결 / FAQ</a>
							</li>
                        </ul>
                    </div>
                </section>
                
                <section class="con_wrap">
                    <section class="payment_info">
                        <h2>결제요청 내역</h2>
                        <ul>
                            <li>
                                <div class="info_title">구매자명</div>
                                <div><%=BuyerName%></div>
                            </li>
                            <li>
                                <div class="info_title">결제방법</div>
                                <div>신용카드</div>
                            </li>
                            <li>
                                <div class="info_title">카드정보</div>
                                <div><%=CommonUtil.getDefaultStr(dispCardNo,"")%></div>
                            </li>
                            <li>
                                <div class="info_title">할부개월</div>
                                <div><%if(CardQuota.equals("00")) {%>
	                                   일시불
	                                 <%}else{ %>
	                                   <%=CardQuota%>개월
	                                 <%} %></div>
                            </li>
                            <li>
                                <div class="info_title">이메일</div>
                                <div><%=BuyerEmail%></div>
                            </li>
                        </ul>
                    </section>

                    <section class="confirm_notice">
                        <p>
                            결제요청 내역을 확인하시고<br>동의하면 하단의 <b>다음</b> 버튼을 클릭하시어<br>결제를 진행하여 주세요.
                        </p>    
                    </section>

                    

                    <section class="btn_wrap_multi">
                        <div>
                            <a class="btn_gray btn dim_btn" href="#" onclick="return goCancel()">취소</a>
                            <a class="btn_blue btn" href="#" onclick="return goConfirm()">다음</a>
                        </div>
                    </section>
                </section>

                <section class="footer">
                    <span>INNOPAY 1688 - 1250</span>
                </section>

            </section>
            
            <!-- Faq -->
			<%@ include file="/card/faq.jsp" %>
            
            <!-- Notice -->
			<%@ include file="/common/notice.jsp" %>
            
        </section>
    </div>
</form>

<%
if(resBox == null || resBox.isEmpty() || resBox.getString("issue_org") == null){
%>
	<script>
		alert('카드번호를 확인해주세요.');
		goCancel();
	</script>
<%
}
%>

<%-- iframe --%>
<iframe src="../common/blank.html" name="payFrame" style="display:none" frameborder="no" width="100%" height="100" scrolling="yes" align="center"></iframe>
