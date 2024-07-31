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
* 1.class ��            	: Trans.java <br>
* 2.class ����          	: <br>
* 3.���� SQL Map        	: <br>
* 4.���� table           :<br>
* 5.���� class          	: <br>
* 6.���� JSP            	: <br>
* 7.���� �ۼ���/�ۼ���  	: <br>
* 8.�ֱ� ������/������  	: <br>
* 9.���泻��            	: <br>
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
   *@param String  �޴��� ��ȣ<br>
   *@return <br>
   */
	public Trans(String strpCpNo) { this.cp_no = strpCpNo; };
	

	/**
   * �Ⱓ Ȯ�� 
   *@param  DataModel      : ������,������,�Ⱓ���� <br>
   *@return DataModel      : ��ȸ��� <br>
   *@throws SQLException <br>
   *@throws Exception <br>
   */
	public DataModel chkTerm(DataModel map) throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		return (DataModel)client.queryForObject("chkTerm", map);
	}	
	
	/**
   * ��밡�� ���Ҽ��� 
   *@param  DataModel      : ������,������,�Ⱓ���� <br>
   *@return DataModel      : ��ȸ��� <br>
   *@throws SQLException <br>
   *@throws Exception <br>
   */
	public List getSvcLst(String strMID) throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		return client.queryForList("getSvcLst", strMID);
	}	
	
	/**
	 * �ŷ����� Count
	 *@param  HashMap			:	��ȸ ����, ��ȸ	��<br>
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
	 * �ŷ�����
	 *@param  HashMap			:	��ȸ ����, ��ȸ	��<br>
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
	 * �ŷ����� - ��
	 *@param  Hash  			:	�ŷ� TID, ���Ҽ���<br>
	 *@return	Hash				:	�ŷ�����<br>
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
	 * ������û���� Count
	 *@param  HashMap			:	��ȸ ����, ��ȸ	��<br>
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
	 * ������û����
	 *@param  HashMap			:	��ȸ ����, ��ȸ	��<br>
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
	 * �̿Ϸ� ������ �˻�
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
	 * ������û����
	 *@param  HashMap			:	��ȸ ����, ��ȸ	��<br>
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
	 * ������û���� - ��
	 *@param  Hash  			:	�ŷ� TID, ���Ҽ���<br>
	 *@return	Hash				:	�ŷ�����<br>
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
	 * �ŷ���û���� ������ȸ
	 *@param  Hash  		:	��û RID<br>
	 *@return	Hash		:	��û����<br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public DataModel getPayreqMerchantInfo(DataModel map)	throws SQLException, Exception {
		
		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		return (DataModel)client.queryForObject("getPayreqMerchantInfo", map);
	}
		
	/**
	 * �ŷ���û���� ����ȸ
	 *@param  Hash  		:	��û RID<br>
	 *@return	Hash		:	��û����<br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public DataModel getPayreqTransInfo(DataModel map)	throws SQLException, Exception {
		
		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		return (DataModel)client.queryForObject("getPayreqTransInfo", map);
	}
	
	/**
	 * ������ ��ȸ
	 *@param 	String			:	MID<br>
	 *@return	String			:	��ȸ���<br>
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
	 * ����������ȸ
	 *@param  	String  	:	MID<br>
	 *@return	Hash		:	��ȸ���<br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public DataModel getMerchantInfo(String strMID)	throws SQLException, Exception {
		
		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		return (DataModel)client.queryForObject("getMerchantInfo", strMID);
	}
		
	
}