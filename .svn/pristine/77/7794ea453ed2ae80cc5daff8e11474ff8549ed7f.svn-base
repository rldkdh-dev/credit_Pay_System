<%
/******************************************************************************
*
*	@ SYSTEM NAME		: URL Noti Test 페이지
*	@ PROGRAM NAME		: inform.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2009.03.25
*	@ PROGRAM CONTENTS	: URL Noti Test 페이지
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*	1	인포뱅크		2009.03.25			URL Noti 결과 페이지
*-----  --------    ----------------    ----------------------------------------
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*" %>
<%
	String PayMethod		= request.getParameter("PayMethod");
    String TID              = request.getParameter("TID");
	String MID				= request.getParameter("MID");	
	String Amt				= request.getParameter("Amt");	
	String mallUserID       = request.getParameter("mallUserID");
	String GoodsName		= request.getParameter("GoodsName");
	String OID				= request.getParameter("OID");
	String AuthDate         = request.getParameter("AuthDate");
	String AuthCode			= request.getParameter("AuthCode");
	String ResultCode		= request.getParameter("ResultCode");
	String ResultMsg		= request.getParameter("ResultMsg");	
	
	System.out.print("지불수단(PayMethod):[" + PayMethod + "]<br>");
	System.out.print("상점ID(MID):[" + MID + "]<br>");	
	System.out.print("금액(Amt):[" + Amt + "]<br>");		
	System.out.print("고객ID(mallUserID):[" + mallUserID + "]<br>");
	System.out.print("상품명(GoodsName):[" + GoodsName + "]<br>");
	System.out.print("주문번호(OID):[" + OID + "]<br>");
	System.out.print("승인일시(AuthDate):[" + AuthDate + "]<br>");
	System.out.print("승인번호(AuthCode):[" + AuthCode + "]<br>");
	System.out.print("결과코드(ResultCode):[" + ResultCode + "]<br>");
	System.out.print("결과메시지(ResultMsg):[" + ResultMsg + "]<br>");	
	
    if(ResultCode != null ) {
    	if(ResultCode.equals("4000")) {
    		// 승인 성공 시 DB 처리 하세요.
			out.print("결제성공");
		} else if(ResultCode.equals("2100")) {
			// 취소 성공 시 DB 처리 하세요.
			out.print("취소성공");
		}
	}
%>