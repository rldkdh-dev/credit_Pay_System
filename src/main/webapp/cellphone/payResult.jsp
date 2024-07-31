<%@ page contentType="text/html; charset=euc-kr"%>

<%-- 공통 common include --%>
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
	String TID          = getDefaultStr(request.getParameter("TID"), "");
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
	String resResultCode = getDefaultStr(request.getParameter("resResultCode"), "");
	String resResultMsg = getDefaultStr(request.getParameter("resResultMsg"), "");
	String resAuthCode  = getDefaultStr(request.getParameter("resAuthCode"), "");
	String carrier = getDefaultStr(request.getParameter("Carrier"), "");
	String serverInfo = getDefaultStr(request.getParameter("ServerInfo"), "");
	String resAuthDate = getDefaultStr(request.getParameter("resAuthDate"), "");
	String DstAddr0 = getDefaultStr(request.getParameter("DstAddr0"), "");
	String DstAddr1 = getDefaultStr(request.getParameter("DstAddr1"), "");
	String DstAddr2 = getDefaultStr(request.getParameter("DstAddr2"), "");
	
	String Iden0 = getDefaultStr(request.getParameter("Iden0"), "");
	String Iden1 = getDefaultStr(request.getParameter("Iden1"), "");
	
	String OTP = getDefaultStr(request.getParameter("OTP"), "");
	String EncodeTID = getDefaultStr(request.getParameter("EncodeTID"), "");

	String cssStr = "";
	String disAuthDate = "";
	
	
	Box req = new Box();
	Box resMemberInfo = null;

	req.put("mid", MID);
	resMemberInfo = CommonBiz.getMemberInfo(req);
	if(resMemberInfo == null ) {        
        throw new Exception("W006"); // 상점정보가 없습니다.       
    }

	//휴대폰결제정보 
	Box resTransInfo = null;
	req.put("mid" , MID);
	req.put("tid", TID);
	
	//System.out.println("mobile payResult req["+req+"]");
	
	resTransInfo = CommonBiz.getMobileTransInfo(req);
	//System.out.println("resTransInfo["+resTransInfo+"]");
	if(resTransInfo == null ) {        
        throw new Exception("W002"); // TID가 유효하지 않습니다.       
    } else {
    	String app_dt = resTransInfo.getString("app_dt"); // 승인일
        String app_tm = resTransInfo.getString("app_tm"); // 승인시
    	    	   
		String appYY = app_dt.substring(0, 4); // 년
		String appMM = app_dt.substring(4, 6); // 월
		String appDD = app_dt.substring(6, 8); // 일
		String disYYMMDD = appYY + "/" + appMM + "/" + appDD;
		String appHH = app_tm.substring(0, 2); // 시
		String appmm = app_tm.substring(2, 4); // 분
		String appss = app_tm.substring(4, 6); // 초
		String disHHmmss = appHH + ":" + appmm + ":" + appss;
		disAuthDate = disYYMMDD + " " + disHHmmss; // 승인일시		    	   
    }
	
	String systemMode = System.getProperty("SYSTEM_MODE");
	
%>
<%@ include file="../common/left.jsp" %>
<script language="javascript">
<!--
window.attachEvent("onbeforeunload",fn_UnLoad);

function fn_UnLoad() {
 if(event.clientY < 0) {
	 goClose();
 }
}

var flag = true;

<%-- 확인페이지 --%>
function goReceipt() {
	var f = document.tranMgr;
	var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=414,height=622";
	window.open("about:blank","popupIssue",status);
	f.target = "popupIssue";
<%if("TEST".equals(systemMode)){  // TEST 시스템 URL%>
    	f.action = "http://test.nicepay.co.kr:8012/issue/IssueLoader.jsp?TID=<%=TID%>&type=0";
<%}else if("REAL".equals(systemMode)){  // REAL 시스템URL%>
	f.action = "https://pg.nicepay.co.kr/issue/IssueLoader.jsp?TID=<%=TID%>&type=0";
<%}%>
	f.submit();
	return false;
}

<%-- 결과 페이지 --%>
function goClose() {
	if (flag == true) {
		flag = false;

	    document.returnMgr.action = "<%=ReturnURL%>";
	    //var returnWindow = openWindow('', 'yes', 'yes', '545', '400','returnWindow', '150', '150');
	    //document.returnMgr.target = "payFrame";
	    document.returnMgr.target = "payWindow";
	    document.returnMgr.submit();	
	}
	//return false;
}

<%-- 취소하기 --%>
function goCancel() {
	var bodyElements = document.getElementsByTagName("body");
	var body = bodyElements[0];
	body.setAttribute("onbeforeunload","");
    document.cancelMgr.action = "../mainCancelPay.jsp";
    document.cancelMgr.submit();
    return false;
}
-->
</script>


<form name="returnMgr" method="post" action="">
<input type="hidden" name="PayMethod"			value="<%=PayMethod%>">
<input type="hidden" name="TID"                 value="<%=TID%>">
<input type="hidden" name="MID"					value="<%=MID%>">
<input type="hidden" name="Amt"					value="<%=Amt%>">
<input type="hidden" name="name"			value="<%=BuyerName%>">
<input type="hidden" name="mallUserID"          value="<%=mallUserID%>">
<input type="hidden" name="BuyerEmail"          value="<%=BuyerEmail%>">
<input type="hidden" name="GoodsName"			value="<%=GoodsName%>">
<input type="hidden" name="OID"					value="<%=Moid%>">
<input type="hidden" name="AuthDate"			value="<%=resAuthDate%>">
<input type="hidden" name="AuthCode"			value="<%=resAuthCode%>">
<input type="hidden" name="SUB_ID"			value="<%=SUB_ID%>">

