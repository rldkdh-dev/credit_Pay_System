package service;

/**
 * CardSvc.java Class is Designed for providing 
 *
 * Copyright    Copyright (c) 2016
 * Company      Infinisoft Co.
 *
 * @Author      : 김봉민
 * @File        : service.CardSvc.java
 * @Version     : 1.0,
 * @See         : 
 * @Description : 
 * @Date        : 2017. 6. 26. - 오후 6:44:13
 * @ServiceID:
 * @VOID:
 * @Commnad:
 *
 **/

import java.io.IOException;
import java.io.Reader;
import java.nio.charset.Charset;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import util.CommonUtil;

public class CardSvc {
	private static final Logger logger = LoggerFactory.getLogger(CardSvc.class);
	private Reader reader = null;
	private SqlMapClient client = null;
	private String authFlg = "02";	// 인증(기본값)
	
	public CardSvc() {
		try {
			Charset charset = Charset.forName("UTF-8");
			Resources.setCharset(charset);
			reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
			client = SqlMapClientBuilder.buildSqlMapClient(reader);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}
	public CardSvc(String auth_flg) {
		try {
			this.authFlg = auth_flg;
			Charset charset = Charset.forName("UTF-8");
			Resources.setCharset(charset);
			reader = Resources.getResourceAsReader("SqlMapConfigS.xml");
			client = SqlMapClientBuilder.buildSqlMapClient(reader);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}
	
	/**
	 * 가맹점 카드 설정 정보 리스트 생성
	 * @param mid
	 * @return
	 * SVC_CD='01' 카드
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String getCardInfoMap(String mid){
		JSONArray arr = new JSONArray();
		JSONObject obj = null;

		try{
			/**
			 * 1. 카드사 정보 생성
			 */ 
			List<HashMap> cardList = client.queryForList("cardservice.select.tb_code.cardcode");
			if(cardList!=null&& cardList.size()>0){
				for(int i=0;i<cardList.size();i++){
					obj = new JSONObject();
					HashMap map1 = cardList.get(i);
					CardInfoVO vo = new CardInfoVO();
					vo.put("cardCode",(String) map1.get("code1"));
					vo.put("cardNm",(String)map1.get("desc1"));
					vo.put("code2",(String)map1.get("code2"));
//					System.out.println("**** cardList vo "+vo.toString());
					obj.put((String)map1.get("code1"), vo);
//					System.out.println("**** cardList obj "+obj.toString());
					arr.add(obj);
//					System.out.println("**** cardList arr "+arr.toString());
				}
			/**
			 * 2. PG 정보 생성
			 * VAN 정보가 설정되어 있는 경우 VAN 정보를 우선으로 한다.
			 * 2017.09.12 인증/비인증 가맹점이 모두 등록되어 있는경우 오류가 있어
			 * auth_flg 로 구분함.	
			 */ 
				List<HashMap> pgList = null;
				List<HashMap> overList = null;
				// 2018.08 쿼리에 해외카드 필드 추가
				if("01".equals(authFlg)){
					pgList = client.queryForList("cardservice.select.tb_pg_info.mid_keyin", mid);
				}else{
					pgList = client.queryForList("cardservice.select.tb_pg_info.mid_auth", mid);	// 무조건 1개가 있어야 함
					overList = client.queryForList("cardservice.select.tb_pg_info.mid_auth.over", mid);
					// 2020.01.28 해외카드만 사용하는 가맹점 Case 추가
					if(pgList==null || pgList.size()<1) {
					    if(overList!=null && overList.size()>0) {
					        pgList.addAll(overList);
					    }
					}
				}
				logger.info("*****pgList.size()["+pgList.size()+"]");
				if(pgList!=null&&pgList.size()>0){
					String[] blockStr = null;

					for(int i=0;i<pgList.size();i++){
						HashMap map2 = pgList.get(i);
						blockStr = ((String)map2.get("block_card")).split(":");
						for(int j=0;j<arr.size();j++){
							JSONObject json = (JSONObject) arr.get(j);
							Iterator it = json.keySet().iterator();
							while(it.hasNext()){
								String key = (String)it.next();
								CardInfoVO vo = (CardInfoVO) json.get(key);
								if("03".equals(map2.get("pg_cd"))) {
								    vo.put("transCl","2");      // 2:VAN
								}else {
								    vo.put("transCl","1");      // 1:PG
								}
								vo.put("fnNo",""); // 가맹점번호 셋팅 안함 2020.09
								vo.put("pgCd",(String)map2.get("pg_cd"));
								vo.put("pgKeyInCl",(String)map2.get("pg_key_in_cl"));
								vo.put("pgLicenseKey",(String)map2.get("pg_license_key"));
								vo.put("pgMid",(String)map2.get("pg_mid"));
								/**
								 * 2-1. 무이자 이벤트 설정
								 * PG별 설정된 무이자 이벤트 정보 업데이트
								 * 가맹점 무이자 이벤트는 추후 적용
								 */
								HashMap req = new HashMap();
								req.put("pg_cd", map2.get("pg_cd"));
								req.put("fn_cd", key);
								req.put("mid", mid);
								// 카드사 무이자 할부
								HashMap eventMap = (HashMap) client.queryForObject("cardservice.select.tb_event_card.pg.instmn", req);
								String evt_card = "";
								// 가맹점 무이자 할부
								HashMap evtMerMap = (HashMap) client.queryForObject("cardservice.select.tb_event_merchant.pg.instmn", req);
								String evt_merchant = "";
								if(eventMap!=null&& !eventMap.isEmpty()){
									vo.put("noInterestYn","Y");
									vo.put("eventAmt", eventMap.get("event_amt"));
									vo.put("instMn", (String)eventMap.get("instmn_mm"));
									evt_card = (String)eventMap.get("instmn_mm");
								}
								if(evtMerMap!=null && !evtMerMap.isEmpty()) {
									vo.put("noInterestYn","Y");
									vo.put("eventAmt", evtMerMap.get("event_amt"));
									vo.put("instMn", (String)evtMerMap.get("instmn_mm"));
									evt_merchant = (String)evtMerMap.get("instmn_mm");
								}
								String evt_instMn = getInstmnMergeString(evt_card,evt_merchant);
//								logger.debug("*********** evt_instMn ["+key+"]["+evt_instMn+"]");
								vo.put("instMn", evt_instMn);
								
								if(blockStr!=null&&blockStr.length>0){
									for(int k=0;k<blockStr.length;k++){
										if(key.equals(blockStr[k])){
											vo.put("blockYn","Y");
										}
									}
								}else{
									vo.put("blockYn","N");
								}
								// 해외카드가 설정되어 있는지 확인
								if("over".equals(vo.get("code2"))) {	// 해외카드 코드인 경우
									vo.put("blockYn", "Y");
									if(overList!=null && overList.size()>0) {
										String[] overStr = null;
										for(int m=0;m<overList.size();m++) {
											HashMap map3 = overList.get(m);
											overStr =  ((String)map3.get("over_card")).split(":");
											if(overStr!=null && overStr.length>0) {
												for(int n=0;n<overStr.length;n++) {
													if(key.equals(overStr[n])) {
														vo.put("blockYn", "N");
														vo.put("pgCd",(String)map3.get("pg_cd"));
														vo.put("pgKeyInCl",(String)map3.get("pg_key_in_cl"));
														vo.put("pgLicenseKey",(String)map3.get("pg_license_key"));
														vo.put("pgMid",(String)map3.get("pg_mid"));
													}
												}
											}
										} // end for(int m=0;m<overList.size();m++)
									} // end if(overList!=null && overList.size()>0)	
								} // 해외카드 설정 끝.
								
							} // end while
						} // end for
						
					} // end for(int i=0;i<pgList.size();i++)

					
				} // end PG list
//				System.out.println("**** pgList arr "+arr.toString());
			/**
			 * 3. VAN 정보 생성
			 * 2020.09 PG 정보로 통합
			 */ 	
//				List<HashMap> vanList = client.queryForList("cardservice.select.tb_join_info.mid", mid);
//				if(vanList!=null&&vanList.size()>0){
//					for(int i=0;i<vanList.size();i++){
//						HashMap map3 = vanList.get(i);
//						String key = (String)map3.get("fn_cd");	// 카드사코드
//						
//						for(int j=0;j<arr.size();j++){
//							JSONObject json = (JSONObject) arr.get(j);
//							if(json.containsKey(key)){
//								CardInfoVO vo = (CardInfoVO) json.get(key);
//								vo.put("transCl",(String)map3.get("trans_cl"));
//								vo.put("fnNo",(String)map3.get("fn_no"));
//							}
//						}
//
//					} // end for
////					System.out.println("**** vanList1 arr "+arr.toString());
//				/**
//				 * 3-1. VAN 정보가 있는 경우만 block card 를 체크한다.	
//				 */
//					HashMap merMap = (HashMap) client.queryForObject("cardservice.select.tb_merchant.card_block", mid);
//					if(merMap!=null&& !merMap.isEmpty()){
//						String[] useStr = ((String)merMap.get("card_use")).split(":");
//						String[] blockStr = ((String)merMap.get("card_block")).split(":");
//						for(int i=0;i<useStr.length;i++){
//							String key = useStr[i];
//							for(int j=0;j<arr.size();j++){
//								JSONObject json = (JSONObject) arr.get(j);
//								if(json.containsKey(key)){
//									CardInfoVO vo = (CardInfoVO) json.get(key);
//									vo.put("blockYn","N");	
//								}
//							}
//							
//						} // end for
//						for(int k=0;k<blockStr.length;k++){
//							String key = blockStr[k];
//							for(int l=0;l<arr.size();l++){
//								JSONObject json = (JSONObject) arr.get(l);
//								if(json.containsKey(key)){
//									CardInfoVO vo = (CardInfoVO) json.get(key);
//									vo.put("blockYn","Y");	
//								}
//							}
//							
//						} // end for
//					} // end if
//					
//					/**
//					 * 3-2. 무이자 이벤트 설정
//					 * VAN > 카드사별 설정된 무이자 이벤트 정보 업데이트
//					 * 가맹점 무이자 이벤트는 추후 적용
//					 */
//					List<HashMap> vanEventList = client.queryForList("cardservice.select.tb_event_card.van.instmn", mid);
//					if(vanEventList!=null&&vanEventList.size()>0){
//						for(int i=0;i<vanEventList.size();i++){
//							HashMap eventMap = vanEventList.get(i);
//							String key = (String)eventMap.get("fn_cd");	// 카드사코드
//							for(int j=0;j<arr.size();j++){
//								JSONObject json = (JSONObject) arr.get(j);
//								if(json.containsKey(key)){
//									CardInfoVO vo = (CardInfoVO) json.get(key);
//									vo.put("noInterestYn","Y");
//									vo.put("eventAmt", eventMap.get("event_amt"));
//									vo.put("instMn", (String)eventMap.get("instmn_mm"));
//								}
//							}
//						}
//					}
//					
//				} // end VAN list
////				System.out.println("**** vanList2 arr "+arr.toString());
				
			}else{
				logger.error("getCardInfoList cardlist is null");
			}
			
		}catch(Exception e){
			logger.error("getCardInfoList Exception ["+mid+"]", e);
			return null;
		}
//      logger.debug("****CardInfoMap "+arr.toString());
		return arr.toJSONString();
	}
	
