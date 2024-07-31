<%@ page import="java.util.*,java.net.*" contentType="text/html; charset=euc-kr"
%><%
	String proceed  = request.getParameter("proceed");
	String tid      = request.getParameter("tid"); if (null == tid ) tid = "";
	String cid      = request.getParameter("cid"); if (null == tid ) tid = "";
	String pg_token = request.getParameter("pg_token"); if (null == pg_token ) pg_token = "";
	System.out.println("proceed:"+proceed);
	System.out.println("pg_token:"+pg_token);
	System.out.println("tid:"+tid);

%>
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="No-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>KAKAO 인증결과</title>
</head>
<body>
<script type="text/javascript" charset="euc-kr">
	function return_proceed()
	{
		if("<%=proceed%>" == "true")
		{
			if( opener == null )
			{
				parent.recvResult("<%=proceed%>","<%=tid%>","<%=cid%>","<%=pg_token%>");
				location.href="./blank.html";
			}
			else
			{
				opener.recvResult("<%=proceed%>","<%=tid%>","<%=cid%>","<%=pg_token%>");
				self.close();
			}
		}
		else{
			parent.kakao_cancel();
		}
	}
	return_proceed();
</script>
</body>
</html>