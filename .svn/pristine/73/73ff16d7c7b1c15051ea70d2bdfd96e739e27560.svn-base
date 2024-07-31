package util;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import kr.co.infinisoft.pg.common.StrUtils;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpClientParams;
import org.apache.commons.httpclient.params.HttpConnectionParams;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.lang.StringUtils;
import org.apache.http.message.BasicNameValuePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/**
 * 
 * @id : $Id: HttpBean.java 525 2011-10-04 06:00:18Z cretty $
 * @version : $Revision: 525 $
 * @author : $Author: cretty $
 */
public class HttpBean
{
	/** logger */
	private static final Logger logger = LoggerFactory.getLogger(HttpBean.class);
	
	/** connectionManager,Clinet */
	private MultiThreadedHttpConnectionManager connectionManager;
	private HttpClient client;
	
	/**
	 * Constructor
	 */
	public HttpBean(){
		connectionManager = new MultiThreadedHttpConnectionManager();
		HttpConnectionParams params = new HttpConnectionParams();
		params.setConnectionTimeout(10000);
		client = new HttpClient(new HttpClientParams(params) ,connectionManager);
	}
	
	/**
	 * doPost
	 * @param url
	 * @param values
	 * @throws Exception
	 */
	public int doPost(String url,Map<String,String> values) throws Exception {
		int re = -1;
		PostMethod post = null;
		try {
			post = new PostMethod(url);
			
			ArrayList<NameValuePair> list = new ArrayList<NameValuePair>();
			Iterator<String> it = values.keySet().iterator();
			while(it.hasNext()){
				String key = it.next();
				String value = values.get(key);
				NameValuePair nv = new NameValuePair(key,value);
				list.add(nv);
			}
			
			StringBuffer urlBuffer = new StringBuffer();
			String str_url = "";
			urlBuffer.append(url).append("?");
			NameValuePair[] data = new NameValuePair[values.size()];
			for(int i=0;i<list.size();i++){
				data[i] = list.get(i);
				
				if ( StringUtils.isEmpty(data[i].getValue()) ) {
					str_url = "";
				}
				else {
					str_url = URLEncoder.encode(data[i].getValue());
				}
				
				if (i == 0) {
					urlBuffer.append(data[i].getName()).append("=").append(str_url);
				}
				else {
					urlBuffer.append("&").append(data[i].getName()).append("=").append(str_url);
				}
			}
			logger.info("MERCHANT<-SMARTRO:[{}]", urlBuffer.toString());
			
			//post.setRequestHeader("Content-type", "text/html; charset=EUC-KR");
			post.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=EUC-KR");
			post.setRequestBody(data);
			DefaultHttpMethodRetryHandler defaultHttpMethodRetryHandler = new DefaultHttpMethodRetryHandler(0,false);
			logger.debug("defaultHttpMethodRetryHandler : {}",defaultHttpMethodRetryHandler);
			
			

			post.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,defaultHttpMethodRetryHandler);
			re = client.executeMethod(post);
			logger.info("Return Code:{}",re);
			logger.debug("Post_data: " + data);
			logger.debug("response:{}",post.getResponseBodyAsString());
		}catch(IllegalArgumentException ia){
			throw ia;
		}catch(Exception ex){
			throw ex;
		}finally{
			post.releaseConnection();			
		}
		return re;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public HashMap doPost(String url,Map<String,String> values, String contenttype, String charset) throws Exception{
		logger.debug("**** start HttpBean doPost ****");
		int re = -1;
		PostMethod post = null;
		String CONTENTTYPE = "application/x-www-form-urlencoded";
		String CHARSET = "utf-8";
		HashMap rtnMap = new HashMap();
		String rtn = null;
		try {
			CONTENTTYPE = (StringUtils.isEmpty(CONTENTTYPE))?"application/x-www-form-urlencoded":contenttype;
			CHARSET = (StringUtils.isEmpty(charset))?"utf-8":charset;
			
			post = new PostMethod(url);
			
			ArrayList<NameValuePair> list = new ArrayList<NameValuePair>();
			Iterator<String> it = values.keySet().iterator();
			while(it.hasNext()){
				String key = it.next();
				String value = values.get(key);
				NameValuePair nv = new NameValuePair(key,value);
				list.add(nv);
			}
			
			StringBuffer urlBuffer = new StringBuffer();
			String str_url = "";
			urlBuffer.append(url).append("?");
			NameValuePair[] data = new NameValuePair[values.size()];
			for(int i=0;i<list.size();i++){
				data[i] = list.get(i);
				
				if(StringUtils.isEmpty(data[i].getValue())){
					str_url = "";
				}else{
					str_url = URLEncoder.encode(data[i].getValue(),CHARSET);
				}
				
				if(i == 0){
					urlBuffer.append(data[i].getName()).append("=").append(str_url);
				}else{
					urlBuffer.append("&").append(data[i].getName()).append("=").append(str_url);
				}
			}
			logger.debug("**** Request URL ["+url+"]");
			logger.info("InnoPay Request->[{}]", urlBuffer.toString());
			
			post.setRequestHeader("Content-Type", CONTENTTYPE+";charset="+CHARSET);
			post.setRequestBody(data);
			logger.debug("Post Data: " + data);
			DefaultHttpMethodRetryHandler defaultHttpMethodRetryHandler = new DefaultHttpMethodRetryHandler(0,false);
			logger.debug("defaultHttpMethodRetryHandler : {}",defaultHttpMethodRetryHandler);
			
			post.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,defaultHttpMethodRetryHandler);
			re = client.executeMethod(post);
			logger.info("Result Code:{}",re);

			rtn = (post.getResponseBodyAsString()!=null)?post.getResponseBodyAsString().trim():"";
			logger.debug("Response Body:[{}]",rtn);
			
			String[] params = rtn.split("\\|");
			if(params!=null && params.length>0){
				for(int i=0;i<params.length;i++){
					String param[] = params[i].split("=");
					String val = "";
					if(param!=null && param.length>1){
						val = param[1];
						if(StringUtils.isEmpty(val)||val=="null") val="";
					}else{
						val = "";
					}
					rtnMap.put(param[0], StrUtils.cleanStr(val));
				} // end for
			}
			
		}catch(IllegalArgumentException ia){
			logger.error("doPost IllegalArgumentException "+ia.getMessage());
			throw ia;
		}catch(Exception ex){
			logger.error("doPost Exception "+ex.getMessage(),ex);
			throw ex;
		}finally{
			post.releaseConnection();			
		}
		return rtnMap;
	}
	
	public String sendPost(String url, List<NameValuePair> list) throws Exception {
		int re = -1;
		String res = "";
		PostMethod post = null;
		String notiOk = "0000";
		try{
			post = new PostMethod(url);
			
			StringBuffer urlBuffer = new StringBuffer();
			String values = "";
			urlBuffer.append(url).append("?");
			NameValuePair[] data = new NameValuePair[list.size()];
			for(int i=0;i<list.size();i++){
				data[i] = list.get(i);
				
				if ( StringUtils.isEmpty(data[i].getValue()) ) {
					values = "";
				}else{
					values = URLEncoder.encode(data[i].getValue(),"UTF-8");
				}
				
				if (i == 0) {
					urlBuffer.append(data[i].getName()).append("=").append(values);
				}
				else {
					urlBuffer.append("&").append(data[i].getName()).append("=").append(values);
				}
			}
			logger.info("Innopay->Merchant:[{}]", urlBuffer.toString());
			
			post.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=UTF-8");
			post.setRequestBody(data);
			DefaultHttpMethodRetryHandler defaultHttpMethodRetryHandler = new DefaultHttpMethodRetryHandler(0,false);
			logger.debug("defaultHttpMethodRetryHandler : {}",defaultHttpMethodRetryHandler);
			
			post.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,defaultHttpMethodRetryHandler);
			re = client.executeMethod(post);
			logger.info("Return Http Status:{}",re);
			res = post.getResponseBodyAsString();
			logger.debug("Merchant->Innopay:[{}]",res);
			
			if(re!=200){
				res = "90";	//오류
			}
			
		}catch(Exception e){
			logger.error("sendPost Exception "+e.getMessage(),e);
		}finally{
			post.releaseConnection();
		}
		
		return res;
	}
	
	public String sendPostEximbay(String url, List<NameValuePair> list) throws Exception {
		int re = -1;
		String res = "";
		PostMethod post = null;
		String notiOk = "0000";
		try{
			
			post = new PostMethod(url);
			
			StringBuffer urlBuffer = new StringBuffer();
			String values = "";
			urlBuffer.append(url).append("?");
			NameValuePair[] data = new NameValuePair[list.size()];
			for(int i=0;i<list.size();i++){
				data[i] = list.get(i);
				
				if ( StringUtils.isEmpty(data[i].getValue()) ) {
					values = "";
				}else{
					values = data[i].getValue();
				}
				
				if (i == 0) {
					urlBuffer.append(data[i].getName()).append("=").append(values);
				}
				else {
					urlBuffer.append("&").append(data[i].getName()).append("=").append(values);
				}
			}
			logger.info("Innopay->Merchant:[{}]", urlBuffer.toString());
			
			post.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=UTF-8");
			post.setRequestBody(data);
			DefaultHttpMethodRetryHandler defaultHttpMethodRetryHandler = new DefaultHttpMethodRetryHandler(0,false);
			logger.debug("defaultHttpMethodRetryHandler : {}",defaultHttpMethodRetryHandler);
			
			post.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,defaultHttpMethodRetryHandler);
			
			re = client.executeMethod(post);
			logger.info("Return Http Status:{}",re);
			res = post.getResponseBodyAsString();
			logger.debug("Merchant->Innopay:[{}]",res);
			
			if(re!=200){
				res = "90";	//오류
			}
			
		}catch(Exception e){
			logger.error("sendPost Exception "+e.getMessage(),e);
		}finally{
			post.releaseConnection();
		}
		
		return res;
	}
	
/*
	public static void main(String [] args) throws Exception {
		logger.debug("start");
//		HttpBean httpBean = new HttpBean();
		//String url = "http://localhost:8080/ipgweb/test/test1.jsp";
		String url = "https://mms.mnbank.co.kr/home/Login.jsp";
		LinkedHashMap<String,String> values = new LinkedHashMap<String,String>();
		values.put("name","aaaaaaaaaaaa");
		values.put("val1","Value 1");
		logger.debug(values.toString());
//		httpBean.doPost(url, values);
		logger.debug("done");
	}
	*/
} // end class