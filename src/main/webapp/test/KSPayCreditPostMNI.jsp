<%------------------------------------------------------------------------------
파일명     : KSPayCreditFormMNI.jsp
기능       : KSPAY 와 소켓 통신 및 결제 확인 
-------------------------------------------------------------------------------%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="ksnet.kspay.*" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%
	//승인타입 : A-인증없는승인, N-인증승인, M-MPI인증승인, I-ISP인증승인 
	String certitype         = request.getParameter("certitype") ;	
	
//Header부 Data -------------------------------------------------------------------
	String EncType           = "2" ;                                    //0: 암화안함, 1:ssl, 2: seed
	String Version           = "0603" ;                                 //전문버전
	String Type              = "00" ;                                   //구분
	String Resend            = "0" ;                                    //전송구분 : 0 : 처음,  2: 재전송
	String RequestDate       = new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date()); // 요청일자 
	String KeyInType         = "K" ;                                    //KeyInType 여부 : S : Swap, K: KeyInType
	String LineType          = "1" ;                                    //lineType 0 : offline, 1:internet, 2:Mobile
	String ApprovalCount     = "1" ;                                    //복합승인갯수
	String GoodType          = "0" ;                                    //제품구분 0 : 실물, 1 : 디지털
	String HeadFiller        = "" ;                                     //예비
	
	String StoreId           = request.getParameter("storeid") ;        // 상점아이디
	String OrderNumber       = request.getParameter("ordernumber") ;    // 주문번호
	String UserName          = request.getParameter("ordername") ;      // 주문자명
	String IdNum             = "" ;                                     // 주민번호 or 사업자번호 (공백처리)
	String Email             = request.getParameter("email") ;          // email
	String GoodName          = request.getParameter("goodname") ;       // 제품명
	String PhoneNo           = request.getParameter("phoneno") ;        // 휴대폰번호
//Header end -------------------------------------------------------------------
	
//Data Default -------------------------------------------------------------------
	String ApprovalType      = request.getParameter("authty") ;         //승인구분
	String InterestType      = request.getParameter("interest") ;       //일반/무이자구분 1:일반 2:무이자
	// 카드번호=유효기간  or 거래번호
	String TrackII           = request.getParameter("cardno")+"="+request.getParameter("expdt");
	String Installment       = request.getParameter("installment") ;    //할부  00일시불
	String Amount            = request.getParameter("amount") ;         //금액
	String Passwd            = request.getParameter("passwd") ;         //비밀번호 앞2자리
	String LastIdNum         = request.getParameter("lastidnum") ;      //주민번호  앞6자리, 사업자번호10
	String CurrencyType      = request.getParameter("currencytype") ;   //통화구분 0:원화 1: 미화
	
	String BatchUseType      = "0" ;                      //거래번호배치사용구분  0:미사용 1:사용
	String CardSendType      = "0" ;                      //카드정보전송유무
	                                                      //0:미전송 1:카드번호,유효기간,할부,금액,가맹점번호 2:카드번호앞14자리 + "XXXX",유효기간,할부,금액,가맹점번호
	String VisaAuthYn        = "7" ;                      //비자인증유무 0:사용안함,7:SSL,9:비자인증
	String Domain            = "" ;                       //도메인 자체가맹점(PG업체용)
	String IpAddr            = request.getRemoteAddr();   //IP ADDRESS 자체가맹점(PG업체용)
	String BusinessNumber    = "" ;                       //사업자 번호 자체가맹점(PG업체용)
	String Filler            = "" ;                       //예비
	String AuthType          = "" ;                       //ISP : ISP거래, MP1, MP2 : MPI거래, SPACE : 일반거래
	String MPIPositionType   = "" ;                       //K : KSNET, R : Remote, C : 제3기관, SPACE : 일반거래
	String MPIReUseType      = "" ;                       //Y : 재사용, N : 재사용아님
	String EncData           = "" ;                       //MPI, ISP 데이터
	
	String cavv              = request.getParameter("cavv") ;   //MPI용
	String xid               = request.getParameter("xid") ;    //MPI용
	String eci               = request.getParameter("eci") ;    //MPI용
	
	String KVP_PGID          = "" ;
	String KVP_CARDCODE      = "" ;
	String KVP_SESSIONKEY    = "" ;
	String KVP_ENCDATA       = "" ;
	
	// KBAPP
	String kb_app_otp = request.getParameter("kb_app_otp"	);
	/*ISP일경우*/
	if(certitype.equals("I"))
	{
		TrackII              = "" ;
		InterestType         = request.getParameter("KVP_NOINT");       //무이자구분
		Installment          = request.getParameter("KVP_QUOTA");       //할부:00일시불
		KVP_PGID             = request.getParameter("KVP_PGID");
		KVP_CARDCODE         = request.getParameter("KVP_CARDCODE");
		KVP_SESSIONKEY       = request.getParameter("KVP_SESSIONKEY");
		KVP_ENCDATA          = request.getParameter("KVP_ENCDATA");
	}
