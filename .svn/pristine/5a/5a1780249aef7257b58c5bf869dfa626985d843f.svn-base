<%
/******************************************************************************
*
*   @ SYSTEM NAME       : 실시간계좌이체 앱 연동페이지
*   @ PROGRAM NAME      : sendBankTransinfo.jsp
*   @ MAKER             : 
*   @ MAKE DATE         : 2018.03.07
*   @ PROGRAM CONTENTS  : 실시간계좌이체 앱 연동페이지
*
************************** 변 경 이 력 *****************************************
* 번호    작업자     작업일             변경내용
*******************************************************************************/
%><%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*, java.text.*,java.net.InetAddress" %>
<%@ page import="service.SupportIssue" %>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%@ page import="kr.co.seeroo.spclib.SPCLib, org.json.simple.JSONObject"%>
<%@ page import="kr.co.infinisoft.pg.common.*" %>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%-- 공통 common include --%>
<%@ include file="../common/commonParameter.jsp" %>
<%-- 계좌이체 common parameter include --%>
<%@ include file="../common/bankParameter.jsp" %>
<%
//Cache 의존 제거
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

String hd_item_name = CommonUtil.getDefaultStr(request.getParameter("hd_item_name"), ""); // 상품명

String TID           = CommonUtil.getDefaultStr(request.getParameter("TID"), ""); // 거래번호
String tx_bill_yn    = CommonUtil.getDefaultStr(request.getParameter("tx_bill_yn"), "N"); // 
String tx_vat_yn     = CommonUtil.getDefaultStr(request.getParameter("tx_vat_yn"), "Y"); //
String sbp_tab_first = CommonUtil.getDefaultStr(request.getParameter("sbp_tab_first"), "N"); //
String callbackfunc  = CommonUtil.getDefaultStr(request.getParameter("callbackfunc"), ""); //
%>
<!DOCTYPE html>
<html>
    <head>
        <title>INNOPAY 전자결제서비스</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="../js/jquery.mCustomScrollbar.js"></script>
        <script type="text/javascript" src="../js/common.js" charset="utf-8"></script>
        <link rel="stylesheet" type="text/css" href="../css/jquery.mCustomScrollbar.css" />
        <link rel="stylesheet" type="text/css" href="../css/common.css" />
        <link href='../css/font.css' rel='stylesheet' type='text/css'>
<script type="text/javascript">
var m_interval = 1000;  // 1초
var m_count = 0;        // check count
var rtn = null;

$(document).ready(function(){
	var frm = document.bankForm;
	document.body.scrollTop = document.body.scrollHeight;
    if(frm.canHaveHTML) { // detect IE
        document.charset = frm.acceptCharset;
    }
    frm.target="VISIBLE";
    //frm.action = "https://pgtest.kftc.or.kr:7743/MobilePayMO.do"; // 테스트서버
    frm.action   = "https://www.bankpay.or.kr:7443/MobilePayMO.do"; // 운영서버
	frm.submit();
	
	var m_chk = setTimeout(checkBankdata, 10000);
});

