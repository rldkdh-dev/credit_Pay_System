package mobile;

import java.security.MessageDigest;
import java.text.DecimalFormat;
import java.util.*;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;

/**
 * 
 * @author 정훈
 *
 */
public class StringUtil {

	public StringUtil(){ }

	/**
	 * 스트링의 null 여부 리턴
	 * @param str null 체크 스트링
	 */
	public static boolean isEmpty(String str) {
		return str == null || str.length() == 0;
	}
	/**
	 *  Bracket 값들의 제거  (avg, text 형식의 값들의 리턴형식..)
	 *  @param str  resource 변경할 데이터
	 *  @param replaceStr null인 경우 변경할 데이터
	 */
	public static String delBracket (String str, String replaceStr) {
		str = str.replaceAll("\\[", "");  // text 형식에 앞에 붙음.
		str = str.replaceAll("\\]", "");  // text 형식에 뒤에 붙음.
		if( str.equals("null"))
			str = replaceStr;
		return str;
	 }	
	
	/**
	 * 스트링이 null인 경우 변환한다.
	 * @param str   resource 스트링
	 * @param replacer 변환된 스트링(str이 null인경우 )
	 */
	public static String nvl(String str, String replacer)	{
		if(str == null)
			return replacer;
		else
			return str;
	}
	
