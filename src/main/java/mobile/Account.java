package mobile;

import java.io.*;
import java.util.*;
import java.sql.*;
import java.lang.*;
import java.security.*;
import javax.servlet.http.*;
import mobile.DataModel;
import mobile.MMSUtil;
import com.ibatis.common.resources.*;
import com.ibatis.sqlmap.client.*;

/**
* 1.class 占쏙옙            	: Account.java <br>
* 2.class 占쏙옙占쏙옙          	: 占쏙옙占쏙옙 占쏙옙 <br>
* 3.占쏙옙占�SQL Map        	: AccountMap.xml AccountReadMap.xml <br>
* 4.占쏙옙占�table           : tb_m_person <br>
* 5.占쏙옙占�class          	: <br>
* 6.占쏙옙占�JSP            	: <br>
* 7.占쏙옙占쏙옙 占쌜쇽옙占쏙옙/占쌜쇽옙占쏙옙  	: <br>
* 8.占쌍깍옙 占쏙옙占쏙옙占쏙옙/占쏙옙占쏙옙占쏙옙  	: <br>
* 9.占쏙옙占썸내占쏙옙            	: <br>
*/


public class Account
{
  public static int m_iAuthDur = 300;				// 占쏙옙占쏙옙占쏙옙占쏙옙占썩간 5占쏙옙

	// 占썩본占쏙옙占쏙옙
	public String cp_no;		// 占쌨댐옙占쏙옙 占쏙옙호
	public String cp_co;    	// 占쏙옙占쏙옙占�
	public String dpSize;		// 화占쏙옙크占쏙옙
	public String model;		// 占쏙옙占쏙옙트占쏙옙 占쏙옙占쏙옙
	
	// 占쏙옙占쏙옙占쏙옙占쏙옙
	public String rid;      	// RID
	public String msg;			// 占쏙옙占쏙옙 占쌨쏙옙占쏙옙 占쏙옙占쏙옙	
	public String ip;
	public String mac;	
	public String prev;			// 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙	
	public String cardInfo;
	
	public String PayMethod;
	public String GoodsCnt;
	public String GoodsName;
	public String Amt;	
	public String Moid;
	public String MID;
	public String ReturnURL;
	public String RetryURL;
	public String mallUserID;
	public String BuyerName;
	public String BuyerAuthNum;
	public String BuyerTel;
	public String BuyerEmail;
	public String BuyerAddr;
	public String BuyerPostNo;
	public String ParentEmail;
	public String UserIP;
	public String MallIP;
	public String VbankExpDate;
	public String EncryptData;	
	public String MallReserved;
	public String ResultYN;
	public String MallResultFWD;
	
	public String TID;
	
	// 占신울옙카占쏙옙
	public String CardFnCd;
	public String CardInstmn;
	public String CardType;
	public String AuthType;
	public String Param;
	public String CardNo;
	public String CardExpireDt;
	public String Cvc;
	public String CardPassWord;
	public String CardAuthNo;
	public String NonInstCl;
	
	// 占쏙옙占쏙옙占쏙옙占�
	public String BankCode;
	public String VBankAccountName;
	public String cashReceiptType;
	public String CashId;
	public String VBankAccountNum;
	
	// 占쌨댐옙占쏙옙
	public String CPID;
	public String Carrier;
	public String ServerInfo;
	public String Iden;
	public String CAP;
	public String OTP;
	public String Retry;
	public String EncodedTID;
	public String cpTid;
	

  /**
   *@param <br>
   *@return <br>
   */
	public Account() {};
	
	/**
   *@param cp_no<br>   
   *@return <br>
   */
	public Account(String strpCpNo)	{
		this.cp_no = strpCpNo;		
	};
	
	
	 /**
	  * 占싸깍옙占쏙옙占쏙옙 占쏙옙 占쏙옙占�
	  *
	  * @param req
	  * @param res
	  * @param map : 占쏙옙占쏙옙占�占쏙옙占쏙옙
	  * @return 占싸깍옙占쏙옙 占쏙옙占쏙옙占�
	  * @throws java.lang.Exception
	  */
	 public static boolean logInWap(HttpServletRequest req, HttpServletResponse res, DataModel map) throws SQLException, Exception  {
	  
	  Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
	  SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
	  
	  if (map == null) {
	   throw new Exception("占�占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙求占�");
	  }
	  
	  boolean bRetVal = false;
	  
	  Iterator iter = map.keySet().iterator();
	  
	  while(iter.hasNext()) {
	   String sUserInfoKey = (String)iter.next();
	   
	   if (sUserInfoKey != null) {
	    bRetVal = setAttribute(req, m_iAuthDur, sUserInfoKey, (String) map.get(sUserInfoKey));
	    
	    if (bRetVal == false) { //return false;
	     throw new Exception("Session save fail!");
	    }
	   }
	  }
	  
	  return bRetVal; 
	 }
	

