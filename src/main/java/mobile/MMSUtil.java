package mobile;

import java.io.*;
import java.util.*;
import java.util.regex.Pattern;
import java.lang.*;
import java.text.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Base64;

/**
* 1.class ��            	: MMSUtil.java <br>
* 2.class ����          	: ����� <br>
* 3.��� SQL Map         	: <br>
* 4.��� table            : <br>
* 5.��� class          	: <br>
* 6.��� JSP            	: <br>
* 7.���� �ۼ���/�ۼ���  	: 2009.01.22/bugslife <br>
* 8.�ֱ� ������/������  	: <br>
* 9.���泻��            	: <br>
*/
public class MMSUtil
{

  private static final SimpleDateFormat sdfyyMMddHHmmss = new SimpleDateFormat("yyMMddHHmmss");
  
  /**
   * ����
   *@param <br>
   *@return <br>
   */
	public MMSUtil() {};
	
  
  /**
  * ��й�ȣ ��ȣȭ
  * @param String   : ��� ���ڿ�
  * @return String  : ��ȣȭ ���ڿ�
  */
  public static final synchronized String Base64EncodedMD5(String strPW){ 
    
    String passACL = null;
    MessageDigest md = null;
    
    try {
      md = MessageDigest.getInstance("MD5");
    } catch(Exception e) {
      e.printStackTrace();
    }
    
    md.update(strPW.getBytes());
    byte[] raw = md.digest();
    byte[] encodedBytes = Base64.encodeBase64(raw);
    passACL = new String(encodedBytes);
    
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
  /**
   * �޴��� ��ȿ���� Ȯ��
   *@param String       : ��� ���ڿ�<br>
   *@return boolean     : ������ ��ȿ�� ��� true<br>
   */
  public static boolean HhpNum_Check(String iDate) {
    String strTmp = iDate.substring(0, 3);
     boolean reBool = false;
  
  	if(ChkNum(iDate)) {
  
  		if(iDate.length() == 10 || iDate.length() == 11) {
  
  				  if(strTmp.equals("010") || strTmp.equals("011") ||
  					 strTmp.equals("016") || strTmp.equals("017") ||
  					 strTmp.equals("018") || strTmp.equals("019")){
  					 reBool = true;
  				  }
  		}
    }
    return reBool;
  }
  
  /**
   * ���ڿ��� Ȯ��
   *@param String       : ��� ���ڿ�<br>
   *@return boolean     : ���ڸ����� �̷��������� true<br>
   */
  public static boolean ChkNum(String inStr) {
  
    boolean reBool = false;
    
    if(inStr.equals("") || inStr == null) return reBool;
  
   	for(int i = 0; i < inStr.length(); i++)
    {
      if(inStr.substring(i, i+1).compareTo("0") < 0 || inStr.substring(i, i+1).compareTo("9") > 0) return reBool;    
    }
  
    return true;
  }  

  /**
   * ����ڹ�ȣ �� �ֹι�ȣ(����/��) Ȯ��
   *@param String       : ��� ���ڿ�<br>
   *@return boolean     : �ڸ����� ��� ��ȿ�� ��� true<br>
   */
	public boolean Regist_Check(String iDate){
		
		String reName = "";
		boolean reBool = false;
		int sum = 0;
		int num = 0;
		String  inx = "137137135";
		int sidliy = 0;        
		int sidchk = 0;    
		if(iDate != null){
			if(iDate.length() == 10){	// ����� ��ȣ üũ
				
				
					for(int i=0; i<9; i++){
						sum += Integer.parseInt(iDate.substring(i,i+1)) * Integer.parseInt(inx.substring(i,i+1));
					}
					
					 sum = sum + (Integer.parseInt(iDate.substring(8,9))*5)/10;
					 sidliy = sum % 10;        
					 sidchk = 0;        
					 if(sidliy != 0) { 
					 	sidchk = 10 - sidliy; 
					 }else { 
					 	sidchk = 0; 
					 }
					 if(sidchk != Integer.parseInt(iDate.substring(9,10))) { 
					 		reBool = false;
					 }else{
					 		reBool = true;
					 }
			}else if(iDate.length() == 13){ 	// �ֹι�ȣ üũ
				if(iDate.substring(6,7).equals("1")||iDate.substring(6,7).equals("2")||iDate.substring(6,7).equals("3")||iDate.substring(6,7).equals("4")){

					for(int i=0;i<8;i++){ 
						sum+=Integer.parseInt(iDate.substring(i,i+1))*(i+2); 
					}
					for(int i=8;i<12;i++){ 
						sum+=Integer.parseInt(iDate.substring(i,i+1))*(i-6); 
					}
					sum=11-(sum%11);
					if (sum>=10) { sum-=10; }
					if (Integer.parseInt(iDate.substring(12,13)) != sum || (Integer.parseInt(iDate.substring(6,7)) !=1 && Integer.parseInt(iDate.substring(6,7)) != 2 && Integer.parseInt(iDate.substring(6,7)) != 3 && Integer.parseInt(iDate.substring(6,7)) != 4 ) ){
						reBool = false;
					}else{
						reBool = true;
					}
				}else{	// �ܱ��� �ֹι�ȣ
					sum=0; 
					int odd=0; 
					int i=0;
					int j=0;
					int[] buf = new int[13]; 
					
					for(i=0; i<13; i++) { buf[i]=Integer.parseInt(iDate.substring(i,i+1)); } 
					odd = buf[7]*10 + buf[8]; 
					if(odd%2 != 0) {	j++;	} 
					if( (buf[11]!=6) && (buf[11]!=7) && (buf[11]!=8) && (buf[11]!=9) ) { j++;	}
					
					int multiplier[] = {2,3,4,5,6,7,8,9,2,3,4,5};
					for(i=0, sum=0; i<12; i++) { 
						sum += (buf[i] *= multiplier[i]); 
					} 
					sum = 11 - (sum%11); 
					if(sum >= 10) { sum -= 10; }
					sum += 2; 
					if(sum >= 10) { sum -= 10; } 
					if(sum != buf[12]) { j++; }
					
					if(j==0) reBool = true;
				}
			}
		}
		return reBool;
	}
	
	/**
	  * �ѱ��� 2����Ʈ�� �ν��Ͽ� ��ȯ�Ѵ�.
	  * @param str �� String 
	  * @param int �ڸ� ����Ʈ ���� 
	  * @return String ��ܵ� String 
	  */ 
	  public static String cutStr(String str, int length) { 
	    byte[] bytes = str.getBytes(); 
	    int len = bytes.length; 
	    int counter = 0; 
	    
	    if (length >= len) { 
	      StringBuffer sb = new StringBuffer(); 
	      sb.append(str); 
	    
	      for(int i=0;i<length-len;i++){ 
	        sb.append(' '); 
	      } 

	      return sb.toString().trim(); 
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
		 * ���ڿ� �޾Ƽ� �޸�(,) ���̱�
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
		
	
	public static String getTelType(String str){
		//mobile Check
		String hpReg =  "(01\\d{1})(\\d{3,4})(\\d{4})";		
		
		//tel Check
		String telReg1 =  "(\\d{2,3})(\\d{3,4})(\\d{4})";
		String telReg2 = "(02)(\\d{3,4})(\\d{4})";
		
		if(str == null) return str;
		str = str.replaceAll("\\s","");
		str = str.replaceAll("-", "");
		if(str.length() < 9) return str;
		if(ChkNum(str) == false) return str;
		
		if(Pattern.matches(hpReg, str)){
			return str.replaceAll(hpReg, "$1-$2-$3");
		}else if(Pattern.matches(telReg1, str)){
			if(Pattern.matches(telReg2, str)){
				return str.replaceAll(telReg2, "$1-$2-$3");
			}else{
				return str.replaceAll(telReg1, "$1-$2-$3");
			}
		}else{
			return str;
		}
	}
	
	public static String getCoNoType(String str){
		String regEx=  "(\\d{3})(\\d{2})(\\d{5})";		
		if(str == null) return str;
		str = str.replaceAll("\\s","");
		str = str.replaceAll("-", "");
		if(str.length() < 9) return str;
		if(ChkNum(str) == false) return str;
		
		if(Pattern.matches(regEx, str)){
			return str.replaceAll(regEx, "$1-$2-$3");
		}else{
			return str;
		}
	}
}