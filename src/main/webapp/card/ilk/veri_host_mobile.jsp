<%@ page 
	contentType="text/html; charset=utf-8"
	import="java.util.*, com.ilk.ansim.vbv_mpi.*"
%><%@ include file="veri_kmpi.jsp" %><%!

private static Hashtable errs = null;
private static boolean notYet = true;
private static void errCodeDef()
{
	if( notYet ) {
		errs = new Hashtable();

		errs.put("301",	"카드번호를 확인하여 다시 입력해 주시기 바랍니다.");
		errs.put("302",	"카드번호를 확인하여 다시 입력해 주시기 바랍니다.");
		errs.put("303",	"안심클릭에 가입하시고 다시 이용해 주시기 바랍니다.");
		errs.put("304",	"카드사와의 통신 이상으로 가입여부를 알수 없습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("311",	"카드사 통신 이상으로 가입여부를 알수 없습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("312",	"카드사 통신 이상으로 가입여부를 알수 없습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("321",	"카드사 통신 이상으로 접속할 수 없습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("322",	"카드사 통신 이상으로 접속할 수 없습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("323",	"카드사 통신 이상으로 접속할 수 없습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("324",	"카드사 통신 이상으로 접속할 수 없습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("331",	"카드사 통신 이상으로 접속할 수 없습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("332",	"카드사 확인요청 메세지에 오류가 있습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("333",	"카드사 응답이 유효하지 않습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("334",	"카드사 응답이 유효하지 않습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("341",	"카드사 인증요청이 잘못 되었습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("351",	"통신중 문제가 발생하였습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("401",	"카드사 인증결과 전문이 유효하지 않습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("402",	"인증결과 전문 오류가 있습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("404",	"인증결과 전문 오류가 있습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("405",	"팝업페이지에서 새로고침을 하시면 정상거래가 되지 않습니다. 다시거래해 주시기 바랍니다.");
		errs.put("406",	"팝업페이지에서 새로고침을 하시면 정상거래가 되지 않습니다. 다시거래해 주시기 바랍니다.");
		errs.put("407",	"인증이 실패가 되었습니다. 인증창에서 취소를 하시면 결제가 되지 않습니다.");
		errs.put("408",	"인증불가 되었습니다. 카드사에 문의 하여 주시기 바랍니다.");
		errs.put("409",	"인증결과 전문 검증시 문제가 발생하였습니다. 가맹점에 문의하여 주시기 바랍니다.");
		errs.put("411",	"인증결과 전문 검증시 문제가 발생하였습니다. 가맹점에 문의하여 주시기 바랍니다.");
		errs.put("412",	"인증결과 전문 검증시 문제가 발생하였습니다. 가맹점에 문의하여 주시기 바랍니다.");
		errs.put("413",	"인증결과 전문 검증시 문제가 발생하였습니다. 가맹점에 문의하여 주시기 바랍니다.");
		errs.put("414",	"인증결과 전문 검증시 문제가 발생하였습니다. 가맹점에 문의하여 주시기 바랍니다.");
		errs.put("415",	"인증결과 전문 검증시 문제가 발생하였습니다. 가맹점에 문의하여 주시기 바랍니다.");
		errs.put("431",	"통신중 문제가 발생하였습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("501",	"내부 처리 중 오류가 발생하였습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("502",	"내부 처리 중 오류가 발생하였습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("503",	"내부 처리 중 오류가 발생하였습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("611",	"데이터베이스 처리 중 오류가 발생하였습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("612",	"데이터베이스 처리 중 오류가 발생하였습니다. 잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("613",	"데이터베이스 처리 중 오류가 발생하였습니다. 잠시후 다시 이용해 주시기 바랍니다.");	
		errs.put("995",	"ActiveX 모듈을 설치되지 않았습니다. 설치하시고 거래를 진행하여 주십시오.");
		errs.put("996",	"국민/비씨 카드는 ISP(안전결제)를 사용하셔야합니다.");
		errs.put("997",	"인증처리 도중 오류가 발생하였습니다.잠시후 다시 이용해 주시기 바랍니다.");
		errs.put("998",	"필요한 매개변수가 없습니다.가맹점에 문의하여 주시기 바랍니다.");
		errs.put("999",	"카드번호나 유효기간을 확인 하신후 이용해 주시기 바랍니다.");

		notYet = false;
	}
}

private String strCut(String str, int len) {
	if (str == null) return "";

	byte[] srcBytes = str.getBytes();
	int byteLen = srcBytes.length;
	
	if (byteLen > len) {
		byte[] tmpBytes = new byte[len];
		System.arraycopy(srcBytes, 0, tmpBytes, 0, tmpBytes.length);
		return new String(tmpBytes);
	}
	else {
		return str;
	}
}

%><%
	System.out.println("-------- veri_host_mobile.jsp start --------");
	/*
	 * Declare error codes.
	 */
	errCodeDef();

	request.setCharacterEncoding("utf-8");

	/*
	 * Do not cache this page.
	 */
	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","-1");
	response.setHeader("pragma","no-cache");

	/*
	 *	Get the form variable and HTTP header
	 */
	String pan				= (String)request.getParameter("pan");
	String expiry			= (String)request.getParameter("expiry");
	String purch_amount		= (String)request.getParameter("purchase_amount");
	String amount			= "";
	String goodsname		= (String)request.getParameter("goodsname");
	String description		= (String)request.getParameter("description");
	String purch_currency	= (String)request.getParameter("currency");
	String device_category	= (String)request.getParameter("device_category");
	String userid			= (String)request.getParameter("userid");
	String mid				= (String)request.getParameter("hostid");
	String cardcode			= (String)request.getParameter("cardcode");
	String name				= (String)request.getParameter("name");
	String url				= (String)request.getParameter("url");
	String country			= (String)request.getParameter("country");
	String returnUrl		= (String)request.getParameter("returnUrl");
	String useActiveX		= (String)request.getParameter("useActiveX");
	String MD           	= (String)request.getParameter("returnUrl");;
	String transID			= (String)request.getParameter("transID");
	String accept			= ""; 
	String userAgent		= "";
	String apvl_chain_no	= (String)request.getParameter("apvl_chain_no");
	String apvl_seller_id	= (String)request.getParameter("apvl_seller_id");
	String apvl_halbu		= (String)request.getParameter("apvl_halbu");
	String POPSIZE			= (String)request.getParameter("POPSIZE");

	if (pan == null || pan.equals("") || "null".equals(pan))									pan = "no pan";
	if (purch_amount == null || purch_amount.equals("") || "null".equals(purch_amount))				purch_amount = "0";
	if (description == null || description.trim().equals(""))			description = "no_desc";
	if (purch_currency == null || purch_currency.trim().equals(""))		purch_currency = "410";
	if (expiry == null || expiry.trim().equals("") || purch_currency.equals("410"))						expiry = "4912";
	if (device_category == null || device_category.trim().equals(""))	device_category = "0";
	if (userid == null)													userid = "";
	if (mid == null)													mid = "";
	if (cardcode == null || cardcode.equals(""))						cardcode = ""; //CardTable.getCode(pan);
	if (name == null || name.equals("") || name.equals("RedirectShop"))	name = "PayerAuthService";
	if (url == null || !url.startsWith("http"))							url = "http://www.ilkr.com";
	if (country == null || country.equals(""))							country = "410";
	if (transID == null)												transID = "";
	if (accept == null)													accept = "";
	if (userAgent == null)												userAgent = "";
	
	if (apvl_chain_no == null || apvl_chain_no.equals(""))				apvl_chain_no = "00927812446";
	if (apvl_seller_id == null || apvl_seller_id.equals(""))			apvl_seller_id = "00927812446";
	if (apvl_halbu == null || apvl_halbu.equals(""))					apvl_halbu = "00";

	/*
	 *	Set the cardholder device type
	 *		0 : PC (HTML)
	 *		1 : mobile internet device (WML)
	 */
	String dev_category=null;
	if (device_category.equals("mobile")) {
		dev_category = "1";
	} else {
		dev_category = "0";
	}

	if( purch_currency.equals("410") ) {
		amount = "KRW " + purch_amount;
	} else if( purch_currency.equals("840") ) {
		amount = "USD " + purch_amount;
	} else {
		amount = purch_amount;
	}

	String auth_msg = "";
	String success = "N";
	String enrolled = "";
	String xid = "";
	boolean result = false;
	
	// mpiVbV(ip, port); or mpiVbV(port);
	 mpiVbV mpi = new mpiVbV(5103);

	// check if pan is ISP pan
	String errorCode = checkISP( pan );
	
	// OK, pan is not ISP pan
	if ( "000".equals( errorCode ) ) {
	
		// limit length of parameters
		cardcode = strCut(cardcode, 4);
		name = strCut(name, 25);	// ILK ACS에서 25bytes만 허용함..(visa spec에는 25characters이지만...)
		mid = strCut(mid, 32);
		userid = strCut(userid, 32);
		description = strCut(description, 125);
		transID = strCut(transID, 36);
		
		//	set arguments
		result = true;
		result = result && mpi.argSetCardno(pan);
		result = result && mpi.argSetExpiry(expiry);
		result = result && mpi.argSetPurchaseAmount(purch_amount);
		result = result && mpi.argSetAmount(amount);
		result = result && mpi.argSetDescription(description);
		result = result && mpi.argSetCurrency(purch_currency);
		result = result && mpi.argSetDeviceCategory(dev_category);
		result = result && mpi.argSetUserID(userid);
		result = result && mpi.argSetMID(mid);
		result = result && mpi.argSetCardCode(cardcode);
		result = result && mpi.argSetAcceptHeader(accept);
		result = result && mpi.argSetUserAgentHeader(userAgent);
		result = result && mpi.argSetTransID(transID);
		result = result && mpi.argSetName(name);
		result = result && mpi.argSetUrl(url);
		result = result && mpi.argSetCountry(country);
	
		/*
		 *	Verify enrollment
		 */
	
		if( purch_amount.equals("0") ) {
			result = false;
			auth_msg = "Purchase amount must be positive value";
		}
	
		if( result ) {
			String params = mpi.argBuildParam();
			if( !params.equals("") ) {
				success = mpi.verifyEnrollment(params);
				xid = mpi.getXid();
				errorCode = mpi.getErrorCode();
				if( errorCode == null || errorCode.equals("") ) {
					// mpi와 통신 오류
					errorCode = "997";
				}
			} else {
				// required parameter error
				result = false;
				errorCode = "998";
			}
		} else {
			// parameter error
			errorCode = "999";
		}
	}

	if (success.equals("Y") && errorCode.equals("000")) {			// Operation succeeded

		enrolled = mpi.getEnrolled();

		if (enrolled.equals("Y")) {		// Supplied pan is enrolled one

			String AcsUrl	= mpi.getAcsUrl();
			String PaReq	= mpi.getPAReq();

			// 중요: servlet 버전에 따라 "https"를 "http"로 가져오는 경우가 있으니 그럴 경우에는 
			//       URL을 직접 하드코딩 하시기 바랍니다.
			String ret = HttpUtils.getRequestURL(request).toString();
			String TermUrl = ret.substring(0, ret.lastIndexOf("/")) + "/auth_host_mobile.jsp";
			// HANA SK 안드로이드 버젼에 따라 응답처리 페이지가 다릅니다.
				
			// Android Apk
			if("4570473000000008".equals(pan) || "4570473000000009".equals(pan)){	
				TermUrl = ret.substring(0, ret.lastIndexOf("/")) + "/auth_host_apk.jsp";	
			} else {
				// Mobile Web default
				TermUrl = ret.substring(0, ret.lastIndexOf("/")) + "/auth_host_mobile.jsp";	
			}
			
			System.out.println("veri_host_mobile.jsp start2 TermUrl check ---------->  " + TermUrl);
%>
<html>
	<head>
		<title>비자 안심클릭 서비스 가입여부 확인중...</title>
	</head>
	<body OnLoad="onLoadProc();">
		<Script type="text/javascript">
		function onLoadProc() {
			postForm.submit();
		}
		</Script>
		<form name="postForm" action="<%=AcsUrl%>" method="POST" accept-charset="euc-kr">
			<input type=hidden name=PaReq   value="<%=PaReq%>">
			<input type=hidden name=TermUrl value="<%=TermUrl%>">
			<input type=hidden name=MD      value="<%=returnUrl%>">
			<input type=hidden name=goodsname      value="<%=goodsname%>">
			<input type=hidden name=usimYn                          value="N">
            <input type=hidden name=returnURL                       value="<%=returnUrl %>">
            <input type=hidden name=cardType                value="088">
			<!-- 2010-08-17 modify Han -->
   			<!-- KEB Ysave and Popsize -->
   			<input type=hidden name=apvl_chain_no value="<%=apvl_chain_no%>">
   			<input type=hidden name=apvl_seller_id value="<%=apvl_seller_id%>">
   			<input type=hidden name=apvl_halbu value="<%=apvl_halbu%>">
		</form>
	</body>
</html>
<%

			return;			// done successfully

		} else {			// not enrolled pan or unable to verify
			auth_msg = errorCode + ": " + errs.get(errorCode);
		}

	} else {				// Operation failed, internal error, or ISP pan
	
		if( mpi.getErrorCode() == null || mpi.getErrorCode().equals("") || mpi.getErrorCode().equals("000") ) {
		
			enrolled = "X";
			if ( errorCode != null )
				auth_msg = errorCode + ": " + errs.get(errorCode);
			else
				auth_msg = errorCode + ": " + "비자 안심클릭 서비스 조회 동안에 장애가 발생되었습니다.";
			
			/* rchoi - 2005.02.02 : for ISP
			if( !result ) {
				enrolled = "X";
				auth_msg = errorCode + ": " + "넘어온 파라미터에 문제가 있습니다. " + mpi.getErrorList().replace('\n',' ') + auth_msg;
			} else {
				
				auth_msg = errorCode + ": " + "비자 안심클릭 서비스 조회 동안에 장애가 발생되었습니다.";
			}
			*/
			// 오류로 인하여 DB에 정보가 안남은것으로 간주하고 insert한다.
			if(errorCode == null) errorCode = "";

			
			// hjseo, 2005-01-20 수정
			// 각 field의 값의 길이를 check하여 over할 경우 해당 값만큼만 잘라서 넣어주도록 수정.
			// 기존에는 db insert시 오류 발생하여 DB에 안쌓였었음.
			// 한글이 있을 수도 있기때문에 substring은 안되고 byte로 짤라야함...
			pan = strCut(pan, 20);
			expiry = strCut(expiry, 4);
			cardcode = strCut(cardcode, 4);
			mid = strCut(mid, 32);
			name = strCut(name, 64);
			userid = strCut(userid, 32);
			purch_amount = strCut(purch_amount, 12);
			purch_currency = strCut(purch_currency, 3);
			description = strCut(description, 125);
			transID = strCut(transID, 36);

		} else {
			auth_msg = errorCode + ": " + errs.get(errorCode);
		}
	}						// Operation succeeded or not

%>
<html>
<script type="text/javascript">
function onLoadProc() {
	var frm = document.frmRet;
	var proceed = true;

	if( "<%=auth_msg%>" != "" ) {
		proceed = false;
		alert("<%=auth_msg%>");
	}     
	frm.submit();
}
	</script>
	<body onload="javascript:onLoadProc();">
		<form name=frmRet method=post action="<%=returnUrl%>">
			<input type=hidden name=proceed value="">
			<input type=hidden name=xid     value="">
			<input type=hidden name=eci     value="">
			<input type=hidden name=cavv    value="">
			<input type=hidden name=realPan value="">
			<input type=hidden name=errCode value="<%=errorCode%>">
		</form>
	</body>
</html>