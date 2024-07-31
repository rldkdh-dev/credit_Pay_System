<%@ page contentType="text/html; charset=euc-kr" %>
<%
        String xid = request.getParameter("xid");
        String eci = request.getParameter("eci");
        String cavv = request.getParameter("cavv");
        String realPan = request.getParameter("realPan");
        String errCode = request.getParameter("errCode");
        String proceed = request.getParameter("proceed");
        String ss_useyn					= request.getParameter("ss_useyn");
      	String savekind					= request.getParameter("savekind");
      	String ss_useyn_ke 			= request.getParameter("ss_useyn_ke");
      	
        String result;
        if(cavv == null) cavv = "";
        if(cavv.trim().equals("")) {
                result = "인증에 <font color=red>실패</font>하였습니다.";
        } else {
                result = "인증에 성공하였습니다.";
        }
        StringBuffer sb = new StringBuffer();
        sb.append("xid["+xid+"],");
        sb.append("eci["+eci+"],");
        sb.append("cavv["+cavv+"],");
        sb.append("realPan["+realPan+"],");
        sb.append("errCode["+errCode+"],");
        sb.append("ss_useyn["+ss_useyn+"],");
        sb.append("savekind["+savekind+"],");
        sb.append("ss_useyn_ke["+ss_useyn_ke+"],");
        
        System.out.println("ILK RESULT testReturn.jsp["+sb+"]");
%>
<html>
<script type="text/javascript">
    function unload_me() {
		window.parent.paramSet("<%=xid%>","<%=eci%>","<%=cavv%>","<%=realPan%>", "<%=ss_useyn%>", "<%=savekind%>", "<%=ss_useyn_ke%>", "<%=proceed%>");
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
<tr>
<td align=right>ss_useyn&nbsp;&nbsp;</td>
<td align=left><%=ss_useyn%></td>
</tr>
<tr>
<td align=right>savekind&nbsp;&nbsp;</td>
<td align=left><%=savekind%></td>
</tr>
<tr>
<td align=right>ss_useyn_ke&nbsp;&nbsp;</td>
<td align=left><%=ss_useyn_ke%></td>
</tr>
</table>
</center>
<hr>
IsaacLandKorea K-MPI Hosting Service.
</body>
</html>
