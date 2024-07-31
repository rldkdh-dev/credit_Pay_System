<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 결제결과실패페이지
*	@ PROGRAM NAME		: payResultFail.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2009.03.17
*	@ PROGRAM CONTENTS	: 결제결과실패페이지
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*******************************************************************************/
%>
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
	String TID = getDefaultStr(request.getParameter("TID"), "");
	String SUB_ID = getDefaultStr(request.getParameter("SUB_ID"), "");
	
	String carrier = getDefaultStr(request.getParameter("Carrier"), "");
	String serverInfo = getDefaultStr(request.getParameter("ServerInfo"), "");
	
	String DstAddr0 = getDefaultStr(request.getParameter("DstAddr0"), "");
	String DstAddr1 = getDefaultStr(request.getParameter("DstAddr1"), "");
	String DstAddr2 = getDefaultStr(request.getParameter("DstAddr2"), "");
	
	String Iden0 = getDefaultStr(request.getParameter("Iden0"), "");
	String Iden1 = getDefaultStr(request.getParameter("Iden1"), "");
	
	String OTP = getDefaultStr(request.getParameter("OTP"), "");
	String EncodeTID = getDefaultStr(request.getParameter("EncodeTID"), "");

	String cssStr = "";
    
	String resultCode = "";
	String resultMsg = "";
	
	String resAuthDate		= getDefaultStr(request.getParameter("resAuthDate"), "");
	String resErrorCD		= getDefaultStr(request.getParameter("resErrorCD"), "");
	String resErrorMSG		= getDefaultStr(request.getParameter("resErrorMSG"), "");
	String resResultCode	= getDefaultStr(request.getParameter("resResultCode"), "");
	String resResultMsg		= getDefaultStr(request.getParameter("resResultMsg"), "");
	
	
	Box req = new Box();
	Box resMemberInfo = null;
	Box resTransInfo = null;

	req.put("mid", MID);
	resMemberInfo = CommonBiz.getMemberInfo(req);
	if(resMemberInfo == null ) {        
       throw new Exception("W006"); // 상점정보가 없습니다.       
  }
	
	
	 resultCode = resResultCode.length() > 0 ? resResultCode.trim() : "9999";
	 resultMsg = resResultMsg.length() > 0 ? resResultMsg.trim() : "알수없는 오류";
	 
	 if(resErrorCD != null && !resErrorCD.equals("")){
		resultCode = resErrorCD;
		resultMsg = resErrorMSG;					
	}
	

%>
<%@ include file="../common/left.jsp" %>
<script language="javascript">
<!--

<%-- 취소 --%>
function goClose() {
	window.close();
}
-->
</script>


	            <tr>
	              <td width="134" align="center">&nbsp;</td>
	              <td width="323" align="right" valign="top"><table border="0" cellpadding="0" cellspacing="0">
	                <tr>
	                  <td height="20" valign="middle" class="step2">정보입력 <img src="../images/step_next.gif" /></td>
                  <td height="20" valign="middle" class="step2">인증 <img src="../images/step_next.gif" /></td>
                  <td height="20" valign="middle" class="step2">정보확인 <img src="../images/step_next.gif" /></td>
                  <td height="20" valign="middle" class="step">결제실패</td>
	                </tr>
	              </table></td>
	              <td width="30">&nbsp;</td>
	            </tr>
	          </table>
	        </td>
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
                  <td width="356" height="464" align="center" valign="top">
                  <table width="343" border="0" align="left" cellpadding="0" cellspacing="0">
									  <tr class="pay_layout">
									    <td><img src="../images/box_notice3_3.gif" /></td>
									  </tr>
									  <tr>
									    <td><table width="337" border="0" align="center" cellpadding="0" cellspacing="0">
									    	<tr>
									        <td width="93" height="31" align="center" background="../images/box_table_top.gif"><img src="../images/box_table11_09.gif" width="61" height="13" /></td>
									        <td width="240" height="27" background="../images/box_table2_top.gif" class="boxbody" >휴대폰 결제</td>
									      </tr>									      
									      <tr>
									        <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table11_02.gif" width="61" height="13" /></td>
									        <td height="27" background="../images/box_table2_bg.gif" class="boxbody"><%="[" + resultCode + "]:" + resultMsg %></td>
									      </tr>
									      <tr>
									        <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table11_03.gif" width="61" height="13" /></td>
									        <td height="27" background="../images/box_table2_bg.gif" class="boxbody"><%=setComma(Amt)%>원</td>
									      </tr>
									      <tr>
									        <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table11_04.gif" width="61" height="13" /></td>
									        <td height="27" background="../images/box_table2_bg.gif" class="boxbody"><%=resMemberInfo.getString("co_nm")%></td>
									      </tr>
									      <tr>
									        <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table11_06.gif" width="61" height="13" /></td>
									        <td height="27" background="../images/box_table2_bg.gif" class="boxbody"><%=GoodsName%></td>
									      </tr>
									      <tr>
									        <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table11_05.gif" width="61" height="13" /></td>
									        <td height="27" background="../images/box_table2_bg.gif" class="boxbody"><%=BuyerName%></td>
									      </tr>									      
									      <tr>
									        <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table11_07.gif" width="67" height="13" /></td>
									        <td height="27" background="../images/box_table2_bg.gif" class="boxbody"><%=BuyerEmail.equals("") ? "&nbsp;" : BuyerEmail%></td>
									      </tr>	
									      <tr>
									        <td height="30" align="center" background="../images/box_table_foot.gif"><img src="../images/box_table02_06.gif" width="57" height="13" /></td>
									        <td height="27" background="../images/box_table2_foot.gif" class="boxbody"><%=TID%></td>
									      </tr>
									      <tr>
													<td height="27" colspan="2"  class="boxbody">※결제가 실패되었습니다. 다시 시도해 주시기 바랍니다</td>
												</tr>	
									    </table></td>
									    
									  </tr>
									  <tr>
									    <td height="35"></td>
									  </tr>
									  <tr>
									    <td><table align="center" cellpadding="0" cellspacing="0" class="pay_layout">
									      <tr>
									        <td><img src="../images/closebt.gif" border="0" onClick="return goClose()" /></td>
									        </tr>
									    </table></td>
									  </tr>
									</table>
									</td>
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
      
<%@include file="../common/right.jsp" %>

