<%------------------------------------------------------------------------------
 FILE NAME : KSPayCancelPost.jsp
 AUTHOR : kspay@ksnet.co.kr
 DATE : 2006/09/01
                                                         http://www.kspay.co.kr
                                                         http://www.ksnet.co.kr
                                  Copyright 2003 KSNET, Co. All rights reserved
-------------------------------------------------------------------------------%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="ksnet.kspay.KSPayApprovalCancelBean" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<%
// Default(수정항목이 아님)-------------------------------------------------------
	String	EncType       = "2";					// 0: 암화안함, 1:openssl, 2: seed
	String	Version       = "0603";				    // 전문버전
	String	Type          = "00";					// 구분
	String	Resend        = "0";					// 전송구분 : 0 : 처음,  2: 재전송
	String	RequestDate   = new SimpleDateFormat("yyyyMMddhhmmss").format(new java.util.Date()); // 요청일자 : yyyymmddhhmmss
	String	KeyInType     = "K";					// KeyInType 여부 : S : Swap, K: KeyInType
	String	LineType      = "1";			        // lineType 0 : offline, 1:internet, 2:Mobile
	String	ApprovalCount = "1";				    // 복합승인갯수
	String 	GoodType      = "0";	                // 제품구분 0 : 실물, 1 : 디지털
	String	HeadFiller    = "";				        // 예비
//-------------------------------------------------------------------------------

// Header (입력값 (*) 필수항목)--------------------------------------------------
	String	StoreId		= request.getParameter("storeid");		// *상점아이디
	String	OrderNumber	= "";									// 주문번호
	String	UserName    = "";									// *주문자명
	String	IdNum       = "";									// 주민번호 or 사업자번호
	String	Email       = "";									// *email
	String 	GoodName    = "";									// *제품명
	String	PhoneNo     = "";									// *휴대폰번호                                              
// Header end -------------------------------------------------------------------

// Data Default(수정항목이 아님)-------------------------------------------------
	String ApprovalType	  = request.getParameter("authty");		// 승인구분
	String TrNo   		  = request.getParameter("trno");		// 거래번호
	String Canc_amt		  = request.getParameter("canc_amt");	// 취소금액
	String Canc_seq		  = request.getParameter("canc_seq");	// 취소일련번호
	String Canc_type	  = request.getParameter("canc_type");	// 취소유형 0 :거래번호취소 1: 주문번호취소 3:부분취소
// Data Default end -------------------------------------------------------------

