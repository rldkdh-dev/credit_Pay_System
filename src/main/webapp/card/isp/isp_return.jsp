<%@ page contentType="text/html; charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%
    String SendCode		                  = request.getParameter("SendCode");
	String Message                    = request.getParameter("Message");                
	String TID                       = request.getParameter("TID");                          
	String SessionKey  = request.getParameter("SessionKey");         
	String EncData            = request.getParameter("EncData");                 
	String paymentCertifyToken        = request.getParameter("KvpCardCode");            
	String totalPaymentAmt            = request.getParameter("KVP_PAYSET_FLAG");                
	String cardInstallmentMonthNumber = request.getParameter("KVP_REMAIN_POINT");       
	String mccode                     = request.getParameter("KVP_USING_POINT");                         
	String pccode                     = request.getParameter("VP_PREDIS_RET_CODE");                          
	String pcnumb                     = request.getParameter("VP_PREDIS_RET_MEMGRADE");     
	String sellerKey                  = request.getParameter("VP_PREDIS_DISAMOUNT_TOT"); 
	String VP_PREDIS_MEMCODE                    = request.getParameter("VP_PREDIS_MEMCODE");                         
	String VP_PREDIS_CAMCODE                     = request.getParameter("VP_PREDIS_CAMCODE");                          
	String VP_PREDIS_RET_AMOUNT                     = request.getParameter("VP_PREDIS_RET_AMOUNT");     
	String VP_PREDIS_DISAMOUNT_M001                  = request.getParameter("VP_PREDIS_DISAMOUNT_M001"); 
	String VP_PREDIS_DISAMOUNT_M901                  = request.getParameter("VP_PREDIS_DISAMOUNT_M901");                         
	String VP_PREDIS_DISAMOUNT_M902                     = request.getParameter("VP_PREDIS_DISAMOUNT_M902");                          
	String dd                     = request.getParameter("VP_PREDIS_AMOUNT");

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
