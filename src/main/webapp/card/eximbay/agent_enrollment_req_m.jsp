<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"  %>
<%@ page import="java.util.Properties, java.io.*,java.util.*" %>
<%@page import="java.util.HashMap, java.util.Map.Entry"%>
<%@page import="java.math.BigInteger, java.security.MessageDigest"%>
<%@page import="com.rocomo.*, util.*, org.apache.commons.httpclient.NameValuePair, mobile.DataModel" %>

<html>
<head>
<title>간편결제 서비스 진행중</title>
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="p3p" content='CP="ALL CURa ADMa DEVa TAIa OUR BUS IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC OTC"' >

<%
	System.out.println("start eximbay agent.jsp-----");

	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","-1");
	response.setHeader("pragma","no-cache");
	response.setHeader("P3P", "CP='ALL CURa ADMa DEVa TAIa OUR BUS IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC OTC'");

	//한글처리
	request.setCharacterEncoding("UTF-8");

	//eximbay 파라미터
	String mid = request.getParameter("MID");
	String cur = request.getParameter("Currency");
	String ref = request.getParameter("TID");
	String amt = request.getParameter("Amt");
	String cardno = request.getParameter("EB_CARDNO");
	String expirydt = request.getParameter("EB_EXPIRYDT");
	
	//카드사 전달 파라미터
	String card_acsURL = "";
	String card_PaReq = "";
	String card_TermUrl = "";
	String card_MD = "";
	
	boolean error_flag = false;
	String error_msg = "";

	DataModel reqMap = new DataModel();
	DataModel rtnMap = new DataModel();
	
	reqMap.put("cur", cur);
	reqMap.put("ref", ref);
	reqMap.put("amt", amt);
	reqMap.put("cardno", cardno);
	reqMap.put("expirydt", expirydt);
	reqMap.put("mid", mid);
	
	//DCC Exchange Rate
	try {

		EximbayUtil eximbayUtil = new EximbayUtil();

		rtnMap = eximbayUtil.reqDccExchangeRate(reqMap);

		//인증완료
		if(rtnMap.getStrNull("rescode").equals("0000")){

			card_acsURL = rtnMap.getStrNull("basecur");
%>
			<script>
				parent.tranMgr.EB_BASECUR.value = "<%=rtnMap.getStrNull("basecur")%>";	
				parent.tranMgr.EB_BASEAMT.value = "<%=rtnMap.getStrNull("baseamt")%>";
				parent.tranMgr.EB_BASERATE.value = "<%=rtnMap.getStrNull("baserate")%>";
				parent.tranMgr.EB_BFOREIGNCUR.value = "<%=rtnMap.getStrNull("foreigncur")%>";
				parent.tranMgr.EB_BFOREIGNAMT.value = "<%=rtnMap.getStrNull("foreignamt")%>";
				parent.tranMgr.EB_BFOREIGNRATE.value = "<%=rtnMap.getStrNull("foreignrate")%>";
				parent.tranMgr.EB_BDCCRATE.value = "<%=rtnMap.getStrNull("dccrate")%>";
				parent.tranMgr.EB_BDCCRATEID.value = "<%=rtnMap.getStrNull("dccrateid")%>";	
			</script>
<%

		}else{
			error_msg = rtnMap.getStrNull("resmsg");
			error_flag = true;
		}
		
	} catch (Exception e) {
		error_msg = "기타 장애";
		error_flag = true;
		e.printStackTrace();
	}

	//Enrollment and Authentication
	if(!error_flag){
		try {
	
			EximbayUtil eximbayUtil = new EximbayUtil();
	
			rtnMap = eximbayUtil.reqEnrollmentAuth(reqMap);
	
			//인증완료
			if(rtnMap.getStrNull("rescode").equals("0000")){
				
				String prot = request.getScheme();
				String curPage = HttpUtils.getRequestURL(request).toString();
				String returnPage = prot + curPage.substring(curPage.indexOf(':'), curPage.lastIndexOf('/')) + "/agent_enrollment_res_m.jsp";  
	
				card_acsURL = rtnMap.getStrNull("acsurl");
				card_PaReq = rtnMap.getStrNull("PaReq");
				card_TermUrl = returnPage;
				card_MD = rtnMap.getStrNull("xid");
	%>
				<script>
					parent.tranMgr.EB_AUTHORIZEDID.value = "<%=rtnMap.getStrNull("authorizedid")%>";
					parent.tranMgr.EB_CARD_ACSURL.value = "<%=card_acsURL%>";
					parent.tranMgr.EB_CARD_PAREQ.value = "<%=card_PaReq%>";
					parent.tranMgr.EB_CARD_TERMURL.value = "<%=card_TermUrl%>";
					parent.tranMgr.EB_CARD_MD.value = "<%=card_MD%>";
				</script>
	<%				
	
			}else{
				error_msg = rtnMap.getStrNull("resmsg");
				error_flag = true;
			}
			
		} catch (Exception e) {
			error_msg = "기타 장애";
			error_flag = true;
			e.printStackTrace();
		}
	}
%>

<body onunload="javascript:closePopup();">
<form name=EXIMBAYFORM>
<input type="hidden" name="PaReq" value="<%=card_PaReq%>"/>
<input type="hidden" name="TermUrl" value="<%=card_TermUrl%>"/>
<input type="hidden" name="MD" value="<%=card_MD%>"/>
</form>
</body>

<script type="text/javascript">
var certResult = false;		//카드사로 부터 인증결과를 받으면 true로 변경됨...
var childwin = null;        //결제창
var cnt = 0;

//결제화면에서 선택한 카드사의 인증 POPUP창을 OPEN한다...
function openEximbay() {
	var PopOption = 'width=500,height=420,status=no,dependent=no,scrollbars=no,resizable=no';
    childwin = window.open('', 'EXIMBAYPOPUP', PopOption);
	document.forms[0].target="EXIMBAYPOPUP";
	document.forms[0].method="post";
	document.forms[0].action="<%=card_acsURL%>"; 
	//parent.document.getElementById("SPSDIV").style.display = "";
	document.forms[0].submit();
	
	if (childwin == null) {
        alert("팝업차단을 해제하신 후 결제를 하시기 바랍니다.");
        parent.install_eximbay_notice_off();
        parent.disableItems(false);
        parent.submitCnt = 0;
    }
	popupIsClosed();
}

function popupIsClosed()
{
    if(childwin) {
        if(childwin.closed) {
            if(!certResult){
            	popError("결제창을 닫으셨습니다.");
            	parent.install_eximbay_notice_off();
                parent.disableItems(false);
                parent.submitCnt = 0;
            }
        }else{
            self.setTimeout("popupIsClosed()", 1000);
        }
    } 
}

function popError(arg)
{
    if( childwin ) {
        childwin.close();
    }
    alert(arg);
}

function closePopup()
{
     if( childwin ) {
             childwin.close();
     }
}

function proceed(proceed) {
    certResult = proceed;
}
</script>

<%
	
	if(error_flag){
%>
		<script type="text/javascript">
			alert('[<%=error_msg%>] 오류가 발생하였습니다.\n쇼핑몰 담당자에 문의하시기 바랍니다.');
			parent.install_eximbay_notice_off();
            parent.disableItems(false);
            parent.submitCnt = 0;
		</script>
<%		
	}else{
%>
		<script type="text/javascript">
			//openEximbay();
			parent.doEximbayCardAuth();
		</script>
<%
	}
	
%>

</html>
