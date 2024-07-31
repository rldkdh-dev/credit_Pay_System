<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.net.InetAddress, org.apache.commons.lang.StringUtils" %>
<%@ page import="mobile.MMSUtil,kr.co.infinisoft.pg.common.StrUtils"%>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link rel="stylesheet" type="text/css" href="common/css/jquery.bxslider.css" />
	<link rel="stylesheet" type="text/css" href="common/css/common.css" />
	<link rel="stylesheet" type="text/css" href='common/css/font.css'>
	<link rel="shortcut icon" href="images/favicon.ico">
	<script type="text/javascript" src="common/js/jquery-2.1.4.min.js"></script>
	<script type="text/javascript" src="common/js/jquery.bxslider.js"></script>
 	<script type="text/javascript" src="common/js/jSignature.js"></script>
	<script type="text/javascript" src="common/js/common.js"></script>
<%
	request.setCharacterEncoding("utf-8");
	// parameter check
	String OrderCode	= CommonUtil.getDefaultStr(request.getParameter("OrderCode"), "");
	boolean errorCheck = false; //true:오류 / false:정상
	String resultCode = null;
	String resultMsg = null;
	
	String CoNm				= "";
	String TelNo        	= "";
	String GoodsName    	= "";
	String AddrNo       	= "";
	String Image        	= "";
	String CardQuota        = "";
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
	String MID				= "";
	String Aid				= "";
	String BuyerEmail		= "";
	String ShopLicenseKey	= "";
	String DeliverySeq		= "";
	String InformWay		= "";
	String Step				= "";
	String ExpireYn			= "";
	String UserId           = "";
	String PgMid            = "";
	String SvcCd            = "";
	String svcPrdtCd        = "";
	String LimitInstmn		= "";
	String AuthFlg			= "";
	String JoinType			= "";
	String TID				= "";
	String BuyerCode    	= "";
	String PgKeyInCl	    = "";
	String PgCode           = "";   // PG사 코드(블루월넛 때문에 추가)
	String PgCd           	= "";
	String cardno           = "";
	String CardExpire       = "";
	String CardNum          = "";
	String joinCode         = "";
	String RetryURL         = "";
	String User_ID          = "";
	String Pg_Mid           = "";
	String LicenseKey       = "";
	String CardPwd          = "";
	String strCardno        = "";
	String BuyerAuthNum     = "";
	boolean ExpireStatus = false;
	
	//OrderCode 존재여부 확인
	//주문정보 존재
	CardPwd			=  request.getParameter("CardPwd");
	CoNm			=  request.getParameter("CoNm"); 
	String card_num1 = request.getParameter("card_num1");
    String card_num2 = request.getParameter("card_num2");
    String card_num3 = request.getParameter("card_num3");
    String card_num4 = request.getParameter("card_num4");
    cardno = card_num1+card_num2+card_num3+card_num4;
    CardNum = cardno;
	//cardno			=  request.getParameter("cardno"); 
	CardExpire 		=  request.getParameter("CardExpire");
	//CardNum 		=  request.getParameter("CardNum");
	GoodsName 		=  request.getParameter("GoodsName");
	TelNo 			=  request.getParameter("TelNo");
	AddrNo			=  request.getParameter("AddrNo");
	BuyerName 		=  request.getParameter("BuyerName");
	BuyerTel 		=  request.getParameter("BuyerTel");
	DeliveryYn 		=  request.getParameter("DeliveryYn");
	ZoneCode 		=  CommonUtil.getDefaultStr(request.getParameter("ZoneCode"),"");
	Address 		=  CommonUtil.getDefaultStr(request.getParameter("Address"),"");
	AddressDetail 	=  CommonUtil.getDefaultStr(request.getParameter("AddressDetail"),"");
	GoodsCnt		=  CommonUtil.getDefaultStr(request.getParameter("GoodsCnt"), "1");
	Amt				=  request.getParameter("Amt");
	TaxAmt			=  request.getParameter("TaxAmt");
	DutyFreeAmt		=  request.getParameter("DutyFreeAmt");
	Moid			=  request.getParameter("Moid");
	MID				=  request.getParameter("MID");
	BuyerEmail		=  request.getParameter("BuyerEmail");
	BuyerAuthNum    =  request.getParameter("BuyerAuthNum");
	ShopLicenseKey	=  request.getParameter("ShopLicenseKey");
	DeliverySeq		=  request.getParameter("DeliverySeq");
	InformWay		=  request.getParameter("InformWay");
	Step			=  request.getParameter("Step");
	ExpireYn		=  request.getParameter("ExpireYn");
	UserId          =  request.getParameter("UserId");
	PgMid           =  request.getParameter("PgMid");
	svcPrdtCd       =  request.getParameter("svcPrdtCd"); //03:수기, 04:인증
	SvcCd           =  request.getParameter("SvcCd"); // 01: 카드
	LimitInstmn     =  request.getParameter("LimitInstmn");
	AuthFlg		    =  request.getParameter("AuthFlg");
	JoinType		=  request.getParameter("JoinType");
	TID				=  request.getParameter("TID");
	BuyerCode       =  request.getParameter("BuyerCode");
	PgKeyInCl       =  request.getParameter("PgKeyInCl");
	PgCode          =  request.getParameter("PgCode");
	Aid          	=  request.getParameter("Aid");
	PgCd          	=  request.getParameter("PgCd");
	joinCode        =  request.getParameter("joinCode");
	RetryURL        =  request.getParameter("RetryURL");
	User_ID         =  request.getParameter("User_ID");
	Pg_Mid          =  request.getParameter("Pg_Mid"); 
	LicenseKey      =  request.getParameter("LicenseKey");
	CardQuota		=  request.getParameter("CardQuota");
