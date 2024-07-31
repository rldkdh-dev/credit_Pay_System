<%@ page language="java" contentType="text/plain; charset=UTF-8"%><%@ page import="mobile.CardSms
,kr.co.infinisoft.pg.document.Box,kr.co.infinisoft.pg.document.GiftBox,org.json.simple.JSONObject,kr.co.infinisoft.pg.common.*
,util.CommonUtil, util.CardUtil, service.*,org.apache.commons.lang.StringUtils" %><%
request.setCharacterEncoding("utf-8");
String DeliverySeq = CommonUtil.getDefaultStr(request.getParameter("DeliverySeq") , "");
String ZoneCode = CommonUtil.getDefaultStr(request.getParameter("zoneCode") , "");
String Address = CommonUtil.getDefaultStr(request.getParameter("address") , "");
String AddressDetail = CommonUtil.getDefaultStr(request.getParameter("addressDetail") , "");
String OrderCode = CommonUtil.getDefaultStr(request.getParameter("OrderCode") , "");
String BuyerName = CommonUtil.getDefaultStr(request.getParameter("BuyerName") , "");
String BuyerTel = CommonUtil.getDefaultStr(request.getParameter("BuyerTel") , "");
String Postcode = CommonUtil.getDefaultStr(request.getParameter("postcode") , "");
System.out.println("****input DeliverySeq["+DeliverySeq+"]");
System.out.println("****input ZoneCode["+ZoneCode+"]");
System.out.println("****input Address["+Address+"]");
System.out.println("****input AddressDetail["+AddressDetail+"]");
System.out.println("****input OrderCode["+OrderCode+"]");
System.out.println("****input BuyerName["+BuyerName+"]");
System.out.println("****input BuyerTel["+BuyerTel+"]");
System.out.println("****input Postcode["+Postcode+"]");
if ("".equals(Postcode)){
	ZoneCode = "";
}
Box req = new Box();
Box res = null;
String KVP_ENCDATA     = null;
String resultCode = "9999";
String resultMsg  = null;

try{
	req.put("DeliverySeq",DeliverySeq);
	req.put("ZoneCode",ZoneCode);
	req.put("Address",Address);
	req.put("AddressDetail",AddressDetail);
	req.put("OrderCode",OrderCode);
	req.put("BuyerName",BuyerName);
	req.put("BuyerTel",BuyerTel);
	res = CardSms.changeDelivery(req);

	resultCode    	= res.getString("ResultCode");
	resultMsg  		= res.getString("ResultMsg");
}catch(Exception e){
	resultCode = "9999";
	resultMsg  = "배송정보 업데이트 오류 발생 다시 시도해주세요.";
	System.out.println("changeDelivery Exception ["+9999+"]");
}
System.out.println("******** changeDelivery resultCode["+resultCode+"]");
JSONObject json = new JSONObject();
json.put("resultCode", resultCode);
json.put("resultMsg", resultMsg);
response.setContentType("application/json;charset=UTF-8");
out.print(json.toString());
%>
