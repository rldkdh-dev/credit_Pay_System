<%@page contentType="text/html; charset=UTF-8"
		%>
	//-------------------------------------------------------------------------
	// (3-2) accperr.jsp : 결제 인증 처리 중 오류 발생 시 호출되는 페이지 입니다.
	//-------------------------------------------------------------------------
	<% 
	request.setCharacterEncoding("UTF-8");
	String error = request.getParameter("error");
	String code = request.getParameter("code");
	
	if ("isp".equals(error)) {				// ISP결제 선택 시
		out.print("<script>window.parent.onISP();</script>");
	} else if ("cancel".equals(error)) {	// 결제 취소 시
		out.print("<script>window.parent.onCancel();</script>");
	} else if ("error".equals(error)) {		// 오류 발생 시
		out.print("<script>window.parent.onError(" + code + ");</script>");
	} else {								// 예외처리
		out.print("<script>window.parent.onCancel(9999);</script>");
	}
%>