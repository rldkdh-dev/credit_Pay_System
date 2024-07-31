<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*"%>
<%@ page import="com.ilk.ansim.vbv_mpi.*"%>
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
		notYet = false;
	}
}
%>
<%
	/*
	 * Declare error codes.
	 */
	errCodeDef();

	/*
	 * Do not cache this page.
	 */
	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","-1");
	response.setHeader("pragma","no-cache");
	/*
	 *	Get the form elements
	 */
	String MD			= request.getParameter("MD");
	String PaRes		= request.getParameter("PaRes");
	String realPan		= request.getParameter("realPan");
	
	String AUTH_TYPE= request.getParameter("AUTH_TYPE");
	String ss_useyn = request.getParameter("ss_useyn");
	String savekind = request.getParameter("savekind");

	String isp_yn = request.getParameter("isp_yn");
	String ss_useyn_ke = request.getParameter("ss_useyn_ke");

	String status		= "";
	String verifyResult	= "";
	String xid			= "";
	String eci			= "";
	String cavv			= "";
	String auth_msg		= "";
	String proceed		= "true";
	String errCode		= "000";
	String paresYN		= "Y";
	String iReqCode		= "";
	String iReqDetail	= "";

	/*
	 *	Create mpi component mpiVbV(ip,port) or mpiVbV(port)
	 */
	 mpiVbV mpi = new mpiVbV(5103);

	String success  = mpi.validatePayerAuth(PaRes);

	status       	= mpi.getStatus();
	verifyResult 	= mpi.getVerifyResult();
	xid          	= mpi.getXid();
	eci          	= mpi.getEci();
	cavv         	= mpi.getCavv();
	errCode      	= mpi.getErrorCode();
	iReqCode     	= mpi.getIReqCode();
	iReqDetail   	= mpi.getIReqDetail();

	if(xid == null)        xid = "";
	if(eci == null)        eci = "";
	if(cavv == null)       cavv = "";
	if(realPan == null)    realPan = "";
	if(errCode == null)    errCode = "";
	if(iReqCode == null)   iReqCode = "";
	if(iReqDetail == null) iReqDetail = "";

	if (!success.equals("Y")) status = "X";

	if( PaRes == null || PaRes.equals("") ) {
		auth_msg = "��������. ī��簡 ��������� �Ѱ����� �ʾҽ��ϴ�.";
		errCode = "996";
		paresYN = "N";
   }else if( !status.equals("Y") && !status.equals("A") && errCode.equals("000") ) {
		auth_msg = "��������. ��������� �� �� �����ϴ�.";
		errCode = "995";
   }else if( !errCode.equals("000") ) {
		auth_msg = errCode + ": " + errs.get(errCode);
   }
	if( MD == null ) MD = xid;
	
%>

<html>
<head>
	<title>���� �Ƚ�Ŭ�� ���� ������</title>
</head>
<body onload="unload_me();">
</body>
<script type="text/javascript">
	function unload_me() {
		
		var proceed = false;
		if( "<%=auth_msg%>" != "" ) {
			alert("<%=auth_msg%>");
		} else {
			proceed = true;
		}
		if("<%=isp_yn%>"=="Y"){
			//�츮���� ISPȣ��
			parent.goISP_WOORI();
	    }else{
			parent.paramSet("<%=xid%>","<%=eci%>","<%=cavv%>", "<%=realPan%>", "<%=ss_useyn%>", "<%=savekind%>","<%=ss_useyn_ke%>",proceed);
			//parent.proceed(proceed);
	    }
	    }
</script>
</html>
