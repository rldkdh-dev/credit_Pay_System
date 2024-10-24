<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 정보입력페이지(가상계좌)
*	@ PROGRAM NAME		: mainVBank.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2018.01.02
*	@ PROGRAM CONTENTS	: 정보입력페이지(가상계좌)
*
************************** 변 경 이 력 *****************************************
*	번호	작업자		작업일				변경내용
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="service.SupportIssue" %>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%@ page import="kr.co.seeroo.spclib.SPCLib, org.json.simple.JSONObject"%>
<%@ page import="kr.co.infinisoft.pg.common.*" %>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%-- 공통 common include --%>
<%@ include file="../common/commonParameter.jsp" %>
<%
System.out.println("**** Start mainVBank.jsp["+System.currentTimeMillis()+"] ****");
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
%>
<%
    String co_no = "";  // 사업자번호
    String co_nm = "";  // 가맹점명
	
	if(VbankExpDate!=null){
		if(VbankExpDate.indexOf("-") > 0){
			VbankExpDate = VbankExpDate.replaceAll("-","");	
		}
		if(VbankExpDate.indexOf(".") > 0){
            VbankExpDate = VbankExpDate.replaceAll(".",""); 
        }
	}

	String RID = CommonUtil.getDefaultStr(request.getParameter("RID"), "");
		
	// genTID(String mid,String svcCd,String svcPrdtCd)
	String TID = KeyUtils.genTID(MID, CommonConstants.SVC_CD_VBANK, "01");
	
	TaxAmt = CommonUtil.getDefaultStr(request.getParameter("Amt"), "0");
	Amt = String.valueOf(Long.parseLong(TaxAmt)+Long.parseLong(DutyFreeAmt));
	
	// 주문번호 특수문자 체크
	if(CommonUtil.isSpecialChar(Moid)) {
		System.out.println("**********[주문번호가 유효하지 않습니다]**********");
		throw new Exception("W001");
	}
	
	// 상점정보(resMemberInfo) 존재 유무 확인
    Box req = new Box();
    Box resMemberInfo = null;

    req.put("svc_cd",svcCd);
    req.put("svc_prdt_cd",svcPrdtCd);
    req.put("mid", MID);
    req.put("today_dt", TimeUtils.getyyyyMMdd());
    req.put("amt", Amt);

    resMemberInfo = CommonBiz.getMemberInfo(req);
    
	if(resMemberInfo == null) {
		System.out.println("**********[상점정보가 없습니다]**********");
		throw new Exception("W006"); // 상점정보가 없습니다.
	}
	
    int vacctLimit = (int)resMemberInfo.getInt("vacct_limit");
    co_no       = resMemberInfo.getString("co_no");             // 사업자 번호(가맹점)
    co_nm       = resMemberInfo.getString("co_nm");             // 상호(가맹점)
	
	// 상품가격 500원 이하 오류 처리
	if(Integer.parseInt(Amt.equals("")?"0":Amt) <=500){
		throw new Exception("W031"); // 500원 이하 결제불가
	}
	
	String strVbankExpDate = "";
	
	//// 입금예정일 상점 기한 체크
	// 2018.01 필수값으로 설정안함
	String strExpDate = null;
	GregorianCalendar ExpCalendar = null;
	int year = 0;
    int month = 0;
    int day = 0;
	if(StringUtils.isEmpty(VbankExpDate)){
		//throw new Exception("W032"); // 필수 체크
		strExpDate = TimeUtils.getyyyyMMdd();
		year = Integer.parseInt(strExpDate.substring(0,4));
	    month = Integer.parseInt(strExpDate.substring(4,6));
	    day = Integer.parseInt(strExpDate.substring(6,8));
	    ExpCalendar = new GregorianCalendar(year,month-1,day);
	    ExpCalendar.add(Calendar.DAY_OF_MONTH, vacctLimit);
	}else{
		try{
			System.out.println("======== input VankExpDate ["+VbankExpDate+"]");
			if(VbankExpDate.length() >=8){
				VbankExpDate = VbankExpDate.substring(0,8);
				year = Integer.parseInt(VbankExpDate.substring(0,4));
		        month = Integer.parseInt(VbankExpDate.substring(4,6));
		        day = Integer.parseInt(VbankExpDate.substring(6,8));
		        ExpCalendar = new GregorianCalendar(year,month-1,day);
			}else if(VbankExpDate.length()<8){
				throw new Exception("W034");
			}
		}catch(Exception e){
			strExpDate = TimeUtils.getyyyyMMdd();
	        year = Integer.parseInt(strExpDate.substring(0,4));
	        month = Integer.parseInt(strExpDate.substring(4,6));
	        day = Integer.parseInt(strExpDate.substring(6,8));
	        ExpCalendar = new GregorianCalendar(year,month-1,day);
	        ExpCalendar.add(Calendar.DAY_OF_MONTH, vacctLimit);
			System.out.println("======== input VankExpDate Exception "+e.getMessage());
		}
	} // end if(StringUtils.isEmpty(VbankExpDate))
		
    java.util.Date expDate = ExpCalendar.getTime();
    Calendar nowCalendar = Calendar.getInstance();
    nowCalendar.add(Calendar.DAY_OF_MONTH, vacctLimit);
    java.util.Date limitDate = nowCalendar.getTime();
    System.out.println("======== expDate ["+expDate+"]");
    System.out.println("======== limitDate ["+limitDate+"]");
    
    if(expDate.after(limitDate)){
        throw new Exception("W033");
    }
	
    SimpleDateFormat sdfyyyyMMdd = new SimpleDateFormat("yyyyMMdd");
    VbankExpDate = sdfyyyyMMdd.format(expDate);
    // 입금기한일 정보를 가져온다.          
    strVbankExpDate = VbankExpDate.substring(0,4) + ". " + VbankExpDate.substring(4,6) + ". " + VbankExpDate.substring(6,8) ;
    ////입금예정일 상점 기한 체크 끝

	// 은행리스트 가져오기
	// 2019.04 가맹점에 연결된 FN_CD 기준으로 은행리스트를 가져오도록 변경
	req = new Box();
	req.put("code_cl", "0001");
	req.put("mid", MID);
	
	List<Box> listVbankInfo = CommonBiz.getVbankInfo(req);
	String strYYYYMMdd = TimeUtils.getyyyyMMdd();
	req.put("day", strYYYYMMdd);
	
	// tb_day
	// (0 : 평일-영업일, 1 : 토요일, 2 : 공휴일)
	// 추후 확인 현재는 (1 : 평일-영업일, 2 : 토요일, 3 : 공휴일)
	String off_cl = "";
	Box dayBox = CommonBiz.getDay(req);
	if(dayBox != null){
		off_cl = dayBox.getString("off_cl");
	}
	
	// 현금영수증 발행 여부 확인
	String rcpt_flag = "";
	Box pgMap = new Box();
	SupportIssue si = new SupportIssue();
	req.put("mid", MID);
	req.put("svc_cd", "04");
	req.put("svc_prdt_cd", "01");
	pgMap = si.getPgInfo(req);
	if(pgMap != null){
		rcpt_flag = "Y";
	}
	
	// 농협 수수료 확인
	Box nhFeeMap = new Box();
	req.put("mid", MID);
	req.put("svc_cd", "03");
	req.put("bank_cd", "011");
	nhFeeMap = si.getVbankFeeInfo(req);
	Double nhVbankFee = 0.00;
	if(nhFeeMap != null) nhVbankFee = Double.parseDouble(nhFeeMap.getString("fee"));
	
	// 현금영수증 발행 필수 여부 확인
	String cash_receipt_yn = resMemberInfo.getString("cash_receipt_yn");
	
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
        <link rel="stylesheet" type="text/css" href="../css/jquery.mCustomScrollbar.css" />
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
        <link rel="stylesheet" type="text/css" href="../css/common.css" />
        <link href='../css/font.css' rel='stylesheet' type='text/css'>
