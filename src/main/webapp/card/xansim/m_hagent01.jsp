<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page errorPage="error.jsp?status=m_hagent01" %>
<%@ page import="com.polaris.MallEncSimple" %>
<%@ page import="mobile.*, service.*, util.*" %>
<%
    // ��ġ���� ���� ����
    // ���󸮽� : ���¿� ����  010-2987-5223
    // ���󸮽� : ���翵 ����  010-5211-5826
    // ���󸮽� : ������ ����  010-3523-0386
    // ���󸮽� : ������ ����  010-3225-2420
    response.setHeader("P3P", "CP='NOI CURa ADMa DEVa TAIa OUR DELa BUS IND PHY ONL UNI COM NAV INT DEM PRE'");

    response.setHeader("cache-control","no-cache");
    response.setHeader("expires","-1");
    response.setHeader("pragma","no-cache");

    //�ѱ�ó��...
    request.setCharacterEncoding("UTF-8");
    
    System.out.println("---- m_hagent01.jsp start ----");
    /////////////////////////////////////////////////////////////////////
    //PG�� ���� ����
    //�̺κ��� pg�翡�� �������θ��� üũ�ϱ����� �ʿ��Ѱ͵��� �߰��Ͻø� �˴ϴ�
    //������ ����� �߰� ���Ͻǰ��� pg�翡 ������ hostagent01�� �����Ͻø� �˴ϴ�.
    //��) �ƾƵ� ,�н�����
    /////////////////////////////////////////////////////////////////////
    //���θ��� PG��� ���� �߱޹����� ���̵� �н����带 �Է��ϼ���.

    String X_MALLID="TESTID";
    String X_MALL_PASS="123456";
    /////////////////////////////////////////////////////////////////////
    //PG�� ���� ��
    /////////////////////////////////////////////////////////////////////

    /////////////////////////////////////////////////////////////////////
    //XMPI ���� ����
    /////////////////////////////////////////////////////////////////////

    // [�ʼ�] Display Name (����â�� ����� ���θ���)
    String X_MNAME=CommonUtil.getDefaultStr(request.getParameter("order_goods"),"");
    
    // [�ʼ�] ���θ� ��� : ���θ� ����ڹ�ȣ
    String X_MBUSINESSNUM= CommonUtil.getDefaultStr(request.getParameter("order_business"),"");
    
    // [�ʼ�] �ݾ�(���ڷθ�, �޸�, �Ҽ��� �Ұ�)
    // ��ȭ : 1000 = 1000�� , ��ȭ: 1000 = 10.00 �޷�
    String X_AMOUNT = CommonUtil.getDefaultStr(request.getParameter("order_amount"),"");

    // [�ʼ�] ��ȭ(410:��ȭ, 840:��ȭ)
    String X_CURRENCY=CommonUtil.getDefaultStr(request.getParameter("order_currency"),"410");
    
    // [�ʼ�] ���õ� ī����
    // 'SAMSUNGCARD' 'HYUNDAICARD' 'SHINHANCARD' 'NONGHYUPCARD'
    String X_CARDTYPE=CommonUtil.getDefaultStr(request.getParameter("order_cardname"),"");
    
    // [�ʼ�] ȣ���� ���θ� ������� URL :
    String X_MERCHANT_RECEIVEURL="https://pg.innopay.co.kr/ipay/card/xansim/m_hagent02.jsp";
    if (request.getServerPort() == 80 || request.getServerPort() == 443) {
        X_MERCHANT_RECEIVEURL = request.getScheme() + "://" + request.getServerName() +"/ipay/card/xansim/m_hagent02.jsp";
    } else {
        X_MERCHANT_RECEIVEURL = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort()+"/ipay/card/xansim/m_hagent02.jsp";
    } 
    