//Data Default end -------------------------------------------------------------
	
//Server로 부터 응답이 없을시 자체응답
	String rApprovalType       = "1001" ;
	String rTransactionNo      = "" ;                 //거래번호
	String rStatus             = "X" ;                //상태 O : 승인, X : 거절
	String rTradeDate          = "" ;                 //거래일자
	String rTradeTime          = "" ;                 //거래시간
	String rIssCode            = "00" ;               //발급사코드
	String rAquCode            = "00" ;               //매입사코드
	String rAuthNo             = "9999" ;             //승인번호 or 거절시 오류코드
	String rMessage1           = "승인거절" ;         //메시지1
	String rMessage2           = "C잠시후재시도" ;    //메시지2
	String rCardNo             = "" ;                 //카드번호
	String rExpDate            = "" ;                 //유효기간
	String rInstallment        = "" ;                 //할부
	String rAmount             = "" ;                 //금액
	String rMerchantNo         = "" ;                 //가맹점번호
	String rAuthSendType       = "N" ;                //전송구분
	String rApprovalSendType   = "N" ;                //전송구분(0 : 거절, 1 : 승인, 2: 원카드)
	String rPoint1             = "000000000000" ;     //Point1
	String rPoint2             = "000000000000" ;     //Point2
	String rPoint3             = "000000000000" ;     //Point3
	String rPoint4             = "000000000000" ;     //Point4
	String rVanTransactionNo   = "" ;
	String rFiller             = "" ;                 //예비
	String rAuthType           = "" ;                 //ISP : ISP거래, MP1, MP2 : MPI거래, SPACE : 일반거래
	String rMPIPositionType    = "" ;                 //K : KSNET, R : Remote, C : 제3기관, SPACE : 일반거래
	String rMPIReUseType       = "" ;                 //Y : 재사용, N : 재사용아님
	String rEncData            = "" ;                 //MPI, ISP 데이터
