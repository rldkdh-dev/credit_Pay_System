<%@ page language="java" contentType="text/plain; charset=UTF-8"%><%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz
,kr.co.infinisoft.pg.document.Box,kr.co.infinisoft.pg.document.GiftBox,org.json.simple.JSONObject,kr.co.infinisoft.pg.common.*
,util.CommonUtil, util.CardUtil, service.*,org.apache.commons.lang.StringUtils, mobile.CardSms, java.util.*" %><%
//Enumeration en = request.getParameterNames();
//while(en.hasMoreElements()) {
//	String key = (String)en.nextElement();
//	String val = request.getParameter(key);
//	System.out.println("["+key+"]["+val+"]");
//}
String cardNum = CommonUtil.getDefaultStr(request.getParameter("CardNum") , "");
//System.out.println("****input CardNum["+cardNum+"]");
//String card_num1 = CommonUtil.getDefaultStr(request.getParameter("card_num1") , "");
//String card_num2 = CommonUtil.getDefaultStr(request.getParameter("card_num2") , "");
//String card_num3 = CommonUtil.getDefaultStr(request.getParameter("card_num3") , "");
//String card_num4 = CommonUtil.getDefaultStr(request.getParameter("card_num4") , "");
//System.out.println("****input CardNum["+card_num1+"]["+card_num2+"]["+card_num3+"]["+card_num4+"]");
//cardNum = card_num1+card_num2+card_num3+card_num4;
Box req = new Box();
Box res = null;
String resultCode = "9999";
String resultMsg = "";
String fnCd = "";
String issueOrg = "";

try{
	res = CardSms.getCardBinList(cardNum);

	fnCd    = CommonUtil.getDefaultStr(res.getString("fn_cd"),"");
	issueOrg  = CommonUtil.getDefaultStr(res.getString("issue_org"),"");
	resultCode  = CommonUtil.getDefaultStr(res.getString("ResultCode"),"");
	resultMsg  = CommonUtil.getDefaultStr(res.getString("ResultMsg"),"");
}catch(Exception e){
	resultCode="9999";
	resultMsg = "카드정보 조회 오류 발생 관리자에게 문의해주세요.";
	System.out.println("checkCardBin Exception ["+9999+"]");
}
System.out.println("******** checkCardBin resultCode["+resultCode+"]");
System.out.println("******** checkCardBin resultMsg["+resultMsg+"]");
System.out.println("******** checkCardBin fnCd["+fnCd+"]");
System.out.println("******** checkCardBin issueOrg["+issueOrg+"]");
JSONObject json = new JSONObject();
json.put("fnCd", fnCd);
json.put("issueOrg", issueOrg);
json.put("resultCode", resultCode);
json.put("resultMsg", resultMsg);
response.setContentType("application/json;charset=UTF-8");
out.print(json.toString());
%>