	/**
	 * 가맹점 할부 기본정보 설정
	 * TODO : 카드사별로 무이자정보를 업데이트 해야한다. 
	 */
	@SuppressWarnings("unchecked")
	public String getBaseInstmnMap(String mid, String amt, int max){
		if(max==0) max=12;
		JSONArray arr = new JSONArray();
		JSONObject obj = null;
		long amount = 0;
		try{
			amount = Long.parseLong(amt);
			if(amount<50000){
				obj = new JSONObject();
				obj.put("00", "일시불");
				arr.add(obj);
				return arr.toJSONString();
			}
		}catch(Exception e){
			obj = new JSONObject();
			obj.put("00", "일시불");
			arr.add(obj);
			return arr.toJSONString();
		}
		
		String limit_mon = "";
		try {
			limit_mon = (String)client.queryForObject("cardservice.select.tb_merchant.limit_instmn", mid);
		} catch (SQLException e) {
			logger.error("getInstmnMap Exception ["+mid+"]",e);
		}
		if(StringUtils.isNotEmpty(limit_mon)){
			try {
				max = Integer.parseInt(limit_mon);
			} catch (NumberFormatException e) {
				logger.error("getInstmnMap limit_mon parseInt Exception ",e);
				max=12;
			}
		}
		
		for(int i=0;i<=max;i++){
			obj = new JSONObject();
			if(i==0){
				obj.put("00", "일시불");
				arr.add(obj);
			}
			if(i>1){
				String key = CommonUtil.fixSizeZero(String.valueOf(i), 2);
				obj.put(key, String.valueOf(i)+"개월");
				arr.add(obj);
			}
		}
		
		return arr.toJSONString();
	}

