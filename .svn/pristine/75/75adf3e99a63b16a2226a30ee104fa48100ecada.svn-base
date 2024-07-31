<%------------------------------------------------------------------------------
파일명     : KSPayCreditFormN.jsp
기능       : 승인/인증승인/MPI인증승인용 카드정보입력용 페이지
-------------------------------------------------------------------------------%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.text.*" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<%
	response.setHeader("cache-control","no-cache");
	response.setHeader("expires","-1");
	response.setHeader("pragma","no-cache");
%>
<%
	
	//신용카드승인종류 - 승인타입 : A-인증없는승인, N-인증승인, M-MPI인증승인
	String certitype    = request.getParameter("certitype") ;
	String authcode     = "" ;
	
	//기본거래정보
	String storeid      = request.getParameter("storeid") ;        //상점아이디
	String ordername    = request.getParameter("ordername") ;      //주문자명
	String ordernumber  = request.getParameter("ordernumber") ;    //주문번호
	String amount       = request.getParameter("amount") ;         //금액
	String goodname     = request.getParameter("goodname") ;       //상품명
	String email        = request.getParameter("email") ;          //주문자이메일
	String phoneno      = request.getParameter("phoneno") ;        //주문자휴대폰번호
	String currencytype = request.getParameter("currencytype") ;   //통화구분 : "WON" : 원화, "USD" : 미화
	String interesttype = request.getParameter("interesttype") ;   //무이자구분 "NONE" : 무이자안함, "ALL" : 전체월 무이자, "3:6:9" : 3,6,9개월무이자
	
	if(certitype.equals("A"))        authcode = "1000" ;
	else if(certitype.equals("N"))   authcode = "1300" ;
	else if(certitype.equals("M"))   authcode = "1000" ;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html charset=euc-kr">
<title>KSPay</title>
<script language=javascript src="https://kspay.ksnet.to/popmpi/js/kspf_pop_mpi.js"></script>
<script language="javascript">
<!--
// 이중승인의 가능성을 줄이기 위해 몇가지 이벤트를 막는다.
document.onmousedown=right;
document.onmousemove=right;

document.onkeypress = processKey;	
document.onkeydown  = processKey;

