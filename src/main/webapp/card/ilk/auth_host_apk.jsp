<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*"%>
<%@ page import="com.ilk.ansim.vbv_mpi.*"%>
<%
		System.out.println("-------- auth_host_apk.jsp start --------");

        response.setHeader("cache-control","no-cache");
        response.setHeader("expires","-1");
        response.setHeader("pragma","no-cache");

        /*
         *      Get the form elements
         */
        request.setCharacterEncoding("utf-8");
        String MD              	= request.getParameter("MD");
        String PaRes            = request.getParameter("PaRes");        
        String realPan          = request.getParameter("realPan");
        String ss_useyn_ke 		= request.getParameter("ss_useyn_ke");
        String savekind 		= request.getParameter("savekind");
        
        System.out.println("MD:" + MD);
        System.out.println("PaRes:" + PaRes);
        System.out.println("realPan:" + realPan);

        String status           = "";
        String verifyResult     = "";
        String xid              = "";
        String eci              = "";
        String cavv             = "";
        String auth_msg         = "";
        String proceed          = "true";
        String errCode          = "000";
        String paresYN          = "Y";
        String iReqCode         = "";
        String iReqDetail       = "";

        /*
         *      Create mpi component mpiVbV(ip,port) or mpiVbV(port)
         */
         mpiVbV mpi = new mpiVbV(5103);
        String success = mpi.validatePayerAuth(PaRes);

        status       = mpi.getStatus();
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
        if(realPan == null)    realPan = "";
        if(errCode == null)    errCode = "";
        if(iReqCode == null)   iReqCode = "";
        if(iReqDetail == null) iReqDetail = "";

        if (!success.equals("Y")) status = "X";

        if( PaRes == null || PaRes.equals("") ) {
                auth_msg = "인증실패. 카드사가 인증결과를 넘겨주지 않았습니다.";
                errCode = "996";
                paresYN = "N";
        } else if( !status.equals("Y") && !status.equals("A") && errCode.equals("000") ) {
                auth_msg = "인증실패. 인증결과를 알 수 없습니다.";
                errCode = "995";
        } else if( !errCode.equals("000") ) {
                auth_msg = errCode + ": " ;
        }

        if( MD == null ) MD = xid;

        if( errCode.equals("000") ){
     	    out.println(   "xid`" + xid + "&eci`" + eci + "&cavv`" + cavv + "&realPan`"  + realPan );
		} else {
			String res_cd = request.getParameter("res_cd");
     	   	String resultMsg = request.getParameter("resultMsg");
     	    out.println( "res_cd="  + res_cd + "&" + "res_msg=" + resultMsg );
     	}

%>