	@SuppressWarnings("rawtypes")
	public CardListVO getCardList(String cardInfoMapStr){
		CardListVO cvo = new CardListVO();
		StringBuffer sbAll = new StringBuffer();
		StringBuffer sbMajor = new StringBuffer();
		StringBuffer sbMinor = new StringBuffer();
		StringBuffer sbOver = new StringBuffer();
		JSONParser parser = new JSONParser();
		JSONArray arr = new JSONArray();
		// option >> null:전체, pur:Major *:Minor over:해외카드
		try {
			 arr = (JSONArray) parser.parse(cardInfoMapStr);
			 for(int i=0;i<arr.size();i++){
				 JSONObject obj = (JSONObject) arr.get(i);
				 Iterator it = obj.keySet().iterator();
				 while(it.hasNext()){
					 String key = (String) it.next();
					 JSONObject vo = (JSONObject) obj.get(key);
					 
					 if(!"Y".equals(vo.get("blockYn"))){
						 sbAll.append("<option value="+key+">"+vo.get("cardNm")+"</option>");
						 if("pur".equals(vo.get("code2"))){
							 sbMajor.append("<option value="+key+">"+vo.get("cardNm")+"</option>");
						 }else if("*".equals(vo.get("code2"))){
							 sbMinor.append("<option value="+key+">"+vo.get("cardNm")+"</option>");
						 }else if("over".equals(vo.get("code2"))){
							 sbOver.append("<option value="+key+">"+vo.get("cardNm")+"</option>");
						 }
					 }					 
				 } // end while
			 } // end for
			 
		} catch (ParseException e) {
			logger.error("getMajorCardList Exception ", e);
		}
		cvo.setAllList(sbAll.toString());
		cvo.setMajorList(sbMajor.toString());
		cvo.setMinorList(sbMinor.toString());
		cvo.setOverList(sbOver.toString());
//		logger.debug("sbAll "+sbAll.toString());
//		logger.debug("sbMajor "+sbMajor.toString());
//		logger.debug("sbMinor "+sbMinor.toString());
//		logger.debug("sbOver "+sbOver.toString());
		
		return cvo;
	}
	
