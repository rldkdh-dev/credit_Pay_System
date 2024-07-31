<%@ page contentType="text/html; charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%
    String _PTID		                  = request.getParameter("PTID");
	String proceed                    = request.getParameter("proceed");                
	String code                       = request.getParameter("code");                          
	String sellerOrderReferenceKey    = request.getParameter("sellerOrderReferenceKey");         
	String reserveOrderNo             = request.getParameter("reserveOrderNo");                 
	String paymentCertifyToken        = request.getParameter("paymentCertifyToken");            
	String totalPaymentAmt            = request.getParameter("totalPaymentAmt");                
	String cardInstallmentMonthNumber = request.getParameter("cardInstallmentMonthNumber");       
	String mccode                     = request.getParameter("mccode");                         
	String pccode                     = request.getParameter("pccode");                          
	String pcnumb                     = request.getParameter("pcnumb");     
	String sellerKey                  = request.getParameter("sellerKey"); 

%>
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="No-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>
<body >
<script type="text/javascript">
   window.onload = function(e)
{
		
		var FormName = "";
		
		if( opener == null )
		{
			FormName = parent.document.PaycoAuthForm;
		}else
		{
			FormName = opener.document.PaycoAuthForm;
		}	
		
		FormName.sellerOrderReferenceKey.value  = '<%=sellerOrderReferenceKey%>';     
		FormName.reserveOrderNo.value  = '<%=reserveOrderNo%>';     
		FormName.mccode.value = '<%=mccode%>';     
		FormName.pccode.value = '<%=pccode%>';     
		FormName.pcnumb.value = '<%=pcnumb%>';     
		FormName.paymentCertifyToken.value  = '<%=paymentCertifyToken%>';     
		FormName.CardQuota.value = '<%=cardInstallmentMonthNumber%>';     
		FormName.sellerKey.value = '<%=sellerKey%>';    
		
		if( opener == null )
		{
			parent.recvResult_payco("<%=proceed%>");	
		}else
		{
			opener.recvResult_payco("<%=proceed%>");	
			
		}	
	}
	
	
</script>
</body>
</html>
