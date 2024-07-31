<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.mobilians.mc01_v0003.*" %>

<%-- 공통 common include --%>
<%@ include file="../common/ipgwebCommon.jsp" %>


<%
// 상점에서 사용하는 파라미터
String PayMethod	= getDefaultStr(request.getParameter("PayMethod"), CommonConstants.PAY_METHOD_MOBILE);
String payType		= getDefaultStr(request.getParameter("payType"), "");
String GoodsCnt		= getDefaultStr(request.getParameter("GoodsCnt"), "");
String GoodsName	= getDefaultStr(request.getParameter("GoodsName"), "");
String GoodsURL		= getDefaultStr(request.getParameter("GoodsURL"), "");
String GoodsCl		= getDefaultStr(request.getParameter("GoodsCl"), "");
String Amt			= getDefaultStr(request.getParameter("Amt"), "");	
String Moid			= getDefaultStr(request.getParameter("Moid"), "");
String MID			= getDefaultStr(request.getParameter("MID"), "");
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
String MallResultFWD = getDefaultStr(request.getParameter("MallResultFWD"), "");
String TID = getDefaultStr(request.getParameter("TID"), "");
String TransType = getDefaultStr(request.getParameter("TransType"), "");
String SUB_ID = getDefaultStr(request.getParameter("SUB_ID"), "");

String Carrier = getDefaultStr(request.getParameter("Carrier"), "");


String DstAddr0 = getDefaultStr(request.getParameter("DstAddr0"), "");
String DstAddr1 = getDefaultStr(request.getParameter("DstAddr1"), "");
String DstAddr2 = getDefaultStr(request.getParameter("DstAddr2"), "");



String Iden0 = getDefaultStr(request.getParameter("Iden0"), "");
String Iden1 = getDefaultStr(request.getParameter("Iden1"), "");


String CPID = getDefaultStr(request.getParameter("CPID"), "");
String MOBRecordKey = getDefaultStr(request.getParameter("MOB_RecordKey"), "");
String MOBMrchID = getDefaultStr(request.getParameter("MOB_MrchID"), "");
String MOBMode = getDefaultStr(request.getParameter("MOB_Mode"), "");

String smsOTP = "";
String EmailFlag = "N";
String Item = "";
String Phoneid = "";

// 모빌리언스랑 SMS인증 요청
McashManager mm = new McashManager();
AckParam ap = mm.McashApprv( MOBMode,     MOBRecordKey,    MOBMrchID,    CPID,    (DstAddr0+DstAddr1+DstAddr2),
                               (Iden0+Iden1), BuyerAuthNum, mallUserID,    BuyerName, BuyerEmail,
                               Phoneid,  TID,     Moid,    GoodsName,   Amt,
                               smsOTP,   Carrier,     EmailFlag, Item , "", "", "","EUC-KR"  );


String gRemainamt = "";