%>
<% if(request.getParameter("Aid").equals("00000sejoa")) {%>
    	<title>SEJONGPAY 전자결제서비스</title>
<% }else{%>
		<title>INNOPAY 전자결제서비스</title>
<% }%>	
</head>
<%
	long Amt2=Long.parseLong(Amt);
	strCardno = cardno.substring(0,4)+ "********" + cardno.substring(12);	
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

//상점 IP 셋팅 <MallIP 셋팅>
    InetAddress inet = InetAddress.getLocalHost();
    String payActionUrl = "https://pg.innopay.co.kr";    

	if (request.getServerPort() == 80 || request.getServerPort() == 443) {
	    payActionUrl = request.getScheme() + "://" + request.getServerName() ;
	} else {
	    payActionUrl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort();
	}   
%>
<script type="text/javascript">
function GoPay(f){
	f.action = '<%=payActionUrl%>' + '/ipay/card/payTransSMS.jsp';	
	checkCardBin(f);		
}

//카드빈 체크
function checkCardBin(f){
    $.ajax({
        type : "POST",
        url : "./card/checkCardBin.jsp",
        async : true,
        data : $("#frm").serialize(),
        dataType : "json",
        success : function(data){
            if(data.resultCode=="0000"){
            	$("#formBankCd").val(data.fnCd);
            	f.submit();
            }else{
            	alert(data.resultMsg);
            }
        },
        error : function(data){
        	alert(data.resultMsg);
        }
    });
}
</script>
<body>
	<form action="" name="frm" id="frm" method="post">
		<!-- 공통 -->
		<input type="hidden" id="PgKeyInCl" name="PgKeyInCl"         value="<%=PgKeyInCl%>">
		<input type="hidden" id="CardPwd" name="CardPwd"             value="<%=CardPwd%>">
		<input type="hidden" id="svcPrdtCd" name="svcPrdtCd"         value="<%=svcPrdtCd%>">
		<input type="hidden" id="address" name="address"             value="<%=Address%>">
		<input type="hidden" id="addressDetail" name="addressDetail" value="<%=AddressDetail%>">
		<input type="hidden" id="zoneCode" name="zoneCode"           value="<%=ZoneCode%>">
		<input type="hidden" id="CardQuota" name="CardQuota"         value="<%=CardQuota%>">
		<input type="hidden" id="OrderCode" name="OrderCode"         value="<%=OrderCode%>">
		<input type="hidden" name="PayMethod"                        value="CARD">
		<input type="hidden" name="MallIP"                           value="<%=inet.getHostAddress()%>"/> <!-- 가맹점서버 IP 가맹점에서 설정-->
	    <input type="hidden" name="UserIP"                           value="<%=request.getRemoteAddr()%>"> <!-- 구매자 IP 가맹점에서 설정-->
	    <input type="hidden" name="device"                           value=""> <!-- 자동셋팅 -->
	    <input type="hidden" id="DeliverySeq" name="DeliverySeq"     value="<%=DeliverySeq%>">
		    
