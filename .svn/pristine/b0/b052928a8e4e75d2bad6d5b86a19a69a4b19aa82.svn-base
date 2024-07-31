<%@page import="java.util.*,java.io.*"%>
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="../common/ipgwebCommon.jsp" %>

<%
String PayMethod	= getDefaultStr(request.getParameter("PayMethod"), CommonConstants.PAY_METHOD_MOBILE);
String payType		= getDefaultStr(request.getParameter("payType"), "");
String GoodsCnt		= getDefaultStr(request.getParameter("GoodsCnt"), "");
String GoodsName	= getDefaultStr(request.getParameter("GoodsName"), "");
String GoodsURL		= getDefaultStr(request.getParameter("GoodsURL"), "");
String GoodsCl		= getDefaultStr(request.getParameter("GoodsCl"), "");
String Amt			= getDefaultStr(request.getParameter("Amt"), "");	
String Moid			= getDefaultStr(request.getParameter("Moid"), "");
String MID			= getDefaultStr(request.getParameter("MID"), "");
String TID			= getDefaultStr(request.getParameter("TID"), "");
String ReturnURL	= getDefaultStr(request.getParameter("ReturnURL"), "");
String ResultYN     = getDefaultStr(request.getParameter("ResultYN"), "");
String RetryURL		= getDefaultStr(request.getParameter("RetryURL"), "");
String mallUserID	= getDefaultStr(request.getParameter("mallUserID"), "");
String BuyerName	= getDefaultStr(request.getParameter("BuyerName"), "");
String BuyerAuthNum	= getDefaultStr(request.getParameter("BuyerAuthNum"), "");
String BuyerTel		= getDefaultStr(request.getParameter("BuyerTel"), "");
String BuyerEmail	= getDefaultStr(request.getParameter("BuyerEmail"), "");
String BuyerAddr	= getDefaultStr(request.getParameter("BuyerAddr"), "");
String BuyerPostNo	= getDefaultStr(request.getParameter("BuyerPostNo"), "");
String ParentEmail	= getDefaultStr(request.getParameter("ParentEmail"), "");
String UserIP		= getDefaultStr(request.getParameter("UserIP"), "");
String MallIP		= getDefaultStr(request.getParameter("MallIP"), "");
String BrowserType	= getDefaultStr(request.getParameter("BrowserType"), "");
String VbankExpDate = getDefaultStr(request.getParameter("VbankExpDate"), "");
String MallReserved = getDefaultStr(request.getParameter("MallReserved"), "");
String MallReserved1 = getDefaultStr(request.getParameter("MallReserved1"), "");
String MallReserved2 = getDefaultStr(request.getParameter("MallReserved2"), "");
String MallReserved3 = getDefaultStr(request.getParameter("MallReserved3"), "");
String MallReserved4 = getDefaultStr(request.getParameter("MallReserved4"), "");
String MallReserved5 = getDefaultStr(request.getParameter("MallReserved5"), "");
String MallReserved6 = getDefaultStr(request.getParameter("MallReserved6"), "");
String MallReserved7 = getDefaultStr(request.getParameter("MallReserved7"), "");
String MallReserved8 = getDefaultStr(request.getParameter("MallReserved8"), "");
String MallReserved9 = getDefaultStr(request.getParameter("MallReserved9"), "");
String MallReserved10 = getDefaultStr(request.getParameter("MallReserved10"), "");
String MallResultFWD = getDefaultStr(request.getParameter("MallResultFWD"), "");
String TransType = getDefaultStr(request.getParameter("TransType"), "");
String SUB_ID = getDefaultStr(request.getParameter("SUB_ID"), "");

String Carrier = getDefaultStr(request.getParameter("Carrier"), "");


String DstAddr0 = getDefaultStr(request.getParameter("DstAddr0"), "");
String DstAddr1 = getDefaultStr(request.getParameter("DstAddr1"), "");
String DstAddr2 = getDefaultStr(request.getParameter("DstAddr2"), "");
String DstAddr = DstAddr0 + DstAddr1 + DstAddr2;