<script type="text/javascript">
$(document).ready(function() { 
     //페이지가 호출되었을때 우리은행 selected 
	 $(".bank_list").children().eq(1).trigger('click');
});
<!--
var submitCnt = 0;

function OnCashReceiptType(val){

	switch(parseInt(val)){
	    case 1:case 4:case 7:{    // 소득공제용
	    	$("#rcptType").css('display','table');
	    	$("#receiptType").val('1');
	    	$("#bizNum").css('display','none');
	    	$("#rcptTel").css('display','table');
	    	$("#rcptJumin").css('display','none');
	    	$("#cardNum").css('display','none');
	        break;
	    }
	    case 2:case 5:case 8:{  // 지출증빙용
	    	$("#rcptType").css('display','none');
	        $("#bizNum").css('display','table');
	        $("#rcptTel").css('display','none');
	        $("#rcptJumin").css('display','none');
	        $("#cardNum").css('display','none');
	        break;
	    }
	    case 3:case 6:case 9:{
	    	$("#rcptType").css('display','none');
	        $("#bizNum").css('display','none');
	        $("#rcptTel").css('display','none');
	        $("#rcptJumin").css('display','none');
	        $("#cardNum").css('display','none');
	        break;
	    }       
    }   
}
function OnReceiptType(val){

	switch(parseInt(val)){
	    case 1:{    // 휴대폰
	        $("#bizNum").css('display','none');
	        $("#rcptTel").css('display','inline-table');
	        $("#rcptJumin").css('display','none');
	        $("#cardNum").css('display','none');
	        break;
	    }
	    case 2:{  // 주민번호
	        $("#bizNum").css('display','none');
	        $("#rcptTel").css('display','none');
	        $("#rcptJumin").css('display','inline-table');
	        $("#cardNum").css('display','none');
	        break;
	    }
	    case 3:{   // 신용카드번호
	        $("#bizNum").css('display','none');
	        $("#rcptTel").css('display','none');
	        $("#rcptJumin").css('display','none');
	        $("#cardNum").css('display','inline-table');
	        break;
	    }       
	}   
}

<%-- 확인페이지 --%>
function goNext() {
	if(!checkTerms()) return;
	var formNm = document.tranMgr;
	var receiptTypeNo = '';
	<%-- 은행선택 체크 --%>
	if(formNm.BankCode.value == "") {
		alert("은행을 선택하세요.");
		return false;
	}
	
	<%-- 입금자 성명 체크 --%>
	if(formNm.VBankAccountName.value == "") {
		alert("입금자 성명을 입력하세요.");
		return false;
	}
	
	<%-- 현금영수증 발급 체크 --%>
	//if($("#cashReceiptType").val() == "") {
	if($('input:radio[name="cashReceiptType"]:checked').val() == "") {
		alert("현금영수증 발급여부를 선택하세요.");
		return false;
	}
	else {
		
		<%if("Y".equals(cash_receipt_yn)){%>
		if($('input:radio[name="cashReceiptType"]:checked').val() == "3") {
			alert("현금영수증 발행은 필수입니다.\n소득공제용 또는 지출증빙용을 선택하세요");
			return false;
		}
		<%}%>
		
		if($('input:radio[name="cashReceiptType"]:checked').val() == "1"
			|| $('input:radio[name="cashReceiptType"]:checked').val() == "4"
			|| $('input:radio[name="cashReceiptType"]:checked').val() == "7" ) {

			if($('input:radio[name="receiptType"]:checked').val() == "1"){  // 휴대폰
				receiptTypeNo = formNm.rcptTel1.value + formNm.rcptTel2.value + formNm.rcptTel3.value;
				if(formNm.rcptTel1.value == ""||formNm.rcptTel2.value == ""||formNm.rcptTel3.value == "" ){
					alert("핸드폰 번호를 입력하세요.");
					formNm.rcptTel1.focus();
					return false;
				}else if(!cellNumCheck(formNm.rcptTel1.value) || receiptTypeNo.length > 12 || receiptTypeNo.length < 10){
					alert("핸드폰 번호를 정확히 입력하세요.");
					formNm.rcptTel1.focus();
					return false;
				}
			}else if($('input:radio[name="receiptType"]:checked').val() == "2"){    // 주민번호
				receiptTypeNo = formNm.rcptJuminNo1.value + formNm.rcptJuminNo2.value;
			    if(formNm.rcptJuminNo1.value == ""||formNm.rcptJuminNo2.value == ""){
			    	alert("주민번호를 입력하세요.");
			    	formNm.rcptJuminNo1.focus();
                    return false;
			    }else if(!isJuminNo(formNm.rcptJuminNo1.value , formNm.rcptJuminNo2.value) || receiptTypeNo.length < 13 || receiptTypeNo.length > 13){
                    alert("주민번호가 유효하지 않습니다.");
                    formNm.rcptJuminNo1.focus();
                    return false;
                }
			}else if($('input:radio[name="receiptType"]:checked').val() == "3"){    // 신용카드 번호
				receiptTypeNo = formNm.rcptCardNo1.value + formNm.rcptCardNo2.value + formNm.rcptCardNo3.value + formNm.rcptCardNo4.value;
                if(formNm.rcptCardNo1.value == ""||formNm.rcptCardNo2.value == ""||formNm.rcptCardNo3.value == ""||formNm.rcptCardNo4.value == ""){
                    alert("신용카드 번호를 입력하세요.");
                    formNm.rcptCardNo1.focus();
                    return false;
                }else if(receiptTypeNo.length > 17 || receiptTypeNo.length < 14){
                    alert("신용카드 번호를 정확히 입력하세요.");
                    formNm.rcptCardNo1.focus();
                    return false;
                }
			}
		}
		else if($('input:radio[name="cashReceiptType"]:checked').val() == "2"
			|| $('input:radio[name="cashReceiptType"]:checked').val() == "5"
			|| $('input:radio[name="cashReceiptType"]:checked').val() == "8" ) {
			receiptTypeNo = formNm.rcptCorpNo1.value + formNm.rcptCorpNo2.value + formNm.rcptCorpNo3.value;
			if(formNm.rcptCorpNo1.value == ""||formNm.rcptCorpNo2.value == ""||formNm.rcptCorpNo3.value == "" ){
                alert("사업자 번호를 입력하세요.");
                formNm.rcptCorpNo1.focus();
                return false;
            }else if(!isBusiNoByValue(receiptTypeNo) || receiptTypeNo.length < 10 || receiptTypeNo.length > 10){
                alert("사업자번호가 올바르지 않습니다.");
                formNm.rcptCorpNo1.focus();
                return false;
            }
		}
		formNm.receiptTypeNo.value = receiptTypeNo;
	}
	
	if(submitCnt > 0) {
		return false;
	}
	
	submitCnt++;
	formNm.action = "payConfirm.jsp";
	formNm.submit();
	//return true;
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
			window.location.href='<%=RefererURL%>';
		}
	}catch(e){}
}
function  callActivity(){
	var nav=navigator.userAgent;
			   try{
				   if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
						window.open('', '_self', '');
					    window.close();
					}
				   if((parent!=undefined && parent!=null) || 'X'=='<%=FORWARD%>'){
					   window.parent.postMessage('close','*');
				   
					   if(/Android/i.test(navigator.userAgent)) {    // 안드로이드
						   // 안드로이드
				        	  window.PayAppBridge.backpage();
					   }			  			
					  if(/iPhone|iPad|iPod/i.test(navigator.userAgent)) { // iOS 아이폰, 아이패드, 아이팟
						  window.webkit.messageHandlers.payResult.postMessage("close");		
				        }
			            return false;    
			        }
				   else{
			            history.back(-1);
			            return false;
			        }
			   }  
			    catch(e){ window.parent.postMessage('close','*');  }
			
			   }	
