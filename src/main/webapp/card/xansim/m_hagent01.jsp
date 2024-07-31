<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page errorPage="error.jsp?status=m_hagent01" %>
<%@ page import="com.polaris.MallEncSimple" %>
<%@ page import="mobile.*, service.*, util.*" %>
<%
    // 설치관련 사항 문의
    // 폴라리스 : 차승욱 팀장  010-2987-5223
    // 폴라리스 : 최재영 과장  010-5211-5826
    // 폴라리스 : 정병록 과장  010-3523-0386
    // 폴라리스 : 한지승 과장  010-3225-2420
    response.setHeader("P3P", "CP='NOI CURa ADMa DEVa TAIa OUR DELa BUS IND PHY ONL UNI COM NAV INT DEM PRE'");

    response.setHeader("cache-control","no-cache");
    response.setHeader("expires","-1");
    response.setHeader("pragma","no-cache");

    //한글처리...
    request.setCharacterEncoding("UTF-8");
    
    System.out.println("---- m_hagent01.jsp start ----");
    /////////////////////////////////////////////////////////////////////
    //PG사 영역 시작
    //이부분은 pg사에서 하위쇼핑몰을 체크하기위해 필요한것들은 추가하시면 됩니다
    //변수명 변경및 추가 원하실경우는 pg사에 배포된 hostagent01을 수정하시면 됩니다.
    //예) 아아디 ,패스워드
    /////////////////////////////////////////////////////////////////////
    //쇼핑몰은 PG사로 부터 발급받으신 아이디 패스워드를 입력하세요.

    String X_MALLID="TESTID";
    String X_MALL_PASS="123456";
    /////////////////////////////////////////////////////////////////////
    //PG사 영역 끝
    /////////////////////////////////////////////////////////////////////

    /////////////////////////////////////////////////////////////////////
    //XMPI 영역 시작
    /////////////////////////////////////////////////////////////////////

    // [필수] Display Name (인증창에 출력할 쇼핑몰명)
    String X_MNAME=CommonUtil.getDefaultStr(request.getParameter("order_goods"),"");
    
    // [필수] 쇼핑몰 경우 : 쇼핑몰 사업자번호
    String X_MBUSINESSNUM= CommonUtil.getDefaultStr(request.getParameter("order_business"),"");
    
    // [필수] 금액(숫자로만, 콤마, 소수점 불가)
    // 원화 : 1000 = 1000원 , 미화: 1000 = 10.00 달러
    String X_AMOUNT = CommonUtil.getDefaultStr(request.getParameter("order_amount"),"");

    // [필수] 통화(410:원화, 840:미화)
    String X_CURRENCY=CommonUtil.getDefaultStr(request.getParameter("order_currency"),"410");
    
    // [필수] 선택된 카드사명
    // 'SAMSUNGCARD' 'HYUNDAICARD' 'SHINHANCARD' 'NONGHYUPCARD'
    String X_CARDTYPE=CommonUtil.getDefaultStr(request.getParameter("order_cardname"),"");
    
    // [필수] 호스팅 쇼핑몰 응답받을 URL :
    String X_MERCHANT_RECEIVEURL="https://pg.innopay.co.kr/ipay/card/xansim/m_hagent02.jsp";
    if (request.getServerPort() == 80 || request.getServerPort() == 443) {
        X_MERCHANT_RECEIVEURL = request.getScheme() + "://" + request.getServerName() +"/ipay/card/xansim/m_hagent02.jsp";
    } else {
        X_MERCHANT_RECEIVEURL = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort()+"/ipay/card/xansim/m_hagent02.jsp";
    } 
    
