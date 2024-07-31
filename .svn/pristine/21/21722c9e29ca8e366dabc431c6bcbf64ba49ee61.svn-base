<%
/*****************************************************************************
*
*   @ SYSTEM NAME       : 신용카드 결제결과 응답 페이지
*                         블루월넛 SMS결제 연동용 결과 페이지                    
*   @ PROGRAM NAME      : payResult_card_bw.jsp
*   @ MAKER             : InnoPay PG
*   @ MAKE DATE         : 2018.01.26
*   @ PROGRAM CONTENTS  : 신용카드 결제결과 응답 페이지
*
******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="../common/cardParameter.jsp" %>
<%
    String cssStr = "";
    String disAuthDate = ""; // 승인일시

    String resAuthDate          = CommonUtil.getDefaultStr(request.getParameter("resAuthDate"), "");
    String resAuthCode          = CommonUtil.getDefaultStr(request.getParameter("resAuthCode"), "");
    String resErrorCD           = CommonUtil.getDefaultStr(request.getParameter("resErrorCD"), "");
    String resErrorMSG          = CommonUtil.getDefaultStr(request.getParameter("resErrorMSG"), "");
    String resResultCode        = CommonUtil.getDefaultStr(request.getParameter("resResultCode"), "");
    String resResultMsg         = CommonUtil.getDefaultStr(request.getParameter("resResultMsg"), "");   
    String resAcquCardCode      = CommonUtil.getDefaultStr(request.getParameter("resAcquCardCode"), "");    
    String resAcquCardName      = CommonUtil.getDefaultStr(request.getParameter("resAcquCardName"), "");
    // 아래 블루월넛 때문에 추가
    String resAppCardCode       = CommonUtil.getDefaultStr(request.getParameter("resAppCardCode"), "");
    String resAppCardName       = CommonUtil.getDefaultStr(request.getParameter("resAppCardName"), "");
//    System.out.println("resAuthDate["+resAuthDate+"]");
//    System.out.println("resAppCardCode["+resAppCardCode+"]");
//    System.out.println("resAppCardName["+resAppCardName+"]");
//    System.out.println("resAcquCardCode["+resAcquCardCode+"]");
//    System.out.println("resAcquCardName["+resAcquCardName+"]");
//    System.out.println("device ["+device+"]");
    
    Box req = new Box();
    Box resFnNmCode1 = null;
    Box resMemberInfo = null;
    Box resTransInfo = null;
        
    req.put("mid", MID);
    req.put("tid", TID);
    
    // TODO : DB처리 수정 필요
    // For TEST
    // Box resCardTrans= CommonBiz.getCardTransInfo(req);
    // String payCardCode = resCardTrans.getString("app_co");
    // For Test
    // 테스트시 승인내역이 없어 payCardCode = null
    String payCardCode = formBankCd;
    // 블루월넛 때문에 아래 추가
    if(StringUtils.isEmpty(payCardCode)){
        payCardCode = resAppCardCode;
    }
    
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
    
    disAuthDate = curYY +"."+ curMM+"." + curDD + "&nbsp;" + curHH + ":" + curmm + ":" + curSS; 
    req.put("col_nm", "card_cd");
    req.put("code1", payCardCode);
    
    resFnNmCode1 = CommonBiz.getFnNmCode1(req); 
    resMemberInfo = CommonBiz.getMemberInfo(req);
    
    String systemMode = System.getProperty("SYSTEM_MODE");
    
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
        <script type="text/javascript" src="../js/common.js"></script>
        <title>INNOPAY 전자결제서비스</title>

<script type="text/javascript">
    
    function fn_UnLoad() {
        if(event.clientY < 0) {
            goClose();
        }
    }
    
    var flag = true;
    function goReceipt() {
        var f = document.tranMgr;
        var status = "toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=500,height=893,top=0,left=0";
        window.open("about:blank","popupIssue",status);
        f.target = "popupIssue";
        f.action = "/ipay/issue/IssueLoader.jsp?type=0";
        f.submit();
        return false;   
    }
    
    function goClose() {
        if (flag == true) {
            flag = false;
            <% if(StringUtils.isNotEmpty(ReturnURL)){ %>
                   document.returnMgr.action = "<%=ReturnURL%>";
                <% if("euc-kr".equals(EncodingType)){%>
                       document.charset = "euc-kr";
                <% }else { %>
                       document.charset = "utf-8";
                <% }%>
                   document.returnMgr.target = "payWindow";
                   document.returnMgr.submit(); 
            <%}else{ %>
                window.close();
            <%}%> 
        }
        return false;
    }
    
    function goCancel() {
        var bodyElements = document.getElementsByTagName("body");
        var body = bodyElements[0];
        body.setAttribute("onbeforeunload","");
        document.cancelMgr.action = "../mainCancelPay.jsp";
        document.cancelMgr.submit();
        return false;
    }
    window.attachEvent("onbeforeunload",fn_UnLoad);
</script>
    </head>
    <body>
        <div class="innopay">
            <div class="dim"></div>
            <section class="innopay_wrap">

                <header class="gnb">
                    <!-- <h1 class="logo"><img src="../images/innopay_logo.png" alt="INNOPAY 전자결제서비스 logo" height="26px" width="auto"></h1> -->
                    <h1 class="logo"><img src="../images/bluewalnut.png" alt="BlueWalnut 전자결제서비스 logo" style="height:21px;"></h1>
                    <div class="kind">
                        <span>신용카드결제</span>
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
                            </ul>
                        </div>
                    </section>
                    
                    <section class="con_wrap">
                        <section class="success_notice">
                            <div>
                                <div>
                                    <img src="../images/check_blue.png" alt="성공">
                                    <p>결제성공</p>
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
                                    <div>신용카드 (<%=resFnNmCode1.getString("fn_nm_code1") + "카드"%>)</div>
                                </li>
                                <li>
                                    <div class="info_title">결제일시</div>
                                    <div><%=disAuthDate%></div>
                                </li>
                                <li>
                                    <div class="info_title">E-mail</div>
                                    <div><%=BuyerEmail.equals("") ? "&nbsp;" : BuyerEmail%></div>
                                </li>
                                <li>
                                    <div class="info_title">승인번호</div>
                                    <div><%=resAuthCode %></div>
                                </li>
                                <li>
                                    <div class="info_title">결제결과</div>
                                    <div class="blue">결제성공</div>
                                </li>
                            </ul>
                        </section>

                        <!-- <section class="btn_wrap">
                            <div>
                                <a class="btn_blue btn" href="#" onclick="return goReceipt()">영수증</a>
                            </div>
                        </section> -->
                    </section>

                    <!-- <section class="footer">
                        <span>INNOPAY 1688 - 1250</span>
                    </section> -->

                </section>
            </section>
        </div>

<form name="cancelMgr" method="post">
    <input type="hidden" name="TID"         value="<%=TID%>">
    <input type="hidden" name="MID"         value="<%=MID%>">
    <input type="hidden" name="PayMethod"   value="<%=PayMethod%>">
    <input type="hidden" name="CancelAmt"   value="<%=Amt%>">
</form>

<form name="returnMgr" method="post" action="">
<input type="hidden" name="PayMethod"           value="<%=PayMethod%>">
<input type="hidden" name="MID"                 value="<%=MID%>">
<input type="hidden" name="TID"                 value="<%=TID%>">
<input type="hidden" name="mallUserID"          value="<%=mallUserID%>">
<input type="hidden" name="Amt"                 value="<%=Amt%>">
<input type="hidden" name="CardInterest"        value="<%=CardInterest%>">
<input type="hidden" name="name"            value="<%=BuyerName%>">
<input type="hidden" name="GoodsName"           value="<%=GoodsName%>">
<input type="hidden" name="OID"                 value="<%=Moid%>">
<input type="hidden" name="AuthDate"            value="<%=resAuthDate%>">
<input type="hidden" name="AuthCode"            value="<%=resAuthCode%>">
<input type="hidden" name="ResultCode"          value="<%=resResultCode%>">
<input type="hidden" name="ResultMsg"           value="<%=resResultMsg%>">
<input type="hidden" name="MallReserved"        value="<%=MallReserved%>">
<input type="hidden" name="fn_cd" value="<%=formBankCd%>">
<input type="hidden" name="fn_name" value="<%=resFnNmCode1.getString("fn_nm_code1")%>">
<input type="hidden" name="CardQuota" value="<%=CardQuota%>">
<input type="hidden" name="BuyerEmail" value="<%=BuyerEmail%>">
<input type="hidden" name="BuyerAuthNum" value="<%=BuyerAuthNum%>">
<input type="hidden" name="AcquCardCode" value="<%=resAcquCardCode%>">
<input type="hidden" name="AcquCardName" value="<%=resAcquCardName%>">
</form>

<form name="tranMgr" method="post" action="">
<input type="hidden" name="PayMethod"           value="<%=PayMethod%>">
<input type="hidden" name="formBankCd"          value="<%=formBankCd%>">
<input type="hidden" name="GoodsCnt"            value="<%=GoodsCnt%>">
<input type="hidden" name="GoodsName"           value="<%=GoodsName%>">
<input type="hidden" name="Amt"                 value="<%=Amt%>">
<input type="hidden" name="CardQuota"           value="<%=CardQuota%>">
<input type="hidden" name="Moid"                value="<%=Moid%>">
<input type="hidden" name="MID"                 value="<%=MID%>">
<input type="hidden" name="ReturnURL"           value="<%=ReturnURL%>">
<input type="hidden" name="ResultYN"            value="<%=ResultYN%>">
<input type="hidden" name="RetryURL"            value="<%=RetryURL%>">
<input type="hidden" name="mallUserID"          value="<%=mallUserID%>">
<input type="hidden" name="BuyerName"           value="<%=BuyerName%>">
<input type="hidden" name="BuyerAuthNum"        value="<%=BuyerAuthNum%>">
<input type="hidden" name="BuyerTel"            value="<%=BuyerTel%>">
<input type="hidden" name="BuyerEmail"          value="<%=BuyerEmail%>">
<input type="hidden" name="ParentEmail"         value="<%=ParentEmail%>">
<input type="hidden" name="BuyerAddr"           value="<%=BuyerAddr%>">
<input type="hidden" name="BuyerPostNo"         value="<%=BuyerPostNo%>">
<input type="hidden" name="UserIP"              value="<%=UserIP%>">
<input type="hidden" name="MallIP"              value="<%=MallIP%>">
<input type="hidden" name="BrowserType"         value="<%=BrowserType%>">
<input type="hidden" name="SUB_ID"              value="<%=SUB_ID%>">
<input type="hidden" name="EncodingType"        value="<%=EncodingType%>">
<input type="hidden" name="AcquCardCode"        value="<%=resAcquCardCode%>">
<input type="hidden" name="AcquCardName"        value="<%=resAcquCardName%>">
<%-- from mpi --%>
<input type="hidden" name="TID"                 value="<%=TID%>">
<input type="hidden" name="eci"                 value="<%=eci%>">
<input type="hidden" name="xid"                 value="<%=xid%>">
<input type="hidden" name="cavv"                value="<%=cavv%>">
<input type="hidden" name="cardno"              value="<%=cardno %>">
<input type="hidden" name="joinCode"            value="<%=joinCode%>">
<%-- from direct input jsp page --%>
<input type="hidden" name="CardExpire"          value="<%=CardExpire%>">
<input type="hidden" name="CardPwd"             value="<%=CardPwd%>">
<input type="hidden" name="quotabase"       value="<%=quotabase%>">
<%-- from isp --%>
<input type="hidden" name="KVP_PGID"            value="<%=KVP_PGID%>">
<input type="hidden" name="KVP_GOODNAME"        value="<%=KVP_GOODNAME%>">
<input type="hidden" name="KVP_PRICE"           value="<%=KVP_PRICE%>">
<input type="hidden" name="KVP_CURRENCY"        value="<%=KVP_CURRENCY%>">
<input type="hidden" name="KVP_NOINT_INF"       value="<%=KVP_NOINT_INF%>">
<input type="hidden" name="KVP_QUOTA_INF"       value="<%=KVP_QUOTA_INF%>">
<input type="hidden" name="KVP_IMGURL"          value="<%=KVP_IMGURL%>">
<input type="hidden" name="KVP_NOINT"           value="<%=KVP_NOINT%>">
<input type="hidden" name="KVP_QUOTA"           value="<%=KVP_QUOTA%>">
<input type="hidden" name="KVP_CARDCODE"        value="<%=KVP_CARDCODE%>">
<input type="hidden" name="KVP_CONAME"          value="<%=KVP_CONAME%>">
<input type="hidden" name="KVP_SESSIONKEY"      value="<%=KVP_SESSIONKEY%>">
<input type="hidden" name="KVP_ENCDATA"         value="<%=KVP_ENCDATA%>">
<input type="hidden" name="KVP_RESERVED1"       value="<%=KVP_RESERVED1%>">
<input type="hidden" name="KVP_RESERVED2"       value="<%=KVP_RESERVED2%>">
<input type="hidden" name="KVP_RESERVED3"       value="<%=KVP_RESERVED3%>">

<!-- 프린트 페이지정보 -->
<input type="hidden" name="fn_nm_code1"         value="<%=CommonUtil.getDefaultStr(resFnNmCode1.getString("fn_nm_code1") , "")%>">
<input type="hidden" name="disAuthDate"         value="<%=disAuthDate%>">
<% if(resTransInfo != null) { %>
<input type="hidden" name="card_no"             value="<%=CommonUtil.getDefaultStr(resTransInfo.getString("card_no") , "")%>"><!-- 내일 확인후 삭제하던가 -->
<input type="hidden" name="cc_dt"               value="<%=CommonUtil.getDefaultStr(resTransInfo.getString("cc_dt") , "")%>">
<input type="hidden" name="cc_tm"               value="<%=CommonUtil.getDefaultStr(resTransInfo.getString("cc_tm") , "")%>">
<input type="hidden" name="app_no"              value="<%=CommonUtil.getDefaultStr(resTransInfo.getString("app_no") , "")%>">
<input type="hidden" name="expire_dt"           value="<%=CommonUtil.getDefaultStr(resTransInfo.getString("expire_dt") , "")%>">
<input type="hidden" name="instmnt_mon"         value="<%=CommonUtil.getDefaultStr(resTransInfo.getString("instmnt_mon") , "00")%>">
<% } else { %>
<input type="hidden" name="cc_dt"               value="">
<input type="hidden" name="cc_tm"               value="">
<input type="hidden" name="app_no"              value="">
<input type="hidden" name="expire_dt"           value="">
<input type="hidden" name="instmnt_mon"         value="">
<% } %>
<!-- 이용상점 정보 -->
<input type="hidden" name="co_nm"               value="<%=CommonUtil.getDefaultStr(resMemberInfo.getString("co_nm"), "")%>">
<input type="hidden" name="co_no"               value="<%=CommonUtil.getDefaultStr(resMemberInfo.getString("co_no"), "")%>">
<input type="hidden" name="boss_nm"             value="<%=CommonUtil.getDefaultStr(resMemberInfo.getString("boss_nm"), "")%>">
<input type="hidden" name="tel_no"              value="<%=CommonUtil.getDefaultStr(resMemberInfo.getString("tel_no"), "")%>">
</form>
    </body>
</html>