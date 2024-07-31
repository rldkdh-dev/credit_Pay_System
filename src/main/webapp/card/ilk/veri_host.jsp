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

		errs.put("301",	"ī���ȣ ���� üũ �Ұ�(ī���ȣ Ȯ�ο��)");
		errs.put("302",	"����� ���� ���� ī�����(ī���ȣ Ȯ�ο��, ī��� ���ǿ��)");
		errs.put("303",	"���� �Ƚ�Ŭ���� ���ԵǾ� ���� ����(ī���ȣ Ȯ�ο��, ī��� ���ǿ��)");
		errs.put("304",	"ī��� �ý��۹����� ���Ͽ� ���Կ��θ� �˼� ����(ī��� ���ǿ��)");
		errs.put("311",	"���Կ��� ���� ����(ī���ȣ Ȯ�ο��)");
		errs.put("312",	"���Կ��� ���� ���� �Ұ�");
		errs.put("321",	"ī��翡 ���� ���� ���� �߻�(ī��� ���ǿ��)");
		errs.put("322",	"ī��翡 ���ӽð� �ʰ�(ī��� ���ǿ��)");
		errs.put("323",	"ī���� ��ŵ��� ���� �߻�(ī��� ���ǿ��)");
		errs.put("324",	"ī��翡 ������ ����ð� �ʰ�(ī��� ���ǿ��)");
		errs.put("331",	"ī����� ������ ��ȿ���� ����(ī��� ���ǿ��)");
		errs.put("332",	"���Կ��� Ȯ�ο�û �޽����� ������ ����");
		errs.put("333",	"ī����� ������ ��ȿ���� ����(ī��� ���ǿ��)");
		errs.put("334",	"ī����� ������ ��ȿ���� ����(ī��� ���ǿ��)");
		errs.put("341",	"������û ���� ���� ����");
		errs.put("351",	"����� ������ �߻��Ͽ����ϴ�");
		errs.put("401",	"������� ������ ��ȿ���� ����(ī��� ���ǿ��)");
		errs.put("402",	"������� ���� ����(ī��� ���ǿ��)");
		errs.put("404",	"������� ���� ����(ī��� ���ǿ��)");
		errs.put("405",	"���� ������û ������ 2ȸ�̻� ����(�˾����������� ���ΰ�ħ�� �Ͻø� ����ŷ��� ���� �ʽ��ϴ�)");
		//errs.put("405",	"������û ������ ������ �ֽ��ϴ�. ���θ� ����ڿ��� �����Ͻñ� �ٶ��ϴ�.");	//�����޽����� �̰ŷ� �������� ������.
		errs.put("406",	"������� ������ �߸���(ī��� ���ǿ��)");
		errs.put("407",	"��������. ����â���� ��Ҹ� �Ͻø� ������ ���� �ʽ��ϴ�.");
		errs.put("408",	"�����Ұ�(ī��� ���ǿ��)");
		errs.put("409",	"������� ���� ������ �����߻�(ī��� ���ǿ��)");
		errs.put("411",	"������� ���� ������ �����߻�(ī��� ���ǿ��)");
		errs.put("412",	"������� ���� ������ �����߻�(ī��� ���ǿ��)");
		errs.put("413",	"������� ���� ������ �����߻�(ī��� ���ǿ��)");
		errs.put("414",	"������� ���� ������ �����߻�(ī��� ���ǿ��)");
		errs.put("415",	"������� ���� ������ �����߻�(ī��� ���ǿ��)");
		errs.put("431",	"����� ������ �߻��Ͽ����ϴ�");
		errs.put("501",	"���� ó�� ����(�ٽ��ѹ� �õ��� �ֽʽÿ�)");
		errs.put("502",	"���� ó�� ����");
		errs.put("503",	"���� ó�� ����");
		errs.put("611",	"�����ͺ��̽� ó�� ����(�ٽ��ѹ� �õ��� �ֽʽÿ�)");
		errs.put("612",	"�����ͺ��̽� ó�� ����(�ٽ��ѹ� �õ��� �ֽʽÿ�)");
		errs.put("613",	"�����ͺ��̽� ó�� ����(�ٽ��ѹ� �õ��� �ֽʽÿ�)");
		errs.put("995",	"ActiveX ����� ��ġ���� �ʾ��� ���.");
  	errs.put("996",	"����/�� ī��� ISP(��������)�� ����ϼž��մϴ�.");
		errs.put("997",	"����ó�� ���� ������ �߻��Ͽ����ϴ�.(�ٽ��ѹ� �õ��� �ֽýÿ�)");
		errs.put("998",	"�ʿ��� �Ű������� �����ϴ�.(���θ��� ���� �ٶ��ϴ�)");
		errs.put("999",	"�Ű������� �߸��Ǿ����ϴ�.(ī���ȣ�� ��ȿ�Ⱓ�� Ȯ�ιٶ��ϴ�)");

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

	//�Ե� ������ ����(X-MPI�� ���ϰ�)
    String MID 						= (String)request.getParameter("MID"); //������ID(�ִ�20,����+����):����X-MPI �״�� ����
    String BUSINESSTYPE 	      	= (String)request.getParameter("BUSINESSTYPE"); //�����������ڵ�(PG:P, ���θ�:M):ī��� ��������� ����
	String APVL_SELLER_ID_LT        = (String)request.getParameter("APVL_SELLER_ID_LT"); //����� ��ȣ(BUSINESSTYPE=M�� ��� ����ڹ�ȣ�� ��������� �����ؾߵ�)
	String SUB_APVL_SELLER_ID_LT    = (String)request.getParameter("SUB_APVL_SELLER_ID_LT"); //��������� ��ȣ(BUSINESSTYPE=P�� ��� ����������ʼ��� ����������� ��)
	//�Ե�ī�� ���μ��̺�
	String APVL_SS_USEYN            = (String)request.getParameter("APVL_SS_USEYN"); //���μ��̺� ����� ��뿩�� Y,N
	//�Ե�ī�� ���� �Ƚɼ���
	String PAY               	 	= (String)request.getParameter("PAY");  //���� ���� default ����(�ɼ�): SPS(�������-����), ACS(�Ƚ�Ŭ��)
	String MOBILE               	= (String)request.getParameter("MOBILE");   //����� ���� Y,N 
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
		name = strCut(name, 25);	// ILK ACS���� 25bytes�� �����..(visa spec���� 25characters������...)
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
					// mpi�� ��� ����
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

			// �߿�: servlet ������ ���� "https"�� "http"�� �������� ��찡 ������ �׷� ��쿡�� 
			//       URL�� ���� �ϵ��ڵ� �Ͻñ� �ٶ��ϴ�.
			String ret = HttpUtils.getRequestURL(request).toString();
			String TermUrl = ret.substring(0, ret.lastIndexOf("/")) + "/auth_host.jsp";
			String TermUrl2 = ret.substring(0, ret.lastIndexOf("/")) + "/auth_actx.jsp";
		//	https://accesscontrol.citibank.co.kr:443/acsapp/SPAC100000.jsp
