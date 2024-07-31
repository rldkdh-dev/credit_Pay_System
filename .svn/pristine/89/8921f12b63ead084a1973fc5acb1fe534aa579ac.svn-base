
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="./common_epay.jsp" %>
	<%
		System.out.println("**** Start ipay EPay_mobile.jsp ["+System.currentTimeMillis()+"] ****");
		Enumeration eNames = request.getParameterNames();
		if (eNames.hasMoreElements()) {
			Map entries = new TreeMap();
			while (eNames.hasMoreElements()){
				String name = (String) eNames.nextElement();
				String[] values = request.getParameterValues(name);
				if (values.length > 0) {
					String value = values[0];
					for (int i = 1; i < values.length; i++){
						value += "," + values[i];
					}
					System.out.println(name + "[" + value +"]");
				}
			}
		}
		%>
		<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link rel="stylesheet" type="text/css" href="../css/jquery.mCustomScrollbar.css" />
		<link rel="stylesheet" type="text/css" href="../css/common.css" />
		<link href='../css/font.css' rel='stylesheet' type='text/css'>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
		<script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
		<script type="text/javascript" src="../js/jquery.mCustomScrollbar.js"></script>
		<script type="text/javascript" src="../js/card_pay_m.js" charset="utf-8"></script>
  		<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
		<script type="text/javascript" src="../js/common.js"></script>
		<!-- <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script> -->
	<script type="text/javascript">
			// function googleTranslateElementInit() {
			//   new google.translate.TranslateElement({pageLanguage: 'ko', layout: google.translate.TranslateElement.InlineLayout.SIMPLE, autoDisplay: false}, 'google_translate_element');
			// }
		var f = null;
		var payco_frm = null;
		var lpay = null;
		
	function getLocalUrl(mypage){ 
		var myloc = location.href; 
		return myloc.substring(0, myloc.lastIndexOf('/')) + '/' + mypage;
	} 
	
	function goCancel() {
		try{
			if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
				window.open('', '_self', '');
			    window.close();
			}else if((window.parent!=null&&window.parent!=undefined)||('X'=='<%=FORWARD%>')){
				window.parent.postMessage('close','*');
			}else{
				
			}
		}catch(e){}
	}
			/*
			$(function(){
				$("#SFRAME").load(function(){ //iframe 컨텐츠가 로드 된 후에 호출됩니다.					
					var a = $(this).contents().find('body');
					alert($(this).contents().find('body').prop("scrollHeight"));
				});
			});
		*/
		function goNext(){
			if(!checkTerms()) return;
			var mobile = isMobile();
		
		if($("#simple_pay1_area").hasClass("on") === true){
			try{			
		     		f = document.MainForm;
				 	f.action = "kakao/kakao_m.jsp";
				 	f.submit();
			}catch(e){
				alert("결제창 호출에 실패하였습니다!");				 	
			    return false;
			}
			}else if($("#simple_pay2_area").hasClass("on") === true){
			try{
				lpay = document.lpayForm;
				lpay.sndReply.value = getLocalUrl("lpay/lpay_return.jsp");									         
					var call_url = "./lpay/lpay_m.jsp";  	 				
				
					lpay.action = call_url;
					lpay.submit();
			}catch(e){
					alert("결제창 호출에 실패하였습니다!");
					e.printStackTrace(); //오류 출력(방법은 여러가지)
				    throw e;
				}
			}else if($("#simple_pay3_area").hasClass("on") === true){
			try{
				var payco_frm  = document.paycoForm;
				 payco_frm.sndReply.value = getLocalUrl("payco/payco_return.jsp");
				var call_url = "./payco/payco_m.jsp";  	 
				
				payco_frm.action = call_url;
				payco_frm.submit();
			}catch(e){
					alert("결제창 호출에 실패하였습니다!");
					e.printStackTrace(); //오류 출력(방법은 여러가지)
				    throw e;
				     }		
			}else if($("#simple_pay4_area").hasClass("on") === true){
			try{
				var ssgfrm = document.ssgFrm;
				ssgfrm.sndCertitype.value = "2";		
				//ssgfrm.target="SSGFRAME";
				ssgfrm.action ='./ssg/ssg_m.jsp'; 
				ssgfrm.submit();
			}catch(e){
					alert("결제창 호출에 실패하였습니다!");
					e.printStackTrace(); //오류 출력(방법은 여러가지)
				    throw e;
				}
			}else if($("#simple_pay5_area").hasClass("on") === true){
			try{
				var ssgfrm = document.ssgFrm;
				ssgfrm.sndCertitype.value = "1";		
				//ssgfrm.target="SSGFRAME";
				ssgfrm.action ='./ssg/ssg_m.jsp'; 
				ssgfrm.submit();
			}catch(e){
					alert("결제창 호출에 실패하였습니다!");
					e.printStackTrace(); //오류 출력(방법은 여러가지)
				    throw e;
				}
			}else if($("#simple_pay6_area").hasClass("on") === true){
				try{
					var naverfrm = document.NAVERPayAuthForm;												
					naverfrm.action ='./naver/naver_m.jsp'; 
					naverfrm.submit(); 
				}catch(e){
					alert("결제창 호출에 실패하였습니다!");
					e.printStackTrace(); //오류 출력
				    throw e;
				}					
			}
			else{
			alert("잘못된 접근 방식입니다.");
			return false;
		}
		}
		
		function submitAuth(){  
			var frm = document.KSPayAuthForm;
			frm.action = "./payConfirm_EPay.jsp";
			frm.submit();
		}
		function isMobile(){ //모바일, pc 구분
			var filter = "win16|win32|win64|mac|macintel";
			 
			if (navigator.platform ){
	 			if (filter.indexOf(navigator.platform.toLowerCase()) < 0) {
	  			return true;
	 			} else {
	 				//PC
	  			return false;
	 			}
			}
		}		
		//카카오페이 레이어 화면 속성 hidden
		function kakao_cancel(){
			document.getElementById("KAKAO_IFRM").style.visibility="hidden";
		}	
		</script>
		<title>INNOPAY 전자결제서비스</title>
	</head>
	<body>
		<div class="innopay">
				<section class="innopay_wrap">

				<header class="gnb">
					<h1 class="logo"><img src="../images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></h1>
					<div class="kind">
						<span>간편결제</span>
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
						<section class="footer pc">	  
	                    </section>
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
										<span>전자금융거래 기본약관 (필수)</span>
										
										<div class="checks">
											<input type="checkbox" id="terms1"/>
											<label for="terms1">동의</label>
										</div>
										<a href="#" data=".terms1" class="popup_btn">상세보기</a>
									</li>
									<li>
										<span>개인정보 수집 및 이용안내 (필수)</span>
										<div class="checks">     
											<input type="checkbox" id="terms2"/>
											<label for="terms2">동의</label>
										</div>
										<a href="#" data=".terms2" class="popup_btn">상세보기</a>
									</li>
									<li>
										<span>개인정보 제공 및 위탁안내 (필수)</span>
										<div class="checks">
											<input type="checkbox" id="terms3"/>
											<label for="terms3">동의</label> 
										</div>
										<a href="#" data=".terms3" class="popup_btn">상세보기</a>
									</li>
								</ul>
							</section>

							<section class="payment_input">
								<h2>간편결제 선택</h2>
								<div class="card_list">
									<div class="simple_pay_list">
										<a href="#" class="on" id="simple_pay1_area">
											<p class="simple_pay1" ></p>
										</a>
										<a href="#" id="simple_pay2_area">
											<p class="simple_pay2"></p>
										</a>
										<a href="#" id="simple_pay3_area">
											<p class="simple_pay3"></p>
										</a>
										<a href="#" id="simple_pay4_area">
											<p class="simple_pay4"></p>
										</a>
											<a href="#" id="simple_pay5_area">
											<p class="simple_pay5"></p>
										</a>
										<a href="#" id="simple_pay6_area">
											<p class="simple_pay6"></p>
										</a>
									</div>
								</div>
							</section>							
						</div>
						 <section class="btn_wrap_multi">
	                            <div id="btn_wrap">
	                                <a class="btn_gray btn" href="javascript:goCancel()">취소</a>
	                                <a class="btn_blue btn install_notice_btn" href="#">다음</a>
	                            </div>
	                        </section>
	                        <section class="footer mobile">
	                        <p>INNOPAY 1688 - 1250</p>
	                    </section>
					</section>
				</section>
			<%@ include file="/common/notice.jsp" %>

				<!--popup1-->
				<section class="float_wrap terms1">
					<div class="pop_dim"></div>
					<div class="popup conditions_text">
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
					<div class="popup conditions_text">
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
					<div class="popup conditions_text">
						<h3 class="popup_title">개인정보 제공 및 위탁안내</h3>
						<a href="#" class="btn_close pop_close"></a>
						<div class="popup_cont">
							<div class="popup_scroll">
								<div class="popup_scroll_in">
									<p>제1조 (목적)<br>이 약관은 주식회사 인피니소프트 (이하 '회사'라 합니다)가 제공하는 전자지급결제대행서비스 및 결제대금예치서비스를 이용자가 이용함에 있어 회사와 이용자 사이의 전자금융거래에 관한 기본적인 사항을 정함을 목적으로 합니다. </p>
									<p>제2조 (용어의 정의)<br>이 약관에서 정하는 용어의 정의는 다음과 같습니다.<br>1. '전자금융거래'라 함은 회사가 전자적 장치를 통하여 전자지급결제대행서비스 및 결제대금예치서비스(이하 '전자금융거래 서비스'라고 합니다)를 제공하고, 이용자가 회사의 종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다.<br>2. '전자지급결제대행서비스'라 함은 전자적 방법으로 재화의 구입 또는 용역의 이용에 있어서 지급결제정보를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 서비스를 말합니다.<br>3. '결제대금예치서비스'라 함은 이용자가 재화의 구입 또는 용역의 이용에 있어서 그 대가(이하 '결제대금'이라 한다)의 전부 또는 일부를 재화 또는 용역(이하 '재화 등'이라 합니다)을 공급받기 전에 미리 지급하는 경우, 회사가 이용자의 물품수령 또는 서비스 이용 확인 시점까지 결제대금을 예치하는 서비스를 말합니다.<br>4. '이용자'라 함은 이 약관에 동의하고 회사가 제공하는 전자금융거래 서비스를 이용하는 자를 말합니다.<br>5. '접근매체'라 함은 전자금융거래에 있어서 거래지시를 하거나 이용자 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는 수단 또는 정보로서 전자식 카드 및 이에 준하는 전자적 정보(신용카드번호를 포함한다), '전자서명법'상의 인증서, 회사에 등록된 이용자번호, 이용자의 생체정보, 이상의 수단이나 정보를 사용하는데 필요한 비밀번호 등 전자금융거래법 제2조 제10호에서 정하고 있는 것을 말합니다.<br>6. '거래지시'라 함은 이용자가 본 약관에 의하여 체결되는 전자금융거래계약에 따라 회사에 대하여 전자금융거래의 처리를 지시하는 것을 말합니다.<br>7. '오류'라 함은 이용자의 고의 또는 과실 없이 전자금융거래가 전자금융거래계약 또는 이용자의 거래지시에 따라 이행되지 아니한 경우를 말합니다. </p>
									<p>제3조 (약관의 명시 및 변경)<br>1. 회사는 이용자가 전자금융거래 서비스를 이용하기 전에 이 약관을 게시하고 이용자가 이 약관의 중요한 내용을 확인할 수 있도록 합니다.<br> 2. 회사는 이용자의 요청이 있는 경우 전자문서의 전송방식에 의하여 본 약관의 사본을 이용자에게 교부합니다.<br>3. 회사가 약관을 변경하는 때에는 그 시행일 1월 전에 변경되는 약관을 회사가 제공하는 전자금융거래 서비스 이용 초기화면 및 회사의 홈페이지에 게시함으로써 이용자에게 공지합니다.</p>
									
								</div>
							</div>
						</div>	
						<div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>
					</div>
				</section>	
				<!--//플러그인 설치안내 popup-->
				<section class="float_wrap install_notice">
				
					<div class="dim_blue"></div>
					<div class="popup_cont">
						<img src="../images/i_info.png" alt="알림" width="60px" height="auto">
						<p>국민, BC 카드를 이용하여 처음 결제하시는 경우,<br>설치하기를 터치하여 플러그인 설치를 하시기 바랍니다.</p>
					</div>
				
				</section>
				<!--//플러그인 설치안내 popup-->
				
				<section class="float_wrap card_frame">
					<div class="pop_dim"></div>
					<div class="popup card_etc">
						<h3 class="popup_title">카드사 선택</h3>
						<a href="#" class="btn_close pop_close"></a>
						<div class="popup_cont">
							<div class="popup_scroll">
								<div class="card_list2">
									<a href="#">
										<p class="card3">하나(외환)</p>
									</a>
									<a href="#">
										<p class="card14">광주카드</p>
									</a>
									<a href="#">
										<p class="card14">전북카드</p>
									</a>
									<a href="#">
										<p class="card10">수협카드</p>
									</a>
									<a href="#">
										<p class="card15">KDB산업카드</p>
									</a>
									<a href="#">
										<p class="card5">제주카드</p>
									</a>
									<a href="#">
										<p class="card11">신협카드</p>
									</a>
									<a href="#">
										<p class="card21">우체국</p>
									</a>
									<a href="#">
										<p class="card33">저축은행</p>
									</a>
									<a href="#">
										<p class="card22">새마을금고</p>
									</a>
									<a href="#">
										<p class="card30">케이뱅크</p>
									</a>
									<a href="#">
										<p class="card31">카카오뱅크</p>
									</a>
									<a href="#">
										<p class="card16">해외비자</p>
									</a>
									<a href="#">
										<p class="card17">해외마스터</p>
									</a>
									<a href="#">
										<p class="card20">해외JCB</p>
									</a>
									<a href="#">
										<p class="card18">해외다이너스</p>
									</a>
								</div>
							</div>
						</div>
						<div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>
					</div>
				</section>
				<!--popup faq-->
				<section class="float_wrap faq">
					<div class="pop_dim"></div>
					<div class="popup">
						<h3 class="popup_title">결제 문제해결 / FAQ</h3>
						<a href="#" class="btn_close pop_close"></a>
						<div class="popup_cont">
							<div class="popup_scroll">
								<div class="popup_scroll_in">
									<div class="tab_wrap">
										<ul>
											<li><a href="#" class="on">결제오류<br>해결방법</a></li>
											<li><a href="#">일반결제<br>(ISP)<br>결제 FAQ </a></li>
											<li><a href="#">일반결제<br>(안심클릭)<br>결제 FAQ</a></li>
									    </ul>
									</div>
									<div class="tab_con_wrap">
										<div class="tab_con ac_toggles">
											<div class="ac_toggle">
												<h3><a href="#">웹브라우저의 팝업차단 해제</a><i class="icon-plus-sign"></i></h3>
												<div>
													<div>
														<p>
															이노페이의 결제창은 팝업으로 서비스가 제공 됩니다. 따라서 상점에서 구매하기 또는 결제하기 버튼 선택 후 이노페이 전자결제 결제창이 보이지 않는 경우 고객님의 이용하시는 웹브라우저의 팝업차단 기능을 해제하시기 바랍니다.
														</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3><a href="#">웹브라우저의 캐시, 쿠키 등의 삭제</a><i class="icon-plus-sign"></i></h3>
												<div>
													<div>
														<p>
															이노페이의 기존 버전의 쿠키를 실행하는 경우 결제오류가 발생할 수 있습니다. 따라서 웹브라우저의 임시파일, 열어본 페이지 목록, 캐시, 쿠키 정보를 삭제 후 다시 시도해 보시기 바랍니다.
														</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3><a href="#">세션오류 해결방법</a><i class="icon-plus-sign"></i></h3>
												<div>
													<h4>발생사유: 서버와 단말(PC, 스마트기기)간 통신연결이 일시적으로 끊기는 경우</h4>
													<div>
														<p class="title">스마트기기의 경우</p>
														<p>1. 인터넷 설정에서 캐시 및 쿠키 삭제</p>
														<p>2. 어플 다운받아서 진행 시 어플 삭제/부팅후 어플 재다운받아 결제합니다.</p>
														<p>3. Wifi 사용시 LTE로 변경 후 진행합니다.</p>
														<p>4. 네이버나 다음 어플에서 사이트 검색해서 이용 중인 경우, 인터넷 기본브라우저 또는 크롬브라우저 실행 후 인터넷 주소창에 결제사이트 주소를 바로 입력해서 결제를 진행합니다.</p>
													</div>
													<div>
														<p class="title">PC의 경우</p>
														<p>1. 인터넷 설정에서 쿠키 및 캐시 파일을 삭제합니다.</p>
														<p>2. 바이러스프로그램(알약,V3,툴바 등) 종료 및 호환성보기설정()</p>
														<p>3. 위 내용 진행 시에도 동일 현상 시 30분 후 재결제를 진행합니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3><a href="#">OTP 및 보안카드 입력오류 해결방법</a><i class="icon-plus-sign"></i></h3>
												<div>
													<h4>발생사유: 입력한 정보(인증수단의 일련번호 등)이 은행의 정보와 일치하지 않은 경우</h4>
													<div>
														<p class="title">일련번호확인 방법</p>
														<p>1. 보안카드 : 보안카드 NO라고 적혀있는 숫자 중(전체 자릿수 상관없이)끝4자리입력</p>
														<p>2. OTP :OTP 뒷면의 S/N으로 시작하는 숫자 중(전체 자릿수 상관없이) 끝4자리</p>
														<p class="s_text">기계에 S/N넘버가 없을 시 케이스에서 확인해야 합니다.</p>
														<p class="s_text">일회용비밀번호는 OTP기계앞면 숫자 6자리 입니다.</p>
													</div>
													<div>
														<p class="title">보안매체정보(일련번호, OTP번호 등)를 정확히 입력 및 재설치 후에도 동일현상 발생 시 은행에 문의합니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3><a href="#">신용카드 결제실패 해결방법</a><i class="icon-plus-sign"></i></h3>
												<div>
													<div>
														<p class="title">ISP 계열(국민/비씨 카드, 카드 앞면에 BC 문구 있음)</p>
														<p>1. ISP모듈설치 실패: www.vp.co.kr 접속 - 일반결제ISP+수동설치 메뉴 클릭 후 수동설치</p>
														<p>2. 키보드보안프로그램 설치 오류발생</p>
														<p class="s_text">제어판->프로그램기능(프로그램추가/제거)클릭</p>
														<p class="s_text">ToucheEn Key with E2E for 32bit / SoftCamp Secure KeyStroke 4.0 삭제 후 재설치</p>

														<p>3. 웹페이지 표기불가</p>
														<p class="s_text">웹브라우저의 쿠키 및 캐시 삭제</p>
														<p class="s_text">인터넷 익스프롤러의 경우 도구 - 호환성보기설정 - 사이트( https://pg.innopay.co.kr / 결제하는 사이트) 추가</p>
														
														<p>4. 문제해결 실패 시 ISP고객센터(1577-3033번)로 문의</p>
													</div>
													<div>
														<p class="title">안심클릭 계열(삼성, 롯데, 현대, 신한 등 국민/비씨를 제외한 카드)</p>
														<p>1. 카드번호 등 입력 실패, 인증서 호출 실패 등</p>
														<p class="s_text">각 카드사별 보안프로그램 설치</p>
														<p class="s_text">동일현상 발생 시 카드사 문의</p>
														
														<p>2. 웹페이지 표기불가</p>
														<p class="s_text">웹브라우저의 쿠키 및 캐시 삭제</p>
														<p class="s_text">인터넷 익스프롤러의 경우 도구 - 호환성보기설정 - 사이트( https://pg.innopay.co.kr / 결제하는 사이트) 추가</p>
														
														<p>3. 문제해결 실패 시 각 카드사 고객센터로 문의</p>
													</div>
												</div>
											</div>
										</div>
										<div class="tab_con ac_toggles">
											<div class="ac_toggle">
												<h3 class="question"><a href="#">일반결제 ISP 서비스는 어디에서 신청하나요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>1. 브이피(주) 웹사이트에서 신청하실 수 있습니다. <a href="http://service.vp.co.kr/index.vp" class="text_link" target="_blank">ISP 신청 바로가기 ></a></p>
														<p>2. 쇼핑몰 등에서 결제 시 나타나는 일반결제(ISP) 결제창에서 신청하실 수 있습니다.</p>
														<p>3. 비씨카드 , KB국민카드 홈페이지의 안전결제(ISP) 서비스 신청페이지에서 신청하실 수 있습니다.</p>
														<p class="ex_text">*일반결제(ISP) 서비스 신청완료 즉시 모든 서비스를 이용할 수 있습니다.</p>
													</div>
													<div class="img_area">
														<p>1단계: 카드사 선택</p>
														<img src="../images/isp_1.png">
													</div>
													<div class="img_area">
														<p>2단계: 일반결제(ISP) 선택</p>
														<img src="../images/isp_2.png">
													</div>
													<div class="img_area">
														<p>3단계: 등록 선택</p>
														<img src="../images/isp_3.png">
													</div>
													<div class="img_area">
														<p>4단계: 카드정보 입력</p>
														<img src="../images/isp_4.png">
													</div>
													<div class="img_area">
														<p>5단계: 약관동의</p>
														<img src="../images/isp_5.png">
													</div>
													<div class="img_area">
														<p>6단계: 본인인증</p>
														<img src="../images/isp_6.png">
													</div>
													<div class="img_area">
														<p>7단계: 결제비밀번호 설정</p>
														<img src="../images/isp_7.png">
													</div>
													<div class="img_area">
														<p>8단계: 완료</p>
														<img src="../images/isp_8.png">
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">일반결제 ISP 서비스를 신청할때 본인인증은 어떻게 하나요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>신용카드 명의자의 공인인증서 또는 휴대폰으로 본인인증을 하셔야 합니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">일반결제 ISP 결제진행은 어떻게 하나요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div class="img_area">
														<p>1단계: 할부기간 선택</p>
														<img src="../images/isp_11.png">
													</div>
													<div class="img_area">
														<p>2단계: 이용매체 선택</p>
														<img src="../images/isp_12.png">
													</div>
													<div class="img_area">
														<p>3단계: 결제할 카드 선택</p>
														<img src="../images/isp_13.png">
													</div>
													<div class="img_area">
														<p>4단계: 일반결제 ISP 비밀번호 입력</p>
														<img src="../images/isp_9.png">
													</div>
													<div class="img_area">
														<p>5단계: 결제요청 완료</p>
														<img src="../images/isp_10.png">
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">일반결제 ISP 비밀번호가 무엇인가요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>일반결제(ISP) 비밀번호는 비씨카드, KB국민카드, 우리카드, 저축은행카드, 산업은행카드, 신협카드, 우체국카드, 새마을금고카드, 수협카드, 전북카드, 광주카드, 제주카드 이용 고객들을 위한 신용카드인증서 비밀번호입니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">일반결제 ISP 비밀번호를 잊었거나 변경하려면 어떻게 해야 하나요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>일반결제 ISP 비밀번호는 본인 외에는 아무도 알지 못하므로 기존에 등록된 카드를 삭제 후 새로 카드등록 하셔야 합니다.</p>
													</div>
													<div class="img_area">
														<p>1단계: 카드 삭제 선택</p>
														<img src="../images/isp_14.png">
													</div>
													<div class="img_area">
														<p>2단계: 카드 삭제 확인</p>
														<img src="../images/isp_15.png">
													</div>
													<div class="img_area">
														<p>3단계: 카드 등록</p>
														<img src="../images/isp_3.png">
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">일반결제 ISP 비밀번호가 틀렸다거나 입력되지 않는 경우에는 어떻게 해야 하나요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>우선 고객님이 입력한 일반결제 ISP 비밀번호 대소문자 구분이 되어있는지 확인하시기 바랍니다. 일반결제 ISP 비밀번호를 정확하게 입력하였는데 계속 틀렸다고 나오거나, 키보드 입력이 되지 않는 경우는 키보드보안 프로그램의 충돌이 의심됩니다.</p>
														<p class="title">이럴 경우 다음과 같이 해결할 수 있습니다.</p>
														<p>1. 소프트캠프 홈페이지 <a href="http://www.softcamp.co.kr/scsk" class="text_link" target="_blank">http://www.softcamp.co.kr/scsk</a>에 접속 하십시오.</p>
														<p>2. "제품 설치/삭제"를 클릭 하십시오.</p>
														<p>3. "9. 수동설치"를 클릭하셔서 수동 설치 하십시오.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">일반결제 ISP 고객센터 전화번호는 어떻게 되나요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>ISP에 대한 모든 문의는 <a href="tel:15773033" class="text_link">브이피(주) 1577-3033</a>로 문의 바랍니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">일반결제 ISP 결제시 공인인증서가 필요하나요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>일반결제(ISP) 서비스를 이용함에 있어서 1회 결제금액이 30만원 미만인 경우에는 공인인증서가 필요하지 않습니다. 그러나, 1회 30만원 이상 결제하는 경우, 반드시 카드소지자 본인의 공인인증서가 필요합니다. 또한 30만원 이상 결제하는 경우, ARS인증이 추가 됩니다.</p>
														<p class="ex_text">* 공인인증서가 없을 경우, 가까운 은행을 방문하여 공인인증서를 신청하시기 바랍니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">모바일간편결제 ISP 서비스란 무엇인가요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>일반결제(ISP) 서비스의 모바일 버전으로써 고객님의 휴대폰으로 일반결제(ISP) 서비스를 프로그램 (VM, App)을 다운 받아서 인터넷은 물론 휴대폰을 통해서 ISP를 편리하고 안전하게 이용하실 수 있는 서비스입니다.</p>
														<p><a href="http://www.vp.co.kr/home/sub01_001_0002.html#howtouse" class="text_link" target="_blank">모바일간편결제 ISP 이용안내 ></a></p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">모바일간편결제 ISP 서비스는 어떻게 신청하나요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>1. 브이피(주) 웹사이트에서 신청하실 수 있습니다.</p>
														<p>2. 쇼핑몰 등에서 결제시 나타나는 일반결제(ISP) 결제창 또는 비씨카드, KB카드 홈페이지에서 신청하실 수 있습니다.</p>
													</div>
													<div>
														<p class="title">모바일간편결제(ISP) 서비스 신청단계</p>
														<p>1. 카드번호 및 이메일 입력</p>
														<p>2. 모바일간편결제(ISP) 약관동의 및 카드비밀번호 등 입력</p>
														<p>3. 모바일간편결제(ISP) 비밀번호 등록</p>
														<p>4. "휴대폰"을 저장위치 선택</p>
														<p>5. 휴대폰번호 입력 → 해당 휴대폰으로 SMS메시지가 전송</p>
														<p>6. 휴대폰에서 모바일간편결제(ISP) 서비스 가입 신청 → 프로그램(VM/App) 다운로드</p>
														<p>7. 휴대폰의 모바일간편결제(ISP) 서비스 메뉴에서 ISP서비스 신청</p>
														<p>8. 모바일간편결제(ISP) 서비스 신청 완료</p>
														<p class="ex_text">* 모바일간편결제(ISP) 신청 완료 즉시 모든 서비스를 이용할 수 있습니다.</p>
													</div>
												</div>
											</div>
										</div>
										<div class="tab_con ac_toggles">
											<div class="ac_toggle">
												<h3 class="question"><a href="#">결제하기를 눌렀는데 QR코드 또는 숫자만 보여요. 카드번호 입력하는 방식으로는 처리가 안되나요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>앱카드[간편결제] 방식의 결제하기를 클릭하신 경우입니다. 하단의 결제 하기 버튼을 통해 일반결제(안심클릭)로 진행 부탁 드립니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">앱카드 [간편결제]는 무엇인가요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>카드사에서 제공하는 결제 방식으로 QR코드 앱카드 을 통해 결제하는 형식입니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">Smart 결제는 무엇인가요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>카드사에 결제정보를 등록 하신 후 가입하신 ID와 주민등록번호 뒷자리로 결제하는 방식입니다. 가입을 하지 않으셨다면 일반결제(안심클릭)으로 진행 부탁 드립니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">일반결제(안심클릭)이 무엇인가요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>도용 방지를 위한 보안서비스로 카드번호, 안심클릭 비밀번호와 CVC/4DBC(카드 뒷면의 끝 3자리) 또는 공인인증서로 본인확인 후 결제하는 방식입니다.</p>
														<p class="ex_text">* 전자상거래 결제 간편화 및 Active-X 해결 방안(2014.09.23)에 따라 2014년 10월 15일부터 안심클릭의 명칭이 일반결제로 변경 됨</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">일반결제(안심클릭) 비밀번호는 어떤것을 입력하면 되나요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>카드비밀번호 숫자 4자리가 아닌 온라인결제 서비스 이용하여 결제하실 경우 사용하게 될 비밀번호를 입력하여 주시기 바랍니다. 일반결제(안심클릭)서비스를 등록하지 않으신경우, 카드사의 안심클릭창에서 제공하는 일반결제(안심클릭)등록화면을 통해 등록 하시거나 카드사 홈페이지 또는 카드사 고객센타로 문의 바랍니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">일반결제(안심클릭) 비밀번호를 분실했어요.</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>비밀번호를 분실하신경우 비밀번호 변경등록 후 이용하여 주시기 바랍니다. 카드사 일반결제(안심클릭)화면에서 비밀번호 재등록/일반결제(안심클릭) 재등록 화면이 확인되지 않으신 경우 카드사 홈페이지 또는 카드사 고객센타로 문의 바랍니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">일반결제(안심클릭) 서비스 등록화면에서 개인 메세지는 어떤 부분을 입력하는 건가요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>일반결제(안심클릭) 결제 진행단계에서 카드소유주가 확인는 메세지 표시 부분입니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">카드로 결제 하는데 공인인증서가 필요하네요?</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>30만원 이상 결제 시 공인인증서 인증은 필수 입니다.</p>
														<p class="ex_text">* 카드사별로 기준이 다를 수 있습니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">카드번호 입력 후 계속 다시 입력하라고 나와요.</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>카드 앞면에 비씨마크가 있는 경우는 비씨카드(ISP)를 선택하여 결제를 진행하여 주시기 바랍니다.</p>
													</div>
												</div>
											</div>
											<div class="ac_toggle">
												<h3 class="question"><a href="#">카드사 선택 후 다음화면에서 결제창이 하얗게 나와요.</a><i class="icon-plus-sign"></i></h3>
												<div class="answer">
													<div>
														<p>키보드 및 보안 프로그램의 오류 및 충돌로 인한 문제이므로, 보안프로그램 삭제 후 재설치</p>
														<p>1. PC에서 인터넷 익스플로러를 종료</p>
														<p>2. PC 왼쪽하단부 시작버튼 클릭 → 제어판 클릭 → 프로그램 추가/삭제 클릭→ 'TouchEn key with E2E'을 삭제함 → XecureWeb 프로그램도 삭제</p>
														<p class="ex_text">*  경우에 따라 nProtect KeyCrypt / nProtect Netizen Ver.3(remove only) 및 nProtect Netizen (remove only)도 삭제 필요</p>
														<p class="ex_text">* Internet explorer 11버전 이용하시는 경우는 Internet explorer 상단 - 도구 - 호환성보기 설정 - 결제 진행하시는 사이트 및 카드사 사이트 추가 후 하단의 항목 모두 체크 후 재진행</p>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>	
						<div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>				
					</div>
		</div>
	<!-- 카카오페이 응답 파라미터-->
<form name="MainForm" method="post">
	<input type="hidden" name="TID"             value="<%=TID%>"/>
	<input type="hidden" name="storeid"    		value="<%=Kakao_Key%>">
	<input type="hidden" name="tid"	            value="">                   <!-- 카카오페이 TID -->
	<input type="hidden" name="cid"	            value="">
	<input type="hidden" name="xid"        		value="">                   <!-- 카카오페이 결제승인 토큰 -->
	<input type="hidden" name="MID"    			value="<%=MID%>">
	<input type="hidden" name="svcPrdtCd"       value="<%=svcPrdtCd%>">
	<input type="hidden" name="formBankCd"      value=""/>
	<input type="hidden" name="svcCd"      		value="<%=svcCd%>">
	<input type="hidden" name="TID"             value="<%=TID%>"/>
	<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/>
	<input type="hidden" name="MallReserved"    value="<%=MallReserved%>"/>
	<input type="hidden" name="mallUserID"      value="<%=mallUserID%>"/>
	<input type="hidden" name="ediDate"         value="<%=ediDate%>">
	<input type="hidden" name="EncryptData"     value="<%=EncryptData%>">
	<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
	<input type="hidden" name="BuyerEmail"		value="<%=BuyerEmail%>">           <!-- 이메일 -->
	<input type="hidden" name="BuyerTel"		value="<%=BuyerTel%>">           <!-- 연락처 -->
	<input type="hidden" name="Moid"			value="<%=Moid %>">           <!-- 주문번호 -->
	<input type="hidden" name="BuyerName"		value="<%=BuyerName %>">           <!-- 주문자명 -->
	<input type="hidden" name="GoodsName"		value="<%=GoodsName %>">           <!-- 상품명 -->
	<input type="hidden" name="Amt"				value="<%=Amt%>">           <!-- 결제금액 -->
	<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
	<input type="hidden" name="ResultYN"        value="<%=ResultYN%>"/>
	<input type="hidden" name="RetryURL"        value="<%=RetryURL%>"/>
	<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/> 
	<input type="hidden" name="MallIP"			value="<%=MallIP %>">
	<input type="hidden" name="UserIP"          value="<%=UserIP%>">  
	<input type="hidden" name="EncodingType"    value="<%=EncodingType%>"/>
	<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
	<input type="hidden" name="EPayCl"          value="01">
	<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
	<input type="hidden" name="FORWARD"         value="<%=FORWARD%>"/>
	<input type="hidden" name="Currency"        value="<%=Currency%>"/>
	<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
	<input type="hidden" name="PayMethod"       value="<%=PayMethod%>"/>
	<input type="hidden" name="CardInterest"    value="<%=CardInterest%>"/>
	<input type="hidden" name="device"          value="<%=device%>"/>
	<input type="hidden" name="OfferingPeriod"  value="<%=OfferingPeriod%>"/>
</form>

<!-- lpay 응답 파라미터-->
<form name="lpayForm"  method="post" id="lpayForm">
	<input type="hidden" name="sndStoreid"    	value="<%=Lpay_Key%>">           <!-- 상점아이디 -->
	<input type="hidden" name="sndEmail"		value="<%=BuyerEmail%>">           <!-- 이메일 -->
	<input type="hidden" name="sndMobile"		value="<%=BuyerTel%>">           <!-- 연락처 -->
	<input type="hidden" name="sndOrdernumber"	value="<%=Moid %>">           <!-- 주문번호 -->
	<input type="hidden" name="sndOrdername"	value="<%=BuyerName %>">           <!-- 주문자명 -->
	<input type="hidden" name="sndGoodname"		value="<%=GoodsName %>">           <!-- 상품명 -->
	<input type="hidden" name="sndAmount"		value="<%=Amt%>">           <!-- 결제금액 -->
	<input type="hidden" name="sndReply"    	value="" >          <!-- returnUrl -->
	<input type="hidden" name="sndCharset"      value="" >          <!-- 가맹점 charset -->
	<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/>		
	<input type="hidden" name="svcPrdtCd"   	value="<%=svcPrdtCd%>">
	<input type="hidden" name="MID"    			value="<%=MID%>">
	<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/> 
	<input type="hidden" name="svcCd"      		value="<%=svcCd%>">
	<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
	<input type="hidden" name="TID"             value="<%=TID%>"/>
	<input type="hidden" name="MallReserved"    value="<%=MallReserved%>"/>
	<input type="hidden" name="MallIP"			value="<%=MallIP %>">
	<input type="hidden" name="UserIP"          value="<%=UserIP%>">  
	<input type="hidden" name="ediDate"         value="<%=ediDate%>">
	<input type="hidden" name="EncryptData"     value="<%=EncryptData%>">
	<input type="hidden" name="BuyerEmail"		value="<%=BuyerEmail%>">           <!-- 이메일 -->
	<input type="hidden" name="BuyerTel"		value="<%=BuyerTel%>">           <!-- 연락처 -->
	<input type="hidden" name="Moid"			value="<%=Moid %>">           <!-- 주문번호 -->
	<input type="hidden" name="BuyerName"		value="<%=BuyerName %>">           <!-- 주문자명 -->
	<input type="hidden" name="GoodsName"		value="<%=GoodsName %>">           <!-- 상품명 -->
	<input type="hidden" name="Amt"				value="<%=Amt%>">           <!-- 결제금액 -->
	<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
	<input type="hidden" name="ResultYN"        value="<%=ResultYN%>"/>
	<input type="hidden" name="RetryURL"        value="<%=RetryURL%>"/>
	<input type="hidden" name="mallUserID"      value="<%=mallUserID%>"/>
	<input type="hidden" name="MallIP"			value="<%=MallIP %>">  
	<input type="hidden" name="EncodingType"    value="<%=EncodingType%>"/>
	<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
	<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
	<input type="hidden" name="FORWARD"         value="<%=FORWARD%>"/>
	<input type="hidden" name="Currency"        value="<%=Currency%>"/>
	<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
	<input type="hidden" name="PayMethod"       value="<%=PayMethod%>"/>
	<input type="hidden" name="User_ID"         value="<%=User_ID%>"/>
	<input type="hidden" name="CardInterest"    value="<%=CardInterest%>"/>
	<input type="hidden" name="device"    		value="<%=device%>">
	<input type="hidden" name="OfferingPeriod"  value="<%=OfferingPeriod%>"/>
</form>

<!-- 페이코 응답 파라미터 -->
<form name="paycoForm"  method="post" id="paycoForm">
	<input type="hidden" name="sndStoreid"    	value="<%=Payco_Key%>">
	<input type="hidden" name="sndEmail"		value="<%=BuyerEmail%>">
	<input type="hidden" name="sndMobile"		value="<%=BuyerTel%>">
	<input type="hidden" name="sndOrdernumber"	value="<%=Moid %>">
	<input type="hidden" name="sndOrdername"	value="<%=BuyerName %>">
	<input type="hidden" name="sndGoodname"		value="<%=GoodsName %>">
	<input type="hidden" name="sndStorename"    value="<%=co_nm%>">
	<input type="hidden" name="sndAmount"		value="<%=Amt%>">
	<input type="hidden" name="device"    	  	value="<%=device %>" >
	<input type="hidden" name="sndReply"    	value="" >                 <!-- returnUrl -->
	<input type="hidden" name="sndCharset"      value="" >                 <!-- 가맹점 charset -->	
	<input type="hidden" name="svcPrdtCd"       value="<%=svcPrdtCd%>">
	<input type="hidden" name="MID"    			value="<%=MID%>">
	<input type="hidden" name="svcCd"      		value="<%=svcCd%>">
	<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
	<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/>
	<input type="hidden" name="PayMethod"       value="<%=PayMethod%>"/>
	<input type="hidden" name="TID"             value="<%=TID%>"/>
	<input type="hidden" name="mallUserID"      value="<%=mallUserID%>"/>
	<input type="hidden" name="MallReserved"    value="<%=MallReserved%>"/>
	<input type="hidden" name="ediDate"         value="<%=ediDate%>">
	<input type="hidden" name="EncryptData"     value="<%=EncryptData%>">
	<input type="hidden" name="BuyerEmail"		value="<%=BuyerEmail%>">           <!-- 이메일 -->
	<input type="hidden" name="BuyerTel"		value="<%=BuyerTel%>">           <!-- 연락처 -->
	<input type="hidden" name="Moid"			value="<%=Moid %>">           <!-- 주문번호 -->
	<input type="hidden" name="BuyerName"		value="<%=BuyerName %>">           <!-- 주문자명 -->
	<input type="hidden" name="GoodsName"		value="<%=GoodsName %>">           <!-- 상품명 -->
	<input type="hidden" name="Amt"				value="<%=Amt%>">           <!-- 결제금액 -->
	<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
	<input type="hidden" name="ResultYN"        value="<%=ResultYN%>"/>
	<input type="hidden" name="RetryURL"        value="<%=RetryURL%>"/>
	<input type="hidden" name="EncodingType"    value="<%=EncodingType%>"/>
	<input type="hidden" name="MallIP"			value="<%=MallIP %>">
	<input type="hidden" name="UserIP"          value="<%=UserIP%>">  
	<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
	<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
	<input type="hidden" name="FORWARD"         value="<%=FORWARD%>"/>
	<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
	<input type="hidden" name="User_ID"         value="<%=User_ID%>"/>
	<input type="hidden" name="Currency"        value="<%=Currency%>"/>
	<input type="hidden" name="CardInterest"    value="<%=CardInterest%>"/>
	<input type="hidden" name="bizno"    		value="<%=co_no %>"/>
	<input type="hidden" name="rtapp"    		value=""/>
	<input type="hidden" name="OfferingPeriod"  value="<%=OfferingPeriod%>"/>
</form>
<!-- SSG 응답 파라미터 -->
<form name=ssgFrm method=post>
	<input type="hidden" name="storeid"        		value="<%=Ssg_Key%>">
	<input type="hidden" name="email"          		value="<%=BuyerEmail%>">
	<input type="hidden" name="MID"    				value="<%=MID%>">
	<input type="hidden" name="svcPrdtCd"      		value="<%=svcPrdtCd%>">
	<input type="hidden" name="TID"             	value="<%=TID%>"/>
	<input type="hidden" name="MallReserved"    	value="<%=MallReserved%>"/>
	<input type="hidden" name="ediDate"        		value="<%=ediDate%>">
	<input type="hidden" name="EncryptData"    		value="<%=EncryptData%>">
	<input type="hidden" name="ReturnURL"       	value="<%=ReturnURL%>"/>
	<input type="hidden" name="BuyerEmail"			value="<%=BuyerEmail%>">
	<input type="hidden" name="PayMethod"       	value="<%=PayMethod%>"/> 
	<input type="hidden" name="BuyerTel"			value="<%=BuyerTel%>">
	<input type="hidden" name="CardQuota"           value="" >
	<input type="hidden" name="OrderCode"    		value="<%=OrderCode%>">
	<input type="hidden" name="BuyerName"			value="<%=BuyerName %>">
	<input type="hidden" name="GoodsName"			value="<%=GoodsName %>"> 
	<input type="hidden" name="GoodsCnt"        	value="<%=GoodsCnt%>"/>
	<input type="hidden" name="ResultYN"        	value="<%=ResultYN%>"/>
	<input type="hidden" name="RetryURL"        	value="<%=RetryURL%>"/>
	<input type="hidden" name="ReturnURL"        	value="<%=ReturnURL%>"/>
	<input type="hidden" name="MallIP"				value="<%=MallIP %>">
	<input type="hidden" name="UserIP"          	value="<%=UserIP%>">  
	<input type="hidden" name="TaxAmt"          	value="<%=TaxAmt%>"/>
	<input type="hidden" name="Amt"         		value="<%=Amt%>">
	<input type="hidden" name="Moid"				value="<%=Moid %>">         
	<input type="hidden" name="svcCd"      			value="<%=svcCd%>">
	<input type="hidden" name="DutyFreeAmt"    	 	value="<%=DutyFreeAmt%>"/>
	<input type="hidden" name="User_ID"        	 	value="<%=User_ID%>"/>
	<input type="hidden" name="device"    			value="<%=device%>">
	<input type="hidden" name="sndCertitype"    	value="">
	<input type="hidden" name="OfferingPeriod"   	value="<%=OfferingPeriod%>"/>
</form>
<form name=NAVERPayAuthForm method=post>
<!--기본-------------------------------------------------------------->
	<input type="hidden" name="sndStoreid"    	value="<%=Naver_Key%>">           <!-- 상점아이디 -->
	<input type="hidden" name="sndEmail"		value="<%=BuyerEmail%>">           <!-- 이메일 -->
	<input type="hidden" name="sndMobile"		value="<%=BuyerTel%>">           <!-- 연락처 -->
	<input type="hidden" name="sndOrdernumber"	value="<%=Moid %>">           <!-- 주문번호 -->
	<input type="hidden" name="sndOrdername"	value="<%=BuyerName %>">           <!-- 주문자명 -->
	<input type="hidden" name="sndStorename"    value="<%=co_nm%>" >       <!-- 가맹점명 -->
	<input type="hidden" name="sndGoodname"		value="<%=GoodsName %>">           <!-- 상품명 -->
	<input type="hidden" name="sndAmount"		value="<%=Amt%>">           <!-- 결제금액 -->
	<input type="hidden" name="sndReply"    	value="" >          <!-- returnUrl -->
	<input type="hidden" name="sndCharset"      value="" >          <!-- 가맹점 charset -->		
	<input type="hidden" name="svcPrdtCd"   	value="<%=svcPrdtCd%>">
	<input type="hidden" name="MID"    			value="<%=MID%>">
	<input type="hidden" name="svcCd"      		value="<%=svcCd%>">
	<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
	<input type="hidden" name="TID"             value="<%=TID%>"/>
	<input type="hidden" name="MallReserved"    value="<%=MallReserved%>"/>
	<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/>
	<input type="hidden" name="ediDate"         value="<%=ediDate%>">
	<input type="hidden" name="EncryptData"     value="<%=EncryptData%>">
	<input type="hidden" name="BuyerEmail"		value="<%=BuyerEmail%>">           <!-- 이메일 -->
	<input type="hidden" name="BuyerTel"		value="<%=BuyerTel%>">           <!-- 연락처 -->
	<input type="hidden" name="Moid"			value="<%=Moid %>">           <!-- 주문번호 -->
	<input type="hidden" name="BuyerName"		value="<%=BuyerName %>">           <!-- 주문자명 -->
	<input type="hidden" name="GoodsName"		value="<%=GoodsName %>">           <!-- 상품명 -->
	<input type="hidden" name="Amt"				value="<%=Amt%>">           <!-- 결제금액 -->
	<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
	<input type="hidden" name="ResultYN"        value="<%=ResultYN%>"/>
	<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/>
	<input type="hidden" name="RetryURL"        value="<%=RetryURL%>"/>
	<input type="hidden" name="mallUserID"      value="<%=mallUserID%>"/>
	<input type="hidden" name="EncodingType"    value="<%=EncodingType%>"/>
	<input type="hidden" name="PayMethod"       value="<%=PayMethod%>"/>
	<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
	<input type="hidden" name="User_ID"         value="<%=User_ID%>"/>
	<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
	<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
	<input type="hidden" name="FORWARD"         value="<%=FORWARD%>"/>
	<input type="hidden" name="Currency"        value="<%=Currency%>"/>
	<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
	<input type="hidden" name="MallIP"			value="<%=MallIP %>">
	<input type="hidden" name="UserIP"          value="<%=UserIP%>">  
	<input type="hidden" name="CardInterest"    value="<%=CardInterest%>"/>
	<input type="hidden" name="device"    		value="<%=device%>">
	<input type="hidden" name="sndCertitype"    value="">
	<input type="hidden" name="OfferingPeriod"  value="<%=OfferingPeriod%>"/>
<!-- 네이버페이 변수 -->
	<input type="hidden" name="EPayCl"          value="04">
	<INPUT TYPE="hidden" NAME="certitype" 		value="2">
</form>

	</body>
 
</html>