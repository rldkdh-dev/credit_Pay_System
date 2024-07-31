<%@ page contentType="text/html; charset=euc-kr"%>
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
		String SUB_ID = getDefaultStr(request.getParameter("SUB_ID"), "");
		
		String TID = KeyUtils.genTID(MID, CommonConstants.SVC_CD_CELLPHONE, CommonConstants.SVC_PRDT_CD_ONLINE);
		
		
		//주문번호 특수문자 체크
		if(isSpecialChar(Moid)) {
			throw new Exception("W001"); // 주문번호가 유효하지 않습니다.
		}
		
		Box req = new Box();
		Box resMemberInfo = null;
		req.put("mid", MID);
		resMemberInfo = CommonBiz.getMemberInfo(req);



		String cpSlidingCl = resMemberInfo.getString("cp_sliding_cl");
		// 상품가격 500원 미만 오류 처리
		
		if(StringUtils.equals("1",cpSlidingCl)){
			if(Integer.parseInt(Amt.equals("")?"0":Amt) < 500){
				throw new Exception("W051"); // 500원 미만 결제불가
			}
		}
		
		
        
		// CPID 조회
        Box box = new Box();
        box.put("mid",MID);
		box.put("svc_cd",CommonConstants.SVC_CD_CELLPHONE);
		box.put("svc_prdt_cd",CommonConstants.SVC_PRDT_CD_ONLINE);
		box.put("goods_cl",GoodsCl);
		box.put("today",TimeUtils.getyyyyMMdd());	
		System.out.println("-------------------GoodsCl ["+GoodsCl+"]");

		
		List<Box> cpidList = CommonBiz.selectCPIDGoodsCl(box);
		if(cpidList == null || cpidList.size() == 0 ){
		  throw new Exception("W053");
		}

		Box cpidBox = cpidList.get(0);
		String fn_id = cpidBox.getString("fn_id");
		System.out.println("-------------------fn_id ["+fn_id+"]");
		String mobMerchantId = fn_id.substring(0,8);
		String mid_url = resMemberInfo.getString("mid_url");

		


%>

<script language="javascript">

  function goNext(){
	  var fm = document.tranMgr;

	  if(fm.DstAddr0.value == ""){
	    	alert("결제할 전화번호를 확인하세요.");
	    	fm.DstAddr0.focus();	
		    return ;
		}
	    
		if ( StrLen(fm.DstAddr1.value) != 3 && StrLen(fm.DstAddr1.value) != 4 ) {
			alert("결제할 전화번호를 확인하세요.");
			fm.DstAddr1.focus();		
			return;
		}
		if ( StrLen(fm.DstAddr2.value) != 4 ) {
			alert("결제할 전화번호를 확인하세요.");
			fm.DstAddr2.focus();	
			return;
		}
		if ( StrLen(fm.Iden0.value) < 6 ) {
			alert("주민등록 번호를 확인 하세요.");
			fm.Iden0.focus();
			return; 
		} 
		if ( StrLen(fm.Iden1.value) < 7 ) {
			alert("주민등록 번호를 확인 하세요.");
			fm.Iden1.focus();
			return;
		}	  
		if ( Jumin_chk(fm.Iden0.value+fm.Iden1.value) ) {
			alert("주민등록 번호를 확인 하세요.");
			fm.Iden0.focus();
			return;
		}	  
		fm.action = "inputMobileAuthSms.jsp";
		fm.submit();
  }

  function goCancel(){
    window.close();
  }

  function SCarrier(car) {
			switch( car ) {
			case "011" :
			case "017" :
				document.tranMgr.Carrier.value="SKT";
				document.tranMgr.Carrier1.checked = true;
				document.tranMgr.Carrier6.checked = false;
				document.tranMgr.Carrier9.checked = false;
				break;
			case "016" :
			case "018" :
				document.tranMgr.Carrier.value="KTF";
				document.tranMgr.Carrier1.checked = false;
				document.tranMgr.Carrier6.checked = true;
				document.tranMgr.Carrier9.checked = false;
				break;
			case "019" :
				document.tranMgr.Carrier.value="LG U+";
				document.tranMgr.Carrier1.checked = false;
				document.tranMgr.Carrier6.checked = false;
				document.tranMgr.Carrier9.checked = true;
				break;
			}
  }

  function SCarrier2(car) {
	 
	if(!document.tranMgr.Carrier1.checked && !document.tranMgr.Carrier6.checked && !document.tranMgr.Carrier9.checked){
		switch( car ) {
		case "011" :
		case "017" :
			document.tranMgr.Carrier.value="SKT";
			document.tranMgr.Carrier1.checked = true;
			document.tranMgr.Carrier6.checked = false;
			document.tranMgr.Carrier9.checked = false;
			break;
		case "016" :
		case "018" :
			document.tranMgr.Carrier.value="KTF";
			document.tranMgr.Carrier1.checked = false;
			document.tranMgr.Carrier6.checked = true;
			document.tranMgr.Carrier9.checked = false;
			break;
		case "019" :
			document.tranMgr.Carrier.value="LG U+";
			document.tranMgr.Carrier1.checked = false;
			document.tranMgr.Carrier6.checked = false;
			document.tranMgr.Carrier9.checked = true;
			break;
		}
	}
		
}

   function StrLen(arg_str) {
		var j = 0;
		var tempStr;
		var tempStr2;
		for(var i = 0; i < arg_str.length; i++ ) {
		 tempStr = arg_str.charCodeAt(i);
		 tempStr2 = tempStr.toString();
		 if(tempStr2.length >= 5) {
			 j++;
		 }
		}
		return i+j;
	}

   function Jumin_chk(it) {
		IDtot = 0;
		IDAdd='234567892345';

		for(i=0;i<12;i++) {
			IDtot=IDtot+parseInt(it.substring(i,i+1))*parseInt(IDAdd.substring(i,i+1));
		}
		IDtot=11-(IDtot%11);

		if(IDtot==10) {
			IDtot=0;
		}
		else if(IDtot==11){
			IDtot=1;
		}
		if(parseInt(it.substring(12,13))!=IDtot) {
			return true;
		} 
	};
  
