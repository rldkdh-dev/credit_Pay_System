<%@ page import="java.util.*,java.net.*" contentType="text/html; charset=euc-kr"
%><%
	String proceed         = request.getParameter("proceed");              //인증성공여부
	String cardNumber      = request.getParameter("cardnumber");           //카드번호
	String cardExpiredDate = request.getParameter("expdt");                //유효기간
	String cardCode        = request.getParameter("cardcode");             //카드사 구분자
	String paymentId       = request.getParameter("paymentid");            //네이버 페이 결제번호
	String installment     = request.getParameter("installment");          //할부개월수
	String cavv            = request.getParameter("cavv");                 //카드사 인증 데이터
	String xid             = request.getParameter("xid");                  //카드사 인증 데이터
	String eci             = request.getParameter("eci");                  //카드사 인증 데이터
	String trid            = request.getParameter("trid");                 //카드사 인증 데이터
	

	
	
%>
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="No-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>NPAY 인증결과</title>
</head>
<body>
<script type="text/javascript" charset="euc-kr">
function return_proceed()
{
	if("<%=proceed%>" == "true")
	{
		if( opener == null )
		{
		parent.recvResult("<%=proceed%>","<%=cardNumber%>","<%=cardExpiredDate%>","<%=cardCode%>", "<%=paymentId%>", "<%=installment%>","<%=cavv%>","<%=xid%>","<%=eci%>","<%=trid%>");
			location.href="./blank.html";
		}
		else
		{
			opener.recvResult("<%=proceed%>","<%=cardNumber%>","<%=cardExpiredDate%>","<%=cardCode%>", "<%=paymentId%>", "<%=installment%>","<%=cavv%>","<%=xid%>","<%=eci%>","<%=trid%>");
			self.close();
		}
	}else{
		if( opener == null ){		
			if( /Android/i.test(navigator.userAgent)) {	// 안드로이드
				parent.goBack();
				self.close();
		   	} else{
				self.close();
		   	}
			
		}
		
		else{			
			if( /Android/i.test(navigator.userAgent)) {	// 안드로이드
				opener.goBack();
				self.close();
		   	} else{
				self.close();
		   	}
		}
	}
}
	
return_proceed();
</script>
</body>
</html>