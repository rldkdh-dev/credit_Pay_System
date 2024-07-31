<%@ page language="java" contentType="text/plain; charset=UTF-8"%><%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz
,kr.co.infinisoft.pg.document.Box,kr.co.infinisoft.pg.document.GiftBox,org.json.simple.JSONObject,kr.co.infinisoft.pg.common.*
,util.CommonUtil, util.CardUtil, service.*,org.apache.commons.lang.StringUtils" %><%
String TID = CommonUtil.getDefaultStr(request.getParameter("TID") , "");
System.out.println("****input TID["+TID+"]");
Box req = new Box();
Box resIspmAuth = null;
String KVP_CARDCODE    = null;
String KVP_SESSIONKEY  = null;
String KVP_ENCDATA     = null;
String resultCode = "9999";

try{
	req.put("tid",TID);
	resIspmAuth = CommonBiz.getISP_Auth_m(req);

	KVP_CARDCODE    = resIspmAuth.getString("kvp_cardcode");
	KVP_SESSIONKEY  = resIspmAuth.getString("session_key");
	KVP_ENCDATA     = resIspmAuth.getString("enc_data");
	
	if(StringUtils.isNotEmpty(KVP_CARDCODE) && StringUtils.isNotEmpty(KVP_SESSIONKEY) 
	        && StringUtils.isNotEmpty(KVP_ENCDATA)){
	    resultCode="0000";
	}else{
	    resultCode="9998";
	}	
}catch(Exception e){
	resultCode="9999";
	System.out.println("checkISPResult Exception ["+9999+"]");
}
System.out.println("******** checkISPResult resultCode["+resultCode+"]");
JSONObject json = new JSONObject();
json.put("resultCode", resultCode);
response.setContentType("application/json;charset=UTF-8");
out.print(json.toString());
%>