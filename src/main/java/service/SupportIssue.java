package service;

import java.io.IOException;
import java.io.Reader;
import java.nio.charset.Charset;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import kr.co.infinisoft.pg.document.Box;
import mobile.DataModel;

/**
 * 1.class 명            	: SupportIssue.java <br>
 * 2.class 개요          	: 서비스 신청등록 <br>
 * 3.관련 SQL Map         : ServiceMap.xml<br>
 * 4.관련 table           : tb_comp <br>
 * 5.관련 class          	: <br>
 * 6.관련 JSP            	: ServiceReq.jsp <br>
 * 7.최초 작성일/작성자  	: 2009.02.17/edward<br>
 * 8.최근 수정일/수정자  	: <br>
 * 9.변경내역            	: <br>
 */
public class SupportIssue {

	private static final Logger logger = LoggerFactory.getLogger(SupportIssue.class);
	private Reader reader = null;
	private SqlMapClient client = null;
	/**
	 * 생성자
	 *@param <br>
	 *@return <br>
	 */
	public SupportIssue() {
		try {
			Charset charset = Charset.forName("UTF-8");
			Resources.setCharset(charset);
			reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
			client = SqlMapClientBuilder.buildSqlMapClient(reader);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	};

	public Box getPgInfo(Box map) throws Exception{
	    return (Box) client.queryForObject("getPgInfoMap", map);
	}
	
	/**
	 * 로그인 ID에 대한 MID 내역조회
	 *@param              : default = Login ID<br>
	 *@return ArrayList   : MID 리스트 <br>
	 *@throws SQLException <br>
	 *@throws Exception <br>
	 */
	public List getMIDInfo(String MID) throws SQLException, Exception {
		
		return client.queryForList("getMIDInfo", MID);
	}

	/**
	 * ID에 대한 사업자정보조회
	 *@param              : default = Login ID<br>
	 *@return ArrayList   : Comp 정보 <br>
	 *@throws SQLException <br>
	 *@throws Exception <br>
	 */
	public List getCompInfo(String id, String id_cl) throws SQLException, Exception {

		DataModel map = new DataModel();

		map.put("usr_id", id);
		map.put("id_cl",  id_cl);

		return client.queryForList("getCompInfo", map);
	}

	/**
	 * 거래내역 조회
	 *@param String       : 조회 TID<br>
	 *@return List        : 조회결과(TID 상세내역)<br>
	 *@throws SQLException <br>
	 *@throws Exception <br>
	 */
	public List getTransDetail(DataModel map) throws SQLException, Exception {

		return client.queryForList("serDetailTID", map);
	}


	/**
	 * 카드 거래내역 상세 조회
	 *@param String       : 조회 TID<br>
	 *@return List        : 조회결과(TID 상세내역)<br>
	 *@throws SQLException <br>
	 *@throws Exception <br>
	 */
	public List getTransDetailCard(String TID) throws SQLException, Exception {

		DataModel map = new DataModel();
		map.put("TID", TID);
		map.put("id_cl", "x");

		return client.queryForList("serDetailCardTID", map);
	}
	public List getTransDetailEPay(String TID) throws SQLException, Exception {

		DataModel map = new DataModel();
		map.put("TID", TID);
		map.put("id_cl", "x");

		return client.queryForList("serDetailEPayTID", map);
	}
	/**
	 * 간편결제 거래내역 상세 조회
	 *@param String       : 조회 TID<br>
	 *@return List        : 조회결과(TID 상세내역)<br>
	 *@throws SQLException <br>
	 *@throws Exception <br>
	 */
	public List getTransDetailAccnt(String TID) throws SQLException, Exception {

		DataModel map = new DataModel();
		map.put("TID", TID);
		map.put("id_cl", "x");

		return client.queryForList("serDetailAccntTID", map);
	}

	/**
	 * 가상계좌 거래내역 상세 조회
	 *@param String       : 조회 TID<br>
	 *@return List        : 조회결과(TID 상세내역)<br>
	 *@throws SQLException <br>
	 *@throws Exception <br>
	 */
	public List getTransDetailVacct(String TID) throws SQLException, Exception {

		DataModel map = new DataModel();
		map.put("TID", TID);
		map.put("id_cl", "x");

		return client.queryForList("serDetailVacctTransTID", map);
	}
	
	/**
	 * 계좌간편결제 거래내역 상세 조회
	 *@param String       : 조회 TID<br>
	 *@return List        : 조회결과(TID 상세내역)<br>
	 *@throws SQLException <br>
	 *@throws Exception <br>
	 */
	public List getTransDetailEasyBank(String TID) throws SQLException, Exception {
		
		DataModel map = new DataModel();
		map.put("TID", TID);
		map.put("id_cl", "x");
		
		return client.queryForList("serDetailEasyBankTID", map);
	}
	
	/**
	 * 현금영수증 내역 상세 조회
	 *@param String       : 조회 TID<br>
	 *@return List        : 조회결과(TID 상세내역)<br>
	 *@throws SQLException <br>
	 *@throws Exception <br>
	 */
	public List getCashReceiptDetail(String TID) throws SQLException, Exception {

		DataModel map = new DataModel();
		map.put("TID", TID);
		map.put("id_cl", "x");

		return client.queryForList("selCRInfo", map);
	}
	
	public DataModel getCashReceiptInfo(String TID) throws SQLException, Exception{

		return (DataModel)client.queryForObject("selectRcptFlg", TID);
	}
	
	/**
	 * Bankpay 인증결과 저장
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public int insertBankPayAuthResult(HashMap map) throws Exception{
		return client.update("insertBankAuthM", map);
	}
	/**
	 * Bankpay 인증결과 조회
	 * @param tid
	 * @return
	 * @throws Exception
	 */
	public DataModel getBankPayAuthResult(String tid) throws Exception{
		return (DataModel)client.queryForObject("selectBankAuthM", tid);
	}
	
	/**
	 * 가상계좌 농협 수수료 조회
	 * @param mid
	 * @return
	 * @throws Exception
	 */
	public Box getVbankFeeInfo(Box map) throws Exception{
	    return (Box) client.queryForObject("getVbankFeeInfo", map);
	}
	
	/**
	 * 안심 수기결제 구매동의서 조회
	 *@param String       : 조회 TID<br>
	 *@return List        : 조회결과(구매동의서)<br>
	 *@throws SQLException <br>
	 *@throws Exception <br>
	 */
	public List getCardTransBuyAgree(String TID) throws SQLException, Exception {

		DataModel map = new DataModel();
		map.put("TID", TID);

		return client.queryForList("getCardTransBuyAgree", map);
	}
	
} // end class
