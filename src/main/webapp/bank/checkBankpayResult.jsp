<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz
,kr.co.infinisoft.pg.document.Box,kr.co.infinisoft.pg.document.GiftBox,org.json.simple.JSONObject,kr.co.infinisoft.pg.common.*
,util.CommonUtil, util.CardUtil, service.*,org.apache.commons.lang.StringUtils, mobile.*" %><%

String TID = CommonUtil.getDefaultStr(request.getParameter("TID") , "");
System.out.println("******** checkBankpayResult input TID["+TID+"]");
DataModel dm = new DataModel();
SupportIssue si = new SupportIssue();

String resultCode = "9999";
String tid = "";
String hdPi = "";
String hdEpType = "";
String bankpayCode = "";

try{
    dm = si.getBankPayAuthResult(TID);
    System.out.println("checkBankpayResult result ["+dm.toString()+"]");
    tid     = dm.getStrNull("tid");
    hdPi    = dm.getStrNull("hd_pi");
    hdEpType = dm.getStrNull("hd_ep_type");
    bankpayCode = dm.getStrNull("bankpay_code");
    
    if(StringUtils.isNotEmpty(hdPi) && StringUtils.isNotEmpty(hdEpType) 
            && StringUtils.isNotEmpty(tid)){
        resultCode="0000";
    }else{
        resultCode="9998";
    }   
}catch(Exception e){
    resultCode="9999";
    System.out.println("checkBankpayResult Exception ["+9999+"]");
}

System.out.println("******** checkBankpayResult resultCode["+resultCode+"]");
JSONObject json = new JSONObject();
json.put("resultCode", resultCode);
json.put("tid", tid);
json.put("hdPi", hdPi);
json.put("hdEpType", hdEpType);
json.put("bankpayCode", bankpayCode);
//System.out.println("******** checkBankpayResult result["+json.toString()+"]");
response.setContentType("application/json;charset=UTF-8");
out.print(json.toString());
%>