//  ------------------------------------------
    // 2007.06.11
    // 삼성카드 인증요청 추가 Field
    //------------------------------------------
    String X_CHAIN_NO_SS = "";
    String X_SELLER_ID = "";
    if (X_CARDTYPE.equals("SAMSUNGCARD")) {
        // X_CHAIN_NO_SS : 승인요청시 사용되는 가맹점번호를 세팅하세요.
        X_CHAIN_NO_SS = CommonUtil.getDefaultStr(request.getParameter("order_fnno"),"00000000");
        // apvl_seller_id : 승인요청시 사용되는 가맹점의 사업자번호를 세팅하세요.
        X_SELLER_ID = "1248702232";
    }
    
//  -----------------------------------------------
    //2008.09.19 : 슈퍼세이브 관련 
    //현대카드 인증요청전문 Field 추가!!!
    //-----------------------------------------------
    String X_CHAIN_NO_HD = "";
    String X_SELLER_ID_HD = "";
    String X_SS_USEYN_HD = "";
    if (X_CARDTYPE.equals("HYUNDAICARD")) {
        X_CHAIN_NO_HD = "00000000";
        X_SELLER_ID_HD = "1248702232";
        X_SS_USEYN_HD = ""; // N : 세이브 사용안함, 그외 : 세이브 사용
    }
    
    //------------------------------------------
    //------------------------------------------
    //2009.02.18 : 하이세이브
    //신한카드 인증요청전문 Field 추가!!!
    //2012.12.03 : 제주은행 추가.
    //------------------------------------------
    String X_CHAIN_NO_SH = "";
    String X_SELLER_ID_SH = "";
    String X_SS_USEYN_SH = "";
    if (X_CARDTYPE.equals("SHINHANCARD")) {
      //신한카드사 가맹점 번호를 세팅하세요.
      //제주은행도 신한카드사 가맹점 번호를 세팅하세요.
        X_CHAIN_NO_SH = "0000000000";
        X_SELLER_ID_SH = "1248702232";
        X_SS_USEYN_SH = "N"; // N : 세이브 사용안함, 그외 : 세이브 사용
    }   
    
    //-----------------------------------------------
    //2010.08 : 세이브 관련 
    //NH카드 인증요청전문 Field 추가!!!
    //-----------------------------------------------
    String X_CHAIN_NO_NH = "";
    String X_SELLER_ID_NH = "";
    String X_SS_USEYN_NH = "";
    if (X_CARDTYPE.equals("NONGHYUPCARD")) {
        X_CHAIN_NO_NH = "0000000000";
        X_SELLER_ID_NH = "1248702232";
        X_SS_USEYN_NH = ""; // N : 세이브 사용안함, 그외 : 세이브 사용
    }   

    String X_SP_CHAIN_CODE=CommonUtil.getDefaultStr(request.getParameter("sp_chain_code"),"0");

    String X_SP_ORDER_USER_ID= CommonUtil.getDefaultStr(request.getParameter("order_userid"),"");
    
    //2011.04월 삼성카드사 간편결제 추가
    //------------------------------------------
    // [옵션] 삼성카드사 간편결제 쇼핑몰 개인회원 KEY
    // 삼성카드만 해당됨.
    // 삼성카드사에 주민번호를 단방향  암호화(SHA256) 해서 전송하는 부분에 대한 보안성 적합여부는 삼성카드사에 문의요망
    // 삼성카드사에 간편결제 가맹점으로 등록된 쇼핑몰의 경우만 결제가 진행됨
    // MallEncSimple.getMallEncSimpleId()를  사용하기 위해서는 xmpi에서 추가로 배포하는 MallEnc.jar를 서버에 설치후 사용가능 
    //------------------------------------------
    //간편결제선택여부 

    //간편결제를 선택한 회원의 주민번호를 암호화 하여 삼성카드사에 전송한다.
    if (X_CARDTYPE.equals("SAMSUNGCARD") && "1".equals(X_SP_CHAIN_CODE)) {
        //삼성카드 간편결제 쇼핑몰키 
        //고객의 주민번호를 인자값으로 넘겨야 한다. - 없이 넘겨야한다. : 
        X_SP_ORDER_USER_ID=MallEncSimple.getMallEncSimpleId("1234569876543");
    }

    //2011.09월 현대카드사 간편결제 추가
    //------------------------------------------
    // [옵션] 간편결제 쇼핑몰 개인회원 KEY
    // 간편결제 가맹점으로 등록된 쇼핑몰의 경우만 결제가 진행됨
    // MallEncSimple.getMallEncSimpleId()를  사용하기 위해서는 xmpi에서 추가로 배포하는 MallEnc.jar를 서버에 설치후 사용가능 
    //------------------------------------------
    //간편결제선택여부 
    //간편결제를 선택한 회원의 고객키를 암호화 하여 현대카드사에 전송한다.
    //PC에서 간편결제를 적용했을경우 PC에서 사용하는 동일한 고객키를 사용해야한다.
    //PC ,모바일상의 고객키가 틀리면 재가입해야한다.
    if (X_CARDTYPE.equals("HYUNDAICARD") && "1".equals(X_SP_CHAIN_CODE)) {
        //간편결제 쇼핑몰키 
        //고객키를 넘겨야 한다.
        //쇼핑몰 고유닉 + 고객 고유 key
        X_SP_ORDER_USER_ID=MallEncSimple.getMallEncSimpleId(X_MNAME+"1234569876543");
    }
    
    //------------------------------------------
    // 2014.10
    // 농협카드 간편결제 관련 추가 
    // 쇼핑몰 고객키를 넘기면됨
    //------------------------------------------
    //간편결제를 선택한 회원의 쇼핑몰 자체 고객키값을 전송.
    if (X_CARDTYPE.equals("NONGHYUPCARD") && "1".equals(X_SP_CHAIN_CODE)) {
        //농협은 간편결제 코드가 5
        X_SP_CHAIN_CODE = "5";
        //간편결제 쇼핑몰키 
        //고객키를 넘겨야 한다.      
        X_SP_ORDER_USER_ID=MallEncSimple.getMallEncSimpleId("1234569876543");
    }
    
    String X_HOSTURL="";
    String X_RECEIVEURL="";
    if ("SAMSUNGCARD".equals(X_CARDTYPE)){
        X_HOSTURL="https://vbv.samsungcard.co.kr/VbV/host/m_hostAgent01.jsp";
        X_RECEIVEURL="https://vbv.samsungcard.co.kr/VbV/host/m_hostAgent12.jsp";
    }else if ("HYUNDAICARD".equals(X_CARDTYPE)){
        X_HOSTURL="https://ansimclick.hyundaicard.com/host/m_hostAgent01.jsp";
        X_RECEIVEURL="https://ansimclick.hyundaicard.com/host/m_hostAgent12.jsp";
    }else if ("SHINHANCARD".equals(X_CARDTYPE)){
        X_HOSTURL="https://vbv.shinhancard.com/host/m_hostAgent01.jsp";
        X_RECEIVEURL="https://vbv.shinhancard.com/host/m_hostAgent12.jsp";
    }else if ("NONGHYUPCARD".equals(X_CARDTYPE)){
        X_HOSTURL="https://vbv.nonghyup.com/host/m_hostAgent01.jsp";
        X_RECEIVEURL="https://vbv.nonghyup.com/host/m_hostAgent12.jsp";
        X_RECEIVEURL = URLEncoder.encode(X_RECEIVEURL, "UTF-8");
    }else {
        throw new Exception("안심클릭 서비스가 지원되지 않은 카드사[" + X_CARDTYPE + "]입니다.");
        //out.println("서비스 할수 없습니다.");
    }
    System.out.println("호스팅 URL:" + X_HOSTURL);
    
    if ("SAMSUNGCARD".equals(X_CARDTYPE)){
        X_CARDTYPE="51";
    }else if ("HYUNDAICARD".equals(X_CARDTYPE)){
        X_CARDTYPE="61";
    }else if ("NONGHYUPCARD".equals(X_CARDTYPE)){
        X_CARDTYPE="91";
    }    
    /////////////////////////////////////////////////////////////////////
    //XMPI 영역 끝
    /////////////////////////////////////////////////////////////////////