function processKey() { 
	if((event.ctrlKey == true && (event.keyCode == 8 || event.keyCode == 78 || event.keyCode == 82)) 
		|| ((typeof(event.srcElement.type) == "undefined" || typeof(event.srcElement.name) == "undefined" || event.srcElement.type != "text" || event.srcElement.name != "sndEmail") && event.keyCode >= 112 && event.keyCode <= 123)) {
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

function right(e) {
	if(navigator.appName=='Netscape'&&(e.which==3||e.which==2)){
		alert('마우스 오른쪽 버튼을 사용할수 없습니다.');
		return;
	}else if(navigator.appName=='Microsoft Internet Explorer'&&(event.button==2||event.button==3)) {
		alert('마우스 오른쪽 버튼을 사용할수 없습니다.');
		return;
	}
}
-->
</script>

<script language="javascript">
<!--
	/*** MPI 인증용 스크립트 ***/

	//유효기간추출하기
	function getValue(ym)
	{
		var i = 0;
		var form = document.KSPayAuthForm;

		if( ym == "year" ) {
			while( !form.expyear[i].selected ) i++;
			return form.expyear[i].value;
		} 
		else if( ym == "month" ) {
			while( !form.expmon[i].selected ) i++;
			return form.expmon[i].value;
		}
	}

	function getReturnUrl()
	{
		var myloc = location.href;
		return myloc.substring(0, myloc.lastIndexOf('/')) + '/return.jsp';	
	}

	// 결제 처리- MPI
	function submitV3d()
	{
		var frm = document.Visa3d;
		var realform = document.KSPayAuthForm;
		
		SetInstallment(realform);

		//MPI 인증용 유효기간을 expiry에 세팅한다(YYMM 형태로 세팅하여야 한다.).
		frm.expiry.value = "4912";     //MPI 의 경우는 "4912"로 세팅
		realform.expdt.value = "4912"; //MPI 의 경우는 "4912"로 세팅

		var sIndex = realform.selectcard.value;

		// 카드사 선택 여부 체크
		if (sIndex == 0) {
			alert('결제하실 카드사를 선택하시기 바랍니다.');
			realform.selectcard.focus();
			return;
		}

		frm.instType.value = realform.interest.value;	
		frm.cardcode.value = realform.selectcard.value ;
		frm.returnUrl.value = getReturnUrl();
		
		_KSP_CALL_MPI(frm ,paramSet);   // 인증페이지 호출
	}

	/* 실제 승인페이지로 넘겨주는 form에 xid, eci, cavv, cardno를 세팅한다 */
	function paramSet()
	{
		var frm = document.KSPayAuthForm;
    
		var r_array;
		r_array = arguments[0].split('|');    

		frm.xid.value = r_array[1];
		frm.eci.value = r_array[2];
		frm.cavv.value = r_array[3];
		frm.cardno.value = r_array[4];
		
		proceed(r_array[0]);	
	}

	/* realSubmit을 진행할 것인가 아닌가를 판단하는 함수. 이 함수의 호출은 승인 페이지가 아닌 return.jsp로 하게 되며, 
	페이지가 받아두었던 인증값 파라메터들과 리얼서브밋진행여부를 받아 승인페이지로 되넘겨준다. */
	function proceed(arg)
	{
		var frm = document.KSPayAuthForm;
		var xid = frm.xid.value;
		var eci = frm.eci.value;
		var cavv = frm.cavv.value;
		var cardno = frm.cardno.value;

		if ((arg == "TRUE"||arg == "true"||arg == true) && check_param(xid, eci, cavv, cardno))
		{
			submitAuth() ;
		}
		else
		{
			alert("인증실패") ;
		}
	}

	function check_param(xid, eci, cavv, cardno)
	{
	
		var ck_mpi = get_cookie("xid_eci_cavv_cardno");
	
		if (ck_mpi == xid + eci + cavv + cardno)
		{
			return false;
		}

		set_cookie("xid_eci_cavv_cardno", xid + eci + cavv + cardno);

		ck_mpi = get_cookie("xid_eci_cavv_cardno");
	
		return true;
	}

	function get_cookie(strName)
	{
		var strSearch = strName + "=";
		if ( document.cookie.length > 0 )
		{
			iOffset = document.cookie.indexOf( strSearch );
			if ( iOffset != -1 ) 
			{
				iOffset += strSearch.length;
				iEnd = document.cookie.indexOf( ";", iOffset );
				if ( iEnd == -1 )
					iEnd = document.cookie.length;

				return unescape(document.cookie.substring( iOffset, iEnd ));
			}
		}

		return "";
	}

	function set_cookie(strName, strValue) 
	{ 
	
		var strCookie = strName + "=" + escape(strValue);
		document.cookie = strCookie;
	}
	
	/*** MPI 인증용 스크립트 끝 ***/

	function submitAuth()
	{
		var frm = document.KSPayAuthForm;	
		
		SetInstallment(frm);

		if (frm.expdt.value != "4912") // MPI결제가 아닌경우만 사용 , MPI의 경우는 위에서 "4912"로 세팅
		{
			frm.expdt.value	= getValue("year").substring(2) + getValue("month");
		}
		frm.action			= "./KSPayCreditPostMNI.jsp";
		frm.submit();
	}

	function SetInstallment(form)
	{
		var sInstallment = form.installment.value;
		var sInteresttype = form.interesttype.value.split(":");
		
		sInstallment = (sInstallment != null && sInstallment.length == 2) ? sInstallment.substring(0,2) : "00";
		
		if((sInstallment != "00" && sInstallment != "01" && sInstallment != "60" && sInstallment !="61")&& form.amount.value < 50000) {
			alert("50,000원 이상만 할부 가능합니다.");
			form.installment.value = form.installment.options[0].value;
			form.interestname.value = "";
			return;
		}
		
		if(sInteresttype[0] == "ALL")
		{
			if (sInstallment != "00")
				form.interestname.value = "무이자할부";
			else 
				form.interestname.value = "";
			
			form.interest.value = 2;
			return;
		}
		else if (sInteresttype[0] == "NONE" || sInteresttype[0] == "" || sInteresttype[0].substring(0,1) == " ")
		{
			if (sInstallment != "00")
				form.interestname.value = "일반할부";
			else 
				form.interestname.value = "";
			
			form.interest.value = 1;	
			return;
		}
		
		for (i=0; i < sInteresttype.length; i++)
		{
			if (sInteresttype[i].length == 1) 
				sInteresttype[i] = "0"+sInteresttype[i];
			else if (sInteresttype[i].length > 2) 
				sInteresttype[i] = sInteresttype[i].substring(0,2);
			
			
			if (sInteresttype[i] == sInstallment)
			{
				if (sInstallment != "00")
					form.interestname.value = "무이자할부";
				else 
					form.interestname.value = "";
				
				form.interest.value = 2;
				break;
				
			}
			else
			{
				if (sInstallment != "00")
					form.interestname.value = "일반할부";
				else 
					form.interestname.value = "";
				
				form.interest.value = 1;
			}
		}
	}
-->
</script>
<style type="text/css">
	TABLE{font-size:9pt; line-height:160%;}
	A {color:blueline-height:160% background-color:#E0EFFE}
	INPUT{font-size:9pt}
	SELECT{font-size:9pt}
	.emp{background-color:#FDEAFE}
	.white{background-color:#FFFFFF color:black border:1x solid white font-size: 9pt}
</style>
</head>

<body topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 onFocus="" >

<form name=KSPayAuthForm method=post>
<!--기본-------------------------------------------------------------->
<input type=hidden name="storeid"       value="<%=storeid%>">
<input type=hidden name="authty"        value="<%=authcode%>">
<input type=hidden name="certitype"     value="<%=certitype%>">

<!--일반신용카드------------------------------------------------------>
<input type=hidden name="expdt"          value="">
<input type=hidden name="email"          value="<%=email%>">
<input type=hidden name="phoneno"        value="<%=phoneno%>">
<input type=hidden name="interest"       value="">
<input type=hidden name="interesttype"   value="<%=interesttype%>">
<input type=hidden name="ordernumber"    value="<%=ordernumber%>">
<input type=hidden name="ordername"      value="<%=ordername%>">
<input type=hidden name="goodname"       value="<%=goodname%>">
<input type=hidden name="amount"         value="<%=amount%>">
<input type=hidden name="currencytype"   value="<%=currencytype%>">

<%if(certitype.equals("M")){%>
<input type=hidden name="cardno"         value="">
<%}%>
<!--MPI---------------------------------------------------------------->
<input type="hidden" name="xid"  value="">
<input type="hidden" name="eci"  value="">
<input type="hidden" name="cavv" value="">
<!--MPI---------------------------------------------------------------->

<table border=0 width=0>
<tr>
<td align=center>
<table width=280 cellspacing=0 cellpadding=0 border=0 bgcolor=#4F9AFF>
<tr>
<td>
<table width=100% cellspacing=1 cellpadding=2 border=0>
<tr bgcolor=#4F9AFF height=25>
<td align=left><font color="#FFFFFF">
KSPay 신용카드 승인&nbsp;
<%
	if(certitype.equals("A"))      out.println("(인증없는승인)") ;
	else if(certitype.equals("N")) out.println("(인증승인)") ;
	else if(certitype.equals("M")) out.println("(M-MPI인증승인)") ;
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
	<td>상품명 :</td>
	<td><%=goodname%></td>
</tr>
<tr>
	<td>금액 :</td>
	<td><%=amount%></td>
</tr>
<tr>
	<td colspan=3><hr noshade size=1></td>
</tr>

<!-- MPI 인증승인이면 MPI 인증 스크립트를 사용한다 -->
<% if(certitype.equals("M")) {%>
<tr>
	<td>신용카드종류 :</td>
	<td>
		<select name="selectcard">
			<option value="0" selected>카드를 선택하세요</option>
			<option value="1">하나(구.외환)카드</option>
			<option value="2">삼성카드</option>
			<option value="4">현대카드</option>
			<option value="5">롯데카드</option>
			<option value="6">신한카드</option>
			<option value="7">씨티카드</option>		
			<option value="11">하나(구.하나SK)카드</option>
			<option value="14">농협카드</option>
		</select>
	</td>
</tr>
<%}%>

<!--MPI가 아닐때 카드번호/유효기간을 세팅.-->
<% if(certitype.equals("N")||certitype.equals("A")){%>
<tr>
	<td>신용카드 :</td>
	<td>
		<input type=text name=cardno size=20 maxlength=16 value="">
	</td>
</tr>
<tr>
	<td>유효기간 :</td>
	<td>
		<select name="expyear">
<%
	Calendar CurrDt = Calendar.getInstance();   // 카드 유효기간 계산
	int dYear = CurrDt.get(Calendar.YEAR);
	if(dYear > 0) 
	{
		for(int i=dYear; i<dYear+15;i++)
		{
			out.println("<option value=\"" + i + "\"");
			if(i == (dYear)) out.println(" selected ");
			out.println(">" + i + "</option>\n");
		}
	}
%>
		</select>년/
		<select name="expmon">
			<option value="01">01</option>
			<option value="02">02</option>
			<option value="03">03</option>
			<option value="04">04</option>
			<option value="05">05</option>
			<option value="06">06</option>
			<option value="07">07</option>
			<option value="08">08</option>
			<option value="09">09</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12" selected>12</option>
		</select>월
	</td>
</tr>
<%}%>

<tr>
	<td>할부 :</td>
	<td>
		<select name="installment" onchange="return SetInstallment(this.form);">
			<option value="00" selected>일시불</option>
			<option value="02">02개월</option>
			<option value="03">03개월</option>
			<option value="04">04개월</option>
			<option value="05">05개월</option>
			<option value="06">06개월</option>
			<option value="07">07개월</option>
			<option value="08">08개월</option>
			<option value="09">09개월</option>
			<option value="10">10개월</option>
			<option value="11">11개월</option>
			<option value="12">12개월</option>
		</select>
		&nbsp;
		<input type=text name=interestname size="10" readonly value="" style="border:0px" >
	</td>
</tr>

<!-- MPI 인증승인이면 MPI 인증 스크립트를 사용한다 -->
<%if(certitype.equals("M")){%>
	<input type=hidden name=lastidnum value="">
	<input type=hidden name=passwd value="">
<tr>
	<td colspan=2 align=center>
			<input type=button onclick="javascript:submitV3d()" value="MPI 인증승인">
	</td>
</tr>
<!-- 일반인증승인-->
<%}else if(certitype.equals("N")){%>
<tr>
	<td>생년월일(YYMMDD) :</td>
	<td>
		<input type=text name=lastidnum size=10 maxlength=6 value=""> - XXXXXXX 
	</td>
</tr>
<tr>
	<td>비밀번호 앞 두자리 :</td>
	<td><input type=password name=passwd size=4 maxlength=2 value="">XX</td>
</tr>
<tr>
	<td colspan=2 align=center>
		<input type=button onclick="javascript:submitAuth()" value="일반인증승인">
	</td>
</tr>
<!-- 인증없는승인-->
<%}else if(certitype.equals("A")){%>
	<input type=hidden name=lastidnum value="">
	<input type=hidden name=passwd value="">
<tr>
	<td colspan=2 align=center>
		<input type=button onclick="javascript:submitAuth()" value="인증없는승인">
	</td>
</tr>
<%}%>

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
</form>
<!------------------------------------ ILK Modification --------------------------------------------->
<!-----------------------------------------------------------------------------------------------
	중요!!!
	IFrame의 src를 내용이 아무것도 없는 blank.html로 주는 것은 https 즉 SSL로 결제가 이루어지는 경우
	현재 페이지 로드시 보안관련 메시지가 뜨는 것을 방지하기 위함이다.
	이 부분 삭제시 "보안되지 않는 항목도 표시하시겠습니까?" 라는 메시지가 뜨므로 주의.
------------------------------------------------------------------------------------------------->

<!--MPI인증에 사용될 인자들-->
<IFRAME id=ILKFRAME name=ILKFRAME style="display:none" src="blank.html"></IFRAME>
<%
    String ret = HttpUtils.getRequestURL(request).toString();
    ret = ret.substring(0, ret.lastIndexOf("/")) + "/return.jsp";

    if(currencytype.equals("WON")||currencytype == null||currencytype.equals("")) currencytype = "410" ;   //미화
    else if(currencytype.equals("USD"))    	currencytype = "840" ;                                         //원화
%>
<div style="display:none"> 
<FORM name=Visa3d action="" method=post>
   <INPUT type="hidden"   name=pan             value=""                     size="19" maxlength="19">
   <INPUT type="hidden"   name=expiry          value=""                     size="6"  maxlength="6">
   <INPUT type="hidden"   name=purchase_amount value="<%=amount%>"          size="20" maxlength="20">
   <INPUT type="hidden"   name=amount          value="<%=amount%>"          size="20" maxlength="20">
   <INPUT type="hidden"   name=description     value="none"                 size="80" maxlength="80">
   <INPUT type="hidden"   name=currency        value="<%=currencytype%>"    size="3"  maxlength="3"	>
   <INPUT type="hidden"   name=recur_frequency value=""                     size="4"  maxlength="4"	>
   <INPUT type="hidden"   name=recur_expiry    value=""                     size="8"  maxlength="8"	>
   <INPUT type="hidden"   name=installments    value=""                     size="4"  maxlength="4"	>   
   <INPUT type="hidden"   name=device_category value="0"                    size="20" maxlength="20">
   <INPUT type="hidden"   name="name"          value="test store"           size="20">   <!--회사명을 영어로 넣어주세요(최대20byte)-->
   <INPUT type="hidden"   name="url"           value="http://www.store.com" size="20">   <!-- 회사 도메인을 http://를 포함해서 넣어주세요-->
   <INPUT type="hidden"   name="country"       value="410"                  size="20">
   <INPUT type="password" name="dummy"         value="">
   <INPUT type="hidden"   name="returnUrl"     value="<%=ret%>">   <!--MPI인증후 결과값을받을 페이지-->
   <input type="hidden"   name=cardcode        value="">
   <input type="hidden"   name="merInfo"       value="<%=storeid%>">
   <input type="hidden"   name="bizNo"         value="1208197322">
   <input type="hidden"   name="instType"      value="">
</FORM>
</div>
<!------------------------------------ ILK Modification end ----------------------------------------->
</body>
</html>