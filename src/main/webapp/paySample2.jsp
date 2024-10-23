<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.net.InetAddress" %>
<%
//상점 IP 셋팅 <MallIP 셋팅>
InetAddress inet = InetAddress.getLocalHost();
String rtnUrl = "";
if (request.getServerPort() == 80 || request.getServerPort() == 443) {
    rtnUrl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort() +"/ipay/returnPay.jsp";
} else {
    rtnUrl = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort() +"/ipay/returnPay.jsp";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<style type="text/css">
article h2{display: block;width: 100%;font-size: 16px;}
form { width:540px;}
form table{padding:20px 0 0 0px;width: 100%;}
form td{padding:0 0px 5px 0;text-align: left;font-size:12px;}
form td.title{width: 180px;font-size:12px;}
form input{border: 1px solid #aaa;border-radius: 0;padding-left: 10px;width: 300px;}
form .btn_submit{width:150px; border-radius: 4px; padding: 0; margin: 20px 0;height: 30px;background-color: #1e5dd2;border: none;color: #fff;font-weight: bold;font-size:12px;}
.lb{font-size:12px;}
@media screen and (max-device-width : 736px){form{width: 100%;}}
</style>
<!-- InnoPay 결제연동 스크립트(필수) -->
<script type="text/javascript" src="https://pg.innopay.co.kr/ipay/js/jquery-2.1.4.min.js"></script>
<!-- <script type="text/javascript" src="http://117.52.91.132:8180/ipay/js/Innopay-1.3.js" charset="utf-8"></script> -->
<script type="text/javascript" src="./js/Innopay-1.3.1.js" charset="utf-8"></script>
<script type="text/javascript">
/**
 * ReturnURL을 설정하지 않은 경우 아래 함수에서 리턴파라미터를 처리함.
 */
function innopay_result(data){
	var a = JSON.stringify(data);
	alert(a);
	// Sample
	var mid = data.MID;					// 가맹점 MID
	var tid = data.TID;					// 거래고유번호
	var amt = data.Amt;					// 금액
	var moid = data.MOID;				// 주문번호
	var authdate = data.AuthDate;		// 승인일자
	var authcode = data.AuthCode;		// 승인번호
	var resultcode = data.ResultCode;	// 결과코드(PG)
	var resultmsg = data.ResultMsg;		// 결과메세지(PG)
	var errorcode = data.ErrorCode;		// 에러코드(상위기관)
	var errormsg = data.ErrorMsg;		// 에러메세지(상위기관)
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
            <h2>쇼핑몰 결제요청 샘플 페이지</h2>
            <form action="" name="frm" id="frm" method="post"> 
                <table>
                    <caption>쇼핑몰 결제요청 폼</caption>
                    <tbody>
                        <tr>
                            <td class="title" class="title"><div><b>결제수단</b></div></td>
                            <td>
                                <div id="pay_method">
                                    <select style="width:310px;" name="PayMethod" id="PayMethod">
                                        <option value="CARD">신용카드(일반)</option>
                                        <option value="BANK">계좌이체</option>
                                        <option value="VBANK">무통장입금(가상계좌)</option>
                                        <option value="CARS">ARSPAY Web LINK</option>
                                        <option value="CSMS">SMS카드결제 Web LINK(인증)</option>
                                        <option value="DSMS">SMS카드결제 Web LINK(수기)</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="title" class="title"><div><b>상품명</b></div></td>
                            <td>
                                <div>
                                    <input type="text" name="GoodsName" value="테스트상품" placeholder="">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="title"><div><b>상품가격</b></div></td>
                            <td>
                                <div>
                                    <input type="text" name="Amt" value="1000" onKeyUp="javascript:numOnly(this,document.frm,false);">
                                    <input type="hidden" name="Currency" value="KRW"><!-- KRW, USD -->
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="title"><div><b>상품개수</b></div></td>
                            <td>
                                <div>
                                    <input type="text" name="GoodsCnt" value="1">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="title"><div><b>가맹점주문번호</b></div></td>
                            <td class="">
                                <div><!-- 가맹점에서 사용하는 주문번호 -->
                                    <input type="text" name="Moid" value="mnoid1234567890" style="width:60%;" placeholder=""> (미입력시 자동생성)
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="title"><div><b>상점 MID</b></div></td>
                            <td class=''>
                                <div> <!-- testpay01m, danaltestm -->
                                	<input type="text" name="MID" value="testpay01m" style="width:40%;"> (발급받은 상점MID를 입력)
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="title"><div><b>상점 라이센스키</b></div></td>
                            <td class=''>
                                <div> <!--  -->
                                	<input type="text" name="MerchantKey" value="Ma29gyAFhvv/+e4/AHpV6pISQIvSKziLIbrNoXPbRS5nfTx2DOs8OJve+NzwyoaQ8p9Uy1AN4S1I0Um5v7oNUg=="> <!-- 발급된 가맹점키 -->
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="title"><div><b>구매자명</b></div></td>
                            <td>
                                <div>
                                    <input type="text" name="BuyerName" value="mn_홍길동" placeholder="">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="title"><div>구매자 연락처</div></td>
                            <td>
                                <div>
                                    <input type="text" name="BuyerTel" value="012345678" placeholder="">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="title"><div>구매자 이메일 주소</div></td>
                            <td>
                                <div>
                                    <input type="text" name="BuyerEmail" value="test@test.com" placeholder="">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="title"><div><b>결제결과전송 URL</b></div></td>
                            <td>
                                <div>
                                    <!-- <input type="text" name="ReturnURL" value="https://pg.innopay.co.kr/ipay/returnPay.jsp" placeholder=""> -->
                                    <input type="text" name="ReturnURL" value="<%=rtnUrl%>" placeholder="">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="title"><div><b>결제창 팝업유무</b></div></td>
                            <td class="">
                                <div>
                                	<input type="text" name="FORWARD" value="X" style="width:40%;" placeholder=""> (Y:팝업연동 N:페이지전환 X:레이어)
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="title"><div><b>결제결과창 유무</b></div></td>
                            <td class="">
                                <div>
                                    <input type="text" name="ResultYN" value="N" style="width:40%;"> (N:결제결과창 없음)
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <!-- 가맹점필요시 아래 hidden 데이터 설정 -->
                
                <!-- 가맹점필요시 아래 hidden 데이터 설정 -->
                <input type="hidden" name="MallIP" value="<%=inet.getHostAddress()%>"/> <!-- 가맹점서버 IP 가맹점에서 설정-->
				<input type="hidden" name="UserIP" value="<%=request.getRemoteAddr()%>"> <!-- 구매자 IP 가맹점에서 설정-->
				<input type="hidden" name="MallReserved" value=""> <!-- 가맹점 데이터, 전송된 값을 그대로 리턴 -->
				<input type="hidden" name="EncodingType" value="utf-8"> <!-- 인코딩타입, utf-8 이 아닌 경우 설정, euc-kr... -->
				<input type="hidden" name="ArsConnType" value="02"> <!-- ARS접속방법 01:호전환,02:가상번호,03:대표번호 -->
				<input type="hidden" name="User_ID" value=""> <!-- 영업사원 아이디 -->

                <div align="center" style="height:50px;">
                	<input type="button" class="btn_submit" name="btn_pay" value="결제요청" onclick="return goPay(frm)">
                </div>
                <div style="height:10px;"></div>
                <div class='lb'>
					<font color=red>※ 결제창을 Pop-up 방식으로 연동하는 경우 반드시 브라우저 Pop-up 해제를 설정해 주시기 바랍니다.</font> 
                </div>
            </form>
<!-- End Form -->            
        </article>
        <footer style="margin-top: 20px;">
            <ul class='lb'>
                <li>고객지원: 1688-1250</li>
                <li>
                    <span>결제내역조회</span>
                    <a href="http://web.innopay.co.kr/" title="결제내역조회 페이지 이동 ">web.innopay.co.kr</a>
                </li>
            </ul>
        </footer>
    </div>
    <!-- //*** #wrapper -->
</body>
</html>