//  ------------------------------------------
    // 2007.06.11
    // �Ｚī�� ������û �߰� Field
    //------------------------------------------
    String X_CHAIN_NO_SS = "";
    String X_SELLER_ID = "";
    if (X_CARDTYPE.equals("SAMSUNGCARD")) {
        // X_CHAIN_NO_SS : ���ο�û�� ���Ǵ� ��������ȣ�� �����ϼ���.
        X_CHAIN_NO_SS = CommonUtil.getDefaultStr(request.getParameter("order_fnno"),"00000000");
        // apvl_seller_id : ���ο�û�� ���Ǵ� �������� ����ڹ�ȣ�� �����ϼ���.
        X_SELLER_ID = "1248702232";
    }
    
//  -----------------------------------------------
    //2008.09.19 : ���ۼ��̺� ���� 
    //����ī�� ������û���� Field �߰�!!!
    //-----------------------------------------------
    String X_CHAIN_NO_HD = "";
    String X_SELLER_ID_HD = "";
    String X_SS_USEYN_HD = "";
    if (X_CARDTYPE.equals("HYUNDAICARD")) {
        X_CHAIN_NO_HD = "00000000";
        X_SELLER_ID_HD = "1248702232";
        X_SS_USEYN_HD = ""; // N : ���̺� ������, �׿� : ���̺� ���
    }
    
    //------------------------------------------
    //------------------------------------------
    //2009.02.18 : ���̼��̺�
    //����ī�� ������û���� Field �߰�!!!
    //2012.12.03 : �������� �߰�.
    //------------------------------------------
    String X_CHAIN_NO_SH = "";
    String X_SELLER_ID_SH = "";
    String X_SS_USEYN_SH = "";
    if (X_CARDTYPE.equals("SHINHANCARD")) {
      //����ī��� ������ ��ȣ�� �����ϼ���.
      //�������൵ ����ī��� ������ ��ȣ�� �����ϼ���.
        X_CHAIN_NO_SH = "0000000000";
        X_SELLER_ID_SH = "1248702232";
        X_SS_USEYN_SH = "N"; // N : ���̺� ������, �׿� : ���̺� ���
    }   
    
    //-----------------------------------------------
    //2010.08 : ���̺� ���� 
    //NHī�� ������û���� Field �߰�!!!
    //-----------------------------------------------
    String X_CHAIN_NO_NH = "";
    String X_SELLER_ID_NH = "";
    String X_SS_USEYN_NH = "";
    if (X_CARDTYPE.equals("NONGHYUPCARD")) {
        X_CHAIN_NO_NH = "0000000000";
        X_SELLER_ID_NH = "1248702232";
        X_SS_USEYN_NH = ""; // N : ���̺� ������, �׿� : ���̺� ���
    }   

    String X_SP_CHAIN_CODE=CommonUtil.getDefaultStr(request.getParameter("sp_chain_code"),"0");

    String X_SP_ORDER_USER_ID= CommonUtil.getDefaultStr(request.getParameter("order_userid"),"");
    
    //2011.04�� �Ｚī��� ������� �߰�
    //------------------------------------------
    // [�ɼ�] �Ｚī��� ������� ���θ� ����ȸ�� KEY
    // �Ｚī�常 �ش��.
    // �Ｚī��翡 �ֹι�ȣ�� �ܹ���  ��ȣȭ(SHA256) �ؼ� �����ϴ� �κп� ���� ���ȼ� ���տ��δ� �Ｚī��翡 ���ǿ��
    // �Ｚī��翡 ������� ���������� ��ϵ� ���θ��� ��츸 ������ �����
    // MallEncSimple.getMallEncSimpleId()��  ����ϱ� ���ؼ��� xmpi���� �߰��� �����ϴ� MallEnc.jar�� ������ ��ġ�� ��밡�� 
    //------------------------------------------
    //����������ÿ��� 

    //��������� ������ ȸ���� �ֹι�ȣ�� ��ȣȭ �Ͽ� �Ｚī��翡 �����Ѵ�.
    if (X_CARDTYPE.equals("SAMSUNGCARD") && "1".equals(X_SP_CHAIN_CODE)) {
        //�Ｚī�� ������� ���θ�Ű 
        //���� �ֹι�ȣ�� ���ڰ����� �Ѱܾ� �Ѵ�. - ���� �Ѱܾ��Ѵ�. : 
        X_SP_ORDER_USER_ID=MallEncSimple.getMallEncSimpleId("1234569876543");
    }

    //2011.09�� ����ī��� ������� �߰�
    //------------------------------------------
    // [�ɼ�] ������� ���θ� ����ȸ�� KEY
    // ������� ���������� ��ϵ� ���θ��� ��츸 ������ �����
    // MallEncSimple.getMallEncSimpleId()��  ����ϱ� ���ؼ��� xmpi���� �߰��� �����ϴ� MallEnc.jar�� ������ ��ġ�� ��밡�� 
    //------------------------------------------
    //����������ÿ��� 
    //��������� ������ ȸ���� ��Ű�� ��ȣȭ �Ͽ� ����ī��翡 �����Ѵ�.
    //PC���� ��������� ����������� PC���� ����ϴ� ������ ��Ű�� ����ؾ��Ѵ�.
    //PC ,����ϻ��� ��Ű�� Ʋ���� �簡���ؾ��Ѵ�.
    if (X_CARDTYPE.equals("HYUNDAICARD") && "1".equals(X_SP_CHAIN_CODE)) {
        //������� ���θ�Ű 
        //��Ű�� �Ѱܾ� �Ѵ�.
        //���θ� ������ + �� ���� key
        X_SP_ORDER_USER_ID=MallEncSimple.getMallEncSimpleId(X_MNAME+"1234569876543");
    }
    
    //------------------------------------------
    // 2014.10
    // ����ī�� ������� ���� �߰� 
    // ���θ� ��Ű�� �ѱ���
    //------------------------------------------
    //��������� ������ ȸ���� ���θ� ��ü ��Ű���� ����.
    if (X_CARDTYPE.equals("NONGHYUPCARD") && "1".equals(X_SP_CHAIN_CODE)) {
        //������ ������� �ڵ尡 5
        X_SP_CHAIN_CODE = "5";
        //������� ���θ�Ű 
        //��Ű�� �Ѱܾ� �Ѵ�.      
        X_SP_ORDER_USER_ID=MallEncSimple.getMallEncSimpleId("1234569876543");
    }
    
    String X_HOSTURL="";
    String X_RECEIVEURL="";
    if ("SAMSUNGCARD".equals(X_CARDTYPE)){
        X_HOSTURL="https://vbv.samsungcard.co.kr/VbV/host/m_hostAgent01.jsp";
        X_RECEIVEURL="https://vbv.samsungcard.co.kr/VbV/host/m_hostAgent12.jsp";
    }else if ("HYUNDAICARD".equals(X_CARDTYPE)){
        X_HOSTURL="https://ansimclick.hyundaicard.com/host/m_hostAgent01.jsp";
        X_RECEIVEURL="https://ansimclick.hyundaicard.com/host/m_hostAgent12.jsp";
    }else if ("SHINHANCARD".equals(X_CARDTYPE)){
        X_HOSTURL="https://vbv.shinhancard.com/host/m_hostAgent01.jsp";
        X_RECEIVEURL="https://vbv.shinhancard.com/host/m_hostAgent12.jsp";
    }else if ("NONGHYUPCARD".equals(X_CARDTYPE)){
        X_HOSTURL="https://vbv.nonghyup.com/host/m_hostAgent01.jsp";
        X_RECEIVEURL="https://vbv.nonghyup.com/host/m_hostAgent12.jsp";
        X_RECEIVEURL = URLEncoder.encode(X_RECEIVEURL, "UTF-8");
    }else {
        throw new Exception("�Ƚ�Ŭ�� ���񽺰� �������� ���� ī���[" + X_CARDTYPE + "]�Դϴ�.");
        //out.println("���� �Ҽ� �����ϴ�.");
    }
    System.out.println("ȣ���� URL:" + X_HOSTURL);
    
    if ("SAMSUNGCARD".equals(X_CARDTYPE)){
        X_CARDTYPE="51";
    }else if ("HYUNDAICARD".equals(X_CARDTYPE)){
        X_CARDTYPE="61";
    }else if ("NONGHYUPCARD".equals(X_CARDTYPE)){
        X_CARDTYPE="91";
    }    
    /////////////////////////////////////////////////////////////////////
    //XMPI ���� ��
    /////////////////////////////////////////////////////////////////////
