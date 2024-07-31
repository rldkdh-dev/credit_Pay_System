<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 결제결과실패페이지
*	@ PROGRAM NAME		: payResultFail.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2018.01.05
*	@ PROGRAM CONTENTS	: 결제결과실패페이지
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="service.SupportIssue" %>
<%@ page import="kr.co.infinisoft.pg.client.PGClientContext" %>
<%@ page import="kr.co.infinisoft.pg.client.PGConnection" %>
<%@ page import="kr.co.infinisoft.pg.client.PGClient" %>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.document.GiftBox" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%@ page import="kr.co.seeroo.spclib.SPCLib, org.json.simple.JSONObject"%>
<%@ page import="kr.co.infinisoft.pg.common.*" %>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%-- 공통 common include --%>
<%@ include file="../common/commonParameter.jsp" %>
<%
	String TID              = CommonUtil.getDefaultStr(request.getParameter("TID"), "");
    String resAuthDate      = CommonUtil.getDefaultStr(request.getParameter("resAuthDate"), "");
    String resErrorCD       = CommonUtil.getDefaultStr(request.getParameter("resErrorCD"), "");
    String resErrorMSG      = CommonUtil.getDefaultStr(request.getParameter("resErrorMSG"), "");
    String resResultCode    = CommonUtil.getDefaultStr(request.getParameter("resResultCode"), "");
    String resResultMsg     = CommonUtil.getDefaultStr(request.getParameter("resResultMsg"), "");
	
	Box req = new Box();
	Box resFnNmCode1 = null;
	Box resMemberInfo = null;

	req.put("col_nm", "bank_cd");
	req.put("code1", BankCode);
	resFnNmCode1 = CommonBiz.getFnNmCode1(req);
	
	// 가맹점 정보 가져오기
    req.put("svc_cd",svcCd);
    req.put("svc_prdt_cd",svcPrdtCd);
    req.put("mid", MID);
    resMemberInfo = CommonBiz.getMemberInfo(req);
		
	resResultCode = resResultCode.trim();
	
	// 가상계좌 채번 실패: 4104
	if(!resResultCode.equals("4104") && resResultCode.length() != 4) { 
		resResultCode = "9999";
		resResultMsg = "알수없는 오류";
	}
	
	// resAuthDate 승인일(yymmddhhmmss)
	SimpleDateFormat sdfyyMM = new SimpleDateFormat("yyyy");
	String curYY = sdfyyMM.format(new java.util.Date());
	
	String curMM = "";
	String curDD = "";
	String curHH = "";
	String curmm = "";
	String curSS = "";
	
	if(resAuthDate != null && resAuthDate.length() == 12) {
    	curMM = resAuthDate.substring(2, 4);
    	curDD = resAuthDate.substring(4, 6);
    	curHH = resAuthDate.substring(6, 8);
    	curmm = resAuthDate.substring(8, 10);
    	curSS = resAuthDate.substring(10, 12);
    }
    
	String disAuthDate = curYY +"."+ curMM+"." + curDD + "&nbsp;" + curHH + ":" + curmm + ":" + curSS; 
	
	if(StringUtils.isNotEmpty(resErrorCD)){
		resResultCode = resErrorCD;
		resResultMsg = resErrorMSG;					
	}
	String VbankName = resFnNmCode1.getString("fn_nm_code1");
	
	JSONObject json = new JSONObject();
    json.put("action", "pay");
    json.put("PayMethod", PayMethod);
    json.put("MID", MID);
    json.put("TID", TID);
    json.put("mallUserID", mallUserID);
    json.put("BuyerName", java.net.URLEncoder.encode(BuyerName,"utf-8"));
    json.put("BuyerEmail", BuyerEmail);
    json.put("Amt", Amt);
    json.put("name", java.net.URLEncoder.encode(BuyerName,"utf-8"));
    json.put("GoodsName", java.net.URLEncoder.encode(GoodsName,"utf-8"));
    json.put("OID", Moid);
    json.put("MOID", Moid);
    json.put("AuthDate", resAuthDate);
    json.put("AuthCode", "");
    json.put("ResultCode", resResultCode);
    json.put("ResultMsg", java.net.URLEncoder.encode(resResultMsg,"utf-8"));
    json.put("VbankNum", "");
    json.put("VbankName", java.net.URLEncoder.encode(VbankName,"utf-8"));
    json.put("MerchantReserved", java.net.URLEncoder.encode(MallReserved,"utf-8"));
    json.put("MallReserved", java.net.URLEncoder.encode(MallReserved,"utf-8"));
    json.put("SUB_ID", SUB_ID);
    json.put("ErrorCode", resErrorCD);
    json.put("ErrorMsg", java.net.URLEncoder.encode(resErrorMSG,"utf-8"));
    json.put("BuyerAuthNum", BuyerAuthNum);
    json.put("ReceitType", cashReceiptType);
    json.put("ReceiptType", cashReceiptType);
    json.put("VbankExpDate", VbankExpDate);
    json.put("VBankAccountName", java.net.URLEncoder.encode(VBankAccountName,"utf-8"));
    System.out.println("json Data["+json.toString()+"]");
    String retURL = CommonUtil.getURLStr(ReturnURL, json);
    System.out.println("GET URL["+retURL+"]");

%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="../css/jquery.mCustomScrollbar.css" />
        <link rel="stylesheet" type="text/css" href="../css/common.css" />
        <link href='../css/font.css' rel='stylesheet' type='text/css'>
        <script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="../js/jquery.mCustomScrollbar.js"></script>
        <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
        <script type="text/javascript" src="../js/common.js"></script>
        <title>INNOPAY 전자결제서비스</title>
        