function checkBankdata(){
	var resultcode = null;
	var bankpaycode = "";
	var frm = document.tranMgr;
    $.ajax({
        type : "POST",
        url : "./checkBankpayResult.jsp",
        async : true,
        data : $("#chkForm").serialize(),
        dataType : "json",
        success : function(data){
            resultcode = data.resultCode;
            console.log("checkBankpay resultCode ["+resultcode+"]");
            console.log("checkBankpay result bankpayCode["+data.bankpayCode+"]");
            if(resultcode=="0000"){
                // bankpayCode에 따른 분기처리
                bankpaycode = data.bankpayCode;
                if(bankpaycode=='000'){
                	frm.hd_pi.value = data.hdPi;
                    frm.hd_ep_type.value = data.hdEpType;
                    frm.action = "./payConfirm_m.jsp";
                    frm.submit();
                }else{
                	alert("결제인증이 정상처리되지 않았습니다.\n 다시 시도해 주시기 바랍니다.\n 오류코드["+bankpaycode+"]");
                	goClose();
                }
            }else if(resultcode=='9998'){
            	alert("결제인증이 정상처리되지 않았습니다.\n 다시 시도해 주시기 바랍니다.");
            	goClose();
            }else{
                if(m_count>600){
                    clearInterval(m_chk);
                    alert("결제시간이 초과되었습니다.\n 다시 시도해 주시기 바랍니다.");
                    goClose();
                }
                m_count++;
                setTimeout(function(){checkBankdata();}, m_interval);
                console.log("checkBankpay m_count ["+m_count+"]");
            }
        },
        error : function(data){
            //rtn = $.parseJSON(data.responseText);
            resultcode = data.resultCode;
            console.log("checkBankpay rtn.resultCode ["+resultcode+"]");
            if(m_count>600){
                alert("결제시간이 초과되었습니다.\n 다시 시도해 주시기 바랍니다.");
                goClose();
            }
            m_count++;
            console.log("checkBankpay m_count ["+m_count+"]");
            setTimeout(function(){checkBankdata();}, m_interval);
        }
    });
};
function goClose(){
	try{
		if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
			window.open('', '_self', '');
		    window.close();
		}else if((window.parent!=null&&window.parent!=undefined)||('X'=='<%=FORWARD%>')){
			window.parent.postMessage('close','*');
		}else{
			// FORWARD:N 지원안함
		}
	}catch(e){}
}
</script>

</head>
<body>
<form name="tranMgr" method="post" action="">
<input type="hidden" name="PayMethod"       value="<%=PayMethod%>">
<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>">
<input type="hidden" name="GoodsName"       value="<%=GoodsName%>">
<input type="hidden" name="GoodsURL"        value="<%=GoodsURL%>">
<input type="hidden" name="Amt"             value="<%=Amt%>">
<input type="hidden" name="Moid"            value="<%=Moid%>">
<input type="hidden" name="MID"             value="<%=MID%>">
<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>">
<input type="hidden" name="RetryURL"        value="<%=RetryURL%>">
<input type="hidden" name="mallUserID"      value="<%=mallUserID%>">
<input type="hidden" name="BuyerName"       value="<%=BuyerName%>">
<input type="hidden" name="BuyerAuthNum"    value="<%=BuyerAuthNum%>">
<input type="hidden" name="BuyerTel"        value="<%=BuyerTel%>">
<input type="hidden" name="BuyerEmail"      value="<%=BuyerEmail%>">
<input type="hidden" name="ParentEmail"     value="<%=ParentEmail%>">
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
<input type="hidden" name="FORWARD"        value="<%=FORWARD%>">
<input type="hidden" name="ResultYN"        value="<%=ResultYN%>">
<input type="hidden" name="EncryptData"    value="<%=EncryptData%>"> <!-- 거래검증값 추가(2018.08 hans) -->
<input type="hidden" name="ediDate"        value="<%=ediDate%>">
<!-- VBank -->
<input type="hidden" name="BankCode"   value="<%=BankCode%>"/>
<input type="hidden" name="cashReceiptType"   value="<%=cashReceiptType%>"/>
<input type="hidden" name="receiptTypeNo"   value="<%=receiptTypeNo%>"/>
<input type="hidden" name="receiptType"   value="<%=receiptType%>"/>

<%-- 계좌이체에서 사용하는 파라미터 --%>
<input type="hidden" name="hd_pre_msg_type" value="<%=hd_pre_msg_type%>">
<input type="hidden" name="hd_msg_code"     value="<%=hd_msg_code%>">
<input type="hidden" name="hd_msg_type"     value="<%=hd_msg_type%>">
<input type="hidden" name="hd_ep_type"      value="<%=hd_ep_type%>">
<input type="hidden" name="hd_pi"           value="<%=hd_pi%>">
<input type="hidden" name="hd_approve_no"   value="<%=hd_approve_no%>">
<input type="hidden" name="hd_serial_no"    value="<%=hd_serial_no%>">
<input type="hidden" name="hd_firm_name"    value="<%=hd_firm_name%>">
<input type="hidden" name="tx_amount"       value="<%=tx_amount%>">
<input type="hidden" name="tx_user_key"     value="<%=tx_user_key%>">
<input type="hidden" name="tx_user_define"  value="<%=tx_user_define%>">
<input type="hidden" name="tx_receipt_acnt" value="<%=tx_receipt_acnt%>">
<input type="hidden" name="hd_input_option" value="<%=hd_input_option%>">
<input type="hidden" name="hd_ep_option"    value="<%=hd_ep_option%>">
<input type="hidden" name="hd_timeout_yn"   value="<%=hd_timeout_yn%>">
<input type="hidden" name="hd_timeout"      value="<%=hd_timeout%>">
<input type="hidden" name="tx_email_addr"   value="<%=tx_email_addr%>">
<input type="hidden" name="TransType"       value="<%=TransType %>">

