<%------------------------------------------------------------------------------
���ϸ�     : KSPayCreditFormMNI.jsp
���       : KSPAY �� ���� ��� �� ���� Ȯ�� 
-------------------------------------------------------------------------------%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="ksnet.kspay.*" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%
	//����Ÿ�� : A-�������½���, N-��������, M-MPI��������, I-ISP�������� 
	String certitype         = request.getParameter("certitype") ;	
	
//Header�� Data -------------------------------------------------------------------
	String EncType           = "2" ;                                    //0: ��ȭ����, 1:ssl, 2: seed
	String Version           = "0603" ;                                 //��������
	String Type              = "00" ;                                   //����
	String Resend            = "0" ;                                    //���۱��� : 0 : ó��,  2: ������
	String RequestDate       = new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date()); // ��û���� 
	String KeyInType         = "K" ;                                    //KeyInType ���� : S : Swap, K: KeyInType
	String LineType          = "1" ;                                    //lineType 0 : offline, 1:internet, 2:Mobile
	String ApprovalCount     = "1" ;                                    //���ս��ΰ���
	String GoodType          = "0" ;                                    //��ǰ���� 0 : �ǹ�, 1 : ������
	String HeadFiller        = "" ;                                     //����
	
	String StoreId           = request.getParameter("storeid") ;        // �������̵�
	String OrderNumber       = request.getParameter("ordernumber") ;    // �ֹ���ȣ
	String UserName          = request.getParameter("ordername") ;      // �ֹ��ڸ�
	String IdNum             = "" ;                                     // �ֹι�ȣ or ����ڹ�ȣ (����ó��)
	String Email             = request.getParameter("email") ;          // email
	String GoodName          = request.getParameter("goodname") ;       // ��ǰ��
	String PhoneNo           = request.getParameter("phoneno") ;        // �޴�����ȣ
//Header end -------------------------------------------------------------------
	
//Data Default -------------------------------------------------------------------
	String ApprovalType      = request.getParameter("authty") ;         //���α���
	String InterestType      = request.getParameter("interest") ;       //�Ϲ�/�����ڱ��� 1:�Ϲ� 2:������
	// ī���ȣ=��ȿ�Ⱓ  or �ŷ���ȣ
	String TrackII           = request.getParameter("cardno")+"="+request.getParameter("expdt");
	String Installment       = request.getParameter("installment") ;    //�Һ�  00�Ͻú�
	String Amount            = request.getParameter("amount") ;         //�ݾ�
	String Passwd            = request.getParameter("passwd") ;         //��й�ȣ ��2�ڸ�
	String LastIdNum         = request.getParameter("lastidnum") ;      //�ֹι�ȣ  ��6�ڸ�, ����ڹ�ȣ10
	String CurrencyType      = request.getParameter("currencytype") ;   //��ȭ���� 0:��ȭ 1: ��ȭ
	
	String BatchUseType      = "0" ;                      //�ŷ���ȣ��ġ��뱸��  0:�̻�� 1:���
	String CardSendType      = "0" ;                      //ī��������������
	                                                      //0:������ 1:ī���ȣ,��ȿ�Ⱓ,�Һ�,�ݾ�,��������ȣ 2:ī���ȣ��14�ڸ� + "XXXX",��ȿ�Ⱓ,�Һ�,�ݾ�,��������ȣ
	String VisaAuthYn        = "7" ;                      //������������ 0:������,7:SSL,9:��������
	String Domain            = "" ;                       //������ ��ü������(PG��ü��)
	String IpAddr            = request.getRemoteAddr();   //IP ADDRESS ��ü������(PG��ü��)
	String BusinessNumber    = "" ;                       //����� ��ȣ ��ü������(PG��ü��)
	String Filler            = "" ;                       //����
	String AuthType          = "" ;                       //ISP : ISP�ŷ�, MP1, MP2 : MPI�ŷ�, SPACE : �Ϲݰŷ�
	String MPIPositionType   = "" ;                       //K : KSNET, R : Remote, C : ��3���, SPACE : �Ϲݰŷ�
	String MPIReUseType      = "" ;                       //Y : ����, N : ����ƴ�
	String EncData           = "" ;                       //MPI, ISP ������
	
	String cavv              = request.getParameter("cavv") ;   //MPI��
	String xid               = request.getParameter("xid") ;    //MPI��
	String eci               = request.getParameter("eci") ;    //MPI��
	
	String KVP_PGID          = "" ;
	String KVP_CARDCODE      = "" ;
	String KVP_SESSIONKEY    = "" ;
	String KVP_ENCDATA       = "" ;
	
	// KBAPP
	String kb_app_otp = request.getParameter("kb_app_otp"	);
	/*ISP�ϰ��*/
	if(certitype.equals("I"))
	{
		TrackII              = "" ;
		InterestType         = request.getParameter("KVP_NOINT");       //�����ڱ���
		Installment          = request.getParameter("KVP_QUOTA");       //�Һ�:00�Ͻú�
		KVP_PGID             = request.getParameter("KVP_PGID");
		KVP_CARDCODE         = request.getParameter("KVP_CARDCODE");
		KVP_SESSIONKEY       = request.getParameter("KVP_SESSIONKEY");
		KVP_ENCDATA          = request.getParameter("KVP_ENCDATA");
	}
