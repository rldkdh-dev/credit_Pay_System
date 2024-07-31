<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 프린트 파라미터 처리 파일
*	@ PROGRAM NAME		: printParameter.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2009.04.02
*	@ PROGRAM CONTENTS	: 프린트 파라미터 처리 파일
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=euc-kr"%>

<%
	Box box = new Box();
	Enumeration enumeration = request.getParameterNames();
	while(enumeration.hasMoreElements()){
		String key = (String)enumeration.nextElement();
		String val = getDefaultStr(request.getParameter(key) , "");
		
		if(key.equals("ord_soc_no") && val != ""){//주민번호 표시형식
			val	= val.substring(0,6) + "-" + val.substring(6);
		} else if(key.equals("cc_dt") && val != ""){//취소날짜 표시형식
			val	= val.substring(0,4) + "/".toString() + val.substring(4,6) + "/".toString() + val.substring(6);
		} else if(key.equals("cc_tm") && val != ""){//취소시간 표시형식
			val	= val.substring(0,2) + ":" + val.substring(2,4) +":" + val.substring(4);
		} else if(key.equals("expire_dt") && val != "" ){//유효기간 표시형식
			val = val.substring(0,2) +"/".toString()+ val.substring(2);	
		} else if(key.equals("card_no") && val != "" ){//카드번호 표시형식 
			//나중에 DB들어가면 card_no로 바꾸기 프린트 페이지도 다 페이리절트 페이지 수정해야함
			val = val.substring(0,4) + "-****-****-" + val.substring(12);	
		}
		box.put(key , val);
	}
	
	//금액정보 Block에 넣기
	//tdCount 금액이 들어갈 칸의 총갯수-1
	//AmtSub 금액
	//Bugase 부가세
	//SumAmt 금액+부가세
	int tdCount	= 0; 					
	String AmtSub = "";
	String Bugase = "";
	String SumAmt = "";
	try{
		tdCount = Integer.parseInt(request.getAttribute("tdCount").toString());	
		AmtSub 	= blockIn(String.valueOf(Integer.parseInt(box.getString("Amt")) -  Integer.parseInt(box.getString("Amt")) / 10) , tdCount);
		Bugase 	= blockIn(String.valueOf(Integer.parseInt(box.getString("Amt")) / 10) , tdCount);
		SumAmt 	= blockIn(box.getString("Amt") , tdCount);
	}catch(NullPointerException e){ }	
	
%>