// Server로 부터 응답이 없을시 자체응답
	String rApprovalType	   = "1011"; 
	String rTransactionNo      = "";			// 거래번호
	String rStatus             = "X";			// 상태 O : 승인, X : 거절
	String rTradeDate          = ""; 			// 거래일자
	String rTradeTime          = ""; 			// 거래시간
	String rIssCode            = "00"; 			// 발급사코드
	String rAquCode			   = "00"; 			// 매입사코드
	String rAuthNo             = "9999"; 		// 승인번호 or 거절시 오류코드
	String rMessage1           = "취소거절"; 	// 메시지1
	String rMessage2           = "C잠시후재시도";// 메시지2
	String rCardNo             = ""; 			// 카드번호
	String rExpDate            = ""; 			// 유효기간
	String rInstallment        = ""; 			// 할부
	String rAmount             = ""; 			// 금액
	String rMerchantNo         = ""; 			// 가맹점번호
	String rAuthSendType       = "N"; 			// 전송구분
	String rApprovalSendType   = "N"; 			// 전송구분(0 : 거절, 1 : 승인, 2: 원카드)
	String rPoint1             = "000000000000";// Point1
	String rPoint2             = "000000000000";// Point2
	String rPoint3             = "000000000000";// Point3
	String rPoint4             = "000000000000";// Point4
	String rVanTransactionNo   = "";
	String rFiller             = ""; 			// 예비
	String rAuthType	 	   = ""; 			// ISP : ISP거래, MP1, MP2 : MPI거래, SPACE : 일반거래
	String rMPIPositionType	   = ""; 			// K : KSNET, R : Remote, C : 제3기관, SPACE : 일반거래
	String rMPIReUseType	   = ""; 			// Y : 재사용, N : 재사용아님
	String rEncData			   = ""; 			// MPI, ISP 데이터

	try 
	{
		KSPayApprovalCancelBean ipg = new KSPayApprovalCancelBean("localhost", 29991); 

		ipg.HeadMessage(EncType, Version, Type, Resend, RequestDate, StoreId, OrderNumber, UserName, IdNum, Email, 
						GoodType, GoodName, KeyInType, LineType, PhoneNo, ApprovalCount, HeadFiller);

		if (Canc_type.equals("3"))
			ipg.CancelDataMessage(ApprovalType, Canc_type, TrNo, "", "", ipg.format(Canc_amt,9,'9')+ipg.format(Canc_seq,2,'9'),"","");
		else 
			ipg.CancelDataMessage(ApprovalType, "0", TrNo, "", "", "","","");

		if(ipg.SendSocket("1")) {
			rApprovalType		= ipg.ApprovalType[0];	    
			rTransactionNo		= ipg.TransactionNo[0];	  		// 거래번호
			rStatus				= ipg.Status[0];		  		// 상태 O : 승인, X : 거절
			rTradeDate			= ipg.TradeDate[0];		  		// 거래일자
			rTradeTime			= ipg.TradeTime[0];		  		// 거래시간
			rIssCode			= ipg.IssCode[0];		  		// 발급사코드
			rAquCode			= ipg.AquCode[0];		  		// 매입사코드
			rAuthNo				= ipg.AuthNo[0];		  		// 승인번호 or 거절시 오류코드
			rMessage1			= ipg.Message1[0];		  		// 메시지1
			rMessage2			= ipg.Message2[0];		  		// 메시지2
			rCardNo				= ipg.CardNo[0];		  		// 카드번호
			rExpDate			= ipg.ExpDate[0];		  		// 유효기간
			rInstallment		= ipg.Installment[0];	  		// 할부
			rAmount				= ipg.Amount[0];		  		// 금액
			rMerchantNo			= ipg.MerchantNo[0];	  		// 가맹점번호
			rAuthSendType		= ipg.AuthSendType[0];	  		// 전송구분= new String(this.read(2));
			rApprovalSendType	= ipg.ApprovalSendType[0];		// 전송구분(0 : 거절, 1 : 승인, 2: 원카드)
			rPoint1				= ipg.Point1[0];		  		// Point1
			rPoint2				= ipg.Point2[0];		  		// Point2
			rPoint3				= ipg.Point3[0];		  		// Point3
			rPoint4				= ipg.Point4[0];		  		// Point4
			rVanTransactionNo   = ipg.VanTransactionNo[0];      // Van거래번호
			rFiller				= ipg.Filler[0];		  		// 예비
			rAuthType			= ipg.AuthType[0];		  		// ISP : ISP거래, MP1, MP2 : MPI거래, SPACE : 일반거래
			rMPIPositionType	= ipg.MPIPositionType[0]; 		// K : KSNET, R : Remote, C : 제3기관, SPACE : 일반거래
			rMPIReUseType		= ipg.MPIReUseType[0];			// Y : 재사용, N : 재사용아님
			rEncData			= ipg.EncData[0];		  		// MPI, ISP 데이터
		}
	}
	catch(Exception e) {
		rMessage2			= "P잠시후재시도("+e.toString()+")";	// 메시지2
	} // end of catch
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html charset=euc-kr">
<title>KSPay</title>
<style type="text/css">
	TABLE{font-size:9pt; line-height:160%;}
	A {color:blueline-height:160% background-color:#E0EFFE}
	INPUT{font-size:9pt}
	SELECT{font-size:9pt}
	.emp{background-color:#FDEAFE}
	.white{background-color:#FFFFFF color:black border:1x solid white font-size: 9pt}
</style>
</head>

<body>
<table border=0 width=0>
	<tr>
		<td align=center>
			<table width=350 cellspacing=0 cellpadding=0 border=0 bgcolor=#4F9AFF>
				<tr>
					<td width=50%>
						<table width=100% cellspacing=1 cellpadding=2 border=0>
							<tr bgcolor=#4F9AFF height=25>
								<td align=left><font color="#FFFFFF">
								KSPay 신용카드 취소
								</font></td>
							</tr>
							<tr bgcolor=#FFFFFF>
								<td valign=top>
									<table width=100% cellspacing=0 cellpadding=2 border=0>
										<tr>
											<td align=left>
												<table>
													<tr><td>거래번호					    </td><td><%=rTransactionNo	%></td></tr>
													<tr><td>오류구분(O/X)					</td><td><%=rStatus			%></td></tr>
													<tr><td>거래 일자						</td><td><%=rTradeDate		%></td></tr>
													<tr><td>거래 시간						</td><td><%=rTradeTime		%></td></tr>
													<tr><td>응답 메세지1                    </td><td><%=rMessage1		%></td></tr>
													<tr><td>응답 메세지2                    </td><td><%=rMessage2		%></td></tr>
												</table>
											<td>
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
</body>
</html>