//Data Default end -------------------------------------------------------------
	
//Server�� ���� ������ ������ ��ü����
	String rApprovalType       = "1001" ;
	String rTransactionNo      = "" ;                 //�ŷ���ȣ
	String rStatus             = "X" ;                //���� O : ����, X : ����
	String rTradeDate          = "" ;                 //�ŷ�����
	String rTradeTime          = "" ;                 //�ŷ��ð�
	String rIssCode            = "00" ;               //�߱޻��ڵ�
	String rAquCode            = "00" ;               //���Ի��ڵ�
	String rAuthNo             = "9999" ;             //���ι�ȣ or ������ �����ڵ�
	String rMessage1           = "���ΰ���" ;         //�޽���1
	String rMessage2           = "C�������õ�" ;    //�޽���2
	String rCardNo             = "" ;                 //ī���ȣ
	String rExpDate            = "" ;                 //��ȿ�Ⱓ
	String rInstallment        = "" ;                 //�Һ�
	String rAmount             = "" ;                 //�ݾ�
	String rMerchantNo         = "" ;                 //��������ȣ
	String rAuthSendType       = "N" ;                //���۱���
	String rApprovalSendType   = "N" ;                //���۱���(0 : ����, 1 : ����, 2: ��ī��)
	String rPoint1             = "000000000000" ;     //Point1
	String rPoint2             = "000000000000" ;     //Point2
	String rPoint3             = "000000000000" ;     //Point3
	String rPoint4             = "000000000000" ;     //Point4
	String rVanTransactionNo   = "" ;
	String rFiller             = "" ;                 //����
	String rAuthType           = "" ;                 //ISP : ISP�ŷ�, MP1, MP2 : MPI�ŷ�, SPACE : �Ϲݰŷ�
	String rMPIPositionType    = "" ;                 //K : KSNET, R : Remote, C : ��3���, SPACE : �Ϲݰŷ�
	String rMPIReUseType       = "" ;                 //Y : ����, N : ����ƴ�
	String rEncData            = "" ;                 //MPI, ISP ������
//--------------------------------------------------------------------------------
	
	try 
	{	
		KSPayApprovalCancelBean ipg = new KSPayApprovalCancelBean("localhost", 29991); 
		
		ipg.HeadMessage(EncType, Version, Type, Resend, RequestDate, StoreId, OrderNumber, UserName, IdNum, Email, 
						GoodType, GoodName, KeyInType, LineType, PhoneNo, ApprovalCount, HeadFiller);
		
		//�Ϲݽ����ΰ��
		if(certitype.equals("A")||certitype.equals("N"))
		{
			AuthType        = "" ;
			MPIPositionType = "" ;
			MPIReUseType    = "" ;
			EncData         = "" ;
		}
		//MPI���������ΰ��
		else if(certitype.equals("M"))
		{
			AuthType        = "M" ;
			MPIPositionType = "K" ;
			MPIReUseType    = "N" ;
			cavv            = ipg.format(cavv, 40, 'X');
			xid             = ipg.format(xid,  40, 'X');
			eci             = ipg.format(eci,   2, 'X');
			EncData         = ipg.format(""+(cavv+xid+eci).getBytes().length, 5, '9') + cavv+xid+eci;
		}
		//ISP���������ΰ��
		else if(certitype.equals("I"))
		{
			if(!kb_app_otp.equals("")){
				ApprovalType			= "1000";
				TrackII = kb_app_otp+"=8911";
				Filler = "            KBA" ;
			}else{
				AuthType        = "I";
				MPIPositionType = "K";
				MPIReUseType    = "N";
			
				KVP_SESSIONKEY  = URLEncoder.encode(KVP_SESSIONKEY);
				KVP_ENCDATA     = URLEncoder.encode(KVP_ENCDATA);
				KVP_SESSIONKEY  = ipg.format(""+KVP_SESSIONKEY.getBytes().length,  4, '9') + KVP_SESSIONKEY;
				KVP_ENCDATA     = ipg.format(""+KVP_ENCDATA.getBytes().length,     4, '9') + KVP_ENCDATA;
				KVP_CARDCODE    = ipg.format(""+KVP_CARDCODE.getBytes().length,2, '9') + KVP_CARDCODE;
				KVP_CARDCODE    = ipg.format(""+KVP_CARDCODE, 22, 'X');
				EncData         = ipg.format(""+(KVP_PGID+KVP_SESSIONKEY+KVP_ENCDATA+KVP_CARDCODE).getBytes().length, 5, '9') + KVP_PGID+KVP_SESSIONKEY+KVP_ENCDATA+KVP_CARDCODE;
			}
			if(InterestType.equals("0")) InterestType = "1" ;
			else                         InterestType = "2" ;
		}
		
		if(CurrencyType.equals("WON")||CurrencyType.equals("410")||CurrencyType.equals(""))	CurrencyType = "0" ;
		else if(CurrencyType.equals("USD")||CurrencyType.equals("840"))	CurrencyType = "1" ;
		else CurrencyType = "0" ;
		
		ipg.CreditDataMessage
		(ApprovalType, InterestType, TrackII, Installment, Amount, Passwd, LastIdNum, CurrencyType, 
		 BatchUseType, CardSendType, VisaAuthYn, Domain, IpAddr, BusinessNumber, Filler, AuthType, 
		 MPIPositionType, MPIReUseType, EncData);
		
		if(ipg.SendSocket("1")) 
		{
			rApprovalType       = ipg.ApprovalType[0];
			rTransactionNo      = ipg.TransactionNo[0];        // �ŷ���ȣ
			rStatus             = ipg.Status[0];               // ���� O : ����, X : ����
			rTradeDate          = ipg.TradeDate[0];            // �ŷ�����
			rTradeTime          = ipg.TradeTime[0];            // �ŷ��ð�
			rIssCode            = ipg.IssCode[0];              // �߱޻��ڵ�
			rAquCode            = ipg.AquCode[0];              // ���Ի��ڵ�
			rAuthNo             = ipg.AuthNo[0];               // ���ι�ȣ or ������ �����ڵ�
			rMessage1           = ipg.Message1[0];             // �޽���1
			rMessage2           = ipg.Message2[0];             // �޽���2
			rCardNo             = ipg.CardNo[0];               // ī���ȣ
			rExpDate            = ipg.ExpDate[0];              // ��ȿ�Ⱓ
			rInstallment        = ipg.Installment[0];          // �Һ�
			rAmount             = ipg.Amount[0];               // �ݾ�
			rMerchantNo         = ipg.MerchantNo[0];           // ��������ȣ
			rAuthSendType       = ipg.AuthSendType[0];         // ���۱���= new String(this.read(2));
			rApprovalSendType   = ipg.ApprovalSendType[0];     // ���۱���(0 : ����, 1 : ����, 2: ��ī��)
			rPoint1             = ipg.Point1[0];               // Point1
			rPoint2             = ipg.Point2[0];               // Point2
			rPoint3             = ipg.Point3[0];               // Point3
			rPoint4             = ipg.Point4[0];               // Point4
			rVanTransactionNo   = ipg.VanTransactionNo[0];     // Van�ŷ���ȣ
			rFiller             = ipg.Filler[0];               // ����
			rAuthType           = ipg.AuthType[0];             // ISP : ISP�ŷ�, MP1, MP2 : MPI�ŷ�, SPACE : �Ϲݰŷ�
			rMPIPositionType    = ipg.MPIPositionType[0];      // K : KSNET, R : Remote, C : ��3���, SPACE : �Ϲݰŷ�
			rMPIReUseType       = ipg.MPIReUseType[0];         // Y : ����, N : ����ƴ�
			rEncData            = ipg.EncData[0];              // MPI, ISP ������
		}
	}
	catch(Exception e) 
	{
		rMessage2 = "C�������õ�("+e.toString()+")";       // �޽���2
	}