//--------------------------------------------------------------------------------
	
	try 
	{	
		KSPayApprovalCancelBean ipg = new KSPayApprovalCancelBean("localhost", 29991); 
		
		ipg.HeadMessage(EncType, Version, Type, Resend, RequestDate, StoreId, OrderNumber, UserName, IdNum, Email, 
						GoodType, GoodName, KeyInType, LineType, PhoneNo, ApprovalCount, HeadFiller);
		
		//일반승인인경우
		if(certitype.equals("A")||certitype.equals("N"))
		{
			AuthType        = "" ;
			MPIPositionType = "" ;
			MPIReUseType    = "" ;
			EncData         = "" ;
		}
		//MPI인증승인인경우
		else if(certitype.equals("M"))
		{
			AuthType        = "M" ;
			MPIPositionType = "K" ;
			MPIReUseType    = "N" ;
			cavv            = ipg.format(cavv, 40, 'X');
			xid             = ipg.format(xid,  40, 'X');
			eci             = ipg.format(eci,   2, 'X');
			EncData         = ipg.format(""+(cavv+xid+eci).getBytes().length, 5, '9') + cavv+xid+eci;
		}
		//ISP인증승인인경우
		else if(certitype.equals("I"))
		{
			if(!kb_app_otp.equals("")){
				ApprovalType			= "1000";
				TrackII = kb_app_otp+"=8911";
				Filler = "            KBA" ;
			}else{
				AuthType        = "I";
				MPIPositionType = "K";
				MPIReUseType    = "N";
			
				KVP_SESSIONKEY  = URLEncoder.encode(KVP_SESSIONKEY);
				KVP_ENCDATA     = URLEncoder.encode(KVP_ENCDATA);
				KVP_SESSIONKEY  = ipg.format(""+KVP_SESSIONKEY.getBytes().length,  4, '9') + KVP_SESSIONKEY;
				KVP_ENCDATA     = ipg.format(""+KVP_ENCDATA.getBytes().length,     4, '9') + KVP_ENCDATA;
				KVP_CARDCODE    = ipg.format(""+KVP_CARDCODE.getBytes().length,2, '9') + KVP_CARDCODE;
				KVP_CARDCODE    = ipg.format(""+KVP_CARDCODE, 22, 'X');
				EncData         = ipg.format(""+(KVP_PGID+KVP_SESSIONKEY+KVP_ENCDATA+KVP_CARDCODE).getBytes().length, 5, '9') + KVP_PGID+KVP_SESSIONKEY+KVP_ENCDATA+KVP_CARDCODE;
			}
			if(InterestType.equals("0")) InterestType = "1" ;
			else                         InterestType = "2" ;
		}
		
		if(CurrencyType.equals("WON")||CurrencyType.equals("410")||CurrencyType.equals(""))	CurrencyType = "0" ;
		else if(CurrencyType.equals("USD")||CurrencyType.equals("840"))	CurrencyType = "1" ;
		else CurrencyType = "0" ;
		
		ipg.CreditDataMessage
		(ApprovalType, InterestType, TrackII, Installment, Amount, Passwd, LastIdNum, CurrencyType, 
		 BatchUseType, CardSendType, VisaAuthYn, Domain, IpAddr, BusinessNumber, Filler, AuthType, 
		 MPIPositionType, MPIReUseType, EncData);
		
		if(ipg.SendSocket("1")) 
		{
			rApprovalType       = ipg.ApprovalType[0];
			rTransactionNo      = ipg.TransactionNo[0];        // 거래번호
			rStatus             = ipg.Status[0];               // 상태 O : 승인, X : 거절
			rTradeDate          = ipg.TradeDate[0];            // 거래일자
			rTradeTime          = ipg.TradeTime[0];            // 거래시간
			rIssCode            = ipg.IssCode[0];              // 발급사코드
			rAquCode            = ipg.AquCode[0];              // 매입사코드
			rAuthNo             = ipg.AuthNo[0];               // 승인번호 or 거절시 오류코드
			rMessage1           = ipg.Message1[0];             // 메시지1
			rMessage2           = ipg.Message2[0];             // 메시지2
			rCardNo             = ipg.CardNo[0];               // 카드번호
			rExpDate            = ipg.ExpDate[0];              // 유효기간
			rInstallment        = ipg.Installment[0];          // 할부
			rAmount             = ipg.Amount[0];               // 금액
			rMerchantNo         = ipg.MerchantNo[0];           // 가맹점번호
			rAuthSendType       = ipg.AuthSendType[0];         // 전송구분= new String(this.read(2));
			rApprovalSendType   = ipg.ApprovalSendType[0];     // 전송구분(0 : 거절, 1 : 승인, 2: 원카드)
			rPoint1             = ipg.Point1[0];               // Point1
			rPoint2             = ipg.Point2[0];               // Point2
			rPoint3             = ipg.Point3[0];               // Point3
			rPoint4             = ipg.Point4[0];               // Point4
			rVanTransactionNo   = ipg.VanTransactionNo[0];     // Van거래번호
			rFiller             = ipg.Filler[0];               // 예비
			rAuthType           = ipg.AuthType[0];             // ISP : ISP거래, MP1, MP2 : MPI거래, SPACE : 일반거래
			rMPIPositionType    = ipg.MPIPositionType[0];      // K : KSNET, R : Remote, C : 제3기관, SPACE : 일반거래
			rMPIReUseType       = ipg.MPIReUseType[0];         // Y : 재사용, N : 재사용아님
			rEncData            = ipg.EncData[0];              // MPI, ISP 데이터
		}
	}
	catch(Exception e) 
	{
		rMessage2 = "C잠시후재시도("+e.toString()+")";       // 메시지2
	}
