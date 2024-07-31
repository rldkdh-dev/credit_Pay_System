<%
/******************************************************************************
*
*	@ SYSTEM NAME       : PG 수기,인증결제 연동페이지
*   @ PROGRAM NAME      : interfaceCardURL.jsp
*   @ MAKER             : InnopayPG
*   @ MAKE DATE         : 2017.09.08
*   @ PROGRAM CONTENTS  : PG 수기,인증결제 연동페이지
*
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="mobile.CardSms"%>
<%@ page import="kr.co.infinisoft.pg.common.StrUtils"%>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="mobile.MMSUtil"%>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%@ page import="java.net.InetAddress" %>
<%
	request.setCharacterEncoding("utf-8");
	// parameter check
	String OrderCode = CommonUtil.getDefaultStr(request.getParameter("OrderCode"), "");
	boolean errorCheck = false; //true:오류 / false:정상
	String resultCode = null;
	String resultMsg = null;
	
	Box orderInfo = new Box();
	String CoNm				= "";
	String TelNo        	= "";
	String GoodsName    	= "";
	String AddrNo       	= "";
	String Image        	= "";
	String BuyerName		= "";
	String BuyerTel			= "";
	String DeliveryYn		= "";
	String ZoneCode 		= "";
	String Address			= "";
	String AddressDetail	= "";
	String GoodsCnt			= "";
	String Amt				= "";
	// 2019.04 과세 면세 필드 추가
	String TaxAmt			= "";	// 과세금액
	String DutyFreeAmt		= "";	// 면세금액
	String Moid				= "";
	String Mid				= "";
	String BuyerEmail		= "";
	String ShopLicenseKey	= "";
	String DeliverySeq		= "";
	String InformWay		= "";
	String Step				= "";
	String ExpireYn			= "";
	String UserId           = "";
	String PgMid            = "";
	String SvcCd            = "";
	String SvcPrdtCd        = "";
	String LimitInstmn		= "";
	String AuthFlg			= "";
	String JoinType			= "";
	String TID				= "";
	String BuyerCode    	= "";
	String PgKeyInCl	    = "";
	String PgCode           = "";   // PG사 코드(블루월넛 때문에 추가)
	String Aid           	= "";
	String PgCd           	= "";
	
	boolean ExpireStatus = false;
	
	//OrderCode 존재여부 확인
	if(StringUtils.isEmpty(OrderCode)){
		 //OrderCode 미존재
		errorCheck = true;
		resultMsg = "주문코드가 존재하지 않습니다.";
	}else{
		 //OrderCode 존재 -> 존재 시 주문정보 조회
		 orderInfo = CardSms.selectConfOrderInfo(OrderCode);
		 System.out.println("order.jsp orderInfo :: " + orderInfo.toString());
		 
		 resultCode = orderInfo.getString("ResultCode");
		 resultMsg = orderInfo.getString("ResultMsg");
		 
		 if("0000".equals(resultCode)){
			//주문정보 존재
			
			CoNm			=  orderInfo.getString("MID_NM")==null?"":orderInfo.getString("MID_NM");
			GoodsName 		=  orderInfo.getString("GOODS_NAME")==null?"":orderInfo.getString("GOODS_NAME");
			TelNo 			=  orderInfo.getString("TEL_NO")==null?"":orderInfo.getString("TEL_NO");
			AddrNo			=  (orderInfo.getString("ADDR_NO1")==null?"":orderInfo.getString("ADDR_NO1")) + " " + (orderInfo.getString("ADDR_NO2")==null?"":orderInfo.getString("ADDR_NO2"));
			BuyerName 		=  orderInfo.getString("BUYER_NAME")==null?"":orderInfo.getString("BUYER_NAME");
			BuyerTel 		=  orderInfo.getString("BUYER_CELLPHONE_NO")==null?"":orderInfo.getString("BUYER_CELLPHONE_NO");
			DeliveryYn 		=  orderInfo.getString("DEV_ADDR_CL")==null?"":orderInfo.getString("DEV_ADDR_CL");
			ZoneCode 		=  orderInfo.getString("zone_code")==null?"":orderInfo.getString("zone_code");
			Address 		=  orderInfo.getString("address")==null?"":orderInfo.getString("address");
			AddressDetail 	=  orderInfo.getString("address_detail")==null?"":orderInfo.getString("address_detail");
			GoodsCnt		=  orderInfo.getString("GoodsCnt")==null?"":orderInfo.getString("goods_cnt");
			Amt				=  orderInfo.getString("GOODS_AMT")==null?"0":orderInfo.getString("GOODS_AMT");
			TaxAmt			=  orderInfo.getString("GOODS_TAX_AMT")==null?"0":orderInfo.getString("GOODS_TAX_AMT");
			DutyFreeAmt		=  orderInfo.getString("GOODS_DUTY_FREE")==null?"0":orderInfo.getString("GOODS_DUTY_FREE");
			Moid			=  orderInfo.getString("MOID")==null?"":orderInfo.getString("MOID");
			Mid				=  orderInfo.getString("MID")==null?"":orderInfo.getString("MID");
			BuyerEmail		=  orderInfo.getString("BUYER_EMAIL")==null?"":orderInfo.getString("BUYER_EMAIL");
			ShopLicenseKey	=  orderInfo.getString("SHOP_LICENSE_KEY")==null?"":orderInfo.getString("SHOP_LICENSE_KEY");
			DeliverySeq		=  orderInfo.getString("delivery_seq")==null?"":orderInfo.getString("delivery_seq");
			InformWay		=  orderInfo.getString("INFORM_WAY")==null?"":orderInfo.getString("INFORM_WAY");
			Step			=  orderInfo.getString("STEP")==null?"":orderInfo.getString("STEP");
			ExpireYn		=  orderInfo.getString("EXPIRE_YN")==null?"":orderInfo.getString("EXPIRE_YN");
			UserId          =  orderInfo.getString("USER_ID")==null?"":orderInfo.getString("USER_ID");
			PgMid           =  orderInfo.getString("PG_MID")==null?"":orderInfo.getString("PG_MID");
			SvcPrdtCd       =  orderInfo.getString("SVC_PRDT_CD")==null?"":orderInfo.getString("SVC_PRDT_CD"); //03:수기, 04:인증
			SvcCd           =  orderInfo.getString("SVC_CD")==null?"":orderInfo.getString("SVC_CD"); // 01: 카드
			LimitInstmn     =  orderInfo.getString("LIMIT_INSTMN")==null?"00":orderInfo.getString("LIMIT_INSTMN");
			AuthFlg		    =  orderInfo.getString("AUTH_FLG")==null?"":orderInfo.getString("AUTH_FLG");
			JoinType		=  orderInfo.getString("JOIN_TYPE")==null?"":orderInfo.getString("JOIN_TYPE");
			TID				=  orderInfo.getString("TID")==null?"":orderInfo.getString("TID");
			BuyerCode       =  orderInfo.getString("BUYER_CODE")==null?"":orderInfo.getString("BUYER_CODE");
			PgKeyInCl       =  orderInfo.getString("PG_KEY_IN_CL")==null?"":orderInfo.getString("PG_KEY_IN_CL");
			PgCode          =  orderInfo.getString("PG_CODE")==null?"":orderInfo.getString("PG_CODE");
			Aid          	=  orderInfo.getString("AID")==null?"":orderInfo.getString("AID");
			PgCd          	=  orderInfo.getString("PG_CD")==null?"":orderInfo.getString("PG_CD");
			
			if("25".equals(Step)){
				errorCheck = true;
				resultMsg = "이미 결제완료된 주문정보입니다.";
			}else if("85".equals(Step)){
				errorCheck = true;
				resultMsg = "결제 취소된 주문정보입니다.";
			}else if("95".equals(Step)){
				errorCheck = true;
				resultMsg = "주문 취소된 주문정보입니다.";
			}
			
			if("N".equals(ExpireYn)){
				errorCheck = true;
				resultMsg = "유효기간이 경과된 주문정보입니다.";
			}
			
			Image = orderInfo.getString("image", "");
			if (Image == null || Image.equals("")){
				
				Image = orderInfo.getString("image_url", "");
				
				if (Image == null || Image.equals("")){
					Image = "<img src='./images/no_img.png' alt='상품이미지'>";
				}else{
					Image = "<img src='"+Image+"' alt='상품이미지'>";
				}
				
			}else{
				Image = "<img src='data:image/jpeg;base64, "+Image+"' alt='상품이미지'>";	
			}
			// SMS 결제는 PG가 1개라는 가정하에 아래와 같이 처리함
			Box pgInfoBox = new Box();
			pgInfoBox = CardSms.selectSmsPgInfo(Mid, SvcCd, SvcPrdtCd);
			if(pgInfoBox!=null && !pgInfoBox.isEmpty()){
				PgCode = pgInfoBox.getString("PG_CD");
			}
			if("34".equals(PgCode)){
				response.sendRedirect("./interfaceBWURL.jsp?OrderCode="+OrderCode);
			}
		 }else{
			 //DB 에러 또는 주문정보 미존재
			 errorCheck = true;
		 }
	}
%>
<%
//상점 IP 셋팅 <MallIP 셋팅>
InetAddress inet = InetAddress.getLocalHost();
String payActionUrl = "https://pg.innopay.co.kr";    
String AddressUrl=payActionUrl+"/ipay/addressSearch.jsp";
if (request.getServerPort() == 80 || request.getServerPort() == 443) {
    payActionUrl = request.getScheme() + "://" + request.getServerName() ;
} else {
    payActionUrl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort();
}   
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link href='https://cdn.rawgit.com/theeluwin/NotoSansKR-Hestia/master/stylesheets/NotoSansKR-Hestia.css' rel='stylesheet' type='text/css'>
		
		<script type="text/javascript" src="js/card_conf.js"></script>
		<!-- InnoPay 결제연동 스크립트(필수) -->
		<script type="text/javascript" src="js/innopay-2.0.js"></script>
		<!-- vKeyPad -->
		<script type="text/javascript" src="js/vKeypad.min.js"></script>
		<script type="text/javascript" src="js/kjscrypto.min.js"></script>
		<script type="text/javascript" src="js/kjscrypto_contrib.min.js"></script>
		<link rel="stylesheet" type="text/css" href="common/css/jquery.bxslider.css" />
		<link rel="stylesheet" type="text/css" href="common/css/common.css" />
		<link rel="stylesheet" type="text/css" href='common/css/font.css'>
		<script type="text/javascript" src="common/js/jquery-2.1.4.min.js"></script>
		<script type="text/javascript" src="common/js/jquery.bxslider.js"></script>
  		<script type="text/javascript" src="common/js/jSignature.js"></script>
		<script type="text/javascript" src="common/js/common.js"></script>
		<link rel="shortcut icon" href="images/favicon.ico">
		<script type="text/javascript">
		
			$(document).ready(function(){
				/*레이어 팝업 높이*/
				if ("04"=='<%=SvcPrdtCd%>') { 
					$(".payment_input").css("display","none");
				}
				var popup_scroll_height = function() {return window.innerHeight - 170;}
				$('.popup_scroll').css('height', popup_scroll_height);
				$(window).resize(function() {
					window.innerHeight.refresh;
					popup_scroll_height();
					$('.popup_scroll').css('height', popup_scroll_height);
				});

				/*약관동의 popup 동작*/
				var card_event_top_p = function() {
					if($(".popup.card_event").is(":hidden")){
						    $(".popup.card_event").css("top",popup_top());
							$("a.btn_c_event").click(function(){
							$(".popup.card_event").css("display","block");
							$(".popup.card_event").stop().animate({"top":50},{"duration":300});
							$("body").addClass("dimed");
							$("#wrap").addClass("dim_blur");
							$(".dim").css("display","block");
							$(".btn_close").css("display","block");
							$(".popup_btn_wrap").css("display","block");
						});
					};
				};
								
				$(document).on('click', "a.btn_close", function(){
					$(".popup.conditions_text").stop().animate({"top":popup_top()},300,function(){$(".popup.conditions_text").css("display","none");});
					$(".popup.card_event").stop().animate({"top":popup_top()},300,function(){$(".popup.card_event").css("display","none");});
					$("body").removeClass("dimed");
					$("#wrap").removeClass("dim_blur");
					$(".dim").css("display","none");
					$(".btn_close").css("display","none");
					$(".popup_btn_wrap").css("display","none");
				});
				
				// 카드 종류 별 인증 입력값 변경
				$("#cardType").change(function() {
				    if ($("#cardType option:selected").val() == "02") {
				    	$("#cardTypeLabel").text("사업자등록번호");
				    	$("#biz1").attr("placeholder", "(- 제외 10자리)");
				    	$("#biz1").attr( "maxLength", "10" );
				    	$("#BuyerAuthNum").val("");
				    } else {
				    	$("#cardTypeLabel").text("주민등록번호");
				    	$("#BuyerAuthNum").attr("placeholder", "(앞 6자리)");
				    	$("#BuyerAuthNum").attr( "maxLength", "6" );
				    }
					maxLengthCheck(document.frm.BuyerAuthNum);
				});
				
				setPayActionUrl('<%=payActionUrl%>');
				
				setQuota(); //할부개월 셋팅
				setAuth(); //가맹점 인증 방식별 입력값 셋팅
				// 가상키패드 연동
				checkDevice(frm);
				vKeypadGlobal.setDefaultServletURL('servlets/vKeypad.do');
				vKeypadGlobal.newInstance(frm, frm.card_num1, null, 'NUMBERPAD_type1');
				vKeypadGlobal.newInstance(frm, frm.card_num2, null, 'NUMBERPAD_type1');
				vKeypadGlobal.newInstance(frm, frm.card_num3, null, 'NUMBERPAD_type1');
				vKeypadGlobal.newInstance(frm, frm.card_num4, null, 'NUMBERPAD_type1');
				vKeypadGlobal.newInstance(frm, frm.CardAvailMonth, null, 'NUMBERPAD_type1');
				vKeypadGlobal.newInstance(frm, frm.CardAvailYear, null, 'NUMBERPAD_type1');
				vKeypadGlobal.newInstance(frm, frm.p_num, null, 'NUMBERPAD_type1');
				vKeypadGlobal.newInstance(frm, frm.biz1, null, 'NUMBERPAD_type1');
				vKeypadGlobal.newInstance(frm, frm.biz2, null, 'NUMBERPAD_type1');
				vKeypadGlobal.newInstance(frm, frm.biz3, null, 'NUMBERPAD_type1');
				vKeypadGlobal.newInstance(frm, frm.CardPwd, null, 'NUMBERPAD_type1');
				if(frm.device.value=="mobile"){
                    vKeypadGlobal.setOptionAll("isMobile", true);
                }else{
					 vKeypadGlobal.setOptionAll("alignX", -500);
				}
                vKeypadGlobal.setOptionAll("align", "center");
				vKeypadGlobal.setOptionAll("zIndex", 10);
				vKeypadGlobal.loadAll();
			});

			// 
			function setAuth(){
				$("input[id='radio3-1']").prop("checked", true);
				<%-- var AuthFlg = '<%=AuthFlg%>';
				if (AuthFlg == "01" || AuthFlg == "03"){
					$("#cardTypeSection").css("display","none");
					$("#cardAuthNoSection").css("display","none");
				}
				if (AuthFlg == "01" || AuthFlg == "02"){
					$("#cardPwSection").css("display","none");
				} --%>
				var PgKeyInCl = '<%=PgKeyInCl%>';
				if (PgKeyInCl == "01" || PgKeyInCl == "10"){
					$(".Pass").css('display','none');
					$("input[id='radio3-2']").prop('disabled',true);
					$("input[id='radio3-1']").prop("checked", true);
					$(".birth").css('display','none');    
					$(".kind").css('display','none'); 
					$("input[id='radio3-1']").prop('disabled',true);
				}
			}
			
			//할부개월 셋
			function setQuota(){
				var LimitInstmn = '<%=LimitInstmn%>';
				var Amt = '<%=Amt%>';
				
				try {
					LimitInstmn = parseInt(LimitInstmn);	
				} catch (e) {
					LimitInstmn = 0;
				}
				
				if (Amt > 2000){
					for (var i=LimitInstmn; i >= 2; i--){
						if (i < 10){
							$("#select2").prepend("<option value='0" + i + "'>" + i + "개월</option>");
						}else{
							$("#select2").prepend("<option value='" + i + "'>" + i + "개월</option>");
						}
					}
					$("#select2").prepend("<option value='00' selected='selected'>일시불</option>");
				}else{
					$("#select2").prepend("<option value='00' selected='selected'>일시불</option>");
				}
			}
		
			//maxLength 체크
			function maxLengthCheck(object){
				if (object.value.length > object.maxLength){
					object.value = object.value.slice(0, object.maxLength);
				}    
			};
			
			function clickAddr(){
				//배송지 팝업 url
				window.open('<%=payActionUrl%>' + "/ipay/addressSearch.jsp", '', 'width=700, height=400, menubar=no, status=no, toolbar=no');
			}
			
			//주소 선택 리턴 함수
			function returnAddr(postcode, fullAddr, zonecode){
				var Frame=document.getElementById("__daum__viewerFrame_1");
				var insDiv=document.getElementById("insDiv");
							
			}
			
			//결제정보 입력 페이지
			function showPaymentPage(){
				$(".buyer_input").css("display","none");
				$(".payment_input").css("display","block");
				$("#gnbComment").text("결제정보를 입력해주세요.");
				$("#nextBtnWrap").css("display","none");
				$("#payBtnWrap").css("display","block");
			}
			
			//구매자정보 페이지
			function showBuyerInfoPage(){
				$(".buyer_input").css("display","block");
				$(".payment_input").css("display","none");
				$("#gnbComment").text("주문정보와 구매자 정보를 확인해 주세요.");
				$("#nextBtnWrap").css("display","block");
				$("#payBtnWrap").css("display","none");
			}
			
			//배송 정보 업데이트
			function changeDelivery(f){
				$.ajax({
			        type : "POST",
			        url : "./card/delivery/changeDelivery.jsp",
			        async : true,
			        data : $("#frm").serialize(),
			        dataType : "json",
			        success : function(data){
			            resultcode = data.resultCode;
			            resultMsg = data.resultMsg;
			            if(resultcode=="0000"){
			            	if ($("#svcPrdtCd").val() == "03"){
			            		//수기결제
			            		return cardGoPay(f);
			            	}else{
			            		//인증결제
			            		return innopay.goPayForm(f);
			            	}
			            }else{
			                alert(resultMsg);
			                return;
			            }
			        },
			        error : function(data){
			        	alert("배송정보 업데이트 오류 발생 다시 시도해주세요.");
			        	return;
			        }
			    });
			}
			
			// 첫 노출 페이지에서 다음 버튼 누를  경우
			function cardConfGoPay(f){
				if ($("#svcPrdtCd").val() == "03"){ //수기결제
					if(!checkTerms()) { 
						return;
					}
					showPaymentPage();
					return;
				}
				//인증 결제
				if ($("#DeliverySeq").val() != "" || $("#zoneCode").val() != ""){
					changeDelivery(f);
				}else{
				    innopay.goPayForm(f);
				}
			}
			
			// 두번째 노출 페이지에서 다음 버튼 누를 경우 (수기 결제)
			function checkChangeDelivery(f){
				if ($("#DeliverySeq").val() != "" || $("#zoneCode").val() != ""){
					changeDelivery(f);
				}else{
					cardGoPay(f);
				}
			}
			
			//수기결제
			function cardGoPay(f){
				if ($("#svcPrdtCd").val() == "03"){ //수기결제
				    if(!checkTerms()) { 
				        return;
				    }
				}
				//수기결제로직
				f.action = '<%=payActionUrl%>'+'/ipay/PayConfirm_SMS.jsp';
			
				vKeypadGlobal.prepareSubmitAll();
				var isCheck = checkForm(f);
				if(isCheck){
					f.cardno.value = f.card_num1.value + f.card_num2.value + f.card_num3.value + f.card_num4.value;
					f.CardNum.value = f.card_num1.value + f.card_num2.value + f.card_num3.value + f.card_num4.value;
					f.CardExpire.value = f.CardAvailYear.value + f.CardAvailMonth.value;
				    f.submit();
				}
			}
		
			function checkTerms(){
			    if(!$("#terms1").is(":checked")||!$("#terms2").is(":checked")||!$("#terms3").is(":checked")/* ||!$("#terms4").is(":checked") */){
			        alert("이용약관에 동의해 주세요.");
			        return false;
			    }
			    return true;
			};
			
			
			//입력값 유효성 검사
			function checkForm(f){
				if(<%=DeliveryYn%> == "1"){
				    if($("#input_address").val() == '' || $("#input_address2").val() == '' || $("#input_address3").val() == ''){
				        alert("주소를 입력해주세요.");
				        $("#input_address").focus();
				        return false;
				    }
				}
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
				if($("#CardAvailMonth").val() == '' || $("#CardAvailMonth").val().length < 2){
					alert("유효기간(월)을 입력해주세요");
					$("#CardAvailMonth").focus();
					return false;
				}
				if($("#CardAvailYear").val() == '' || $("#CardAvailYear").val().length < 2){
					alert("유효기간(년)을 입력해주세요");
					$("#CardAvailYear").focus();
					return false;
				}

				var PgKeyInCl = '<%=PgKeyInCl%>';
				if (PgKeyInCl == "11" || PgKeyInCl=="00"){
					if($("#CardPwd").val() == '' || $("#CardPwd").val().length < 2){
						alert("비밀번호를 입력해주세요");
						$("#CardPwd").focus();
						return false;
					}
					if ($("input[id='radio3-2']:checked").val() == "sh1_02") {
						var bizNumleng=$("#biz1").val().length+$("#biz2").val().length+$("#biz3").val().length;
						var bizNum=$("#biz1").val()+$("#biz2").val()+$("#biz3").val();
						 f.BuyerAuthNum.value = bizNum;
						if($("#biz1").val() == '' || bizNumleng < 10){
							alert("사업자번호를 입력해주세요");
							$("#biz1").focus();
							return false;
						}
				    } else {
				    	if($("#p_num").val() == '' || $("#p_num").val().length < 6){
							alert("생년월일을 입력해주세요");
							$("#p_num").focus();
							return false;
						}
				    	f.BuyerAuthNum.value = $("#p_num").val();
				    }
				}
				return true;
			}					
			
			function focusNextItem(field, limit, next) {
				if (field.value.length == limit) {
					document.getElementById(next).focus();
				}
			}
			function insertFrame(){
		  		var frameArea=document.getElementById('addressFrame');
		  		var w=document.getElementById('w');
		  		frameArea.innerHTML="<IFRAME frameborder='0' title='우편번호검색프레임' id='__daum__viewerFrame_1' style='display:none' border:0; width:100%;height:100%;min-width:300px;min-height:440px;padding:0></IFRAME>";
		  	}
		</script>
		
		<% if(Aid.equals("00000sejoa")) {%>
			<title>SEJONGPAY 전자결제서비스</title>
		<% }else{%>
			<title>INNOPAY 전자결제서비스</title>
		<% }%>
	</head>