</script>
<%@include file="../common/left.jsp" %>
<form name="tranMgr" method="post">
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
	<input type="hidden" name="Carrier" value="">
	<input type="hidden" name="EMAIL" value="<%=BuyerEmail%>">
	<input type="hidden" name="CPID" value="<%=fn_id%>">
	<input type="hidden" name="MOB_RecordKey" value="<%=mid_url%>">
	<input type="hidden" name="MOB_MrchID" value="<%=mobMerchantId%>">
	<input type="hidden" name="MOB_Mode" value="04">
	<input type="hidden" name="SUB_ID" value="<%=SUB_ID%>">
	
            <tr>
              <td width="134" align="center">&nbsp;</td>
              <td width="323" align="right" valign="top"><table border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="20" valign="middle" class="step">정보입력 <img src="../images/step_next02.gif" /></td>
                  <td height="20" valign="middle" class="step2">인증 <img src="../images/step_next.gif" /></td>
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
                          <td><div class="boxnaming"><%=GoodsName %></div></td>
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
                              <td width="93" height="31" align="center" background="../images/box_table_top.gif"><img src="../images/box_table04_01.gif"/></td>
                              <td width="240" height="27" align="left" background="../images/box_table2_top.gif" class="boxbody" >
                              	<input type="radio" name="Carrier1" value="" onClick="SCarrier('011');">
                                SKT
                                <input type="radio" name="Carrier6" value="" onClick="SCarrier('016');">
                                KT
                                <input type="radio" name="Carrier9" value="" onClick="SCarrier('019');">
                                LG U+ </td>
                            </tr>
														<tr>
                              <td height="30" align="center" background="../images/box_table_bg.gif"><img src="../images/box_table04_02.gif"/></td>
                              <td height="27" align="left" background="../images/box_table2_bg.gif" class="boxbody">
                              	<select name="DstAddr0"  onChange="JavaScript:SCarrier2(document.tranMgr.DstAddr0.value);">
                                  <option value="" selected>선택</option>
                                  <option value="010">010</option>
                                  <option value="011">011</option>
                                  <option value="016">016</option>
                                  <option value="017">017</option>
                                  <option value="018">018</option>
                                  <option value="019">019</option>
                             		</select>
                                -
                                <input type="text" class="input02" style="width: 35px" name="DstAddr1" size="4" maxlength="4"  onKeyUp="javascript:numOnly(this,document.tranMgr,false); move_focus(this,4,document.tranMgr.DstAddr2)"> -
																<input type="text" class="input02" style="width: 35px" name="DstAddr2" size="4" maxlength="4"  onKeyUp="javascript:numOnly(this,document.tranMgr,false)"></td>
                            </tr>
                            <tr>
                              <td height="30" align="center" background="../images/box_table_foot.gif"><img src="../images/box_table04_03.gif"/></td>
                              <td height="26" align="left" background="../images/box_table2_foot.gif" class="boxbody">
                              <input type="text" class="input02" style="width: 60px" name="Iden0" size="6" maxlength="6" onKeyUp="javascript:numOnly(this,document.tranMgr,false); move_focus(this,6,document.tranMgr.Iden1)"> -
															<input type="password" class="input02" style="width: 60px;height:21px;" name="Iden1" size="7" maxlength="7"></td>
                            </tr>
                          </table></td>
                        </tr>
                        <tr>
                          <td height="16"></td>
                        </tr>
                        <tr>
                          <td><img src="../images/box_notice5.gif" /></td>
                        </tr>
                        <tr>
                          <td height="35"></td>
                        </tr>	
                        <tr>
                          <td><table align="center" cellpadding="0" cellspacing="0" class="pay_layout">
                            <tr>
                              <td><img src="../images/nextbt.gif" border="0" onclick="javascript:goNext();"/></td>
                              <td><img src="../images/cancelbt.gif" border="0" onclick="javascript:goCancel();"/></td>
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