%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<!--
    모바일 버젼은  액티브 X를 미지원 합니다.
-->
<script type="text/javascript">
<!--
function openXansim() {
    document.X_ANSIMFORM.action="<%=X_HOSTURL%>";
    document.X_ANSIMFORM.method="post";
    document.X_ANSIMFORM.submit();
}
-->
</script>
</HEAD>
<BODY onload="openXansim();">
<form name="X_ANSIMFORM" method="post">
    <input type=hidden name="X_MALLID" value="<%=X_MALLID%>">
    <input type=hidden name="X_MALL_PASS" value="<%=X_MALL_PASS%>">
    <input type=hidden name="X_MNAME" value="<%=X_MNAME%>">
    <input type=hidden name="X_MBUSINESSNUM" value="<%=X_MBUSINESSNUM%>">
    <input type=hidden name="X_AMOUNT" value="<%=X_AMOUNT%>">
    <input type=hidden name="X_CURRENCY" value="<%=X_CURRENCY%>">
    <input type=hidden name="X_CARDTYPE" value="<%=X_CARDTYPE%>">
    <input type=hidden name="X_MERCHANT_RECEIVEURL" value="<%=X_MERCHANT_RECEIVEURL%>">
    <input type=hidden name="X_SP_CHAIN_CODE" value="<%=X_SP_CHAIN_CODE%>" >
    <input type=hidden name="X_SP_ORDER_USER_ID" value="<%=X_SP_ORDER_USER_ID%>" >
    <input type=hidden name="X_RECEIVEURL" value="<%=X_RECEIVEURL%>">
    <!-- 삼성카드관련 추가 파라미터 -->
    <input type=hidden name="X_CHAIN_NO_SS" value="<%=X_CHAIN_NO_SS%>">
    <input type=hidden name="X_SELLER_ID" value="<%=X_SELLER_ID%>">
    <!-- 현대카드관련 추가 파라미터 -->
    <input type=hidden name="X_CHAIN_NO_HD" value="<%=X_CHAIN_NO_HD%>">
    <input type=hidden name="X_SELLER_ID_HD" value="<%=X_SELLER_ID_HD%>">
    <input type=hidden name="X_SS_USEYN_HD" value="<%=X_SS_USEYN_HD%>">
    <!-- 신한카드관련 추가 파라미터 -->
    <input type=hidden name="X_CHAIN_NO_SH" value="<%=X_CHAIN_NO_SH%>">
    <input type=hidden name="X_SELLER_ID_SH" value="<%=X_SELLER_ID_SH%>">
    <input type=hidden name="X_SS_USEYN_SH" value="<%=X_SS_USEYN_SH%>">
    <!-- NH카드관련 추가 파라미터 -->
    <input type=hidden name="X_CHAIN_NO_NH" value="<%=X_CHAIN_NO_NH%>">
    <input type=hidden name="X_SELLER_ID_NH" value="<%=X_SELLER_ID_NH%>">
    <input type=hidden name="X_SS_USEYN_NH" value="<%=X_SS_USEYN_NH%>">
    <!--2011.04월 신한카드사 스마트폰 공인인증 결제 적용함-->
    <!--2012.03월 현대카드사 스마트폰 공인인증 결제 적용함-->
    <!--10. [옵션]쇼핑몰 어플 스키마  예) 아이폰 결제시: yes24://  , 사파리결제시 : 공백 -->
    <input type="hidden" name="MALL_APP_NAME" value="">
    <!--11. [옵션]안심클릭 공인인증 결제 사용여부 : 아이폰에서만 적용됨(모든금액) 예) 사용 : "Y" -->
    <input type="hidden" name="ISMART_USE_SIGN" value="">
</form>
</BODY>
</HTML>