if(ap == null){
	throw new Exception("W050"); 
}
System.out.println("=========ap.getPhoneid()["+ap.getPhoneid()+"]");
if(!StringUtils.equals(Common.RTN_OK,ap.getResultcd())){ //실패
	String errorCode = ap.getResultcd();
	String errorMsg = ap.getResultmsg();

	
%>

<form name="errorMgr" method="post" action="mobileError.jsp">
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
	<input type="hidden" name="MallResultFWD"   value="<%=MallResultFWD%>">
	<input type="hidden" name="ErrorCode"       value="<%=errorCode%>">
	<input type="hidden" name="ErrorMsg"        value="<%=errorMsg%>">
	<input type=hidden name="TransType" value="<%=TransType%>">
	<input type="hidden" name="SUB_ID"        value="<%=SUB_ID%>">
	
	<input type="hidden" name="Carrier"        value="<%=Carrier%>">
	<input type="hidden" name="DstAddr0"        value="<%=DstAddr0%>">
	<input type="hidden" name="DstAddr1"        value="<%=DstAddr1%>">
	<input type="hidden" name="DstAddr2"        value="<%=DstAddr2%>">
	<input type="hidden" name="Iden0"        value="<%=Iden0%>">
	<input type="hidden" name="Iden1"        value="<%=Iden1%>">
	<input type="hidden" name="CPID"            value="<%=CPID%>">
	<input type="hidden" name="MOB_RecordKey" value="<%=MOBRecordKey%>">
	<input type="hidden" name="MOB_MrchID" value="<%=MOBMrchID%>">
	<input type="hidden" name="MOB_PhoneID" value="<%=ap.getPhoneid()%>">
	
	
</form>
<script language="javascript">
   document.errorMgr.submit();
</script>
<%
}else{	//정상
	String errorCode = ap.getResultcd();
	String errorMsg = ap.getResultmsg();
  if(  ap.getSmsval().equals("      ") && ap.getSmsval().length() == 6 ){ 
	
	 gRemainamt = ap.getRemainamt();
  
  }

%>




	
	<script language="javascript">
	  function goNext(){
		if(document.transMgr.OTP.value.length!=6) {
			alert("승인번호는 6자리입니다.");
			document.transMgr.OTP.focus();
			return;
		}
		document.transMgr.action = "payConfirm.jsp";
		document.transMgr.submit();
	  }

	  function goCancel(){
	    window.close();
	  }

	 
	  
	</script>

<%@include file="../common/left.jsp" %>
<form name="transMgr" method="post">
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
	<input type="hidden" name="MallResultFWD"   value="<%=MallResultFWD%>">
	<input type="hidden" name="ErrorCode"       value="<%=errorCode%>">
	<input type="hidden" name="ErrorMsg"        value="<%=errorMsg%>">
	<input type="hidden" name="SUB_ID"        value="<%=SUB_ID%>">
	
	<input type="hidden" name="Carrier"        value="<%=Carrier%>">

	<input type="hidden" name="DstAddr0"        value="<%=DstAddr0%>">
	<input type="hidden" name="DstAddr1"        value="<%=DstAddr1%>">
	<input type="hidden" name="DstAddr2"        value="<%=DstAddr2%>">
	<input type="hidden" name="Iden0"        value="<%=Iden0%>">
	<input type="hidden" name="Iden1"        value="<%=Iden1%>">
	<input type="hidden" name="CAP"        value="<%=gRemainamt%>">
	<input type="hidden" name="CPID"            value="<%=CPID%>">
	<input type="hidden" name="MOB_RecordKey" value="<%=MOBRecordKey%>">
	<input type="hidden" name="MOB_MrchID" value="<%=MOBMrchID%>">
	<input type="hidden" name="MOB_PhoneID" value="<%=ap.getPhoneid()%>">

            <tr>
              <td width="134" align="center">&nbsp;</td>
              <td width="323" align="right" valign="top"><table border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="20" valign="middle" class="step2">정보입력 <img src="../images/step_next.gif" /></td>
                  <td height="20" valign="middle" class="step">인증 <img src="../images/step_next02.gif" /></td>
                  <td height="20" valign="middle" class="step2">정보확인 <img src="../images/step_next.gif" /></td>
                  <td height="20" valign="middle" class="step2">결제완료</td>
                </tr>
              </table></td>
              <td width="30">&nbsp;</td>
            </tr>
          </table></td>
        </tr>
        <tr>	
				<%-- 서브탭 --%>
				<%@ include file="../common/subTab.jsp" %>

          <td><table width="0" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td valign="top" background="../images/copy.gif"><img src="../images/copy.gif" width="20" height="498" /></td>
              <td valign="top"><table width="0" border="0" cellspacing="0" cellpadding="0">
              	<tr>
                  <td width="356" height="24" background="../images/copy_08.gif">
                  	<div class="event" align="center"><%=noticeContents %></div></td>
                </tr>
                <tr>
                  <td width="356" height="464" align="center" valign="top"><table width="343" cellpadding="0" cellspacing="0" class="pay_layout">
                    <tr>
                      <td height="6"></td>
                    </tr>
                    <tr>
                      <td height="5" align="center" valign="middle" bgcolor="#e7e7e7"></td>
                    </tr>
                    <tr>
                      <td height="50" align="center" valign="middle" background="../images/bg07.gif"><table cellpadding="3" cellspacing="0" bordercolor="#CCCCCC" class="pay_layout">
                        <tr>
                          <td><img src="../images/box_naming.gif" /></td>
                          <td><div class="boxnaming"><%=GoodsName%></div></td>
                        </tr>
                        <tr>
                          <td><img src="../images/box_price.gif" /></td>
                          <td><div class="boxprice"><%=setComma(Amt)%><img src="../images/box_unit.gif" /></div></td>
                        </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td height="5" align="center" valign="middle" bgcolor="#e7e7e7"></td>
                    </tr>
                    <tr>
                      <td height="9"></td>
                    </tr>
                    <tr>
                      <td align="left"><img src="../images/box_select03.gif" /></td>
                    </tr>
                    <tr>
                      <td valign="top"><table width="343" border="0" align="left" cellpadding="0" cellspacing="0">
                        <tr>
                          <td height="10"></td>
                        </tr>
											  <tr>
											    <td align="left"><img src="../images/box_subtitle04.gif" /></td>
											  </tr>
											  <tr>
											    <td height="5"></td>
											  </tr>
											  <tr>
											    <td><table width="337" border="0" align="center" cellpadding="0" cellspacing="0">
											      <tr>
											        <td width="93" height="31" align="center" background="../images/box_table_top.gif"><img src="../images/box_table05_01.gif"/></td>
											        <td width="240" height="27" align="left" background="../images/box_table2_top.gif" class="boxbody" ><%=setComma(String.valueOf(Integer.parseInt(gRemainamt)))%>원</td>
											      </tr>
											      <tr>
											        <td height="30" align="center" background="../images/box_table_foot.gif"><img src="../images/box_table05_02.gif"/></td>
											        <td height="27" align="left" background="../images/box_table2_foot.gif" class="boxbody"><input type="text" class="input02" name="OTP" maxlength="6"></td>
											      </tr>
											    </table></td>
											  </tr>
											  <tr>
											    <td height="16"></td>
											  </tr>
											  <tr>
											    <td align="left"><img src="../images/box_notice6.gif" /></td>
											  </tr>
											  <tr>
											    <td height="35"></td>
											  </tr>
											  <tr>
											    <td><table align="center" cellpadding="0" cellspacing="0" class="pay_layout">
											      <tr>
											        <td><img src="../images/nextbt.gif" border="0"  onclick="javascript:goNext()"/></td>
											        <td><img src="../images/cancelbt.gif" border="0"  onclick="javascript:goCancel()"/></td>
											      </tr>
											    </table></td>
											  </tr>
                      </table></td>
                    </tr>
                  </table></td>
                </tr>
              </table></td>
              <td valign="top" background="../images/copy_line2.gif"><img src="../images/copy_09.gif" width="28" height="478" /></td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td><img src="../images/copy_11.gif" width="404" height="21" /></td>
        </tr>
        <tr>
          <td colspan="2"><img src="../images/foot_ver2.gif" width="545" height="17" /></td>
        </tr>
      </table></td>				

</form> 
<%@include file="../common/right.jsp" %>
<%
}
%>
					