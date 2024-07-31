<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="service.SupportIssue" %>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%@ page import="kr.co.seeroo.spclib.SPCLib, org.json.simple.JSONObject"%>
<%@ page import="kr.co.infinisoft.pg.common.*" %>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%
/*
 * Do not cache this page.
 */
response.setHeader("cache-control","no-cache");
response.setHeader("expires","-1");
response.setHeader("pragma","no-cache");

request.setCharacterEncoding("utf-8");

//파라미터 체크
String PayMethod        = CommonUtil.getDefaultStr(request.getParameter("PayMethod"), "");
String payType          = CommonUtil.getDefaultStr(request.getParameter("payType"), ""); // 사용안함
String GoodsCnt         = CommonUtil.getDefaultStr(request.getParameter("GoodsCnt"), "");
String GoodsName        = CommonUtil.getDefaultStr(request.getParameter("GoodsName"), "");
String GoodsURL         = CommonUtil.getDefaultStr(request.getParameter("GoodsURL"), ""); // 사용안함
String GoodsCl          = CommonUtil.getDefaultStr(request.getParameter("GoodsCl"), ""); // 상품구분 (1:컨텐츠/2:현물), 사용안함
String Amt              = CommonUtil.getDefaultStr(request.getParameter("Amt"), ""); 
String DutyFreeAmt		= CommonUtil.getDefaultStr(request.getParameter("DutyFreeAmt"), "0");	// 면세관련 필드 추가 (2019.04 hans)
String TaxAmt			= CommonUtil.getDefaultStr(request.getParameter("TaxAmt"), "0");		// 면세관련 필드 추가 (2019.04 hans)
String Moid             = CommonUtil.getDefaultStr(request.getParameter("Moid"), "");
String MID              = CommonUtil.getDefaultStr(request.getParameter("MID"), "");
String ReturnURL        = CommonUtil.getDefaultStr(request.getParameter("ReturnURL"), "");
String ResultYN         = CommonUtil.getDefaultStr(request.getParameter("ResultYN"), "");
String RetryURL         = CommonUtil.getDefaultStr(request.getParameter("RetryURL"), "");
String mallUserID       = CommonUtil.getDefaultStr(request.getParameter("mallUserID"), "");
String BuyerName        = CommonUtil.getDefaultStr(request.getParameter("BuyerName"), "");
String BuyerAuthNum     = CommonUtil.getDefaultStr(request.getParameter("BuyerAuthNum"), ""); // 수기결제용
String BuyerTel         = CommonUtil.getDefaultStr(request.getParameter("BuyerTel"), "");
String BuyerEmail       = CommonUtil.getDefaultStr(request.getParameter("BuyerEmail"), "");
String BuyerAddr        = CommonUtil.getDefaultStr(request.getParameter("BuyerAddr"), "");    // 사용안함
String BuyerPostNo      = CommonUtil.getDefaultStr(request.getParameter("BuyerPostNo"), "");  // 사용안함
String ParentEmail      = CommonUtil.getDefaultStr(request.getParameter("ParentEmail"), "");  // 사용안함
String UserIP           = CommonUtil.getDefaultStr(request.getParameter("UserIP"), "");
String MallIP           = CommonUtil.getDefaultStr(request.getParameter("MallIP"), "");
String BrowserType      = CommonUtil.getDefaultStr(request.getParameter("BrowserType"), "");
String ediDate          = CommonUtil.getDefaultStr(request.getParameter("ediDate"), "");
String EncryptData      = CommonUtil.getDefaultStr(request.getParameter("EncryptData"), "");   
String MallReserved     = CommonUtil.getDefaultStr(request.getParameter("MallReserved"), "");
String MallResultFWD    = CommonUtil.getDefaultStr(request.getParameter("MallResultFWD"), "");
String SUB_ID           = CommonUtil.getDefaultStr(request.getParameter("SUB_ID"), "");     // 사용안함  
String TransType        = CommonUtil.getDefaultStr(request.getParameter("TransType"), "");  // 결제타입 [0 : 일반결제 , 1 : 에스크로 결제]
String EncodingType     = CommonUtil.getDefaultStr(request.getParameter("EncodingType"), "");  
String OfferingPeriod   = CommonUtil.getDefaultStr(request.getParameter("OfferingPeriod"), "");
String device           = CommonUtil.getDefaultStr(request.getParameter("device"), "");
String svcCd            = CommonUtil.getDefaultStr(request.getParameter("svcCd"), "");        // 지불수단
String svcPrdtCd        = CommonUtil.getDefaultStr(request.getParameter("svcPrdtCd"), "");    // sub지불수단
//card sms
String OrderCode        = CommonUtil.getDefaultStr(request.getParameter("OrderCode"),"");
String ExpTerm          = CommonUtil.getDefaultStr(request.getParameter("ExpTerm"),"1440");

