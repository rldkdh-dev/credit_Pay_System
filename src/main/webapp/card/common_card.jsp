<%
/*****************************************************************************
*
*   @ SYSTEM NAME       : 신용카드 공통함수
*   @ PROGRAM NAME      : common_card.jsp
*   @ MAKER             : InnoPay PG
*   @ MAKE DATE         : 2016.06.26
*   @ PROGRAM CONTENTS  : 신용카드 결제
*
******************************************************************************/
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="service.SupportIssue" %>
<%@ page import="kr.co.infinisoft.pg.document.Box" %>
<%@ page import="kr.co.infinisoft.pg.common.biz.CommonBiz" %>
<%@ page import="kr.co.seeroo.spclib.SPCLib, org.json.simple.JSONObject"%>
<%@ page import="kr.co.infinisoft.pg.common.*" %>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%
request.setCharacterEncoding("utf-8");
    String actionUrl = "payConfirm_card.jsp";
    String pointStr = "";
    String pointUseYN = "";
    String TID = "";
    String auth_flg = "";                                                               // 인증 타입  02:인증, 01:KeyIn,
    String co_no = "";                                                                  // 사업자번호
    String co_nm = "";                                                                  // 상호   
    String CardInterest = "0";                                                          // 0:일반 1:무이자 
    String PayMethod    = CommonUtil.getDefaultStr(request.getParameter("PayMethod"), CommonConstants.PAY_METHOD_CARD);
    String formBankCd   = CommonUtil.getDefaultStr(request.getParameter("formBankCd"), "");
    String GoodsCnt     = CommonUtil.getDefaultStr(request.getParameter("GoodsCnt"), "");
    String GoodsName    = CommonUtil.getDefaultStr(request.getParameter("GoodsName"), "");
    String GoodsURL     = CommonUtil.getDefaultStr(request.getParameter("GoodsURL"), "");
    String Amt          = CommonUtil.getDefaultStr(request.getParameter("Amt"), "");	// 2019.04 과세+면세 금액으로 변경
    String Moid         = CommonUtil.getDefaultStr(request.getParameter("Moid"), "");
    String MID          = CommonUtil.getDefaultStr(request.getParameter("MID"), "");
    String ReturnURL    = CommonUtil.getDefaultStr(request.getParameter("ReturnURL"), "");
    String ResultYN     = CommonUtil.getDefaultStr(request.getParameter("ResultYN"), "");
    String RetryURL     = CommonUtil.getDefaultStr(request.getParameter("RetryURL"), "");
    String mallUserID   = CommonUtil.getDefaultStr(request.getParameter("mallUserID"), "");
    String BuyerName    = CommonUtil.getDefaultStr(request.getParameter("BuyerName"), "");
    String BuyerAuthNum = CommonUtil.getDefaultStr(request.getParameter("BuyerAuthNum"), "");
    String BuyerTel     = CommonUtil.getDefaultStr(request.getParameter("BuyerTel"), "");
    String BuyerEmail   = CommonUtil.getDefaultStr(request.getParameter("BuyerEmail"), "");
    String ParentEmail  = CommonUtil.getDefaultStr(request.getParameter("ParentEmail"), "");
    String BuyerAddr    = CommonUtil.getDefaultStr(request.getParameter("BuyerAddr"), "");
    String BuyerPostNo  = CommonUtil.getDefaultStr(request.getParameter("BuyerPostNo"), "");
    String UserIP       = CommonUtil.getDefaultStr(request.getParameter("UserIP"), "");
    String MallIP       = CommonUtil.getDefaultStr(request.getParameter("MallIP"), "");
    String BrowserType  = CommonUtil.getDefaultStr(request.getParameter("BrowserType"), "");
    String VbankExpDate = CommonUtil.getDefaultStr(request.getParameter("VbankExpDate"), "");
    String MallReserved = CommonUtil.getDefaultStr(request.getParameter("MallReserved"), "");
    String MallResultFWD = CommonUtil.getDefaultStr(request.getParameter("MallResultFWD"), "");
    String EncodingType = CommonUtil.getDefaultStr(request.getParameter("EncodingType"), "");
    String OfferingPeriod = CommonUtil.getDefaultStr(request.getParameter("OfferingPeriod"), "");
    String device         = CommonUtil.getDefaultStr(request.getParameter("device"), "");
    String svcCd          = CommonUtil.getDefaultStr(request.getParameter("svcCd"), "");        // 지불수단
    String svcPrdtCd      = CommonUtil.getDefaultStr(request.getParameter("svcPrdtCd"), "");    // sub지불수단

    String OrderCode        = CommonUtil.getDefaultStr(request.getParameter("OrderCode"),"");
    String User_ID          = CommonUtil.getDefaultStr(request.getParameter("User_ID"), "");
    String Pg_Mid           = CommonUtil.getDefaultStr(request.getParameter("Pg_Mid"), "");
    String BuyerCode        = CommonUtil.getDefaultStr(request.getParameter("BuyerCode"), "");
    String FORWARD	    	= CommonUtil.getDefaultStr(request.getParameter("FORWARD"), "Y");
    String webview	    	= CommonUtil.getDefaultStr(request.getParameter("webview"), "");
    String EncryptData      = CommonUtil.getDefaultStr(request.getParameter("EncryptData"), "");   // 거래검증값 추가(2018.08 hans)
    String ediDate          = CommonUtil.getDefaultStr(request.getParameter("ediDate"), "");
    String Currency			= CommonUtil.getDefaultStr(request.getParameter("Currency"), "KRW");
    String DutyFreeAmt		= CommonUtil.getDefaultStr(request.getParameter("DutyFreeAmt"), "0");	// 면세관련 필드 추가 (2019.04 hans)
    String TaxAmt			= CommonUtil.getDefaultStr(request.getParameter("Amt"), "0");			// 면세관련 필드 추가 (2019.04 hans)
    String RefererURL		= CommonUtil.getDefaultStr(request.getParameter("RefererURL"), "");			// Referer URL 추가 (2019.04 hans)
