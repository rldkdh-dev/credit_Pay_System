<%@ page contentType="text/html; charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%
	String proceed             = request.getParameter("proceed");
	String LPAY_F_CO_CD        = request.getParameter("LPAY_F_CO_CD");
	String LPAY_MEM_M_NUM      = request.getParameter("LPAY_MEM_M_NUM");
	String LPAY_IMONTH_NUM     = request.getParameter("LPAY_IMONTH_NUM");
	String LPAY_REQ_AMT        = request.getParameter("LPAY_REQ_AMT");
	String LPAY_CAVV           = request.getParameter("LPAY_CAVV");
	String LPAY_P_M_NUM        = request.getParameter("LPAY_P_M_NUM");
	String LPAY_XID            = request.getParameter("LPAY_XID");
	String LPAY_ECI            = request.getParameter("LPAY_ECI");
	String LPAY_OTC_NUM        = request.getParameter("LPAY_OTC_NUM");
	String LPAY_TR_ID          = request.getParameter("LPAY_TR_ID");
	String LPAY_CARD_YYMM      = request.getParameter("LPAY_CARD_YYMM");
%>
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="No-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>
<body >
<script type="text/javascript">
	function return_proceed()
	{
		var FormName = "";
		
		if( opener == null )
		{
			FormName = parent.document.kspayForm;
		}else
		{
			FormName = opener.document.kspayForm;
		}	
		
		FormName.LPAY_F_CO_CD           .value = '<%= LPAY_F_CO_CD         %>';
		FormName.LPAY_MEM_M_NUM         .value = '<%= LPAY_MEM_M_NUM       %>';
		FormName.CardQuota       		.value = '<%= LPAY_IMONTH_NUM      %>';
		FormName.LPAY_REQ_AMT           .value = '<%= LPAY_REQ_AMT         %>';
		FormName.cavv             		.value = '<%= LPAY_CAVV            %>';
		FormName.CardNum          		.value = '<%= LPAY_P_M_NUM         %>';
		FormName.xid              		.value = '<%= LPAY_XID             %>';
		FormName.eci              		.value = '<%= LPAY_ECI             %>';
		FormName.LPAY_OTC_NUM          	.value = '<%= LPAY_OTC_NUM         %>';
		FormName.LPAY_TR_ID            	.value = '<%= LPAY_TR_ID           %>';
		FormName.CardExpire        		.value = '<%= LPAY_CARD_YYMM       %>';
		
	
		
		if( opener == null ){
			parent.recvResult("<%=proceed%>");	
			
		}else{
			opener.recvResult("<%=proceed%>");	
			setTimeout("self.close()",2000);
		}	
	}
	
	return_proceed();
</script>
</body>
</html>