//maxLength 체크
function maxLengthCheck(object){
	if(object.value.length > object.maxLength){
		  object.value = object.value.slice(0, object.maxLength);
	}    
};
// 약관동의 체크
function checkTerms(){
    if(!$("#terms1").is(":checked")||!$("#terms2").is(":checked")||!$("#terms3").is(":checked")/* ||!$("#terms4").is(":checked") */){
        alert("이용약관에 동의해 주세요.");
        return false;
    }
    return true;
};

function goCheckBank(bankCode, bankName, dis_tm, etc) {
	
    var formNm = document.tranMgr;
    formNm.BankCode.value = bankCode;
    
    if (etc == "etc") {
    	//document.getElementById('etcBank1').setAttribute('value', bankCode);
    	document.getElementById("etcBank1").setAttribute('onclick', 'javascript:goCheckBank(\'' + bankCode + '\', \'' + bankName + '\', \'' + dis_tm + '\', \'\');');
    	document.getElementById("etcBank1").innerHTML = '<div><p class="bank' + bankCode + '">' + bankName + '</p></div>';
    	document.getElementById("etcBank1").innerHTML += '<p class="w_time">' + dis_tm + '</p>';
    	document.getElementById('etcBank2').setAttribute('onclick', 'javascript:bankFrameOn();');
    	document.getElementById("etcBank2").innerHTML = '<p class="bank_more">기타은행</p>';

	    $(".float_wrap").css("display","none");
	    $('body').css("overflow","auto");
	    $('.payment_input .bank_list a').removeClass('on');
	    $('#etcBank1').addClass('on');
    } else {
    	$('.bank_list2 a').removeClass('on');
    }
    
    return true;
}


function bankFrameOn() {
	$(".bank_frame").css('display','block');
	$(".bank_frame").find('.pop_dim').css('opacity','0');
	$(".bank_frame").find('.pop_dim').animate({opacity: '0.7'}, 500);
	$(".bank_etc").center();
	scroll_disable();
 }
-->
</script>
<title>INNOPAY 전자결제서비스</title>
</head>
<body>

