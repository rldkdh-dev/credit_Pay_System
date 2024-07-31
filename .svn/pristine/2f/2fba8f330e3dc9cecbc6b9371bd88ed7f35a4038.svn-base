<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="java.net.SocketException"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.httpclient.HttpStatus"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@ include file="../../common/cardParameter.jsp" %>
<% 
	// Cache 의존 제거
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	System.out.println("input_EB_MPI.jsp Start -----------------------------------");
	
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
	
	String pointUseYN 	= CommonUtil.getDefaultStr(request.getParameter("pointUseYN"), "");
	String VbankExpDate = CommonUtil.getDefaultStr(request.getParameter("VbankExpDate"), "");
	String co_no 		= CommonUtil.getDefaultStr(request.getParameter("co_no"), "");
	String co_nm 		= CommonUtil.getDefaultStr(request.getParameter("co_nm"), "");
	String bankCd 		= CommonUtil.getDefaultStr(request.getParameter("formBankCd"), "");
	String prot = request.getScheme();
	String curPage = HttpUtils.getRequestURL(request).toString();
	String returnPage = prot + curPage.substring(curPage.indexOf(':'), curPage.lastIndexOf('/')) + "/mobileReturn.jsp";  
	
%>
<!DOCTYPE html>
<html>
    <head>
    <title>INNOPAY 전자결제서비스</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <script type="text/javascript" src="../../js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="../../js/jquery.mCustomScrollbar.js"></script>
        <script type="text/javascript" src="../../js/common.js" charset="utf-8"></script>
        <script type="text/javascript" src="../../js/card_pay_m.js" charset="utf-8"></script>
        <link rel="stylesheet" type="text/css" href="../../css/jquery.mCustomScrollbar.css" />
        <link rel="stylesheet" type="text/css" href="../../css/common.css" />
        <link href='../../css/font.css' rel='stylesheet' type='text/css'>
<script type="text/javascript">
	 
	function submitPage() {
         var frm = document.EBFORM;
         
         var af = document.getElementById("EBFRAME");
         af.style.display = 'block';
         af.style.height = '75%';
         af.style.width = '100%';

         frm.action = '<%=EB_CARD_ACSURL%>';
         frm.submit();
         return true;
         
	 }
	
	function goPayment(){		
		var formNm = document.tranMgr;
		formNm.action = "../payConfirm_card_m.jsp";
		formNm.submit();
	}
	
	function doEximbayValidate() {
		
		var frm = document.tranMgr;

	    frm.action = "./agent_validate_req_m.jsp";
	    frm.target="EXIMBAYFRAME";
	    frm.submit();
		return true;
		
	}
	
	function goBack(){
		
		var frm = document.tranMgr;

	    frm.action = "../inputForeign_card_m.jsp";
	    frm.target="_self";
	    frm.submit();
		return true;
		
	}
	
</script>
</head>
<body onload="javascript:submitPage();">
<form style="height:100%" name="tranMgr" method="post" action="">
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
<%-- <input type="hidden" name="quotabase"       value="<%=quotabase%>"/> --%>
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

<!-- EXIMBAY -->
<input type="hidden" name="EB_CARDNO" value="<%=EB_CARDNO%>">
<input type="hidden" name="EB_EXPIRYDT" value="<%=EB_EXPIRYDT%>">
<input type="hidden" name="EB_AUTHORIZEDID" value="<%=EB_AUTHORIZEDID%>">
<input type="hidden" name="EB_PARES" value="<%=EB_PARES%>">
<input type="hidden" name="EB_BASECUR" value="<%=EB_BASECUR%>">
<input type="hidden" name="EB_BASEAMT" value="<%=EB_BASEAMT%>">
<input type="hidden" name="EB_BASERATE" value="<%=EB_BASERATE%>">
<input type="hidden" name="EB_BFOREIGNCUR" value="<%=EB_BFOREIGNCUR%>">
<input type="hidden" name="EB_BFOREIGNAMT" value="<%=EB_BFOREIGNAMT%>">
<input type="hidden" name="EB_BFOREIGNRATE" value="<%=EB_BFOREIGNRATE%>">
<input type="hidden" name="EB_BDCCRATE" value="<%=EB_BDCCRATE%>">
<input type="hidden" name="EB_BDCCRATEID" value="<%=EB_BDCCRATEID%>">
<input type="hidden" name="EB_ECI" value="<%=EB_ECI%>">
<input type="hidden" name="EB_XID" value="<%=EB_XID%>">
<input type="hidden" name="EB_CAVV" value="<%=EB_CAVV%>">
<input type="hidden" name="EB_PARESSTATUS" value="<%=EB_PARESSTATUS%>">
<input type="hidden" name="EB_MD" value="<%=EB_MD%>">
<input type="hidden" name="EB_CVC" value="<%=EB_CVC%>">
<input type="hidden" name="EB_CARD_ACSURL" value="<%=EB_CARD_ACSURL%>">
<div class="innopay" >
    <section class="innopay_wrap" style="height:120%">

        <header class="gnb">
            <h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="../../images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
            <div class="kind">
                <span>신용카드결제</span>
            </div>
        </header>
        <div style="height:100%;width:100%;margin-top:46px;padding-top:5px;" align="center;position:absolute;">
            <iframe id="EBFRAME" name="EBFRAME" align="middle" style="display:none;" frameborder="0" src="../xansim/iframe.jsp" ></iframe>    
        </div>
    </section>
    <section class="footer">
        <span>INNOPAY 1688 - 1250</span>
    </section>
</div>
<div id="EXIMBAYDIV" style="display:none;">
<iframe id="EXIMBAYFRAME" name="EXIMBAYFRAME" border="0" style="width:100%;height:100%;" scrolling="no"></iframe>
</div>
</form>
<FORM name=EBFORM action="<%=EB_CARD_ACSURL%>" target=EBFRAME method=post>
	<input type="hidden" name="PaReq" value="<%=EB_CARD_PAREQ%>"/>
	<input type="hidden" name="TermUrl" value="<%=EB_CARD_TERMURL%>"/>
	<input type="hidden" name="MD" value="<%=EB_CARD_MD%>"/>
</FORM>
</body>
</html>