<div class="innopay">
    <section class="innopay_wrap">
        <header class="gnb">
            <h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="../images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
            <div class="kind">
                <span>계좌이체결제</span>
            </div>
        </header>
        
        <sction class="con_wrap" style="padding:0 0 50px 0;">
        	<iframe id="VISIBLE" name="VISIBLE" style="width:100%; height:588px;margin-top:-8px; display:block;"></iframe>
        </sction>
        
        <section class="btn_wrap" style="padding:9px 15px;position:fixed;bottom:0;left:0;background:#fff;">
        	<div>
               	<a class="btn_gray btn dim_btn btn_s" style="width:100%;margin:0;" href="javascript:goClose();">취소</a>
            </div>
        </section>
    </section>
</div>
</form>
<form name="bankForm" method="post" accept-charset="euc-kr" target="VISIBLE">
<input type="hidden" name="hd_pre_msg_type" value="<%=hd_pre_msg_type%>">
<input type="hidden" name="hd_msg_code"     value="<%=hd_msg_code%>">
<input type="hidden" name="hd_msg_type"     value="<%=hd_msg_type%>">
<input type="hidden" name="hd_ep_type"      value="<%=hd_ep_type%>">
<input type="hidden" name="hd_pi"           value="<%=hd_pi%>">
<input type="hidden" name="hd_approve_no"   value="<%=hd_approve_no%>">
<input type="hidden" name="hd_serial_no"    value="<%=hd_serial_no%>">
<input type="hidden" name="hd_firm_name"    value="<%=hd_firm_name%>">
<input type="hidden" name="hd_item_name"    value="<%=GoodsName%>">
<input type="hidden" name="tx_amount"       value="<%=tx_amount%>">
<input type="hidden" name="tx_bill_yn"       value="<%=tx_bill_yn%>">
<input type="hidden" name="tx_vat_yn"       value="<%=tx_vat_yn%>">
<input type="hidden" name="tx_user_key"     value="<%=tx_user_key%>">
<input type="hidden" name="tx_user_define"  value="<%=tx_user_define%>">
<input type="hidden" name="tx_receipt_acnt" value="<%=tx_receipt_acnt%>">
<input type="hidden" name="hd_input_option" value="<%=hd_input_option%>">
<input type="hidden" name="hd_ep_option"    value="<%=hd_ep_option%>">
<input type="hidden" name="hd_timeout_yn"   value="<%=hd_timeout_yn%>">
<input type="hidden" name="hd_timeout"      value="<%=hd_timeout%>">
<input type="hidden" name="tx_email_addr"   value="<%=tx_email_addr%>">
<input type="hidden" name="sbp_tab_first"   value="<%=sbp_tab_first%>">

<input type="hidden" name="title" value="INNOPAY 전자결제서비스"/>
<input type="hidden" name="method" value="POST"/>
<input type="hidden" name="callbackparam1" value="<%=TID%>"/>
<input type="hidden" name="callbackparam2" value=""/>
<input type="hidden" name="callbackparam3" value=""/>
<input type="hidden" name="callbackparam4" value=""/>
<input type="hidden" name="callbackparam5" value=""/>
<input type="hidden" name="callbackfunc" value="<%=callbackfunc%>"/>
</form>
<form name="chkForm" id="chkForm" method="post">
    <input type="hidden" name ="TID" value="<%=TID%>"/>
</form>
</body>
</html>