<%@ page import="java.util.*"
%><%@ page import="com.ilk.ansim.vbv_mpi.*"
%><%
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

	String ss_useyn		= request.getParameter("ss_useyn");
	String savekind		= request.getParameter("savekind");
	String ss_useyn_ke	= request.getParameter("ss_useyn_ke");

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
	String success = mpi.validatePayerAuth(PaRes);

	status = mpi.getStatus();
	verifyResult = mpi.getVerifyResult();
	xid          = mpi.getXid();
	eci          = mpi.getEci();
	cavv         = mpi.getCavv();
	errCode      = mpi.getErrorCode();
	iReqCode     = mpi.getIReqCode();
	iReqDetail   = mpi.getIReqDetail();

	if(xid == null)        xid = "";
	if(eci == null)        eci = "";
	if(cavv == null)       cavv = "";
	if(errCode == null)    errCode = "";
	if(iReqCode == null)   iReqCode = "";
	if(iReqDetail == null) iReqDetail = "";

	if (!success.equals("Y")) status = "X";

	if( PaRes == null || PaRes.equals("") ) {
		errCode = "996";
		paresYN = "N";
	} else if( !status.equals("Y") && !status.equals("A") && errCode.equals("000") ) {
		errCode = "995";
	}

	if( MD == null ) MD = xid;

	StringBuffer sb = new StringBuffer();
	sb.append("`success|").append(success);
	sb.append("`status|").append(status);
	sb.append("`verifyresult|").append(verifyResult);
	sb.append("`xid|").append(xid);
	sb.append("`eci|").append(eci);
	sb.append("`cavv|").append(cavv);
	sb.append("`ss_useyn|").append(ss_useyn);
	sb.append("`savekind|").append(savekind);
	sb.append("`ss_useyn_ke|").append(ss_useyn_ke);
	sb.append("`errcode|").append(errCode).append("`");
	out.print(sb.toString());
%>