	/**
	 * 占쏙옙 占쏙옙호 확占쏙옙
	 * @param	 String    : 占쌨댐옙占쏙옙 占쏙옙호
	 * @return String    : 占쏙옙占쏙옙
	 * @throws Exception
	 */
	public String chkAccount(String strpCpNo) throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);

		return client.queryForObject("chkAccount", strpCpNo).toString();
	}
	
	
	
	/**
   * 占쏙옙占쏙옙 占쏙옙橘占싫�占쏙옙효占쏙옙 확占쏙옙
   *@param  DataModel      : 占쌨댐옙占쏙옙占싫�占쏙옙占쏙옙占쏙옙橘占싫�占쏙옙占쏙옙占싻뱄옙호<br>
   *@return DataModel      : 占쏙옙회占쏙옙占�<br>
   *@throws SQLException <br>
   *@throws Exception <br>
   */
	public DataModel chkNPW(DataModel map) throws SQLException, Exception {
		
		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		MMSUtil mm = new MMSUtil();
		
//		map.put("pw", mm.Base64EncodedMD5(map.getStr("pw")));
//		map.put("npw", mm.Base64EncodedMD5(map.getStr("npw")));
		map.put("pw", mm.getHexCodeMD5(map.getStr("pw")));
		map.put("npw", mm.getHexCodeMD5(map.getStr("npw")));

		return (DataModel)client.queryForObject("chkNPW", map);
  }
	
	/**
   * 占쏙옙橘占싫�占쏙옙효占쏙옙 확占쏙옙
   *@param String          : 占쌨댐옙占쏙옙占싫�br>
   *@param String          : 占쏙옙橘占싫�<br>
   *@return DataModel      : 占쏙옙회占쏙옙占�<br>
   *@throws SQLException <br>
   *@throws Exception <br>
   */
	public boolean chkPWVaild(DataModel map) throws SQLException, Exception {
		
		boolean bRtn = true;
		
		if(isValidPassword1(map.getStr("pw")) == false || isValidPassword2(map.getStr("pw")) == false || isValidPassword3(map.getStr("pw")) == false || isValidPassword4(map) == false )
				bRtn = false;
		
		return bRtn;
  }
	
	private boolean isValidPassword1(String strNewPW)
	{
				
		int length = strNewPW.length();
		int lastIndex = 0;
		int firstIndex = 0;
		String tempStr = "";
				
		for(int i=0; i < length-2; i++ )
		{
			tempStr = strNewPW.substring(i,i+3);
			firstIndex = strNewPW.lastIndexOf(tempStr);
			lastIndex = strNewPW.indexOf(tempStr);
			
			if(firstIndex != lastIndex) { return false;	}
		}
		
		
		return true;	
	}
	
	private boolean isValidPassword2(String strNewPW)
	{				
		int length = strNewPW.length();
		
		for(int i=0; i < length; i++ )
		{
			
			String tempChar = strNewPW.substring(i,i+1);
			String tempString = tempChar+tempChar+tempChar;
			
			if(strNewPW.indexOf(tempString) >= 0) { return false; }
		}
		
		return true;	
	}
	
	private boolean isValidPassword3(String strNewPW)
	{		
		String digits = "0123456789";		
		int length = strNewPW.length();
		
		for(int i=0; i < length-2; i++ )
		{			
			String temp = strNewPW.substring(i,i+3);
			if(digits.indexOf(temp) >=0) { return false; }
		}
		
		return true;	
	}
	
	private boolean isValidPassword4(DataModel map)
	{		
		String strNewPW = map.getStr("pw");
		String strSocNo = map.getStr("soc_no");
		String strCpNo = map.getStr("cp_no");		
		
		int length = strNewPW.length();
		
		for(int i=0; i < length-2; i++ )
		{			
			String temp = strNewPW.substring(i,i+3);
						
			if(strSocNo.indexOf(temp) >=0 || strCpNo.indexOf(temp) >=0) { return false; }
		}
		
		return true;	
	}
	
	/**
	 * 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙청占쏙옙占쏙옙 占쏙옙占쏙옙 -- 占쌕놂옙
	 * @param title		占쏙옙占쏙옙 占쏙옙占쏙옙
	 * @param cbUrl		占쌥뱄옙 URL
	 * @param cellNo	占쌘듸옙占쏙옙 占쏙옙호
	 * @throws Exception
	 */
	public final void insPAuthReqInfo(DataModel map) throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigP.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);

		try {
			client.startTransaction(); 

			client.update("insPAuthReqInfo", map);
			
			client.commitTransaction ();

		} finally {
			try	{ client.endTransaction ();	}catch (Exception e){ }
		}
	}
	
	/**
	 * 占쏙옙占쏙옙占�占쏙옙占쏙옙 DB占쏙옙 占쌥울옙
	 * @param DataModel  : 占쏙옙占쏙옙占�占쏙옙占쏙옙
	 * @return Int       : 占쌥울옙 占실쇽옙
	 * @throws Exception
	 */
	public int createAccount(DataModel map) throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigP.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);

		MMSUtil mm = new MMSUtil();
		
		int iRtn = 0;
				