	@SuppressWarnings("rawtypes")
	public CardListVO getCardList2(String cardInfoMapStr){
		CardListVO cvo = new CardListVO();
		StringBuffer sbMajor = new StringBuffer();
		StringBuffer sbMinor = new StringBuffer();
		StringBuffer sbOver = new StringBuffer();
		JSONParser parser = new JSONParser();
		JSONArray arr = new JSONArray();
		//   >> null:전체, pur:Major *:Minor over:해외카드
		try {
			 arr = (JSONArray) parser.parse(cardInfoMapStr);
			 for(int i=0;i<arr.size();i++){
				 JSONObject obj = (JSONObject) arr.get(i);
				 Iterator it = obj.keySet().iterator();
				 while(it.hasNext()){
					 String key = (String) it.next();
					 JSONObject vo = (JSONObject) obj.get(key);
					 
					 if (vo.get("cardNm").equals("비씨")) {
						 vo.put("cardNm", "비씨카드");
					 } else if (vo.get("cardNm").equals("국민")) {
						 vo.put("cardNm", "KB국민");
					 } else if (vo.get("cardNm").equals("신한")) {
						 vo.put("cardNm", "신한카드");
					 } else if (vo.get("cardNm").equals("현대")) {
						 vo.put("cardNm", "현대카드");
					 } else if (vo.get("cardNm").equals("삼성")) {
						 vo.put("cardNm", "삼성카드");
					 } else if (vo.get("cardNm").equals("롯데")) {
						 vo.put("cardNm", "롯데카드");
					 } else if (vo.get("cardNm").equals("하나")) {
						 vo.put("cardNm", "하나카드");
					 } else if (vo.get("cardNm").equals("우리")) {
						 vo.put("cardNm", "우리카드");
					 } else if (vo.get("cardNm").equals("씨티")) {
						 vo.put("cardNm", "씨티카드");
					 } else if (vo.get("cardNm").equals("외환")) {
						 vo.put("cardNm", "하나(외환)");
					 } else if (vo.get("cardNm").equals("광주")) {
						 vo.put("cardNm", "광주카드");
					 } else if (vo.get("cardNm").equals("전북")) {
						 vo.put("cardNm", "전북카드");
					 } else if (vo.get("cardNm").equals("수협")) {
						 vo.put("cardNm", "수협카드");
					 } else if (vo.get("cardNm").equals("산은")) {
						 vo.put("cardNm", "KDB산업");
					 } else if (vo.get("cardNm").equals("제주")) {
						 vo.put("cardNm", "제주카드");
					 } else if (vo.get("cardNm").equals("신협")) {
						 vo.put("cardNm", "신협카드");
					 }
					 
					 if(!"Y".equals(vo.get("blockYn"))){
						 if("pur".equals(vo.get("code2"))){
							 sbMajor.append("<a href=\"#\" value=\"" + key + "\" onclick=\"javascript:goCheckCard2('" + key + "', '" + vo.get("cardNm") + "', '');\"><p class=\"card" + Integer.parseInt(key) + "\">" + vo.get("cardNm") + "</p></a>");
						 } else if( "*".equals(vo.get("code2")) && !(Integer.parseInt(key) >= 37 && Integer.parseInt(key) <= 44) ){
							 sbMinor.append("<a href=\"#\" value=\"" + key + "\" onclick=\"javascript:goCheckCard2('" + key + "', '" + vo.get("cardNm") + "', 'etc');\"><p class=\"card" + Integer.parseInt(key) + "\">" + vo.get("cardNm") + "</p></a>");
						 } else if("over".equals(vo.get("code2"))){
							 sbMinor.append("<a href=\"#\" value=\"" + key + "\" onclick=\"javascript:goCheckCard2('" + key + "', '" + vo.get("cardNm") + "', 'etc');\"><p class=\"card" + Integer.parseInt(key) + "\">" + vo.get("cardNm") + "</p></a>");
							 sbOver.append("<a href=\"#\" value=\"" + key + "\" onclick=\"javascript:goCheckCard2('" + key + "', '" + vo.get("cardNm") + "', 'etc');\"><p class=\"card" + Integer.parseInt(key) + "\">" + vo.get("cardNm") + "</p></a>");
						 }
					 }					 
				 } // end while
			 } // end for
			 
		} catch (ParseException e) {
			logger.error("getMajorCardList Exception ", e);
		}
		cvo.setMajorList(sbMajor.toString());
		cvo.setMinorList(sbMinor.toString());
		cvo.setOverList(sbOver.toString());
		return cvo;
	}
	
//	<a href="#" value="01" onclick="javascript:goCheckCard2('01', '비씨카드', '');">
//	<p class="card1">비씨카드</p>
//</a>
	
