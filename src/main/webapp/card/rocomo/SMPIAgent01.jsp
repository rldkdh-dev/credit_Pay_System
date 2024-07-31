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
        //���ÿ��� �׽�Ʈ �ø� ���� �߰�

        String os = System.getenv("OS");
        System.out.println("OS["+os+"]");
        String defaultPath = "/home/infinisoft/WAS/tomcat-pg-ipay/webapps/ipay/WEB-INF/classes";
        String certPath = "/home/infinisoft/WAS/tomcat-pg-ipay/webapps/ipay/cert/real";

        if(!StringUtils.isEmpty(os) && os.contains("Windows")){
            defaultPath = "C:/eclipse_workspace2/InfiniPG_ipay_new/src/main/resources";
            certPath = "C:/eclipse_workspace2/InfiniPG_ipay_new/src/main/webapp/cert/real";
        }
        System.out.println("defaultPath ["+defaultPath+"]");            
        Property.init(defaultPath, "rocomo_smpi");  //("������Ƽ ���� ���","������Ƽ���� �̸�")
        
        privateKeyPath = certPath+Property.get("smpi.private_key_path").trim();
        signKeyPath    = certPath+Property.get("smpi.sign_key_path").trim();
        signCertPath   = certPath+Property.get("smpi.sign_cert_path").trim();
        encPasswordPath= certPath+Property.get("smpi.enc_password_path").trim();
         
        // ī���� ����Ʈ
        CARD_NAME_LIST = MallUtil.parsingByDelimiter(Property.get("smpi.card_name_list").trim() , ",");  
        if (CARD_NAME_LIST.length == 0) throw new Exception("�������� : properties�� 'CARD_NAME_LIST'�������� Ȯ���Ͻñ� �ٶ��ϴ�.");
        IS_INSTALL = true;

    }
    catch (Exception e) {
        System.out.println(e.getMessage());
        System.out.println("���� ��� ��ġ ����...[�������� : properties�� ���� ������ Ȯ���Ͻñ� �ٶ��ϴ�...]");
        IS_INSTALL = false;
    }
**/
%>
<%!

	private static String[] CARD_NAME_LIST;
	private static boolean IS_INSTALL = false;
	static {
		try {
			//���ÿ��� �׽�Ʈ �ø� ���� �߰�

			String os = System.getenv("OS");
	        System.out.println("OS["+os+"]");
		    String defaultPath = "/home/infinisoft/WAS/tomcat-pg-ipay/webapps/ipay/WEB-INF/classes";
			String certPath = "/home/infinisoft/WAS/tomcat-pg-ipay/webapps/ipay/cert/real";

			if(!StringUtils.isEmpty(os) && os.contains("Windows")){
				defaultPath = "C:/eclipse_workspace2/InfiniPG_ipay_new/src/main/resources";
				certPath = "C:/eclipse_workspace2/InfiniPG_ipay_new/src/main/webapp/cert/real";
			}
			System.out.println("defaultPath ["+defaultPath+"]");			
			Property.init(defaultPath, "rocomo_smpi");  //("������Ƽ ���� ���","������Ƽ���� �̸�")
			//if(MallCertManager.class.getClass() == null){
			//    System.out.println("**** MallCertManager is null");
			MallCertManager.init(certPath+Property.get("smpi.private_key_path").trim(),
					certPath+Property.get("smpi.sign_key_path").trim(),
					certPath+Property.get("smpi.sign_cert_path").trim(),
					certPath+Property.get("smpi.enc_password_path").trim()
				);		    
			//}
	        // ī���� ����Ʈ
			CARD_NAME_LIST = MallUtil.parsingByDelimiter(Property.get("smpi.card_name_list").trim() , ",");	 
			if (CARD_NAME_LIST.length == 0) throw new Exception("�������� : properties�� 'CARD_NAME_LIST'�������� Ȯ���Ͻñ� �ٶ��ϴ�.");
			IS_INSTALL = true;

		}
		catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("���� ��� ��ġ ����...[�������� : properties�� ���� ������ Ȯ���Ͻñ� �ٶ��ϴ�...]");
			IS_INSTALL = false;
		}
	}

%>
<html>
<head>
<title>������� ���� ������</title>
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="p3p" content='CP="ALL CURa ADMa DEVa TAIa OUR BUS IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC OTC"' >
<!--
	�������
	�ݵ�� �ش� ������û �������� �߰��Ͻñ� �ٶ��ϴ�.
