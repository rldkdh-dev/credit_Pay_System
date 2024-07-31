<%@ page contentType="text/html; charset=euc-kr" %>
<%
	String proceed = request.getParameter("proceed");
	String xid     = request.getParameter("xid");
	String eci     = request.getParameter("eci");
	String cavv    = request.getParameter("cavv");
	String cardno  = request.getParameter("cardno") ;
	String errCode = request.getParameter("errCode");
	String _tx_key = request.getParameter("tx_key");
	//System.out.println("proceed["+proceed+"]xid["+xid+"]eci["+eci+"]cavv["+cavv+"]cardno["+cardno+"]errCode["+"]_tx_key["+_tx_key+"]");
%>
<html>
<body>
<script language="javascript">
<!--
	function return_proceed()
	{             
		if (typeof(top.opener) == "undefined" || typeof(top.opener.paramSet) == "undefined" )
 		{       
 			if ("undefined" != typeof(window.localStorage))
			{
				var tnm = '<%=_tx_key%>';
				if (tnm != null && tnm.length>5)
				{
					var tval = new Array('<%=proceed%>','<%=xid%>','<%=eci%>','<%=cavv%>','<%=cardno%>','<%=errCode%>');
					localStorage.setItem("ksmpi_" + tnm ,tval.join('|'));
					setTimeout("self.close()",2000);
				}
			}else{
				alert("도구->인터넷옵션->보안->신뢰할 수 있는 사이트->보호모드 사용체크 후 다시 결제 진행해주세요");
			}
 		}else{
 			opener.paramSet('<%=proceed%>|<%=xid%>|<%=eci%>|<%=cavv%>|<%=cardno%>|<%=errCode%>');
			setTimeout("self.close()",2000);
 		}
	}
	return_proceed();
                     
	
-->
</script>
</body>
</html>
