<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"  %>
<%@ page import="java.util.Properties, java.io.*,java.util.*" %>
<%@page import="java.util.HashMap, java.util.Map.Entry"%>
<%-- <%@page import="com.rocomo.Property,com.rocomo.MallUtil, util.*" %> --%>
<%@page import="com.rocomo.*" %>
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
**/
%>
<%!

	private static String[] CARD_NAME_LIST;
	private static boolean IS_INSTALL = false;
	static {
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
			//if(MallCertManager.class.getClass() == null){
			//    System.out.println("**** MallCertManager is null");
			MallCertManager.init(certPath+Property.get("smpi.private_key_path").trim(),
					certPath+Property.get("smpi.sign_key_path").trim(),
					certPath+Property.get("smpi.sign_cert_path").trim(),
					certPath+Property.get("smpi.enc_password_path").trim()
				);		    
			//}
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
	}

%>
<html>
<head>
<title>간편결제 서비스 진행중</title>
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="p3p" content='CP="ALL CURa ADMa DEVa TAIa OUR BUS IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC OTC"' >
<!--
	간편결제
	반드시 해당 인증요청 페이지에 추가하시기 바랍니다.
-->
<%
System.out.println("---- start SMPIAgent01.jsp ----");
	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","-1");
	response.setHeader("pragma","no-cache");
	response.setHeader("P3P", "CP='ALL CURa ADMa DEVa TAIa OUR BUS IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC OTC'");

	//한글처리...
	request.setCharacterEncoding("UTF-8");

	String BIZ_TYPE = Property.get("smpi.biz_type").trim();  // 쇼핑몰/PG 구분
    String BIZ_NO = Property.get("smpi.biz_no").trim();      // 쇼핑몰/PG의 사업자번호
	
	String RECV_URL = "";
	if (request.getServerPort() == 80 || request.getServerPort() == 443) {
		RECV_URL = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort() +"/ipay/card/rocomo/SMPIAgent02.jsp";
	} else {
		RECV_URL = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort() +"/ipay/card/rocomo/SMPIAgent02.jsp";
	}	
	System.out.println("["+RECV_URL+"]");
	if (!IS_INSTALL) {
		//오류처리...
		%>
		<script type="text/javascript">
			alert('SMPI가 정상적으로 설치되지 않았습니다. \n설정파일[properties]을 확인하시기 바랍니다. \n[쇼핑몰 관리자에게 문의]');
			//parent.document.getElementById("SPSDIV").style.display = "none";
			parent.install_mpi_notice_off();
			parent.disableItems(false);
			//parent.ansimItems(false);
			window.location.href="../xansim/iframe.jsp";
		</script>
		<%
		return;
	}

	// form parameter data 저장...
	HashMap map = new HashMap();
	map.putAll(request.getParameterMap());
	
	// 카드사명...
	String order_cardname = ((String[])map.get("order_cardname"))[0];
	boolean isOkCardName = MallUtil.checkCardName(CARD_NAME_LIST, order_cardname);

	if (!isOkCardName) {
		//오류처리... (카드사명이 잘못되었음)
		throw new Exception("간편결제 서비스가 지원되지 않은 카드사[" + order_cardname + "]입니다.");
	}

	// 설정 정보에서 선택된 해당 카드사 접속 정보를 가져옴...
	
    String cardPareqURL = Property.get("smpi."+order_cardname.trim().toLowerCase() + "_url");
	String mId          = Property.get("smpi."+order_cardname.trim().toLowerCase() + "_mid");
	String cardPkPath	= Property.get("smpi."+order_cardname.trim().toLowerCase() + "_pk_path");	

	System.out.println("cardPareqURL["+cardPareqURL+"]");
    System.out.println("mId["+mId+"]");
    System.out.println("cardPkPath["+cardPkPath+"]");
    System.out.println("BIZ_NO["+BIZ_NO+"]");
    System.out.println("BIZ_TYPE["+BIZ_TYPE+"]");
    System.out.println("RECV_URL["+RECV_URL+"]");
	/*************************************************************************************************
		Xid : 거래 건당 unique 한 값으로 40자리
	 	몰에서 생성한 값으로 카드사에 리턴온 값에  해당Xid가 있어야만 정상적인 린턴값으로 인증한다.
	 	agent01 에서 생성후 agent02에서 카드사에 보내온값을 복호화후  Xid가 동일한지 검증
	 	세션변수나 DB등 몰의 환경에 맞게세팅하시면 됩니다.
	 	Xid : 40자리의 숫자로 생성 , 40자리는 꼭 맞추어야 합니다.
	 	default값이 아닌 쇼핑몰에 생성한 임의의 값을넘기셔도 됩니다.
	 	default : 사업자 번호(10) + 일자(8, yyyyMMdd) + 시간(9, HHmmssSSS)+나머지는 "9"로 채움.
 	***************************************************************************************************/
 	String xid = MallUtil.getXid(BIZ_NO.trim());

	/** 	
	// xid, order_cardname 쿠키에 저장...
	CookieUtil cookieUtil = new CookieUtil(request);
	response.addCookie(cookieUtil.createCookie("com.smpi.xid", xid));
	response.addCookie(cookieUtil.createCookie("com.smpi.order_cardname", order_cardname));
    **/
    // 세션처리로 변경 2016.02.10
    session = request.getSession(true);
    session.setAttribute("com.smpi.xid", xid);
    session.setAttribute("com.smpi.order_cardname", order_cardname);

	// 카드사로 보낼 인증 요청 데이타에 쇼핑몰/PG 정보 저장...
	map.put("businessType", BIZ_TYPE);
	map.put("businessNo", BIZ_NO);
	map.put("receiveUrl", RECV_URL);

	// 카드사로 보낼 인증 요청 데이타에 카드사로 부터 부여받은 ID 저장...
	map.put("mId", mId);

	// 인증요청의 거래관리번호인 xid정보를 카드사 인증 요청 데이타에 저장...
	map.put("xid", xid);

	// 인증요청 시작일자, 시간을 카드사로 보낼 인증 요청 데이타에 저장...
	map.put("Date", MallUtil.getCurrentDate());
	map.put("Time", MallUtil.getCurrentTime());

	// 카드사로 보낼 인증요청 메시지 생성...
	String originalMsg = MallUtil.makePareqData(map);
	String[] encData = null;

	try {
		//데이타 암호화...
		System.out.println("데이타 암호화 : MallCertManager의 encrypt() 메소드 시작.");
		MallCertManager certMgr = new MallCertManager(cardPkPath);
		//certMgr = new MallCertManager(cardPkPath);
		//if(!certMgr.isInit()){
		//    System.out.println("MallCertManager is not set");
		//    certMgr.init(privateKeyPath, signKeyPath, signCertPath, encPasswordPath);    
		//}
		
		System.out.println("originalMsg["+originalMsg+"]");
		encData = certMgr.encrypt(originalMsg);
		System.out.println("데이타 암호화 : MallCertManager의 encrypt() 메소드 정상 종료.");
	}
	catch (Exception e) {
		System.out.println("lotte_smpi_error "+e.getMessage());
		e.printStackTrace();
%>
<script type="text/javascript">
	alert('메세지 암호화 중 오류가 발생하였습니다.\n쇼핑몰 담당자에 문의하시기 바랍니다.');
	//parent.document.getElementById("SPSDIV").style.display = "none";
	parent.install_mpi_notice_off();
    parent.disableItems(false);
	//parent.ansimItems(false);
    window.location.href="../xansim/iframe.jsp";
</script>
<%
		return;
	}

	String pareq1=encData[0];  //session key
	String pareq2=encData[1];  //암호화된 pareq
	String pareq3=encData[2];  //전자서명 인증서
	String pareq4=encData[3];  //전자서명값	
%>
<script type="text/javascript">
var certResult = false;		//카드사로 부터 인증결과를 받으면 true로 변경됨...
var childwin = null;        //결제창
var cnt = 0;

//결제화면에서 선택한 카드사의 인증 POPUP창을 OPEN한다...
function openSimplepay() {
	var PopOption = 'width=639,height=465,status=no,dependent=no,scrollbars=no,resizable=no';

	document.forms[0].target="SPSFRAME";
	document.forms[0].method="post";
	document.forms[0].action="<%=cardPareqURL%>"; 
	//parent.document.getElementById("SPSDIV").style.display = "";
	document.forms[0].submit();
}

function proceed(proceed) {
    certResult = proceed;
}
</script>
<body onload="javascript:openSimplepay();">
<form name=SIMPLEPAYFORM>
	<input type=hidden name="pareq1" value="<%=pareq1%>"><br>
	<input type=hidden name="pareq2" value="<%=pareq2%>"><br>
	<input type=hidden name="pareq3" value="<%=pareq3%>"><br>
	<input type=hidden name="pareq4" value="<%=pareq4%>"><br>
</form>
</body>
</html>
