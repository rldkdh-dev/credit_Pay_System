<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%><%@ page import="util.CommonUtil, util.CardUtil, service.*" %><%
    String MerDeviceType = CommonUtil.getDefaultStr(request.getParameter("MerDeviceType"), "WEB");
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
    <title>HPay 결제 샘플 페이지</title>
    <meta http-equiv="cache-control" content="no-cache"/>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%  if(MerDeviceType.equals("APP")){ %>
    <!-- 모바일 결제창 연동시 적용 CSS -->
    <meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
    <link rel="stylesheet" type="text/css" href="https://pg.bluewalnut.co.kr/dlp/css/mobile/hpay.css" />    
<%  }else{ %>
    <!-- PC 결제창 연동시 적용 CSS -->
    <link rel="stylesheet" type="text/css" href="https://pg.bluewalnut.co.kr/dlp/css/pc/hpay.css" />
<%  } %>
    <script type="text/javascript" src="https://pg.bluewalnut.co.kr:443/dlp/scripts/lib/easyXDM.min.js"></script>
    <script type="text/javascript" src="https://pg.bluewalnut.co.kr:443/dlp/hpay_tr.js"></script>
    <script type="text/javascript" src="https://pg.bluewalnut.co.kr:443/dlp/cnspayUtil.js"></script>
    <script type="text/javascript" src="https://pg.bluewalnut.co.kr:443/dlp/scripts/lib/json2.js"></script>
    
    <script type="text/javascript">
    function hpaySubmit() {
        opener.hpaySubmit();
    }
    
    function pay() {
        var payForm = opener.document.frm;
        goPay(payForm);
    }
    
    function hpayClose() {
        opener.hpayClose();
    }
    </script>
</head>
<body>
<script type="text/javascript">
    pay();
</script>
</body>
</html>