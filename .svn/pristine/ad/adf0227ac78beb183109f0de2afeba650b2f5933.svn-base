<%@ page contentType="text/html; charset=utf-8" %>
<%
	System.out.println("---- mobileReturn.jsp start ----");

	String xid = request.getParameter("xid");
	String eci = request.getParameter("eci");
	String cavv = request.getParameter("cavv");
	String realPan = request.getParameter("realPan");
	String errCode = request.getParameter("errCode");
	String proceed = request.getParameter("proceed");

	String result;
	if(cavv == null) cavv = "";
	if(cavv.trim().equals("")) {
		proceed = "false";
		result = "인증에 <font color=red>실패</font>하였습니다.";
	} else {
		proceed = "true";
		result = "인증에 성공하였습니다.";
	}    
	 StringBuffer sb = new StringBuffer();
     sb.append("xid["+xid+"],");
     sb.append("eci["+eci+"],");
     sb.append("cavv["+cavv+"],");
     sb.append("realPan["+realPan+"],");
     sb.append("errCode["+errCode+"],");
     sb.append("proceed["+proceed+"],");
     
     System.out.println("ILK RESULT mobileReturn.jsp["+sb.toString()+"]");
%>
<html>
<script type='text/javascript'>
    function unload_me() {
		parent.paramSet("<%=xid%>","<%=eci%>","<%=cavv%>","<%=realPan%>","<%=proceed%>");
    }
    unload_me();
</script>
<body style="FONT-SIZE:9pt; COLOR:#778188; FONT-FAMILY:굴림" onUnload="">
<%=result%><br>
<br>
<center>
<table border=0 style="FONT-SIZE:9pt; COLOR:#778188; FONT-FAMILY:굴림">
<tr>
<td align=right>xid&nbsp;&nbsp;</td>
<td align=left><%=xid%></td>
</tr>
<tr>
<td align=right>eci&nbsp;&nbsp;</td>
<td align=left><%=eci%></td>
</tr>
<tr>
<td align=right>cavv&nbsp;&nbsp;</td>
<td align=left><%=cavv%></td>
</tr>
<tr>
<td align=right>cardno&nbsp;&nbsp;</td>
<td align=left><%=realPan%></td>
</tr>
</table>
</center>
<hr>
IsaacLandKorea K-MPI Hosting Service.
</body>
</html>
