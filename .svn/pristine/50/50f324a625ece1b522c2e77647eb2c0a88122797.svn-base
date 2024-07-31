<%
/******************************************************************************
*
*   @ SYSTEM NAME       : PG 수기,인증결제 연동페이지
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
<%@ include file="./bluewalnut/incMerchant.jsp" %>
<%
    request.setCharacterEncoding("utf-8");
    // parameter check
    String OrderCode    = CommonUtil.getDefaultStr(request.getParameter("OrderCode"), "");

    boolean errorCheck = false; //true:오류 / false:정상
    String resultCode = null;
    String resultMsg = null;
    Box pgInfoBox = new Box();
    Box orderInfo = new Box();
    
    String CoNm             = "";
    String TelNo            = "";
    String GoodsName        = "";
    String AddrNo           = "";
    String Image            = "";
    String BuyerName        = "";
    String BuyerTel         = "";
    String DeliveryYn       = "";
    String ZoneCode         = "";
    String Address          = "";
    String AddressDetail    = "";
    String GoodsCnt         = "";
    String Amt              = "";
 	// 2019.04 과세 면세 필드 추가
 	String TaxAmt			= "";	// 과세금액
 	String DutyFreeAmt		= "";	// 면세금액
    String Moid             = "";
    String Mid              = "";
    String BuyerEmail       = "";
    String ShopLicenseKey   = "";
    String DeliverySeq      = "";
    String InformWay        = "";
    String Step             = "";
    String ExpireYn         = "";
    String UserId           = "";
    String PgMid            = "";
    String SvcCd            = "";
    String SvcPrdtCd        = "";
    String LimitInstmn      = "";
    String AuthFlg          = "";
    String JoinType         = "";
    String TID              = "";
    String BuyerCode       = "";
    String PgCode          = "";   // PG사 코드(블루월넛 때문에 추가)
    
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
            
            CoNm            =  orderInfo.getString("MID_NM")==null?"":orderInfo.getString("MID_NM");
            GoodsName       =  orderInfo.getString("GOODS_NAME")==null?"":orderInfo.getString("GOODS_NAME");
            TelNo           =  orderInfo.getString("TEL_NO")==null?"":orderInfo.getString("TEL_NO");
            AddrNo          =  orderInfo.getString("ADDR_NO1")==null?"":orderInfo.getString("ADDR_NO1") + " " + orderInfo.getString("ADDR_NO2")==null?"":orderInfo.getString("ADDR_NO2");
            BuyerName       =  orderInfo.getString("BUYER_NAME")==null?"":orderInfo.getString("BUYER_NAME");
            BuyerTel        =  orderInfo.getString("BUYER_CELLPHONE_NO")==null?"":orderInfo.getString("BUYER_CELLPHONE_NO");
            DeliveryYn      =  orderInfo.getString("DEV_ADDR_CL")==null?"":orderInfo.getString("DEV_ADDR_CL");
            ZoneCode        =  orderInfo.getString("zone_code")==null?"":orderInfo.getString("zone_code");
            Address         =  orderInfo.getString("address")==null?"":orderInfo.getString("address");
            AddressDetail   =  orderInfo.getString("address_detail")==null?"":orderInfo.getString("address_detail");
            GoodsCnt        =  orderInfo.getString("GoodsCnt")==null?"":orderInfo.getString("goods_cnt");
            Amt             =  orderInfo.getString("GOODS_AMT")==null?"":orderInfo.getString("GOODS_AMT");
            TaxAmt			=  orderInfo.getString("GOODS_TAX_AMT")==null?"0":orderInfo.getString("GOODS_TAX_AMT");
			DutyFreeAmt		=  orderInfo.getString("GOODS_DUTY_FREE")==null?"0":orderInfo.getString("GOODS_DUTY_FREE");
            Moid            =  orderInfo.getString("MOID")==null?"":orderInfo.getString("MOID");
            Mid             =  orderInfo.getString("MID")==null?"":orderInfo.getString("MID");
            BuyerEmail      =  orderInfo.getString("BUYER_EMAIL")==null?"":orderInfo.getString("BUYER_EMAIL");
            ShopLicenseKey  =  orderInfo.getString("SHOP_LICENSE_KEY")==null?"":orderInfo.getString("SHOP_LICENSE_KEY");
            DeliverySeq     =  orderInfo.getString("delivery_seq")==null?"":orderInfo.getString("delivery_seq");
            InformWay       =  orderInfo.getString("INFORM_WAY")==null?"":orderInfo.getString("INFORM_WAY");
            Step            =  orderInfo.getString("STEP")==null?"":orderInfo.getString("STEP");
            ExpireYn        =  orderInfo.getString("EXPIRE_YN")==null?"":orderInfo.getString("EXPIRE_YN");
            UserId          =  orderInfo.getString("USER_ID")==null?"":orderInfo.getString("USER_ID");
            PgMid           =  orderInfo.getString("PG_MID")==null?"":orderInfo.getString("PG_MID");
            SvcPrdtCd       =  orderInfo.getString("SVC_PRDT_CD")==null?"":orderInfo.getString("SVC_PRDT_CD"); //03:수기, 04:인증
            SvcCd           =  orderInfo.getString("SVC_CD")==null?"":orderInfo.getString("SVC_CD"); // 01: 카드
            LimitInstmn     =  orderInfo.getString("LIMIT_INSTMN")==null?"00":orderInfo.getString("LIMIT_INSTMN");
            AuthFlg         =  orderInfo.getString("AUTH_FLG")==null?"":orderInfo.getString("AUTH_FLG");
            JoinType        =  orderInfo.getString("JOIN_TYPE")==null?"":orderInfo.getString("JOIN_TYPE");
            TID             =  orderInfo.getString("TID")==null?"":orderInfo.getString("TID");
            BuyerCode       =  orderInfo.getString("BUYER_CODE")==null?"":orderInfo.getString("BUYER_CODE");
            
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
            
            Image = orderInfo.getString("image");
            if (Image == null){
                Image = "<img src='./images/no_img.png' alt='상품이미지'>";
            }else{
                Image = "<img src='data:image/jpeg;base64, "+Image+"' alt='상품이미지'>";    
            }
            
            // SMS 결제는 PG가 1개라는 가정하에 아래와 같이 처리함
            
            pgInfoBox = CardSms.selectSmsPgInfo(Mid, SvcCd, SvcPrdtCd);
            if(pgInfoBox!=null && !pgInfoBox.isEmpty()){
                PgCode = pgInfoBox.getString("PG_CD");
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
if (request.getServerPort() == 80 || request.getServerPort() == 443) {
    payActionUrl = request.getScheme() + "://" + request.getServerName() ;
} else {
    payActionUrl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort();
}   
//// For BlueWalNut
String ediDate = getyyyyMMddHHmmss(); // 전문생성일시
/** for TEST **/
//String merchantKey = "sgNfyYe8ZE2OXM/zQ1V7R2hpoBSd9CfaMB03zMWS77fQkJ9dm2Edo+zla/bwz5lz6qGmUWdFK9MQsBE1lFe24g==";
//PgMid = "hdptest01m";
String merchantKey = pgInfoBox.getString("PG_LICENSE_KEY");
PgMid = pgInfoBox.getString("PG_MID");		
String str_src = ediDate + PgMid + Amt;
//위변조 처리
DataEncrypt hash =  new DataEncrypt();
String hash_String = hash.SHA256Salt(str_src, merchantKey);
////////
%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="css/card_conf.css" />
        <link href='https://cdn.rawgit.com/theeluwin/NotoSansKR-Hestia/master/stylesheets/NotoSansKR-Hestia.css' rel='stylesheet' type='text/css'>
        <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="js/card_conf.js"></script>
        <!-- BlueWalNut 연동 스크립트 -->
        <link rel="stylesheet" href="https://pg.bluewalnut.co.kr:443/dlp/css/mobile/hpay.css" type="text/css" />
        <!-- <link rel="stylesheet" href="https://pg.bluewalnut.co.kr:443//dlp/css/pc/cnspay.css" type="text/css" /> -->
        <script type="text/javascript" src="https://pg.bluewalnut.co.kr:443/dlp/scripts/lib/easyXDM.min.js"></script>
        <script type="text/javascript" src="https://pg.bluewalnut.co.kr:443/dlp/hpay_tr.js"></script>
        <script type="text/javascript" src="https://pg.bluewalnut.co.kr:443/dlp/cnspayUtil.js"></script>
        <script type="text/javascript" src="https://pg.bluewalnut.co.kr:443/dlp/scripts/lib/json2.js"></script>
        <script type="text/javascript">
        
            $(document).ready(function(){
                /*레이어 팝업 높이*/
                var popup_scroll_height = function() {return window.innerHeight - 140;}
                $('.popup_scroll').css('height', popup_scroll_height());
                /*약관동의 popup 동작*/
                var popup_top = function() {  return window.innerHeight;};
                var conditions_top_p = function() {
                    if($(".popup.conditions_text").is(":hidden")){
                          $(".popup.conditions_text").css("top",popup_top());
                            $("a.btn_s").click(function(){
                            $(".popup.conditions_text").css("display","block");
                            $(".popup.conditions_text").stop().animate({"top":100},{"duration":300});
                            $("body").addClass("dimed");
                            $("#wrap").addClass("dim_blur");
                            $(".dim").css("display","block");
                            $(".btn_close").css("display","block"); 
                        });
                    };
                };
                
                conditions_top_p();
                
                $(document).on('click', "a.btn_close", function(){
                    $(".popup.conditions_text").stop().animate({"top":popup_top()},300,function(){$(".popup.conditions_text").css("display","none");});
                    $("body").removeClass("dimed");
                    $("#wrap").removeClass("dim_blur");
                    $(".dim").css("display","none");
                    $(".btn_close").css("display","none");
                });
                
                // 카드 종류 별 인증 입력값 변경
                $("#cardType").change(function() {
                    if ($("#cardType option:selected").val() == "02") {
                        $("#cardTypeLabel").text("사업자등록번호");
                        $("#BuyerAuthNum").attr("placeholder", "(- 제외 10자리)");
                        $("#BuyerAuthNum").attr( "maxLength", "10" );
                    } else {
                        $("#cardTypeLabel").text("주민등록번호");
                        $("#BuyerAuthNum").attr("placeholder", "(앞 6자리)");
                        $("#BuyerAuthNum").attr( "maxLength", "6" );
                    }
                    maxLengthCheck(document.frm.BuyerAuthNum);
                });
                
                setQuota(); //할부개월 셋팅
                setAuth(); //가맹점 인증 방식별 입력값 셋팅
            });
            
            //인증 방식 별 입력값 셋
            function setAuth(){
                var AuthFlg = '<%=AuthFlg%>';
                if (AuthFlg == "01" || AuthFlg == "03"){
                    $("#cardTypeSection").css("display","none");
                    $("#cardAuthNoSection").css("display","none");
                }
                
                if (AuthFlg == "01" || AuthFlg == "02"){
                    $("#cardPwSection").css("display","none");
                }
            }
            
            //할부개월 셋
            function setQuota(){
                var LimitInstmn = '<%=LimitInstmn%>';
                var Amt = '<%=Amt%>';
                
                if (Amt > 2000){
                    for (var i=LimitInstmn; i >= 0; i--){
                        if (i == 1) continue;
                        if(i == 0){
                            $("#select2").prepend("<option value='00' selected='selected'>일시불</option>");
                        }else{
                            if (i < 10){
                                $("#select2").prepend("<option value='0" + i + "'>" + i + "개월</option>");
                            }else{
                                $("#select2").prepend("<option value='" + i + "'>" + i + "개월</option>");    
                            }
                        }
                    }
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
                $("#postcode").val(postcode);
                $("#address").val(fullAddr);
                $("#zoneCode").val(zonecode);
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
                                //return goPay(f);
                                return hpay();
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
                    if (!$("#personal_Data").prop("checked")) { 
                        alert("이용약관에 동의하세요.");
                        return;
                    }
                    showPaymentPage();
                    return;
                }
                
                //인증 결제
                if ($("#DeliverySeq").val() != "" || $("#zoneCode").val() != ""){
                    changeDelivery(f);
                }else{
                    //goPay(f);
                    hpay();
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
                
                //수기결제로직
                f.action = '<%=payActionUrl%>' + '/ipay/card/payTransSMS.jsp';
                checkDevice(f);
                
                var isCheck = checkFormField();
                if(isCheck){
                    f.cardno.value = f.card_num1.value + f.card_num2.value + f.card_num3.value + f.card_num4.value;
                    f.CardNum.value = f.card_num1.value + f.card_num2.value + f.card_num3.value + f.card_num4.value;

                    f.CardExpire.value = f.CardAvailYear.value + f.CardAvailMonth.value;

                    var isOK =
                        confirm("상품명 : " + f.GoodsName.value + 
                                "\n주문번호 : " + f.Moid.value +
                                "\n결제요청금액 : " + f.Amt.value +"원"+
                                "\n구매자명 : " + f.BuyerName.value +
                                "\n신용카드번호 : " + f.card_num1.value +"-"+ f.card_num2.value +"-"+f.card_num3.value+"-"+f.card_num4.value +
                                "\n유효기간 : " + f.CardAvailMonth.value +"월 "+f.CardAvailYear.value+"년"+ 
                        "\n\n결제를 진행하시겠습니까?");
                    if(isOK){
                        checkCardBin(f);
                    }
                }
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
                            $("#formBankCd").val(data.fn_cd);
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
            
            //입력값 유효성 검사
            function checkFormField(){
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
                if($("#card_num4").val() == '' || $("#card_num4").val().length < 3){
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
                
                
                var AuthFlg = '<%=AuthFlg%>';
                
                if (AuthFlg == "03" || AuthFlg == "04"){
                    if($("#CardPwd").val() == '' || $("#CardPwd").val().length < 2){
                        alert("비밀번호를 입력해주세요");
                        $("#CardPwd").focus();
                        return false;
                    }
                }
                
                if (AuthFlg == "02" || AuthFlg == "04"){
                    if ($("#cardType option:selected").val() == "02") {
                        if($("#BuyerAuthNum").val() == '' || $("#BuyerAuthNum").val().length < 10){
                            alert("사업자번호를 입력해주세요");
                            $("#BuyerAuthNum").focus();
                            return false;
                        }
                    } else {
                        if($("#BuyerAuthNum").val() == '' || $("#BuyerAuthNum").val().length < 6){
                            alert("주민등록번호를 입력해주세요");
                            $("#BuyerAuthNum").focus();
                            return false;
                        }
                    }
                }
                
                return true;
            }                   
            
            function focusNextItem(field, limit, next) {
                if (field.value.length == limit) {
                    document.getElementById(next).focus();
                }
            }

            function checkDevice(frm){
                var UserAgent = navigator.userAgent; 
                // 모바일/PC 구분
                if (UserAgent.match(/Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null 
                    || UserAgent.match(/LG|SAMSUNG|Samsung/) != null){
                	frm.MerDeviceType.value="APP";
                    frm.device.value = "mobile";
                }else if(UserAgent.match(/iPhone|iPod|Safari/i) != null){ 
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
//결제 요청 함수
function hpaySubmit() {
    //모바일앱으로 결제창 호출인 경우
    if(m_device_type === 'APP') {
        if(getMobileDeviceOS() === 'android') {
            window.isdlpshown.setMessage('NO');
        } else {
            window.location = 'isdlpshown://NO';
        }
    } else {
        if(typeof(p_win) != "undefined" && p_win != null) {
            p_win.close();
        }
    }
    
    document.frm.target = "_self";
    document.frm.action = "./bluewalnut/payTrans.jsp";
    document.frm.method = "post";
    document.frm.submit();
}
//hpay를 통해 결제를 시작합니다.
function hpay() {
    var payForm = document.frm;
    checkDevice(payForm);
    if(eval(payForm.UsePopupDlp.value) == false){ //팝업창내 레이어 DLP
        if(typeof(p_win) != "undefined" && p_win != null) {
            p_win.close();
        }

        p_win = window.open("about:blank", "merchantPop", "width="+p_w_pop+", height="+p_h_pop+", top="+p_h_pos+", left="+p_w_pos+", menubar=no, scrollbars=no, status=no, titlebar=no, toolbar=no");

        if(p_win == null) {
            alert("팝업차단을 해제하신 후 결제를 하시기 바랍니다.");
        } else {
            payForm.action = "./bluewalnut/merchantPopup.jsp";
            payForm.target = "merchantPop";
            payForm.method = "post";
            payForm.submit();
        }
    }else{
        goPay(payForm);
    }
}
/**
결제 취소시 호출하게 되는 함수
*/
function hpayClose(){
    if(typeof(p_win) !== "undefined" && p_win != null) {
        p_win.close();
    }
}
//팝업창내 레이어 DLP인경우 팝업 리사이즈시 호출하게 되는 함수
function p_dlpReSize() {
    if(typeof(p_win) != "undefined" && p_win != null) {
        p_win.resizeTo(p_w_pop_ex, p_h_pop_ex);
    }
}
//모바일 APP의 BACK 버튼 클릭시 호출하게 되는 함수
function bwcAppClose() {
    //모바일앱으로 결제창 호출인 경우
    if(m_device_type === 'APP') {
        if(getMobileDeviceOS() === 'android') {
            window.isdlpshown.setMessage('NO');
        } else {
            window.location = 'isdlpshown://NO';
        }
    }
    mnCloseDlp();
}
        </script>
        <title>INNOPAY 전자결제서비스</title>
    </head>
    <body>
        <% if(errorCheck == false) {%>
        <form action="./bluewalnut/payTrans.jsp" name="frm" id="frm" method="post" style="">
            <!-- 공통 -->
            <input type="hidden" id="svcPrdtCd" name="svcPrdtCd" value="<%=SvcPrdtCd%>">
            <input type="hidden" name="OrderCode" value="<%=OrderCode%>">
            <input type="hidden" name="PayMethod" value="CARD">
            <input type="hidden" name="selectType" value="CARD">
            <input type="hidden" name="MallIP" value="<%=inet.getHostAddress()%>"/> <!-- 가맹점서버 IP 가맹점에서 설정-->
            <input type="hidden" name="UserIP" value="<%=request.getRemoteAddr()%>"> <!-- 구매자 IP 가맹점에서 설정-->
            <input type="hidden" name="device" value=""> <!-- 자동셋팅 -->
            <input type="hidden" id="DeliverySeq" name="DeliverySeq" value="<%=DeliverySeq%>">
            <input type="hidden" id="ServiceCode" name="ServiceCode" value="002"> <!-- 고정값 -->
            
            <% if ("04".equals(SvcPrdtCd)) { %> <!-- 인증결제에만 노출 -->
            <!--hidden 데이타 필수-->
            <input type="hidden" name="TransType" value="0"/>
            <input type="hidden" name="EdiDate" value="<%=ediDate%>"> <!-- 결제요청일시 제공된 js 내 setEdiDate 함수를 사용하거나 가맹점에서 설정 yyyyMMddHHmmss-->
            <input type="hidden" name="MerchantKey" value="<%=merchantKey%>"> <!-- 발급된 가맹점키 -->
            <input type="hidden" name="EncryptData" value="<%=hash_String%>"> <!-- 암호화데이터 -->
            <input type="hidden" name="TrKey" value="">
            <input type="hidden" name="GoodsCnt" value="1">
            <input type="hidden" name="GoodsName" value="<%=GoodsName%>">
            <input type="hidden" name="Amt" value="<%=Amt%>">
            <input type="hidden" name="TaxAmt" value="<%=TaxAmt%>"/>
			<input type="hidden" name="DutyFreeAmt" value="<%=DutyFreeAmt%>"/>
            <input type="hidden" name="Moid" value="<%=Moid%>">
            <input type="hidden" name="MID" value="<%=PgMid%>">
            <input type="hidden" name="BuyerName" value="<%=BuyerName %>">
            <input type="hidden" name="BuyerTel" value="<%=BuyerTel %>">
            <input type="hidden" name="BuyerEmail" value="<%=BuyerEmail %>">
            <input type="hidden" name="OfferPeriod" value="">
            <input type="hidden" name="UsePopupDlp" value=""><!-- "":레이어, false:팝업, true:결제창넘김 -->
            <input type="hidden" name="MerDeviceType" value="WEB">
            <input type="hidden" name="SUB_ID" value="<%=Mid%>"> <!-- 인피니소프트 MID 전달 -->
            <!--hidden 데이타 옵션-->
            <input type="hidden" name="MerchantDt" value="<%=OrderCode%>">
            <input type="hidden" name="FORWARD" value="N"/>
            
            <%} else {%> <!-- 수기 결제에만 노출 -->
            
            <input type="hidden" name="TransType" value=""/>    
            <input type="hidden" name="MID" value="<%=Mid%>"/>
            <input type="hidden" name="LicenseKey" id="LicenseKey" value="<%=ShopLicenseKey%>"/>
            <input type="hidden" name="BuyerAuthNum" value=""/>
            <input type="hidden" name="cardno" value=""/>
            <input type="hidden" name="CardNum" value=""/>
            <input type="hidden" name="Currency" value="KRW"/>
            <input type="hidden" name="CardInterest" value="0"/>
            <input type="hidden" name="FORWARD" value="Y"/>
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
            <section id="wrap" class="step_1">
                <header id="gnb">
                    <!-- <h1 class="logo"><img src="images/logo.png" alt="INNOPAY 전자결제서비스 logo" height="36px"></h1> -->
                    <h1 class="logo" style="height:40px;"><img src="images/bluewalnut.png" alt="BlueWalnut 전자결제서비스 logo" height="21px"></h1>
                    <div class="comment">
                        <span id="gnbComment">주문정보와 구매자 정보를 확인해 주세요.</span>
                    </div>
                </header>
    
                <section class="contents">
                    <section id="order_info">
                        <h2>주문정보</h2>
                        <div class="product_info">
                            <div class="product_img"><%=Image %></div>
                            <div class="product_text">
                                <div class="product_name"><%=GoodsName %></div>
                                <div class="price"><%=StrUtils.getMoneyType(orderInfo.getLong("GOODS_AMT"))%><span>원</span></div>
                            </div>
                        </div>
                        <ul class="info info_s">
                            <li>
                                <div class="info_title">판매자상호명</div>
                                <div><%=CoNm %></div>
                            </li>
                            <li>
                                <div class="info_title">판매자연락처</div>
                                <div><%=TelNo %></div>
                            </li>
                            <li>
                                <div class="info_title">주소</div>
                                <div><%=AddrNo %></div>
                            </li>
                        </ul>
                    </section>
    
                    <section id="buyer_info" class="buyer_input">
                        <h2>구매자 정보</h2>
                        <ul class="info">
                            <li>
                                <div class="info_title">구매자명</div>
                                <div><%=BuyerName %></div>
                            </li>
                            <li>
                                <div class="info_title">구매자연락처</div>
                                <div><%=MMSUtil.getTelType(BuyerTel)%></div>
                            </li>
                            <% if("1".equals(DeliveryYn)) {%>
                            <li class="adress">
                                <div class="info_title adress">주소</div>
                                <div class="input_section adress_num">
                                    <label for="adress_num" class="input_title">우편번호</label>
                                    <div class="input_type1 adress_num">
                                        <input name="postcode" id="postcode" class="adress_num_i" onclick="javascript:clickAddr();" value="<%=ZoneCode%>"/>
                                        <input name="zoneCode" id="zoneCode" type="text" hidden="hidden" value="<%=ZoneCode%>">
                                    </div>
                                    <div><a class="btn_adress" href="#" onclick="javascript:clickAddr();">주소찾기</a></div>
                                </div>
                                <div class="input_section adress">
                                    <label for="input_adress2" class="input_title">주소</label>
                                    <div class="input_type1">
                                        <input type="text" name="address" id="address" value="<%=Address%>"/>
                                    </div>
                                </div>
                                <div class="input_section adress">
                                    <label for="input_adress3" class="input_title">상세주소</label>
                                    <div class="input_type1">
                                        <input type="text" name="addressDetail" id="addressDetail" value="<%=AddressDetail%>"/>
                                    </div>
                                </div>
                            </li>
                            <%}%>
                        </ul>
                        <% if ("03".equals(SvcPrdtCd)) { %> <!-- 수기결제에만 노출 -->
                        <div class="personal_Data">
                            <a class="btn_gray btn_s" id="goDim">내용보기</a>
                            <input type="checkbox" id="personal_Data"/>
                            <label for="personal_Data">개인정보 수집 및 이용에 동의 합니다.</label>    
                        </div>
                        <%}%>
                    </section>
                    <% if ("03".equals(SvcPrdtCd)) { %> <!-- 수기결제에만 노출 -->
                    <section class="payment_input" style="display: none;">
                        <h2>결제정보 입력</h2>
                        <div class="input_section">
                            <label for="input_type_card" class="input_title">신용카드번호</label>
                            <div class="input_type_card">
                                <input autocomplete="cc-number" type="number" name="card_num1" id="card_num1" onkeyup="javascript:focusNextItem(this, 4, 'card_num2');" placeholder="1234" pattern="[0-9]*" inputmode="numeric" maxLength="4" oninput="maxLengthCheck(this)"/>
                                -
                                <input type="number" name="card_num2" id="card_num2" onkeyup="javascript:focusNextItem(this, 4, 'card_num3');" placeholder="1234" pattern="[0-9]*" inputmode="numeric"  maxLength="4" oninput="maxLengthCheck(this)"/>
                                -
                                <input type="number" name="card_num3" id="card_num3" onkeyup="javascript:focusNextItem(this, 4, 'card_num4');" class="security" placeholder="1234"  pattern="[0-9]*" inputmode="numeric" maxLength="4" oninput="maxLengthCheck(this)"/>
                                -
                                <input type="number" name="card_num4" id="card_num4" onkeyup="javascript:focusNextItem(this, 4, 'CardAvailMonth');" class="security" placeholder="1234"  pattern="[0-9]*" inputmode="numeric"  maxLength="4" oninput="maxLengthCheck(this)"/>
                            </div>
                        </div>
                        <div class="input_section">
                            <label for="input_type_period" class="input_title">카드유효기간</label>
                            <div class="input_type_period">
                                <input type="number" id="CardAvailMonth" name="CardAvailMonth" onkeyup="javascript:focusNextItem(this, 2, 'CardAvailYear');" placeholder="MM" pattern="[0-9]*" inputmode="numeric"  maxLength="2" oninput="maxLengthCheck(this)"/>
                                /
                                <input type="number" id="CardAvailYear" name="CardAvailYear" placeholder="YY" pattern="[0-9]*" inputmode="numeric"  maxLength="2" oninput="maxLengthCheck(this)"/>
                            </div>
                        </div>
                        <div class="input_section" id="cardTypeSection">
                            <label for="select1" class="input_title">카드종류</label>
                            <div class="select_type1 select1">
                                <select name="cardType" id="cardType">
                                    <option value="01" selected="selected">개인</option>
                                    <option value="02">법인</option>
                                </select>
                            </div>
                        </div>
                        <div class="input_section" id="cardAuthNoSection">
                            <label for="p_num" class="input_title" id="cardTypeLabel">주민등록번호</label>
                            <div class="input_type1 p_num">
                                <input type="number" name="BuyerAuthNum" id="BuyerAuthNum" placeholder="앞6자리" pattern="[0-9]*" inputmode="numeric"  maxLength="6" oninput="maxLengthCheck(this)"/>
                            </div>
                        </div>
                        <div class="input_section" id="cardPwSection">
                            <label for="c_password" class="input_title">카드비밀번호</label>
                            <div class="input_type1 c_password">
                                <input type="number" class="security" id="CardPwd" name="CardPwd" placeholder="앞2자리" pattern="[0-9]*" inputmode="numeric"  maxLength="2" oninput="maxLengthCheck(this)"/>
                            </div>
                        </div>
                        <!-- <div class="input_section">
                            <label for="select2" class="input_title">할부개월</label>
                            <div class="select_type1 select2">
                                <select name="CardQuota" id="select2">
                                </select>
                            </div>
                        </div> -->
                    </section>
                    <%}%>
                </section>
    
                <section class="btn_wrap" id="nextBtnWrap">
                    <a class="btn_blue btn" href="#" onclick="return cardConfGoPay(frm)">다음</a>
                </section>
                
                <section class="btn_wrap_multi" id="payBtnWrap" style="display: none;">
                    <div>
                        <a class="btn_gray btn" href="#" onclick="showBuyerInfoPage()">취소</a>
                        <a class="btn_blue btn" href="#" onclick="return checkChangeDelivery(frm)">카드 결제요청</a>
                    </div>
                </section>
    
            </section>
        </form>
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
        
        <!--popup-->
        <div class="dim" style="display: none;"></div>
        <a href="#" class="btn_close pop_btn_close"></a>
        <div class="popup conditions_text">
            <h3 class="popup_title">개인정보 수집 및 이용동의</h3>
            <div class="popup_cont">
                <div class="popup_scroll">
                    <div class="popup_scroll_in">
                        <p>개인정보 수집 및 이용에 동의합니다.</p>
                        <p>회사는 서비스 제공을 위하여 아래와 같은 개인정보를 수집하고 있습니다.</p>
                        <p>■ 수집목적<br>·서비스 제공에 관한 계약 이행<br>·서비스 제공 과정 중 본인 식별, 인증, 실명확인 및 각종 안내/고지<br>·부정이용방지 및 비인가 사용방지<br>·서비스 제공 및 관련 업무처리에 필요한 동의, 철회 등 의사 확인</p>
                        <p>■ 수집항목<br>·구매자 정보 : 구매자명, 구매자 연락처, 주소<br>·대금 결제 정보: 카드사명, 카드소유자명, 카드명의자 생년월일, 카드번호, 유효기간, 할부 개월수, 구매자 카드서명, 접속 IP, 쿠키, 서비스 접속일, 서비스 이용기록, 불량 혹은 비정상 이용기록, 단말OS 등 서비스 제공을 위한 정보</p>
                        <p>■ 보유 및 이용기간<br>·보유기간 : 회원 등록기간<br>·이용기간 : 해당서비스 제공 기간<br>*수집한 개인정보는 수집 및 이용목적이 달성된 후에는 해당정보를 지체 없이 파기합니다</p>
                        <p>위의 개인정보 수집·이용에 대한 동의를 거부할 권리가 있습니다. 
                        그러나 동의를 거부 할 경우 원활한 서비스 제공에 일부 제한을 받을 수 있습니다.<br>
                        감사합니다.</p>
                    </div>
                </div>
            </div>  
            <div class="popup_btn_wrap"><a class="btn_close btn_gray btn" href="#">닫기</a></div>
        </div>  
        <!--//popup-->
        
    </body>

</html>
