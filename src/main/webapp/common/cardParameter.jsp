<%
/*****************************************************************************
*
*	@ SYSTEM NAME		: 공통 파라미터 처리 페이지
*	@ PROGRAM NAME		: cardParameter.jsp
*	@ MAKER				: Innopay PG
*	@ MAKE DATE			: 2017.06.23
*	@ PROGRAM CONTENTS	: 공통 파라미터 처리 페이지
*
******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="service.SupportIssue" %>
<%@ page import="kr.co.infinisoft.pg.client.PGClientContext" %>
<%@ page import="kr.co.infinisoft.pg.client.PGConnection" %>
<%@ page import="kr.co.infinisoft.pg.client.PGClient" %>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.document.GiftBox" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%@ page import="kr.co.seeroo.spclib.SPCLib, org.json.simple.JSONObject"%>
<%@ page import="kr.co.infinisoft.pg.common.*" %>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%
request.setCharacterEncoding("utf-8");
	// parameter check
	String PayMethod	= CommonUtil.getDefaultStr(request.getParameter("PayMethod"), CommonConstants.PAY_METHOD_CARD);
	String TID			= CommonUtil.getDefaultStr(request.getParameter("TID"), "");
	String formBankCd	= CommonUtil.getDefaultStr(request.getParameter("formBankCd"), "");
	String GoodsCnt		= CommonUtil.getDefaultStr(request.getParameter("GoodsCnt"), "1");
	String GoodsName	= CommonUtil.getDefaultStr(request.getParameter("GoodsName"), "");
	String GoodsURL		= CommonUtil.getDefaultStr(request.getParameter("GoodsURL"), "");
	String GoodsCl		= CommonUtil.getDefaultStr(request.getParameter("GoodsCl"), "");
	String Amt			= CommonUtil.getDefaultStr(request.getParameter("Amt"), "");
	String TaxAmt       = CommonUtil.getDefaultStr(request.getParameter("TaxAmt"), "0");
	String DutyFreeAmt  = CommonUtil.getDefaultStr(request.getParameter("DutyFreeAmt"), "0");
	String CardInterest = CommonUtil.getDefaultStr(request.getParameter("CardInterest"), "");
	String CardQuota	= CommonUtil.getDefaultStr(request.getParameter("CardQuota"), "00");
	String Moid			= CommonUtil.getDefaultStr(request.getParameter("Moid"), "");
	String MID			= CommonUtil.getDefaultStr(request.getParameter("MID"), "");
	String ReturnURL	= CommonUtil.getDefaultStr(request.getParameter("ReturnURL"), "");
	String ResultYN     = CommonUtil.getDefaultStr(request.getParameter("ResultYN"), "");
	String RetryURL		= CommonUtil.getDefaultStr(request.getParameter("RetryURL"), "");
	String mallUserID	= CommonUtil.getDefaultStr(request.getParameter("mallUserID"), "");
	String BuyerName	= CommonUtil.getDefaultStr(request.getParameter("BuyerName"), "");
	String BuyerAuthNum	= CommonUtil.getDefaultStr(request.getParameter("BuyerAuthNum"), "");
	String BuyerTel		= CommonUtil.getDefaultStr(request.getParameter("BuyerTel"), "");
	String BuyerEmail	= CommonUtil.getDefaultStr(request.getParameter("BuyerEmail"), "");
	String ParentEmail	= CommonUtil.getDefaultStr(request.getParameter("ParentEmail"), "");
	String BuyerAddr	= CommonUtil.getDefaultStr(request.getParameter("BuyerAddr"), "");
	String BuyerPostNo	= CommonUtil.getDefaultStr(request.getParameter("BuyerPostNo"), "");
	String UserIP		= CommonUtil.getDefaultStr(request.getParameter("UserIP"), "");
	String MallIP		= CommonUtil.getDefaultStr(request.getParameter("MallIP"), "");
	String BrowserType	= CommonUtil.getDefaultStr(request.getParameter("BrowserType"), "");
	String CardPoint	= CommonUtil.getDefaultStr(request.getParameter("CardPoint"), "0");
	String quotabase	= CommonUtil.getDefaultStr(request.getParameter("quotabase"), "");
	String MallReserved = CommonUtil.getDefaultStr(request.getParameter("MallReserved"), "");
	String MallReserved1 = CommonUtil.getDefaultStr(request.getParameter("MallReserved1"), "");
	String MallReserved2 = CommonUtil.getDefaultStr(request.getParameter("MallReserved2"), "");
	String MallReserved3 = CommonUtil.getDefaultStr(request.getParameter("MallReserved3"), "");
	String MallReserved4 = CommonUtil.getDefaultStr(request.getParameter("MallReserved4"), "");
	String MallReserved5 = CommonUtil.getDefaultStr(request.getParameter("MallReserved5"), "");
	String MallReserved6 = CommonUtil.getDefaultStr(request.getParameter("MallReserved6"), "");
	String MallReserved7 = CommonUtil.getDefaultStr(request.getParameter("MallReserved7"), "");
	String MallReserved8 = CommonUtil.getDefaultStr(request.getParameter("MallReserved8"), "");
	String MallReserved9 = CommonUtil.getDefaultStr(request.getParameter("MallReserved9"), "");
	String TransType = CommonUtil.getDefaultStr(request.getParameter("TransType"), "");
	String MallResultFWD    = CommonUtil.getDefaultStr(request.getParameter("MallResultFWD"), "");	
	String SUB_ID        = CommonUtil.getDefaultStr(request.getParameter("SUB_ID"), "");	
	String EncodingType  = CommonUtil.getDefaultStr(request.getParameter("EncodingType"), "");	
	// from mpi
	String eci			= CommonUtil.getDefaultStr(request.getParameter("eci"), "");
	String xid			= CommonUtil.getDefaultStr(request.getParameter("xid"), "");
	String cavv			= CommonUtil.getDefaultStr(request.getParameter("cavv"), "");
	String cardno		= CommonUtil.getDefaultStr(request.getParameter("cardno"), "");
	String joinCode		= CommonUtil.getDefaultStr(request.getParameter("joinCode"), "");	
	// from direct input jsp page
	String CardExpire	= CommonUtil.getDefaultStr(request.getParameter("CardExpire"), "");
	String CardPwd		= CommonUtil.getDefaultStr(request.getParameter("CardPwd"), "");
	// from isp
	String KVP_PGID			= CommonUtil.getDefaultStr(request.getParameter("KVP_PGID"), "");
	String KVP_GOODNAME		= CommonUtil.getDefaultStr(request.getParameter("KVP_GOODNAME"), "");
	String KVP_PRICE		= CommonUtil.getDefaultStr(request.getParameter("KVP_PRICE"), "0");
	String KVP_CURRENCY		= CommonUtil.getDefaultStr(request.getParameter("KVP_CURRENCY"), "");
	String KVP_NOINT_INF	= CommonUtil.getDefaultStr(request.getParameter("KVP_NOINT_INF"), "");
	String KVP_QUOTA_INF	= CommonUtil.getDefaultStr(request.getParameter("KVP_QUOTA_INF"), "");
	String KVP_IMGURL		= CommonUtil.getDefaultStr(request.getParameter("KVP_IMGURL"), "");
	String KVP_NOINT		= CommonUtil.getDefaultStr(request.getParameter("KVP_NOINT"), "");
	String KVP_QUOTA		= CommonUtil.getDefaultStr(request.getParameter("KVP_QUOTA"), "");
	String KVP_CARDCODE		= CommonUtil.getDefaultStr(request.getParameter("KVP_CARDCODE"), "");
	String KVP_CONAME		= CommonUtil.getDefaultStr(request.getParameter("KVP_CONAME"), "");
	String KVP_SESSIONKEY	= CommonUtil.getDefaultStr(request.getParameter("KVP_SESSIONKEY"), "");
	String KVP_ENCDATA		= CommonUtil.getDefaultStr(request.getParameter("KVP_ENCDATA"), "");
	String KVP_RESERVED1	= CommonUtil.getDefaultStr(request.getParameter("KVP_RESERVED1"), "");
	String KVP_RESERVED2	= CommonUtil.getDefaultStr(request.getParameter("KVP_RESERVED2"), "");
	String KVP_RESERVED3	= CommonUtil.getDefaultStr(request.getParameter("KVP_RESERVED3"), "");
	
	String OfferingPeriod   = CommonUtil.getDefaultStr(request.getParameter("OfferingPeriod"), "");
	String device           = CommonUtil.getDefaultStr(request.getParameter("device"), "");
	String svcCd            = CommonUtil.getDefaultStr(request.getParameter("svcCd"), "");
    String svcPrdtCd        = CommonUtil.getDefaultStr(request.getParameter("svcPrdtCd"), "");
    
	//card sms
	String OrderCode = CommonUtil.getDefaultStr(request.getParameter("OrderCode"),"");
	String ExpTerm = CommonUtil.getDefaultStr(request.getParameter("ExpTerm"),"1440");
	
	String User_ID        	= CommonUtil.getDefaultStr(request.getParameter("User_ID"), "");
	String Pg_Mid           = CommonUtil.getDefaultStr(request.getParameter("Pg_Mid"), "");
	String BuyerCode        = CommonUtil.getDefaultStr(request.getParameter("BuyerCode"), "");
	
	String PgCd			    = CommonUtil.getDefaultStr(request.getParameter("PgCd"), "");
	String DanalParams	    = CommonUtil.getDefaultStr(request.getParameter("DanalParams"), "");
	String FORWARD	    	= CommonUtil.getDefaultStr(request.getParameter("FORWARD"), "X");
	String EncryptData      = CommonUtil.getDefaultStr(request.getParameter("EncryptData"), "");   // 거래검증값 추가(2018.08 hans)   
	String ediDate          = CommonUtil.getDefaultStr(request.getParameter("ediDate"), "");
	String Currency			= CommonUtil.getDefaultStr(request.getParameter("Currency"), "KRW");
	// 가맹점 URL 필드 추가 2019.04 Hans
	String RefererURL 		= CommonUtil.getDefaultStr(request.getParameter("RefererURL"), "");
	
	//from Eximbay
	String EB_CARDNO = CommonUtil.getDefaultStr(request.getParameter("EB_CARDNO"), "");
	String EB_EXPIRYDT = CommonUtil.getDefaultStr(request.getParameter("EB_EXPIRYDT"), "");
	String EB_AUTHORIZEDID = CommonUtil.getDefaultStr(request.getParameter("EB_AUTHORIZEDID"), "");
	String EB_PARES = CommonUtil.getDefaultStr(request.getParameter("EB_PARES"), "");
	String EB_BASECUR = CommonUtil.getDefaultStr(request.getParameter("EB_BASECUR"), "");
	String EB_BASEAMT = CommonUtil.getDefaultStr(request.getParameter("EB_BASEAMT"), "");
	String EB_BASERATE = CommonUtil.getDefaultStr(request.getParameter("EB_BASERATE"), "");
	String EB_BFOREIGNCUR = CommonUtil.getDefaultStr(request.getParameter("EB_BFOREIGNCUR"), "");
	String EB_BFOREIGNAMT = CommonUtil.getDefaultStr(request.getParameter("EB_BFOREIGNAMT"), "");
	String EB_BFOREIGNRATE = CommonUtil.getDefaultStr(request.getParameter("EB_BFOREIGNRATE"), "");
	String EB_BDCCRATE = CommonUtil.getDefaultStr(request.getParameter("EB_BDCCRATE"), "");
	String EB_BDCCRATEID = CommonUtil.getDefaultStr(request.getParameter("EB_BDCCRATEID"), "");
	String EB_ECI = CommonUtil.getDefaultStr(request.getParameter("EB_ECI"), "");
	String EB_XID = CommonUtil.getDefaultStr(request.getParameter("EB_XID"), "");
	String EB_CAVV = CommonUtil.getDefaultStr(request.getParameter("EB_CAVV"), "");
	String EB_PARESSTATUS = CommonUtil.getDefaultStr(request.getParameter("EB_PARESSTATUS"), "");
	String EB_MD = CommonUtil.getDefaultStr(request.getParameter("EB_MD"), "");
	String EB_CVC = CommonUtil.getDefaultStr(request.getParameter("EB_CVC"), "");
	String EB_CARD_ACSURL = CommonUtil.getDefaultStr(request.getParameter("EB_CARD_ACSURL"), "");
	String EB_CARD_PAREQ = CommonUtil.getDefaultStr(request.getParameter("EB_CARD_PAREQ"), "");
	String EB_CARD_TERMURL = CommonUtil.getDefaultStr(request.getParameter("EB_CARD_TERMURL"), "");
	String EB_CARD_MD = CommonUtil.getDefaultStr(request.getParameter("EB_CARD_MD"), "");
	
	Amt = Amt.replaceAll(",", "");

	//LPay 파라미터
	String LPAY_P_REQ_ID = CommonUtil.getDefaultStr(request.getParameter("LPAY_P_REQ_ID"), "");
	String LPAY_PG_ID = CommonUtil.getDefaultStr(request.getParameter("LPAY_PG_ID"), "");
	String LPAY_F_CO_CD = CommonUtil.getDefaultStr(request.getParameter("LPAY_F_CO_CD"), "");
	String LPAY_MEM_M_NUM = CommonUtil.getDefaultStr(request.getParameter("LPAY_MEM_M_NUM"), "");
	String LPAY_OTC_NUM = CommonUtil.getDefaultStr(request.getParameter("LPAY_OTC_NUM"), "");
	String LPAY_TR_ID = CommonUtil.getDefaultStr(request.getParameter("LPAY_TR_ID"), "");
	
	//카카오페이 전용 cavv
	
	String kakao_cavv = CommonUtil.getDefaultStr(request.getParameter("tid"), "").trim() + CommonUtil.getDefaultStr(request.getParameter("cid"), "").trim() ; // 카카오페이 결제 고유번호 TID + CID	
	String kakao_cavv2 = CommonUtil.getDefaultStr(request.getParameter("kakao_cavv2"), "");
	//간편결제 구분
	String EPayCl = request.getParameter("EPayCl");
	
	//Payco 파라미터
	String Payco_sellerOrderReferenceKey = CommonUtil.getDefaultStr(request.getParameter("sellerOrderReferenceKey"), "");
	String Payco_reserveOrderNo = CommonUtil.getDefaultStr(request.getParameter("reserveOrderNo"), "");
	String Payco_mccode = CommonUtil.getDefaultStr(request.getParameter("mccode"), "");
	String Payco_pccode = CommonUtil.getDefaultStr(request.getParameter("pccode"), "");
	String Payco_pcnumb = CommonUtil.getDefaultStr(request.getParameter("pcnumb"), "");
	String Payco_paymentCertifyToken = CommonUtil.getDefaultStr(request.getParameter("paymentCertifyToken"), "");
	String Payco_sellerKey = CommonUtil.getDefaultStr(request.getParameter("sellerKey"), "");
	
	//Toss 파라미터
	String injanm = CommonUtil.getDefaultStr(request.getParameter("injanm"), "");
	String trno = CommonUtil.getDefaultStr(request.getParameter("trno"), "");
	String banktrno = CommonUtil.getDefaultStr(request.getParameter("banktrno"), "");
	String paymethod = CommonUtil.getDefaultStr(request.getParameter("paymethod"), "");
	
	//SSG 파라미터
	String SSGPAY_TERMID = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_TERMID"), "");
	String SSGPAY_MGIFT_CARD_YN = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_MGIFT_CARD_YN"), "");
	String SSGPAY_CARD_CERT_FLAG = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_CARD_CERT_FLAG"), "");
	String SSGPAY_DELEGATE_CERTIFY_CODE = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_DELEGATE_CERTIFY_CODE"), "");
	String SSGPAY_OID = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_OID"), "");
	String SSGPAY_MGIFT_TRADE_AMT = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_MGIFT_TRADE_AMT"), "");
	String SSGPAY_CARD_TRACK2_DATA = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_CARD_TRACK2_DATA"), "");
	String SSGPAY_CARD_YN = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_CARD_YN"), "");
	String SSGPAY_PAYMETHOD = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_PAYMETHOD"), "");
	String SSGPAY_PLATFORM_MID = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_PLATFORM_MID"), "");
	String SSGPAY_MGIFT_CONFIRM_NO = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_MGIFT_CONFIRM_NO"), "");
	String SSGPAY_CARD_ETC_DATA = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_CARD_ETC_DATA"), "");
	String SSGPAY_MGIFT_CARD_NO = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_MGIFT_CARD_NO"), "");
	String SSGPAY_CARD_NO = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_CARD_NO"), "");
    String SSGPAY_CARD_CERTFY_NO = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_CARD_CERTFY_NO"), "");
    String SSGPAY_CARD_TRADE_AMT = CommonUtil.getDefaultStr(request.getParameter("SSGPAY_CARD_TRADE_AMT"), "");
    
    //네이버페이 파라미터
    String cardNumber = CommonUtil.getDefaultStr(request.getParameter("cardNumber"), "");
    String cardExpiredDate = CommonUtil.getDefaultStr(request.getParameter("cardExpiredDate"), "");
    String cardCode = CommonUtil.getDefaultStr(request.getParameter("cardCode"), "");
    String paymentId = CommonUtil.getDefaultStr(request.getParameter("paymentId"), "");
    String installment = CommonUtil.getDefaultStr(request.getParameter("installment"), "");
    String trid = CommonUtil.getDefaultStr(request.getParameter("trid"), "");
    
    
    
	
	
%>