	public String getKvpQuota(String baseInstmnMapStr){
		StringBuffer sb = new StringBuffer();
		JSONParser parser = new JSONParser();
		JSONArray arr = new JSONArray();
		try{
			arr = (JSONArray) parser.parse(baseInstmnMapStr);
			for(int i=0;i<arr.size();i++){
				JSONObject obj = (JSONObject) arr.get(i);
				 Iterator it = obj.keySet().iterator();
				 while(it.hasNext()){
					 String key = (String) it.next();
					 sb.append(Integer.parseInt(key));
					 sb.append(":");
				 }
			}
		}catch(Exception e){
			logger.error("getKvpQuota Exception ", e);
		}
		String str = sb.toString();
		if(str.lastIndexOf(":")==(str.length()-1)){
			str= str.substring(0,str.length()-1);
		}
		return str;
	}

	private String getInstmnMergeString(String cardStr, String merStr) {
		StringBuffer sb = new StringBuffer();
		if(StringUtils.isEmpty(cardStr)) {
			return merStr;
		}else if(StringUtils.isEmpty(merStr)) {
			return cardStr;
		}
		
		try {
			List<String> list = new ArrayList<String>();
			String[] card_arr = cardStr.split(":");
			String[] mer_arr = merStr.split(":");
			
			for(int i=0;i<card_arr.length;i++) {
				if(StringUtils.isNotEmpty(card_arr[i]) && !list.contains(card_arr[i])) {
					list.add(card_arr[i]);
				}
			}
			
			for(int j=0;j<mer_arr.length;j++) {
				if(StringUtils.isNotEmpty(mer_arr[j]) && !list.contains(mer_arr[j])) {
					list.add(mer_arr[j]);
				}
			}
			Collections.sort(list);
			
			for(int k=0;k<list.size();k++){
				sb.append(list.get(k));
				if((k+1)<list.size()) sb.append(":");
			}
		}catch(Exception e) {
			logger.error("getInstmnMergeString exception ["+cardStr+"]["+merStr+"] "+e.getMessage(), e);
		}
		
		return sb.toString();
	}
	
} // end class