-->
<%
System.out.println("---- start SMPIAgent01.jsp ----");
	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","-1");
	response.setHeader("pragma","no-cache");
	response.setHeader("P3P", "CP='ALL CURa ADMa DEVa TAIa OUR BUS IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC OTC'");

	//�ѱ�ó��...
	request.setCharacterEncoding("UTF-8");

	String BIZ_TYPE = Property.get("smpi.biz_type").trim();  // ���θ�/PG ����
    String BIZ_NO = Property.get("smpi.biz_no").trim();      // ���θ�/PG�� ����ڹ�ȣ
	
	String RECV_URL = "";
	if (request.getServerPort() == 80 || request.getServerPort() == 443) {
		RECV_URL = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort() +"/ipay/card/rocomo/SMPIAgent02.jsp";
	} else {
		RECV_URL = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort() +"/ipay/card/rocomo/SMPIAgent02.jsp";
	}	
	System.out.println("["+RECV_URL+"]");
	if (!IS_INSTALL) {
		//����ó��...
		%>
		<script type="text/javascript">
			alert('SMPI�� ���������� ��ġ���� �ʾҽ��ϴ�. \n��������[properties]�� Ȯ���Ͻñ� �ٶ��ϴ�. \n[���θ� �����ڿ��� ����]');
			//parent.document.getElementById("SPSDIV").style.display = "none";
			parent.install_mpi_notice_off();
			parent.disableItems(false);
			//parent.ansimItems(false);
			window.location.href="../xansim/iframe.jsp";
		</script>
		<%
		return;
	}

	// form parameter data ����...
	HashMap map = new HashMap();
	map.putAll(request.getParameterMap());
	
	// ī����...
	String order_cardname = ((String[])map.get("order_cardname"))[0];
	boolean isOkCardName = MallUtil.checkCardName(CARD_NAME_LIST, order_cardname);

	if (!isOkCardName) {
		//����ó��... (ī������ �߸��Ǿ���)
		throw new Exception("������� ���񽺰� �������� ���� ī���[" + order_cardname + "]�Դϴ�.");
	}

	// ���� �������� ���õ� �ش� ī��� ���� ������ ������...
	
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
		Xid : �ŷ� �Ǵ� unique �� ������ 40�ڸ�
	 	������ ������ ������ ī��翡 ���Ͽ� ����  �ش�Xid�� �־�߸� �������� ���ϰ����� �����Ѵ�.
	 	agent01 ���� ������ agent02���� ī��翡 �����°��� ��ȣȭ��  Xid�� �������� ����
	 	���Ǻ����� DB�� ���� ȯ�濡 �°Լ����Ͻø� �˴ϴ�.
	 	Xid : 40�ڸ��� ���ڷ� ���� , 40�ڸ��� �� ���߾�� �մϴ�.
	 	default���� �ƴ� ���θ��� ������ ������ �����ѱ�ŵ� �˴ϴ�.
	 	default : ����� ��ȣ(10) + ����(8, yyyyMMdd) + �ð�(9, HHmmssSSS)+�������� "9"�� ä��.
 	***************************************************************************************************/
 	String xid = MallUtil.getXid(BIZ_NO.trim());

	/** 	
	// xid, order_cardname ��Ű�� ����...
	CookieUtil cookieUtil = new CookieUtil(request);
	response.addCookie(cookieUtil.createCookie("com.smpi.xid", xid));
	response.addCookie(cookieUtil.createCookie("com.smpi.order_cardname", order_cardname));
    **/
    // ����ó���� ���� 2016.02.10
    session = request.getSession(true);
    session.setAttribute("com.smpi.xid", xid);
    session.setAttribute("com.smpi.order_cardname", order_cardname);

	// ī���� ���� ���� ��û ����Ÿ�� ���θ�/PG ���� ����...
	map.put("businessType", BIZ_TYPE);
	map.put("businessNo", BIZ_NO);
	map.put("receiveUrl", RECV_URL);

	// ī���� ���� ���� ��û ����Ÿ�� ī���� ���� �ο����� ID ����...
	map.put("mId", mId);

	// ������û�� �ŷ�������ȣ�� xid������ ī��� ���� ��û ����Ÿ�� ����...
	map.put("xid", xid);

	// ������û ��������, �ð��� ī���� ���� ���� ��û ����Ÿ�� ����...
	map.put("Date", MallUtil.getCurrentDate());
	map.put("Time", MallUtil.getCurrentTime());

	// ī���� ���� ������û �޽��� ����...
	String originalMsg = MallUtil.makePareqData(map);
	String[] encData = null;

	try {
		//����Ÿ ��ȣȭ...
		System.out.println("����Ÿ ��ȣȭ : MallCertManager�� encrypt() �޼ҵ� ����.");
		MallCertManager certMgr = new MallCertManager(cardPkPath);
		//certMgr = new MallCertManager(cardPkPath);
		//if(!certMgr.isInit()){
		//    System.out.println("MallCertManager is not set");
		//    certMgr.init(privateKeyPath, signKeyPath, signCertPath, encPasswordPath);    
		//}
		
		System.out.println("originalMsg["+originalMsg+"]");
		encData = certMgr.encrypt(originalMsg);
		System.out.println("����Ÿ ��ȣȭ : MallCertManager�� encrypt() �޼ҵ� ���� ����.");
	}
	catch (Exception e) {
		System.out.println("lotte_smpi_error "+e.getMessage());
		e.printStackTrace();
%>
<script type="text/javascript">
	alert('�޼��� ��ȣȭ �� ������ �߻��Ͽ����ϴ�.\n���θ� ����ڿ� �����Ͻñ� �ٶ��ϴ�.');
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
	String pareq2=encData[1];  //��ȣȭ�� pareq
	String pareq3=encData[2];  //���ڼ��� ������
	String pareq4=encData[3];  //���ڼ���	
%>
<script type="text/javascript">
var certResult = false;		//ī���� ���� ��������� ������ true�� �����...
var childwin = null;        //����â
var cnt = 0;

//����ȭ�鿡�� ������ ī����� ���� POPUPâ�� OPEN�Ѵ�...
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
