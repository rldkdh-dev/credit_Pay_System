package mobile;

import java.io.IOException;
import java.io.Reader;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Hex;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import kr.co.infinisoft.pg.common.KeyUtils;
import kr.co.infinisoft.pg.common.StrUtils;
import kr.co.infinisoft.pg.common.TimeUtils;
import kr.co.infinisoft.pg.common.biz.CommonBiz;
import kr.co.infinisoft.pg.common.db.SqlMapMgrP;
import kr.co.infinisoft.pg.document.Box;
import util.NetUtil;

public class Homepage {

	@SuppressWarnings("finally")
	public List<DataModel> getTransList(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		List<DataModel> dataList = null;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			dataList = client.queryForList("getTransList", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return dataList;

	}
	
	@SuppressWarnings("finally")
	public List<DataModel> getBankTransList(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		List<DataModel> dataList = null;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			dataList = client.queryForList("getBankTransList", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return dataList;

	}	
	
	@SuppressWarnings("finally")
	public List<DataModel> getVacctTransList(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		List<DataModel> dataList = null;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			dataList = client.queryForList("getVacctTransList", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return dataList;

	}	

}