String User_ID          = CommonUtil.getDefaultStr(request.getParameter("User_ID"), "");
String Pg_Mid           = CommonUtil.getDefaultStr(request.getParameter("Pg_Mid"), "");
String BuyerCode        = CommonUtil.getDefaultStr(request.getParameter("BuyerCode"), "");

// 카드코드 지정 파라미터 관련하여 아래 formBankCd 파라미터 추가 - 2015/11/04 added by GWK
String formBankCd       = CommonUtil.getDefaultStr(request.getParameter("formBankCd"), "");

// for VBank
String VbankExpDate     = CommonUtil.getDefaultStr(request.getParameter("VbankExpDate"), ""); // 가상계좌 입금 마감일
String BankCode         = CommonUtil.getDefaultStr(request.getParameter("BankCode"), "");       // 은행코드
String VBankAccountName = CommonUtil.getDefaultStr(request.getParameter("VBankAccountName"), "");
String cashReceiptType  = CommonUtil.getDefaultStr(request.getParameter("cashReceiptType"), "3");       // 현금영수증 발급구분(1:소득공제용,2:지출증빙,3:미발행)
String receiptTypeNo    = CommonUtil.getDefaultStr(request.getParameter("receiptTypeNo"), "");          // 현금영수증 발급번호
String receiptType      = CommonUtil.getDefaultStr(request.getParameter("receiptType"), "");            // 발급구분(1:휴대폰,2:주민번호,3:신용카드번호)
String FORWARD	    	= CommonUtil.getDefaultStr(request.getParameter("FORWARD"), "X");
String RefererURL    	= CommonUtil.getDefaultStr(request.getParameter("RefererURL"), "");

// 상품명이 긴 경우 38자미만으로 잘라낸다.
GoodsName = CommonUtil.cutStr(GoodsName, 38);
%>
<%-- 계좌이체 common parameter include --%>
<%@ include file="../common/bankParameter.jsp" %>
<%
/* 공통 파라미터 Set */
    String TID     = CommonUtil.getDefaultStr(request.getParameter("TID"), "");

/*
 *  Get the form variable and HTTP header
 */
 String hd_item_name    = request.getParameter("hd_item_name");
 
 String tx_bill_yn      = request.getParameter("tx_bill_yn");
 String tx_vat_yn       = request.getParameter("tx_vat_yn");
 String tx_bill_vat     = request.getParameter("tx_bill_vat");
 String tx_svc_charge   = request.getParameter("tx_svc_charge");
 String tx_bill_tax     = request.getParameter("tx_bill_tax");
 String tx_bill_deduction = request.getParameter("tx_bill_deduction");
 String tx_age_check    = request.getParameter("tx_age_check");
  
 String sbp_service_use = request.getParameter("sbp_service_use");
 String sbp_tab_first   = request.getParameter("sbp_tab_first");
 String tx_returnURL       = request.getParameter("tx_returnURL");
  
 String tx_guarantee        = request.getParameter("tx_guarantee");

if (hd_msg_code == null || hd_msg_code.equals(""))              hd_msg_code = "0200";
if (hd_msg_type == null || hd_msg_type.equals(""))              hd_msg_type = "EFT";
if (hd_ep_type == null || hd_ep_type.trim().equals(""))         hd_ep_type = "SECUCERT";
if (hd_approve_no == null || hd_approve_no.equals(""))          hd_approve_no = "";
if (hd_serial_no == null || hd_serial_no.equals(""))            hd_serial_no = "";
if (hd_firm_name == null || hd_firm_name.equals(""))            hd_firm_name = "";
if (hd_item_name == null || hd_item_name.equals(""))            hd_item_name = "";
if (tx_amount == null || tx_amount.equals(""))                  tx_amount = "";

if (tx_bill_yn == null || tx_bill_yn.equals(""))                tx_bill_yn = "N";  //
if (tx_vat_yn == null || tx_vat_yn.equals(""))                  tx_vat_yn = "";
if (tx_bill_vat == null || tx_bill_vat.equals(""))              tx_bill_vat = ""; // 미입력시 자동계산
if (tx_svc_charge == null || tx_svc_charge.equals(""))          tx_svc_charge = "";
if (tx_bill_tax == null || tx_bill_tax.equals(""))              tx_bill_tax = "";
if (tx_bill_deduction == null || tx_bill_deduction.equals(""))  tx_bill_deduction = "";
if (tx_age_check == null || tx_age_check.equals(""))            tx_age_check = "";

