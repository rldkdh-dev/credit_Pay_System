package util;
import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.nio.charset.Charset;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.httpclient.NameValuePair;

import mobile.DataModel;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import service.CardSvc;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import javax.crypto.SecretKey;
 
/*
Copyright 회사명 
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
 
public class EximbayUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(EximbayUtil.class);
	private Reader reader = null;
	private SqlMapClient client = null;
	
	public EximbayUtil() {
		try {
			Charset charset = Charset.forName("UTF-8");
			Resources.setCharset(charset);
			reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
			client = SqlMapClientBuilder.buildSqlMapClient(reader);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}
    
	public static String toEncrypt(String IVKEY, String CRYPTOKEY, String originalMsg)  {
		String AESMode = "AES/CBC/PKCS5Padding";
		String SecetKeyAlgorithmString = "AES";
		
		IvParameterSpec ivspec = new IvParameterSpec(IVKEY.getBytes());
		SecretKey keySpec = new SecretKeySpec(CRYPTOKEY.getBytes(), SecetKeyAlgorithmString);
		try{
			Cipher cipher = Cipher.getInstance(AESMode);
			cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivspec);
			byte[] encrypted = cipher.doFinal(originalMsg.getBytes());
			return new String(Base64.encodeBase64(encrypted));
		}catch(Exception e){
			e.printStackTrace();
			return "";
		}
	}
	
	public static String getSHA256(String value){
		
		try{
	        byte[] plainText = value.getBytes("UTF-8");
	        byte[] hashValue = null;
	        
	        MessageDigest md = MessageDigest.getInstance("SHA-256");
	        hashValue = md.digest(plainText);
   
	        return toHexString(hashValue);
        }catch(Exception e){
        	System.out.println("[encryptSHA256]Exception : " + e);	
        }
        return "";
	}

	//16진수 변환 함수
	public static String toHexString(byte[] letter){
		StringBuffer sbHex = new StringBuffer();
		for (int j = 0; j <letter.length; j++) {             
			String hexValue = Integer.toHexString((int)letter[j] & 0xff); 

			if(hexValue.length() == 1) sbHex.append("0");
			sbHex.append(hexValue.toUpperCase());
		} 

		return sbHex.toString();
	}
	
	public DataModel reqDccExchangeRate(DataModel reqMap){
		
		DataModel rtnMap = new DataModel();
		
		//eximbay 파라미터
		String ver = "230";
		String mid = reqMap.getStrNull("mid");
		String txntype = "DCCRATE";
		String cur = reqMap.getStrNull("cur");
		String ref = reqMap.getStrNull("ref");
		String amt = reqMap.getStrNull("amt");
		String cardno = reqMap.getStrNull("cardno");
		
		String fgkey = "";
		String paramStr = "";
		String secretkey = "";
		String url = "";
		String res = "";
		DataModel map = new DataModel();
		
		try {

			EximbayUtil eximbayUtil = new EximbayUtil();
			
			//프로퍼티 로드
			InputStream is = null;
			is = EximbayUtil.class.getResourceAsStream("/eximbay.properties");
			Properties prop = new Properties();
			prop.load(is);
			
			List<HashMap> overList = client.queryForList("cardservice.select.tb_pg_info.mid_auth.over", mid);
			
			if(overList.size() != 0){
				for(int i=0; i<overList.size(); i++){
					HashMap overMap = overList.get(i);
					mid = (String) overMap.get("pg_mid");
					secretkey = (String) overMap.get("pg_license_key");
				}
			}else{
				rtnMap.put("rescode", "9999");
				rtnMap.put("resmsg", "PG정보 미입력");
				System.out.println("PG정보 미입력");
				return rtnMap;
			}

			String IVKEY = prop.getProperty("IVKEY");
			String CRYPTOKEY = prop.getProperty("CRYPTOKEY");
			url = prop.getProperty("URL");

			System.out.println("Eximbay DCC Exchange Rate param start");
			System.out.println("ver ["+ver+"]");
			System.out.println("mid ["+mid+"]");
			System.out.println("txntype ["+txntype+"]");
			System.out.println("ref ["+ref+"]");
			System.out.println("cur ["+cur+"]");
			System.out.println("amt ["+amt+"]");
			System.out.println("cardno ["+cardno+"]");
			System.out.println("Eximbay DCC Exchange Rate param end");
			
			cardno = eximbayUtil.toEncrypt(IVKEY, CRYPTOKEY, cardno);

			//파라미터 세팅			
			HashMap<String, String> reqTemp = new HashMap<String, String>();
			reqTemp.put("ver", ver);
			reqTemp.put("mid", mid);
			reqTemp.put("txntype", txntype);
			reqTemp.put("cur", cur);
			reqTemp.put("ref", ref);
			reqTemp.put("amt", amt);
			reqTemp.put("cardno", cardno);
			
			paramStr = this.makeAllParam(reqTemp);
			
			paramStr = secretkey+"?"+paramStr;
			
			System.out.println("paramStr ["+paramStr+"]");
			
			//암호화키 생성
			fgkey = eximbayUtil.getSHA256(paramStr+"");
			
			System.out.println("fgkey ["+fgkey+"]");

			List<NameValuePair> values = new ArrayList<NameValuePair>();
			values.add(new NameValuePair("ver", ver));
			values.add(new NameValuePair("mid", mid));
			values.add(new NameValuePair("txntype", txntype));
			values.add(new NameValuePair("ref", ref));
			values.add(new NameValuePair("cur", cur));
			values.add(new NameValuePair("amt", amt));
			values.add(new NameValuePair("cardno", cardno));
			values.add(new NameValuePair("fgkey", fgkey));
			
			HttpBean httpBean = new HttpBean();

			try {
				
				res = httpBean.sendPostEximbay(url, values); // HTTP URL 호출
				
				if(!"90".equals(res)){ //성공
					System.out.println("reqDccExchangeRate res ["+res+"]");
				
					map = eximbayUtil.parse(res);
					System.out.println("map ["+map+"]");
					
					if(map.getStrNull("rescode").equals("0000")){

						rtnMap = map;
						System.out.println("Eximbay DCC Exchange Rate 인증 완료");
						
					}else{
						rtnMap = map;
						System.out.println("Eximbay DCC Exchange Rate 인증 실패");
					}
					
				}else{
					rtnMap.put("rescode", "9999");
					rtnMap.put("resmsg", "Eximbay 통신 에러");
					System.out.println("Eximbay DCC Exchange Rate 통신 에러");
				}
			}catch(Exception ex1){
				rtnMap.put("rescode", "9999");
				rtnMap.put("resmsg", "카드사 통신 장애");
				System.out.println("Eximbay HTTP DCC Exchange Rate 통신 에러");
				ex1.printStackTrace();
			}
			
		} catch (Exception e) {
			rtnMap.put("rescode", "9999");
			rtnMap.put("resmsg", "기타 장애");
			System.out.println("Eximbay DCC Exchange Rate 에러");
			e.printStackTrace();
		}
		
		return rtnMap;
		
	}
	
	public DataModel reqEnrollmentAuth(DataModel reqMap){
		
		DataModel rtnMap = new DataModel();
		
		//eximbay 파라미터
		String ver = "230";
		String mid = reqMap.getStrNull("mid");
		String txntype = "ENROLLMENT";
		String cur = reqMap.getStrNull("cur");
		String ref = reqMap.getStrNull("ref");
		String amt = reqMap.getStrNull("amt");
		String cardno = reqMap.getStrNull("cardno");
		String expirydt = reqMap.getStrNull("expirydt");
		
		String fgkey = "";
		String paramStr = "";
		String secretkey = "";
		String url = "";
		String res = "";
		DataModel map = new DataModel();
		
		try {

			EximbayUtil eximbayUtil = new EximbayUtil();
			
			//프로퍼티 로드
			InputStream is = null;
			is = EximbayUtil.class.getResourceAsStream("/eximbay.properties");
			Properties prop = new Properties();
			prop.load(is);
			
			List<HashMap> overList = client.queryForList("cardservice.select.tb_pg_info.mid_auth.over", mid);
			
			if(overList.size() != 0){
				for(int i=0; i<overList.size(); i++){
					HashMap overMap = overList.get(i);
					mid = (String) overMap.get("pg_mid");
					secretkey = (String) overMap.get("pg_license_key");
				}
			}else{
				rtnMap.put("rescode", "9999");
				rtnMap.put("resmsg", "PG정보 미입력");
				System.out.println("PG정보 미입력");
				return rtnMap;
			}

			String IVKEY = prop.getProperty("IVKEY");
			String CRYPTOKEY = prop.getProperty("CRYPTOKEY");
			url = prop.getProperty("URL");

			System.out.println("Eximbay Enrollment and Authentication param start");
			System.out.println("ver ["+ver+"]");
			System.out.println("mid ["+mid+"]");
			System.out.println("txntype ["+txntype+"]");
			System.out.println("ref ["+ref+"]");
			System.out.println("cur ["+cur+"]");
			System.out.println("amt ["+amt+"]");
			System.out.println("cardno ["+cardno+"]");
			System.out.println("expirydt ["+expirydt+"]");
			System.out.println("Eximbay Enrollment and Authentication param end");
			
			cardno = eximbayUtil.toEncrypt(IVKEY, CRYPTOKEY, cardno);
			expirydt = eximbayUtil.toEncrypt(IVKEY, CRYPTOKEY, expirydt);

			//파라미터 세팅			
			HashMap<String, String> reqTemp = new HashMap<String, String>();
			reqTemp.put("ver", ver);
			reqTemp.put("mid", mid);
			reqTemp.put("txntype", txntype);
			reqTemp.put("cur", cur);
			reqTemp.put("ref", ref);
			reqTemp.put("amt", amt);
			reqTemp.put("cardno", cardno);
			reqTemp.put("expirydt", expirydt);
			
			paramStr = this.makeAllParam(reqTemp);
			
			paramStr = secretkey+"?"+paramStr;
			
			System.out.println("paramStr ["+paramStr+"]");
			
			//암호화키 생성
			fgkey = eximbayUtil.getSHA256(paramStr+"");
			
			System.out.println("fgkey ["+fgkey+"]");

			List<NameValuePair> values = new ArrayList<NameValuePair>();
			values.add(new NameValuePair("ver", ver));
			values.add(new NameValuePair("mid", mid));
			values.add(new NameValuePair("txntype", txntype));
			values.add(new NameValuePair("ref", ref));
			values.add(new NameValuePair("cur", cur));
			values.add(new NameValuePair("amt", amt));
			values.add(new NameValuePair("cardno", cardno));
			values.add(new NameValuePair("expirydt", expirydt));
			values.add(new NameValuePair("fgkey", fgkey));
			
			HttpBean httpBean = new HttpBean();

			try {
				
				res = httpBean.sendPostEximbay(url, values); // HTTP URL 호출
				
				if(!"90".equals(res)){ //성공
					System.out.println("reqEnrollmentAuth res ["+res+"]");
				
					map = eximbayUtil.parse(res);
					System.out.println("map ["+map+"]");
					
					if(map.getStrNull("rescode").equals("0000")){

						rtnMap = map;
						System.out.println("Eximbay Enrollment and Authentication 인증 완료");
						
					}else{
						rtnMap = map;
						System.out.println("Eximbay Enrollment and Authentication 인증 실패");
					}
					
				}else{
					rtnMap.put("rescode", "9999");
					rtnMap.put("resmsg", "Eximbay 통신 에러");
					System.out.println("Eximbay Enrollment and Authentication 통신 에러");
				}
			}catch(Exception ex1){
				rtnMap.put("rescode", "9999");
				rtnMap.put("resmsg", "카드사 통신 장애");
				System.out.println("Eximbay Enrollment and Authentication HTTP 통신 에러");
				ex1.printStackTrace();
			}
			
		} catch (Exception e) {
			rtnMap.put("rescode", "9999");
			rtnMap.put("resmsg", "기타 장애");
			System.out.println("Eximbay Enrollment and Authentication 에러");
			e.printStackTrace();
		}
		
		return rtnMap;
		
	}
	
	public DataModel reqValidateAuth(DataModel reqMap){
		
		DataModel rtnMap = new DataModel();
		
		//eximbay 파라미터
		String ver = "230";
		String mid = reqMap.getStrNull("mid");
		String txntype = "PAVALIDATE";
		String ref = reqMap.getStrNull("ref");
		String cur = reqMap.getStrNull("cur");
		String amt = reqMap.getStrNull("amt");
		String authorizedid = reqMap.getStrNull("authorizedid");
		String PaRes = reqMap.getStrNull("PaRes");
		
		String fgkey = "";
		String paramStr = "";
		String secretkey = "";
		String url = "";
		String res = "";
		boolean error_flag = false;
		String error_msg = "";
		DataModel map = new DataModel();

		try {

			//AES 암/복호화
			EximbayUtil eximbayUtil = new EximbayUtil();
			
			//프로퍼티 로드
			InputStream is = null;
			is = EximbayUtil.class.getResourceAsStream("/eximbay.properties");
			Properties prop = new Properties();
			prop.load(is);
			
			List<HashMap> overList = client.queryForList("cardservice.select.tb_pg_info.mid_auth.over", mid);
			
			if(overList.size() != 0){
				for(int i=0; i<overList.size(); i++){
					HashMap overMap = overList.get(i);
					mid = (String) overMap.get("pg_mid");
					secretkey = (String) overMap.get("pg_license_key");
				}
			}else{
				rtnMap.put("rescode", "9999");
				rtnMap.put("resmsg", "PG정보 미입력");
				System.out.println("PG정보 미입력");
				return rtnMap;
			}

			String IVKEY = prop.getProperty("IVKEY");
			String CRYPTOKEY = prop.getProperty("CRYPTOKEY");
			url = prop.getProperty("URL");

			System.out.println("Eximbay Validate Authentication param start");
			System.out.println("ver ["+ver+"]");
			System.out.println("mid ["+mid+"]");
			System.out.println("txntype ["+txntype+"]");
			System.out.println("ref ["+ref+"]");
			System.out.println("cur ["+cur+"]");
			System.out.println("amt ["+amt+"]");
			System.out.println("authorizedid ["+authorizedid+"]");
			System.out.println("PaRes ["+PaRes+"]");
			System.out.println("Eximbay Validate Authentication param end");

			//파라미터 세팅			
			HashMap<String, String> reqTemp = new HashMap<String, String>();
			reqTemp.put("amt", amt);
			reqTemp.put("authorizedid", authorizedid);
			reqTemp.put("cur", cur);
			reqTemp.put("mid", mid);
			reqTemp.put("ref", ref);
			reqTemp.put("txntype", txntype);
			reqTemp.put("ver", ver);
			reqTemp.put("PaRes", PaRes);
			
			paramStr = this.makeAllParam(reqTemp);
			
			paramStr = secretkey+"?"+paramStr;
			
			System.out.println("paramStr ["+paramStr+"]");
			
			//암호화키 생성
			fgkey = eximbayUtil.getSHA256(paramStr+"");
			
			System.out.println("fgkey ["+fgkey+"]");

			List<NameValuePair> values = new ArrayList<NameValuePair>();
			values.add(new NameValuePair("ver", ver));
			values.add(new NameValuePair("mid", mid));
			values.add(new NameValuePair("txntype", txntype));
			values.add(new NameValuePair("ref", ref));
			values.add(new NameValuePair("cur", cur));
			values.add(new NameValuePair("amt", amt));
			values.add(new NameValuePair("authorizedid", authorizedid));
			values.add(new NameValuePair("PaRes", PaRes));
			values.add(new NameValuePair("fgkey", fgkey));
			
			HttpBean httpBean = new HttpBean();

			try {
				
				res = httpBean.sendPostEximbay(url, values); // HTTP URL 호출
				
				if(!"90".equals(res)){ //성공
					System.out.println("reqValidateAuth res ["+res+"]");
				
					map = eximbayUtil.parse(res);
					System.out.println("map ["+map+"]");
					
					if(map.getStrNull("rescode").equals("0000")){

						rtnMap = map;
						System.out.println("Eximbay Validate Authentication 인증 완료");
						
					}else{
						rtnMap = map;
						System.out.println("Eximbay Validate Authentication 인증 실패");
					}
					
				}else{
					rtnMap.put("rescode", "9999");
					rtnMap.put("resmsg", "Eximbay 통신 에러");
					System.out.println("Eximbay Validate Authentication 통신 에러");
				}
			}catch(Exception ex1){
				rtnMap.put("rescode", "9999");
				rtnMap.put("resmsg", "카드사 통신 장애");
				System.out.println("Eximbay Validate Authentication HTTP 통신 에러");
				ex1.printStackTrace();
			}
			
		} catch (Exception e) {
			rtnMap.put("rescode", "9999");
			rtnMap.put("resmsg", "기타 장애");
			System.out.println("Eximbay Validate Authentication 에러");
			e.printStackTrace();
		}
		
		return rtnMap;
		
	}
	
	public static DataModel parse(String res){
		
		DataModel map = new DataModel();
		
		try{
			
			StringTokenizer token = new StringTokenizer(res,"&");
			while(token.hasMoreTokens()){
				StringTokenizer token2 = new StringTokenizer(token.nextToken(),"=");
				
				String name = "";
				String value = "";
				
				if(token2.hasMoreTokens()){
					name = token2.nextToken();
				}
				
				if(token2.hasMoreTokens()){
					value = token2.nextToken();
				}
				
				map.put(name,value);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return map;
		
	}

	//파라미터 정렬
	public String makeAllParam(HashMap<String, String> reqTemp){

		int listSize = 1;
		StringBuffer reqParam = new StringBuffer();

		List<String> reqList = new ArrayList<String>();


		try{
			reqList = new ArrayList<String>(reqTemp.keySet());
			Collections.sort(reqList);

			for (String str : reqList) {	
				String key = str;
				String value = (String) reqTemp.get(str);  

				if ("fgkey".equals(key))  {
					listSize++;
					continue;
				}			
				if(reqList.size() ==  listSize)
					reqParam.append(key).append("=").append(value);
				else 
					reqParam.append(key).append("=").append(value).append("&");   
				listSize++;
			}
			System.out.println("[makeReqAllParam]sorting : "+reqParam.toString());
			return reqParam.toString();



		}catch(Exception e){
			System.out.println("[makeReqAllParam]Exception : " + e);	
		}
		System.out.println("[makeReqAllParam]return : "+reqParam.toString());
		return reqParam.toString();
	}

} // end class