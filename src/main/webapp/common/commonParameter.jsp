<%@ page contentType="text/html; charset=utf-8"%>
<%
/******************************************************************************
*
*   @ SYSTEM NAME       : 공통 include 파일
*   @ PROGRAM NAME      : commonParameter.jsp
*   @ MAKER             : InnopayPG
*   @ MAKE DATE         : 2017.06.23
*   @ PROGRAM CONTENTS  : 공통 include 파일
*
*******************************************************************************/
request.setCharacterEncoding("utf-8");

	//파라미터 체크
	String PayMethod        = CommonUtil.getDefaultStr(request.getParameter("PayMethod"), "");
    String payType          = CommonUtil.getDefaultStr(request.getParameter("payType"), ""); // 사용안함
	String GoodsCnt         = CommonUtil.getDefaultStr(request.getParameter("GoodsCnt"), "1");
	String GoodsName        = CommonUtil.getDefaultStr(request.getParameter("GoodsName"), "");
	String GoodsURL         = CommonUtil.getDefaultStr(request.getParameter("GoodsURL"), ""); // 사용안함
	String GoodsCl          = CommonUtil.getDefaultStr(request.getParameter("GoodsCl"), ""); // 상품구분 (1:컨텐츠/2:현물), 사용안함
	String Amt              = CommonUtil.getDefaultStr(request.getParameter("Amt"), "");   
	String DutyFreeAmt		= CommonUtil.getDefaultStr(request.getParameter("DutyFreeAmt"), "0");	// 면세관련 필드 추가 (2019.04 hans)
    String TaxAmt			= CommonUtil.getDefaultStr(request.getParameter("TaxAmt"), "0");			// 면세관련 필드 추가 (2019.04 hans)
	String Moid             = CommonUtil.getDefaultStr(request.getParameter("Moid"), "");
	String MID              = CommonUtil.getDefaultStr(request.getParameter("MID"), "");
	String ReturnURL        = CommonUtil.getDefaultStr(request.getParameter("ReturnURL"), "");
	String ResultYN         = CommonUtil.getDefaultStr(request.getParameter("ResultYN"), "");
	String RetryURL         = CommonUtil.getDefaultStr(request.getParameter("RetryURL"), "");
	String mallUserID       = CommonUtil.getDefaultStr(request.getParameter("mallUserID"), "");
	String BuyerName        = CommonUtil.getDefaultStr(request.getParameter("BuyerName"), "");
	String BuyerAuthNum     = CommonUtil.getDefaultStr(request.getParameter("BuyerAuthNum"), ""); // 수기결제용
	String BuyerTel         = CommonUtil.getDefaultStr(request.getParameter("BuyerTel"), "");
	String BuyerHp         = CommonUtil.getDefaultStr(request.getParameter("BuyerHp"), "");
	String BuyerEmail       = CommonUtil.getDefaultStr(request.getParameter("BuyerEmail"), "");
	String BuyerAddr        = CommonUtil.getDefaultStr(request.getParameter("BuyerAddr"), "");    // 사용안함
	String BuyerPostNo      = CommonUtil.getDefaultStr(request.getParameter("BuyerPostNo"), "");  // 사용안함
	String ParentEmail      = CommonUtil.getDefaultStr(request.getParameter("ParentEmail"), "");  // 사용안함
	String UserIP           = CommonUtil.getDefaultStr(request.getParameter("UserIP"), "");
	String MallIP           = CommonUtil.getDefaultStr(request.getParameter("MallIP"), "");
	String BrowserType      = CommonUtil.getDefaultStr(request.getParameter("BrowserType"), "");
	String ediDate          = CommonUtil.getDefaultStr(request.getParameter("ediDate"), "");
	String EncryptData      = CommonUtil.getDefaultStr(request.getParameter("EncryptData"), "");   
	String MallReserved     = CommonUtil.getDefaultStr(request.getParameter("MallReserved"), "");
	String MallResultFWD    = CommonUtil.getDefaultStr(request.getParameter("MallResultFWD"), "");
	String SUB_ID           = CommonUtil.getDefaultStr(request.getParameter("SUB_ID"), "");     // 사용안함  
	String TransType        = CommonUtil.getDefaultStr(request.getParameter("TransType"), "0");  // 결제타입 [0 : 일반결제 , 1 : 에스크로 결제]
	String EncodingType     = CommonUtil.getDefaultStr(request.getParameter("EncodingType"), "");  
	String OfferingPeriod   = CommonUtil.getDefaultStr(request.getParameter("OfferingPeriod"), "");
	String device           = CommonUtil.getDefaultStr(request.getParameter("device"), "");
	String svcCd            = CommonUtil.getDefaultStr(request.getParameter("svcCd"), "");        // 지불수단
	String svcPrdtCd        = CommonUtil.getDefaultStr(request.getParameter("svcPrdtCd"), "");    // sub지불수단
	//card sms
    String OrderCode        = CommonUtil.getDefaultStr(request.getParameter("OrderCode"),"");
    String ExpTerm          = CommonUtil.getDefaultStr(request.getParameter("ExpTerm"),"1440");
    
    String User_ID          = CommonUtil.getDefaultStr(request.getParameter("User_ID"), "");
    String Pg_Mid           = CommonUtil.getDefaultStr(request.getParameter("Pg_Mid"), "");
    String BuyerCode        = CommonUtil.getDefaultStr(request.getParameter("BuyerCode"), "");
    
	// 카드코드 지정 파라미터 관련하여 아래 formBankCd 파라미터 추가 - 2015/11/04 added by GWK
	String formBankCd       = CommonUtil.getDefaultStr(request.getParameter("formBankCd"), "");
	
	// for VBank
	String VbankExpDate     = CommonUtil.getDefaultStr(request.getParameter("VbankExpDate"), ""); // 가상계좌 입금 마감일
	String BankCode         = CommonUtil.getDefaultStr(request.getParameter("BankCode"), "");       // 은행코드
	String VBankAccountName = CommonUtil.getDefaultStr(request.getParameter("VBankAccountName"), "");
	String cashReceiptType  = CommonUtil.getDefaultStr(request.getParameter("cashReceiptType"), "3");       // 현금영수증 발급구분(1:소득공제용,2:지출증빙,3:미발행)
	String receiptTypeNo    = CommonUtil.getDefaultStr(request.getParameter("receiptTypeNo"), "");          // 현금영수증 발급번호
	String receiptType      = CommonUtil.getDefaultStr(request.getParameter("receiptType"), "");            // 발급구분(1:휴대폰,2:주민번호,3:신용카드번호)
	String FORWARD	    	= CommonUtil.getDefaultStr(request.getParameter("FORWARD"), "X");
	String Currency			= CommonUtil.getDefaultStr(request.getParameter("Currency"), "KRW");
	
	// 상품명이 긴 경우 38자미만으로 잘라낸다.
    GoodsName = CommonUtil.cutStr(GoodsName, 38);
	
	// Web Link
	String RequestType      = CommonUtil.getDefaultStr(request.getParameter("RequestType"), ""); // 화면 타입
	// 가맹점 URL 필드 추가 2019.04 Hans, FORWARD: N 처리용, 검토후 적용예정
	String RefererURL 		= CommonUtil.getDefaultStr(request.getParameter("RefererURL"), "");
%>