%>

<html>
<head>
<title>KSPay</title>
<meta http-equiv="Content-Type" content="text/html charset=euc-kr">
<style type="text/css">
	TABLE{font-size:9pt; line-height:160%;}
	A {color:blueline-height:160% background-color:#E0EFFE}
	INPUT{font-size:9pt}
	SELECT{font-size:9pt}
	.emp{background-color:#FDEAFE}
	.white{background-color:#FFFFFF color:black border:1x solid white font-size: 9pt}
</style>
<script language="javascript">
<!--

document.onkeypress = processKey;
document.onkeydown  = processKey;

function processKey() {
	if(( event.ctrlKey == true && ( event.keyCode == 78 || event.keyCode == 82 ) ) ||
		( event.keyCode >= 112 && event.keyCode <= 123 ))
	{
		event.keyCode = 0;
		event.cancelBubble = true;
		event.returnValue = false;
	}
	if(event.keyCode == 8 && typeof(event.srcElement.value) == "undefined") {
		event.keyCode = 0;
		event.cancelBubble = true;
		event.returnValue = false;
	}
}

-->
</script>
</head>

<body onload="" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 >
<table border=0 width=0>
<tr>
<td align=center>
<table width=320 cellspacing=0 cellpadding=0 border=0 bgcolor=#4F9AFF>
<tr>
<td>
<table width=100% cellspacing=1 cellpadding=2 border=0>
<tr bgcolor=#4F9AFF height=25>
<td align=left><font color="#FFFFFF">
KSPay �ſ�ī�� ���
<%
	if(certitype.equals("A"))      out.println("(�������½���)") ;
	else if(certitype.equals("N")) out.println("(��������)") ;
	else if(certitype.equals("M")) out.println("(M-MPI��������)") ;
	else if(certitype.equals("I")) out.println("(I-ISP��������)") ;
%>
</font></td>
</tr>
<tr bgcolor=#FFFFFF>
<td valign=top>
<table width=100% cellspacing=0 cellpadding=2 border=0>
<tr>
<td align=left>
<table>
<tr>
	<td>�ŷ����� :</td>
	<td><%=rApprovalType%></td>
</tr>
<tr>
	<td>�ŷ���ȣ :</td>
	<td><%=rTransactionNo%></td>
</tr>
<tr>
	<td>�ŷ��������� :</td>
	<td><%=rStatus%></td>
</tr>
<tr>
	<td>�ŷ��ð� :</td>
	<td><%=rTradeDate%> / <%=rTradeTime%></td>
</tr>
<tr>
	<td>�߱޻��ڵ� :</td>
	<td><%=rIssCode%></td>
</tr>
<tr>
	<td>���Ի��ڵ� :</td>
	<td><%=rAquCode%></td>
</tr>
<tr>
	<td>���ι�ȣ :</td>
	<td><%=rAuthNo%></td>
</tr>
<tr>
	<td>�޽���1 :</td>
	<td><%=rMessage1%></td>
</tr>
<tr>
	<td>�޽���2 :</td>
	<td><%=rMessage2%></td>
</tr>

</table>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</table>
</body>
</html>
