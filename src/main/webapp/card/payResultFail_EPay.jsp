<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 간편결제 결과 실패페이지
*	@ PROGRAM NAME		: payResultFail_EPay.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2020.04.08
*	@ PROGRAM CONTENTS	: 간편결제 결과 실패페이지
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%-- 공통 파라미터 체크 --%>
<%@ include file="../common/cardParameter.jsp" %>
<%
	PayMethod="EPAY";
	String resultCode = "";
	String resultMsg = "";

	String resAuthDate		= CommonUtil.getDefaultStr(request.getParameter("resAuthDate"), "");
	String resErrorCD		= CommonUtil.getDefaultStr(request.getParameter("resErrorCD"), "");
	String resErrorMSG		= CommonUtil.getDefaultStr(request.getParameter("resErrorMSG"), "");
	String resResultCode	= CommonUtil.getDefaultStr(request.getParameter("resResultCode"), "");
	String resResultMsg		= CommonUtil.getDefaultStr(request.getParameter("resResultMsg"), "");

	System.out.println("resErrorCD["+resErrorCD+"]");
	System.out.println("resErrorMSG["+resErrorMSG+"]");
	System.out.println("resResultCode["+resResultCode+"]");
	System.out.println("resResultMsg["+resResultMsg+"]");
	
	Box req = new Box();
	Box resFnNmCode1 = null;
	Box resMemberInfo = null;

	req.put("col_nm", "card_cd");
	req.put("code1", formBankCd);
	
	resFnNmCode1 = CommonBiz.getFnNmCode1(req);
	
	req.put("mid", MID);
	resMemberInfo = CommonBiz.getMemberInfo(req);
		 
	if(resResultCode.equals("3001")) { // 카드 결제 성공(3001)
		resultCode = resResultCode;
		resultMsg = resResultMsg;
	} else if ( resResultCode.length() == 4 ) { // 나머지 오류
		resultCode = resResultCode;
		resultMsg = resResultMsg;
	} else {	// 미정의 오류
		resultCode = resResultCode.length() > 0 ? resResultCode.trim() : "9999";
		resultMsg = resResultMsg.length() > 0 ? resResultMsg.trim() : "알수없는 오류";
	}
	
	if(resErrorCD != null && !resErrorCD.equals("")){
		resultCode = resErrorCD;
		resultMsg = resErrorMSG;					
	}
	   String PayName="";	
	if(EPayCl.equals("01"))
		PayName="카카오페이";
	else if(EPayCl.equals("02"))
		PayName="LPay";
	else if(EPayCl.equals("03"))
		PayName="PAYCO";
	else if(EPayCl.equals("04"))
        PayName="SSGPAY";
	else if(EPayCl.equals("06"))
        PayName="네이버페이";
	
	
	JSONObject json = new JSONObject();
    json.put("action", "pay");
    json.put("PayMethod", "EPAY");
    json.put("MID", MID);
    json.put("TID", TID);
    json.put("EPayCl", EPayCl);
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
    json.put("VbankName", "");
    json.put("MerchantReserved", java.net.URLEncoder.encode(MallReserved,"utf-8"));
    json.put("MallReserved", java.net.URLEncoder.encode(MallReserved,"utf-8"));
    json.put("SUB_ID", SUB_ID);
    json.put("fn_cd", formBankCd);
    json.put("fn_name", java.net.URLEncoder.encode(PayName,"utf-8"));
    json.put("CardQuota", CardQuota);
    json.put("AcquCardCode", "");
    json.put("AcquCardName", "");
    json.put("ErrorCode", resErrorCD);
    json.put("ErrorMsg", java.net.URLEncoder.encode(resErrorMSG,"utf-8"));
    json.put("BuyerAuthNum", BuyerAuthNum);
    json.put("ReceitType", "");
    json.put("VbankExpDate", "");
    json.put("VBankAccountName", "");
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
	    </script>
    </head>
    <body>
        <div class="innopay">
            <div class="dim"></div>
            <section class="innopay_wrap">

                <header class="gnb">
                    <h1 class="logo"><a href="http://web.innopay.co.kr/" target="_blank"><img src="../images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></a></h1>
                    <div class="kind">
                        <span>간편결제</span>
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
                                    <div><%=GoodsName %></div>
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
                        <section class="success_notice">
                            <div>
                                <div>
                                    <img src="../images/x_red.png" alt="실패">
                                    <p>결제실패</p>
                                </div>
                            </div>  
                        </section>

                        <section class="complete_info">
                            <ul class="top_info">
                                <li>
                                    <div class="info_title">상품명</div>
                                    <div><%=GoodsName %></div>
                                </li>
                                <li class="price_li">
                                    <div class="info_title">결제금액</div>
                                    <div class="price"><%=CommonUtil.setComma(Amt)%><span>원</span></div>
                                </li>
                            </ul>
                            <ul>
                                <li>
                                    <div class="info_title">상점명</div>
                                    <div><%=resMemberInfo.getString("co_nm")%></div>
                                </li>
                                <li>
                                    <div class="info_title">구매자명</div>
                                    <div><%=BuyerName%></div>
                                </li>
                                <li>
                                    <div class="info_title">결제수단</div>
                                    <div><%=PayName %></div>
                                </li>
                                <li>
                                    <div class="info_title">결제결과</div>
                                    <div class="red">결제실패</div>
                                </li>
                                <li>
                                    <div class="info_title">실패사유</div>
                                    <div><%="[" + resultCode + "]:" + resultMsg %></div>
                                </li>
                            </ul>
                        </section>

                        <section class="btn_wrap">
                            <div>
                                <a class="btn_gray btn" href="javascript:goClose()">닫기</a>
                            </div>
                        </section>
                    </section>

                    <section class="footer pc">
	                        <p>INNOPAY 1688 - 1250</p>
	                    </section>
