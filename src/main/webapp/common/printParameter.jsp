<%
/******************************************************************************
*
*	@ SYSTEM NAME		: ����Ʈ �Ķ���� ó�� ����
*	@ PROGRAM NAME		: printParameter.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2009.04.02
*	@ PROGRAM CONTENTS	: ����Ʈ �Ķ���� ó�� ����
*
************************** �� �� �� �� *****************************************
* ��ȣ	�۾���		�۾���				���泻��
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=euc-kr"%>

<%
	Box box = new Box();
	Enumeration enumeration = request.getParameterNames();
	while(enumeration.hasMoreElements()){
		String key = (String)enumeration.nextElement();
		String val = getDefaultStr(request.getParameter(key) , "");
		
		if(key.equals("ord_soc_no") && val != ""){//�ֹι�ȣ ǥ������
			val	= val.substring(0,6) + "-" + val.substring(6);
		} else if(key.equals("cc_dt") && val != ""){//��ҳ�¥ ǥ������
			val	= val.substring(0,4) + "/".toString() + val.substring(4,6) + "/".toString() + val.substring(6);
		} else if(key.equals("cc_tm") && val != ""){//��ҽð� ǥ������
			val	= val.substring(0,2) + ":" + val.substring(2,4) +":" + val.substring(4);
		} else if(key.equals("expire_dt") && val != "" ){//��ȿ�Ⱓ ǥ������
			val = val.substring(0,2) +"/".toString()+ val.substring(2);	
		} else if(key.equals("card_no") && val != "" ){//ī���ȣ ǥ������ 
			//���߿� DB���� card_no�� �ٲٱ� ����Ʈ �������� �� ���̸���Ʈ ������ �����ؾ���
			val = val.substring(0,4) + "-****-****-" + val.substring(12);	
		}
		box.put(key , val);
	}
	
	//�ݾ����� Block�� �ֱ�
	//tdCount �ݾ��� �� ĭ�� �Ѱ���-1
	//AmtSub �ݾ�
	//Bugase �ΰ���
	//SumAmt �ݾ�+�ΰ���
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
