<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="java.net.SocketException"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.httpclient.HttpStatus"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@ include file="../../common/cardParameter.jsp" %>
<% 
// Cache 의존 제거
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

Box req = new Box();
Box resMemberInfo = null;
req.put("mid", MID);
req.put("svc_prdt_cd",svcPrdtCd);
resMemberInfo = CommonBiz.getMemberInfo(req);

String pointUseYN = CommonUtil.getDefaultStr(request.getParameter("pointUseYN"), "");
/**
String domain = "http://localhost:8080";
if (request.getServerPort() == 80 || request.getServerPort() == 443) {
    domain = request.getScheme() + "://" + request.getServerName() ;
} else {
    domain = request.getScheme() + "://" + request.getServerName() + ":"+request.getServerPort();
} 

// 필요 데이타 저장.
String MispStatus = "0";
String VbankExpDate = CommonUtil.getDefaultStr(request.getParameter("VbankExpDate"), "");

// ISP Data 저장.
String LoginGubun   = "";
String PgId         = KVP_PGID;
String WAPUrl       = "";
String ReturnUrl    = domain+"/ipay/card/isp/returnISPM_data.jsp";
//String ReturnUrl    = "https://pg.innopay.co.kr/ipay/card/isp/returnISPM_data.jsp";
String GoodName     = GoodsName;
String Price        = Amt;
Currency     = "WON";
String NoInt        = CardInterest;
String Noint_Inf    = CardQuota;
String HpNum        = BuyerTel;
String MerchantNo   = CommonUtil.getDefaultStr(request.getParameter("MerchantNo_ispm"), "");
String PubCertPrice = "";
String Tcode        = "";
String IpAddr       = UserIP;
String TID_ispm     = TID;
String CancelUrl    = "";
String CardCode     = CommonUtil.getDefaultStr(request.getParameter("bankCd_ispm"), "");
**/
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>INNOPAY 전자결제서비스</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<link type="text/css" media="screen" rel="stylesheet" href="../../css/common.css">
<link href='../../css/font.css' rel='stylesheet' type='text/css'>
<script type="text/javascript" src="../../js/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="../../js/jquery.mCustomScrollbar.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="../../js/isp_mobile.js" charset="UTF-8"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script type="text/javascript" src="../../js/common.js" charset="utf-8"></script>
<script type="text/javascript">
var m_interval = 1500;  // 1초
var m_count = 0;        // check count
var rtn = null;
var m_http_ver = '';

$(document).ready(function(){
	/* var str = navigator.userAgent;
	var i = str.indexOf("Chrome");
	if(i>0){
		var ver = str.substring(i+7,i+9);
		if(ver<73){
			execISP();
		}	
	}else{
		execISP();
	} */
    var m_chk = setTimeout(checkISPdata, 3000);
});
function execISP(){
	try{
		var insDiv = '';
		insDiv +="<div style='overflow:hidden;'>";
		insDiv +="<iframe id='MISP_FRAME' name='MISP_FRAME' style='border:0px none;' frameborder='0' src='./callAppScheme.jsp?TID=<%=TID%>'></iframe>";
		insDiv +="</div>";
		var attElement = document.createElement('div');
		attElement.setAttribute('id', 'ispDiv');
		attElement.innerHTML = insDiv;
		document.body.appendChild(attElement);
	}catch(e){alert(e);}
}
function checkISPdata(){
    var resultcode = null;
    $.ajax({
        type : "POST",
        url : "./checkISPResult.jsp",
        async : true,
        data : $("#chkForm").serialize(),
        dataType : "json",
        success : function(data){
        	//rtn = $.parseJSON(data.responseText);
            resultcode = data.resultCode;
            console.log("checkISPdata rtn.resultCode ["+resultcode+"]");
            if(resultcode=="0000"){
            	//clearInterval(m_chk);
                var frm = document.tranMgr;
                frm.action = "../payConfirm_card_m.jsp";
                frm.submit();
            }else{
                if(m_count>600){
                    alert("결제시간이 초과되었습니다.\n 다시 시도해 주시기 바랍니다.");
                    window.close();
                }
                m_count++;
                setTimeout(function(){checkISPdata();}, m_interval);
                console.log("checkISPdata m_count ["+m_count+"]");
            }
        },
        error : function(data){
            resultcode = data.resultCode;
            console.log("checkISPdata rtn.resultCode ["+resultcode+"]");
            if(m_count>600){
                alert("결제시간이 초과되었습니다.\n 다시 시도해 주시기 바랍니다.");
                window.close();
            }
            m_count++;
            console.log("checkISPdata m_count ["+m_count+"]");
            setTimeout(function(){checkISPdata();}, m_interval);
        }
    });
}
//Android
function callAppScheme(tid) {
    parent.location.href="intent://TID=" + tid + "#Intent;scheme=ispmobile;package=kvp.jjy.MispAndroid320;end";
}
// iphone

