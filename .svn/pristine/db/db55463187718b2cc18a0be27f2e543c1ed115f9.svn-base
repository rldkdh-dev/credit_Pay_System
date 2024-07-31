<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"  %>
<%@ page import="java.util.Properties, java.io.*,java.util.*" %>
<%@page import="java.util.HashMap, java.util.Map.Entry"%>
<%@page import="java.math.BigInteger, java.security.MessageDigest"%>
<%@page import="com.rocomo.*, util.*, org.apache.commons.httpclient.NameValuePair, mobile.DataModel" %>

<%
	System.out.println("start eximbay agent_enrollment_res.jsp-----");

	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","-1");
	response.setHeader("pragma","no-cache");
	response.setHeader("P3P", "CP='ALL CURa ADMa DEVa TAIa OUR BUS IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC OTC'");

	//한글처리
	request.setCharacterEncoding("UTF-8");
	
	Enumeration em = request.getParameterNames();
	HashMap paramMap = new HashMap();
	while(em.hasMoreElements())
	{
	    String key = em.nextElement().toString();
	    String value = request.getParameter(key);
	    paramMap.put(key, value);
	}

	System.out.println("====agent_enrollment_res response Param "+paramMap.toString());
	
	String card_PaRes = request.getParameter("PaRes");
	String card_MD = request.getParameter("MD");
	
%>

<script>
	parent.tranMgr.EB_PARES.value = "<%=card_PaRes%>";
	parent.tranMgr.EB_MD.value = "<%=card_MD%>";
	certResult = true;
	parent.doEximbayValidate();
	//self.close();
</script>
