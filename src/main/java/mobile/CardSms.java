package mobile;

import java.io.IOException;
import java.io.Reader;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;

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

public class CardSms {
	
	/**
	 * 설명 : SMS 수기결제 URL Code 생성
	 * @Method Name : genUrlCode
	 * @return
	 */
	private static final synchronized String genUrlCode(){
		  SecureRandom random = new SecureRandom();
		  byte[] bytes = new byte[5];
		  random.nextBytes(bytes);
		  char[] c = Hex.encodeHex(bytes);
		  return new String(c);
	  }
	
	/**
	 * 설명 : 주문정도 등록
	 * @Method Name : insertOrderInfo
	 * @param request
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	@SuppressWarnings("finally")
	public static final Box insertOrderInfo(Box request,HttpServletRequest req) throws SQLException, IOException{
		
		request.put("TID",  KeyUtils.genTID(request.getString("MID"), "01", "01"));
		request.put("ReqDt", TimeUtils.getyyyyMMdd());
		request.put("ReqTm", TimeUtils.getHHmmss());
		request.put("OrderCode", genUrlCode());
		
		
		Date date = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MINUTE, Integer.parseInt(request.getString("ExpTerm")));
		request.put("ExpDt", TimeUtils.getyyyyMMdd(cal.getTime()));
		request.put("ExpTm", TimeUtils.getHHmmss(cal.getTime()));
		
		String orderUrl = NetUtil.getInstance().getServerShortURL(req) + "/pay/card/sms/order.jsp?OrderCode="+request.getString("OrderCode");
		request.put("OrderUrl", orderUrl);
		
		SqlMapClient client = null;
		Box resultBox = new Box();
		resultBox.putAll(request);
		boolean errorStatus = true; //false:정상 / true:에러발생
		int insertCnt = 0;
		try{
			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
			client = SqlMapClientBuilder.buildSqlMapClient(reader);
			client.startTransaction();
			insertCnt = client.update("insertCardSmsOrder",request);
			System.out.println("insert cnt :: " + insertCnt );
			client.commitTransaction();
		} catch(Exception e){
			errorStatus = true;
			e.printStackTrace();
		} finally {
			client.endTransaction();
			if(insertCnt != 0){
				Sms sms = new Sms();
				sms.setMsg_type("3"); // 1:SMS(고정)  2: SMS URL 3:MMS 4:MMS URL
				sms.setDstaddr(request.getString("BuyerTel"));
				sms.setCallback("15443267");
				sms.setSubject("(주)유니윌 위즈페이 안심결제안내");
				String coNm = "["+request.getString("CoNm").replace("(", "").replace("주)", "")+"]";
				String goodsNm = request.getString("GoodsName").replace(" ", "");
				String amt = StrUtils.getMoneyType(request.getLong("GoodsAmt"));
				String strText = coNm+"\n상품명_"+goodsNm+"\n상품금액_"+amt+"원\n안심결제가 요청되었습니다\n\n안심결제 접속URL안내\n"+orderUrl+"\n\n- 결제대행사 (주)유니윌 위즈페이"; 
				sms.setText(strText);
				insertSMS(client, sms);
				errorStatus = false;
			}
			if(errorStatus == true){
				resultBox.put("ResultCode", "9999");
				resultBox.put("ResultMsg", "주문정보 등록 오류 발생");
			}else{
				resultBox.put("ResultCode", "0000");
				resultBox.put("ResultMsg", "주문정보 등록 성공");
			}
			return resultBox;
		}
	}
	
	private static final int insertSMS(SqlMapClient client, Sms sms) throws SQLException{
		return client.update("smsInsert", sms);
	}
	
	@SuppressWarnings("finally")
	public static final Box selectOrderInfo(String OrderCode) throws Exception{
		Box resultBox = new Box();
		
		boolean errorStatus = true; //false:정상 / true:에러발생
		String resultCode = null;
		String resultMsg = null;
		
		SqlMapClient client = null;
		try{
			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
			client = SqlMapClientBuilder.buildSqlMapClient(reader);
			client.startTransaction();
			resultBox = (Box) client.queryForObject("selectCardSmsOrder",OrderCode);
			client.commitTransaction();
			errorStatus = false;
		} catch(Exception e){
			errorStatus = true;
			resultMsg = "주문정보 조회 오류 발생";
			e.printStackTrace();
		} finally{
			client.endTransaction();
			if(resultBox == null && errorStatus == false){
				resultBox = new Box();
				errorStatus = true;
				resultMsg = "주문정보가 존재하지 않습니다";
			}else{
				//가맹점 정보 획득
				Box midBox = new Box();
				midBox.put("mid", resultBox.getString("MID"));
				
				Box memberInfo = new Box();
				memberInfo = CommonBiz.getMemberInfo(midBox);
				resultBox.put("CoNm", memberInfo.getString("co_nm"));
				resultBox.put("CoTel", memberInfo.getString("tel_no"));
				
			}
			if(errorStatus == true){
				resultBox.put("ResultCode", "9999");
				resultBox.put("ResultMsg", resultMsg);
				return resultBox;
			}else{
				resultBox.put("ResultCode", "0000");
				resultBox.put("ResultMsg", "주문정보 조회 성공");
				return resultBox;
			}
		}
	}
	
	@SuppressWarnings("finally")
	public static final Box selectConfOrderInfo(String OrderCode) throws Exception{
		Box resultBox = new Box();
		
		boolean errorStatus = true; //false:정상 / true:에러발생
		String resultCode = null;
		String resultMsg = null;
		
		SqlMapClient client = null;
		try{
			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
			client = SqlMapClientBuilder.buildSqlMapClient(reader);
			client.startTransaction();
			resultBox = (Box) client.queryForObject("selectCardConfOrder",OrderCode);
			resultBox.put("TID",  KeyUtils.genTID(resultBox.getString("MID"), "01", "03"));
			client.commitTransaction();
			errorStatus = false;
		} catch(Exception e){
			errorStatus = true;
			resultMsg = "주문정보 조회 오류 발생 관리자에게 문의해주세요.";
			e.printStackTrace();
		} finally{
			client.endTransaction();
			if(resultBox == null && errorStatus == false){
				resultBox = new Box();
				errorStatus = true;
				resultMsg = "해당 가맹점 또는 거래에 대한 데이터가 존재하지 않습니다.";
			}
			
			if(errorStatus == true){
				resultBox = new Box();
				resultBox.put("ResultCode", "9999");
				resultBox.put("ResultMsg", resultMsg);
				return resultBox;
			}else{
				resultBox.put("ResultCode", "0000");
				resultBox.put("ResultMsg", "주문정보 조회 성공");
				return resultBox;
			}
		}
	}
	
	@SuppressWarnings("finally")
	public static final Box getCardBinList(String cardNum) throws Exception{
		Box resultBox = new Box();
		
		boolean errorStatus = true; //false:정상 / true:에러발생
		String resultCode = null;
		String resultMsg = null;
		
		SqlMapClient client = null;
		try{
			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
			client = SqlMapClientBuilder.buildSqlMapClient(reader);
			client.startTransaction();
			resultBox = (Box) client.queryForObject("getCardBin",cardNum);
			client.commitTransaction();
			errorStatus = false;
		} catch(Exception e){
			errorStatus = true;
			resultMsg = "카드정보 조회 오류 발생 관리자에게 문의해주세요.";
			e.printStackTrace();
		} finally{
			client.endTransaction();
			if(resultBox == null && errorStatus == false){
				resultBox = new Box();
				errorStatus = true;
				resultMsg = "입력하신 카드번호와 부합되는 카드사 코드 관련 정보가 없습니다.";
			}
			
			if(errorStatus == true){
				resultBox = new Box();
				resultBox.put("ResultCode", "9999");
				resultBox.put("ResultMsg", resultMsg);
				return resultBox;
			}else{
				resultBox.put("ResultCode", "0000");
				resultBox.put("ResultMsg", "카드정보 조회 성공");
				return resultBox;
			}
		}
	}
	
	@SuppressWarnings("finally")
	public static final Box updateOrderInfo(Box request) throws Exception{
		Box resultBox = new Box();
		
		boolean errorStatus = true; //false:정상 / true:에러발생
		String resultCode = null;
		String resultMsg = null;
		
		int updateCnt = 0;
		SqlMapClient client = null;
		try{
			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
			client = SqlMapClientBuilder.buildSqlMapClient(reader);
			client.startTransaction();
			updateCnt = client.update("updateCardSmsOrder",request);
			client.commitTransaction();
			errorStatus = false;
		} catch(Exception e){
			errorStatus = true;
			resultMsg = "주문정보 업데이트 오류 발생";
			e.printStackTrace();
		} finally {
			client.endTransaction();
			if(updateCnt == 0 && errorStatus == false){
				resultBox = new Box();
				errorStatus = true;
				resultMsg = "주문정보가 존재하지 않습니다";
			}
			if(errorStatus == true){
				resultBox.put("ResultCode", "9999");
				resultBox.put("ResultMsg", resultMsg);
				return resultBox;
			}else{
				resultBox.put("ResultCode", "0000");
				resultBox.put("ResultMsg", "주문정보 업데이트 성공");
				return resultBox;
			}
		}
	}
	
	@SuppressWarnings("finally")
	public static final Box changeDelivery(Box request) throws Exception{
		Box resultBox = new Box();
		
		boolean errorStatus = true; //false:정상 / true:에러발생
		String resultCode = null;
		String resultMsg = null;
		
		int updateCnt = 0;
		SqlMapClient client = null;
		try{
			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
			client = SqlMapClientBuilder.buildSqlMapClient(reader);
			client.startTransaction();
			if ("".equals(request.get("DeliverySeq"))){
				updateCnt = client.update("insertDeliveryInfo",request);
			}else{
				updateCnt = client.update("updateDeliveryInfo",request);
			}
			client.commitTransaction();
			errorStatus = false;
		} catch(Exception e){
			errorStatus = true;
			resultMsg = "배송정보 업데이트 오류 발생 다시 시도해주세요.";
			e.printStackTrace();
		} finally {
			client.endTransaction();
			if(updateCnt == 0 && errorStatus == false){
				resultBox = new Box();
				errorStatus = true;
				resultMsg = "배송정보 업데이트 오류 발생 다시 시도해주세요.";
			}
			if(errorStatus == true){
				resultBox.put("ResultCode", "9999");
				resultBox.put("ResultMsg", resultMsg);
				return resultBox;
			}else{
				resultBox.put("ResultCode", "0000");
				resultBox.put("ResultMsg", "배송정보 업데이트 성공");
				return resultBox;
			}
		}
	}
	
	public static final Box selectSmsPgInfo(String mid, String svccd, String svcprdtcd){
		Box resultBox = new Box();
		String resultMsg = null;
		
		SqlMapClient client = null;
		try{
			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			Box reqBox = new Box();
			reqBox.put("mid", mid);
			reqBox.put("svccd", svccd);
			reqBox.put("svcprdtcd", svcprdtcd);
			resultBox = (Box) client.queryForObject("selectSmsPgInfo",reqBox);

			if(resultBox==null||resultBox.isEmpty()){
				resultBox.put("ResultCode", "0000");
				resultBox.put("ResultMsg", "가맹점 정보 조회 실패");
			}else{
				resultBox.put("ResultCode", "0000");
				resultBox.put("ResultMsg", "주문정보 조회 성공");
			}
		} catch(Exception e){
			resultMsg = "가맹점정보 조회 오류 발생 관리자에게 문의해주세요.";
			e.printStackTrace();
			resultBox.put("ResultCode", "9999");
			resultBox.put("ResultMsg", resultMsg);
		}
		return resultBox;
	} // end method
	
	public static final Box selectPgInfo(String mid, String svccd, String svcprdtcd){
		Box resultBox = new Box();
		String resultMsg = null;
		
		SqlMapClient client = null;
		try{
			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			Box reqBox = new Box();
			reqBox.put("mid", mid);
			reqBox.put("svccd", svccd);
			reqBox.put("svcprdtcd", svcprdtcd);
			resultBox = (Box) client.queryForObject("selectPgInfo",reqBox);

			if(resultBox==null||resultBox.isEmpty()){
				resultBox = new Box();
				resultBox.put("ResultCode", "9999");
				resultBox.put("ResultMsg", "신용카드 정보 조회 실패");
			}else{
				resultBox.put("ResultCode", "0000");
				resultBox.put("ResultMsg", "신용카드 정보 조회 성공");
			}
		} catch(Exception e){
			resultMsg = "가맹점정보 조회 오류 발생 관리자에게 문의해주세요.";
			e.printStackTrace();
			resultBox.put("ResultCode", "9999");
			resultBox.put("ResultMsg", resultMsg);
		}
		return resultBox;
	} // end method
	
} // end class
