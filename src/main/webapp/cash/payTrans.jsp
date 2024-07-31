<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 전문전송 (신용카드, mpi/key-in/해외)
*	@ PROGRAM NAME		: payTrans.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2009.02.04
*	@ PROGRAM CONTENTS	: 전문전송 (신용카드, mpi/key-in/해외)
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="kr.co.infinisoft.pg.client.PGClientContext" %>
<%@ page import="kr.co.infinisoft.pg.client.PGConnection" %>
<%@ page import="kr.co.infinisoft.pg.client.PGClient" %>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.document.GiftBox" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%@ page import="kr.co.infinisoft.pg.common.*" %>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%

	//parameter check
	String TransType = CommonUtil.getDefaultStr(request.getParameter("TransType"), "");
	String MID = CommonUtil.getDefaultStr(request.getParameter("MID"), "");
	String LicenseKey = CommonUtil.getDefaultStr(request.getParameter("LicenseKey"), "");
	String pgEncodeKey = CommonUtil.getDefaultStr(request.getParameter("pgEncodeKey"), "");
	String PgMID = CommonUtil.getDefaultStr(request.getParameter("PgMID"), "");
	String BuyerAuthNum = CommonUtil.getDefaultStr(request.getParameter("BuyerAuthNum"), "");
	String Currency = CommonUtil.getDefaultStr(request.getParameter("Currency"), "");
	String PayMethod = CommonUtil.getDefaultStr(request.getParameter("PayMethod"), CommonConstants.PAY_METHOD_CASH);
	String MallIP = CommonUtil.getDefaultStr(request.getParameter("MallIP"), "");
	String UserIP = CommonUtil.getDefaultStr(request.getParameter("UserIP"), "");
	String ediDate = CommonUtil.getDefaultStr(request.getParameter("ediDate"), "");
	String TID = CommonUtil.getDefaultStr(request.getParameter("TID"), "");
	String GoodsCnt = CommonUtil.getDefaultStr(request.getParameter("GoodsCnt"), "");
	String Moid = CommonUtil.getDefaultStr(request.getParameter("Moid"), "");
	String ReturnURL = CommonUtil.getDefaultStr(request.getParameter("ReturnURL"), "");
	String ResultYN = CommonUtil.getDefaultStr(request.getParameter("ResultYN"), "");
	String RetryURL = CommonUtil.getDefaultStr(request.getParameter("RetryURL"), "");
	String mallUserID = CommonUtil.getDefaultStr(request.getParameter("mallUserID"), "");
	String BuyerTel = CommonUtil.getDefaultStr(request.getParameter("BuyerTel"), "");
	String joinCode = CommonUtil.getDefaultStr(request.getParameter("joinCode"), "");
	String device = CommonUtil.getDefaultStr(request.getParameter("device"), "");
	String EncodingType = CommonUtil.getDefaultStr(request.getParameter("EncodingType"), "");
	String PayInform = CommonUtil.getDefaultStr(request.getParameter("PayInform"), "");
	String pg_yn = CommonUtil.getDefaultStr(request.getParameter("pg_yn"), "");
	String block_cl = CommonUtil.getDefaultStr(request.getParameter("block_cl"), "");
	String limit_yn = CommonUtil.getDefaultStr(request.getParameter("limit_yn"), "");
	String SvcPrdtCd = CommonUtil.getDefaultStr(request.getParameter("svcPrdtCd"), "");
	String User_ID    = CommonUtil.getDefaultStr(request.getParameter("User_ID"), "");
	String Pg_Mid    = CommonUtil.getDefaultStr(request.getParameter("Pg_Mid"), "");
	String BuyerCode    = CommonUtil.getDefaultStr(request.getParameter("BuyerCode"), "");
	String MallReserved = CommonUtil.getDefaultStr(request.getParameter("MallReserved"), "");

	String moid = CommonUtil.getDefaultStr(request.getParameter("moid"), "");
	String BuyerName = CommonUtil.getDefaultStr(request.getParameter("BuyerName"), "");
	String GoodsName = CommonUtil.getDefaultStr(request.getParameter("GoodsName"), "");
	String Amt = CommonUtil.getDefaultStr(request.getParameter("Amt"), "");
	String rcpt_type = CommonUtil.getDefaultStr(request.getParameter("rcpt_type"), "");
	String rcpt_type_no = CommonUtil.getDefaultStr(request.getParameter("rcpt_type_no"), "");

	System.out.println("CASH payTrans.jsp  [device check]  " + device);
	Box box = new Box();
	Box resMemberInfo = null;
	Box resMerKeyBox = null;

	box.put("mid", MID);
	resMemberInfo = CommonBiz.getMemberInfo(box);
	resMerKeyBox = CommonBiz.getMemberKey(box);

	PGClientContext context = null;
	PGConnection con = null;
	GiftBox req = null;
	GiftBox rep = null;

	context = PGClient.getInstance().getConext("CASH_BL");

	req = context.newGiftBox("NPG01RCP01");

	//전문공통
	req.put("Version", "NPG01");							// 버전
	req.put("ID", "RCP01");									// 전문ID
	req.put("EdiDate", TimeUtils.getyyyyMMddHHmmss());		// 전문생성일시
	req.put("TID", TID);									// 거래아이디
	req.put("ErrorSys", "WEB");								// 에러시스템명	,상점MALL, 웹서버:WEB, PG서버: PGS
	req.put("ErrorCD", "");									// 에러코드	,정상:00000 에러: 전문ID 
	req.put("ErrorMSG", "");								// 에러메세지	,전문 에러
	//상품정보
	req.put("GoodsCnt", GoodsCnt);							// 상품갯수
	req.put("GoodsName", GoodsName);						// 상품명
	req.put("Amt", Amt);									// 금액
	req.put("MOID", Moid);									// 상품주문번호
	req.put("Currency", "KRW");								// 통화구분
	//상점정보
	req.put("MID", MID);									// 상점아이디
	req.put("LicenseKey", resMerKeyBox.getString("mkey"));	// 상점서명인증키
	req.put("MallIP", MallIP);								// 상점서버IP
	req.put("Language", "Kor");								// 사용언어
	req.put("MallReserved", MallReserved);					// 상점예비정보
	req.put("ReturnURL", ReturnURL);						// 상점 결제결과 전송 URL
	req.put("RetryURL", RetryURL);							// 상점 결제결과 Retry URL
	//구매자정보
	req.put("MallUserID", mallUserID);						// 회원사고객ID
	req.put("BuyerName", BuyerName);						// 구매자명
	req.put("BuyerAuthNum", BuyerAuthNum);					// 구매자인증번호
	req.put("BuyerTel", BuyerTel);							// 구매자연락처
	req.put("BuyerEmail", "");								// 구매자메일주소
	req.put("ParentEmail", "");								// 보호자메일주소
	req.put("BuyerAddr", "");								// 배송지주소
	req.put("BuyerPostNo", "");								// 우편번호
	//결제자정보
	req.put("BrowserType", "");								// 브라우저 종류 및 버전
	req.put("UserIP", UserIP);								// 회원사고객 IP
	req.put("MAC", "");										// 회원사고객 MAC
	req.put("SUB_ID", "");									// 서브몰아이디
	//현금영수증
	req.put("PayMethod", PayMethod);						// 현금영수증 총금액
	req.put("ReceiptAmt", Amt);								// 현금영수증 총금액
	req.put("ReceiptSupplyAmt", ((long)Math.ceil((new Long(Amt)*10) / 11)));	// 현금영수증 공급가액
	req.put("ReceiptVAT", (new Long(Amt) - (long)Math.ceil((new Long(Amt)*10) / 11)));		// 현금영수증 부가세
	req.put("ReceiptServiceAmt", "");						// 현금영수증 봉사료
	req.put("ReceiptType", rcpt_type);						// 현금영수증 인증번호
	req.put("ReceiptIdentity", rcpt_type_no);				// 현금영수증 인증번호
	req.put("SvcPrdtCd", SvcPrdtCd);						// 현금영수증 SUB지불수단

	rep = context.send(req);

	// 전문공통
	String resVersion			= rep.getString("Version");
	String resID				= rep.getString("ID");
	String resEdiDate			= rep.getString("EdiDate");
	String resLength			= rep.getString("Length");
	String resTID				= rep.getString("TID");
	String resErrorSys			= rep.getString("ErrorSys");
	String resErrorCD			= rep.getString("ErrorCD");
	String resErrorMSG			= rep.getString("ErrorMSG");
	// 상품정보
	String resGoodsCnt			= rep.getString("GoodsCnt");
	String resGoodsName			= rep.getString("GoodsName");
	long resAmt					= rep.getLong("Amt");
	String resMOID				= rep.getString("MOID");
	String resCurrency			= rep.getString("Currency");
	// 상점정보
	String resMID				= rep.getString("MID");
	String resLicenseKey		= rep.getString("LicenseKey");
	String resMallIP			= rep.getString("MallIP");
	String resLanguage			= rep.getString("Language");	 
	String resReturnURL			= rep.getString("ReturnURL");	
	String resResultYN          = rep.getString("ResultYN"); // 결제창 보기 유무
	String resRetryURL			= rep.getString("RetryURL");
	String resMallReserved      = java.net.URLEncoder.encode(rep.getString("MallReserved"),"UTF-8");
	// 구매자정보
	String resmallUserID		= rep.getString("MallUserID");
	String resBuyerName			= rep.getString("BuyerName");
	String resBuyerAuthNum		= rep.getString("BuyerAuthNum");
	String resBuyerTel			= rep.getString("BuyerTel");
	String resBuyerEmail		= rep.getString("BuyerEmail");
	String resParentEmail		= rep.getString("ParentEmail");
	String resBuyerAddr		    = rep.getString("BuyerAddr");
	String resBuyerPostNo		= rep.getString("BuyerPostNo");
	// 결제자정보
	String resBrowserType		= rep.getString("BrowserType");
	String resUserIP			= rep.getString("UserIP");
	String resMAC				= rep.getString("MAC");
	String resSUB_ID			= rep.getString("SUB_ID");
	// 결과코드
	String resPayMethod			= rep.getString("PayMethod");
	String resAuthDate			= rep.getString("AuthDate");
	String resAuthCode			= rep.getString("AuthCode");
	String resResultCode		= rep.getString("ResultCode");
	String resResultMsg			= rep.getString("ResultMsg");

   	if(resResultCode.equals("7001")) {
   	%>
   		<script>
            alert('결제 정상 처리 되었습니다.');            
			//parent.document.location.reload();
			parent.location.href="https://admin.innopay.co.kr/mer/trans/orderCashRegist.do";
        </script>
    <%
   	}else{
   		if(resErrorMSG != null && !resErrorMSG.equals("")){
   	%>
   		<script>
   			alert('결제 처리중 오류가 발생 되었습니다.\n[<%=resErrorMSG%>]');
			//parent.document.location.reload();
			parent.location.href="https://admin.innopay.co.kr/mer/trans/orderCashRegist.do";
        </script>	    	
    <%
   		}else if(resResultMsg != null && !resResultMsg.equals("")){
   	%>
   		<script>
   			alert('결제 처리중 오류가 발생 되었습니다.\n[<%=resResultMsg%>]');
			//parent.document.location.reload();
			parent.location.href="https://admin.innopay.co.kr/mer/trans/orderCashRegist.do";
        </script>
    <%
   		}else{
    %>
    	<script>
   			alert('결제 처리중 오류가 발생 되었습니다.');
			//parent.document.location.reload();
			parent.location.href="https://admin.innopay.co.kr/mer/trans/orderCashRegist.do";
        </script>
   	<%
   		}
   	}

%>

<script>
	window.close();
</script>