<script type="text/javascript">
<!--
<%-- 취소 --%>
function goClose() {
<% if(StringUtils.isNotEmpty(ReturnURL)){ %>
	var url = "<%=retURL%>";
    <%if("euc-kr".equals(EncodingType)){%>
    	try{ document.charset = "euc-kr"; }catch(e){}
    <%}else{%>
    	try{ document.charset = "utf-8"; }catch(e){}
	<%}%>
	try{
    	if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
    		opener.location.href=url;
    		window.open('', '_self', '');
    	    window.close();
    	}else if((window.parent!=null&&window.parent!=undefined)||('X'=='<%=FORWARD%>')){
    		parent.location.href= url;
		}else{
			location.href = url;
		}
	}catch(e){}
<%}else{%>
	try{
		if((opener!=null&&opener!=undefined)||('Y'=='<%=FORWARD%>')){
			window.open('', '_self', '');
		    window.close();
		}else if((window.parent!=null&&window.parent!=undefined)||('X'=='<%=FORWARD%>')){
			window.parent.postMessage('<%=json.toString()%>','*');
		}else{
		}
	}catch(e){}
<%}%>
    return false;
}
-->
</script>
</head>
<body>
    <div class="innopay">
	       <div class="dim"></div>
	       <section class="innopay_wrap">
	
	           <header class="gnb">
	               <h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="../images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
	               <div class="kind">
	                   <span>가상계좌 결제</span>
	               </div>
	           </header>
	
	           <section class="contents">
	               <section class="order_info">
	                   <ol class="step">
	                       <li>입력</li>
	                       <li>확인</li>
	                       <li class="on">완료</li>
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
	                       </ul>
	                   </div>
	               </section>
	               
	               <section class="con_wrap">
	               <div class="con_scroll">
	                   <section class="success_notice">
	                       <div>
	                           <div>
	                               <img src="../images/x_red.png" alt="실패">
	                               <p>예약실패</p>
	                           </div>
	                       </div>  
	                   </section>
	
	                   <section class="complete_info">
	                       <ul class="top_info">
	                           <%-- <li>
	                               <div class="info_title">상품명</div>
	                               <div><%=GoodsName%></div>
	                           </li>
	                           <li class="price_li">
	                               <div class="info_title">결제금액</div>
	                               <div class="price"><%=CommonUtil.setComma(Amt)%><span>원</span></div>
	                           </li> --%>
	                           <li>
                                   <div class="info_title">구매자명</div>
                                   <div><%=BuyerName%></div>
                               </li>
                               <li>
                                   <div class="info_title">E-mail</div>
                                   <div><%=BuyerEmail%></div>
                               </li>
	                       </ul>
	                       <ul>
	                           <%--<li>
	                               <div class="info_title">상점명</div>
	                               <div><%=resMemberInfo.getString("co_nm") %></div>
	                           </li>--%>
	                           <li>
	                               <div class="info_title">결제수단</div>
	                               <div>가상계좌 (무통장입금)</div>
	                           </li>
	                           <li>
	                               <div class="info_title">결제결과</div>
	                               <div class="red">예약실패</div>
	                           </li>
	                           <li>
	                               <div class="info_title">실패사유</div>
	                               <div class="red">[<%=resResultCode%>] <%=resResultMsg %></div>
	                           </li>
	                       </ul>
	                   </section>
	                   </div>
	
	                   <section class="btn_wrap">
	                       <div>
	                           <a class="btn_gray btn" href="javascript:goClose()">닫기</a>
	                       </div>
	                   </section>
	               </section>
	
	               <section class="footer">
	                   <span>INNOPAY 1688 - 1250</span>
	               </section>
	
	           </section>
	           <!-- Notice -->
			   <%@ include file="/common/notice.jsp" %>
	       </section>
	   </div>
<form name="returnMgr" method="post" action="">
<input type="hidden" name="PayMethod"	value="<%=PayMethod%>">
<input type="hidden" name="MID"			value="<%=MID%>">
<input type="hidden" name="TID"         value="<%=TID%>">
<input type="hidden" name="Amt"			value="<%=Amt%>">
<%-- <input type="hidden" name="name"		value="<%=BuyerName%>"> --%>
<input type="hidden" name="BuyerName"	value="<%=BuyerName%>">
<input type="hidden" name="BuyerEmail"  value="<%=BuyerEmail%>">
<input type="hidden" name="mallUserID"  value="<%=mallUserID%>">
<input type="hidden" name="GoodsName"	value="<%=GoodsName%>">
<input type="hidden" name="OID"			value="<%=Moid%>">
<input type="hidden" name="AuthDate"	value="<%=resAuthDate%>">
<input type="hidden" name="AuthCode"	value="">
<input type="hidden" name="ResultCode"	value="<%=resResultCode%>">
<input type="hidden" name="ResultMsg"	value="<%=resResultMsg%>">
<input type="hidden" name="VbankName"   value="<%=resFnNmCode1.getString("fn_nm_code1")%>">
<input type="hidden" name="VbankNum"	value="">
<input type="hidden" name="MallReserved" value="<%=MallReserved%>">
<input type="hidden" name="BuyerAuthNum" value="<%=BuyerAuthNum%>">
<input type="hidden" name="ReceiptType" value="<%=cashReceiptType%>">
<input type="hidden" name="SUB_ID"      value="<%=SUB_ID%>">
<input type="hidden" name="EncodingType" value="<%=EncodingType%>">
<input type="hidden" name="VbankExpDate" value="<%=VbankExpDate %>">
<input type="hidden" name="OrderCode"    value="<%=OrderCode%>">
<input type="hidden" name="BuyerCode"    value="<%=BuyerCode%>">
<input type="hidden" name="FORWARD"        value="<%=FORWARD%>">
<input type="hidden" name="VBankAccountName"   value="<%=VBankAccountName%>"/>
</form>	   
</body>
</html>