<form name="tranMgr" method="post" action="">
<input type="hidden" name="PayMethod"	   value="<%=PayMethod%>">
<input type="hidden" name="GoodsCnt"	   value="<%=GoodsCnt%>">
<input type="hidden" name="GoodsName"	   value="<%=GoodsName%>">
<input type="hidden" name="GoodsURL"	   value="<%=GoodsURL%>">
<input type="hidden" name="Amt"			   value="<%=Amt%>">
<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
<input type="hidden" name="Moid"		   value="<%=Moid%>">
<input type="hidden" name="MID"			   value="<%=MID%>">
<input type="hidden" name="ReturnURL"	   value="<%=ReturnURL%>">
<input type="hidden" name="RetryURL"	   value="<%=RetryURL%>">
<input type="hidden" name="mallUserID"	   value="<%=mallUserID%>">
<input type="hidden" name="BuyerName"	   value="<%=BuyerName%>">
<input type="hidden" name="BuyerAuthNum"   value="<%=BuyerAuthNum%>">
<input type="hidden" name="BuyerTel"	   value="<%=BuyerTel%>">
<input type="hidden" name="BuyerAddr"	   value="<%=BuyerAddr%>">
<input type="hidden" name="BuyerPostNo"	   value="<%=BuyerPostNo%>">
<input type="hidden" name="UserIP"		   value="<%=UserIP%>">
<input type="hidden" name="MallIP"		   value="<%=MallIP%>">
<input type="hidden" name="BrowserType"	   value="<%=BrowserType%>">
<input type="hidden" name="TID"			   value="<%=TID%>">
<input type="hidden" name="VbankExpDate"   value="<%=VbankExpDate%>">
<input type="hidden" name="MallReserved"   value="<%=MallReserved%>">
<input type="hidden" name="RID"            value="<%=RID%>"> 
<input type="hidden" name="MallResultFWD"  value="<%=MallResultFWD%>">
<input type="hidden" name="TransType"	   value="<%=TransType%>">
<input type="hidden" name="SUB_ID"	       value="<%=SUB_ID%>">
<input type="hidden" name="EncodingType"   value="<%=EncodingType%>">
<input type="hidden" name="OfferingPeriod" value="<%=OfferingPeriod%>"/> 
<input type="hidden" name="device"         value="<%=device%>">
<input type="hidden" name="svcCd"      	   value="<%=svcCd%>">
<input type="hidden" name="svcPrdtCd"      value="<%=svcPrdtCd%>">
<input type="hidden" name="OrderCode"      value="<%=OrderCode%>">
<input type="hidden" name="User_ID"        value="<%=User_ID%>">
<input type="hidden" name="Pg_Mid"         value="<%=Pg_Mid%>">
<input type="hidden" name="BuyerCode"      value="<%=BuyerCode%>">
<input type="hidden" name="FORWARD"        value="<%=FORWARD%>">
<input type="hidden" name="receiptTypeNo"  value=""/>
<input type="hidden" name="ResultYN"       value="<%=ResultYN%>">
<input type="hidden" name="EncryptData"    value="<%=EncryptData%>"> <!-- 거래검증값 추가(2018.08 hans) -->
<input type="hidden" name="ediDate"        value="<%=ediDate%>">
<input type="hidden" name="BankCode"       value="">
<input type="hidden" name="RefererURL"     value="<%=RefererURL%>">
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
                            <li class="on">입력</li>
                            <li>확인</li>
                            <li>완료</li>
                        </ol>
                        <div class="product_info">
                            <ul>
                                <li class="company_name">
                                    <div class="info_title">상점명</div>
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
                                <li class="term">
                                    <div class="info_title">입금기한</div>
                                    <div><%=strVbankExpDate %></div>
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
                                <!-- 20190327 대표님 지시사항으로 제거
                                <li>
                                    <span>고유식별정보 수집 및 이용안내 (필수)</span>
                                    <div class="checks">
                                        <input type="checkbox" id="terms4"/>
                                        <label for="terms4">동의</label>
                                    </div>
                                    <a href="#" data=".terms4" id="popup_terms4" class="popup_terms" onclick="javascript:popupTerms(4);">상세보기</a>
                                </li> -->
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
                            <div>
                            	<div class="bank_list">
                            		<%
		                            if(listVbankInfo != null) {
		                                for(int inx = 0; inx < listVbankInfo.size() && inx < 11; inx++) {
		                                    Box vbankBox = (Box)listVbankInfo.get(inx);
		                                    
		                                    String fn_cd = vbankBox.getString("fn_cd");
		                                    
		                                    String dis_fr_tm = "";
		                                    String dis_to_tm = "";
		                                    String dis_tm = "";
		                                    
		                                    boolean isSpecial = false;
		                                    
		                                    // 평일
		                                    if(off_cl.equals("1")) {
		                                        dis_fr_tm =  vbankBox.getString("work_fr_tm");
		                                        dis_to_tm =  vbankBox.getString("work_to_tm");
		                                    }
		                                    // 토,일요일
		                                    else {
		                                        // 정통부(우체국)
		                                        if(fn_cd.equals("75")) {
		                                            isSpecial = true;
		                                            dis_fr_tm =  vbankBox.getString("holi_fr_tm");
		                                            dis_to_tm = "익일04:00";
		                                            
		                                            dis_tm = dis_fr_tm.substring(0,2) + ":" + dis_fr_tm.substring(2,4) + "~" + "익일04:00";
		                                        }
		                                        // 경남은행
		                                        else if(fn_cd.equals("39")) {
		                                            isSpecial = true;
		                                            dis_tm = "토요일만가능";
		                                        }
		                                        else {
		                                            dis_fr_tm =  vbankBox.getString("holi_fr_tm");
		                                            dis_to_tm =  vbankBox.getString("holi_to_tm");
		                                        }
		                                    }
		                                    
		                               		// 티에스인터내셔널 입금가능 시간 예외처리
		                                    if(!"p44402260m".endsWith(MID) && dis_fr_tm.length() > 0 && dis_to_tm.length() > 0 && isSpecial == false)
		                                        dis_tm = dis_fr_tm.substring(0,2) + ":" + dis_fr_tm.substring(2,4) + "~" 
		                                            + dis_to_tm.substring(0,2) + ":" + dis_to_tm.substring(2,4);
		                                    
		                               		if(inx == 10 && listVbankInfo.size() >= 12){
		                            %>
		                            			<a href="#" id="etcBank1">
													<p class="bank_more">기타은행</p>
												</a>
												<a href="#" id="etcBank2" onclick="javascript:bankFrameOn();"></a>
												
		                            <%
		                            			break;
		                               		}else if(inx == 10 && listVbankInfo.size() == 11){
	                              	%>
												<a href="#" onclick="javascript:goCheckBank('<%=fn_cd%>','<%=vbankBox.getString("fn_nm")%>','<%=dis_tm%>','');">
													<div>
														<p class="bank<%=fn_cd%>"><%=vbankBox.getString("fn_nm")%></p>
													</div>
													<p class="w_time"><%=dis_tm%></p>
												</a>
									<%
		                               		}else{
												if(fn_cd.equals("011")) {
													if(nhVbankFee >= 250) {
														System.out.println("fncd : " + fn_cd + "----nhVbankFee" + nhVbankFee );														
									%>
														<a href="#" onclick="javascript:goCheckBank('<%=fn_cd%>','<%=vbankBox.getString("fn_nm")%>','<%=dis_tm%>','');">
															<div>
																<p class="bank<%=fn_cd%>"><%=vbankBox.getString("fn_nm")%></p>
															</div>
															<p class="w_time"><%=dis_tm%></p>
														</a>
									<%
													}
												// 농협 제외 은행
												} else {
									%>
													<a href="#" onclick="javascript:goCheckBank('<%=fn_cd%>','<%=vbankBox.getString("fn_nm")%>','<%=dis_tm%>','');">
														<div>
															<p class="bank<%=fn_cd%>"><%=vbankBox.getString("fn_nm")%></p>
														</div>
														<p class="w_time"><%=dis_tm%></p>
													</a>
									<%
												}
		                               		}
		                                }
		                            }
									%>
								</div>
                                <div class="input_section">
                                    <label for="VBankAccountName" class="input_title">입금자명</label>
                                    <div class="input_type1">
                                        <input type="text" name="VBankAccountName" id="VBankAccountName" placeholder="공백없이 입력하세요"/>
                                    </div>
                                </div>
                               <!--  <div class="input_section">
                                    <label for="cashReceiptType" class="input_title">현금영수증</label>
                                    <div class="select_type1">
                                        <select name="cashReceiptType" id="cashReceiptType" class="add_input" onchange="OnCashReceiptType($(this).val())">
                                            <option value="3">미발행</option>
                                            <option value="1">소득공제용</option>
                                            <option value="2">지출증빙용</option>
                                        </select>
                                    </div>
                                </div> -->
                                <% if("Y".equals(rcpt_flag)){ %>
                                <div class="input_section">
									<div for="cashReceiptType" class="input_title">현금영수증</div>
									<div class="input_type1 radio">
										<div class="radio_wrap">
											<input type="radio" name="cashReceiptType" value="3" id="cashReceiptType3" onclick="javascript:OnCashReceiptType($(this).val());" checked>
											<label for="cashReceiptType3">미발행</label>
										</div>
										<div class="radio_wrap">	
											<input type="radio" name="cashReceiptType" value="1" id="cashReceiptType1" onclick="javascript:OnCashReceiptType($(this).val());">
											<label for="cashReceiptType1">소득공제용</label>
										</div>
										<div class="radio_wrap">	
											<input type="radio" name="cashReceiptType" value="2" id="cashReceiptType2" onclick="javascript:OnCashReceiptType($(this).val());">
											<label for="cashReceiptType2">지출증빙용</label>
										</div>
									</div>
								</div>
								<% } %>
                                <!-- <div id="rcptType" class="input_section s3_2 s3">
                                    <label for="receiptType" class="input_title">발급번호</label>
                                    <div class="select_type1">
                                        <select name="receiptType" id="receiptType" class="add_input" onchange="OnReceiptType($(this).val())">
                                            <option value="1">휴대폰 번호</option>
                                            <option value="3">신용카드 번호</option>
                                        </select>
                                    </div>
                                </div> -->
                                <div id="rcptType" class="input_section">
									<div class="input_title">발급번호</div>
									<div class="input_type1 radio">
										<div class="radio_wrap">
											<input type="radio" name="receiptType" value="1" id="receiptType1" onclick="OnReceiptType($(this).val())" checked>
											<label for="receiptType1">휴대폰 번호</label>
										</div>
										<!-- <div class="radio_wrap">	
											<input type="radio" name="receiptType" value="3" id="receiptType3" onclick="OnReceiptType($(this).val())">
											<label for="receiptType3">신용카드 번호</label>
										</div> -->
									</div>
								</div>
                                <div id="bizNum" class="input_section s3_3 s3">
                                    <label for="biz_num" class="input_title">사업자번호</label>
                                    <div class="biz_num input_type_split">
                                        <input name="rcptCorpNo1" id="rcptCorpNo1" type="number" placeholder="123" pattern="[0-9]*" inputmode="numeric" maxLength="3" oninput="maxLengthCheck(this)" style="width: 34px;"/>
                                        -
                                        <input name="rcptCorpNo2" id="rcptCorpNo2" type="number" placeholder="12" pattern="[0-9]*" inputmode="numeric"  maxLength="2" oninput="maxLengthCheck(this)" style="width: 26px;"/>
                                        -
                                        <input name="rcptCorpNo3" id="rcptCorpNo3" type="number" placeholder="12345"  pattern="[0-9]*" inputmode="numeric" maxLength="5" oninput="maxLengthCheck(this)" style="width: 50px;"/>
                                    </div>
                                </div>
                                <div id="rcptTel" class="input_section s4_1 s4 s3 s3_2">
                                    <label for="phone_num_r" class="input_title">발급휴대폰</label>
                                    <div class="phone_num_r input_type_split">
                                        <input name="rcptTel1" id="rcptTel1" type="number" value="" placeholder="010" pattern="[0-9]*" inputmode="numeric" maxLength="3" oninput="maxLengthCheck(this)" style="width: 34px;"/>
                                        -
                                        <input name="rcptTel2" id="rcptTel2" type="number" value="" placeholder="1234" pattern="[0-9]*" inputmode="numeric"  maxLength="4" oninput="maxLengthCheck(this)"/>
                                        -
                                        <input name="rcptTel3" id="rcptTel3" type="number" value="" placeholder="1234"  pattern="[0-9]*" inputmode="numeric" maxLength="4" oninput="maxLengthCheck(this)"/>
                                    </div>
                                </div>
                                <div id="rcptJumin" class="input_section s4_2 s4 s3">
                                    <label for="personal_num" class="input_title">주민번호</label>
                                    <div class="personal_num input_type_split">
                                        <input name="rcptJuminNo1" id="rcptJuminNo1" type="number" placeholder="123456" pattern="[0-9]*" inputmode="numeric" maxLength="6" oninput="maxLengthCheck(this)" style="width: 58px;"/>
                                        -
                                        <input name="rcptJuminNo2" id="rcptJuminNo2" type="password" placeholder="1234567" pattern="[0-9]*" inputmode="numeric" class="security"  maxLength="7" oninput="maxLengthCheck(this)" style="width: 66px;"/>
                                    </div>
                                </div>
                                <div id="cardNum" class="input_section s4_3 s4 s3">
                                    <label for="card_num" class="input_title">카드번호</label>
                                    <div class="card_num input_type_split">
                                        <input name="rcptCardNo1" id="rcptCardNo1" autocomplete="cc-number" type="number" placeholder="1234" pattern="[0-9]*" inputmode="numeric" maxLength="4" oninput="maxLengthCheck(this)"/>
                                        -
                                        <input name="rcptCardNo2" id="rcptCardNo2" type="number" placeholder="1234" pattern="[0-9]*" inputmode="numeric"  maxLength="4" oninput="maxLengthCheck(this)"/>
                                        -
                                        <input name="rcptCardNo3" id="rcptCardNo3" type="password" class="security" placeholder="1234"  pattern="[0-9]*" inputmode="numeric" maxLength="4" oninput="maxLengthCheck(this)"/>
                                        -
                                        <input name="rcptCardNo4" id="rcptCardNo4" type="password" class="security" placeholder="1234"  pattern="[0-9]*" inputmode="numeric"  maxLength="4" oninput="maxLengthCheck(this)"/>
                                    </div>
                                </div>
                                <div class="input_section">
                                    <label for="e_mail" class="input_title">이메일</label>
                                    <div class="input_type1">
                                        <input type="email" name="BuyerEmail" id="BuyerEmail" value="<%=BuyerEmail %>" class="e_mail" pattern="[A-Za-z0-9]*" placeholder="이메일은 선택사항입니다"/>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <section class="notice">
                            <p>
                                ＊입금하실 계좌번호는 결제 마지막 단계에서 확인됩니다.
                            </p>        
                        </section>
						</div>
						
                        <section class="btn_wrap_multi">
                            <div>
                                <a class="btn_gray btn" href="javascript:callActivity();">취소</a>
                                <a class="btn_blue btn install_notice_btn" href="#">다음</a>
                            </div>
                        </section>
                    </section>
      <section class="footer pc">
                      <p>INNOPAY 1688 - 1250</p>
             
                    </section>
    <section class="footer mobile">
                       <p>INNOPAY 1688 - 1250</p>
                      
                </section>
                </section>
                
                <!-- Notice -->
				<%@ include file="/common/notice.jsp" %>
                