function callIOSAppScheme() {
		var visitedAt = new Date().getTime();
		var set=null;
		if("IPHONE" === OScheck()) {
             set=setTimeout( function () {
            	
				if ((new Date()).getTime()-visitedAt<3500 ) {
					
					parent.location.replace("http://itunes.apple.com/kr/app/id369125087?mt=8");
						
				}
			} ,3000);
           
			set=setTimeout( function () {
			parent.location.replace("ispmobile://TID=<%=TID%>");
			
				
			} ,0 );	
	    }		
	    else {
	    	parent.location.href="intent://TID=<%=TID%>#Intent;scheme=ispmobile;package=kvp.jjy.MispAndroid320;end";
	    }
	}

function goNext(){
	document.tranMgr.action = "../payConfirm_card_m.jsp";
    document.tranMgr.submit();
}
function callAppInstall() {
	var visitedAt = new Date().getTime();
	if("IPHONE" === OScheck()) {
			if ((new Date()).getTime()-visitedAt<4000 ) {
				parent.location.href = "http://itunes.apple.com/kr/app/id369125087?mt=8";
			}
    }
    else {
    	parent.location.href="intent://TID=<%=TID%>#Intent;scheme=ispmobile;package=kvp.jjy.MispAndroid320;end";
    }
}
function goClose() {
	try{
		var nav=navigator.userAgent;
		if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
			window.open('', '_self', '');
		    window.close();
		}else if((window.parent!=null&&window.parent!=undefined)||('X'=='<%=FORWARD%>')){
			 if(/Android/i.test(navigator.userAgent )) {    // 안드로이드
				   // 안드로이드
		        	  window.PayAppBridge.backpage();
			   }
			 else if(/iPhone|iPad|iPod/i.test(navigator.userAgent))
					 {
				 window.webkit.messageHandlers.payResult.postMessage("close");
			 }
		}else{
			history.go(-1);
		}
	}catch(e){window.parent.postMessage('close','*');}
}
</script>
</head>
<body>
<div class="innopay">
    <div class="dim"></div>
    <section class="innopay_wrap">
        <header class="gnb">
            <h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="../../images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
            <div class="kind">
                <span>신용카드결제</span>
            </div>
        </header>
        <section class="contents">
            <section class="order_info">
                <ol class="step">
                    <li class="on">입력</li>
                    <li>확인</li>
                    <li>완료</li>
                </ol>
                <div class="product_info">
                    <ul>
                        <li class="company_name">
                            <div class="info_title">상점명</div>
                            <div><%=resMemberInfo.getString("co_nm") %></div>
                        </li>
                        <li class="product_name">
                            <div class="info_title">상품명</div>
                            <div><%=GoodsName%></div>
                        </li>
                        <li class="price">
                            <div class="info_title">상품가격</div>
                            <div><%=CommonUtil.setComma(Amt)%><span>원</span></div>
                        </li>
                        <li class="term">
                            <div class="info_title">제공기간</div>
                            <div><%if(OfferingPeriod.equals("")||OfferingPeriod.equals("0")){out.print("별도 제공기간 없음");
                                           }else{ out.print(OfferingPeriod); } %></div>
                        </li>
                        <li class="faq_wrap">
							<a href="#" data=".faq" class="btn_bd_white faq_btn btn popup_btn">결제문제해결 / FAQ</a>
						</li>
                    </ul>
                </div>
            </section>
            <section class="con_wrap">
            <section class="ips_notice">
				<p>
					해당카드는 ISP인증 결제 카드 입니다.<br>처음 결제하시는 경우,<br><b><a class="btn_black btn_s3" href="javascript:callAppInstall();">ISP APP설치</a></b> 후 이용 바랍니다.
                </p>
				<section class="btn_wrap">
                <div>
                	<p> 앱이 자동으로 실행되지 않는 경우 </br>
                	    아래 모바일ISP 결제하기 버튼을 눌러 주세요</br></br></p>
                	<a class="btn_black btn" href="#" onclick="javascript:callIOSAppScheme();">모바일 ISP 결제하기</a>
                </div>
			    </section>
            </section>            
            <section class="btn_wrap">
			<!-- 
               <section class="btn_wrap_multi">
                   <div>
                       <a class="btn_gray btn dim_btn" href="javascript:goClose()">취소</a>
                       <a class="btn_blue btn" href="javascript:goNext()">다음</a>
                   </div> -->
                <a class="btn_gray btn dim_btn" href="javascript:goClose()">취소</a>
            </section>
            </section>
            <section class="footer pc">
                <span>INNOPAY 1688 - 1250</span>
            </section>
            <section class="footer mobile">
                <span>INNOPAY 1688 - 1250</span>
            </section>
        </section>
        <!-- Notice -->
		<%@ include file="/common/notice.jsp" %>
		<!-- Faq -->
		<%@ include file="/card/faq.jsp" %>
    </section>