if (hd_timeout == null || hd_timeout.equals(""))                hd_timeout = "300000";
if (sbp_service_use == null || sbp_service_use.equals(""))      sbp_service_use = "Y";
if (sbp_tab_first == null || sbp_tab_first.equals(""))          sbp_tab_first = "Y";
if (tx_returnURL == null || tx_returnURL.equals(""))            tx_returnURL = "payConfirm.jsp";
if (tx_guarantee == null || tx_guarantee.equals(""))            tx_guarantee = "N";
if (tx_user_key == null || tx_user_key.equals(""))              tx_user_key = "";

String ret = HttpUtils.getRequestURL(request).toString();
String termUrl = ret.substring(0, ret.lastIndexOf("/")) + "/auth_host.jsp";
tx_returnURL = ret.substring(0, ret.lastIndexOf("/")) + "/payConfirm.jsp";

String auth_msg = "";
boolean result = false;

if(hd_approve_no.equals("")){
    result = false;
    auth_msg = "hd_approve_no is null";
} else if(hd_serial_no.equals("")){
    result = false;
    auth_msg = "hd_serial_no is null";
} else if(hd_firm_name.equals("")){
    result = false;
    auth_msg = "hd_firm_name is null";
} else if(tx_amount.equals("")){
    result = false;
    auth_msg = "tx_amount is null";
} else {
    result = true;
}