</form>
				
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
제1조 [목적] 
<br><br>
이 약관은 전자지급결제대행 서비스를 제공하는 주식회사 인피니소프트(이하 '회사'라 합니다)와 이용자 사이의 전자금융거래에 관한 기본적인 사항을 정함을 목적으로 한다.
</p>
<p>
제2조 [용어의 정의]
<br><br>
이 약관에서 정하는 용어의 정의는 다음과 같습니다. 
<br><br>
1. '전자금융거래'라 함은 회사가 전자적 장치를 통하여 전자지급결제대행서비스 및 전자금융 중개서비스(이하 '전자금융거래 서비스'라고 합니다)를 제공하고, 이용자가 회사의 종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다.
<br>
2. '전자지급결제대행 서비스'라 함은 전자적 방법으로 재화의 구입 또는 용역의 이용에 있어서 지급결제정보를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 서비스를 말합니다. 
<br>
3. '결제대금예치서비스'라 함은 이용자가 재화의 구입 또는 용역의 이용에 있어서 그 대가(이하 '결제대금'이라 한다)의 전부 또는 일부를 재화 또는 용역(이하 '재화 등'이라 합니다)을 공급받기 전에 미리 지급하는 경우, 회사가 이용자의 물품수령 또는 서비스 이용 확인 시점까지 결제대금을 예치하는 서비스를 말합니다.
<br>
4. '이용자'라 함은 이 약관에 동의하고 회사가 제공하는 전자금융거래 서비스를 이용하는 자를 말합니다. 
<br>
5. '접근매체'라 함은 전자금융거래에 있어서 거래지시를 하거나 이용자 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는 수단 또는 정보로서 전자식 카드 및 이에 준하는 전자적 정보(신용카드번호를 포함한다), '전자서명법'상의 인증서, 금융기관 또는 전자금융업자에 등록된 이용자번호, 이용자의 생체정보, 이상의 수단이나 정보를 사용하는데 필요한 비밀번호 등 전자금융거래법 제2조 제10호에서 정하고 있는 것을 말합니다. 
<br>
6. '거래지시'라 함은 이용자가 전자금융거래계약에 따라 금융기관 또는 전자금융업자에게 전자금융거래의 처리를 지시하는 것을 말합니다. 
<br>
7. '오류'라 함은 이용자의 고의 또는 과실 없이 전자금융거래가 전자금융거래계약 또는 이용자의 거래지시에 따라 이행되지 아니한 경우를 말합니다. 
</p>
<p>
제3조 [약관의 명시 및 변경]
<br><br>
1. 회사는 이용자가 전자금융거래 서비스를 이용하기 전에 이 약관을 게시하고 이용자가 이 약관의 중요한 내용을 확인할 수 있도록 합니다. 
<br>
2. 회사는 이용자의 요청이 있는 경우 전자문서의 전송방식에 의하여 본 약관의 사본을 이용자에게 교부합니다. 
<br>
3. 회사가 약관을 변경하는 때에는 그 시행일 1월 전에 변경되는 약관을 회사가 제공하는 전자금융거래 서비스 이용 초기화면 및 회사의 홈페이지에 게시함으로써 이용자에게 공지합니다. 
</p>
<p>
제4조 [접근매체의 관리 등]
<br><br>
1. 회사는 전자금융거래 서비스 제공 시 접근매체를 선정하여 이용자의 신원, 권한 및 거래지시의 내용 등을 확인할 수 있습니다. 
<br>
2. 이용자는 접근매체를 제3자에게 대여하거나 사용을 위임하거나 양도 또는 담보 목적으로 제공할 수 없습니다. 
<br>
3. 이용자는 자신의 접근매체를 제3자에게 누설 또는 노출하거나 방치하여서는 안되며, 접근매체의 도용이나 위조 또는 변조를 방지하기 위하여 충분한 주의를 기울여야 합니다. 
<br>
4. 회사는 이용자로부터 접근매체의 분실이나 도난 등의 통지를 받은 때에는 그 때부터 제3자가 그 접근매체를 사용함으로 인하여 이용자에게 발생한 손해를 배상할 책임이 있습니다. 
</p>
<p>
제5조 [회사의 책임]
<br><br>
1. 회사는 접근매체의 위조나 변조로 발생한 사고로 인하여 이용자에게 발생한 손해에 대하여 배상책임이 있습니다. 다만 이용자가 권한 없는 제3자가 이용자의 접근매체를 이용하여 전자금융거래를 할 수 있음을 알았거나 알 수 있었음에도 불구하고 이용자가 자신의 접근매체를 누설 또는 노출하거나 방치한 경우 그 책임의 전부 또는 일부를 이용자가 부담하게 할 수 있습니다.
<br>
2. 회사는 계약체결 또는 거래지시의 전자적 전송이나 처리과정에서 발생한 사고로 인하여 이용자에게 손해가 발생한 경우에는 그 손해를 배상할 책임이 있습니다. 다만, 본 조 제1항 단서에 해당하거나 본 조 제2항에 해당하거나 법인('중소기업기본법' 제2조 제2항에 의한 소기업을 제외한다)인 이용자에게 손해가 발생한 경우로서 회사가 사고를 방지하기 위하여 보안절차를 수립하고 이를 철저히 준수하는 등 합리적으로 요구되는 충분한 주의의무를 다한 경우 회사는 배상할 책임이 없습니다.
<br>
3. 회사는 이용자로부터의 거래지시가 있음에도 불구하고 천재지변, 회사의 귀책사유가 없는 정전, 화재, 통신장애 기타의 불가항력적인 사유로 처리 불가능하거나 지연된 경우로서 이용자에게 처리 불가능 또는 지연사유를 통지한 경우(금융기관 또는 결제수단 발행업체나 통신판매업자가 통지한 경우를 포함합니다)에는 이용자에 대하여 이로 인한 책임을 지지 아니합니다.
<br>
4. 회사는 전자금융거래를 위한 전자적 장치 또는 ‘정보통신망 이용촉진 및 정보보호 등에 관한 법률’ 제2조 제1항 제1호에 따른 정보통신망에 침입하여 거짓이나 그 밖의 부정한 방법으로 획득한 접근매체의 이용으로 발생한 사고로 인하여 이용자에게 그 손해가 발생한 경우에는 그 손해를 배상할 책임이 있습니다. 다만, 다음과 같은 경우 회사는 이용자에 대하여 책임을 지지 않습니다.
가. 회사가 접근매체에 따른 확인 외에 보안강화를 위하여 전자금융거래 시 요구하는 추가적인 보안조치를 이용자가 정당한 사유 없이 거부하여 사고가 발생한 경우
나. 이용자가 추가적인 보안조치에서 사용되는 매체, 수단 또는 정보에 대하여 누설, 누출 또는 방치한 행위 또는 제3자에게 대여하거나 그 사용을 위임한 행위 또는 양도나 담보의 목적으로 제공한 행위
</p>
<p>
제6조 [거래내용의 확인]
<br><br>
1. 회사는 이용자와 미리 약정한 전자적 방법을 통하여 이용자의 거래내용(이용자의 '오류정정 요구사실 및 처리결과에 관한 사항'을 포함합니다)을 확인할 수 있도록 하며, 이용자의 요청이 있는 경우에는 요청을 받은 날로부터 2주 이내에 모사전송 등의 방법으로 거래내용에 관한 서면을 교부합니다. 
<br>
2. 회사가 이용자에게 제공하는 거래내용 중 거래계좌의 명칭 또는 번호, 거래의 종류 및 금액, 거래상대방을 나타내는 정보, 거래일자, 전자적 장치의 종류 및 전자적 장치를 식별할 수 있는 정보와 해당 전자금융거래와 관련한 전자적 장치의 접속기록은 5년간, 건당 거래금액이 1만원 이하인 소액 전자금융거래에 관한 기록, 전자지급수단 이용시 거래승인에 관한 기록, 이용자의 오류정정 요구사실 및 처리결과에 관한 사항은 1년간의 기간을 대상으로 하되, 회사가 전자금융거래 서비스 제공의 대가로 수취한 수수료에 관한 사항은 제공하는 거래내용에서 제외합니다. 
<br>
3. 이용자가 제1항에서 정한 서면교부를 요청하고자 할 경우 다음의 주소 및 전화번호로 요청할 수 있습니다. 
<br>
- 주소: 서울시 금천구 가산디지털2로 53, 307호 (가산동, 한리시그마밸리) 
- 이메일 주소: cs@infinisoft.co.kr
- 전화번호: 1688-1250 
</p>
<p>
제7조 [오류의 정정 등]
<br><br>
1. 이용자는 전자금융거래 서비스를 이용함에 있어 오류가 있음을 안 때에는 회사에 대하여 그 정정을 요구할 수 있습니다. 
<br>
2. 회사는 전항의 규정에 따른 오류의 정정요구를 받은 때에는 이를 즉시 조사하여 처리한 후 정정요구를 받은 날부터 2주 이내에 그 결과를 이용자에게 알려 드립니다. 
</p>
<p>
제8조 [전자금융거래 서비스 이용 기록의 생성 및 보존]
<br><br>
1. 회사는 이용자가 전자금융거래의 내용을 추적, 검색하거나 그 내용에 오류가 발생한 경우에 이를 확인하거나 정정할 수 있는 기록을 생성하여 보존합니다. 
<br>
2. 전항의 규정에 따라 회사가 보존하여야 하는 기록의 종류 및 보존방법은 제6조 제2항에서 정한 바에 따릅니다. 
</p>
<p>
제9조 [거래지시의 철회 제한]
<br><br>
1. 이용자는 전자지급거래에 관한 거래지시의 경우 지급의 효력이 발생하기 전까지 거래지시를 철회할 수 있습니다.
<br>
2. 전항의 지급의 효력이 발생 시점이란 (i) 전자자금이체의 경우에는 거래 지시된 금액의 정보에 대하여 수취인의 계좌가 개설되어 있는 금융기관의 계좌 원장에 입금기록이 끝난 때 (ii) 그 밖의 전자지급수단으로 지급하는 경우에는 거래 지시된 금액의 정보가 수취인의 계좌가 개설되어 있는 금융기관의 전자적 장치에 입력이 끝난 때를 말합니다.
<br>
3. 이용자는 지급의 효력이 발생한 경우에는 전자상거래 등에서의 소비자보호에 관한 법률 등 관련 법령상 청약의 철회의 방법 또는 본 약관 제5조에서 정한 바에 따라 결제대금을 반환 받을 수 있습니다.
</p>
<p>
제10조 [전자금융거래정보의 제공금지]
<br><br>
회사는 전자금융거래 서비스를 제공함에 있어서 취득한 이용자의 인적 사항, 이용자의 계좌, 접근매체 및 전자금융거래의 내용과 실적에 관한 정보 또는 자료를 이용자의 동의를 얻지 아니하고 제3자에게 제공, 누설하거나 업무상 목적 외에 사용하지 아니합니다. 
</p>
<p>
제11조 [분쟁처리 및 분쟁조정]
<br><br>
1. 이용자는 다음의 분쟁처리 책임자 및 담당자에 대하여 전자금융거래 서비스 이용과 관련한 의견 및 불만의 제기, 손해배상의 청구 등의 분쟁처리를 요구할 수 있습니다. 
<br>
- 전화번호: 1688-1250
- 전자우편주소: cs@infinisoft.co.kr
<br><br>
2. 이용자가 회사에 대하여 분쟁처리를 신청한 경우에는 회사는 15일 이내에 이에 대한 조사 또는 처리 결과를 이용자에게 안내합니다. 
<br>
3. 이용자는 '금융감독기구의 설치 등에 관한 법률' 제51조의 규정에 따른 금융감독원의 금융분쟁조정위원회나 '소비자보호법' 제31조 제1항의 규정에 따른 소비자보호원에 회사의 전자금융거래 서비스의 이용과 관련한 분쟁조정을 신청할 수 있습니다. 
</p>
<p>
제12조 [회사의 안정성 확보 의무]
<br><br>
회사는 전자금융거래의 안전성과 신뢰성을 확보할 수 있도록 전자금융거래의 종류별로 전자적 전송이나 처리를 위한 인력, 시설, 전자적 장치 등의 정보기술부문 및 전자금융업무에 관하여 금융감독위원회가 정하는 기준을 준수합니다. 
</p>
<p>
제13조 [약관 외 준칙 및 관할]
<br><br>
1. 이 약관에서 정하지 아니한 사항에 대하여는 전자금융거래법, 전자상거래 등에서의 소비자 보호에 관한 법률, 통신판매에 관한 법률, 여신전문금융업법 등 소비자보호 관련 법령에서 정한 바에 따릅니다. 
<br>
2. 회사와 이용자간에 발생한 분쟁에 관한 관할은 민사소송법에서 정한 바에 따릅니다.
</p>
<br>
<br>
<p>
[부칙]<br>
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
<br><br>
회사는 전자결제대행 및 결제대금예치 서비스, 현금영수증 서비스 그리고 휴대폰 본인확인서비스(이하 “서비스”라 칭함) 신청, 상담, 문의사항 등,
서비스의 제공을 위하여 아래와 같은 개인정보를 수집하고 있습니다.
<br><br>
① 개인정보 수집항목
<br><br>
(1) 필수항목
<br><br>
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
<br><br>
(2) 선택항목
<br><br>
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
<br><br>
(1) 보존항목: 서비스 상담 수집 항목(회사명, 고객명, 전화번호, E-mail, 상담내용 등)
<br>
(2) 보존이유: 분쟁이 발생 할 경우 소명자료 활용
<br>
(3) 보존기간: 상담 완료 후 6개월
<br><br>
② 관련법령에 의한 정보보유
<br><br>
상법, 전자상거래 등에서의 소비자보호에 관한 법률, 전자금융거래법 등 관련법령의 규정에 의하여 보존할 필요가 있는 경우
회사는 관련법령에서 정한 일정한 기간 동안 정보를 보관합니다.
이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 다음 각 호와 같습니다.
<br><br>
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
                <!--//popup3-->
                <!--popup4-->
                <section class="float_wrap terms4">
                    <div class="pop_dim"></div>
                    <div class="popup conditions_text" id="conditions_text4">
                        <h3 class="popup_title">고유식별정보 수집 및 이용안내</h3>
                        <a href="#" class="btn_close pop_close"></a>
                        <div class="popup_cont">
                            <div class="popup_scroll">
                                <div class="popup_scroll_in">
                                    <p>제1조 (목적)<br>이 약관은 주식회사 인피니소프트(이하 '회사'라 합니다)가 제공하는 전자지급결제대행서비스 및 결제대금예치서비스를 이용자가 이용함에 있어 회사와 이용자 사이의 전자금융거래에 관한 기본적인 사항을 정함을 목적으로 합니다. </p>
                                    <p>제2조 (용어의 정의)<br>이 약관에서 정하는 용어의 정의는 다음과 같습니다.<br>1. '전자금융거래'라 함은 회사가 전자적 장치를 통하여 전자지급결제대행서비스 및 결제대금예치서비스(이하 '전자금융거래 서비스'라고 합니다)를 제공하고, 이용자가 회사의 종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다.<br>2. '전자지급결제대행서비스'라 함은 전자적 방법으로 재화의 구입 또는 용역의 이용에 있어서 지급결제정보를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 서비스를 말합니다.<br>3. '결제대금예치서비스'라 함은 이용자가 재화의 구입 또는 용역의 이용에 있어서 그 대가(이하 '결제대금'이라 한다)의 전부 또는 일부를 재화 또는 용역(이하 '재화 등'이라 합니다)을 공급받기 전에 미리 지급하는 경우, 회사가 이용자의 물품수령 또는 서비스 이용 확인 시점까지 결제대금을 예치하는 서비스를 말합니다.<br>4. '이용자'라 함은 이 약관에 동의하고 회사가 제공하는 전자금융거래 서비스를 이용하는 자를 말합니다.<br>5. '접근매체'라 함은 전자금융거래에 있어서 거래지시를 하거나 이용자 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는 수단 또는 정보로서 전자식 카드 및 이에 준하는 전자적 정보(신용카드번호를 포함한다), '전자서명법'상의 인증서, 회사에 등록된 이용자번호, 이용자의 생체정보, 이상의 수단이나 정보를 사용하는데 필요한 비밀번호 등 전자금융거래법 제2조 제10호에서 정하고 있는 것을 말합니다.<br>6. '거래지시'라 함은 이용자가 본 약관에 의하여 체결되는 전자금융거래계약에 따라 회사에 대하여 전자금융거래의 처리를 지시하는 것을 말합니다.<br>7. '오류'라 함은 이용자의 고의 또는 과실 없이 전자금융거래가 전자금융거래계약 또는 이용자의 거래지시에 따라 이행되지 아니한 경우를 말합니다. </p>
                                    <p>제3조 (약관의 명시 및 변경)<br>1. 회사는 이용자가 전자금융거래 서비스를 이용하기 전에 이 약관을 게시하고 이용자가 이 약관의 중요한 내용을 확인할 수 있도록 합니다.<br> 2. 회사는 이용자의 요청이 있는 경우 전자문서의 전송방식에 의하여 본 약관의 사본을 이용자에게 교부합니다.<br>3. 회사가 약관을 변경하는 때에는 그 시행일 1월 전에 변경되는 약관을 회사가 제공하는 전자금융거래 서비스 이용 초기화면 및 회사의 홈페이지에 게시함으로써 이용자에게 공지합니다.</p>
                                    
                                </div>
                            </div>
                        </div>  
                        <div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>
                    </div>
                </section>  
                
                <!--bank-->
				<section class="float_wrap bank_frame">
					<div class="pop_dim"></div>
					<div class="popup bank_etc">
						<h3 class="popup_title">은행 선택</h3>
						<a href="#" class="btn_close pop_close"></a>
						<div class="popup_cont">
							<div class="popup_scroll">
								<div class="bank_list2">
									<%
		                            if(listVbankInfo != null && listVbankInfo.size() >= 12) {
		                                for(int inx = 10; inx < listVbankInfo.size(); inx++) {
		                                    Box vbankBox = (Box)listVbankInfo.get(inx);
		                                    
		                                    String fn_cd = vbankBox.getString("fn_cd");
		                                    
		                                    String dis_fr_tm = "";
		                                    String dis_to_tm = "";
		                                    String dis_tm = "";
		                                    
		                                    boolean isSpecial = false;
		                                    
		                                    // 평일
		                                    if(off_cl.equals("1")) {
		                                        dis_fr_tm =  vbankBox.getString("work_fr_tm");
		                                        dis_to_tm =  vbankBox.getString("work_to_tm");
		                                    }
		                                    // 토,일요일
		                                    else {
		                                        // 정통부(우체국)
		                                        if(fn_cd.equals("75")) {
		                                            isSpecial = true;
		                                            dis_fr_tm =  vbankBox.getString("holi_fr_tm");
		                                            dis_to_tm = "익일04:00";
		                                            
		                                            dis_tm = dis_fr_tm.substring(0,2) + ":" + dis_fr_tm.substring(2,4) + "~" + "익일04:00";
		                                        }
		                                        // 경남은행
		                                        else if(fn_cd.equals("39")) {
		                                            isSpecial = true;
		                                            dis_tm = "토요일만가능";
		                                        }
		                                        else {
		                                            dis_fr_tm =  vbankBox.getString("holi_fr_tm");
		                                            dis_to_tm =  vbankBox.getString("holi_to_tm");
		                                        }
		                                    }
		                                    
		                               		// 티에스인터내셔널 입금가능 시간 예외처리
		                                    if(!"p44402260m".endsWith(MID) && dis_fr_tm.length() > 0 && dis_to_tm.length() > 0 && isSpecial == false) {
		                                        dis_tm = dis_fr_tm.substring(0,2) + ":" + dis_fr_tm.substring(2,4) + "~" 
		                                            + dis_to_tm.substring(0,2) + ":" + dis_to_tm.substring(2,4);
		                                	}
									%>		                                    

											<a href="#" onclick="javascript:goCheckBank('<%=fn_cd%>','<%=vbankBox.getString("fn_nm")%>','<%=dis_tm%>','etc');">
												<div>
													<p class="bank<%=fn_cd%>"><%=vbankBox.getString("fn_nm")%></p>
												</div>
												<p class="w_time"><%=dis_tm%></p>
											</a>
									<%
		                               	}
		                            }
									%>
								</div>
							</div>
						</div>
						<div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>
					</div>
				</section>
				<!--bank-->
                
                <!--//popup4-->				
            </section>
        </div>
    </body>

</html>


<script>
$("#rcptType").css('display','none');
$("#bizNum").css('display','none');
$("#rcptTel").css('display','none');
$("#rcptJumin").css('display','none');
$("#cardNum").css('display','none');
</script>