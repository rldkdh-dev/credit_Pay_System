<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.net.InetAddress" %>
<%
//상점 IP 셋팅 <MallIP 셋팅>
InetAddress inet = InetAddress.getLocalHost();
String payActionUrl = "https://api.innopay.co.kr";    

if (request.getServerPort() == 80 || request.getServerPort() == 443) {
    payActionUrl = request.getScheme() + "://" + request.getServerName() ;
} else {
    payActionUrl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort();
}
if((payActionUrl.indexOf("localhost")<0) && (request.getServerName().indexOf("117.52.91.132")<0)){
	payActionUrl = "https://api.innopay.co.kr";
}
String postURL = payActionUrl+"/api/DanalManualNoti";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" type="text/css" href="./css/jquery.mCustomScrollbar.css" />
<link rel="stylesheet" type="text/css" href="./css/common.css" />
<style type="text/css">
article h2{display: block;width: 100%;font-size: 16px;}
form { width:90%;}
form table{padding:20px 0 0 0px;width: 100%;}
form td{padding:0 0px 5px 0;text-align: left;}
form td.title{width: 150px;}
form input{border: 1px solid #aaa;border-radius: 0;padding-left: 10px;width: 100%;}
form .btn_submit{width: 100%; border-radius: 4px; padding: 0; margin: 20px 0;height: 40px;background-color: #1e5dd2;border: none;color: #fff;font-weight: bold;}
textarea {border:1px solid; margin:5px; width:100%; height:400px; background-color:#EEEEEE; }
@media screen and (max-device-width : 736px){form{width: 100%;}}
</style>
<link href='./css/font.css' rel='stylesheet' type='text/css'>
<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
    });
    function goNoti(f){
    	f.action="<%=postURL%>";
    	f.submit();
    }
</script>
<title>INNOPAY 전자결제서비스</title>
</head>
<body>
<!-- *** #wrapper -->
    <div style="padding:30px;">
        <header>
            <h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
        </header>
        <article>
            <h2>다날 오프PG 결제노티 수동처리 페이지</h2>
        <div>
			<font color=red>※ 엑셀데이터를 csv(, 구분) 으로 변환하여 해당 데이터를 아래 입력합니다.</font> 
        </div>    
        <div>
			<font color=blue>No.,CPID,서비스구분,거래구분,카드사,구매자,고객ID,상품명,거래(취소)일시,TID,결제(취소)원금액,주문번호,카드번호,최종요청금액,포인트 여부,즉시 할인 금액,무이자 할부 구분,할부,승인번호,승인일자,취소요청자,취소사유</font> 
        </div>
        
            <form action="" name="frm" id="frm" method="post" style=""> 
                <table width="100%">
                    <caption>쇼핑몰 결제요청 폼</caption>
                    <tbody>
                    	<tr><td class="title" colspan="2">
                                <div><b>데이터</b></div>
                            </td>
                    	</tr>
                    	<tr>
                    	    <td colspan="2">
                                <textarea name="data" id="data" rows="100"></textarea>
                            </td>
                    	</tr>
                    </tbody>
                </table>

                <div>
                    <a class="btn_submit btn" href="#" onclick="return goNoti(frm)">전송</a>
                </div>
            </form>
<!-- End Form -->            
        </article>

        <footer style="margin-top: 20px;">
            <ul>
                <li>고객지원: 1688-1250</li>
                <li>
                    <span>결제내역조회</span>
                    <a href="https://web.innopay.co.kr" title="결제내역조회 페이지 이동 ">web.innopay.co.kr</a>
                </li>
            </ul>
        </footer>
        
    </div>
    
    <!-- //*** #wrapper -->
</body>
</html>