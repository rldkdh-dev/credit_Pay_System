<%@ page contentType="text/html; charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%
	String proceed		                   = request.getParameter("proceed");
	String SSGPAY_CARD_TRADE_AMT         = request.getParameter("SSGPAY_CARD_TRADE_AMT");
	String SSGPAY_TERMID                 = request.getParameter("SSGPAY_TERMID");     
	String SSGPAY_MGIFT_CARD_YN          = request.getParameter("SSGPAY_MGIFT_CARD_YN");
	String SSGPAY_CARD_DATE_NO           = request.getParameter("SSGPAY_CARD_DATE_NO");
	String SSGPAY_MGIFT_CONFIRM_NO       = request.getParameter("SSGPAY_MGIFT_CONFIRM_NO");
	String SSGPAY_CARD_CERT_FLAG         = request.getParameter("SSGPAY_CARD_CERT_FLAG");
	String SSGPAY_CARD_ETC_DATA          = request.getParameter("SSGPAY_CARD_ETC_DATA");
	String SSGPAY_DELEGATE_CERTIFY_CODE  = request.getParameter("SSGPAY_DELEGATE_CERTIFY_CODE");
	String SSGPAY_MGIFT_CARD_NO          = request.getParameter("SSGPAY_MGIFT_CARD_NO");
	String SSGPAY_INSTALL_MONTH          = request.getParameter("SSGPAY_INSTALL_MONTH");
	String SSGPAY_OID                    = request.getParameter("SSGPAY_OID");
	String SSGPAY_MGIFT_TRADE_AMT        = request.getParameter("SSGPAY_MGIFT_TRADE_AMT");
	String SSGPAY_CARD_CERTFY_NO         = request.getParameter("SSGPAY_CARD_CERTFY_NO");
	String SSGPAY_CARD_TRACK2_DATA       = request.getParameter("SSGPAY_CARD_TRACK2_DATA");
	String SSGPAY_CARD_NO                = request.getParameter("SSGPAY_CARD_NO"); 
	String SSGPAY_CARD_YN                = request.getParameter("SSGPAY_CARD_YN");	
	String SSGPAY_PAYMETHOD              = request.getParameter("SSGPAY_PAYMETHOD");
	String SSGPAY_PLATFORM_MID           = request.getParameter("SSGPAY_PLATFORM_MID");
%>
<html>
<body>
<script language="javascript">

	function return_proceed(){         
 		parent.paramSet("<%=SSGPAY_CARD_TRADE_AMT%>","<%=SSGPAY_TERMID%>","<%=SSGPAY_MGIFT_CARD_YN%>","<%=SSGPAY_CARD_DATE_NO%>","<%=SSGPAY_MGIFT_CONFIRM_NO%>","<%=SSGPAY_CARD_CERT_FLAG%>","<%=SSGPAY_CARD_ETC_DATA%>","<%=SSGPAY_DELEGATE_CERTIFY_CODE%>","<%=SSGPAY_MGIFT_CARD_NO%>","<%=SSGPAY_INSTALL_MONTH%>","<%=SSGPAY_OID%>","<%=SSGPAY_MGIFT_TRADE_AMT%>","<%=SSGPAY_CARD_CERTFY_NO%>","<%=SSGPAY_CARD_TRACK2_DATA%>","<%=SSGPAY_CARD_NO%>","<%=SSGPAY_CARD_YN%>","<%=SSGPAY_PAYMETHOD%>","<%=SSGPAY_PLATFORM_MID%>");
 		parent.proceed("<%=proceed%>");
		setTimeout("self.close()",2000);
	}
	return_proceed();


</script>
</body>
</html>