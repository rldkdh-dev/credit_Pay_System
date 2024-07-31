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
* 1.class 명            	: Trans.java <br>
* 2.class 개요          	: <br>
* 3.관련 SQL Map        	: <br>
* 4.관련 table           :<br>
* 5.관련 class          	: <br>
* 6.관련 JSP            	: <br>
* 7.최초 작성일/작성자  	: <br>
* 8.최근 수정일/수정자  	: <br>
* 9.변경내역            	: <br>
*/
public class Trans
{
	
	public String cp_no;

  /**
   *@param <br>
   *@return <br>
   */
	public Trans() {};
	
	/**
   *@param String  휴대폰 번호<br>
   *@return <br>
   */
	public Trans(String strpCpNo) { this.cp_no = strpCpNo; };
	

	/**
   * 기간 확인 
   *@param  DataModel      : 시작일,종료일,기간제한 <br>
   *@return DataModel      : 조회결과 <br>
   *@throws SQLException <br>
   *@throws Exception <br>
   */
	public DataModel chkTerm(DataModel map) throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		return (DataModel)client.queryForObject("chkTerm", map);
	}	
	
	/**
   * 사용가능 지불수단 
   *@param  DataModel      : 시작일,종료일,기간제한 <br>
   *@return DataModel      : 조회결과 <br>
   *@throws SQLException <br>
   *@throws Exception <br>
   */
	public List getSvcLst(String strMID) throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		return client.queryForList("getSvcLst", strMID);
	}	
	
	/**
	 * 거래정보 Count
	 *@param  HashMap			:	조회 구분, 조회	값<br>
	 *@return	int 				:	Record Count <br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public int transLstCnt(DataModel map)	throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		map.put("cp_no", cp_no);

		return Integer.parseInt(client.queryForObject("transLstCnt",	map).toString());
	}
	
	/**
	 * 거래정보
	 *@param  HashMap			:	조회 구분, 조회	값<br>
	 *@return	List				:	Record <br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public List transLst(DataModel map, int iPage, int iRows)	throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		map.put("cp_no", cp_no);

		return client.queryForList("transLst",	map, iPage*iRows, iRows);
	}
	
	public List transLst(DataModel map)	throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		map.put("cp_no", cp_no);

		return client.queryForList("transLst",	map);
	}
	
	/**
	 * 거래정보 - 상세
	 *@param  Hash  			:	거래 TID, 지불수단<br>
	 *@return	Hash				:	거래내역<br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public DataModel transInfo(DataModel map)	throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		map.put("cp_no", cp_no);
		
		return (DataModel)client.queryForObject("transInfo", map);
	}	
    

	/**
	 * 결제요청정보 Count
	 *@param  HashMap			:	조회 구분, 조회	값<br>
	 *@return	int 				:	Record Count <br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public int reqLstCnt(DataModel map)	throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		map.put("cp_no", cp_no);

		return Integer.parseInt(client.queryForObject("reqLstCnt",	map).toString());
	}
	
	/**
	 * 결제요청정보
	 *@param  HashMap			:	조회 구분, 조회	값<br>
	 *@return	List				:	Record <br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public List reqLst(DataModel map, int iPage, int iRows)	throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		map.put("cp_no", cp_no);

		return client.queryForList("reqLst",	map, iPage*iRows, iRows);
	}
	
	/**
	 * 미완료 결제건 검색
	 *@return	String			:	RID <br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public String reqLastRID()	throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
				
		if(client.queryForObject("reqLastRID", cp_no) == null) return "";
		else return client.queryForObject("reqLastRID",	cp_no).toString();
	}
	
	/**
	 * 결제요청정보
	 *@param  HashMap			:	조회 구분, 조회	값<br>
	 *@return	List				:	Record <br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public List reqLst(DataModel map)	throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		map.put("cp_no", cp_no);

		return client.queryForList("reqLst",	map);
	}
	
	/**
	 * 결제요청정보 - 상세
	 *@param  Hash  			:	거래 TID, 지불수단<br>
	 *@return	Hash				:	거래내역<br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public DataModel reqInfo(DataModel map)	throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		map.put("cp_no", cp_no);
		
		return (DataModel)client.queryForObject("reqInfo", map);
	}		
	
	/**
	 * 거래요청내역 상점조회
	 *@param  Hash  		:	요청 RID<br>
	 *@return	Hash		:	요청내역<br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public DataModel getPayreqMerchantInfo(DataModel map)	throws SQLException, Exception {
		
		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		return (DataModel)client.queryForObject("getPayreqMerchantInfo", map);
	}
		
	/**
	 * 거래요청내역 상세조회
	 *@param  Hash  		:	요청 RID<br>
	 *@return	Hash		:	요청내역<br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public DataModel getPayreqTransInfo(DataModel map)	throws SQLException, Exception {
		
		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		return (DataModel)client.queryForObject("getPayreqTransInfo", map);
	}
	
	/**
	 * 상점명 조회
	 *@param 	String			:	MID<br>
	 *@return	String			:	조회결과<br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public String getTransCompNm(String strMID)	throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);

		if(client.queryForObject("getTransCompNm", strMID) == null) return "";
		else return client.queryForObject("getTransCompNm",	strMID).toString();
	}
	
	/**
	 * 상점정보조회
	 *@param  	String  	:	MID<br>
	 *@return	Hash		:	조회결과<br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public DataModel getMerchantInfo(String strMID)	throws SQLException, Exception {
		
		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		return (DataModel)client.queryForObject("getMerchantInfo", strMID);
	}
		
	
}