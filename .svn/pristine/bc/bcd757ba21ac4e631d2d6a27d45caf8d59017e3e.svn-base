<%
/******************************************************************************
*
*	@ SYSTEM NAME		: 카드 이벤트 처리
*	@ PROGRAM NAME		: cardEventProcess.jsp
*	@ MAKER				: 
*	@ MAKE DATE			: 2009.04.02
*	@ PROGRAM CONTENTS	: 카드 이벤트 처리
*
************************** 변 경 이 력 *****************************************
* 번호	작업자		작업일				변경내용
*******************************************************************************/ 
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	boolean isCardInterest = false;
	// 무이자여부 판단
	//  '0' 일반, '1' 무이자	
	
	//if(CardInterest.equals("0")) {
	
	    Box ninstFeeBox = null;
		Box eventMerchantBox = null;
		Box eventCardBox = null;
		
		// 카드사 이벤트 적용여부 판단
		req.put("mid",          MID);
		req.put("today_dt",     TimeUtils.getyyyyMMdd());
		req.put("amt",          Amt);
		req.put("fn_cd",        formBankCd);
		req.put("svc_prdt_cd",  CommonConstants.SVC_PRDT_CD_ONLINE);
		req.put("mon_id",       CardQuota);
		
		//ninstFeeBox = CommonBiz.getNinstFee(req);
		//if(ninstFeeBox.getLong("cnt") > 0)
		//    isCardInterest = true;
	
		// 카드사 이벤트 체크
		boolean isEventCard = false;
		List<Box> listEventCard = CommonBiz.getEventCardCode(req);
		
		if(listEventCard.size() > 0){
			
			eventCardBox = isEventCard(listEventCard, req);
			if(eventCardBox != null){
				String instmn_mm = eventCardBox.getString("instmn_mm");
				if(isBetweenInstmnNm(instmn_mm, CardQuota)) {
					isEventCard = true;
				}
			}
		}
			
	
		// 카드사이벤트 체크
		//if(eventCardBox != null && isCardInterest == false) {
			//String instmn_mm_fr = eventCardBox.getString("instmn_mm_fr");
			//String instmn_mm_to = eventCardBox.getString("instmn_mm_to");
		//	String instmn_mm = eventCardBox.getString("instmn_mm");
			
			//if(isBetweenInstmnNm(instmn_mm, CardQuota)) {
		    	//isCardInterest = true;
			//}
		//}  
		System.out.print("isEventCard ["+isEventCard+"]");
		// 상점이벤트 체크
		// 카드사 이벤트 진행시에는 무시
		List<Box> listEventMerchant = null;
		if(isEventCard == false) {
			listEventMerchant = CommonBiz.getEventMerchant(req);
			eventMerchantBox = isEventMerchant(listEventMerchant, req);
		}
		System.out.print("eventMerchantBox ["+eventMerchantBox+"]");
		// 상점이벤트 체크
		if(eventMerchantBox != null && isCardInterest == false) {
			String instmn_mm = eventMerchantBox.getString("instmn_mm");
			
			if(isMatchInstmnNm(instmn_mm, CardQuota)) {
				isCardInterest = true;
			}
		}
	//}
%>