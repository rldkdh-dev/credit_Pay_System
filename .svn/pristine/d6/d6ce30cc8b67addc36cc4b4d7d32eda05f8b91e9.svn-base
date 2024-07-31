package util;

/**
 * CardUtil.java Class is Designed for providing 
 *
 * Copyright    Copyright (c) 2016
 * Company      Infinisoft Co.
 *
 * @Author      : 김봉민
 * @File        : util.CardUtil.java
 * @Version     : 1.0,
 * @See         : 
 * @Description : 
 * @Date        : 2017. 6. 27. - 오전 10:26:21
 * @ServiceID:
 * @VOID:
 * @Commnad:
 *
 **/

import java.util.Collections;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

import kr.co.infinisoft.pg.common.biz.CommonBiz;
import kr.co.infinisoft.pg.document.Box;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CardUtil {
	private static final Logger logger = LoggerFactory
			.getLogger(CardUtil.class);

	public CardUtil() {	}
	
	public static String generateQuotabase(String mid){
	    try{
	        StringBuffer sb = new StringBuffer();
	        Box box = new Box();
	        box.put("mid",mid);
	        Box instnmBox = CommonBiz.getMerchantLimitInstNmByMid(box);
	        String limitInstmn = instnmBox.getString("limit_instmn");
	        int limitInstmnTypeInt = Integer.parseInt(limitInstmn);
	        sb.append("일시불");
	        if(limitInstmnTypeInt>=2){
	            for(int i = 2 ; i<=limitInstmnTypeInt ; i++){
	                sb.append(":");
	                sb.append(i+"개월");
	            }
	        }
	        return sb.toString();
	    }catch(Exception e){
	        e.printStackTrace();
	        return "일시불:2개월:3개월:4개월:5개월:6개월:7개월:8개월:9개월:10개월:11개월:12개월";
	    }
	    
	 }
	
	
    public static String generateIspArrayJavaScript(List<Box> list){
	    StringBuffer sb = new StringBuffer();
	    sb.append("[");
	    if(list!=null){
	        for(Box box : list){
	            String auth_type = box.getString("auth_type");
	            String fn_cd = box.getString("fn_cd");
	            if("02".equals(auth_type)){
	                sb.append("'").append(fn_cd).append("',");
	            }
	            
	        }
	        sb.append("]");
	        return sb.toString().replaceAll(",]","]");
	    }else{
	        return "[]";
	    }
	}
	
	
    public static String generateVisa3dArrayJavaScript(List<Box> list){
	    StringBuffer sb = new StringBuffer();
	    sb.append("[");
	    if(list!=null){
	        for(Box box : list){
	            String auth_type = box.getString("auth_type");
	            String fn_cd = box.getString("fn_cd");
	            if("03".equals(auth_type)){
	                sb.append("'").append(fn_cd).append("',");
	            }
	            
	        }
	        sb.append("]");
	        return sb.toString().replaceAll(",]","]");
	    }else{
	        return "[]";
	    }
	}
	
    public static String generateKeyinArrayJavaScript(List<Box> list){
	    StringBuffer sb = new StringBuffer();
	    sb.append("[");
	    if(list!=null){
	        for(Box box : list){
	            String auth_type = box.getString("auth_type");
	            String fn_cd = box.getString("fn_cd");
	            if("01".equals(auth_type)){
	                sb.append("'").append(fn_cd).append("',");
	            }
	        }
	        sb.append("]");
	        return sb.toString().replaceAll(",]","]");
	    }else{
	        return "[]";
	    }
	}
	
    public static String generateForeignCardArrayJavaScript(List<Box> list){
	    StringBuffer sb = new StringBuffer();
	    sb.append("[");
	    if(list!=null){
	        for(Box box : list){
	            String code1 = box.getString("code1");
	            sb.append("'").append(code1).append("',");
	        }
	        sb.append("]");
	        return sb.toString().replaceAll(",]","]");
	    }else{
	        return "[]";
	    }
	}
	 
	
    public static String generateKeyinHashmapJavaScript(List<Box> list, String varName){
	    if(list!=null){
	        StringBuffer sb = new StringBuffer();
	        for(Box box : list){
	            String auth_type = box.getString("auth_type");
	            String fn_cd = box.getString("fn_cd");
	            String key_in_cl =  box.getString("key_in_cl");
	            if("01".equals(auth_type)){
	                sb.append(varName).append("['").append(fn_cd).append("']=").append("'").append(key_in_cl).append("';");
	            }
	        }
	        return sb.toString();
	    }else{
	        return "";
	    }
	}
	
    public static String generateOtherCardArrayJavaScript(List<Box> list){
	    StringBuffer sb = new StringBuffer();
	    sb.append("[");
	    if(list!=null){
	        for(Box box : list){
	            String card_cd = box.getString("code1");
	            sb.append("'").append(card_cd).append("',");
	        }
	        sb.append("]");
	        return sb.toString().replaceAll(",]","]");
	    }else{
	        return "[]";
	    }
	}
	
    public static String generatePointArrayJavaScript(String list){
	    StringBuffer sb = new StringBuffer();
	    list        = list.substring(1, (list.length() - 1));
	    String[] strArray = list.split(":");
	    
	    sb.append("[");
	    if(list!=null){
	        for(int i = 0; i < strArray.length; i++) {
	            String card_cd = strArray[i];
	            sb.append("'").append(card_cd).append("',");
	        }
	        sb.append("]");
	        return sb.toString().replaceAll(",]","]");
	    }else{
	        return "[]";
	    }   
	}
	
    public static String generateChainNoArrayJavaScript(List<Box> list){
	    StringBuffer sb = new StringBuffer();
	    sb.append("[");
	    if(list!=null){
	        for(Box box : list){
	            String fn_cd = box.getString("fn_cd");
	            String fn_no = box.getString("fn_no");
	            sb.append("'").append(fn_cd).append(":").append(fn_no).append("',");
	        }
	        sb.append("]");
	        return sb.toString().replaceAll(",]","]");
	    }else{
	        
	        return "[]";
	    }
	}
    
    /**
     * 무이자이벤트 대상 카드여부 확인
     * tempStr : [01-02:03:04:05,]
     * cardcode : 01, 02 ...
     */
    public static boolean checkNointCardCode(String tempStr, String cardcode){
    //  System.out.println("temptStr ["+tempStr+"]");
    //  System.out.println("cardcode ["+cardcode+"]");
        boolean ret = false;
        if(StringUtils.isEmpty(tempStr)){
            ret = false;
        }else{
            String[] arr = tempStr.split(",");
            for(int i=0 ; i < arr.length ;i++){
                String[] code = arr[i].split("-");
                if(code[0].equals(cardcode)){
                    return true;
                }
            }
        }
        
        return ret;
    }
	
	/**
	 * tb_event_card에서 가져온 정보와 (카드사 코드, 가격) 매칭 여부 판단
	 * 01-02:03:04:05:06:07:08:09,02-02:03:04,04-02:03:04:05:06 스트링 만들어 준다.
	 * @param	list	tb_event_card
	 * @param	box		카드사코드, 가격
	 */
	public static String mkEventCard(List<Box> list, Box box) throws Exception {
	    String retVal = "";
	    
	    if(list == null) return retVal;
		
		long amt = box.getLong("amt");
		
		for(int inx = 0; inx < list.size(); inx++) {
			Box eventCardBox = (Box)list.get(inx);
			
			String event_fn_cd		= eventCardBox.getString("fn_cd");
			long event_amt			= eventCardBox.getLong("event_amt");
			String instmn_mm		= eventCardBox.getString("instmn_mm");
			//String instmn_mm_to		= eventCardBox.getString("instmn_mm_to");
			
			// 이벤트 최소 금액
			if(amt >= event_amt) {
	    		retVal += event_fn_cd + "-";
			    /*
	    		for(int jnx = Integer.parseInt(instmn_mm_fr); jnx <= Integer.parseInt(instmn_mm_to); jnx++) {
			        if(jnx == Integer.parseInt(instmn_mm_to)) {
			            retVal += (jnx < 10 ? "0" + jnx : jnx);
			        }
			        else {
	    		        retVal += (jnx < 10 ? "0" + jnx : jnx) + ":";
	    		    }
			    }
			    */
			    retVal+=instmn_mm;
			    
			    if((inx + 1) != list.size()) {
			        retVal += ",";
			    }
			}
		}
		
	    return "(" + retVal + ")";
	}

	/**
	 * tb_event_card에서 가져온 정보와 (카드사 코드, 가격) 매칭 여부 판단
	 * @param	list	tb_event_card
	 * @param	box		카드사코드, 가격
	 */
	public static Box isEventCard(List<Box> list, Box box) throws Exception {
		Box retVal = null;
		
		if(list == null) return retVal;
		
		long amt = box.getLong("amt");
		String fn_cd = box.getString("fn_cd");
		
		for(int inx = 0; inx < list.size(); inx++) {
			Box eventCardBox = (Box)list.get(inx);
			
			String event_fn_cd		= eventCardBox.getString("fn_cd");
			String card_detail_cd	= eventCardBox.getString("card_detail_cd");
			long event_amt			= eventCardBox.getLong("event_amt");
			String instmn_mm = eventCardBox.getString("instmn_mm");
			//String instmn_mm_fr		= eventCardBox.getString("instmn_mm_fr");
			//String instmn_mm_to		= eventCardBox.getString("instmn_mm_to");
			String event_fr_dt		= eventCardBox.getString("event_fr_dt");
			String event_to_dt		= eventCardBox.getString("event_to_dt");
			String event_cl			= eventCardBox.getString("event_cl");
			String event_flag		= eventCardBox.getString("event_flag");
			String reg_dt			= eventCardBox.getString("reg_dt");
			
			// 이벤트적용 카드 여부 판단
			if(event_fn_cd.equals(fn_cd)) {
				// 이벤트 최소 금액
				if(amt >= event_amt) {
					retVal = eventCardBox;
				}
			}
		}
		
		return retVal;
	}

	/**
	 * tb_event_merchant에서 가져온 정보를 이용해서
	 * 01-02:03:04:05:06:07:08:09,02-02:03:04,04-02:03:04:05:06 스트링 만들어 준다.
	 * @param	list	tb_event_merchant
	 * @param	box		가격
	 */
	public static String mkEventMerchant(List<Box> list, Box box) throws Exception {
	    String retVal = "";
	    
	    if(list == null) return retVal;
		
		long amt = box.getLong("amt");
		
		for(int inx = 0; inx < list.size(); inx++) {
			Box eventMerchantBox = (Box)list.get(inx);
			
			String event_fn_cd		= eventMerchantBox.getString("fn_cd");
			String card_detail_cd	= eventMerchantBox.getString("card_detail_cd");
			long event_amt			= eventMerchantBox.getLong("event_amt");
			String instmn_mm		= eventMerchantBox.getString("instmn_mm");
		
			// 이벤트 최소 금액
			if(amt >= event_amt) {
			    if(retVal.length() > 0) {
			        retVal += ",";
			    }
		        retVal += event_fn_cd + "-" + instmn_mm;
			}
		}
		
	    return "(" + retVal + ")";
	}

	/**
	 * tb_event_merchant에서 가져온 정보를 이용해서
	 * @param	list	tb_event_merchant
	 * @param	box		가격
	 */
	public static Box isEventMerchant(List<Box> list, Box box) throws Exception {
		Box retVal = null;
		
		if(list == null) return retVal;
		
		long amt = box.getLong("amt");
		String fn_cd = box.getString("fn_cd");
		
		for(int inx = 0; inx < list.size(); inx++) {
			Box eventMerchantBox = (Box)list.get(inx);
			
			String mid				= eventMerchantBox.getString("mid");
			String event_fn_cd		= eventMerchantBox.getString("fn_cd");
			String card_detail_cd	= eventMerchantBox.getString("card_detail_cd");
			long event_amt			= eventMerchantBox.getLong("event_amt");
			String instmn_mm		= eventMerchantBox.getString("instmn_mm");
			String event_fr_dt		= eventMerchantBox.getString("event_fr_dt");
			String event_to_dt		= eventMerchantBox.getString("event_to_dt");
			String event_cd			= eventMerchantBox.getString("event_cd");
			String event_flag		= eventMerchantBox.getString("event_flag");
			String auto_delay		= eventMerchantBox.getString("auto_delay");
			String dc_amt			= eventMerchantBox.getString("dc_amt");
			String status			= eventMerchantBox.getString("status");
			String reg_dt			= eventMerchantBox.getString("reg_dt");
			
			// 이벤트적용 카드 여부 판단
			if(event_fn_cd.equals(fn_cd)) {
				// 이벤트 최소 금액
				if(amt >= event_amt) {
					retVal = eventMerchantBox;
				}
			}
		}
		
		return retVal;
	}

	/**
	 * 할부개월 표시 (02:03 -> 2,3)
	 * @param instmn_mm
	 */
	public static String convertInstmnNm(String instmn_mm) {
		String retVal = "";
		
		if(instmn_mm == null) return retVal;
		
		String strTemp = "";
		String[] strArray = instmn_mm.split(":");
		
		for(int i = 0; i < strArray.length; i++) {
			int temp = new Integer(strArray[i]);
			
			strTemp += temp;
			
			if((i + 1) != strArray.length) {
				strTemp += ",";
			}
		}
		
		retVal = strTemp;
		
		return retVal;
	}

	/**
	 * 할부개월 시작과 끝 사이에 있는지 판단
	 * @param   instmn_mm_fr    할부개월 시작
	 * @param   instmn_mm_to    할부개월 끝
	 */
	public static boolean isBetweenInstmnNm(String instmn_mm, String cardQuota) {
		boolean retVal = false;
		
		if(instmn_mm == null) return retVal;
		/*
		int i_mm_fr = Integer.parseInt(instmn_mm_fr);
		int i_mm_to = Integer.parseInt(instmn_mm_to);
		
		
		int i_c_quota = Integer.parseInt(cardQuota);
		
		if(i_c_quota >= i_mm_fr && i_c_quota <= i_mm_to) {
		    retVal = true;
		}
		*/
		String[] strArray = instmn_mm.split(":");
		
		for(int i = 0; i < strArray.length; i++) {
			int temp = new Integer(strArray[i]);
			int icardQuota = new Integer(cardQuota);
			
			if(temp == icardQuota) {
				retVal = true;
				break;
			}
		}
		
		return retVal;
	}

	/**
	 * 할부개월 매칭 체크 (02:03 -> 02)
	 * @param instmn_mm
	 * @param cardQuota
	 * @return
	 */
	public static boolean isMatchInstmnNm(String instmn_mm, String cardQuota) {
		boolean retVal = false;
		
		if(instmn_mm == null) return retVal;

		String[] strArray = instmn_mm.split(":");
		
		for(int i = 0; i < strArray.length; i++) {
			int temp = new Integer(strArray[i]);
			int icardQuota = new Integer(cardQuota);
			
			if(temp == icardQuota) {
				retVal = true;
				break;
			}
		}
		
		return retVal;
	}

	/**
	 *  금액을 지정된 칸에 입력한다. 
	 * @param cost 금액
	 * @param tdCount 한줄당 총 td의 갯수 - 1 (1:height값이 들어가있는 td)
	 * @return rtnBlock 
	 */
	public static String blockIn(String cost , int tdCount){
		StringBuffer  rtnBlock	= new StringBuffer();
		try{
				int a=0;
				for(int i = 0 ; i < tdCount ; i++){
					if(tdCount - cost.length() <= i){
						rtnBlock.append("<td class='font_sbtext'>"+cost.substring(a , a+1)+"</td>");
						a++;
					}else {
						rtnBlock.append("<td class='font_sbtext'>&nbsp;</td>");	
					}	
				}
			}catch(Exception e){
				e.getMessage();
			}
		return rtnBlock.toString();
	}

	/**
	 * 결제수단 매칭 체크
	 * @param svc_cds
	 * @param svc_cd
	 * @return
	 */
	public static boolean isMatchSvcCd(String svc_cds, String svc_cd) {
		boolean retVal = false;
		
		if(svc_cds == null) return retVal;

		String[] strArray = svc_cds.split(",");
		
		for(int i = 0; i < strArray.length; i++) {
			int temp = new Integer(strArray[i]);
			int isvc_cd = new Integer(svc_cd);
			
			if(temp == isvc_cd) {
				retVal = true;
				break;
			}
		}
		
		return retVal;
	}

	/**
	 * 상점에서 올려준 카드사 무이자 추출해 내기
	 * (11-3:6,12-3) -> 11-3:6,12-3
	 */
	public static String noIntStr(String str) throws Exception {
		String retVal = null;
		
		if(str.indexOf("(") > -1 && str.indexOf(")") > -1) {
			retVal = str.substring(str.indexOf("(") + 1, str.indexOf(")"));
		}
		else {
			retVal = "";
		}	
		return retVal;
	}

	/**
	 * 1. web_event 에서 올려준 카드사 무이자
	 * 2. tb_event_card 카드사 무이자
	 * 3. tb_event_merchant 카드사 무이자
	 * 위의 세 가지 경우를 합쳐서 String으로 돌려준다.
	 * @param   str1: 일시불:2개월:3개월:4개월:5개월:6개월:xxx
	 * @param   str2: 카드사 이벤트(tb_event_card)
	 * @param   str3: 상점 이벤트(tb_event_merchant)
	 */
	public static String mergeNoIntStr(String str1, String str2, String str3) throws Exception {
		
		String retVal = null;
	    String totalNoInt = null;
			
		String webEvent = noIntStr(str1);
	    String cardEvent = noIntStr(str2);  
	    String midEvent = noIntStr(str3);
		
		if ( webEvent.equals("") ) {	webEvent = "00-00";	} 
		if ( cardEvent.equals("") ) {	cardEvent = "00-00";	} 
		if ( midEvent.equals("") ) {	midEvent = "00-00";	}
		
		totalNoInt = ( webEvent + "," + cardEvent + "," + midEvent);
		
		String[] rowCodeArr = totalNoInt.split(",");
		String[] itemCodeArr = null;
		Hashtable ha = new Hashtable();
		/*
		for(int i = 0; i < rowCodeArr.length; i++) {
			itemCodeArr = rowCodeArr[i].split("-");
			
			if ( itemCodeArr[0].equals("00" ) == false ) {
				ha.put(itemCodeArr[0], itemCodeArr[1]);	
			}
		}
		*/
		// 카드 이벤트부터 처리
		rowCodeArr = cardEvent.split(",");
		for(int i = 0; i < rowCodeArr.length; i++) {
			itemCodeArr = rowCodeArr[i].split("-");
			if ( itemCodeArr[0].equals("00" ) == false ) {
				ha.put(itemCodeArr[0], itemCodeArr[1]);	
			}		
		}
		
		
		

		// 상점 이벤트 처리
		rowCodeArr = midEvent.split(",");
		for(int i = 0; i < rowCodeArr.length; i++) {
			itemCodeArr = rowCodeArr[i].split("-");
			if ( itemCodeArr[0].equals("00" ) == false ) {
				if(!ha.containsKey(itemCodeArr[0])){
					ha.put(itemCodeArr[0], itemCodeArr[1]);
				}else{
					String cardEventInstMn = (String)ha.get(itemCodeArr[0]);
					if(itemCodeArr[1]!=null){
						String [] merchantQuota = itemCodeArr[1].split(":");
						for(int j = 0 ; j < merchantQuota.length; j++){
							if(!isMatchInstmnNm(cardEventInstMn,merchantQuota[j])){
								cardEventInstMn = cardEventInstMn+":"+merchantQuota[j];
							}
						}
						ha.put(itemCodeArr[0],cardEventInstMn);
					}
						
				}
			}		
		}
		
		
	    // 키들로만 구성된 집합을 추출
	    Set keySet = ha.keySet();
	    Iterator iter = keySet.iterator();
	    
	    String strTemp = "";
	    
	    // 다음키가 있는지 검사합니다. 
	    while(iter.hasNext() == true) {
	        String key = (String)iter.next(); // 키를 순차적으로 읽어 옵니다.
	        String str = (String)ha.get(key); // 키에 해당하는 값을 추출합니다.

	        if ( key.equals("00") == false ) {
	        	strTemp += key + "-" + str + ",";  
	        }
	    }
	    
	    retVal = strTemp;
		
		return retVal;
	}

	/**
	* 1. web_event 에서 올려준 카드사 무이자
	 * 2. tb_event_card 카드사 무이자
	 * 3. tb_event_merchant 카드사 무이자
	 * 위의 세 가지 경우를 합쳐서 String으로 돌려준다.
	 * @param   str1: 일시불:2개월:3개월:4개월:5개월:6개월:xxx
	 * @param   str2: 카드사 이벤트(tb_event_card)
	 * @param   str3: 상점 이벤트(tb_event_merchant)
	 */
	public static Hashtable mergeNoIntHash(String str1, String str2, String str3) throws Exception {
		
		Hashtable retVal = null;
		String totalNoInt = null;
		
		String webEvent = noIntStr(str1);
	    String cardEvent = noIntStr(str2);  
	    String midEvent = noIntStr(str3);
	    
	    if ( webEvent.equals("") ) {    webEvent = "00-00"; } 
	    if ( cardEvent.equals("") ) {   cardEvent = "00-00";    } 
	    if ( midEvent.equals("") ) {    midEvent = "00-00"; }
		
	    totalNoInt = ( webEvent + "," + cardEvent + "," + midEvent);
	    
		String[] rowCodeArr = totalNoInt.split(",");
		String[] itemCodeArr = null;
		
		Hashtable ha = new Hashtable();
		
		/*
		for(int i = 0; i < rowCodeArr.length; i++) {
			itemCodeArr = rowCodeArr[i].split("-");
			if ( itemCodeArr[0].equals("00" ) == false ) {
				ha.put(itemCodeArr[0], itemCodeArr[1]);	
			}		
		}
		*/
		// 카드 이벤트부터 처리
		rowCodeArr = cardEvent.split(",");
		for(int i = 0; i < rowCodeArr.length; i++) {
			itemCodeArr = rowCodeArr[i].split("-");
			if ( itemCodeArr[0].equals("00" ) == false ) {
				ha.put(itemCodeArr[0], itemCodeArr[1]);
			}		
		}
		
		
		

		// 상점 이벤트 처리
		rowCodeArr = midEvent.split(",");
		for(int i = 0; i < rowCodeArr.length; i++) {
			itemCodeArr = rowCodeArr[i].split("-");
			if ( itemCodeArr[0].equals("00" ) == false ) {
				if(!ha.containsKey(itemCodeArr[0])){
					ha.put(itemCodeArr[0], itemCodeArr[1]);
				}else{
					String cardEventInstMn = (String)ha.get(itemCodeArr[0]);
					if(itemCodeArr[1]!=null){
						String [] merchantQuota = itemCodeArr[1].split(":");
						for(int j = 0 ; j < merchantQuota.length; j++){
							if(!isMatchInstmnNm(cardEventInstMn,merchantQuota[j])){
								cardEventInstMn = cardEventInstMn+":"+merchantQuota[j];
							}
						}
						ha.put(itemCodeArr[0],cardEventInstMn);
					}
						
				}
			}		
		}
	    retVal = ha;
	    //System.out.print("**********[retValH : " +  retVal);
		return retVal;
	}

	/**
	 * 메이저 카드코드사 코드
	 * @param   list
	 * @return  retVal  01:02:03:04:06:07:08
	 */
	public static String mkCardCdStr(List<Box> list) throws Exception {
	    String retVal = "";
	    for(int inx = 0; inx < list.size(); inx++) {
	        Box majorCardCode = (Box)list.get(inx);
	        if((inx + 1) == list.size()) {
	            retVal += majorCardCode.getString("code1");
	        }
	        else {
	            retVal += majorCardCode.getString("code1") + ":";
	        }
	    }
	    return retVal;
	}

	/**
	 * 메이저 카드사 코드 Hashtable 리턴
	 * @param   list
	 * @return  retVal  Hashtable
	 */
	public static Hashtable mkCardCdHash(List<Box> list) throws Exception {
	    Hashtable retVal  = new Hashtable();
	    
	    for(int inx = 0; inx < list.size(); inx++) {
	        Box majorCardCode = (Box)list.get(inx);
	        retVal.put(majorCardCode.getString("code1"), majorCardCode.getString("desc1"));
	    }
	    
	    return retVal;
	}

	/**
	 * 포인트사용가능 Hashtable 리턴
	 * @param   list
	 * @return  retVal  Hashtable
	 */
	public static Hashtable mkPointHash(String list) throws Exception {
	    Hashtable retVal  = new Hashtable();
	    if(list.length() > 0)
	    	list = list.substring(1, (list.length() - 1));

	    String[] point_list = list.split(":");
	    
	    for(int inx = 0; inx < point_list.length; inx++) {
	        retVal.put(point_list[inx], point_list[inx]);
	    }
	    
	    return retVal;
	}

	/**
	 * 카드 코드, 가맹점 번호 Hashtable 리턴
	 * @param   list
	 * @return  retVal  Hashtable
	 */
	 /*
	public static Hashtable mkFnCdFnNoHash(List<Box> list) throws Exception {
	    Hashtable retVal  = new Hashtable();
	    
	    for(int inx = 0; inx < list.size(); inx++) {
	        Box temp = (Box)list.get(inx);
	        retVal.put(temp.getString("fn_cd"), temp.getString("fn_no"));
	    }
	    
	    return retVal;
	}
	*/
	/**
	 * 메이저 카드사 코드 뿌려주기
	 */
	public static String displayPurCardNo(String purCardNo, String card_use,
	    String card_block, Hashtable hash, String otherCardCode, Hashtable otherCardCodeHash, Hashtable eventHash, Hashtable pointHash) throws Exception {
		// Hashtable data set
		Hashtable<String, String> card_use_ha = new Hashtable<String, String>();
		Hashtable<String, String> card_block_ha = new Hashtable<String, String>();
		// return string
		StringBuffer sb = new StringBuffer();
		
		String[] card_use_arr = card_use.split(":");
		
		// tb_code에서 pur card_no 가져와서 card_use와 비교한다. (메이저 카드사 경우)
		// 사용카드사 Hashtable 생성
		for(int j = 0; j < card_use_arr.length; j++) {
			if(StringUtils.contains(purCardNo, card_use_arr[j])) {
				card_use_ha.put(card_use_arr[j], card_use_arr[j]);
			}
		}

		Set<String> keySet = card_use_ha.keySet();
		Iterator<String> iter = keySet.iterator();

	    if(card_block == null)
	        card_block = "";

		// 블럭카드사 Hashtable 생성
		while(iter.hasNext() == true) {
			String key = iter.next();
			String value = card_use_ha.get(key);
			if(!StringUtils.contains(card_block, value)) {
				card_block_ha.put(key, value);
			}
		}
		
		SortedMap<String, String> m = Collections.synchronizedSortedMap(new TreeMap<String, String>(card_block_ha)); 
		Set<String> s = m.keySet();
		Iterator<String> iterator = s.iterator();
		
		int hashSize = (card_block_ha.size() + 1);
		int trCnt = 0;
		int tdCnt = 4;

		if(hashSize > 0) {
			int inx = 0;

			trCnt = (int)(Math.ceil((double)hashSize/tdCnt));
			for(int i = 0; i < trCnt; i++) {
				sb.append("<tr>\n");
				for(int j = 0; j < tdCnt && iterator.hasNext(); j++) {
					if(inx < hashSize){
						String key = iterator.next();
						sb.append("<td><span class='box02'><span class='input06'>");
						sb.append("<input type='radio' name='bankcode' value='"+key+"' onClick='goCheckCard();'>"+ hash.get(key));
						// 이벤트 적용 대상 체크
						if(eventHash.containsKey(key)) {
						    sb.append("<img width='10' src='../images/box_icon01.gif'>");
						}
						// 포인트 적용 대상 체크
						if(pointHash.containsKey(key)) {
						    sb.append("<img width='10' src='../images/box_icon02.gif'>");
						}
						sb.append("</span></span></td>\n");
					}
					else {
					}
					inx++;
				}			
				sb.append("</tr>\n");
			}	
			
			if((inx + 1) == hashSize) {
				sb.append("<td colspan='10'>");
				sb.append(displayOtherCardCd(otherCardCode, card_use, card_block, otherCardCodeHash));
				sb.append("</td>\n");
			}
		}
		
		return sb.toString();
	}
	// TODO:테스트용 카드리스트 생성 클래스
	public static String displayPurCardNo2(String purCardNo, String card_use,
		    String card_block, Hashtable hash, String otherCardCode, Hashtable otherCardCodeHash, Hashtable eventHash, Hashtable pointHash) throws Exception {
			// Hashtable data set
			Hashtable<String, String> card_use_ha = new Hashtable<String, String>();
			Hashtable<String, String> card_block_ha = new Hashtable<String, String>();
	///////////////////////////////////////////////
			System.out.println("****************************************************");
			System.out.println("purCardNo "+ purCardNo);
			System.out.println("card_use "+ card_use);
			System.out.println("card_block "+ card_block);
			System.out.println("hash "+ hash.toString());
			System.out.println("otherCardCode "+ otherCardCode);
			System.out.println("otherCardCodeHash "+ otherCardCodeHash.toString());
			System.out.println("eventHash "+ eventHash.toString());
			System.out.println("pointHash "+ pointHash.toString());
			System.out.println("****************************************************");
	///////////////////////////////////////////////
			// return string
			StringBuffer sb = new StringBuffer();
			
			String[] card_use_arr = card_use.split(":");
			
			// tb_code에서 pur card_no 가져와서 card_use와 비교한다. (메이저 카드사 경우)
			// 사용카드사 Hashtable 생성
			for(int j = 0; j < card_use_arr.length; j++) {
				if(StringUtils.contains(purCardNo, card_use_arr[j])) {
					card_use_ha.put(card_use_arr[j], card_use_arr[j]);
				}
			}

			Set<String> keySet = card_use_ha.keySet();
			Iterator<String> iter = keySet.iterator();

		    if(card_block == null)
		        card_block = "";

			// 블럭카드사 Hashtable 생성
			while(iter.hasNext() == true) {
				String key = iter.next();
				String value = card_use_ha.get(key);
				if(!StringUtils.contains(card_block, value)) {
					card_block_ha.put(key, value);
				}
			}
			
			SortedMap<String, String> m = Collections.synchronizedSortedMap(new TreeMap<String, String>(card_block_ha)); 
			Set<String> s = m.keySet();
			Iterator<String> iterator = s.iterator();
			
			int hashSize = (card_block_ha.size() + 1);
			int trCnt = 0;
			int tdCnt = 4;

			if(hashSize > 0) {
				int inx = 0;
				trCnt = (int)(Math.ceil((double)hashSize/tdCnt));
				for(int i = 0; i < trCnt; i++) {
					for(int j = 0; j < tdCnt && iterator.hasNext(); j++) {
						if(inx < hashSize){
							String key = iterator.next();
							sb.append("<option value='"+key+"'>" + hash.get(key) + "</option>\n");
							// 이벤트 적용 대상 체크
							if(eventHash.containsKey(key)) {
							    sb.append("<img width='10' src='../images/box_icon01.gif'>");
							}
							// 포인트 적용 대상 체크
							if(pointHash.containsKey(key)) {
							    sb.append("<img width='10' src='../images/box_icon02.gif'>");
							}
						}
						else {
						}
						inx++;
					}			
				}	
				//TODO 기타 카드 처리 
				//if((inx + 1) == hashSize) {
				//	sb.append("<td colspan='10'>");
				//	sb.append(displayOtherCardCd(otherCardCode, card_use, card_block, otherCardCodeHash));
				//	sb.append("</td>\n");
				//}
			}
			
			return sb.toString();
		}

	public static String displayOtherCardCd(String otherCardCd, String card_use, String card_block, Hashtable hash) throws Exception {
		// return string
		StringBuffer sb = new StringBuffer();
		// Hashtable data set
		Hashtable<String, String> card_use_ha = new Hashtable<String, String>();
		Hashtable<String, String> card_block_ha = new Hashtable<String, String>();
		
	    if(card_block == null)
	        card_block = "";
	        
		String[] card_block_arr = card_block.split(":");
		String[] otherCardCdArr = otherCardCd.split(":");
		
		// 기타가드사 Hashtable 생성
		for(int j = 0; j < otherCardCdArr.length; j++) {
			card_block_ha.put(otherCardCdArr[j], otherCardCdArr[j]);
		}

		Set<String> keySet = card_block_ha.keySet();
		Iterator<String> iter = keySet.iterator();

		// 블럭카드사 Hashtable 생성
		while(iter.hasNext() == true) {
			String key = iter.next();
			String value = card_block_ha.get(key);
			if(!StringUtils.contains(card_block, value)) {
				card_use_ha.put(key, value);
			}
		}
		
		SortedMap<String, String> m = Collections.synchronizedSortedMap(new TreeMap<String, String>(card_use_ha)); 
		Set<String> s = m.keySet();
		
		synchronized(m) { // Synchronizing on m, not s! 
			Iterator i = s.iterator(); // Must be in synchronized block
			//sb.append("<select name='other_bank_code' onChange='goCheckOtherCard()'>\n");
			//sb.append("<option value=''>기타카드</option>\n");
			while(i.hasNext() == true) {
				String key = (String)i.next();
				sb.append("<option value='"+key+"'>" + hash.get(key) + "</option>\n");
			}
			//sb.append("</select>");
		}
		
		return sb.toString();
		
	}

	public static String parseISP_KVP_NOINT_INF(Hashtable<String, String> ha) throws Exception {
		String retVal = "";
		
		Set<String> keySet = ha.keySet();
		Iterator<String> iter = keySet.iterator();
		
		while(iter.hasNext() == true) {
			String key = iter.next();
			// 비씨카드
			if(key.equals("01")) {
				String value = ha.get(key);
				String[] str_arr = value.split(":");
				
				retVal += "0100-";
				
				if(str_arr.length > 0) {
					for(int i = 0; i < str_arr.length; i++) {
						if((i + 1) == str_arr.length)
							retVal += new Integer(str_arr[i]) + ",";
						else
							retVal += new Integer(str_arr[i]) + ":";
					}
				}
			}
			// 국민카드
			if(key.equals("02")) {
				String value = ha.get(key);
				String[] str_arr1 = value.split(":");
				
				retVal += "0204-";
				
				if(str_arr1.length > 0) {
					for(int i = 0; i < str_arr1.length; i++) {
						if((i + 1) == str_arr1.length)
							retVal += new Integer(str_arr1[i]) + ",";
						else
							retVal += new Integer(str_arr1[i]) + ":";
					}
				}
				
			}
		}
		
		
		if(retVal.length() > 0)
		    retVal = retVal.substring(0, (retVal.length() - 1));
		
		return retVal;
	}

	public static String parseISP_KVP_QUOTA_INF(String str) throws Exception {
		String retVal = "";
		
		if(str.indexOf("(") > 0)
			str = str.substring(0, str.indexOf("("));
		
		String[] str_arr = str.split(":");
		
		if(str_arr.length > 0) {
			for(int i = 0; i < str_arr.length; i++) {
				if(str_arr[i].equals("일시불")) {
					retVal += "0" + ":";
				}
				else if(str_arr[i].indexOf("개") > 0) {
					retVal += str_arr[i].substring(0, str_arr[i].indexOf("개")) + ":";
				}
			}
		}
		
		if(retVal.length() > 0)
		    retVal = retVal.substring(0, (retVal.length() - 1));
		
		return retVal;	
	}
	
	
} // end class

