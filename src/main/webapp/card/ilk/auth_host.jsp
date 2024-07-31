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
		auth_msg = "인증실패. 카드사가 인증결과를 넘겨주지 않았습니다.";
		errCode = "996";
		paresYN = "N";
   }else if( !status.equals("Y") && !status.equals("A") && errCode.equals("000") ) {
		auth_msg = "인증실패. 인증결과를 알 수 없습니다.";
		errCode = "995";
   }else if( !errCode.equals("000") ) {
		auth_msg = errCode + ": " + errs.get(errCode);
   }
	if( MD == null ) MD = xid;
	
%>

<html>
<head>
	<title>비자 안심클릭 서비스 진행중</title>
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
			//우리은행 ISP호출
			parent.goISP_WOORI();
	    }else{
			parent.paramSet("<%=xid%>","<%=eci%>","<%=cavv%>", "<%=realPan%>", "<%=ss_useyn%>", "<%=savekind%>","<%=ss_useyn_ke%>",proceed);
			//parent.proceed(proceed);
	    }
	    }
</script>
</html>
