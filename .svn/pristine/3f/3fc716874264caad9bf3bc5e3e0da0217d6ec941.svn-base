<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*, util.CommonUtil, util.CardUtil, service.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%
request.setCharacterEncoding("euc-kr");
System.out.println("[Start] BankPay Return Data ****");
boolean DEBUG = true;
response.setHeader("cache-control","no-cache");
response.setHeader("expires","-1");
response.setHeader("pragma","no-cache");

if(DEBUG){
	Enumeration<String> seEnum = request.getParameterNames();
	while (seEnum.hasMoreElements()) {
	    String paramName = seEnum.nextElement();
	    String paramValue = request.getParameter(paramName);
	    System.out.println("======== KFTC return paramName [" + paramName + "] paramValue [" + paramValue + "]");
	}	
}

/*
 *  Get the form elements
 */
String hd_pi        = "";
String hd_ep_type   = "";
String bankpay_code = "";

String callbackparam1 = "";
String callbackparam2 = "";
String callbackparam3 = "";
String callbackparam4 = "";
String callbackparam5 = "";

hd_pi            = CommonUtil.getDefaultStr(request.getParameter("hd_pi"), ""); // 인증결과값
hd_ep_type       = CommonUtil.getDefaultStr(request.getParameter("hd_ep_type"), ""); // 인증타입
bankpay_code     = CommonUtil.getDefaultStr(request.getParameter("bankpay_code"), ""); // 결과코드
callbackparam1   = CommonUtil.getDefaultStr(request.getParameter("callbackparam1"), ""); // TID
callbackparam2   = CommonUtil.getDefaultStr(request.getParameter("callbackparam2"), ""); // 사용자필드
callbackparam3   = CommonUtil.getDefaultStr(request.getParameter("callbackparam3"), ""); // 사용자필드
callbackparam4   = CommonUtil.getDefaultStr(request.getParameter("callbackparam4"), ""); // 사용자필드
callbackparam5   = CommonUtil.getDefaultStr(request.getParameter("callbackparam5"), ""); // 사용자필드

SupportIssue si = new SupportIssue();
HashMap<String,String> map = new HashMap<String,String>();
try{
	if(StringUtils.isNotEmpty(callbackparam1)){
		map.put("tid", callbackparam1);
	    map.put("hd_pi", hd_pi);
	    map.put("hd_ep_type", hd_ep_type);
	    map.put("bankpay_code", bankpay_code);
	    map.put("callbackparam1", callbackparam1);
	    map.put("callbackparam2", callbackparam2);
	    map.put("callbackparam3", callbackparam3);
	    map.put("callbackparam4", callbackparam4);
	    map.put("callbackparam5", callbackparam5);
	    si.insertBankPayAuthResult(map);	
	}else{
		System.out.println("BankPay auth result return callbackparam1 is null");
	}
	
}catch(Exception e){
	System.out.println("BankPay auth result insert Exception "+e.getMessage());
}

System.out.println("[End] BankPay Return Data ****");
%>