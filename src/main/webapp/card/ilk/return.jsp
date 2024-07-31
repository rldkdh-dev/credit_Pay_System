<%
	String proceed = request.getParameter("proceed");
	String xid = request.getParameter("xid");
	String eci = request.getParameter("eci");
	String cavv = request.getParameter("cavv");
	String realPan = request.getParameter("realPan");
	String errCode = request.getParameter("errCode");
	
	String ss_useyn					= request.getParameter("ss_useyn");
	String savekind					= request.getParameter("savekind");
  	String ss_useyn_ke 			= request.getParameter("ss_useyn_ke");
  
  	StringBuffer sb = new StringBuffer();
  	sb.append("xid["+xid+"],");
  	sb.append("eci["+eci+"],");
  	sb.append("cavv["+cavv+"],");
  	sb.append("realPan["+realPan+"],");
  	sb.append("errCode["+errCode+"],");
  	sb.append("ss_useyn["+ss_useyn+"],");
  	sb.append("savekind["+savekind+"],");
  	sb.append("ss_useyn_ke["+ss_useyn_ke+"],");
  
  	System.out.println("ILK RESULT return.jsp["+sb+"]");
  
	/*
	 * Do not cache this page.
	 */
	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","-1");
	response.setHeader("pragma","no-cache");
%>
<html>
	<body onload="proceed();">
	<script language="javascript">
	<!--
		function proceed()
		{
		    alert("xid: " + xid);
		    alert("eci: " + eci);
		    alert("cavv: " + cavv);
		    alert("realPan: " + realPan);    
		    alert("ss_useyn: " + ss_useyn);    
		    alert("savekind: " + savekind);    
		    alert("ss_useyn_ke: " + ss_useyn_ke);  
		    
		    parent.paramSet("<%=xid%>","<%=eci%>","<%=cavv%>","<%=realPan%>", "<%=ss_useyn%>", "<%=savekind%>", "<%=ss_useyn_ke%>" );
				parent.proceed(<%=proceed.toLowerCase()%>);
				location.href="./dummy.jsp";
		}
	-->
	</script>
	</body>
</html>
