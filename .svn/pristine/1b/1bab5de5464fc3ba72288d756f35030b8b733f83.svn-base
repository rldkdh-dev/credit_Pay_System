<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="kr.co.infinisoft.pg.common.*" %>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.document.GiftBox" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%
	String bankCd		= CommonUtil.getDefaultStr(request.getParameter("bankCd"), "");

	Box req = new Box();
	String CardName = "";
	req.put("bank_cd",bankCd);	
	CardName = CommonBiz.getCardName(req);
	CardName = CardName.substring(1, CardName.length()-1);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>UNIWILL PG</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>

<link href="../css/Confirmation.css" rel="stylesheet" type="text/css" />
<link href="../css/ims.css" rel="stylesheet" type="text/css" />
<link href="../css/mms.css" rel="stylesheet" type="text/css" />
<link href="../css/payment.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
#apDiv1 {
	position:absolute;
	width:200px;
	height:115px;
	z-index:1;
}
#apDiv2 {
	position:absolute;
	left:286px;
	top:428px;
	width:74px;
	height:71px;
	z-index:2;
}
-->
</style>
<link href="../css/issue.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {color: #FF0000}
.style2 {
	font-size: 14px;
	font-weight: bold;
}
.style3 {font-size: 12pt}
.style4 {font-size: 12}
.style5 {font-size: 14px}
-->
</style>
<script type="text/javascript">
function usePoint(retVal){
	window.focus();	
	var openner = window.dialogArguments;	
	window.returnValue = retVal;
	window.close();
}
</script>
<title>카드 포인트 안내</title>
</head>
<body>
<table width="450" border="0" cellpadding="0" cellspacing="0" bgcolor="e5e5e5">
  <tr>
    <td height="31" valign="top"><img src="../images/title077.jpg" width="450" height="90" /></td>
  </tr>
</table>
<table width="450" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="20"><img src="../images/no.gif" width="20" height="20" /></td>
    <td height="30">&nbsp;</td>
    <td width="23"><img src="../images/no.gif" width="20" height="20" /></td>
  </tr>
  <tr>
    <td rowspan="3">&nbsp;</td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><div align="center" class="style2"><span class="style1">[ <%=CardName%> 카드  포인트 가맹점] </span>입니다.</div></td>
        </tr>
      <tr>
        <td height="20"><div align="center"><span class="style3"><span class="style4"><span class="style5"><span class="style5"><span class="style5"><span class="style5"></span></span></span></span></span></span></div></td>
        </tr>
      <tr>
        <td><p align="center" class="style2">포인트 결제시 카드사 정책에 따라 사용할 <br />
          포인트가 &#13;차감되고, 부족한 금액은 <br />
          신용카드로 결제됩니다.</p></td>
        </tr>
    </table></td>
    <td rowspan="3">&nbsp;</td>
  </tr>
  <tr>
    <td height="50">&nbsp;</td>
  </tr>
  

  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><div align="center">사용을  클릭하시면 카드포인트 결제가 진행됩니다</div></td>
        </tr>
      <tr>
        <td height="20">&nbsp;</td>
      </tr>
      <tr>
        <td><table width="143" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="65"><div align="center"><img src="../images/btn_o2.gif" width="65" height="23" onclick="usePoint('1');"/></div></td>
            <td><div align="right"><img src="../images/btn_x2.gif" width="65" height="23" onclick="usePoint('0');"/></div></td>
            </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="450" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="20"><img src="../images/no.gif" width="20" height="30" /></td>
    <td width="408" valign="bottom"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="../images/bottom01.jpg">
      <tr>
        <td><img src="../images/no.gif" width="5" height="5" /></td>
      </tr>
    </table></td>
    <td width="22"><img src="../images/no.gif" width="20" height="30" /></td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>