/**
	인증결제 면세금액 적용관련
	- 기존 Amt 파라미터를 변경하지 않고 과세금액 필드(TaxAmt) 추가
	  Amt = TaxAmt + DutyFreeAmt 로 인증처리후 최종 승인단계에서 금액을 다시 분리해 준다.
**/
    Amt = String.valueOf(Long.parseLong(TaxAmt)+Long.parseLong(DutyFreeAmt));
    
    // 1. TID 생성

    TID = KeyUtils.genTID(MID, svcCd, svcPrdtCd);
    // 2. 주문번호 특수문자 체크
    if(CommonUtil.isSpecialChar(Moid)) {
        System.out.println("**********[주문번호가 유효하지 않습니다]**********");
        throw new Exception("W001");
    }
    // 3. 상점정보(resMemberInfo) 존재 유무 확인
    Box req = new Box();
    Box resMemberInfo = null;
    req.put("svc_cd",svcCd);
    req.put("svc_prdt_cd",svcPrdtCd);
    req.put("mid", MID);
    req.put("today_dt", TimeUtils.getyyyyMMdd());
    req.put("amt", Amt);
    // To-do 카드 코드 파라미터 추가, 가맹점에서 카드코드를 셋팅하는 경우
    req.put("bank_cd",formBankCd);
    System.out.println("formBankCd = "+formBankCd);
    resMemberInfo = CommonBiz.getMemberInfo(req);

    if(resMemberInfo == null) {
        System.out.println("**********[상점정보가 없습니다]**********");
        throw new Exception("W006");
    }
    co_no       = resMemberInfo.getString("co_no");             // 사업자 번호(가맹점)
    co_nm       = resMemberInfo.getString("co_nm");             // 상호(가맹점)
    auth_flg    = resMemberInfo.getString("auth_flg");          // tb_merchant(auth_flg) [ 01:KeyIn 02:인증]
    // 가맹점이 인증 인지 비인증인지 구분은 tb_merchant.auth_flg 로만 한다.
    // 기존 VAN 연동시 카드사별로 설정된 값을 가져와 셋팅하는 부분 삭제
    if(!PayMethod.equals("CKEYIN") && (StringUtils.isEmpty(auth_flg)||!"02".equals(auth_flg))){
    	System.out.println("**********[상점정보 오류(인증가맹점 아님)]**********");
        throw new Exception("W010");
    }
    // 4. 해당 가맹점 결제정보 설정 PG+VAN
    CardSvc cs = new CardSvc();
    
    // getBaseInstmnMap(MID, Amt, 최대할부개월수)
    // 기본할부개월수 설정({"00":"일시불"},{"02":"2개월"} ...) >> JSONArray
    String quotabase = cs.getBaseInstmnMap(MID, Amt, 12);
//    System.out.println("==== quotabase ["+quotabase+"]");
    
    String ispArray = CommonUtil.ispArray;         // isp list - card code
    String visa3dArray = CommonUtil.visa3dArray;   // visa3d list - card code
    // 키인결제는 앞단계에서 구분되어야 함
    String keyinArray = "[]";                      // key-in list - card code
    
    // [해외카드]      
    String foreignCardArray = CommonUtil.foreignCardArray;
//System.out.println("foreignCardArray ["+foreignCardArray+"]");    
    // [포인트결제] >> 추후 기능 추가
    
    // 가맹점 카드 기본정보 조회 >> JSONArray
    String cardInfoMap = cs.getCardInfoMap(MID);
//System.out.println("cardInfoMap ["+cardInfoMap+"]");
    
    // 카드 리스트
    /*
    CardListVO clVO = cs.getCardList(cardInfoMap);
    String CardAllList = clVO.getAllList();
    String CardMajorList = clVO.getMajorList();
    String CardMinorList = clVO.getMinorList();
    String CardOverList = clVO.getOverList();
    */
    CardListVO clVO2 = cs.getCardList2(cardInfoMap);
    String CardMajorList2 = clVO2.getMajorList();
//System.out.println("CardMajorList2 ["+CardMajorList2+"]");
    String CardMinorList2 = clVO2.getMinorList();
    String CardOverList2 = clVO2.getOverList();
    
    // ISP 할부정보
    String kvpQuota = cs.getKvpQuota(quotabase);
    
    // ilk MPI 설정 >> 확인 해봐야 할 부분 testReturn.jsp 역할  
    String prot = request.getScheme();
    String curPage = HttpUtils.getRequestURL(request).toString();
    String returnPage = prot + curPage.substring(curPage.indexOf(':'), curPage.lastIndexOf('/')) + "/ilk/testReturn.jsp";
%>