<section class="footer clear mobile">
                        <p>INNOPAY 1688 - 1250</p>
                        
                    </section>
                </section>
                <!-- Faq -->
				<%@ include file="/card/faq.jsp" %>
                <!-- Notice -->
				<%@ include file="/common/notice.jsp" %>
            </section>
        </div>
<form name="returnMgr" method="post" action="">
<input type="hidden" name="PayMethod"		value="<%=PayMethod%>">
<input type="hidden" name="MID"				value="<%=MID%>">
<input type="hidden" name="TID"             value="<%=TID%>">
<input type="hidden" name="mallUserID"      value="<%=mallUserID%>">
<input type="hidden" name="Amt"				value="<%=Amt%>">
<input type="hidden" name="CardInterest"    value="<%=CardInterest%>">
<input type="hidden" name="name"			value="<%=BuyerName%>">
<input type="hidden" name="GoodsName"		value="<%=GoodsName%>">
<input type="hidden" name="OID"				value="<%=Moid%>">
<input type="hidden" name="AuthDate"		value="<%=resAuthDate%>">
<input type="hidden" name="AuthCode"		value="">
<input type="hidden" name="ResultCode"		value="<%=resResultCode%>">
<input type="hidden" name="ResultMsg"		value="<%=resResultMsg%>">
<input type="hidden" name="MallReserved"	value="<%=MallReserved%>">
<input type="hidden" name="fn_cd" 			value="<%=formBankCd%>">
<input type="hidden" name="fn_name" 		value="<%=PayName%>">
<input type="hidden" name="CardQuota" 		value="<%=CardQuota%>">
<input type="hidden" name="BuyerEmail" 		value="<%=BuyerEmail%>">
<input type="hidden" name="BuyerAuthNum" 	value="<%=BuyerAuthNum%>">
<input type="hidden" name="AcquCardCode" 	value="">
<input type="hidden" name="AcquCardName" 	value="">
</form>        
    </body>
</html>