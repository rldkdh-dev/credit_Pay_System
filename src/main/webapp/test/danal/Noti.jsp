<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.util.*,java.io.*,java.text.*, java.net.*"%>
<%@ page import="kr.co.danal.jsinbi.HttpClient"%>
<%@ include file="inc/function.jsp"%>
<%
	request.setCharacterEncoding("euc-kr");

	/****************************************************************************
	 * �ſ�ī�� ��� �뺸. 
	 *  - Noti.jsp
	 *     
	 * �����ý��� ������ ���� ���ǻ��� �����ø� ������������� ���� �ֽʽÿ�.
	 * DANAL Commerce Division Technique supporting Team 
	 * EMAIL : tech@danal.co.kr
	 *****************************************************************************/
%>
<%
	String Path = new File(application.getRealPath(request.getServletPath())).getParentFile().getAbsolutePath();
	String LogDir = Path + "/log";
	System.out.println("##############" + LogDir);
	try {
		Calendar cal = Calendar.getInstance();
		String ndt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cal.getTime());
		String dt = new SimpleDateFormat("yyMMdd").format(cal.getTime());

		String Logs = LogDir + "/noti_" + dt + ".log";

		String QueryString = data2str(getReqMap(request));

		String Out = "[" + ndt + "]" + QueryString + "\n";

		File logDirectory = new File(LogDir);

		if (!logDirectory.exists()) {
			out.print("Fail-Cannot open log file");
			return;
		}

		PrintWriter stream = new PrintWriter(new BufferedWriter(new FileWriter(Logs, true)));

		stream.write(Out);
		stream.close();

		out.print("OK");

		/***************************************************
		 * Noti ���� �� ���� �Ϸῡ ���� �۾�
		 * - Noti�� ����� ���� DB�۾����� �ڵ��� �����Ͽ� �ֽʽÿ�.
		 * - ORDERID, AMOUNT �� ���� �ŷ����뿡 ���� ������ �ݵ�� �Ͻñ� �ٶ��ϴ�.
		 ****************************************************/
	} catch (Exception e) {
		e.printStackTrace();
		out.print("Fail-" + e.getMessage());
	}
%>
