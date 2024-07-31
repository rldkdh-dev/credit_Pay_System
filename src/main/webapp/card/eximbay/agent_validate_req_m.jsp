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
	System.out.println("start eximbay agent_validate_req.jsp-----");

	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","-1");
	response.setHeader("pragma","no-cache");
	response.setHeader("P3P", "CP='ALL CURa ADMa DEVa TAIa OUR BUS IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC OTC'");

	//한글처리
	request.setCharacterEncoding("UTF-8");

	//eximbay 파라미터
	String mid = request.getParameter("MID");
	String ref = request.getParameter("TID");
	String cur = request.getParameter("Currency");
	String amt = request.getParameter("Amt");
	String authorizedid = request.getParameter("EB_AUTHORIZEDID");
	String PaRes = request.getParameter("EB_PARES");

	boolean error_flag = false;
	String error_msg = "";
	DataModel map = new DataModel();
	DataModel reqMap = new DataModel();
	DataModel rtnMap = new DataModel();
	
	reqMap.put("ref",ref);
	reqMap.put("cur",cur);
	reqMap.put("amt",amt);
	reqMap.put("authorizedid",authorizedid);
	reqMap.put("PaRes",PaRes);
	reqMap.put("mid", mid);

	try {

		EximbayUtil eximbayUtil = new EximbayUtil();

		rtnMap = eximbayUtil.reqValidateAuth(reqMap);

		//인증완료
		if(rtnMap.getStrNull("rescode").equals("0000")){

%>
			<script>
				parent.tranMgr.EB_ECI.value = "<%=rtnMap.getStrNull("eci")%>";
				parent.tranMgr.EB_XID.value = "<%=rtnMap.getStrNull("xid")%>";
				parent.tranMgr.EB_CAVV.value = "<%=rtnMap.getStrNull("cavv")%>";
				parent.tranMgr.EB_PARESSTATUS.value = "<%=rtnMap.getStrNull("paresStatus")%>";
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
	
	if(error_flag){
%>
		<script type="text/javascript">
			alert('[<%=error_msg%>] 오류가 발생하였습니다.\n쇼핑몰 담당자에 문의하시기 바랍니다.');
			parent.install_eximbay_notice_off();
            parent.disableItems(false);
            parent.goBack();
		</script>
<%		
	}else{
%>
		<script type="text/javascript">
			parent.tranMgr.target="_self";
			parent.goPayment();
		</script>
<%
	}
%>

</html>