%>

<html>
<head>
<title>KSPay</title>
<meta http-equiv="Content-Type" content="text/html charset=euc-kr">
<style type="text/css">
	TABLE{font-size:9pt; line-height:160%;}
	A {color:blueline-height:160% background-color:#E0EFFE}
	INPUT{font-size:9pt}
	SELECT{font-size:9pt}
	.emp{background-color:#FDEAFE}
	.white{background-color:#FFFFFF color:black border:1x solid white font-size: 9pt}
</style>
<script language="javascript">
<!--

document.onkeypress = processKey;
document.onkeydown  = processKey;

function processKey() {
	if(( event.ctrlKey == true && ( event.keyCode == 78 || event.keyCode == 82 ) ) ||
		( event.keyCode >= 112 && event.keyCode <= 123 ))
	{
		event.keyCode = 0;
		event.cancelBubble = true;
		event.returnValue = false;
	}
	if(event.keyCode == 8 && typeof(event.srcElement.value) == "undefined") {
		event.keyCode = 0;
		event.cancelBubble = true;
		event.returnValue = false;
	}
}

-->
</script>
</head>

<body onload="" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table border=0 width=0>
<tr>
<td align=center>
<table width=320 cellspacing=0 cellpadding=0 border=0 bgcolor=#4F9AFF>
<tr>
<td>
<table width=100% cellspacing=1 cellpadding=2 border=0>
<tr bgcolor=#4F9AFF height=25>
<td align=left><font color="#FFFFFF">
KSPay 신용카드 결과
<%
	if(certitype.equals("A"))      out.println("(인증없는승인)") ;
	else if(certitype.equals("N")) out.println("(인증승인)") ;
	else if(certitype.equals("M")) out.println("(M-MPI인증승인)") ;
	else if(certitype.equals("I")) out.println("(I-ISP인증승인)") ;
%>
</font></td>
</tr>
<tr bgcolor=#FFFFFF>
<td valign=top>
<table width=100% cellspacing=0 cellpadding=2 border=0>
<tr>
<td align=left>
<table>
<tr>
	<td>거래종류 :</td>
	<td><%=rApprovalType%></td>
</tr>
<tr>
	<td>거래번호 :</td>
	<td><%=rTransactionNo%></td>
</tr>
<tr>
	<td>거래성공여부 :</td>
	<td><%=rStatus%></td>
</tr>
<tr>
	<td>거래시간 :</td>
	<td><%=rTradeDate%> / <%=rTradeTime%></td>
</tr>
<tr>
	<td>발급사코드 :</td>
	<td><%=rIssCode%></td>
</tr>
<tr>
	<td>매입사코드 :</td>
	<td><%=rAquCode%></td>
</tr>
<tr>
	<td>승인번호 :</td>
	<td><%=rAuthNo%></td>
</tr>
<tr>
	<td>메시지1 :</td>
	<td><%=rMessage1%></td>
</tr>
<tr>
	<td>메시지2 :</td>
	<td><%=rMessage2%></td>
</tr>

</table>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</table>
</body>
</html>