	/**
	 * 스트링이 일정 길이 이상이면 자르고 ...을 붙인다.
	 * 한글인 경우 2byte 처리.
	 * @param str   resource Str
	 * @param size  제한길이
	 * @return cutStr   변환 스트링 ( 일정길이 이상인 경우에만 ... 보이도록 )
	 *  HTML 에서도 처리 가능..
			<div style="width:120; text-overflow:ellipsis; overflow:hidden;">111111111111111111111111111111111111</div>
	 */
	public static String cutString(String str, int size){
		
		String tail = "...";
		if(str == null)            return null;

		int srcLen = str.getBytes().length;
		if(srcLen < size)            return str;

		String tmpTail = tail;
		int tailLen = tmpTail.getBytes().length;
		if(tailLen > size)            return "";

		int i = 0;
		int realLen = 0;
		for (i = 0; realLen < size; i++) {
			char a = str.charAt(i);
			if((a & 0xff00) == 0)		realLen++;
			else				        realLen += 2;
		}
		return str.substring(0, i) + tail;
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
	 *  금액 단위수를 숫자 형태로 리턴( 10,000  -> 10000)
	 *  납부내역 연회비 토탈을 위해. 
	 *  @param value string 금액 표현 형식
	 *  @return int ','를 제외한 숫자  ( 값이 없을땐 0 리턴)
	 */
	public static int unformatNumber(String value){
		if(value == null)
			return 0;
		StringBuffer res = new StringBuffer();
		StringTokenizer st = new StringTokenizer(value, ",");
		try	{
			while(st.hasMoreTokens()) 
				res.append(st.nextToken());
		}catch(NoSuchElementException nosuchelementexception) { 			
		}
		return Integer.parseInt(res.toString());
	}
	
	/**
	 * password  암호화.
	 * @param strPW
	 * @return
	 */
    public static final synchronized String Base64EncodedMD5_B(String strPW){
        byte [] encodedBytes= Base64.encodeBase64(DigestUtils.md5(strPW));
        String passACL = new String(encodedBytes);
        return passACL;
    }
    
    /**
	 * @Name : getHexCodeMD5
	 * @Description : 로그인 비밀번호 생성
	 * @CreateDate : 2014. 7. 22.
	 * @Creator : NoteBook
	 * ------------------------------------------
	 *
	 * @param inputValue
	 * @return
	 */
	public static String getHexCodeMD5(String inputValue) {
		MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (Exception e) {
			e.printStackTrace();
		}

		String eip;
		byte[] bip;
		String temp = "";
		String tst = inputValue;

		bip = md5.digest(tst.getBytes());
		for (int i = 0; i < bip.length; i++) {
			eip = "" + Integer.toHexString((int) bip[i] & 0x000000ff);
			if (eip.length() < 2)
				eip = "0" + eip;
			temp = temp + eip;
		}
		return temp;
	}

    
    /**
     *  암호를 생성한다.  비번찾기시 신규 아이디로 처리한다.
	 * @return String 생성된 임시 비번코드
	 */    
    public static String createPwd(){
    	// 생성할 비밀번호 조합
    	StringBuffer pwd= new StringBuffer();
    	// 2009-03-26    비번 숫자로만 된 6자리로 처리됨...
    	/*
		String[] chr = {"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l"
				,"m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G"
				,"H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
		*/

		Random r = new Random();
		for( int i=0; i<6; i++){
			//pwd.append(chr[r.nextInt(61)]);  // 숫자+영소+영대 조합
			pwd.append(r.nextInt(10));	// 숫자조합
		}
		
    	System.out.println("||||||||||     createPwd  : "+pwd.toString());
		
    	return pwd.toString();
    }
    
    /**
     *   사업자 번호 유효성 체크
     *@param String 사업자 번호
     *@return boolean 사업자 번호 유효성
     */
	public static boolean isCompanyNo(String coNo){
		
		if(coNo.length() != 10)
			return false;
		
		if(!coNo.matches("[0-9]+"))
			return false;			
	
		int sum = 0;
		int j =0;
		int[] getlist =new int[10];
		int[] chkvalue = {1,3,7,1,3,7,1,3,5};
		int sidliy =0; 
		int sidchk=0;
		
		for(j=0; j<10; j++) 		{ 
			getlist[j] = Integer.parseInt(coNo.substring(j, j+1)); 
		}
		for(j=0; j<9; j++) { 
			sum += getlist[j]*chkvalue[j]; 
		}							
		sum = sum +(getlist[8]*5)/10;
		
		sidliy = sum % 10;
		sidchk = 0;
		if(sidliy != 0) { sidchk = 10 - sidliy; }
		else { sidchk = 0; }							
		
		if(sidchk != getlist[9]) { 
			return false;
		}			
		return true;
	}	
	
	/**
	 * 내용중에 특수문자 표현을 위해 HTML 특수문자로 변환
     * DB 입력시 사용
	 * @param str
	 * @return
	 */
    public static String getConvertChar(String str){
        for(int i=0; i < str.length(); i++){
            if(str.charAt(i) =='<'){
                str=str.substring(0, i) + "&#60;" + str.substring(i+1, str.length());
                i=i+4; //1자가 5자로 변환됨으로 +4을 합니다.
            }else if(str.charAt(i) == '>'){
                str=str.substring(0, i) + "&#62;" + str.substring(i+1, str.length());
                i=i+4;
            }else if(str.charAt(i) == '\"'){
                str=str.substring(0, i) + "&#34;" + str.substring(i+1, str.length());
                i=i+4;
            }else if(str.charAt(i) == '\''){
                str=str.substring(0, i) + "&#39;" + str.substring(i+1, str.length());
                i=i+4;
            }
        }
        return str;
    }

    /**
     * 숫자만 남겨두고 모두 삭제한다.
     * @param value
     * @return
     */
    public static String getOnlyNumber(String value){
    	return value.replaceAll("[^0-9]", "");
    }
    
    /**
	 * 숫자형식의 데이터를 금액 단위로 리턴한다. ( 10000   -> 10,000 )
	 *  @param value string 금액 표현 형식
	 *  @return int ','를 제외한 숫자  ( 값이 없을땐 0 리턴)
	 */
	public static String formatNumber(String str){
		if(str == null || str.equals("")) {
			return "0";
		}
		
		Long v = Long.parseLong(getOnlyNumber(str));
		
		DecimalFormat df2 = new DecimalFormat("#,##0");
		return df2.format(v);
		
//		if(str == null || str.equals(""))
//			return "0";
//		if(str.length() <= 3)	{
//			return str;
//		} else	{
//			String remainder = str.substring(str.length() - 3, str.length());
//			return str.substring(0, str.length() - 3) + "," + remainder;
//		}
	}
	// overloading 
	public static String formatNumber(int value){
		return formatNumber(String.valueOf(value));
	}
	/*
	public static void main(String args[]) throws Exception{
		String str = "wizzpay01";
		String s1 = StringUtil.Base64EncodedMD5_B(str);
		System.out.println("Base64EncodedMD5_B["+s1+"]");
		String s2 = StringUtil.getHexCodeMD5(str);
		System.out.println("getHexCodeMD5["+s2+"]");
	}
	*/
}
