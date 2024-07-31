<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page language="java" contentType="text/html; charset=utf-8"  %>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.*"%>
<%-- <%@page import="com.rocomo.Property,com.rocomo.MallUtil, util.*" %> --%>
<%@page import="com.rocomo.*" %>
<html>
<head>
<title>간편결제 서비스 진행중</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<style type="text/css">
<!--
BODY {  font-size: 9pt; line-height: 140%; text-decoration: none}
-->
</style>
<%
/*
String[] CARD_NAME_LIST = null;
boolean IS_INSTALL = false;
MallCertManager certMgr = null;
String privateKeyPath = "";
String signKeyPath = "";
String signCertPath = "";
String encPasswordPath = ""; 
    try {
        //로컬에서 테스트 시를 위해 추가

        String os = System.getenv("OS");
        System.out.println("OS["+os+"]");
        String defaultPath = "/home/infinisoft/WAS/tomcat-pg-ipay/webapps/ipay/WEB-INF/classes";
        String certPath = "/home/infinisoft/WAS/tomcat-pg-ipay/webapps/ipay/cert/real";

        if(!StringUtils.isEmpty(os) && os.contains("Windows")){
            defaultPath = "C:/eclipse_workspace2/InfiniPG_ipay_new/src/main/resources";
            certPath = "C:/eclipse_workspace2/InfiniPG_ipay_new/src/main/webapp/cert/real";
        }
        System.out.println("defaultPath ["+defaultPath+"]");            
        Property.init(defaultPath, "rocomo_smpi");  //("프로퍼티 파일 경로","프로퍼티파일 이름")
        
        privateKeyPath = certPath+Property.get("smpi.private_key_path").trim();
        signKeyPath    = certPath+Property.get("smpi.sign_key_path").trim();
        signCertPath   = certPath+Property.get("smpi.sign_cert_path").trim();
        encPasswordPath= certPath+Property.get("smpi.enc_password_path").trim();
         
        // 카드사명 리스트
        CARD_NAME_LIST = MallUtil.parsingByDelimiter(Property.get("smpi.card_name_list").trim() , ",");  
        if (CARD_NAME_LIST.length == 0) throw new Exception("설정파일 : properties의 'CARD_NAME_LIST'설정값을 확인하시기 바랍니다.");
        IS_INSTALL = true;

    }
    catch (Exception e) {
        System.out.println(e.getMessage());
        System.out.println("인증 모듈 설치 오류...[설정파일 : properties의 설정 정보를 확인하시기 바랍니다...]");
        IS_INSTALL = false;
    }
*/
%>
<%!

	private static String[] CARD_NAME_LIST;
	private static boolean IS_INSTALL = false;

	static {
		try {
			//로컬에서 테스트 시를 위해 추가
			String os = System.getenv("OS");
			String defaultPath = "/home/infinisoft/WAS/tomcat-pg-ipay/webapps/ipay/WEB-INF/classes";
            String certPath = "/home/infinisoft/WAS/tomcat-pg-ipay/webapps/ipay/cert/real";

            if(!StringUtils.isEmpty(os) && os.contains("Windows")){
                defaultPath = "C:/eclipse_workspace2/InfiniPG_ipay_new/src/main/resources";
                certPath = "C:/eclipse_workspace2/InfiniPG_ipay_new/src/main/webapp/cert/real";
            }
            
			Property.init(defaultPath, "rocomo_smpi");  //("프로퍼티 파일 경로","프로퍼티파일 이름")

			MallCertManager.init(certPath+Property.get("smpi.private_key_path"),
					certPath+Property.get("smpi.sign_key_path"),
					certPath+Property.get("smpi.sign_cert_path"),
					certPath+Property.get("smpi.enc_password_path")
			);	

	        // 카드사명 리스트
			CARD_NAME_LIST = MallUtil.parsingByDelimiter(Property.get("smpi.card_name_list") , ",");	 
			if (CARD_NAME_LIST.length == 0) throw new Exception("설정파일 : properties의 'CARD_NAME_LIST'설정값을 확인하시기 바랍니다.");
			IS_INSTALL = true;

		}catch (Exception e) {
			System.out.println("인증 모듈 설치 오류...[설정파일 : properties의 설정 정보를 확인하시기 바랍니다...]");
			IS_INSTALL = false;
			
		}
	}

%>
<%
String r0="";
	if (!IS_INSTALL) {
		//오류처리...
		r0="9999";
%>
<script type="text/javascript">
	alert('SMPI가 정상적으로 설치되지 않았습니다. \n설정파일[properties]을 확인하시기 바랍니다. \n[쇼핑몰 관리자에게 문의]');
	//parent.document.getElementById("SPSDIV").style.display = "none";
	parent.ansimItems(false);
    window.location.href="../xansim/iframe.jsp";
</script>
<%
	}
%>
<%
	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","-1");
	response.setHeader("pragma","no-cache");

	//한글처리...
	request.setCharacterEncoding("EUC-KR");
