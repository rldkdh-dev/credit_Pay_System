package util;

import java.util.Iterator;

import org.apache.http.Consts;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.co.infinisoft.pg.document.GiftBox;

public class InnopayUtil {
	
	final static String RECEIVE_URL = "https://pgadmin.wizzpay.co.kr/smsCardKeyinReceive.ipay";
	final static int CONNECT_TIMEOUT = 10000;
	final static int TIMEOUT = 30000;
	
	public InnopayUtil() {
		// TODO Auto-generated constructor stub
	}
	
	public static String genJsonString(GiftBox box){
		JsonObject obj = new JsonObject();
		Iterator<String> it = box.keySet().iterator();
		while(it.hasNext()){
			String mapKey = it.next();
			String mapValue = box.getString(mapKey);
			if(mapValue == null){
				mapValue = "";
			}
			obj.addProperty(mapKey, mapValue);
		}
		return obj.toString();
	}
	
	
	public static void dataSend(GiftBox box){
		String body = ""; 
		int httpStatusCode = -1;
		
		JsonObject resultData = new JsonObject(); 
		CloseableHttpClient httpClient = HttpClients.createSystem();
		ResponseHandler<String> responseHandler = new BasicResponseHandler();
		try {
			HttpPost post = new HttpPost(RECEIVE_URL);
			post.setHeader("Content-type", "application/json; charset=utf-8");
			post.setEntity(new StringEntity(genJsonString(box),Consts.UTF_8));
			
			CloseableHttpResponse response = httpClient.execute(post);
			httpStatusCode = response.getStatusLine().getStatusCode();
			body = responseHandler.handleResponse(response);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			System.out.println("SEND DATA :: " +box.toString());
			System.out.println("SEND STATUS :: " + httpStatusCode);
			System.out.println("SEND RESULT :: " + body);
//			resultData = (JsonObject) new JsonParser().parse(body);
//			System.out.println("SEND RESULT JSON:: " + resultData.toString());
		}
		
	}
	
}
