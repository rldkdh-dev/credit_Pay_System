<%@ page contentType="text/html; charset=euc-kr"
	import="java.util.*, com.ilk.ansim.vbv_mpi.*"%><%@ include file="veri_kmpi.jsp"%>
<%@ page
	import="java.io.UnsupportedEncodingException, java.security.MessageDigest,java.security.NoSuchAlgorithmException"%>
<%!
private static Hashtable errs = null;
private static boolean notYet = true;
private static void errCodeDef()
{
	if( notYet ) {
		errs = new Hashtable();

		errs.put("301",	"카드번호 범위 체크 불가(카드번호 확인요망)");
		errs.put("302",	"등록이 되지 않은 카드범위(카드번호 확인요망, 카드사 문의요망)");
		errs.put("303",	"고객이 안심클릭에 가입되어 있지 않음(카드번호 확인요망, 카드사 문의요망)");
		errs.put("304",	"카드사 시스템문제로 인하여 가입여부를 알수 없음(카드사 문의요망)");
		errs.put("311",	"가입여부 인자 오류(카드번호 확인요망)");
		errs.put("312",	"가입여부 전문 생성 불가");
		errs.put("321",	"카드사에 접속 도중 문제 발생(카드사 문의요망)");
		errs.put("322",	"카드사에 접속시간 초과(카드사 문의요망)");
		errs.put("323",	"카드사와 통신도중 문제 발생(카드사 문의요망)");
		errs.put("324",	"카드사에 연결후 응답시간 초과(카드사 문의요망)");
		errs.put("331",	"카드사의 응답이 유효하지 않음(카드사 문의요망)");
		errs.put("332",	"가입여부 확인요청 메시지에 오류가 있음");
		errs.put("333",	"카드사의 응답이 유효하지 않음(카드사 문의요망)");
		errs.put("334",	"카드사의 응답이 유효하지 않음(카드사 문의요망)");
		errs.put("341",	"인증요청 전문 생성 실패");
		errs.put("351",	"통신중 문제가 발생하였습니다");
		errs.put("401",	"인증결과 전문이 유효하지 않음(카드사 문의요망)");
		errs.put("402",	"인증결과 전문 오류(카드사 문의요망)");
		errs.put("404",	"인증결과 전문 오류(카드사 문의요망)");
		errs.put("405",	"동일 인증요청 전문이 2회이상 들어옴(팝업페이지에서 새로고침을 하시면 정상거래가 되지 않습니다)");
		//errs.put("405",	"인증요청 정보에 문제가 있습니다. 쇼핑몰 담당자에게 문의하시기 바랍니다.");	//오류메시지를 이거로 변경했음 싶은데.
		errs.put("406",	"인증결과 전문이 잘못됨(카드사 문의요망)");
		errs.put("407",	"인증실패. 인증창에서 취소를 하시면 결제가 되지 않습니다.");
		errs.put("408",	"인증불가(카드사 문의요망)");
		errs.put("409",	"인증결과 전문 검증시 문제발생(카드사 문의요망)");
		errs.put("411",	"인증결과 전문 검증시 문제발생(카드사 문의요망)");
		errs.put("412",	"인증결과 전문 검증시 문제발생(카드사 문의요망)");
		errs.put("413",	"인증결과 전문 검증시 문제발생(카드사 문의요망)");
		errs.put("414",	"인증결과 전문 검증시 문제발생(카드사 문의요망)");
		errs.put("415",	"인증결과 전문 검증시 문제발생(카드사 문의요망)");
		errs.put("431",	"통신중 문제가 발생하였습니다");
		errs.put("501",	"내부 처리 오류(다시한번 시도해 주십시오)");
		errs.put("502",	"내부 처리 오류");
		errs.put("503",	"내부 처리 오류");
		errs.put("611",	"데이터베이스 처리 오류(다시한번 시도해 주십시오)");
		errs.put("612",	"데이터베이스 처리 오류(다시한번 시도해 주십시오)");
		errs.put("613",	"데이터베이스 처리 오류(다시한번 시도해 주십시오)");
		errs.put("995",	"ActiveX 모듈을 설치하지 않았을 경우.");
  	errs.put("996",	"국민/비씨 카드는 ISP(안전결제)를 사용하셔야합니다.");
		errs.put("997",	"인증처리 도중 오류가 발생하였습니다.(다시한번 시도해 주시시오)");
		errs.put("998",	"필요한 매개변수가 없습니다.(쇼핑몰에 문의 바랍니다)");
		errs.put("999",	"매개변수가 잘못되었습니다.(카드번호나 유효기간을 확인바랍니다)");

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

%>
<%

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
	String useExtensionPopSize             = (String)request.getParameter("useExtensionPopSize");

	//2010-08-17 modify Han
	//KEB Ysave and Popsize
	String apvl_chain_no	= (String)request.getParameter("apvl_chain_no");
	String apvl_seller_id	= (String)request.getParameter("apvl_seller_id");
	String sub_apvl_seller_id	= (String)request.getParameter("sub_apvl_seller_id");
	String apvl_halbu		= (String)request.getParameter("apvl_halbu");

	if (apvl_chain_no == null)		
		apvl_chain_no	= (String)request.getParameter("APVL_CHAIN_NO");
	if (apvl_seller_id == null)		
		apvl_seller_id	= (String)request.getParameter("APVL_SELLER_ID");
	if (sub_apvl_seller_id == null)		
		sub_apvl_seller_id	= (String)request.getParameter("SUB_APVL_SELLER_ID");
	if (apvl_halbu == null)			
		apvl_halbu		= (String)request.getParameter("APVL_HALBU");

	String POPSIZE			= (String)request.getParameter("POPSIZE");
	String MD           	= "";
	String transID			= (String)request.getParameter("transID");
	String accept			= ""; //(String)request.getHeader("ACCEPT");
	String userAgent		= ""; //(String)request.getHeader("USER-AGENT");
	
	// HANA sk android apk ver Params.
    String usimYn                   = (String)request.getParameter("usimYn");
    String handNum              = (String)request.getParameter("handNum");
    String TID                      = (String)request.getParameter("TID");

    String goodsname                = (String)request.getParameter("goodsname");    //hana, KEB add 2015.02
    String goodscode                = (String)request.getParameter("goodscode");    //hmall add 2015.06

	//롯데 가맹점 구분(X-MPI와 동일값)
    String MID 						= (String)request.getParameter("MID"); //가맹점ID(최대20,숫자+문자):기존X-MPI 그대로 유지
    String BUSINESSTYPE 	      	= (String)request.getParameter("BUSINESSTYPE"); //가맹점구분코드(PG:P, 쇼핑몰:M):카드사 가맹점계약 기준
	String APVL_SELLER_ID_LT        = (String)request.getParameter("APVL_SELLER_ID_LT"); //사업자 번호(BUSINESSTYPE=M인 경우 사업자번호와 하위사업자 동일해야됨)
	String SUB_APVL_SELLER_ID_LT    = (String)request.getParameter("SUB_APVL_SELLER_ID_LT"); //하위사업자 번호(BUSINESSTYPE=P인 경우 하위사업자필수로 실하위사업자 요)
	//롯데카드 쇼핑세이브
	String APVL_SS_USEYN            = (String)request.getParameter("APVL_SS_USEYN"); //쇼핑세이브 사용자 사용여부 Y,N
	//롯데카드 통합 안심서비스
	String PAY               	 	= (String)request.getParameter("PAY");  //결제 유형 default 선택(옵션): SPS(간편결제-범용), ACS(안심클릭)
	String MOBILE               	= (String)request.getParameter("MOBILE");   //모바일 여부 Y,N 
	String ORDER_USERID = (String)request.getParameter("ORDER_USERID");
	//System.out.println("hosting server return Url = " + returnUrl);

	if (pan == null || pan.equals(""))									pan = "no pan";
	if (purch_amount == null || purch_amount.equals(""))				purch_amount = "0";
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
	if (useActiveX == null || useActiveX.equals(""))					useActiveX = "N";
	
	if (usimYn == null)                                                 usimYn = "N";
    if (handNum == null)                                                handNum = "01089466822";
    if (returnUrl == null)                                              returnUrl = "./mobileReturn.jsp";;
    if (TID == null)                                                    TID = "0987654321";
    if (goodsname == null || goodsname.equals(""))                      goodsname = "";
    if (goodscode == null || goodscode.equals(""))                      goodscode = "";
    
	//2010-08-17 modify Han
	//KEB Ysave and Popsize
	//if (apvl_chain_no == null || apvl_chain_no.equals(""))			apvl_chain_no = "00927812446";
	//if (apvl_seller_id == null || apvl_seller_id.equals(""))			apvl_seller_id = "00927812446";
	if (apvl_chain_no == null || apvl_chain_no.equals(""))				apvl_chain_no = "";
	if (apvl_seller_id == null || apvl_seller_id.equals(""))			apvl_seller_id = "";
	if (sub_apvl_seller_id == null || sub_apvl_seller_id.equals(""))		sub_apvl_seller_id = "";
	if (apvl_halbu == null || apvl_halbu.equals(""))				apvl_halbu = "00";
	if (POPSIZE == null || POPSIZE.equals(""))					POPSIZE = "Y";

	if (MID == null || MID.equals(""))									MID ="";
	if (BUSINESSTYPE == null || BUSINESSTYPE.equals(""))				BUSINESSTYPE ="";
	if (APVL_SELLER_ID_LT == null || APVL_SELLER_ID_LT.equals(""))		APVL_SELLER_ID_LT ="";
	if (SUB_APVL_SELLER_ID_LT == null || SUB_APVL_SELLER_ID_LT.equals("")) SUB_APVL_SELLER_ID_LT="";
	if (APVL_SS_USEYN == null || APVL_SS_USEYN.equals(""))				APVL_SS_USEYN="N";
	if (PAY == null || PAY.equals(""))									PAY="";
	if (MOBILE == null || MOBILE.equals(""))							MOBILE="";
	if (ORDER_USERID == null || ORDER_USERID.equals(""))
		ORDER_USERID = "";
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
	
	// mpiVbV(ip,port) or mpiVbV(port)
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
			String TermUrl = ret.substring(0, ret.lastIndexOf("/")) + "/auth_host.jsp";
			String TermUrl2 = ret.substring(0, ret.lastIndexOf("/")) + "/auth_actx.jsp";
		//	https://accesscontrol.citibank.co.kr:443/acsapp/SPAC100000.jsp
%>
<html>
<head>
<title>비자 안심클릭 서비스 가입여부 확인중...</title>
</head>
<body OnLoad="onLoadProc();">
	<script type="text/javascript" src="https://www.isaackorea.net/update/ansim/ILKactx.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	<Script type="text/JavaScript">
		<!--
		var cnt = 0;
		var timeout = 600;
		var k_timeout = 1;
		var processed = false;
		var goon = false;
		var childwin = null;
		
		function closePopup(){
			
			if( childwin ) {
				parent.exit();
			}
		}
		function popupIsClosed(){
			
			 childwin =parent.$("#HANAFRAME").css("visibility");
		
		if(childwin) {
				
				if(childwin=="hidden") {
					if( !goon ) {
						if( !processed ) {
							processed = true;
							self.setTimeout("popupIsClosed()", 2000);
						} 
					}
			   }else {
					cnt++;
					if(cnt > timeout){
						popError("작업시간이 초과되었습니다.");
						parent.exit();
				   }else{
						self.setTimeout("popupIsClosed()", 1000);
						
				   }
			   }
			}  			 
		}

		function popError(arg)
		{
			if( cnt < 1 ) {
				onPopupKiller();
				return;
			}

			if( childwin ) {
				exit();
			}
			alert(arg);
			proceed( false );
		}

		function onLoadProc() {
			if("<%=useActiveX%>" == "Y") {
				onPopupKiller();
			} else {
				// Make sure popup window has a name - ILKROCOMOPOPUP
				// 2010-05-13 modify Han
				// KEB popupsize set
				if(("<%=AcsUrl%>".indexOf("yescardacs.keb.co.kr")!=-1 && "<%=POPSIZE%>" == "Y")||("<%=AcsUrl%>".indexOf("acs.hanacard.co.kr")!=-1 && "<%=POPSIZE%>" == "Y")){
					//childwin = window.open('about:blank','ILKROCOMOPOPUP',
						//'height=430,width=590,status=no,dependent=no,scrollbars=no,resizable=no');
				}else if("<%=AcsUrl%>".indexOf("lottecard")!= -1){
                                      //  childwin = window.open('about:blank','ILKROCOMOPOPUP','height=460,width=633,status=no,dependent=no,scrollbars=no,resizable=no');
				}else if("<%=AcsUrl%>".indexOf("citibank")!= -1) {
                                      
                                    var hana= parent.document.getElementById('HANAFRAME');
                                    hana.style.width="640px";
                                    hana.style.height="460px";
                                    hana.style.marginLeft="20px";
                                    var bt= parent.document.getElementById('bt');
                                    bt.style.left="643px";
                                        
                }else if("<%=AcsUrl%>".indexOf("woori")!= -1) {
                                	var bt= parent.document.getElementById('bt');
                                	var hana= parent.document.getElementById('HANAFRAME');
                                	hana.style.width="600px";
                                	hana.style.height="510px";
                                	hana.style.marginTop="-600px";
                                	bt.style.marginTop="-51px";
                                	                        
                    }
				else{
						//document.postForm.POPSIZE.value='N';
        				//childwin = window.open('about:blank','ILKROCOMOPOPUP',
						//'height=400,width=390,status=no,dependent=no,scrollbars=no,resizable=no');
				}
				document.postForm.target = 'HANAFRAME';
				document.postForm.submit();
				popupIsClosed();
			}
		}		
		//2010-08-17 modify Han
		//KEB Ysave and Popsize
		function paramSet(xid, eci, cavv, realPan, ss_useyn, savekind, ss_useyn_ke)
        {	
                var frm = document.frmRet;
                frm.xid.value = xid;
                frm.eci.value = eci;
                frm.cavv.value = cavv;
                frm.realPan.value = realPan;
                frm.ss_useyn.value = ss_useyn;
                frm.savekind.value = savekind;
                frm.ss_useyn_ke.value = ss_useyn_ke;
        }

		function proceed(arg) {
			var frm = document.frmRet;
			goon = true;
			if( arg == true ) {
				frm.proceed.value = "true";
			} else {
				frm.proceed.value = "false";
				
			}
			frm.submit();
		}
		function onPopupKiller() {
			try {
				var ret;
				MpiPlugin.termUrl	= "<%=TermUrl2%>";
				MpiPlugin.pareq		= document.postForm.PaReq.value;
				MpiPlugin.MD		= document.postForm.MD.value;
				MpiPlugin.acsUrl	= document.postForm.action;
				
				//2010-08-17 modify Han
				//KEB Ysave and Popsize
				MpiPlugin.apvl_chain_no    = document.postForm.apvl_chain_no.value;
                MpiPlugin.apvl_seller_id   = document.postForm.apvl_seller_id.value;
                MpiPlugin.apvl_halbu       = document.postForm.apvl_halbu.value;
                MpiPlugin.POPSIZE		   = document.postForm.POPSIZE.value;
                <%
				if(( AcsUrl.indexOf("keb")!=-1 && POPSIZE == "Y")||(AcsUrl.indexOf("acs.hanacard.co.kr")!=-1 && POPSIZE == "Y")){
				%>
                 MpiPlugin.POPSIZE		= document.postForm.POPSIZE.value;
                 MpiPlugin.set_size(600,470); 
				<%
				}else if((AcsUrl.indexOf("lottecard")!= -1)){
				%>
                 MpiPlugin.POPSIZE		= document.postForm.POPSIZE.value;
                 MpiPlugin.set_size(640,470);
                <%
				}else{
				%>
                 MpiPlugin.POPSIZE		= 'N';
                <%
				}
				%>
                
                MpiPlugin.set_size(390,450);
				ret = MpiPlugin.startAuth();
				if( ret == "000" ) {
					//2010-08-17 modify Han
					//KEB Ysave and Popsize
					paramSet( MpiPlugin.xid, MpiPlugin.eci, MpiPlugin.cavv, MpiPlugin.realPan, MpiPlugin.ss_useyn, MpiPlugin.savekind, MpiPlugin.ss_useyn_ke,MpiPlugin.MD);
					proceed(true);
				} else {
					if( ret != "108" ) alert(ret + ":" + FUNC_MPI_ERR_GET(ret));
					proceed(false);
					
				}
			} catch(e) {
 				// Make sure popup window has a name - ILKROCOMOPOPUP
				// 2010-05-13 modify Han
				// KEB popupsize set
				if(("<%=AcsUrl%>".indexOf("yescardacs.keb.co.kr")!=-1 && "<%=POPSIZE%>" == "Y")||("<%=AcsUrl%>".indexOf("acs.hanacard.co.kr")!=-1 && "<%=POPSIZE%>" == "Y")){
					//childwin = window.open('about:blank','ILKROCOMOPOPUP','height=430,width=590,status=no,dependent=no,scrollbars=no,resizable=no');
				}else if("<%=AcsUrl%>".indexOf("lottecard")!= -1){
					//childwin = window.open('about:blank','ILKROCOMOPOPUP','height=460,width=633,status=no,dependent=no,scrollbars=no,resizable=no');
				}else{
					document.postForm.POPSIZE.value='N';
        			//childwin = window.open('about:blank','ILKROCOMOPOPUP','height=400,width=390,status=no,dependent=no,scrollbars=no,resizable=no');
				}
				
				// 2010-09-06 modify Han
				// KEB Popup Value Set
				document.postForm.useActiveX.value='N';
				
				document.postForm.target = 'HANAFRAME';
				document.postForm.submit();
				popupIsClosed();
			}
		}
		//-->
		</Script>
	<form name="postForm" action="<%=AcsUrl%>" method="POST">
		<input type=hidden name=PaReq 		value="<%=PaReq%>"> 
		<input type=hidden name=TermUrl 	value="<%=TermUrl%>"> 
		<input type=hidden name=MD 			value="<%=xid%>">
		<input type=hidden name=goodsname 	value="<%=goodsname%>">

		<!-- 2010-08-17 modify Han -->
		<!-- KEB Ysave and Popsize -->
		<input type=hidden name=apvl_chain_no 		value="<%=apvl_chain_no%>">
		<input type=hidden name=apvl_seller_id 		value="<%=apvl_seller_id%>">
		<input type=hidden name=sub_apvl_seller_id 	value="<%=sub_apvl_seller_id%>"> 
		<input type=hidden name=apvl_halbu 			value="<%=apvl_halbu%>"> 
		<input type=hidden name=APVL_CHAIN_NO 		value="<%=apvl_chain_no%>"> 
		<input type=hidden name=APVL_SELLER_ID 		value="<%=apvl_seller_id%>">
		<input type=hidden name=SUB_APVL_SELLER_ID  value="<%=sub_apvl_seller_id%>"> 
		<input type=hidden name=APVL_HALBU 			value="<%=apvl_halbu%>"> 
		<input type=hidden name=POPSIZE 			value="<%=POPSIZE%>">

		<!-- 2010-09-06 modify Han -->
		<!-- KEB Popup -->
		<input type=hidden name=useActiveX 				value="<%=useActiveX%>">
		<!-- 2012-06-25 Lotte total by HGT4 -->
		<input type=hidden name=MID 					value="<%=MID%>"> 
		<input type=hidden name=BUSINESSTYPE 			value="<%=BUSINESSTYPE%>"> 
		<input type=hidden name=APVL_SELLER_ID_LT 		value="<%=APVL_SELLER_ID_LT%>">
		<input type=hidden name=SUB_APVL_SELLER_ID_LT   value="<%=SUB_APVL_SELLER_ID_LT%>"> 
		<input type=hidden name=APVL_SS_USEYN 			value="<%=APVL_SS_USEYN%>"> 
		<input type=hidden name=PAY 					value="<%=PAY%>"> 
		<input type=hidden name=MOBILE 					value="<%=MOBILE%>"> 
		<input type=hidden name=ORDER_USERID 			value="<%=ORDER_USERID%>">
		<!-- 2012-06-25 Lotte total by HGT4 -->
		<input type=hidden name=MPIID 					value="<%=md5(TermUrl)%>">

	</form>
	<form name=frmRet method=post action="<%=returnUrl%>">
		<input type=hidden name=proceed 	value=""> 
		<input type=hidden name=xid 		value=""> 
		<input type=hidden name=eci 		value="">
		<input type=hidden name=cavv 		value=""> 
		<input type=hidden name=realPan 	value="">

		<!-- 2010-08-17 modify Han -->
		<!-- KEB Ysave and Popsize -->
		<input type=hidden name=ss_useyn 	value=""> 
		<input type=hidden name=savekind 	value=""> 
		<input type=hidden name=ss_useyn_ke value="">
		<!-- 2012-06-25 Lotte total by HGT4 -->
		<input type=hidden name=AUTH_TYPE   value=""> 
		<input type=hidden name=errCode 	value="<%=errorCode%>">
	</form>
</body>
</html>
<%
	return; // done successfully

		} else { // not enrolled pan or unable to verify
			auth_msg = errorCode + ": " + errs.get(errorCode);
		}

	} else { // Operation failed, internal error, or ISP pan

		if (mpi.getErrorCode() == null || mpi.getErrorCode().equals("") || mpi.getErrorCode().equals("000")) {

			enrolled = "X";
			if (errorCode != null)
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
			if (errorCode == null)
				errorCode = "";

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
	} // Operation succeeded or not
%>

<html>
<script type="text/javascript">
function onLoadProc() {
	var frm = document.frmRet;
	var proceed = true;

	if( "<%=auth_msg%>" != "" ) {
		proceed = false;
			alert("<%=auth_msg%>");
			parent.exit();
	
		}
		if (proceed) {
			frm.proceed.value = "true";
		} else {
			frm.proceed.value = "false";
		}
		frm.submit();
	}
</script>
<body onload="javascript:onLoadProc();">
	<form name=frmRet method=post action="<%=returnUrl%>">
		<input type=hidden name=proceed value=""> 
		<input type=hidden name=xid 	value=""> 
		<input type=hidden name=eci 	value="">
		<input type=hidden name=cavv 	value=""> 
		<input type=hidden name=realPan value=""> 
		<input type=hidden name=errCode value="<%=errorCode%>">
	</form>
</body>
</html>

<%!public static String md5(String str) {

		if (str == null) {
			return null;
		}

		MessageDigest messageDigest = null;

		try {
			messageDigest = MessageDigest.getInstance("MD5");
			messageDigest.reset();
			messageDigest.update(str.getBytes("UTF-8"));
		} catch (NoSuchAlgorithmException e) {

			return str;
		} catch (UnsupportedEncodingException e) {
			return str;
		}

		byte[] byteArray = messageDigest.digest();

		StringBuffer md5StrBuff = new StringBuffer();

		for (int i = 0; i < byteArray.length; i++) {
			if (Integer.toHexString(0xFF & byteArray[i]).length() == 1)
				md5StrBuff.append("0").append(Integer.toHexString(0xFF & byteArray[i]));
			else
				md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));
		}

			return md5StrBuff.toString();
	}%>