<body>
	<% if(errorCheck == false) {%>
		<form action="" name="frm" id="frm" method="post" style="">
			<!-- 공통 -->
			<input type="hidden" id="DeliveryYn" name="DeliveryYn" value="<%=DeliveryYn%>">
			<input type="hidden" id="Aid" name="Aid" value="<%=Aid%>">
			<input type="hidden" id="PgKeyInCl" name="PgKeyInCl" value="<%=PgKeyInCl%>">
			<input type="hidden" id="CoNm" name="CoNm" value="<%=CoNm%>">
			<input type="hidden" id="svcPrdtCd" name="svcPrdtCd" value="<%=SvcPrdtCd%>">
			<input type="hidden" name="OrderCode" value="<%=OrderCode%>">
			<input type="hidden" name="PayMethod" value="CARD">
			<input type="hidden" name="MallIP" value="<%=inet.getHostAddress()%>"/> <!-- 가맹점서버 IP 가맹점에서 설정-->
		    <input type="hidden" name="UserIP" value="<%=request.getRemoteAddr()%>"> <!-- 구매자 IP 가맹점에서 설정-->
		    <input type="hidden" name="device" value=""> <!-- 자동셋팅 -->
		    <input type="hidden" name="MerDeviceType" value=""><!-- 자동셋팅 -->
		    <input type="hidden" name="TelNo" value="<%=TelNo%>">
		    <input type="hidden" name="AddrNo" value="<%=AddrNo%>">
		    <input type="hidden" id="DeliverySeq" name="DeliverySeq" value="<%=DeliverySeq%>">	       
		   
		<% if ("04".equals(SvcPrdtCd)) { %> <!-- 인증결제에만 노출 -->
			<!--hidden 데이타 필수-->
			<input type="hidden" name="MerchantKey" value="<%=ShopLicenseKey%>">
			<input type="hidden" name="TransType" value=""/>
            <input type="hidden" name="ediDate" value=""> <!-- 결제요청일시 제공된 js 내 setEdiDate 함수를 사용하거나 가맹점에서 설정 yyyyMMddHHmmss-->
            <input type="hidden" name="EncryptData" value=""> <!-- 암호화데이터 -->
		    <input type="hidden" name="FORWARD" value="X"> <!-- Y:팝업연동 N:페이지전환 -->
            <input type="hidden" name="MallResultFWD"   value="N"> <!-- Y 인 경우 PG결제결과창을 보이지 않음 -->
		    <input type="hidden" name="GoodsCnt" value="<%=GoodsCnt%>">
		    <input type="hidden" name="GoodsName" value="<%=GoodsName%>">
		    <!-- 복합과세 적용 관련 변경 2019.04 hans -->
		    <input type="hidden" name="Amt" value="<%=TaxAmt%>">
		    <input type="hidden" name="TaxAmt" value="<%=TaxAmt%>"/>
			<input type="hidden" name="DutyFreeAmt" value="<%=DutyFreeAmt%>"/>
		    <input type="hidden" name="Moid" value="<%=Moid%>">
		    <input type="hidden" name="MID" value="<%=Mid%>">
		    <input type="hidden" name="ReturnURL" value="">
		    <input type="hidden" name="ResultYN" value="Y">
		    <input type="hidden" name="RetryURL" value="<%=InformWay%>">
		    <input type="hidden" name="mallUserID" value="">
		    <input type="hidden" name="BuyerName" value="<%=BuyerName %>">
		    <input type="hidden" name="BuyerTel" value="<%=BuyerTel %>">
		    <input type="hidden" name="BuyerEmail" value="<%=BuyerEmail %>">
		    <input type="hidden" name="OfferingPeriod" value="">
		    <input type="hidden" name="EncodingType" value="UTF-8">
		    <input type="hidden" name="svcCd" value="<%=SvcCd%>">
		    <input type="hidden" name="User_ID" value="<%=UserId%>">
		    <input type="hidden" name="Pg_Mid" value="<%=PgMid%>">
		    <input type="hidden" name="BuyerCode" value="<%=BuyerCode%>">
		    <!--hidden 데이타 옵션-->
		    <input type="hidden" name="BrowserType" value="">
            <input type="hidden" name="MallReserved" value="">
            
		<%} else {%> <!-- 수기 결제에만 노출 -->
			
			<input type="hidden" name="TransType" value=""/>	
			<input type="hidden" name="MID" value="<%=Mid%>"/>
			<input type="hidden" name="LicenseKey" id="LicenseKey" value="<%=ShopLicenseKey%>"/>
			<input type="hidden" name="BuyerAuthNum" value=""/>
			<input type="hidden" name="cardno" value=""/>
			<input type="hidden" name="CardNum" value=""/>
			<input type="hidden" name="Currency" value="KRW"/>
			<input type="hidden" name="CardInterest" value="0"/>
			<input type="hidden" name="FORWARD" value="N"/>
			<input type="hidden" name="MallResultFWD"   value="N"/>
			<input type="hidden" name="OfferingPeriod" value="3"/>
			<input type="hidden" name="TID" value="<%=TID%>"/>
			<input type="hidden" id="formBankCd" name="formBankCd" value=""/>
			<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
			<input type="hidden" name="CardExpire"      value=""/>
			<input type="hidden" name="ReturnURL"      value="<%=payActionUrl%>/ipay/returnPay.jsp"/>
			<input type="hidden" name="ResultYN"    value="N"/>
			<input type="hidden" name="RetryURL"    value="<%=InformWay%>"/>
			<input type="hidden" name="mallUserID"  value=""/>
			<input type="hidden" name="joinCode"    value="<%=JoinType%>"/>
			<input type="hidden" name="EncodingType" value="euc-kr"/>
			<input type="hidden" name="User_ID" value="<%=UserId%>"/>
			<input type="hidden" name="PrdtAmt" value="0"/>
			<input type="hidden" name="PrdtDutyFreeAmt" value="0"/>
			<input type="hidden" name="pg_mid" value="<%=PgMid%>">
			<input type="hidden" name="Moid" value="<%=Moid%>">
			<input type="hidden" name="BuyerName" value="<%=BuyerName %>">
			<input type="hidden" name="GoodsName" value="<%=GoodsName%>">
			<input type="hidden" name="Amt" value="<%=Amt%>">
			<input type="hidden" name="TaxAmt" value="<%=TaxAmt%>"/>
			<input type="hidden" name="DutyFreeAmt" value="<%=DutyFreeAmt%>"/>
			<input type="hidden" name="BuyerTel" value="<%=BuyerTel %>">
			<input type="hidden" name="BuyerEmail" value="<%=BuyerEmail %>">
		<%}%>
			
		<div class="innopay">
				<section class="innopay_wrap" id="in" class="step_1" >
				<header class="gnb">
					<h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
					<div class="kind">
						<span>신용카드 SMS결제</span>
					</div>
					<div id="google_translate_element"></div>
				</header>

				<section class="contents" >
					<section class="order_info">
						<ol class="step">
							<li class="on">입력</li>
							<li>확인</li>
							<li>완료</li>
						</ol>
						<div class="product_info">
							<ul>
								<li class="product_name">
									<div class="info_title">상품명</div>
									<div><%=GoodsName %></div>
								</li>
								<li class="price">
									<div class="info_title">상품가격</div>
									<div><%=StrUtils.getMoneyType(orderInfo.getLong("GOODS_AMT"))%><span>원</span></div>
								</li>
								<li class="company_info">
									<div class="info_title">판매자상호</div>
									<div><%=CoNm %></div>
								</li>
								<li class="company_info">
									<div class="info_title">판매자전화</div>
									<div><%=TelNo %></div>
								</li>
								<li class="company_info">
									<div class="info_title">판매자주소</div>
									<div><%=AddrNo %></div>
								</li>
							</ul>
						</div>
					</section>
					
					<section class="con_wrap" >
						<% if ("03".equals(SvcPrdtCd)) { %> <!-- 수기결제에만 노출 -->
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
						<%}%>
						<section class="payment_info" style="margin-top: 24px;">
							<h2>구매자 정보</h2>
							<ul>
								<li>
									<div class="info_title">구매자명</div>
									<div><%=BuyerName %></div>
								</li>
								<li>
									<div class="info_title">구매자전화</div>
									<div><%=MMSUtil.getTelType(BuyerTel)%></div>
								</li>
							<% if("1".equals(DeliveryYn)) {%>
								<li class="address">
									<div class="info_title address">주소</div>
									<div class="input_section address_num">
										<label for="address_num" class="input_title">우편번호</label>
										<div class="input_type1 address_num">
											<input type="number" name="ZoneCode"class="address_num_i" id="input_address" pattern="[0-9]*" value="<%=ZoneCode%>" inputmode="numeric"  maxLength="6" oninput="maxLengthCheck(this)"/>
										</div>
										<a class="btn_address popup_btn" onclick="execDaumPostcode();"data=".f_address"  href="#">주소찾기</a>
									</div>
									<div class="input_section address">
										<label for="input_address2" class="input_title">주소</label>
										<div class="input_type1">
											<input type="text" name="Address" value="<%=Address%>" id="input_address2" />
										</div>
									</div>
									<div class="input_section address">
										<label for="input_address3" class="input_title">상세주소</label>
										<div class="input_type1">
											<input type="text" name="AddressDetail" value="<%=AddressDetail%>" id="input_address3" />
										</div>
									</div>
								</li>
							<%}%>
							</ul>
						</section>
                    <% if ("03".equals(SvcPrdtCd)) { %> <!-- 수기결제에만 노출 -->
						<section class="payment_input">
							<h2>결제정보 입력</h2>
							<a href="#" data=".c_event" class="btn_d_gray btn_s2 btn popup_btn">무이자 할부 안내</a>
							<div>
								<div class="input_section">
									<label for="input_type_card" class="input_title">신용카드번호</label>
									<div class="input_type_split">
									  <div class="input_type_card">
										<input autocomplete="cc-number" type="number" name="card_num1" id="card_num1" onkeyup="javascript:focusNextItem(this, 4, 'card_num2');" placeholder="1234" pattern="[0-9]*" inputmode="numeric" maxLength="4" oninput="maxLengthCheck(this)"/>
										-
										<input type="password" name="card_num2" id="card_num2" onkeyup="javascript:focusNextItem(this, 4, 'card_num3');" class="security" placeholder="1234" pattern="[0-9]*" inputmode="numeric"  maxLength="4" oninput="maxLengthCheck(this)"/>
										-
										<input type="password" name="card_num3" id="card_num3" onkeyup="javascript:focusNextItem(this, 4, 'card_num4');" class="security" placeholder="1234"  pattern="[0-9]*" inputmode="numeric" maxLength="4" oninput="maxLengthCheck(this)"/>
										-
										<input type="number" name="card_num4" id="card_num4" onkeyup="javascript:focusNextItem(this, 4, 'CardAvailMonth');"  placeholder="1234"  pattern="[0-9]*" inputmode="numeric"  maxLength="4" oninput="maxLengthCheck(this)"/>
							          </div>
									</div>
								</div>
								<div class="input_section">
									<label for="input_type_period" class="input_title">카드유효기간</label>
									<div class="input_type_split">
									  <div class="input_type_period">
										<input type="number" id="CardAvailMonth" name="CardAvailMonth" onkeyup="javascript:focusNextItem(this, 2, 'CardAvailYear');" placeholder="MM" pattern="[0-9]*" inputmode="numeric"  maxLength="2" oninput="maxLengthCheck(this)"/>
										/
										<input type="number" id="CardAvailYear" name="CardAvailYear" placeholder="YY" pattern="[0-9]*" inputmode="numeric"  maxLength="2" oninput="maxLengthCheck(this)"/>
							          </div>
									</div>
								</div>
								<div class="input_section kind">
									<label for="radio3" class="input_title">카드종류</label>
									<div class="select_sh1 input_type1">
										<span>
											<input type="radio" name="radio3" value="sh1_01" id="radio3-1">
											<label for="radio3-1">개인</label>
										</span>
										<span>
											<input type="radio" name="radio3" value="sh1_02" id="radio3-2">
											<label for="radio3-2">법인</label>
										</span>
									</div>
								</div>
								<div class="input_section sh1_01 sh1 birth">
									<label for="p_num" class="input_title">생년월일</label>
									<div class="input_type1 p_num">
										<input type="number" id="p_num" name="p_num" placeholder="801010 (6자리)" pattern="[0-9]*" inputmode="numeric" maxlength="6" oninput="maxLengthCheck(this)">
									</div>
								</div>
								<div class="input_section sh1_02 sh1">
									<label for="biz1" class="input_title">사업자번호</label>
									<div class="input_type_split input_type1">
										<input name="biz1" id="biz1" type="number" placeholder="123" pattern="[0-9]*" inputmode="numeric" maxlength="3" oninput="maxLengthCheck(this)" style="width: 34px;"> - <input type="number"  placeholder="12" pattern="[0-9]*" inputmode="numeric" maxlength="2" id="biz2" name="biz2" oninput="maxLengthCheck(this)" style="width: 26px;"> - <input type="number" placeholder="12345" pattern="[0-9]*" inputmode="numeric" maxlength="5" id="biz3" name="biz3" oninput="maxLengthCheck(this)" style="width: 50px;">
									</div>
								</div>
								<div class="input_section Pass">
									<label for="c_password" class="input_title">카드비밀번호</label>
									<div class="input_type1 c_password">
										<input type="password" class="security" id="CardPwd" name="CardPwd" placeholder="앞2자리" pattern="[0-9]*" inputmode="numeric" maxlength="2" oninput="maxLengthCheck(this)">
									</div>
								</div>
								<div class="input_section">
							        <label for="select2" class="input_title">할부개월</label>
							        <div class="select_type1 select2">
								      <select name="CardQuota" id="select2"></select>
							        </div>
						        </div>
							</div>
						</section> <!-- 수기결제 Input end -->
					<% } %>		
						<section class="btn_wrap" id="nextBtnWrap">
							<a class="btn_blue btn install_notice_btn" href="#" onclick="return checkChangeDelivery(frm)">다음</a>
						</section>
					</section>
</form>

					<section class="footer">
						<span>INNOPAY 1688 - 1250</span>
					</section>
				</section>
<%@ include file="/common/notice.jsp" %>
			
		<%} else {%>
		<section id="wrap">
			<section class="float_wrap error_notice">
				<div class="popup_cont">
					<img src="images/i_error.png" alt="알림" width="69px" height="auto">
					<p><%=resultMsg %></p>
					<section class="btn_wrap_fl">
						<div>
							<a class="btn_blue btn" href="javascript:window.close()">확인</a>
						</div>
					</section>
				</div>
			</section>
		</section>
		<%} %>
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

				<!--무이자 안내-->
				<section class="float_wrap c_event">
                    <div class="pop_dim"></div>
                    <div class="popup">
                        <h3 class="popup_title">신용카드 무이자 할부 안내</h3>
                        <a href="#" class="btn_close pop_close"></a>
                        <div class="popup_cont">
                            <div class="popup_scroll iphone">
                                <div class="popup_scroll_in">
                                <div id="addressFrame">
                                    <iframe id="c_event_ifrm" src="https://pg.innopay.co.kr/pay/card/event.jsp?pg_cd=<%=PgCd %>&amp;join_type=1" width="100%" height="440" frameborder="0" scrolling="yes" style="opacity: 1; visibility: visible;"></iframe>       
                                    </div>                    
                                </div>
                            </div>
                        </div>  
                        <div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>
                    </div>
                </section>

                <!--주소찾기-->
				<section class="float_wrap f_address">
                    <div class="pop_dim"></div>
                    <div class="popup">
                        <h3 class="popup_title">주소찾기</h3>
                        <a href="#" class="btn_close pop_close"></a>
                        <div class="popup_cont">
                            <div class="scroll2">
                                                         
                                   <div id="layer" style="display:none; max-height:100%;  max-width:100%;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
</div>                                                                                    
                            </div>
                        </div>  
                        <div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>
                    </div>            
                </section>
				<!--//popup system_notice-->
			
			</section>
		</div>
	<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    //document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('input_address').value = data.zonecode;
                document.getElementById("input_address2").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("input_address3").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
               $('.btn_close').trigger('click');
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 483; //우편번호서비스가 들어갈 element의 width
        var height = 450; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 0; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
	</body>
</html>