System.out.println("==== hd_ep_type ["+hd_ep_type+"]");
// Operation succeeded 
if (result) 
{

%>
<html>
    <head>
        <title>금융결제원 뱅크페이</title>
    </head>
    <body OnLoad="onLoadProc();">
        <script type="text/JavaScript">
            var cnt = 0;
            var timeout = 600;
            var k_timeout = 1;
            var processed = false;
            var goon = false;
            var childwin = null;
        
            function popupIsClosed()
            {
                if(childwin) {
                    if(childwin.closed) {
                        if( !goon ) {
                            if( !processed ) {
                                processed = true;
                                self.setTimeout("popupIsClosed()", 2000);
                            } else popError("인증처리 중 문제가 발생하였습니다.(1)");
                        }
                    } else {
                        cnt++;
                        if(cnt > timeout) {
                            popError("작업시간이 초과되었습니다.");
                        } else {
                            self.setTimeout("popupIsClosed()", 1000);
                        }
                    }
                } else if ( childwin == null ) {
                    cnt++;
                    if ( cnt > k_timeout ) {
                        popError("팝업창이 차단되었습니다. 팝업 차단을 해제해 주십시오.");
                    } else {
                        self.setTimeout("popupIsClosed()", 1000);
                    }
                    
                } else {
                    popError("인증처리 중 문제가 발생하였습니다.(2)");
                }
                parent.clearSubmitCnt();
            }

            function popError(arg)
            {
                if( childwin ) {
                    childwin.close();
                }
                alert(arg);
            }

            function onLoadProc() 
            {           
                leftPosition = (screen.width-720)/2-10;
                topPosition = (screen.height-600)/2-50;
                childwin = window.open('about:blank','BANKPAYPOPUP', 'top='+topPosition+',left='+leftPosition+',height=600,width=720,status=no,dependent=no,scrollbars=no,resizable=no');
                
                document.postForm.target = 'BANKPAYPOPUP';
                document.postForm.submit();
                popupIsClosed();
            }
        
            
            function paramSet(hd_pi, hd_ep_type)
            {
                var frm = document.frmRet;
                frm.hd_pi.value = hd_pi;
                frm.hd_ep_type.value = hd_ep_type;
            }

            function proceed() {
                var frm = document.frmRet;
                frm.target="_parent";
                goon = true;
                emulAcceptCharset(frm);
                frm.submit();
            }
            
            function emulAcceptCharset(form) {
                if (form.canHaveHTML) { // detect IE
                    document.charset = "utf-8";
                }
                return true;
            }
        </Script>
        <form name="postForm" action="https://www.bankpay.or.kr:7443/StartBankPay.do" method="POST">
        <!-- <form name="postForm" action="https://pgtest.kftc.or.kr:7743/StartBankPay.do" method="POST"> -->
            <input type=hidden name=hd_msg_code     value="<%=hd_msg_code%>">
            <input type=hidden name=hd_msg_type     value="<%=hd_msg_type%>">
            <input type=hidden name=hd_ep_type      value="<%=hd_ep_type%>">
            <input type=hidden name=hd_approve_no   value="<%=hd_approve_no%>">
            <input type=hidden name=hd_serial_no    value="<%=hd_serial_no%>">
            <input type=hidden name=hd_firm_name    value="<%=hd_firm_name%>">
            <input type=hidden name=hd_item_name    value="<%=hd_item_name%>">
            <input type=hidden name=tx_amount       value="<%=tx_amount%>">
            <!-- 현금영수증 관련 파라미터 -->
            <input type=hidden name=tx_bill_yn      value="<%=tx_bill_yn%>">
            <input type=hidden name=tx_vat_yn       value="<%=tx_vat_yn%>">
            <input type=hidden name=tx_bill_vat     value="<%=tx_bill_vat%>">
            <input type=hidden name=tx_svc_charge   value="<%=tx_svc_charge%>">
            <input type=hidden name=tx_bill_tax     value="<%=tx_bill_tax%>">
            <input type=hidden name=tx_bill_deduction   value="<%=tx_bill_deduction%>">
            
            <input type=hidden name=tx_age_check    value="<%=tx_age_check%>">
            <input type=hidden name=tx_email_addr    value="<%=BuyerEmail%>">
            
            <input type=hidden name=hd_timeout      value="<%=hd_timeout%>">
            <input type=hidden name=sbp_service_use value="<%=sbp_service_use%>">
            <input type=hidden name=sbp_tab_first   value="<%=sbp_tab_first%>">
            <input type=hidden name=termURL         value="<%=termUrl%>">
            
            <input type=hidden name=tx_guarantee    value="<%=tx_guarantee%>">
            <input type=hidden name=tx_user_key     value="<%=tx_user_key%>">
        </form>
        
        <form name=frmRet method=post action="<%=tx_returnURL%>" accept-charset="utf-8">
            <!-- 암호화된 결제정보 파라미터 -->
            <input type=hidden name=hd_pi           value="">
            <input type=hidden name=hd_ep_type      value="">
            <input type=hidden name=hd_msg_code     value="<%=hd_msg_code%>">
            <input type=hidden name=hd_msg_type     value="<%=hd_msg_type%>">
            <input type=hidden name=hd_approve_no   value="<%=hd_approve_no%>">
            <input type=hidden name=hd_serial_no    value="<%=hd_serial_no%>">
            <input type=hidden name=hd_firm_name    value="<%=hd_firm_name%>">
            <input type=hidden name=hd_item_name    value="<%=hd_item_name%>">
            <input type=hidden name=tx_amount       value="<%=tx_amount%>">
            <!-- 현금영수증 관련 파라미터 -->
            <input type=hidden name=tx_bill_yn      value="<%=tx_bill_yn%>">
            <input type=hidden name=tx_vat_yn       value="<%=tx_vat_yn%>">
            <input type=hidden name=tx_bill_vat     value="<%=tx_bill_vat%>">
            <input type=hidden name=tx_svc_charge   value="<%=tx_svc_charge%>">
            <input type=hidden name=tx_bill_tax     value="<%=tx_bill_tax%>">
            <input type=hidden name=tx_bill_deduction   value="<%=tx_bill_deduction%>">
            <input type=hidden name=tx_age_check    value="<%=tx_age_check%>">
            <input type=hidden name=hd_timeout      value="<%=hd_timeout%>">
            <input type=hidden name=tx_guarantee      value="<%=tx_guarantee%>">
            <input type=hidden name=tx_user_key     value="<%=tx_user_key%>">
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
		<input type="hidden" name="BuyerEmail"        value="<%=BuyerEmail%>">
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
		<input type="hidden" name="OfferingPeriod"   value="<%=OfferingPeriod%>"/> 
		<input type="hidden" name="device"      value="<%=device%>">
		<input type="hidden" name="svcCd"      value="<%=svcCd%>">
		<input type="hidden" name="svcPrdtCd"      value="<%=svcPrdtCd%>">
		<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
		<input type="hidden" name="User_ID"         value="<%=User_ID%>">
		<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
		<input type="hidden" name="BuyerCode"      value="<%=BuyerCode%>">
		<input type="hidden" name="cashReceiptType"   value="<%=cashReceiptType%>"/>
        <input type="hidden" name="receiptTypeNo"   value="<%=receiptTypeNo%>"/>
        <input type="hidden" name="receiptType"   value="<%=receiptType%>"/>
        <input type="hidden" name="FORWARD"        value="<%=FORWARD%>">
        <input type="hidden" name="ResultYN"        value="<%=ResultYN%>">
        <input type="hidden" name="EncryptData"    value="<%=EncryptData%>"> <!-- 거래검증값 추가(2018.08 hans) -->
        <input type="hidden" name="ediDate"        value="<%=ediDate%>">
        <input type="hidden" name="RefererURL" value="<%=RefererURL%>">
        </form>
    </body>
</html>
<%
            return; // done successfully
} 

// parameter is wrong
%>
<html>
    <script type="text/javascript">
        function onLoadProc()
        {
            if( "<%=auth_msg%>" != "" ) {
                alert("<%=auth_msg%>");
            }      
        }
    </script>
    <body onload="javascript:onLoadProc();"> 
    </body>
</html>
