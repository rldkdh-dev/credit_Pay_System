<%
/*****************************************************************************
*
*   @ SYSTEM NAME       : 신용카드 해외카드 입력 페이지
*   @ PROGRAM NAME      : inputForeign_card.jsp
*   @ MAKER             : InnoPay PG
*   @ MAKE DATE         : 2018.08.24
*   @ PROGRAM CONTENTS  : 신용카드 해외카드 입력 페이지
*
******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="./common_card.jsp" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link rel="stylesheet" type="text/css" href="../css/jquery.mCustomScrollbar.css" />
		<link rel="stylesheet" type="text/css" href="../css/common.css" />
		<link href='../css/font.css' rel='stylesheet' type='text/css'>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
		<script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
		<script type="text/javascript" src="../js/jquery.mCustomScrollbar.js"></script>
		<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
		<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
		<script type="text/javascript" src="../js/common.js"></script>
		<script type="text/javascript" src="../js/card_eximbay.js"></script>
		<script type="text/javascript" src="../js/card_pay_m.js" charset="utf-8"></script>
		<script type="text/javascript">
			function googleTranslateElementInit() {
	            new google.translate.TranslateElement({pageLanguage: 'ko', includedLanguages: 'ar,de,en,es,fr,hi,ja,mn,ms,ru,th,tr,vi,zh-CN', layout: google.translate.TranslateElement.InlineLayout.SIMPLE, autoDisplay: false}, 'google_translate_element');
	        }
			//maxLength 체크
			function maxLengthCheck(object){
				if (object.value.length > object.maxLength){
						 object.value = object.value.slice(0, object.maxLength);
				}
			};
		</script>
		<title>INNOPAY 전자결제서비스</title>
	</head>
	<body>
<script type="text/javascript">

	var submitCnt = 0;
	
	function goConfirm() {
	    var frm = document.tranMgr;
	    
	    if(submitCnt > 0) {
	        return false;
	    }
	    
	    if( $("#card_no").val().trim() == '') {
	        alert("카드번호를 입력해주세요.");
	        $("#card_no").focus();
	        return false;       
	    }
	    
	    if( $("#card_no").val().length < 6) {
	    	alert("카드번호를 입력해주세요.");
	    	$("#card_no").focus();
	        return false;       
	    }
	    
	    if( $("#card_expire").val().trim() == '') {
	        alert("유효기간 4자리를 입력해주세요.");
	        $("#card_expire").focus();
	        return false;       
	    }
	    
	    if( $("#card_expire").val().length < 4) {
	        alert("유효기간 4자리를 입력해주세요.");
	        $("#card_expire").focus();
	        return false;       
	    }
	    
	    if( $("#cvc").val().trim() == '') {
	        alert("CVC 번호를 입력해주세요.");
	        $("#cvc").focus();
	        return false;       
	    }
	    
	    if( $("#cvc").val().length < 3) {
	        alert("CVC 번호를 입력해주세요.");
	        $("#cvc").focus();
	        return false;       
	    }
	    
	    var result = doEximbay();
        if(result){
            install_eximbay_notice_on();
        }else{
            install_eximbay_notice_off();
        }
        return false;
	}
	
	function doEximbay() {
		
		var frm = document.tranMgr;
		frm.EB_CARDNO.value = $("#card_no").val();
	    frm.EB_EXPIRYDT.value = $("#card_expire").val();
	    frm.EB_CVC.value = $("#cvc").val();
	    
	    submitCnt++;
	    frm.action = "./eximbay/agent_enrollment_req_m.jsp";
	    frm.target="EXIMBAYFRAME";
	    frm.submit();
		return true;
		
	}
	
	function doEximbayCardAuth() {
		
		var frm = document.tranMgr;
		
	    frm.action = "./eximbay/input_EB_MPI.jsp";
	    frm.target="_self";
	    frm.submit();
		return true;
	}
	
	function doEximbayValidate() {
		
		var frm = document.tranMgr;
		
		submitCnt++;
	    frm.action = "./eximbay/agent_validate_req_m.jsp";
	    frm.target="EXIMBAYFRAME";
	    frm.submit();
		return true;
		
	}
	
	// 결제 과정 취소 function
	function goCancel() {
		document.tranMgr.action = "index_card_m.jsp";
		document.tranMgr.target = "_self";
		document.tranMgr.submit();
		return false;
	}
	
</script>
<form name="tranMgr" id="tranMgr" method="post" action="<%=actionUrl%>">
<input type="hidden" name="PayMethod"       value="<%=PayMethod%>"/>
<input type="hidden" name="pointUseYN"      value="<%=pointUseYN%>"/>
<input type="hidden" name="formBankCd"      value="<%=formBankCd%>"/>
<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
<input type="hidden" name="GoodsName"       value="<%=GoodsName%>"/>
<input type="hidden" name="GoodsURL"        value="<%=GoodsURL%>"/>
<input type="hidden" name="Amt"             value="<%=Amt%>"/>
<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
<input type="hidden" name="CardInterest"    value="<%=CardInterest%>"/>
<input type="hidden" name="CardPoint"    value="0"/>
<input type="hidden" name="Moid"            value="<%=Moid%>"/>
<input type="hidden" name="MID"             value="<%=MID%>"/>
<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/>
<input type="hidden" name="ResultYN"        value="<%=ResultYN%>"/>
<input type="hidden" name="RetryURL"        value="<%=RetryURL%>"/>
<input type="hidden" name="mallUserID"      value="<%=mallUserID%>"/>
<input type="hidden" name="BuyerName"       value="<%=BuyerName%>"/>
<input type="hidden" name="BuyerAuthNum"    value="<%=BuyerAuthNum%>"/>
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
<input type="hidden" name="svcCd"      value="<%=svcCd%>">
<input type="hidden" name="svcPrdtCd"      value="<%=svcPrdtCd%>">
<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
<input type="hidden" name="User_ID"         value="<%=User_ID%>">
<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
<input type="hidden" name="BuyerCode"      value="<%=BuyerCode%>">
<input type="hidden" name="FORWARD"        value="<%=FORWARD%>">
<input type="hidden" name="EncryptData"    value="<%=EncryptData%>"> <!-- 거래검증값 추가(2018.08 hans) -->
<input type="hidden" name="ediDate"        value="<%=ediDate%>">
<input type="hidden" name="Currency"       value="<%=Currency%>">
<input type="hidden" name="BuyerEmail"     value="<%=BuyerEmail%>">
<input type="hidden" name="RefererURL"       value="<%=RefererURL%>">

<!-- EXIMBAY -->
<input type="hidden" name="EB_CARDNO" value="">
<input type="hidden" name="EB_EXPIRYDT" value="">
<input type="hidden" name="EB_AUTHORIZEDID" value="">
<input type="hidden" name="EB_PARES" value="">
<input type="hidden" name="EB_BASECUR" value="">
<input type="hidden" name="EB_BASEAMT" value="">
<input type="hidden" name="EB_BASERATE" value="">
<input type="hidden" name="EB_BFOREIGNCUR" value="">
<input type="hidden" name="EB_BFOREIGNAMT" value="">
<input type="hidden" name="EB_BFOREIGNRATE" value="">
<input type="hidden" name="EB_BDCCRATE" value="">
<input type="hidden" name="EB_BDCCRATEID" value="">
<input type="hidden" name="EB_ECI" value="">
<input type="hidden" name="EB_XID" value="">
<input type="hidden" name="EB_CAVV" value="">
<input type="hidden" name="EB_PARESSTATUS" value="">
<input type="hidden" name="EB_MD" value="">
<input type="hidden" name="EB_CVC" value="">
<input type="hidden" name="EB_CARD_ACSURL" value="">
<input type="hidden" name="EB_CARD_PAREQ" value=""/>
<input type="hidden" name="EB_CARD_TERMURL" value=""/>
<input type="hidden" name="EB_CARD_MD" value=""/>
</form>

		<div class="innopay">
			<div class="dim"></div>
			<section class="float_wrap install_eximbay_notice">
                <div class="dim_blue"></div>
                <div class="popup_cont">
                    <img src="../images/i_info.png" alt="알림" width="60px" height="auto">
                    <p>해당 카드는 안심클릭인증 결제 카드 입니다.<br>카드사 안심클릭인증 후 결제 바랍니다.</p>
                </div>
            </section>
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
							</ul>
						</div>
					</section>
					
					<section class="con_wrap">
						<div class="con_scroll">
							<section class="payment_input" style="margin-top: 0;">
								<h2>카드정보 입력</h2>
									<div class="input_section">
										<label for="card_no" class="input_title">카드번호</label>
										<div>
											<input name="card_no" type="number" id="card_no" placeholder="" pattern="[0-9]*" inputmode="numeric" maxLength="16" oninput="maxLengthCheck(this)" value="" />
										</div>
									</div>
									<div class="input_section">
										<label for="card_expire" class="input_title">유효기간</label>
										<div>
											<input name="card_expire" type="number" id="card_expire" placeholder="4자리" pattern="[0-9]*" inputmode="numeric" maxLength="4" oninput="maxLengthCheck(this)" value="" />
										</div>
									</div>
									<div class="input_section">
										<label for="cvc" class="input_title">CVC</label>
										<div>
											<input name="cvc" type="number" id="cvc" placeholder="3자리" pattern="[0-9]*" inputmode="numeric" maxLength="3" oninput="maxLengthCheck(this)" value="" />
										</div>
									</div>
							</section>
						</div>
						<section class="btn_wrap_multi">
							<div>
								<a class="btn_gray btn dim_btn" href="javascript:goCancel()">취소</a>
								<a class="btn_blue btn" onClick="return goConfirm()">다음</a>
							</div>
						</section>
					</section>

					<section class="footer mobile">
						<span>INNOPAY 1688 - 1250</span>
					</section>

				</section>

				<!-- Faq -->
				<%@ include file="/card/faq.jsp" %>

				<!-- Notice -->
				<%@ include file="/common/notice.jsp" %>
				
			</section>
		</div>
	</body>
	
	<div id="EXIMBAYDIV" style="display:none;">
	<iframe id="EXIMBAYFRAME" name="EXIMBAYFRAME" border="0" style="width:100%;height:100%;" scrolling="no"></iframe>
	</div>

</html>