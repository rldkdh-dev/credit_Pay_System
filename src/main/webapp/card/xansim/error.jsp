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
		alert('����ġ ���� ������ �߻��Ͽ����ϴ�.\n���θ� �����ڿ��� �����Ͻñ� �ٶ��ϴ�.\n[<%=exception.toString()%>]');
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
		alert('����ġ ���� ������ �߻��Ͽ����ϴ�.\n���θ� �����ڿ��� �����Ͻñ� �ٶ��ϴ�.\n[<%=exception.toString()%>]');
		top.opener.setErrorResult();
		self.close();
		-->
		</script>
<%
	}
%>
