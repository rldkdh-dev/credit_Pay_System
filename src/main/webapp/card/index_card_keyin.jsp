<%
/*****************************************************************************
*
*   @ SYSTEM NAME       : 신용카드 수기결제 Index 페이지
*   @ PROGRAM NAME      : index_card_keyin.jsp
*   @ MAKER             : InnoPay PG
*   @ MAKE DATE         : 2019.01.17
*   @ PROGRAM CONTENTS  : 신용카드 수기결제 Index 페이지
*
******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="./common_card.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
System.out.println("**** Start ipay index_card_keyin.jsp ["+System.currentTimeMillis()+"] ****");

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

String pg_key_in_cl = "";
String limit_instmn = "";

Box pgInfoBox = new Box();
pgInfoBox = CardSms.selectPgInfo(MID, svcCd, svcPrdtCd);
System.out.println("====="+pgInfoBox.toString());
if(pgInfoBox!=null && !pgInfoBox.isEmpty() && pgInfoBox.getString("ResultCode", "").equals("0000")){
	pg_key_in_cl = pgInfoBox.getString("pg_key_in_cl", "");
	limit_instmn = pgInfoBox.getString("limit_instmn", "");
}else{
    //////// VAN 연동 추가
    Box box = new Box();
    box.put("mid", MID);
    
    Box merchantInfo = CommonBiz.getMemberInfo(box);
    if(merchantInfo==null || merchantInfo.isEmpty()){
        System.out.println("**********[존재하지 않는 MID 입니다]**********");
        throw new Exception("W003");
    }
    
    box.put("today_dt", TimeUtils.getyyyyMMdd());
    box.put("svc_prdt_cd", "01"); // KeyIn 거래이므로 01 고정
    List<Box> authList = CommonBiz.selectAuthTypeAndKeyInClByMid(box);
    if(authList==null || authList.size()<1){
        System.out.println("**********상점 신용카드 정보를 확인해 주세요.**********");
        throw new Exception("W010");
    }else{
        int size = authList.size();
        Box cardList = new Box();
        String auth_type = "";
        String key_in_cl = "";
        // cardcode = svc_prdt_cd:auth_type:key_in_cl 형태로 넣는다.
        for(int i=0; i<size;i++){
            cardList.put(authList.get(i).getString("fn_cd"),authList.get(i).getString("svc_prdt_cd")+":"+authList.get(i).getString("auth_type")+":"+authList.get(i).getString("key_in_cl"));
            auth_type = authList.get(i).getString("auth_type");
            key_in_cl = authList.get(i).getString("key_in_cl");
        }
        if(!"01".equals(key_in_cl) && !"11".equals(key_in_cl)){
            System.out.println("**********상점 신용카드 정보를 확인해 주세요.**********");
            throw new Exception("W010");
        }
        pg_key_in_cl = key_in_cl;
        limit_instmn = merchantInfo.getString("limit_instmn", "");
    }
    ////////
}

//2020.10.08 PG CODE 가져오기
Box pgMap = new Box();
SupportIssue si = new SupportIssue();
req.put("svc_cd", svcCd);
req.put("svc_prdt_cd", svcPrdtCd);
pgMap = si.getPgInfo(req);
String pgCd = pgMap.getString("pg_cd", "");

String currentYM = new SimpleDateFormat("yyyyMM").format(new Date());
actionUrl = "./payConfirm_card_keyin.jsp";
%>
<!DOCTYPE html>
<html>
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
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
        <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
        <!-- vKeyPad -->
		<script type="text/javascript" src="../js/vKeypad.min.js"></script>
		<script type="text/javascript" src="../js/kjscrypto.min.js"></script>
		<script type="text/javascript" src="../js/kjscrypto_contrib.min.js"></script>
		<script type="text/javascript">
			function googleTranslateElementInit() {
			  new google.translate.TranslateElement({pageLanguage: 'ko', includedLanguages: 'ar,de,en,es,fr,hi,ja,mn,ms,ru,th,tr,vi,zh-CN', layout: google.translate.TranslateElement.InlineLayout.SIMPLE, autoDisplay: false}, 'google_translate_element');
			}
		</script>

<script type="text/javascript">
//카드선택 결제요청 진행 function
function goNext() {
    if(!checkTerms()) return;
    if(!checkForm()) return;
 	// 결제버튼을 숨깁니다.
    disableItems(true);
 	
    vKeypadGlobal.prepareSubmitAll();
 	
 	tranMgr.cardno.value = tranMgr.card_num1.value + tranMgr.card_num2.value + tranMgr.card_num3.value + tranMgr.card_num4.value;
    tranMgr.CardExpire.value = tranMgr.ExpireYear.value + tranMgr.ExpireMonth.value;
    tranMgr.submit();    
} // end goNext
function goCancel() {
	try{
		if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
			window.open('', '_self', '');
		    window.close();
		}else if((window.parent!=null&&window.parent!=undefined)||('X'=='<%=FORWARD%>')){
			window.parent.postMessage('close','*');
		}else{
			window.location.href='<%=RefererURL%>';
		}
	}catch(e){}
}
function  callActivity(){

    try{
        if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
            window.open('', '_self', '');
			window.close();
		}
		if((window.parent!=null&&window.parent!=undefined) || 'X'=='<%=FORWARD%>'){
		    if(/Android/i.test(navigator.userAgent)) {    // 안드로이드
		        // 안드로이드
		        window.PayAppBridge.backpage();
			}			  			
			if(/iPhone|iPad|iPod/i.test(navigator.userAgent)) { // iOS 아이폰, 아이패드, 아이팟
				  window.webkit.messageHandlers.payResult.postMessage("close");		
		    }
			window.parent.postMessage('close','*');
	        return false;
	    }else{
	        window.location.href='<%=RefererURL%>';
	        return false;
	    }
	   }catch(e){ window.parent.postMessage('close','*');  }
}
//입력값 유효성 검사
function checkForm(){
	
	if($("#card_num1").val() == '' || $("#card_num1").val().length < 4){
		alert("신용카드번호를 입력해주세요");
		$("#card_num1").focus();
		return false;
	}
	if($("#card_num2").val() == '' || $("#card_num2").val().length < 4){
		alert("신용카드번호를 입력해주세요");
		$("#card_num2").focus();
		return false;
	}
	if($("#card_num3").val() == '' || $("#card_num3").val().length < 4){
		alert("신용카드번호를 입력해주세요");
		$("#card_num3").focus();
		return false;
	}
	if($("#card_num4").val() == '' || $("#card_num4").val().length < 2){
		alert("신용카드번호를 입력해주세요");
		$("#card_num4").focus();
		return false;
	}
	if($("#ExpireMonth").val() == '' || $("#ExpireMonth").val().length < 2){
		alert("유효기간(월)을 입력해주세요");
		$("#ExpireMonth").focus();
		return false;
	}
	if($("#ExpireYear").val() == '' || $("#ExpireYear").val().length < 2){
		alert("유효기간(년)을 입력해주세요");
		$("#ExpireYear").focus();
		return false;
	}
	
	
	<%-- var AuthFlg = '<%=AuthFlg%>'; --%>
	var PgKeyInCl = '<%=pg_key_in_cl%>';
	
	if (PgKeyInCl == "10" || PgKeyInCl == "11"){
		if($("#BuyerAuthNum").val() == '' || $("#BuyerAuthNum").val().length < 6){
			alert("개인카드인경우 생년월일 법인카드인경우 사업자번호를 입력해주세요.");
			$("#BuyerAuthNum").focus();
			return false;
		}
	}
	
	if (PgKeyInCl == "11"){
		if($("#CardPwd").val() == '' || $("#CardPwd").val().length < 2){
			alert("비밀번호를 입력해주세요");
			$("#CardPwd").focus();
			return false;
		}
	}
	
	return true;
}

$(document).ready(function(){
	
	setQuota(); //할부개월 셋팅
	setAuth(); //가맹점 인증 방식별 입력값 셋팅
	
	// 가상키패드 연동
	checkDevice(tranMgr);
	vKeypadGlobal.setDefaultServletURL('../servlets/vKeypad.do');
	vKeypadGlobal.newInstance(tranMgr, tranMgr.card_num1, null, 'NUMBERPAD_type1');
	vKeypadGlobal.newInstance(tranMgr, tranMgr.card_num2, null, 'NUMBERPAD_type1');
	vKeypadGlobal.newInstance(tranMgr, tranMgr.card_num3, null, 'NUMBERPAD_type1');
	vKeypadGlobal.newInstance(tranMgr, tranMgr.card_num4, null, 'NUMBERPAD_type1');
	vKeypadGlobal.newInstance(tranMgr, tranMgr.ExpireMonth, null, 'NUMBERPAD_type1');
	vKeypadGlobal.newInstance(tranMgr, tranMgr.ExpireYear, null, 'NUMBERPAD_type1');
	vKeypadGlobal.newInstance(tranMgr, tranMgr.BuyerAuthNum, null, 'NUMBERPAD_type1');
	vKeypadGlobal.newInstance(tranMgr, tranMgr.CardPwd, null, 'NUMBERPAD_type1');
	if(tranMgr.device.value=="mobile"){
        vKeypadGlobal.setOptionAll("isMobile", true);
    }
	vKeypadGlobal.setOptionAll("align", "center");
	vKeypadGlobal.setOptionAll("zIndex", 10);
	vKeypadGlobal.loadAll();

});
function checkDevice(frm){
    var UserAgent = navigator.userAgent;
    // 모바일/PC 구분
    if (UserAgent.match(/Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null 
        || UserAgent.match(/LG|SAMSUNG|Samsung/) != null){
    	frm.MerDeviceType.value="APP";
        frm.device.value = "mobile";
    }else if(UserAgent.match(/iPhone|iPod/i) != null){ 
    	frm.MerDeviceType.value="WEB";
    	frm.device.value = "mobile";
    	frm.UsePopupDlp.value="";
    }else{
    	frm.MerDeviceType.value="WEB";
        frm.device.value = "pc";
        frm.UsePopupDlp.value="false";
    }
    return;
}
//인증 방식 별 입력값 셋
function setAuth(){
	<%-- var AuthFlg = '<%=AuthFlg%>';
	if (AuthFlg == "01" || AuthFlg == "03"){
		$("#cardTypeSection").css("display","none");
		$("#cardAuthNoSection").css("display","none");
	}
	
	if (AuthFlg == "01" || AuthFlg == "02"){
		$("#cardPwSection").css("display","none");
	} --%>
	var PgKeyInCl = '<%=pg_key_in_cl%>';
	if (PgKeyInCl == "01"){
		$("#cardTypeSection").css("display","none");
		$("#cardAuthNoSection").css("display","none");
	}
	
	if (PgKeyInCl == "01" || PgKeyInCl == "10"){
		$("#cardPwSection").css("display","none");
	}
}

//할부개월 셋
function setQuota(){
	var LimitInstmn = '<%=limit_instmn%>';
	var Amt = '<%=Amt%>';
	
	try {
		LimitInstmn = parseInt(LimitInstmn);	
	} catch (e) {
		LimitInstmn = 0;
	}
	
	if (Amt > 500){
		for (var i=LimitInstmn; i >= 2; i--){
			if (i < 10){
				$("#CardQuota").prepend("<option value='0" + i + "'>" + i + "개월</option>");
			}else{
				$("#CardQuota").prepend("<option value='" + i + "'>" + i + "개월</option>");
			}
		}
		$("#CardQuota").prepend("<option value='00' selected='selected'>일시불</option>");
	}else{
		$("#CardQuota").prepend("<option value='00' selected='selected'>일시불</option>");
	}
}

//maxLength 체크
function maxLengthCheck(object){
	if (object.value.length > object.maxLength){
		object.value = object.value.slice(0, object.maxLength);
	}    
};

function focusNextItem(field, limit, next) {
	if (field.value.length == limit) {
		document.getElementById(next).focus();
	}
}

</script>
        <title>INNOPAY 전자결제서비스</title>
    </head>
    <body>
<!-- 결제인증요청 폼 -->    
<form name="tranMgr" id="tranMgr" method="post" action="<%=actionUrl%>">
<input type="hidden" name="PayMethod"       value="<%=PayMethod%>"/>
<input type="hidden" name="pointUseYN"      value="<%=pointUseYN%>"/>
<input type="hidden" name="formBankCd"      value=""/>
<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
<input type="hidden" name="GoodsName"       value="<%=GoodsName%>"/>
<input type="hidden" name="GoodsURL"        value="<%=GoodsURL%>"/>
<input type="hidden" name="Amt"             value="<%=Amt%>"/>
<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
<input type="hidden" name="CardInterest"    value="<%=CardInterest%>"/>
<input type="hidden" name="CardPoint"       value="0"/>
<input type="hidden" name="Moid"            value="<%=Moid%>"/>
<input type="hidden" name="MID"             value="<%=MID%>"/>
<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/>
<input type="hidden" name="ResultYN"        value="<%=ResultYN%>"/>
<input type="hidden" name="RetryURL"        value="<%=RetryURL%>"/>
<input type="hidden" name="mallUserID"      value="<%=mallUserID%>"/>
<input type="hidden" name="BuyerName"       value="<%=BuyerName%>"/>
<input type="hidden" name="BuyerTel"        value="<%=BuyerTel%>"/>

<input type="hidden" name="ParentEmail"     value="<%=ParentEmail%>"/>
<input type="hidden" name="BuyerAddr"       value="<%=BuyerAddr%>"/>
<input type="hidden" name="BuyerPostNo"     value="<%=BuyerPostNo%>"/>
<input type="hidden" name="UserIP"          value="<%=UserIP%>"/>
<input type="hidden" name="MallIP"          value="<%=MallIP%>"/>
<input type="hidden" name="BrowserType"     value="<%=BrowserType%>"/>
<input type="hidden" name="VbankExpDate"    value="<%=VbankExpDate%>"/>
<input type="hidden" name="TID"             value="<%=TID%>"/>
<input type="hidden" name="MallReserved"    value="<%=MallReserved%>"/>
<input type="hidden" name="MallResultFWD"   value="<%=MallResultFWD%>"/> 
<input type="hidden" name="EncodingType"   value="<%=EncodingType%>"/> 
<input type="hidden" name="OfferingPeriod"   value="<%=OfferingPeriod%>"/> 
<input type="hidden" name="device"      value="<%=device%>">
<input type="hidden" name="MerDeviceType"      value="">
<input type="hidden" name="svcCd"      value="<%=svcCd%>">
<input type="hidden" name="svcPrdtCd"      value="<%=svcPrdtCd%>">
<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
<input type="hidden" name="User_ID"         value="<%=User_ID%>">
<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
<input type="hidden" name="BuyerCode"      value="<%=BuyerCode%>">
<input type="hidden" name="FORWARD"        value="<%=FORWARD%>">
<input type="hidden" name="EncryptData"    value="<%=EncryptData%>"> <!-- 거래검증값 추가(2018.08 hans) -->
<input type="hidden" name="ediDate"        value="<%=ediDate%>">
<input type="hidden" name="BuyerEmail"     value="<%=BuyerEmail%>">
<input type="hidden" name="CardExpire"	   value="">
<input type="hidden" name="cardno"		   value="">
<input type="hidden" name="RefererURL"       value="<%=RefererURL%>">
<input type="hidden" name="UsePopupDlp" value="">

        <div class="innopay">

                <section class="innopay_wrap" id="in">

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
                            <li class="on">입력</li>
                            <li>확인</li>
                            <li>완료</li>
                        </ol>
                        <div class="product_info">
                            <ul>
                                <li class="company_name">
                                    <div class="info_title">상점</div>
                                    <div><%=co_nm %></div>
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
                    	<div class="con_scroll">
	                        <section class="terms">
	                            <h2>이용약관 동의</h2>
	                            <div class="checks all_check">
	                                <input type="checkbox" id="terms_all"/>
	                                <label for="terms_all">전체동의</label>
	                            </div>
	                            <ul>
	                            	<a class="terms_li_show">이용약관 목록보기</a>
	                                <li>
	                                    <span>전자금융거래 이용약관 (필수)</span>
	                                    
	                                    <div class="checks">
	                                        <input type="checkbox" id="terms1"/>
	                                        <label for="terms1">동의</label>
	                                    </div>
	                                    <a href="#" data=".terms1" id="popup_terms1" class="popup_terms" onclick="javascript:popupTerms(1);">상세보기</a>
	                                </li>
	                                <li>
	                                    <span>개인정보 수집 및 이용안내 (필수)</span>
	                                    <div class="checks">
	                                        <input type="checkbox" id="terms2"/>
	                                        <label for="terms2">동의</label>
	                                    </div>
	                                    <a href="#" data=".terms2" id="popup_terms2" class="popup_terms" onclick="javascript:popupTerms(2);">상세보기</a>
	                                </li>
	                                <li>
	                                    <span>개인정보 제 3자 제공약관 동의 (필수)</span>
	                                    <div class="checks">
	                                        <input type="checkbox" id="terms3"/>
	                                        <label for="terms3">동의</label> 
	                                    </div>
	                                    <a href="#" data=".terms3" id="popup_terms3" class="popup_terms" onclick="javascript:popupTerms(3);">상세보기</a>
	                                </li>
	                            </ul>
	                        </section>

	                        <section class="payment_input">
	                            <h2>결제정보 입력</h2>
	                            <a href="#" data=".c_event" class="btn_d_gray btn_s2 btn popup_btn">무이자 할부 안내</a>
	                            <div>
	                            	<div class="input_section">
 										<label for="card_num" class="input_title">신용카드번호</label>
										<div class="card_num">
											<input type="number" id="card_num1" name="card_num1" onkeyup="javascript:focusNextItem(this, 4, 'card_num2');" maxLength="4" autocomplete="cc-number" placeholder="1234" pattern="[0-9]*" oninput="maxLengthCheck(this)"/>
											-
											<input type="password" id="card_num2" name="card_num2" onkeyup="javascript:focusNextItem(this, 4, 'card_num3');" maxLength="4" class="security" placeholder="1234" pattern="[0-9]*" oninput="maxLengthCheck(this)"/>
											-
											<input type="password" id="card_num3" name="card_num3" onkeyup="javascript:focusNextItem(this, 4, 'card_num4');" maxLength="4" class="security" placeholder="1234" pattern="[0-9]*" oninput="maxLengthCheck(this)"/>
											-
											<input type="number" id="card_num4" name="card_num4" onkeyup="javascript:focusNextItem(this, 4, 'ExpireMonth');" maxLength="4" placeholder="1234" pattern="[0-9]*" oninput="maxLengthCheck(this)"/>
										</div>
									</div>
									<div class="input_section">
										<label for="card_period" class="input_title">카드유효기간</label>
										<div class="card_period">
											<input type="number" name="ExpireMonth" id="ExpireMonth" onkeyup="javascript:focusNextItem(this, 2, 'ExpireYear');" placeholder="MM" pattern="[0-9]*" inputmode="numeric"  maxLength="2" oninput="maxLengthCheck(this)"/>
											/
											<input type="number" name="ExpireYear" id="ExpireYear" placeholder="YY" pattern="[0-9]*" inputmode="numeric"  maxLength="2" oninput="maxLengthCheck(this)"/>
										</div>
									</div>
									<%if(pg_key_in_cl.equals("10") || pg_key_in_cl.equals("11")){ %>
										<div class="input_section">
											<label for="p_num" class="input_title">본인확인</label>
											<div class="input_type1 p_num">
												<input type="number" name="BuyerAuthNum" id="BuyerAuthNum" placeholder="" pattern="[0-9]*" inputmode="numeric"  maxLength="10" oninput="maxLengthCheck(this)"/>
											</div>
										</div>
										<p class="comment">* 개인카드 : 생년월일 6자리<br>* 법인카드 : 사업자번호 10자리</p>
									<%}else{ %>
										<input type="hidden" name="BuyerAuthNum" id="BuyerAuthNum">
									<%} %>
									<%if(pg_key_in_cl.equals("11")){ %>
										<div class="input_section">
											<label for="c_password" class="input_title">카드비밀번호</label>
											<div class="input_type1 c_password">
												<input type="password" class="security" id="CardPwd" name="CardPwd" placeholder="앞2자리" pattern="[0-9]*" inputmode="numeric"  maxLength="2" oninput="maxLengthCheck(this)"/>
											</div>
										</div>
									<%}else{ %>
										<input type="hidden" name="CardPwd" id="CardPwd">
									<%} %>
	                                <div class="input_section">
	                                    <label for="select2" class="input_title">할부개월</label>
	                                    <div class="select_type1 select2">
	                                        <select name="CardQuota" id="CardQuota">
	                                        </select>
	                                    </div>
	                                </div>
	                                <p class="comment">* 5만원이상 할부 가능</p>
	                            </div>
	                        </section>
	                    </div>
                        
                        <%
						if(FORWARD.equals("Y")||FORWARD.equals("X")){
						%>
	                        <section class="btn_wrap_multi">
	                            <div id="btn_wrap">
	                                <a class="btn_gray btn dim_btn" href="javascript:callActivity()">취소</a>
	                                <a class="btn_blue btn install_notice_btn" href="#">다음</a>
	                            </div>
	                        </section>
                        <%}else{ %>
	                        <section class="btn_wrap_multi sms">
	                            <div>
                                	<a class="btn_blue btn install_notice_btn" href="#">다음</a>
	                            </div>
	                        </section>
                        <%} %>
                    </section>

                    <section class="footer pc keyIn">
                        <p>INNOPAY 1688 - 1250</p>
                    </section>

                </section>
</form>			

				<!-- Notice -->
				
				<%@ include file="/common/notice.jsp" %>
			
                <!--popup1-->
                <section class="float_wrap terms1">
                    <div class="pop_dim"></div>
                    <div class="popup conditions_text" id="conditions_text1">
                        <h3 class="popup_title">전자금융거래 기본약관</h3>
                        <a href="#" class="btn_close pop_close"></a>
                        <div class="popup_cont">
                            <div class="popup_scroll">
                                <div class="popup_scroll_in">
<p>
전자금융거래 기본약관
<br><br>
제1조 (목적)
<br>
이 약관은 전자지급결제대행 서비스를 제공하는 주식회사 인피니소프트(이하 ‘회사’라 합니다)와 이용자 사이의 전자금융거래에 관한 기본적인 사항을 정함을 목적으로 한다.
</p>
<p>
제2조 (용어의 정의)
<br>
이 약관에서 정하는 용어의 정의는 다음과 같습니다.
<br>
1. ‘전자금융거래’라 함은 회사가 전자적 장치를 통하여 전자지급결제대행서비스 및 전자금융 중개서비스(이하 ‘전자금융거래 서비스’라고 합니다)를 제공하고, 이용자가 회사의 종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다.
<br>
2. ‘전자지급결제대행 서비스’라 함은 전자적 방법으로 재화의 구입 또는 용역의 이용에 있어서 지급결제정보를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 서비스를 말합니다.
<br>
3. ‘결제대금예치서비스’라 함은 이용자가 재화의 구입 또는 용역의 이용에 있어서 그 대가(이하 ‘결제대금’이라 한다)의 전부 또는 일부를 재화 또는 용역(이하 ‘재화 등’이라 합니다)을 공급받기 전에 미리 지급하는 경우, 회사가 이용자의 물품수령 또는 서비스 이용 확인 시점까지 결제대금을 예치하는 서비스를 말합니다.
<br>
4. ‘이용자’라 함은 이 약관에 동의하고 회사가 제공하는 전자금융거래 서비스를 이용하는 자를 말합니다.
<br>
5. ‘접근매체’라 함은 전자금융거래에 있어서 거래지시를 하거나 이용자 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는 수단 또는 정보로서 전자식 카드 및 이에 준하는 전자적 정보(신용카드번호를 포함한다), ‘전자서명법’상의 인증서, 금융기관 또는 전자금융업자에 등록된 이용자번호, 이용자의 생체정보, 이상의 수단이나 정보를 사용하는데 필요한 비밀번호 등 전자금융거래법 제2조 제10호에서 정하고 있는 것을 말합니다.
<br>
6. ‘거래지시’라 함은 이용자가 전자금융거래계약에 따라 금융기관 또는 전자금융업자에게 전자금융거래의 처리를 지시하는 것을 말합니다.
<br>
7. ‘오류’라 함은 이용자의 고의 또는 과실 없이 전자금융거래가 전자금융거래계약 또는 이용자의 거래지시에 따라 이행되지 아니한 경우를 말합니다.
</p>
<p>
제3조 (약관의 명시 및 변경)
<br>
1. 회사는 이용자가 전자금융거래 서비스를 이용하기 전에 이 약관을 게시하고 이용자가 이 약관의 중요한 내용을 확인할 수 있도록 합니다.
<br>
2. 회사는 이용자의 요청이 있는 경우 전자문서의 전송방식에 의하여 본 약관의 사본을 이용자에게 교부합니다.
<br>
3. 회사가 약관을 변경하는 때에는 그 시행일 1월 전에 변경되는 약관을 회사가 제공하는 전자금융거래 서비스 이용 초기화면 및 회사의 홈페이지에 게시함으로써 이용자에게 공지합니다.
</p>
<p>
제4조 (접근매체의 관리 등)
<br>
1. 회사는 전자금융거래 서비스 제공 시 접근매체를 선정하여 이용자의 신원, 권한 및 거래지시의 내용 등을 확인할 수 있습니다.
<br>
2. 이용자는 접근매체를 제3자에게 대여하거나 사용을 위임하거나 양도 또는 담보 목적으로 제공할 수 없습니다.
<br>
3. 이용자는 자신의 접근매체를 제3자에게 누설 또는 노출하거나 방치하여서는 안되며, 접근매체의 도용이나 위조 또는 변조를 방지하기 위하여 충분한 주의를 기울여야 합니다.
<br>
4. 회사는 이용자로부터 접근매체의 분실이나 도난 등의 통지를 받은 때에는 그 때부터 제3자가 그 접근매체를 사용함으로 인하여 이용자에게 발생한 손해를 배상할 책임이 있습니다.
</p>
<p>
제5조 (회사의 책임)
<br>
1. 회사는 접근매체의 위조나 변조로 발생한 사고로 인하여 이용자에게 발생한 손해에 대하여 배상책임이 있습니다. 다만 이용자가 권한 없는 제3자가 이용자의 접근매체를 이용하여 전자금융거래를 할 수 있음을 알았거나 알 수 있었음에도 불구하고 이용자가 자신의 접근매체를 누설 또는 노출하거나 방치한 경우 그 책임의 전부 또는 일부를 이용자가 부담하게 할 수 있습니다.
<br>
2. 회사는 계약체결 또는 거래지시의 전자적 전송이나 처리과정에서 발생한 사고로 인하여 이용자에게 손해가 발생한 경우에는 그 손해를 배상할 책임이 있습니다. 다만, 본 조 제1항 단서에 해당하거나 본 조 제2항에 해당하거나 법인(‘중소기업기본법’ 제2조 제2항에 의한 소기업을 제외한다)인 이용자에게 손해가 발생한 경우로서 회사가 사고를 방지하기 위하여 보안절차를 수립하고 이를 철저히 준수하는 등 합리적으로 요구되는 충분한 주의의무를 다한 경우 회사는 배상할 책임이 없습니다.
<br>
3. 회사는 이용자로부터의 거래지시가 있음에도 불구하고 천재지변, 회사의 귀책사유가 없는 정전, 화재, 통신장애 기타의 불가항력적인 사유로 처리 불가능하거나 지연된 경우로서 이용자에게 처리 불가능 또는 지연사유를 통지한 경우(금융기관 또는 결제수단 발행업체나 통신판매업자가 통지한 경우를 포함합니다)에는 이용자에 대하여 이로 인한 책임을 지지 아니합니다.
<br>
4. 회사는 전자금융거래를 위한 전자적 장치 또는 ‘정보통신망 이용촉진 및 정보보호 등에 관한 법률’ 제2조 제1항 제1호에 따른 정보통신망에 침입하여 거짓이나 그 밖의 부정한 방법으로 획득한 접근매체의 이용으로 발생한 사고로 인하여 이용자에게 그 손해가 발생한 경우에는 그 손해를 배상할 책임이 있습니다. 다만, 다음과 같은 경우 회사는 이용자에 대하여 책임을 지지 않습니다.
<br>
가. 회사가 접근매체에 따른 확인 외에 보안강화를 위하여 전자금융거래 시 요구하는 추가적인 보안조치를 이용자가 정당한 사유 없이 거부하여 사고가 발생한 경우
<br>
나. 이용자가 추가적인 보안조치에서 사용되는 매체, 수단 또는 정보에 대하여 누설, 누출 또는 방치한 행위 또는 제3자에게 대여하거나 그 사용을 위임한 행위 또는 양도나 담보의 목적으로 제공한 행위
</p>
<p>
제6조 (거래내용의 확인)
<br>
1. 회사는 이용자와 미리 약정한 전자적 방법을 통하여 이용자의 거래내용(이용자의 ‘오류정정 요구사실 및 처리결과에 관한 사항’을 포함합니다)을 확인할 수 있도록 하며, 이용자의 요청이 있는 경우에는 요청을 받은 날로부터 2주 이내에 모사전송 등의 방법으로 거래내용에 관한 서면을 교부합니다.
<br>
2. 회사가 이용자에게 제공하는 거래내용 중 거래계좌의 명칭 또는 번호, 거래의 종류 및 금액, 거래상대방을 나타내는 정보, 거래일자, 전자적 장치의 종류 및 전자적 장치를 식별할 수 있는 정보와 해당 전자금융거래와 관련한 전자적 장치의 접속기록은 5년간, 건당 거래금액이 1만원 이하인 소액 전자금융거래에 관한 기록, 전자지급수단 이용시 거래승인에 관한 기록, 이용자의 오류정정 요구사실 및 처리결과에 관한 사항은 1년간의 기간을 대상으로 하되, 회사가 전자금융거래 서비스 제공의 대가로 수취한 수수료에 관한 사항은 제공하는 거래내용에서 제외합니다.
<br>
3. 이용자가 제1항에서 정한 서면교부를 요청하고자 할 경우 다음의 주소 및 전화번호로 요청할 수 있습니다.
<br>
– 주소: 서울시 금천구 가산디지털2로 53, 307호 (가산동, 한리시그마밸리)
<br>
– 이메일 주소: cs@infinisoft.co.kr
<br>
– 전화번호: 1688-1250
</p>
<p>
제7조 (오류의 정정 등)
<br>
1. 이용자는 전자금융거래 서비스를 이용함에 있어 오류가 있음을 안 때에는 회사에 대하여 그 정정을 요구할 수 있습니다.
<br>
2. 회사는 전항의 규정에 따른 오류의 정정요구를 받은 때에는 이를 즉시 조사하여 처리한 후 정정요구를 받은 날부터 2주 이내에 그 결과를 이용자에게 알려 드립니다.
</p>
<p>
제8조 (전자금융거래 서비스 이용 기록의 생성 및 보존)
<br>
1. 회사는 이용자가 전자금융거래의 내용을 추적, 검색하거나 그 내용에 오류가 발생한 경우에 이를 확인하거나 정정할 수 있는 기록을 생성하여 보존합니다.
<br>
2. 전항의 규정에 따라 회사가 보존하여야 하는 기록의 종류 및 보존방법은 제6조 제2항에서 정한 바에 따릅니다.
</p>
<p>
제9조 (거래지시의 철회 제한)
<br>
1. 이용자는 전자지급거래에 관한 거래지시의 경우 지급의 효력이 발생하기 전까지 거래지시를 철회할 수 있습니다.
<br>
2. 전항의 지급의 효력이 발생 시점이란 (i) 전자자금이체의 경우에는 거래 지시된 금액의 정보에 대하여 수취인의 계좌가 개설되어 있는 금융기관의 계좌 원장에 입금기록이 끝난 때 (ii) 그 밖의 전자지급수단으로 지급하는 경우에는 거래 지시된 금액의 정보가 수취인의 계좌가 개설되어 있는 금융기관의 전자적 장치에 입력이 끝난 때를 말합니다.
<br>
3. 이용자는 지급의 효력이 발생한 경우에는 전자상거래 등에서의 소비자보호에 관한 법률 등 관련 법령상 청약의 철회의 방법 또는 본 약관 제5조에서 정한 바에 따라 결제대금을 반환 받을 수 있습니다.
</p>
<p>
제10조 (전자금융거래정보의 제공금지)
<br>
회사는 전자금융거래 서비스를 제공함에 있어서 취득한 이용자의 인적 사항, 이용자의 계좌, 접근매체 및 전자금융거래의 내용과 실적에 관한 정보 또는 자료를 이용자의 동의를 얻지 아니하고 제3자에게 제공, 누설하거나 업무상 목적 외에 사용하지 아니합니다.
</p>
<p>
제11조 (분쟁처리 및 분쟁조정)
<br>
1. 이용자는 다음의 분쟁처리 책임자 및 담당자에 대하여 전자금융거래 서비스 이용과 관련한 의견 및 불만의 제기, 손해배상의 청구 등의 분쟁처리를 요구할 수 있습니다.
<br>
– 전화번호: 1688-1250
<br>
– 전자우편주소: cs@infinisoft.co.kr
<br>
2. 이용자가 회사에 대하여 분쟁처리를 신청한 경우에는 회사는 15일 이내에 이에 대한 조사 또는 처리 결과를 이용자에게 안내합니다.
<br>
3. 이용자는 ‘금융감독기구의 설치 등에 관한 법률’ 제51조의 규정에 따른 금융감독원의 금융분쟁조정위원회나 ‘소비자보호법’ 제31조 제1항의 규정에 따른 소비자보호원에 회사의 전자금융거래 서비스의 이용과 관련한 분쟁조정을 신청할 수 있습니다.
</p>
<p>
제12조 (회사의 안정성 확보 의무)
<br>
회사는 전자금융거래의 안전성과 신뢰성을 확보할 수 있도록 전자금융거래의 종류별로 전자적 전송이나 처리를 위한 인력, 시설, 전자적 장치 등의 정보기술부문 및 전자금융업무에 관하여 금융감독위원회가 정하는 기준을 준수합니다.
</p>
<p>
제13조 (약관 외 준칙 및 관할)
<br>
1. 이 약관에서 정하지 아니한 사항에 대하여는 전자금융거래법, 전자상거래 등에서의 소비자 보호에 관한 법률, 통신판매에 관한 법률, 여신전문금융업법 등 소비자보호 관련 법령에서 정한 바에 따릅니다.
<br>
2. 회사와 이용자간에 발생한 분쟁에 관한 관할은 민사소송법에서 정한 바에 따릅니다.
</p>
<p>
부칙
<br>
1. 본 약관은 2017년 12월 11일부터 적용합니다.
</p>
                                </div>
                            </div>
                        </div>  
                        <div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>
                    </div>
                </section>  
                <!--//popup1-->
                <!--popup2-->
                <section class="float_wrap terms2">
                    <div class="pop_dim"></div>
                    <div class="popup conditions_text" id="conditions_text2">
                        <h3 class="popup_title">개인정보 수집 및 이용안내</h3>
                        <a href="#" class="btn_close pop_close"></a>
                        <div class="popup_cont">
                            <div class="popup_scroll">
                                <div class="popup_scroll_in">
<p>									
1.수집하는 개인정보의 항목
<br>
회사는 전자결제대행 및 결제대금예치 서비스, 현금영수증 서비스 그리고 휴대폰 본인확인서비스(이하 “서비스”라 칭함) 신청, 상담, 문의사항 등,
서비스의 제공을 위하여 아래와 같은 개인정보를 수집하고 있습니다.
<br><br>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
① 개인정보 수집항목
<br><br>
(1) 필수항목
<br>
가. 계약정보
<br>
대표자명, 대표자 휴대폰번호, 전화번호(회사번호는 해당 없음), 이메일주소, 담당자명, 담당자 휴대폰번호,
담당자 이메일주소, 전화번호(회사번호는 해당 없음)
<br>
나. 상기 명시된 개인정보 항목 이외의 “서비스” 이용과정이나 “서비스” 처리 과정에서 다음과 같은 추가 정보들이 자동 혹은 수동으로
생성되어 수집 될 수 있습니다.
접속 IP/MAC Address, 쿠키, e-mail, 서비스 접속 일시, 서비스 이용기록, 불량 혹은 비정상 이용기록, 결제기록
<br>
다. 기타
<br>
회사는 서비스 이용과 관련한 대금결제, 환불 등에 필요한 다음과 같은 정보 등을 추가로 수집할 수 있습니다.
계좌번호, 예금주명, 서비스계약일 등
<br>
(2) 선택항목
<br>
가. 필수항목 이외에 계약서류에 기재된 정보 또는 고객이 제공한 정보
<br>
나. 주소, 팩스번호 등
<br><br>
② 수집방법
<br><br>
홈페이지(판매자 회원가입,문의상담), 서면양식, 팩스, 이메일, 업무제휴 계약을 체결한 제휴사로부터 고객이 제시 하는 개인정보 수집
<br><br>
</p>
<p>
2.개인정보의 수집 이용목적
<br><br>
회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.
<br><br>
① 서비스 제공 계약의 성립, 유지, 종료를 위한 본인 식별 및 실명확인, 각종 회원관리, 계약서 발송 등
<br>
② 서비스 제공 과정 중 본인 식별, 인증, 실명확인 및 각종 안내/고지
<br>
③ 부정 이용방지 및 비인가 사용방지
<br>
④ 서비스 제공 및 관련 업무처리에 필요한 동의 또는 철회 등 의사확인
<br>
⑤ 이용 빈도 파악 및 인구통계학적 특성에 따른 서비스 제공 및 CRM
<br>
⑥ 서비스 제공을 위한 각 결제수단 별 상점 사업자 정보 등록
<br>
⑦ 기타 회사가 제공하는 이벤트 등 광고성 정보 전달, 통계학적 특성에 따른 서비스 제공 및 광고 게재, 실제 마케팅 활동
</p>
<br><br>
<p>
3.개인정보의 보유 및 이용기간
<br><br>
이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기 합니다.
단, 다음의 각 목에 해당하는 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존 합니다.
<br><br>
① 회사 내부 방침의 의한 정보보유
<br>
(1) 보존항목: 서비스 상담 수집 항목(회사명, 고객명, 전화번호, E-mail, 상담내용 등)
<br>
(2) 보존이유: 분쟁이 발생 할 경우 소명자료 활용
<br>
(3) 보존기간: 상담 완료 후 6개월
<br><br>
② 관련법령에 의한 정보보유
<br>
상법, 전자상거래 등에서의 소비자보호에 관한 법률, 전자금융거래법 등 관련법령의 규정에 의하여 보존할 필요가 있는 경우
회사는 관련법령에서 정한 일정한 기간 동안 정보를 보관합니다.
이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 다음 각 호와 같습니다.
<br>
(1) 계약 또는 청약철회 등에 관한 기록
<br>
가. 보존기간: 5년
<br>
나. 보존근거: 전자상거래 등에서의 소비자보호에 관한 법률
<br>
(2) 대금결제 및 재화 등의 공급에 관한 기록
<br>
가. 보존기간: 5년
<br>
나. 보존근거: 전자상거래 등에서의 소비자보호에 관한 법률
<br>
(3) 소비자의 불만 또는 분쟁처리에 관한 기록
<br>
가. 보존기간: 3년
<br>
나. 보존근거: 전자상거래 등에서의 소비자보호에 관한 법률
<br>
(4) 본인확인에 관한 기록
<br>
가. 보존기간: 6개월
<br>
나. 보존근거: 정보통신 이용촉진 및 정보보호 등에 관한 법률
<br>
(5) 방문에 관한 기록
<br>
가. 보존기간: 3개월
<br>
나. 보존근거: 통신비밀보호법
</p>                                    
                                </div>
                            </div>
                        </div>  
                        <div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>
                    </div>
                </section>  
                <!--//popup2-->
                <!--popup3-->
                <section class="float_wrap terms3">
                    <div class="pop_dim"></div>
                    <div class="popup conditions_text" id="conditions_text3">
                        <h3 class="popup_title">개인정보 제 3자 제공약관 동의</h3>
                        <a href="#" class="btn_close pop_close"></a>
                        <div class="popup_cont">
                            <div class="popup_scroll">
                                <div class="popup_scroll_in">
                                    <p>
“주식회사 인피니소프트”(이하 “회사”)는 이용자의 개인정보를 중요시하며, "정보통신망 이용촉진 및 정보보호에 관한 법률" 및 “개인정보보호법”과 “전자상거래 등에서의 소비자 보호에 관한 법률”을 준수하고 있습니다. 회사는 전자지급결제대행 및 결제대금예치서비스(이하 “서비스”) 이용자로부터 아래와 같이 개인정보를 제3자에게 제공 합니다.
</p>
<p>
1. 개인정보 제공<br>
회사는 이용자의 개인정보를 [개인정보의 수집 및 이용목적]에서 고지한 범위 내에서 사용하며, 이용자의 사전 동의 없이 동 범위를 초과하여 이용하거나 원칙적으로 이용자의 개인정보를 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.<br><br>
- 이용자들이 사전에 동의한 경우(이용자가 사전에 동의한 경우란, 서비스 이용 등을 위하여 이용자가 자발적으로 자신의 개인정보를 제3자에게 제공하는 것에 동의하는 것을 의미합니다), 이러한 경우에도, 회사는 이용자에게 (1) 개인정보를 제공받는 자, (2) 그의 이용목적, (3) 제공되는 개인정보의 항목, (4) 개인정보의 보유 및 이용기간을 사전에 고지하고 이에 대해 명시적/개별적으로 동의를 얻습니다. 이와 같은 모든 과정에 있어서 회사는 이용자의 의사에 반하여 추가적인 정보를 수집하거나, 동의의 범위를 벗어난 정보를 제3자와 공유하지 않습니다.<br>
- 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우<br>
- 개인 맞춤형 광고 서비스를 제공하기 위해 특정 개인을 식별할 수 없는 형태로 제휴사에 제공하는 경우<br><br>
회사의 서비스 이행을 위하여 개인정보를 제3자에게 제공하고 있는 경우는 다음과 같습니다.<br><br>
1) 이용 목적: 신용카드 결제<br>
- 제공 받는자<br>
가. 신용카드사: 국민/비씨/롯데/삼성/NH농협/현대/신한/하나/우리<br>
나. 은행: 신한/SC제일/씨티/하나/농협/기업/국민/저축/수협/신협/우체국/새마을금고/대구/부산/경남/광주/전북/조흥/제주<br>
다. 기타: (주)케이에스넷/블루월넛(주)<br>
- 개인정보 항목: 결제정보<br>
- 보유 및 이용기간: 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다(단, 다른 법령에 특별한 규정이 있을 경우 관련 법령에 따라 보관).<br><br>
2) 이용 목적: 계좌이체 결제<br>
- 제공 받는자<br>
가. 은행: 경남/광주/국민/기업/농협/대구/부산/산업/새마을금고/수협/신한/신협/외환/우리/우체국/전북/제주/하나/씨티/SC제일은행<br>
나. 증권: 동양/미래에셋/삼성/신한/한투/한화<br>
다. 기타: 금융결제원<br>
- 개인정보 항목: 결제정보<br>
- 보유 및 이용기간: 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다(단, 다른 법령에 특별한 규정이 있을 경우 관련 법령에 따라 보관)<br><br>
3) 이용 목적: 가상계좌 결제<br>
- 제공 받는자<br>
가. 은행: 국민/농협/우리/신한/하나/기업/우체국/외환/부산/대구<br>
나. 기타: 케이아이비넷(주)<br>	
- 개인정보 항목: 결제정보<br>
- 보유 및 이용기간: 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다(단, 다른 법령에 특별한 규정이 있을 경우 관련 법령에 따라 보관)<br><br>
4) 이용 목적: 현금영수증 발행<br>
- 제공 받는자: 국세청/(주)케이에스넷<br>
- 개인정보 항목: 결제정보<br>
- 보유 및 이용기간: 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다(단, 다른 법령에 특별한 규정이 있을 경우 관련 법령에 따라 보관)<br><br>
5) 이용 목적: 본인확인 인증<br>
- 제공 받는자: 코리아크레딧뷰로(주)/(주)다날<br>
- 개인정보 항목: 결제정보<br>
- 보유 및 이용기간: 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다(단, 다른 법령에 특별한 규정이 있을 경우 관련 법령에 따라 보관)<br><br>
</p>
<p>
2. 이용자의 개인정보 제3자 제공에 대한 거부<br>
이용자는 회사의 개인정보의 제3자 제공에 대한 동의를 거부할 수 있습니다. 단, 동의를 거부 하는 경우 서비스 결제가 정상적으로 완료 될 수 없음을 알려 드립니다.<br>
※ 개인정보의 처리와 관련된 사항은 회사의 개인정보처리방침에 따릅니다.
</p>
                                    
                                </div>
                            </div>
                        </div>  
                        <div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>
                    </div>
                </section>
                
                <!-- Faq -->
				<%@ include file="/card/faq.jsp" %>
				
				<!--무이자 안내-->
                <section class="float_wrap c_event">
                    <div class="pop_dim"></div>
                    <div class="popup conditions_text" id="conditions_text3">
                        <h3 class="popup_title">신용카드 무이자 할부 안내</h3>
                        <a href="#" class="btn_close pop_close"></a>
                        <div class="popup_cont">
                            <div class="popup_scroll">
                                <div class="popup_scroll_in">
                                    <iframe src="https://pg.innopay.co.kr/ipay/card/event.jsp?pg_cd=<%=pgCd %>&join_type=1" width="440px" height="1550px" frameborder="0" scrolling="no" style="opacity: 1; visibility: visible;"><br /></iframe>                           
                                </div>
                            </div>
                        </div>  
                        <div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>
                    </div>
                </section>
                
                <!--// ISP안내 popup-->
                <section class="float_wrap install_notice">
                    <div class="dim_blue"></div>
                    <div class="popup_cont">
                        <img src="../images/i_info.png" alt="알림" width="60px" height="auto">
                        <p>해당 카드는 ISP인증 결제 카드 입니다.<br>카드 ISP인증 후 결제 바랍니다.</p>
                    </div>
                </section>
                <!--//iSP안내 popup-->
                <!--// 안심클릭안내 popup-->
                <section class="float_wrap install_mpi_notice">
                    <div class="dim_blue"></div>
                    <div class="popup_cont">
                        <img src="../images/i_info.png" alt="알림" width="60px" height="auto">
                        <p>해당 카드는 안심클릭인증 결제 카드 입니다.<br>카드사 안심클릭인증 후 결제 바랍니다.</p>
                    </div>
                </section>
                <!--// 안심클릭안내 popup-->
                
                <!--// 다날안내 popup-->
                <section class="float_wrap install_danal_notice">
                    <div class="dim_blue"></div>
                    <div class="popup_cont">
                        <img src="../images/i_info.png" alt="알림" width="60px" height="auto">
                        <p>카드사 인증 후 결제 바랍니다.</p>
                    </div>
                </section>
                <!--// 다날안내 popup-->
                
				<section class="float_wrap card_frame">
					<div class="pop_dim"></div>
					<div class="popup card_etc">
						<h3 class="popup_title">카드사 선택</h3>
						<a href="#" class="btn_close pop_close"></a>
						<div class="popup_cont">
							<div class="popup_scroll">
								<div class="card_list2">
									<%=CardMinorList2%>
								</div>
							</div>
						</div>
						<div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>
					</div>
				</section>

            </section>
        </div>
    </body>

</html>