String Iden0 = getDefaultStr(request.getParameter("Iden0"), "");
String Iden1 = getDefaultStr(request.getParameter("Iden1"), "");
String Iden = Iden0 + Iden1;

String OTP = getDefaultStr(request.getParameter("OTP"), "");

String CPID = getDefaultStr(request.getParameter("CPID"), "");
String MOBRecordKey = getDefaultStr(request.getParameter("MOB_RecordKey"), "");
String MOBPhoneID = getDefaultStr(request.getParameter("MOB_PhoneID"), "");

StringBuffer cpNoBuffer = new StringBuffer();
cpNoBuffer.append(DstAddr0);
cpNoBuffer.append(DstAddr1);
cpNoBuffer.append(DstAddr2);


	
Box box = new Box();
Box resMerKeyBox = null;

box.put("mid", MID);
resMerKeyBox = CommonBiz.getMemberKey(box);
   
if(resMerKeyBox == null || resMerKeyBox.getString("mkey") == null) {        
	throw new Exception("W009"); // 상점서명키를 확인해 주세요.       
}

//Biz 호출
PGClientContext context = null;
PGConnection con = null;
GiftBox req = null;

context = PGClient.getInstance().getConext("MOBILE_BL");

req = context.newGiftBox("NPG01MOB01");
	
// 전문공통
req.put("Version"		,"NPG01");
req.put("ID"			,"MOB01");
req.put("EdiDate"		,TimeUtils.getyyyyMMddHHmmss());
req.put("TID"			,TID);
req.put("ErrorSys"		,"WEB");
req.put("ErrorCD"		,"");
req.put("ErrorMSG"		,"");
// 상품정보
req.put("GoodsCnt"		,GoodsCnt);
req.put("GoodsName"		,GoodsName);
req.put("Amt"			,Amt);
req.put("MOID"			,Moid);
req.put("Currency"		,"KRW");
// 상점정보	
req.put("MID"			,MID);
req.put("LicenseKey"	,resMerKeyBox.getString("mkey"));	
req.put("MallIP"		,MallIP);
req.put("Language"		,"Kor");
//out.println("MallReserved["+MallReserved+"]");
req.put("MallReserved"	,MallReserved); //상점예비
req.put("ReturnURL"		,ReturnURL);
req.put("RetryURL"		,RetryURL);
// 구매자정보
req.put("MallUserID"	,mallUserID);
req.put("BuyerName"		,BuyerName);
req.put("BuyerAuthNum"	,Iden);
req.put("BuyerTel"		,DstAddr);
req.put("BuyerEmail"	,BuyerEmail);
req.put("ParentEmail"	,ParentEmail);
req.put("BuyerAddr"	    ,BuyerAddr);
req.put("BuyerPostNo"   ,BuyerPostNo);
// 결제자정보
req.put("BrowserType"	,BrowserType);
req.put("UserIP"		,UserIP);
req.put("MAC"			,"");
req.put("SUB_ID"			,SUB_ID);


// 휴대폰
req.put("GoodsCl"		,GoodsCl);
req.put("Carrier"		,Carrier);
req.put("SmsOTP"	,OTP);
req.put("CpTID"		,"");
req.put("CpNo"		,cpNoBuffer.toString());
req.put("RecKey"		,MOBRecordKey);
req.put("PhoneID"		,MOBPhoneID);
req.put("FnCd"		,"");


GiftBox rep = context.send(req);
System.out.print("req:"+req);
System.out.print("rep:"+rep);

String resAuthDate			= rep.getString("AuthDate");
String resErrorCD           = rep.getString("ErrorCD");
String resErrorMSG          = rep.getString("ErrorMSG");
String resResultCode		= rep.getString("ResultCode");
String resResultMsg			= rep.getString("ResultMsg");	
String resAuthCode          = rep.getString("AuthCode");	
%>