//		map.put("pw", mm.Base64EncodedMD5(map.getStr("pw")));
		map.put("pw", mm.getHexCodeMD5(map.getStr("pw")));
		
		try {
			client.startTransaction(); 

			iRtn = client.update("createAccount", map);
			
			client.commitTransaction ();

		} finally {
			try	{ client.endTransaction ();	}catch (Exception e){ }
		}
		
		return iRtn;
	}
	
	 
	/**
   * 占쏙옙占쏙옙占�ID 확占쏙옙
   *@param DataModel       : 占싸깍옙占쏙옙 占쏙옙占쏙옙<br>
   *@return DataModel      : 占쏙옙회占쏙옙占�<br>
   *@throws SQLException <br>
   *@throws Exception <br>
   */
	public DataModel Login(DataModel map) throws SQLException, Exception {
		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
//		MMSUtil mm = new MMSUtil();
//		String hPW = mm.Base64EncodedMD5(map.getStr("pw"));
		String hPW = MMSUtil.getHexCodeMD5(map.getStr("pw"));
		map.put("pw", hPW);
		
		return (DataModel)client.queryForObject("login", map);
  }
	
	/**
   * 占싻쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 카占쏙옙트 占쏙옙占쏙옙
   *@param DataModel       : 占싸깍옙占쏙옙 占쏙옙占쏙옙<br>
   *@param String          : 占쏙옙橘占싫�<br>
   *@return DataModel      : 占쏙옙회占쏙옙占�<br>
   *@throws SQLException <br>
   *@throws Exception <br>
   */
	public int upFailCnt(DataModel map) throws SQLException, Exception {
		Reader reader = Resources.getResourceAsReader("SqlMapConfigP.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
//		MMSUtil mm = new MMSUtil();
		
    int iRtn = 0;
		
//		map.put("pw", mm.Base64EncodedMD5(map.getStr("pw")));
		map.put("pw", MMSUtil.getHexCodeMD5(map.getStr("pw")));
		
		try {
			client.startTransaction(); 

			iRtn = client.update("upPWFailCnt", map);
			
			client.commitTransaction ();

		} finally {
			try	{ client.endTransaction ();	}catch (Exception e){ }
		}
		
		return iRtn;
  }
	
	/**
   * 占싻쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 카占쏙옙트 占십깍옙화
   *@param DataModel       : 占싸깍옙占쏙옙 占쏙옙占쏙옙<br>
   *@param String          : 占쏙옙橘占싫�<br>
   *@return DataModel      : 占쏙옙회占쏙옙占�<br>
   *@throws SQLException <br>
   *@throws Exception <br>
   */
	public int upPWFailCntInit(DataModel map) throws SQLException, Exception {
		Reader reader = Resources.getResourceAsReader("SqlMapConfigP.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
//		MMSUtil mm = new MMSUtil();
		
		int iRtn = 0;
		
//		map.put("pw", mm.Base64EncodedMD5(map.getStr("pw")));
		map.put("pw", MMSUtil.getHexCodeMD5(map.getStr("pw")));
		
		try {
			client.startTransaction(); 

			iRtn = client.update("upPWFailCntInit", map);
			
			client.commitTransaction ();

		} finally {
			try	{ client.endTransaction ();	}catch (Exception e){ }
		}
		
		return iRtn;
  }
	
	
	/**
	* 占싸깍옙占쏙옙占쏙옙 占쏙옙 占쏙옙占�
	*
	* @param req
	* @param res
	* @param map : 占쏙옙占쏙옙占�占쏙옙占쏙옙
	* @return 占싸깍옙占쏙옙 占쏙옙占쏙옙占�
	* @throws java.lang.Exception
	*/
	public static boolean logIn(HttpServletRequest req, HttpServletResponse res, DataModel map) throws SQLException, Exception  {
		
		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		if (map == null) {
			throw new Exception("占�占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙求占�");
		}
		
		boolean bRetVal = false;
		
		// 占쏙옙占쏙옙占�占쏙옙占쏙옙占쏙옙 占싻억옙쨈占�
		DataModel rmap = new DataModel();
		
		rmap = (DataModel)client.queryForObject("getMPersonSessionInfo", map);

		Iterator iter = rmap.keySet().iterator();

		while(iter.hasNext()) {
		  String sUserInfoKey = (String)iter.next();

			if (sUserInfoKey != null) {
					bRetVal = setAttribute(req, m_iAuthDur, sUserInfoKey, (String) rmap.get(sUserInfoKey));

				if (bRetVal == false) { //return false;
					throw new Exception("Session save fail!");
				}
			}
		}
		
		return bRetVal;	
	}
	
	
	/**
	* 占싸깍옙占쏙옙 占실억옙 占쌍댐옙占쏙옙 체크
	*
	* @param req
	* @return 占싸깍옙占쏙옙 체크占쏙옙占쏙옙
	*/
	public static boolean checkLogIn(HttpServletRequest req) throws Exception {
		HttpSession session = null;
		
		session = req.getSession(false);

		String sSsnLoginId = (String) session.getAttribute("cp_no");

		if (sSsnLoginId == null) {
			return false;
		} else {
			return true;
		}
	}
	
	/**
	* 占싸깍옙占쏙옙占쏙옙 占실억옙 占쌍놂옙占쏙옙 占싯삼옙 占싼댐옙.
	* @param req
	* @return
	* @throws java.lang.Exception
	*/
	public boolean checkAuth(HttpServletRequest req) {
		try {
			if ( checkLogIn(req) ) {
			  HttpSession session = req.getSession(false);
		
        cp_no = (String)session.getAttribute("cp_no");
        cp_co = (String)session.getAttribute("cp_co");
        dpSize = (String)session.getAttribute("dpSize");
        model = (String)session.getAttribute("model");
        rid = (String)session.getAttribute("rid");
        msg = (String)session.getAttribute("msg");
        ip = (String)session.getAttribute("ip");
        mac = (String)session.getAttribute("mac");
		prev = (String)session.getAttribute("prev");
		cardInfo = (String)session.getAttribute("cardInfo");
                
		PayMethod = (String)session.getAttribute("PayMethod");
		GoodsCnt = (String)session.getAttribute("GoodsCnt");
		GoodsName = (String)session.getAttribute("GoodsName");
		Amt = (String)session.getAttribute("Amt");	
		Moid = (String)session.getAttribute("Moid");
		MID = (String)session.getAttribute("MID");
		ReturnURL = (String)session.getAttribute("ReturnURL");
		RetryURL = (String)session.getAttribute("RetryURL");
		mallUserID = (String)session.getAttribute("mallUserID");
		BuyerName = (String)session.getAttribute("BuyerName");
		BuyerAuthNum = (String)session.getAttribute("BuyerAuthNum");
		BuyerTel = (String)session.getAttribute("BuyerTel");
		BuyerEmail = (String)session.getAttribute("BuyerEmail");
		BuyerAddr = (String)session.getAttribute("BuyerAddr");
		BuyerPostNo = (String)session.getAttribute("BuyerPostNo");
		ParentEmail = (String)session.getAttribute("ParentEmail");
		UserIP = (String)session.getAttribute("UserIP");
		MallIP = (String)session.getAttribute("MallIP");
		VbankExpDate = (String)session.getAttribute("VbankExpDate");
		EncryptData = (String)session.getAttribute("EncryptData");	
		MallReserved = (String)session.getAttribute("MallReserved");
		ResultYN = (String)session.getAttribute("ResultYN");
		MallResultFWD = (String)session.getAttribute("MallResultFWD");
		
		TID = (String)session.getAttribute("TID");
		
		// 占신울옙카占쏙옙
		CardFnCd = (String)session.getAttribute("CardFnCd");
		CardInstmn = (String)session.getAttribute("CardInstmn");
		CardType = (String)session.getAttribute("CardType");
		AuthType = (String)session.getAttribute("AuthType");
		Param = (String)session.getAttribute("Param");
		CardNo = (String)session.getAttribute("CardNo");
		CardExpireDt = (String)session.getAttribute("CardExpireDt");
		Cvc = (String)session.getAttribute("Cvc");
		CardPassWord = (String)session.getAttribute("CardPassWord");
		CardAuthNo = (String)session.getAttribute("CardAuthNo");
		NonInstCl = (String)session.getAttribute("NonInstCl");
		
		// 占쏙옙占쏙옙占쏙옙占�
		BankCode = (String)session.getAttribute("BankCode");
		VBankAccountName = (String)session.getAttribute("VBankAccountName");
		cashReceiptType = (String)session.getAttribute("cashReceiptType");
		CashId = (String)session.getAttribute("CashId");
		VBankAccountNum = (String)session.getAttribute("VBankAccountNum");
		
		// 占쌨댐옙占쏙옙
		CPID = (String)session.getAttribute("CPID");
		Carrier = (String)session.getAttribute("Carrier");
		ServerInfo = (String)session.getAttribute("ServerInfo");
		Iden = (String)session.getAttribute("Iden");
		CAP = (String)session.getAttribute("CAP");
		OTP = (String)session.getAttribute("OTP");
		Retry = (String)session.getAttribute("Retry");
		EncodedTID = (String)session.getAttribute("EncodedTID");
		cpTid = (String)session.getAttribute("cpTid");
		
				return true;
			}
			else return false;
		}
		catch(Exception e){
			return false;
		}
	}
	
	/**
	 * 占쌔댐옙 Session占쏙옙 占쏙옙占쏙옙占싼댐옙.
	 * @param HttpServletRequest req
	 * @param iAuthDur		占쏙옙占쏙옙 占쏙옙占쏙옙占시곤옙
	 * @param sAttrNam		占쏙옙占쏙옙 占쏙옙
	 * @param sAttrVal		占쏙옙占쏙옙 占쏙옙
	 * @return true/false
	 * @throws Exception
	 */
	public static boolean setAttribute(HttpServletRequest req, int iAuthDur, String sAttrNam, String sAttrVal) throws Exception {

		HttpSession session = null;
		session = req.getSession(true);		//true占쏙옙 占싹몌옙 占쏙옙占�

		session.setMaxInactiveInterval(iAuthDur);
		session.setAttribute(sAttrNam, sAttrVal);

		String sTmpVal = (String) session.getAttribute(sAttrNam);

		if (sTmpVal != null && sTmpVal.equals(sAttrVal)) {
			return true;
		}
		else {
			return false;
		}
	}	
	
	/**
	 * 占쌔댐옙 Session占쏙옙 Attribute占쏙옙 占썹설占쏙옙占싼댐옙.
	 * @param HttpServletRequest req
	 * @param sAttrNam		占쏙옙占쏙옙 占쏙옙
	 * @param sAttrVal		占쏙옙占쏙옙 占쏙옙
	 * @return true/false
	 * @throws Exception
	 */
	public static boolean setAttribute(HttpServletRequest req, String sAttrNam, String sAttrVal) throws Exception {
		HttpSession session = null;
		session = req.getSession(false);
		
		session.setAttribute(sAttrNam, sAttrVal);
		
		String sTmpVal = (String)session.getAttribute(sAttrNam);
		
		if (sTmpVal != null && sTmpVal.equals(sAttrVal)) {
			return true;
		}
		else {
			return false;
		}
	}
	
	/**
	 * 占쏙옙占쏙옙 占쏙옙占쏙옙
	 * @param DataModel		占쏙옙占쏙옙
	 * @return int				占쏙옙占쏙옙 占실쇽옙
	 * @throws Exception
	 */
	public int upInfo(DataModel map) throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigP.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);

		int iRtn = 0;
		
//	  MMSUtil mm = new MMSUtil();

//		map.put("npw", mm.Base64EncodedMD5(map.getStr("npw")));
		map.put("npw", MMSUtil.getHexCodeMD5(map.getStr("npw")));
		
		try {
			client.startTransaction(); 

			iRtn = client.update("upInfo", map);
			
			client.commitTransaction ();

		} finally {
			try	{ client.endTransaction ();	}catch (Exception e){ }
		}
		
		return iRtn;
	}
	
}