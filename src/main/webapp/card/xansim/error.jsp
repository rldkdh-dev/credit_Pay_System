<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page isErrorPage="true" %>
<%
	exception.printStackTrace();
	String status = request.getParameter("status");
	
	boolean isPopup = false;
	
	if (status != null && status.equals("agent02")) {
		//popup window
		isPopup = true;
	}
	else {
		// iframe...
	}
	
	if (isPopup) {
%>
		<script type="text/javascript">
		<!--
		alert('예상치 못한 오류가 발생하였습니다.\n쇼핑몰 관리자에게 문의하시기 바랍니다.\n[<%=exception.toString()%>]');
		parent.disableItems(false);
		window.location.href="iframe.jsp";
		-->
		</script>
<% 
	}
	else {
%>
		<script type="text/javascript">
		<!--
		alert('예상치 못한 오류가 발생하였습니다.\n쇼핑몰 관리자에게 문의하시기 바랍니다.\n[<%=exception.toString()%>]');
		top.opener.setErrorResult();
		self.close();
		-->
		</script>
<%
	}
%>