<% if ("04".equals(svcPrdtCd)) { %> <!-- 인증결제에만 노출 -->
		<!--hidden 데이타 필수-->
		<input type="hidden" name="TransType"      value=""/>
        <input type="hidden" name="ediDate"        value=""> <!-- 결제요청일시 제공된 js 내 setEdiDate 함수를 사용하거나 가맹점에서 설정 yyyyMMddHHmmss-->
        <input type="hidden" name="MerchantKey"    value="<%=LicenseKey%>"> <!-- 발급된 가맹점키 -->
        <input type="hidden" name="EncryptData"    value=""> <!-- 암호화데이터 -->
	    <input type="hidden" name="FORWARD"        value="N"> <!-- Y:팝업연동 N:페이지전환 -->
        <input type="hidden" name="MallResultFWD"  value="N"> <!-- Y 인 경우 PG결제결과창을 보이지 않음 -->
	    <input type="hidden" name="GoodsCnt"       value="<%=GoodsCnt%>">
	    <input type="hidden" name="GoodsName"      value="<%=GoodsName%>">
	    <!-- 복합과세 적용 관련 변경 2019.04 hans -->
	    <input type="hidden" name="Amt"            value="<%=Amt%>">
	    <input type="hidden" name="TaxAmt"         value="<%=TaxAmt%>"/>
		<input type="hidden" name="DutyFreeAmt"    value="<%=DutyFreeAmt%>"/>
	    <input type="hidden" name="Moid"           value="<%=Moid%>">
	    <input type="hidden" name="MID"            value="<%=MID%>">
	    <input type="hidden" name="ReturnURL"      value="">
	    <input type="hidden" name="ResultYN"       value="Y">
	    <input type="hidden" name="RetryURL"       value="<%=RetryURL%>">
	    <input type="hidden" name="mallUserID"     value="">
	    <input type="hidden" name="BuyerName"      value="<%=BuyerName %>">
	    <input type="hidden" name="BuyerTel"       value="<%=BuyerTel %>">
	    <input type="hidden" name="BuyerEmail"     value="<%=BuyerEmail %>">
	    <input type="hidden" name="OfferingPeriod" value="">
	    <input type="hidden" name="EncodingType"   value="UTF-8">
	    <input type="hidden" name="svcCd"          value="<%=SvcCd%>">
	    <input type="hidden" name="User_ID"        value="<%=User_ID%>">
	    <input type="hidden" name="Pg_Mid"         value="<%=Pg_Mid%>">
	    <input type="hidden" name="BuyerCode"      value="<%=BuyerCode%>">
	    <!--hidden 데이타 옵션-->
	    <input type="hidden" name="BrowserType"    value="">
        <input type="hidden" name="MallReserved"   value="">
            
<% } else { %> <!-- 수기 결제에만 노출 -->

		<input type="hidden" name="TransType"       value=""/>	
		<input type="hidden" name="MID"             value="<%=MID%>"/>
		<input type="hidden" name="LicenseKey" id="LicenseKey" value="<%=LicenseKey%>"/>
		<input type="hidden" name="BuyerAuthNum"    value="<%=BuyerAuthNum%>"/>
		<input type="hidden" name="cardno"          value="<%=cardno%>"/>
		<input type="hidden" name="CardNum"         value="<%=CardNum%>"/>
		<input type="hidden" name="Currency"        value="KRW"/>
		<input type="hidden" name="CardInterest"    value="0"/>
		<input type="hidden" name="FORWARD"         value="N"/>
		<input type="hidden" name="MallResultFWD"   value="N"/>
		<input type="hidden" name="OfferingPeriod"  value="3"/>
		<input type="hidden" name="TID"             value="<%=TID%>"/>
		<input type="hidden" id="formBankCd" name="formBankCd" value=""/>
		<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
		<input type="hidden" name="CardExpire"      value="<%=CardExpire%>"/>
		<input type="hidden" name="ReturnURL"       value="<%=payActionUrl%>/ipay/returnPay.jsp"/>
		<input type="hidden" name="ResultYN"        value="N"/>
		<input type="hidden" name="RetryURL"        value="<%=RetryURL%>"/>
		<input type="hidden" name="mallUserID"      value=""/>
		<input type="hidden" name="joinCode"        value="<%=joinCode%>"/>
		<input type="hidden" name="EncodingType"    value="euc-kr"/>
		<input type="hidden" name="User_ID"         value="<%=User_ID%>"/>
		<input type="hidden" name="PrdtAmt"         value="0"/>
		<input type="hidden" name="PrdtDutyFreeAmt" value="0"/>
		<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
		<input type="hidden" name="Moid"            value="<%=Moid%>">
		<input type="hidden" name="BuyerName"       value="<%=BuyerName %>">
		<input type="hidden" name="GoodsName"       value="<%=GoodsName%>">
		<input type="hidden" name="Amt"             value="<%=Amt%>">
		<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
		<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
		<input type="hidden" name="BuyerTel"        value="<%=BuyerTel%>">
		<input type="hidden" name="BuyerEmail"      value="<%=BuyerEmail%>">
<% } %>
	    <div class="innopay">
		    <section class="innopay_wrap">
				<header class="gnb">
					<h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
					<div class="kind">
						<span>신용카드 SMS결제</span>
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
								<li class="product_name">
									<div class="info_title">상품명</div>
									<div><%=GoodsName %></div>
								</li>
								<li class="price">
									<div class="info_title">상품가격</div>
									<div><%=StrUtils.getMoneyType(Amt2)%><span>원</span></div>
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
					
					<section class="con_wrap">
						<section class="confirm_notice">
							<p>
								<b>결제정보</b>를 <b>확인</b>하시고 동의하면 하단의 <b>카드결제요청</b> 버튼을 클릭하시어 결제를 진행하여 주세요.
							</p>	
						</section>
						<section class="payment_info">
							<h2>결제 정보</h2>
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
								<li>
									<div class="info_title">주소</div>
									<div><%=ZoneCode%> <%=Address%> <%=AddressDetail%></div>
								</li>
								<%} %>
								<li>
									<div class="info_title">카드번호</div>
									<div><%=strCardno%></div>
								</li>
								<li>
									<div class="info_title">할부기간</div>
									<div>
									<%  String strInst = CardQuota;
								        if("0".equals(strInst) || "00".equals(strInst)) {
                                    %>
                                        일시불
                                    <%  }else { %>
                                        <%=strInst %>개월
                                    <%  } %></div>
								</li>
							</ul>
						</section>

						<section class="btn_wrap_multi">
							<div>
								<a class="btn_gray btn dim_btn" onclick="javascript:history.go(-1);" href="#">뒤로가기</a>
								<a class="btn_blue btn" href="#" onclick="GoPay(frm)">카드 결제요청</a>
							</div>
						</section>
					</section>
</form>

					<section class="footer">
						<span>INNOPAY 1688 - 1250</span>
					</section>

				</section>
                <!--//popup system_notice-->				
<%@ include file="/common/notice.jsp" %>
			</section>
		</div>
	</body>
</html>