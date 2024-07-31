<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%><%@ page import="java.util.Enumeration"%>    
<%
	System.out.println("-------- URL NOTI TEST --------");
	Enumeration enum1 = request.getParameterNames();
	String reqName = "";
	String reqValue = "";
	
	 
	while(enum1.hasMoreElements()){
	reqName = (String)enum1.nextElement();
	reqValue = request.getParameter(reqName);
	System.out.println("Noti Request Data NAME[" + reqName + "], VALUE[" + reqValue + "]");
	}
	System.out.println("-------- URL NOTI TEST END --------");
	out.print("0000");
%>