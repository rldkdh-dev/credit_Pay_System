package mobile;

import java.io.*;
import java.util.*;
import java.sql.*;
import java.lang.*;
import mobile.DataModel;
import mobile.MMSUtil;
import com.ibatis.common.resources.*;
import com.ibatis.sqlmap.client.*;

/**
*	1.class	��						:	CardISP.java <br>
*	2.class	����						:	ISP ��������	<br>
*	3.��� SQL Map					:	CardISPMap.xml, CardISPReadMap.xml <br>
*	4.��� table						:	tb_payreq_trans, tb_isp_mobile
*	5.��� class						:	<br>
*	6.��� JSP						:	<br>
*	7.���� �ۼ���/�ۼ���				:	2009.07.09/reclus	<br>
*	8.�ֱ� ������/������				:	<br>
*	9.���泻��						:	<br>
*/
public class CardISP
{
	/**
	 * ��	����
	 * cp_no : ���� �޴��� ��ȣ
	 */
	private	String cp_no = null;

	/**
	 * ����
	 *@param <br>
	 *@return	<br>
	 */
	public CardISP() {};

	/**
	 * ����
	 *@param strID		:	�α��� ID<br>
	 *@return	<br>
	 */
	public CardISP(String	strCpNo) {
		this.cp_no = strCpNo;
	};

	/**
	 * �ŷ���û���� ��ȸ
	 *@param  Hash  		:	��û RID, ī���ڵ�<br>
	 *@return	Hash		:	��û����<br>
	 *@throws	SQLException <br>
	 *@throws	Exception	<br>
	 */
	public DataModel getISPInfo(DataModel map)	throws SQLException, Exception {

		Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		return (DataModel)client.queryForObject("getISPInfo", map);
	}
	
	/**
	 * ISP ������û ���� ����
	 * @param  DataModel      : TID, �������� <br>
	 * @throws java.lang.Exception
	 */
	public int updateISPInfo(DataModel map) throws SQLException, Exception {
		
		Reader reader = Resources.getResourceAsReader("SqlMapConfigP.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		int result = 0;
		
		try {
			client.startTransaction();
			result = client.update("updateISPInfo", map);
			client.commitTransaction ();
		} finally {
			client.endTransaction ();
		}
		
		return result;
	}
	
	/**
	 * ISP ������û ���� ����
	 * @param  DataModel      : TID, �������� <br>
	 * @throws java.lang.Exception
	 */
	public int updateISPInfoInit(DataModel map) throws SQLException, Exception {
		
		Reader reader = Resources.getResourceAsReader("SqlMapConfigP.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		int result = 0;
		
		try {
			client.startTransaction();
			result = client.update("updateISPInfoInit", map);
			client.commitTransaction ();
		} finally {
			client.endTransaction ();
		}
		
		return result;
	}
	
	/**
	 * ISP ������û ���� ���� (WAP)
	 * @param  DataModel      : TID, �������� <br>
	 * @throws java.lang.Exception
	 */
	public int insertISPInfo(DataModel map) throws SQLException, Exception {
		
		Reader reader = Resources.getResourceAsReader("SqlMapConfigP.xml");
		SqlMapClient client = SqlMapClientBuilder.buildSqlMapClient(reader);
		
		int result = 0;
		
		try {
			client.startTransaction();
			result = client.update("insertISPInfo", map);
			client.commitTransaction ();
		} finally {
			client.endTransaction ();
		}
		
		return result;
	}
	
}