<input type="hidden" name="ResultCode"			value="<%=resResultCode%>">
<input type="hidden" name="ResultMsg"			value="<%=resResultMsg%>">
<input type="hidden" name="MallReserved"        value="<%=MallReserved%>">
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
 <input type="hidden" name="BuyerAuthNum" value="<%=BuyerAuthNum%>">
 <input type=hidden name="TransType" value="<%=TransType%>">
</form>

<form name="tranMgr" method="post" action="" >
<input type="hidden" name="disAuthDate"			value="<%=disAuthDate%>">
<input type="hidden" name="GoodsName"			value="<%=GoodsName%>">
<input type="hidden" name="BuyerName"			value="<%=BuyerName%>">
<input type="hidden" name="mallUserID"          value="<%=mallUserID%>">
<input type="hidden" name="BuyerEmail"          value="<%=BuyerEmail%>">
<input type="hidden" name="Moid"				value="<%=Moid%>">
<input type="hidden" name="MID"                 value="<%=MID%>">
<input type="hidden" name="TID"                 value="<%=TID%>">
<input type="hidden" name="SUB_ID"                 value="<%=SUB_ID%>">
<input type="hidden" name="type"                value="0">
<input type="hidden" name="Amt"					value="<%=Amt%>">
<input type="hidden" name="ord_soc_no"			value="<%=getDefaultStr(resTransInfo.getString("soc_no") , "")%>">
<input type="hidden" name="cc_dt"				value="<%=getDefaultStr(resTransInfo.getString("cc_dt") , "")%>">
<input type="hidden" name="cc_tm"				value="<%=getDefaultStr(resTransInfo.getString("cc_tm") , "")%>">
<input type="hidden" name="app_no"				value="<%=getDefaultStr(resTransInfo.getString("app_no") , "")%>">

            <tr>
              <td width="134" align="center">&nbsp;</td>
              <td width="323" align="right" valign="top"><table border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="20" valign="middle" class="step2">정보입력 <img src="../images/step_next.gif" /></td>
                  <td height="20" valign="middle" class="step2">인증 <img src="../images/step_next.gif" /></td>
                  <td height="20" valign="middle" class="step2">정보확인 <img src="../images/step_next.gif" /></td>
                  <td height="20" valign="middle" class="step">결제완료</td>
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
                  <td width="356" height="464" align="center" valign="top"><table width="343" border="0" align="left" cellpadding="0" cellspacing="0">
                    <tr class="pay_layout">
                      <td><img src="../images/box_notice3_2.gif" /></td>
                    </tr>
                    <tr>
                      <td><table width="337" border="0" align="center" cellpadding="0" cellspacing="0">
                      	<tr>
                          <td width="93" height="31" align="center" background="../images/box_table_top.gif"><img src="../images/box_table11_09.gif" alt=""/></td>
                          <td width="240" height="27" background="../images/box_table2_top.gif" class="boxbody" >휴대폰결제</td>
                        </tr>                    
                        <tr>
                          <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table04_02.gif"/></td>
                          <td height="27" background="../images/box_table2_bg.gif" class="boxbody"><%=DstAddr0%>-<%=DstAddr1%>-<%=DstAddr2%></td>
                        </tr>
                        <tr>
                          <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table07_02.gif"/></td>
                          <td height="27" background="../images/box_table2_bg.gif" class="boxbody"><%=disAuthDate%></td>
                        </tr>
                        <tr>
                          <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table11_03.gif" alt=""/></td>
                          <td height="27" background="../images/box_table2_bg.gif" class="boxbody"><%=setComma(Amt)%>원</td>
                        </tr>
                        <tr>
                          <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table11_04.gif" alt=""/></td>
                          <td height="27" background="../images/box_table2_bg.gif" class="boxbody"><%=resMemberInfo.getString("co_nm")%></td>
                        </tr>
                        <tr>
                          <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table11_06.gif" alt=""/></td>
                          <td height="27" background="../images/box_table2_bg.gif" class="boxbody"><%=GoodsName%></td>
                        </tr>
                        <tr>
                          <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table11_05.gif" alt=""/></td>
                          <td height="27" background="../images/box_table2_bg.gif" class="boxbody"><%=BuyerName%></td>
                        </tr>
                        <tr>
                          <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table11_07.gif" alt=""/></td>
                          <td height="27" background="../images/box_table2_bg.gif" class="boxbody"><%=BuyerEmail.equals("") ? "&nbsp;" : BuyerEmail%></td>
                        </tr>  
                        <tr>
                          <td height="30" align="center" background="../images/box_table_foot.gif"><img src="../images/box_table02_06.gif" alt=""/></td>
                          <td height="27" background="../images/box_table2_foot.gif" class="boxbody"><%=TID%></td>
                        </tr>                       
                      </table></td>
                    </tr>
                    <tr>
                      <td height="35"></td>
                    </tr>
                    <tr>
                      <td><table align="center" cellpadding="0" cellspacing="0" class="pay_layout">
                        <tr>
                          <td><img src="../images/closebt.gif" border="0" onClick="return goClose();"/></td>
                          <td><img src="../images/receiptbt.gif" border="0" onClick="return goReceipt();"/></td>
<%
    // for only home page demo web application
    if(MID.equals("nicepay01m")) {
%>                          
                          <td><img src="../images/cancelbt.gif" border="0" onClick="return goCancel();"/></td>
<%
    }
%>                          
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

<form name="cancelMgr" method="post">
    <input type="hidden" name="TID"         value="<%=TID%>">
    <input type="hidden" name="MID"         value="<%=MID%>">
    <input type="hidden" name="PayMethod"   value="<%=PayMethod%>">
    <input type="hidden" name="CancelAmt"   value="<%=Amt%>">
</form>

<%@include file="../common/right.jsp" %>