%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<!--
    ����� ������  ��Ƽ�� X�� ������ �մϴ�.
-->
<script type="text/javascript">
<!--
function openXansim() {
    document.X_ANSIMFORM.action="<%=X_HOSTURL%>";
    document.X_ANSIMFORM.method="post";
    document.X_ANSIMFORM.submit();
}
-->
</script>
</HEAD>
<BODY onload="openXansim();">
<form name="X_ANSIMFORM" method="post">
    <input type=hidden name="X_MALLID" value="<%=X_MALLID%>">
    <input type=hidden name="X_MALL_PASS" value="<%=X_MALL_PASS%>">
    <input type=hidden name="X_MNAME" value="<%=X_MNAME%>">
    <input type=hidden name="X_MBUSINESSNUM" value="<%=X_MBUSINESSNUM%>">
    <input type=hidden name="X_AMOUNT" value="<%=X_AMOUNT%>">
    <input type=hidden name="X_CURRENCY" value="<%=X_CURRENCY%>">
    <input type=hidden name="X_CARDTYPE" value="<%=X_CARDTYPE%>">
    <input type=hidden name="X_MERCHANT_RECEIVEURL" value="<%=X_MERCHANT_RECEIVEURL%>">
    <input type=hidden name="X_SP_CHAIN_CODE" value="<%=X_SP_CHAIN_CODE%>" >
    <input type=hidden name="X_SP_ORDER_USER_ID" value="<%=X_SP_ORDER_USER_ID%>" >
    <input type=hidden name="X_RECEIVEURL" value="<%=X_RECEIVEURL%>">
    <!-- �Ｚī����� �߰� �Ķ���� -->
    <input type=hidden name="X_CHAIN_NO_SS" value="<%=X_CHAIN_NO_SS%>">
    <input type=hidden name="X_SELLER_ID" value="<%=X_SELLER_ID%>">
    <!-- ����ī����� �߰� �Ķ���� -->
    <input type=hidden name="X_CHAIN_NO_HD" value="<%=X_CHAIN_NO_HD%>">
    <input type=hidden name="X_SELLER_ID_HD" value="<%=X_SELLER_ID_HD%>">
    <input type=hidden name="X_SS_USEYN_HD" value="<%=X_SS_USEYN_HD%>">
    <!-- ����ī����� �߰� �Ķ���� -->
    <input type=hidden name="X_CHAIN_NO_SH" value="<%=X_CHAIN_NO_SH%>">
    <input type=hidden name="X_SELLER_ID_SH" value="<%=X_SELLER_ID_SH%>">
    <input type=hidden name="X_SS_USEYN_SH" value="<%=X_SS_USEYN_SH%>">
    <!-- NHī����� �߰� �Ķ���� -->
    <input type=hidden name="X_CHAIN_NO_NH" value="<%=X_CHAIN_NO_NH%>">
    <input type=hidden name="X_SELLER_ID_NH" value="<%=X_SELLER_ID_NH%>">
    <input type=hidden name="X_SS_USEYN_NH" value="<%=X_SS_USEYN_NH%>">
    <!--2011.04�� ����ī��� ����Ʈ�� �������� ���� ������-->
    <!--2012.03�� ����ī��� ����Ʈ�� �������� ���� ������-->
    <!--10. [�ɼ�]���θ� ���� ��Ű��  ��) ������ ������: yes24://  , ���ĸ������� : ���� -->
    <input type="hidden" name="MALL_APP_NAME" value="">
    <!--11. [�ɼ�]�Ƚ�Ŭ�� �������� ���� ��뿩�� : ������������ �����(���ݾ�) ��) ��� : "Y" -->
    <input type="hidden" name="ISMART_USE_SIGN" value="">
</form>
</BODY>
</HTML>