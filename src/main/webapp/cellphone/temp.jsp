<%@ page contentType="text/html; charset=euc-kr"%>
<%@ include file="../common/ipgwebCommon.jsp" %>

<%
		String PayMethod	= getDefaultStr(request.getParameter("PayMethod"), CommonConstants.PAY_METHOD_MOBILE);
		String payType		= getDefaultStr(request.getParameter("payType"), "");
		String skinType		= getDefaultStr(request.getParameter("skinType"), "");
		String GoodsCnt		= getDefaultStr(request.getParameter("GoodsCnt"), "");
		String GoodsName	= getDefaultStr(request.getParameter("GoodsName"), "");
		String GoodsURL		= getDefaultStr(request.getParameter("GoodsURL"), "");
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
		// 상품가격 2000원 미만 오류 처리
		
		if(StringUtils.equals("1",cpSlidingCl)){
			if(Integer.parseInt(Amt.equals("")?"0":Amt) <=2000){
				throw new Exception("W051"); // 2000원 이하 결제불가
			}
		}
		
		
        
		// CPID 조회
        Box box = new Box();
        box.put("mid",MID);
		box.put("svc_cd",CommonConstants.SVC_CD_CELLPHONE);
		box.put("svc_prdt_cd",CommonConstants.SVC_PRDT_CD_ONLINE);
		box.put("today",TimeUtils.getyyyyMMdd());	

		
		List<Box> cpidList = CommonBiz.selectCPID(box);
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
	<input type="hidden" name="skinType"        value="<%=skinType%>">
	<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>">
	<input type="hidden" name="GoodsName"       value="<%=GoodsName%>">
	<input type="hidden" name="GoodsURL"        value="<%=GoodsURL%>">
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
	<input type="hidden" name="Carrier" value="">
	<input type="hidden" name="EMAIL" value="<%=BuyerEmail%>">
	<input type="hidden" name="CPID" value="<%=fn_id%>">
	<input type="hidden" name="MOB_RecordKey" value="<%=mid_url%>">
	<input type="hidden" name="MOB_MrchID" value="<%=mobMerchantId%>">
	<input type="hidden" name="MOB_Mode" value="04">

 <tr>		
    <td height="250" valign="top" class="back02">
		<table style="padding:0 0 0 3" width="410" border="0"  cellpadding="0" cellspacing="0">
			<tr> 
				 <td height="17"></td>
			</tr>
			<tr> 
				  <!--선택경로시작-->
				  <td align="right"><strong>정보입력</strong> → 인증 → 정보확인 → 결제완료&nbsp;</td>
				  <!--선택경로끝-->
			</tr>
			<tr> 
				<td height="15"></td>
			</tr>
			<tr> 
				<td> 
					  <table width="410" border="0" cellspacing="0" cellpadding="0">
						  <tr> 
							<td width="9" height="10" class="img01">&nbsp;</td>
							<td class="font_swtext">휴대폰 정보를 입력하십시오.</td>
						  </tr>
					  </table>
				</td>
            </tr>
			<tr> 
				 <td height="5"></td>
			</tr>
			<tr> 
				<td> 
					<%@ include file="../common/subTab.jsp" %>
					 <!--결제선택탭끝-->
                   <!--신용카드내역시작-->
                   <table width="408" border="0" cellspacing="0" cellpadding="0">
						<tr> 
						<%
					
						String strTempCss = "back12";
						if(tdSize == 28)
							strTempCss = "back14";
						else if(tdSize == 104)
							strTempCss = "back13";
						else if(tdSize == 180)
							strTempCss = "back12";
						else 
							strTempCss = "back04";				
						%>
							<td width="408" height="120" class="<%=strTempCss%>"> 
								<table width="385" height="97" border="1" align="center"  cellpadding="0" cellspacing="0" bordercolor="#cccccc"					style="border-collapse:collapse;">
									<tr> 
										<td width="80" height="63" class="TblTc">가입 통신사</td>
										<td> 
											<table border="0" cellspacing="0" cellpadding="0">
												<tr> 
													<td width="50"><label for=""><input type="radio" name="Carrier1" value="" onClick="SCarrier('011');">SKT</label></td>
													<td width="50"><label for=""><input type="radio" name="Carrier6" value="" onClick="SCarrier('016');">KT</label></td>
													<td width="50"><label for=""><input type="radio" name="Carrier9" value="" onClick="SCarrier('019');">LG U+</label></td>
												</tr>
											</table>
										</td>
									</tr>
									<tr> 
										<td height="38" class="TblTc">휴대폰번호</td>
										<td style="padding: 0 0 0 5">
											<select name="DstAddr0"  onChange="JavaScript:SCarrier2(document.tranMgr.DstAddr0.value);">
		                                      <option value="" selected>선택</option>
		                                      <option value="010">010</option>
		                                      <option value="011">011</option>
		                                      <option value="016">016</option>
		                                      <option value="017">017</option>
		                                      <option value="018">018</option>
		                                      <option value="019">019</option>
                                   			 </select> -
											<input type="text" class="input02" style="width: 35px" name="DstAddr1" size="4" maxlength="4"> -
											<input type="text" class="input02" style="width: 35px" name="DstAddr2" size="4" maxlength="4">
										</td>
									</tr>
									<tr> 
										<td height="38" class="TblTc">주민번호</td>
										<td style="padding: 0 0 0 5">
											<input type="text" class="input02" style="width: 60px" name="Iden0" size="6" maxlength="6"> -
											<input type="password" class="input02" style="width: 60px" name="Iden1" size="7" maxlength="7">
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr> 
						   <td width="408" height="11" class="back05"></td>
						</tr>
					</table>
					<!--신용카드내역끝-->
               </td>
           </tr>
           <tr> 
			  <td height="12"> </td>
           </tr>
		   <tr> 
			  <td> 
				  <table width="385" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr> 
						<td class="font_swtext">- 기존 KTF 고객님께서는 KT를 선택하여 주십시요.</td>
					</tr>
					<tr>
						<td class="font_swtext">- 입력하신 휴대폰 번호로 승인번호가 전송됩니다.</td>
					</tr>
					<tr>
						<td class="font_swtext">- 결제금액은 다음달 휴대폰 요금에 합산되어 청구됩니다.</td>
					 </tr>
					</table>
			 </td>
		   </tr>
        </table>
	 </td>
	</tr>
	<tr>
		<td height="15" class="back03"></td>
	</tr>
	<tr>
		<td height="83" valign="bottom" class="back06">
			<table width="410" height="40" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr> 
					<td width="123">&nbsp;</td>
					<td width="65"><input name="submit22224" type="button"  class="mmtnL02c" value="다음" onclick="javascript:goNext()"></td>
					<td width="143"><input name="submit22224" type="button"  class="mmtnL02c" value="취소" onclick="javascript:goCancel()"></td>
					<td width="79"><img src="/images/help_bt.gif" width="79" height="26"></td>
				</tr>
			</table>
		</td>
	</tr>
</form>
<%@include file="../common/bottom.jsp" %>
