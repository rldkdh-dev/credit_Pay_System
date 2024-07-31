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

public class CardEvent
{
	
	@SuppressWarnings("finally")
	public List<DataModel> getCardEventMain(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		List<DataModel> dataList = null;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			dataList = client.queryForList("cardevent.select.tb_nointerest_event", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return dataList;

	}
	
	@SuppressWarnings("finally")
	public List<DataModel> getCardEventDetail(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		List<DataModel> dataList = null;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			dataList = client.queryForList("cardevent.select.tb_nointerest_event_card", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return dataList;

	}
	
	@SuppressWarnings("finally")
	public List<DataModel> getCardEventMainWithMid(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		List<DataModel> dataList = null;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			dataList = client.queryForList("cardevent.select.tb_nointerest_event_with_mid", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return dataList;

	}
	
	@SuppressWarnings("finally")
	public List<DataModel> getCardEventMainWithHomepage(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		List<DataModel> dataList = null;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			dataList = client.queryForList("cardevent.select.tb_nointerest_event_with_homepage", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return dataList;

	}
	
	@SuppressWarnings("finally")
	public boolean isEtland(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		boolean isEtland=false;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			isEtland = (Integer)client.queryForObject("cardevent.select.isEtland", dataModel) > 0 ? true : false;

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return isEtland;

	}
	
	@SuppressWarnings("finally")
	public DataModel getInnopayMapping(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		DataModel data = null;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			data = (DataModel) client.queryForObject("cardevent.select.tb_innopay_mapping", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return data;

	}
	
}