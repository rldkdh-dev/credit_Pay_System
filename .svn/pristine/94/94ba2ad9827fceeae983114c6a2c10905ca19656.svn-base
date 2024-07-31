package util;

import java.sql.Timestamp;
import java.util.Iterator;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CommonUtil {
	private static final Logger logger = LoggerFactory.getLogger(CommonUtil.class);

	// 카드사별 인증 구분 static String 처리 
	// 비씨,국민,우리,광주,수협,전북,산업은행,제주,신협
	// 2017.10 추가 우체국, 저축은행, 새마을금고, 중국은행, 교보증권, 유안타증권, 동부증권, KB증권, 유진투자증권, 미래에셋증권, SK증권, NH투자증권, 케이뱅크, 카카오뱅크
	public static final String ispArray = "['01','02','21','13','22','24','23','14','32','33','35','36','37','38','39','40','41','42','43','44','45','46']";
	// 삼성,신한,현대,롯데,씨티,NH농협,하나, 외환
	public static final String visa3dArray = "['04','06','07','08','11','12','16','03','15']";
	// 비자,마스터,다이너스,AMX,JCB
	public static final String foreignCardArray = "['25','26','27','28','29']";
	
	public CommonUtil() {}
	
	/**
	 *  문자열을 특정 길이로 자르는 함수
	 *  2016.02.04
	 **/
	public static String cutStr(String str, int length) { 
	    byte[] bytes = str.getBytes();
 
	    int len = bytes.length; 
	    int counter = 0; 
	    
	    if (length >= len) {
	        return str; 
	    } 
	    
	    for (int i = length - 1; i >= 0; i--) { 
	        if (((int)bytes[i] & 0x80) != 0) 
	            counter++; 
	    } 
	    
	    String f_str = null; 
	    f_str = new String(bytes, 0, length - (counter % 2)); 
	    
	    return f_str.trim(); 
	}
	/**
	 * 입력에 대해 NULL,혹은 길이가 없을 경우
	 * 기본 문자열 셋을 리턴한다.
	 */
	public static String getDefaultStr(String src, String defaultStr) {
		if (src == null || src.trim().length() < 1) {
			if (defaultStr == null) { return ""; }
			return defaultStr;
		}
		return src;
	}
	/**
	 * 문자열 받아서 콤마(,) 붙이기
	 */
	public static String setComma(String strNum) {
		if(strNum.equals("")) {
			return "0";
		}

		String tmp1 = "";
		String tmp2 = "";
		tmp1 = strNum;

		while ( tmp1.length() > 3 ) {
			tmp2 = "," + tmp1.substring(tmp1.length() - 3, tmp1.length()) + tmp2;
			tmp1 = tmp1.substring(0, tmp1.length() - 3);
		}
		return tmp1 + tmp2;
	}
	/**
	 * 문자열 받아서 특수문자 check 하기
	 */
	public static boolean isSpecialChar(String checkStr) {
		boolean isSpecial = false;
		String strSpecialChar = "~`':;{}[]<>,.!@#$%^&*()_+|\\/?";

		for( int i = 0; i < checkStr.length(); i++ ) {
			char ch = checkStr.charAt(i);
			for( int j = 0; j < strSpecialChar.length(); j++ ) {
				if(ch == strSpecialChar.charAt(j)) {
					isSpecial = true;
					break;
				}
				else {
					isSpecial = false;
				}
			}
		}
		return isSpecial;
	}
	/**
	 * 1000원 미만 확인
	 */
	public static String isBelow1000(String amt) throws Exception {
		String retVal = "0";
		long below1000 = new Long(amt).longValue();
		
		if(below1000 < 1000) { 
			retVal = "1";
		}
		
		return retVal;
	}
	/**
	 * '0'으로 채우기
	 */
	public static String fixSizeZero(String str, int size) {
		if ( str != null && size > 0) {
			int len = str.getBytes().length;
			
			if (len < size) {
				for (int inx = 0; inx < size - len; inx++) {
					str = "0" + str;
				}
			} else if (len > size) {
				str = new String(str.getBytes(), 0, size);
			}
		}

		if ( str == null && size > 0) {
			char[] zeros = new char[size];
			for (int inx = 0; inx < size; inx++) {
				zeros[inx] = '0';
			}
			str = new String(zeros);
		}
		
		return str;
	}
	/**
	 * TID validation
	 * TID			- mnbank001m01010902111528567315
	 * MID			- mnbank001m
	 * svcCd		- 01
	 * svcPrdtCd	- 01
	 * yymmdd		- 090212
	 */
	public static String isValidTID(String TID, String MID, String svcCd, String svcPrdtCd, String yymmdd) throws Exception {
		String retVal = "";
		String rcvMID = "";
		String rcvSvcCd = "";
		String rcvPrdtCd = "";
		String rcvYYMMDD = "";
		
		
		if(TID.length() == 30) {
			rcvMID		= TID.substring(0, 10);
			rcvSvcCd	= TID.substring(10, 12);
			rcvPrdtCd	= TID.substring(12, 14);
			rcvYYMMDD	= TID.substring(14, 20);
			
			if(rcvMID.equals(MID)) {
				if(rcvSvcCd.equals(svcCd)) {
					if(rcvPrdtCd.equals(svcPrdtCd)) {
						if(rcvYYMMDD.equals(yymmdd)) {
							// 정상처리
							retVal = "00";
						}else{
							// 날짜오류
							retVal = "05";
						}
					}else{
						// 결제매체 오류
						retVal = "04";
					}
				}else{
					// 지불수단  오류
					retVal = "03";
				}
			}else{
				// MID 오류
				retVal = "02";
			}
		}
		else {
			// 길이 체크 오류
			retVal = "01";
		}
		return retVal;
	}
	/**
	 * 기준날짜에서 몇일 전,후의 날짜를 구한다.
	 *
	 * @param	sourceTS 기준날짜
	 * @param	day		 변경할 일수
	 * @return	기준날짜에서 입력한 일수를 계산한 날짜
	 */
	public static Timestamp getTimestampWithSpan(Timestamp sourceTS, long day) throws Exception {
		Timestamp targetTS = null;
		
		if (sourceTS != null) {
			targetTS = new Timestamp(sourceTS.getTime() + (day * 1000 * 60 * 60 * 24));
		}

		return targetTS;
	}
	
	/**
     *  DB 캐리지 리턴값 처리
     *@param str String 개행이 포함된 원문
     *@return String  변환된 스트링
     */
    public static  String nl2br(String str) {
        str = str.replaceAll("\\[", "");  // text 형식에 앞에 붙음.
        str = str.replaceAll("\\]", "");  // text 형식에 뒤에 붙음.
        str = str.replaceAll("\r\n", "<br>");
        str = str.replaceAll("\r", "<br>");
        str = str.replaceAll("\n", "<br>");  
        return str;
     }
	/**
	 * GET URL 생성
	 * @param url
	 * @param obj
	 * @return
	 */
	public static String getURLStr(String url, JSONObject obj) {
	    if(obj==null) return "";
	    Iterator<String> it = obj.keySet().iterator();
	    StringBuffer sb = new StringBuffer();
	    
	    sb.append(url);
	    if(url.lastIndexOf("?")<0) { sb.append("?"); }
	    
	    String key = "";
	    while(it.hasNext()) {
            sb.append("&");
            key = it.next();
            sb.append(key);
            sb.append("=");
            sb.append(obj.get(key));
	    }
	    return sb.toString();
	}	
/*
	public static void main(String[] args) throws Exception{
		String str="[{\"00\":\"일시불\"},{\"02\":\"2개월\"}]";
		StringBuffer sb = new StringBuffer();
		JSONParser parser = new JSONParser();
		JSONArray arr = new JSONArray();
		try{
			arr = (JSONArray) parser.parse(str);
			for(int i=0;i<arr.size();i++){
				JSONObject obj = (JSONObject) arr.get(i);
				 Iterator it = obj.keySet().iterator();
				 while(it.hasNext()){
					 String key = (String) it.next();
					 sb.append(Integer.parseInt(key));
					 sb.append(":");
				 }
			}
		}catch(Exception e){
			logger.error("getKvpQuota Exception ", e);
		}
		String str1 = sb.toString();
		if(str1.lastIndexOf(":")==(str1.length()-1)){
			str1= str1.substring(0,str1.length()-1);
		}
		System.out.println(str1);
		
	}
*/
	
} // end class