// 	request.setCharacterEncoding("UTF-8");
	
	//CookieUtil cookieUtil = new CookieUtil(request);
	
	r0 = request.getParameter("r0");
	String r1 = request.getParameter("r1");
	String r2 = request.getParameter("r2");
	String r3 = request.getParameter("r3");
	String r4 = request.getParameter("r4");
	String msg = request.getParameter("msg");	
	System.out.println("r0["+r0+"]");
    System.out.println("r1["+r1+"]");
    System.out.println("r2["+r2+"]");
    System.out.println("r3["+r3+"]");
    System.out.println("r4["+r4+"]");
    System.out.println("msg["+msg+"]");
    if(msg!=null){
        msg = URLDecoder.decode(msg,"UTF-8");
    }
	String pares = "";

	String xid = "";
	String encXid ="";
	String eci = "";
	String cavv = "";
	String card_no = "";
	String restype = "";
	String result = "9999";//default = 9999(error) : 0000 (succ)
	
	String sxid = (String)session.getAttribute("com.smpi.xid");
	String order_cardname = (String)session.getAttribute("com.smpi.order_cardname");
	String reqtype = "";
	String cardPkPath	= Property.get("smpi."+order_cardname.toLowerCase() + "_pk_path");	
	try {
		if (r0.equals("0000")) {
			//데이타 복호화...
			MallCertManager certMgr = new MallCertManager(cardPkPath);
			//certMgr = new MallCertManager(cardPkPath);
			//if(!certMgr.isInit()){
	        //    System.out.println("MallCertManager is not set");
	        //    certMgr.init(privateKeyPath, signKeyPath, signCertPath, encPasswordPath);    
	        //}
			pares = certMgr.decrypt(r1,r2,r3,r4);
			HashMap hm = MallUtil.getTokenValue(pares,"|");
			
			if(hm.get("ENCXID") != null){
				encXid	= URLDecoder.decode((String)hm.get("ENCXID"));	
			}
			if(hm.get("CAVV") != null){
				cavv 	= URLDecoder.decode((String)hm.get("CAVV"));	
			}
			
			xid = (String)hm.get("XID");
			eci 	= (String)hm.get("ECI");
			card_no = (String)hm.get("CARD_NO");
			restype = (String)hm.get("RESTYPE");
			result = "0000";
			
			hm = null;
		}
		else if (r0.equals("")) {
			restype = r1; /* if error, r1 includes restype */
			r0 = "9999";
			msg = "카드사에서 응답값을 주지 않았습니다.";	
		}
		else {
			restype = r1; /* if error, r1 includes restype */
			//카드사에서 정상"0000"이 아닌 응답을 주었음...
			System.out.println(new Date() + ": 카드사 응답코드 [" + r0 + "], 응답메시지 [" + msg + "]");
		}
	}
	catch (Exception e) {
		r0 = "9902";
		msg = "처리중 오류가 발생했습니다. 다시 시도하여 주시기 바랍니다.";
		restype = reqtype;
	}

	if (xid == null) xid = "";
	if (eci == null) eci = "";
	if (cavv == null) cavv = "";
	if (card_no == null) card_no = "";

	if (restype == null) restype = "";
	if (result == null) result = "";
%>
<script type='text/javascript'>
	function setCertResult1() {
		if( '<%=r0%>' != "0000" ) { 
			//결제완료, 수정완료, 가입완료가 되지 않고 사용자에 의해 취소가 되거나 원치않게 종료가 되었을때처리
			alert("[<%=r0%>]:<%=msg%>");		
		    parent.setErrorResult();

		}else{
			//정상처리		
			parent.certResult = true;
			parent.setCertResult("<%=encXid.trim()%>","<%=eci%>","<%=cavv.trim()%>", "<%=card_no.trim()%>" );
		}
		//checkSPS = false;
		//parent.document.getElementById("SPSDIV").style.display = "none";
		//parent.document.getElementById("SPSDIV2").style.display = "none";
		
	}
	function returnPaymentPage() {
	}
</script>
</head>
<body onload="setCertResult1();">
카드사로 부터 받은 인증 결과 받아 처리중입니다.
<br>잠시만 기다리시기 바랍니다.
 
<form name="frmID" method="POST" action="" target="SPSFRAME">
<input type="hidden" name="rsCode"	value = "<%=r0%>">
<input type="hidden" name="msg"	value = "<%=msg%>">
<input type="hidden" name="encXid"	value = "<%=encXid.trim()%>">
<input type="hidden" name="eci"	value = "<%=eci.trim()%>">
<input type="hidden" name="cavv"	value = "<%=cavv.trim()%>">
<input type="hidden" name="card_no"	value = "<%=card_no.trim()%>">
<input type="hidden" name="restype"	value = "<%=restype%>">
<input type="hidden" name="result"	value = "<%=result%>">
</form>
<!-- 카드사로 부터 받은 인증 결과 처리 중입니다. -->
</body>
</html>