</div>
<form name="chkForm" id="chkForm" method="post">
<input type="hidden" name ="TID" 			value="<%=TID%>"/>
</form>
<form name="tranMgr" method="post" action="">
<input type="hidden" name="PayMethod"       value="<%=PayMethod%>"/>
<input type="hidden" name="pointUseYN"      value="<%=pointUseYN%>"/>
<input type="hidden" name="formBankCd"      value="<%=formBankCd%>"/>
<input type="hidden" name="GoodsCnt"        value="<%=GoodsCnt%>"/>
<input type="hidden" name="GoodsName"       value="<%=GoodsName%>"/>
<input type="hidden" name="GoodsURL"        value="<%=GoodsURL%>"/>
<input type="hidden" name="Amt"             value="<%=Amt%>"/>
<input type="hidden" name="TaxAmt"          value="<%=TaxAmt%>"/>
<input type="hidden" name="DutyFreeAmt"     value="<%=DutyFreeAmt%>"/>
<input type="hidden" name="CardInterest"    value="<%=CardInterest%>"/>
<input type="hidden" name="CardQuota"    	value="<%=CardQuota%>"/>
<input type="hidden" name="CardPoint"       value="0"/>
<input type="hidden" name="Moid"            value="<%=Moid%>"/>
<input type="hidden" name="MID"             value="<%=MID%>"/>
<input type="hidden" name="ReturnURL"       value="<%=ReturnURL%>"/>
<input type="hidden" name="ResultYN"        value="<%=ResultYN%>"/>
<input type="hidden" name="RetryURL"        value="<%=RetryURL%>"/>
<input type="hidden" name="mallUserID"      value="<%=mallUserID%>"/>
<input type="hidden" name="BuyerName"       value="<%=BuyerName%>"/>
<input type="hidden" name="BuyerAuthNum"    value="<%=BuyerAuthNum%>"/>
<input type="hidden" name="BuyerTel"        value="<%=BuyerTel%>"/>
<input type="hidden" name="BuyerEmail"      value="<%=BuyerEmail%>"/>
<input type="hidden" name="ParentEmail"     value="<%=ParentEmail%>"/>
<input type="hidden" name="BuyerAddr"       value="<%=BuyerAddr%>"/>
<input type="hidden" name="BuyerPostNo"     value="<%=BuyerPostNo%>"/>
<input type="hidden" name="UserIP"          value="<%=UserIP%>"/>
<input type="hidden" name="MallIP"          value="<%=MallIP%>"/>
<input type="hidden" name="BrowserType"     value="<%=BrowserType%>"/>
<input type="hidden" name="TID"             value="<%=TID%>"/>
<input type="hidden" name="quotabase"       value="<%=quotabase%>"/>
<input type="hidden" name="MallReserved"    value="<%=MallReserved%>"/>
<input type="hidden" name="MallResultFWD"   value="<%=MallResultFWD%>"/> 
<input type="hidden" name="EncodingType"    value="<%=EncodingType%>"/> 
<input type="hidden" name="OfferingPeriod"  value="<%=OfferingPeriod%>"/> <%-- 제공 기간 변수 --%>
<input type="hidden" name="device"          value="<%=device%>"><%-- 테스트 모드 변수 --%>
<input type="hidden" name="svcCd"           value="<%=svcCd%>">
<input type="hidden" name="svcPrdtCd"       value="<%=svcPrdtCd%>">
<input type="hidden" name="KVP_PGID"        value="<%=KVP_PGID%>"><%-- 테스트 모드 변수 --%>
<input type="hidden" name="OrderCode"       value="<%=OrderCode%>">
<input type="hidden" name="User_ID"         value="<%=User_ID%>">
<input type="hidden" name="Pg_Mid"          value="<%=Pg_Mid%>">
<input type="hidden" name="BuyerCode"       value="<%=BuyerCode%>">
<input type="hidden" name="FORWARD"         value="<%=FORWARD%>">
<input type="hidden" name="EncryptData"     value="<%=EncryptData%>"> <!-- 거래검증값 추가(2018.08 hans) -->
<input type="hidden" name="ediDate"         value="<%=ediDate%>">
<input type="hidden" name="RefererURL"      value="<%=RefererURL%>">
</form>
<iframe id='MISP_FRAME' name='MISP_FRAME' style='display:none;,border:0px none;' src='./callAppScheme.jsp?TID=<%=TID%>'></iframe>
</body>
</html>