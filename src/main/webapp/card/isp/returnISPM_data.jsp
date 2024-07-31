<%@ page contentType="text/html; charset=euc-kr"%>
<%@page import="mobile.XMLUtil"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="org.w3c.dom.Element"%>
<%@ page import="kr.co.infinisoft.pg.common.*" %>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%
request.setCharacterEncoding("euc-kr");
	System.out.println("---- VP Return Data Start ----");
	
	String SendCode = "";
    String Message = "";
    String TID = "";
    String SessionKey = "";
    String EncData ="";
    String KvpCardCode ="";
    String returnMsg = "";
    String insert_dt = TimeUtils.getyyyyMMdd();
    
	try{
		StringBuffer sb = new StringBuffer();
		byte[] bt = new byte[5000];
		for(int n;(n=request.getInputStream().read(bt))!=-1;){
			sb.append(new String(bt,0,n));
		}
		
		System.out.println("Return Data["+sb.toString()+"]");
		
		Document data = XMLUtil.string2Doc(sb.toString());
		SendCode = XMLUtil.getElementData(data.getDocumentElement(), "SendCode");
		Message = XMLUtil.getElementData(data.getDocumentElement(), "Message");
		TID = XMLUtil.getElementData(data.getDocumentElement(), "TID");
				
		if(SendCode.equals("10001000")){
			SessionKey = XMLUtil.getElementData(data.getDocumentElement(), "SessionKey");
			EncData = XMLUtil.getElementData(data.getDocumentElement(), "EncData");
			KvpCardCode = XMLUtil.getElementData(data.getDocumentElement(), "KvpCardCode");
			returnMsg = "정상처리";
		}
		
		System.out.println("TID == " + TID);
		System.out.println("SendCode == " + SendCode);
		System.out.println("Message == " + Message);
		System.out.println("SessionKey == " + SessionKey);
		System.out.println("EncData == " + EncData);
		System.out.println("KvpCardCode == " + KvpCardCode);
		System.out.println("returnMsg == " + returnMsg);
		System.out.println("insert_dt == " + insert_dt);
		
		Box req = new Box();
		
		req.put("tid",				TID);
		req.put("session_key",		SessionKey);
		req.put("enc_data",			EncData);
		req.put("kvp_cardcode",		KvpCardCode);
		req.put("insert_dt",		insert_dt);
				
		CommonBiz.insertISPAuth_M(req);
		
	}catch(Exception e){
		System.out.println("returnISPM_data Exception "+e.getMessage());
	}
	// 2017.07.28 무조건 정상메세지로 보냄
	SendCode = "10001000";
	returnMsg = "정상처리";
	
	out.print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
			+ "<UPAY>"
			+ "<ResultCode>"+SendCode+"</ResultCode>"
			+ "<ResultMessage>"+returnMsg+"</ResultMessage>"
			+ "<TID>" + TID + "</TID>"
			+ "</UPAY>"
			);
%>