%>
<html>
<head>
<title>���� �Ƚ�Ŭ�� ���� ���Կ��� Ȯ����...</title>
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
						popError("�۾��ð��� �ʰ��Ǿ����ϴ�.");
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
				auth_msg = errorCode + ": " + "���� �Ƚ�Ŭ�� ���� ��ȸ ���ȿ� ��ְ� �߻��Ǿ����ϴ�.";

			/* rchoi - 2005.02.02 : for ISP
			if( !result ) {
				enrolled = "X";
				auth_msg = errorCode + ": " + "�Ѿ�� �Ķ���Ϳ� ������ �ֽ��ϴ�. " + mpi.getErrorList().replace('\n',' ') + auth_msg;
			} else {
				
				auth_msg = errorCode + ": " + "���� �Ƚ�Ŭ�� ���� ��ȸ ���ȿ� ��ְ� �߻��Ǿ����ϴ�.";
			}
			*/
			// ������ ���Ͽ� DB�� ������ �ȳ��������� �����ϰ� insert�Ѵ�.
			if (errorCode == null)
				errorCode = "";

			// hjseo, 2005-01-20 ����
			// �� field�� ���� ���̸� check�Ͽ� over�� ��� �ش� ����ŭ�� �߶� �־��ֵ��� ����.
			// �������� db insert�� ���� �߻��Ͽ� DB�� �Ƚ׿�����.
			// �ѱ��� ���� ���� �ֱ⶧���� substring�� �ȵǰ� byte�� ©�����...
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