<form name="returnMgr" method="post" action="<%=ReturnURL%>">
         <input type="hidden" name="PayMethod" value="<%=PayMethod%>">
         <input type="hidden" name="MID" value="<%=MID%>">
         <input type="hidden" name="TID" value="<%=TID%>">
         <input type="hidden" name="mallUserID" value="<%=mallUserID%>">
         <input type="hidden" name="BuyerName"			value="<%=BuyerName%>">
         <input type="hidden" name="BuyerEmail"          value="<%=BuyerEmail%>">
         <input type="hidden" name="Amt" value="<%=Amt%>">
         <input type="hidden" name="name" value="<%=BuyerName%>">
         <input type="hidden" name="GoodsName" value="<%=GoodsName%>">
         <input type="hidden" name="OID" value="<%=Moid%>">
         <input type="hidden" name="AuthDate" value="<%=resAuthDate%>">
         <input type="hidden" name="AuthCode" value="<%=resAuthCode%>">
         <input type="hidden" name="ResultCode" value="<%=resResultCode%>">
         <input type="hidden" name="ResultMsg" value="<%=resResultMsg%>">
         <input type="hidden" name="VbankNum" value="">
         <input type="hidden" name="VbankName" value="">
         <input type="hidden" name="MerchantReserved" value="<%=MallReserved%>">
         <input type="hidden" name="MallReserved" value="<%=MallReserved%>">
         <input type="hidden" name="MallReserved1"   value="<%=MallReserved1%>">
         <input type="hidden" name="MallReserved2"   value="<%=MallReserved2%>">
				 <input type="hidden" name="MallReserved3"   value="<%=MallReserved3%>">
				 <input type="hidden" name="MallReserved4"   value="<%=MallReserved4%>">
				 <input type="hidden" name="MallReserved5"   value="<%=MallReserved5%>">
				 <input type="hidden" name="MallReserved6"   value="<%=MallReserved6%>">
				 <input type="hidden" name="MallReserved7"   value="<%=MallReserved7%>">
				 <input type="hidden" name="MallReserved8"   value="<%=MallReserved8%>">
				 <input type="hidden" name="MallReserved9"   value="<%=MallReserved9%>">
				 <input type="hidden" name="MallReserved10"  value="<%=MallReserved10%>">
         <input type="hidden" name="ErrorCode" value="<%=resErrorCD%>">
         <input type="hidden" name="ErrorMsg" value="<%=resErrorMSG%>">
         <input type="hidden" name="BuyerAuthNum" value="<%=BuyerAuthNum%>">
         <input type="hidden" name="SUB_ID" value="<%=SUB_ID%>">
         <input type="hidden" name="GoodsCl" value="<%=GoodsCl%>">
         
