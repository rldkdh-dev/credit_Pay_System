<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 공통 파라미터 처리 파일 (가상계좌)
*	@ PROGRAM NAME		: vbankParameter.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2009.04.01
*	@ PROGRAM CONTENTS	: 공통 파라미터 처리 파일 (가상계좌)
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=euc-kr"%>

<%
	String PayMethod		= getDefaultStr(request.getParameter("PayMethod"), CommonConstants.PAY_METHOD_VBANK);
	String TID				= getDefaultStr(request.getParameter("TID"), "");
	String payType			= getDefaultStr(request.getParameter("payType"), "payConfirm.jsp");
	String GoodsCnt			= getDefaultStr(request.getParameter("GoodsCnt"), "");
	String GoodsName		= getDefaultStr(request.getParameter("GoodsName"), "");
	String GoodsURL			= getDefaultStr(request.getParameter("GoodsURL"), "");
	String GoodsCl			= getDefaultStr(request.getParameter("GoodsCl"), "");
	String Amt				= getDefaultStr(request.getParameter("Amt"), "");
	String Moid				= getDefaultStr(request.getParameter("Moid"), "");
	String MID				= getDefaultStr(request.getParameter("MID"), "");
	String ReturnURL		= getDefaultStr(request.getParameter("ReturnURL"), "");
	String ResultYN         = getDefaultStr(request.getParameter("ResultYN"), "");
	String RetryURL			= getDefaultStr(request.getParameter("RetryURL"), "");
	String mallUserID		= getDefaultStr(request.getParameter("mallUserID"), "");
	String BuyerName		= getDefaultStr(request.getParameter("BuyerName"), "");
	String BuyerAuthNum		= getDefaultStr(request.getParameter("BuyerAuthNum"), "");
	String BuyerTel			= getDefaultStr(request.getParameter("BuyerTel"), "");
	String BuyerEmail		= getDefaultStr(request.getParameter("BuyerEmail"), "");
	String ParentEmail		= getDefaultStr(request.getParameter("ParentEmail"), "");
	String BuyerAddr		= getDefaultStr(request.getParameter("BuyerAddr"), "");
	String BuyerPostNo		= getDefaultStr(request.getParameter("BuyerPostNo"), "");
	String UserIP			= getDefaultStr(request.getParameter("UserIP"), "");
	String MallIP			= getDefaultStr(request.getParameter("MallIP"), "");	
	String BrowserType		= getDefaultStr(request.getParameter("BrowserType"), "");
	String DutyFreeAmt		= getDefaultStr(request.getParameter("DutyFreeAmt"), "0");	// 면세관련 필드 추가 (2019.04 hans)
	String TaxAmt			= getDefaultStr(request.getParameter("Amt"), "0");			// 면세관련 필드 추가 (2019.04 hans)
	// from vbank page
	String BankCode 		= getDefaultStr(request.getParameter("BankCode"), "");
	String VBankAccountName	= getDefaultStr(request.getParameter("VBankAccountName"), "");
	String VbankExpDate		= getDefaultStr(request.getParameter("VbankExpDate"), "");
	String cashReceiptType	= getDefaultStr(request.getParameter("cashReceiptType"), "3");
	String receiptTypeNo	= getDefaultStr(request.getParameter("receiptTypeNo"), "");
	String corpNo			= getDefaultStr(request.getParameter("corpNo"), "");
	String resVbankNum		= getDefaultStr(request.getParameter("resVbankNum"), "");
	String MallReserved     = getDefaultStr(request.getParameter("MallReserved"), "");
	String MallResultFWD    = getDefaultStr(request.getParameter("MallResultFWD"), "");
	String TransType 		= getDefaultStr(request.getParameter("TransType"), "");
	String ReceitType 		= getDefaultStr(request.getParameter("ReceitType"), "");
	String SUB_ID			= getDefaultStr(request.getParameter("SUB_ID"), "");
	String EncodingType		= getDefaultStr(request.getParameter("EncodingType"), "");
	String RefererURL		= getDefaultStr(request.getParameter("RefererURL"), "");
%>