</form>
<form name="tranMgr"  method="post">
    <input type="hidden" name="PayMethod"       value="<%=PayMethod%>">
	<input type="hidden" name="TID"             value="<%=TID%>">
	<input type="hidden" name="payType"         value="<%=payType%>">
	<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>">
	<input type="hidden" name="GoodsName"       value="<%=GoodsName%>">
	<input type="hidden" name="GoodsURL"        value="<%=GoodsURL%>">
	<input type="hidden" name="GoodsCl"        value="<%=GoodsCl%>">
	<input type="hidden" name="Amt"             value="<%=Amt%>">
	<input type="hidden" name="Moid"            value="<%=Moid%>">
	<input type="hidden" name="MID"             value="<%=MID%>">
	<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>">
	<input type="hidden" name="ResultYN"        value="<%=ResultYN%>">
	<input type="hidden" name="RetryURL"        value="<%=RetryURL%>">
	<input type="hidden" name="mallUserID"      value="<%=mallUserID%>">
	<input type="hidden" name="BuyerAuthNum"    value="<%=BuyerAuthNum%>">
	<input type="hidden" name="BuyerTel"        value="<%=BuyerTel%>">
	<input type="hidden" name="BuyerName"       value="<%=BuyerName%>">
	<input type="hidden" name="BuyerEmail"      value="<%=BuyerEmail%>">
	<input type="hidden" name="BuyerAddr"       value="<%=BuyerAddr%>">
	<input type="hidden" name="BuyerPostNo"     value="<%=BuyerPostNo%>">
	<input type="hidden" name="ParentEmail"     value="<%=ParentEmail%>">
	<input type="hidden" name="UserIP"          value="<%=UserIP%>">
	<input type="hidden" name="MallIP"          value="<%=MallIP%>">
	<input type="hidden" name="BrowserType"     value="<%=BrowserType%>">
	<input type="hidden" name="VbankExpDate"    value="<%=VbankExpDate%>">
	<input type="hidden" name="MallReserved"    value="<%=MallReserved%>">
	<input type="hidden" name="MallReserved1"   value="<%=MallReserved1%>">
	<input type="hidden" name="MallReserved2"   value="<%=MallReserved2%>">
	<input type="hidden" name="MallReserved3"   value="<%=MallReserved3%>">
	<input type="hidden" name="MallReserved4"   value="<%=MallReserved4%>">
	<input type="hidden" name="MallReserved5"   value="<%=MallReserved5%>">
	<input type="hidden" name="MallReserved6"   value="<%=MallReserved6%>">
	<input type="hidden" name="MallReserved7"   value="<%=MallReserved7%>">
	<input type="hidden" name="MallReserved8"   value="<%=MallReserved8%>">
	<input type="hidden" name="MallReserved9"   value="<%=MallReserved9%>">
	<input type="hidden" name="MallReserved10"  value="<%=MallReserved10%>">
	<input type="hidden" name="MallResultFWD"   value="<%=MallResultFWD%>">
	<input type=hidden name="TransType" value="<%=TransType%>">
	<input type="hidden" name="SUB_ID"   value="<%=SUB_ID%>">
	
	
	<input type="hidden" name="Carrier"        value="<%=Carrier%>">
	
	<input type="hidden" name="DstAddr0"        value="<%=DstAddr0%>">
	<input type="hidden" name="DstAddr1"        value="<%=DstAddr1%>">
	<input type="hidden" name="DstAddr2"        value="<%=DstAddr2%>">
	<input type="hidden" name="Iden0"        value="<%=Iden0%>">
	<input type="hidden" name="Iden1"        value="<%=Iden1%>">
	<input type="hidden" name="OTP"        value="<%=OTP%>">

	
	<input type="hidden" name="resAuthDate" value="">
	<input type="hidden" name="resResultCode" value="">
	<input type="hidden" name="resResultMsg" value="">
	 <input type="hidden" name="resAuthCode" value="">
	</form>
<%
	if(MallResultFWD.equals("Y")){
%>
	 <script language="javascript">
      document.returnMgr.target="payWindow";
      document.returnMgr.action="<%=ReturnURL%>";
      document.returnMgr.submit();
    </script>

<%	
	}else{
		if( ResultYN.equals("N") ) { // 결제 결과창 안보이기
%>
		 <script>
		 window.close();
		 </script>
<%			
		}else{
	
			if(resResultCode.equals("A000")){
%>
		    	<script language="javascript">
				document.tranMgr.resAuthDate.value = "<%=resAuthDate%>";
				document.tranMgr.resResultCode.value = "<%=resResultCode%>";
				document.tranMgr.resResultMsg.value = "<%=resResultMsg%>";
				document.tranMgr.resAuthCode.value = "<%=resAuthCode%>";
		    	document.tranMgr.action = "payResult.jsp";
		    	document.tranMgr.submit();
		    	</script>

<% 
			}else{ 
%>
    			<script language="javascript">
    			document.tranMgr.resAuthDate.value = "<%=resAuthDate%>";
				document.tranMgr.resResultCode.value = "<%=resResultCode%>";
				document.tranMgr.resResultMsg.value = "<%=resResultMsg%>";
				document.tranMgr.resAuthCode.value = "<%=resAuthCode%>";
    			document.tranMgr.action = "payResultFail.jsp";
    			document.tranMgr.submit();
    			</script>

<% 
			}
		}
	}

	
%>



