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

public class Insurance {

	@SuppressWarnings("finally")
	public List<DataModel> getInsuranceList(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		List<DataModel> dataList = null;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			dataList = client.queryForList("getInsuranceList", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return dataList;

	}
	
	@SuppressWarnings("finally")
	public List<DataModel> getInsuranceSendList(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		List<DataModel> dataList = null;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			dataList = client.queryForList("getInsuranceSendList", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return dataList;

	}
	
	@SuppressWarnings("finally")
	public List<DataModel> getInsuranceReqList(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		List<DataModel> dataList = null;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			dataList = client.queryForList("getInsuranceReqList", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return dataList;

	}
	
	@SuppressWarnings("finally")
	public DataModel getInsuranceServiceUseInfo(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		DataModel map = null;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			map = (DataModel) client.queryForObject("getInsuranceServiceUseInfo", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return map;

	}
	
	@SuppressWarnings("finally")
	public int updateInsuranceSendRecv(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		DataModel map = null;
		int iRtn = 0;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			iRtn = client.update("updateInsuranceSendRecv", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return iRtn;

	}
	
	@SuppressWarnings("finally")
	public int updateInsuranceReqRecv(DataModel dataModel) throws Exception{

		SqlMapClient client = null;

		DataModel map = null;
		int iRtn = 0;

		try{

			Reader reader = Resources.getResourceAsReader("SqlMapConfigS.xml");

			client = SqlMapClientBuilder.buildSqlMapClient(reader);

			client.startTransaction();

			iRtn = client.update("updateInsuranceReqRecv", dataModel);

			client.commitTransaction();

		} catch(Exception e){
			e.printStackTrace();

		} finally{
			client.endTransaction();

		}
		return iRtn;

	}

	//가맹점 발송 메일
	public StringBuffer getTemplate(DataModel map){

		StringBuffer used_sb = new StringBuffer();
		used_sb.append("<td style=\"margin: 0;padding: 0;text-align: left;\">");
		used_sb.append("<span style=\"width: 40px;height: 20px\">");
		used_sb.append("<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
		used_sb.append("</span>");
		used_sb.append("</td>");
		used_sb.append("<td width=\"138\" style=\"width:138px;margin: 0;padding: 0;text-align: left; color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		
		StringBuffer notused_sb = new StringBuffer();
		notused_sb.append("<td style=\"margin: 0;padding: 0;text-align: left;\">");
		notused_sb.append("<span style=\"width: 60px;height: 20px;\">");
		notused_sb.append("<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
		notused_sb.append("</span>");
		notused_sb.append("</td>");
		notused_sb.append("<td width=\"118\" style=\"width:118px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"ko\" xml:lang=\"ko\">");
		sb.append("<head>");
		sb.append("<meta name=\"viewport\" content=\"width=device-width\" />");
		sb.append("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\" />");
		sb.append("<meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\" />");
		sb.append("<meta name=\"format-detection\" content=\"telephone=no\" />");
		sb.append("<style type=\"text/css\">");
		sb.append("a:link {text-decoration: none; color: #666;}");
		sb.append("a:visited {text-decoration: none; color: #666;}");
		sb.append("a:active {text-decoration: none; color: #666;}");
		sb.append("a:hover {text-decoration: none; color: #666; opacity: 0.7;}");
		sb.append("</style>");
		sb.append("</head>");
		sb.append("<body width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" border=\"0\" style=\"letter-spacing: -0.5px;margin:0;padding:0;-webkit-text-size-adjust: 100%;\">");
		sb.append("<div style=\"letter-spacing: -0.5px;width: 600px; margin: 0px auto;\">");
		sb.append("	<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  align=\"center\" bgcolor=\"ffffff\"  style=\"letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;border: 1px solid #eee;\" >");
		sb.append("		<!-- center -->");
		sb.append("		<tr>");
		sb.append("			<td style=\"letter-spacing: -0.5px;padding:0; margin:0;\">");
		sb.append("					<!-- contents -->");
		sb.append("					<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("						<tr>");
		sb.append("							<td>");
		sb.append("								<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									<tr>");
		sb.append("										<td height=\"12\" bgcolor=\"ffffff\"></td>");
		sb.append("									</tr>");
		sb.append("									<tr>");
		sb.append("										<td style=\"letter-spacing: -0.5px;padding-left:30px;text-align: left;\">");
		sb.append("											<span style=\"width: 187px;height: 26px;\">");
		sb.append("												<img src=\"https://admin.innopay.co.kr/mer/img/innopay_logo3.png\" width=\"174\" height=\"26\" alt=\"이노페이 전자결제서비스\" border=\"0\">");
		sb.append("											</span>");
		sb.append("										</td>");
		sb.append("										<td style=\"letter-spacing: -0.5px;padding-right:30px;text-align: right; font-size: 14px; font-weight: normal; color:#1e5dd2;font-family:malgun-gothic, sans-serif;\">");
		sb.append("											보증증권 갱신 안내");
		sb.append("										</td>");
		sb.append("									</tr>");
		sb.append("									<tr>");
		sb.append("										<td height=\"12\" bgcolor=\"ffffff\"></td>");
		sb.append("									</tr>");
		sb.append("								</table>");
		sb.append("							</td>");
		sb.append("						</tr>");
		sb.append("						<tr>");
		sb.append("							<td>");
		sb.append("								<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									<tr>");
		sb.append("										<td width=\"600\" style=\"letter-spacing: -1px;background-color: #1a54c1; color:#dfe4f3; font-weight: bold;font-size: 20px;line-height: 30px;padding:40px 30px;font-family:malgun-gothic, sans-serif;\">");
		sb.append("											이노페이<span style=\"font-weight: normal;font-size: 16px;line-height: 30px;font-family:malgun-gothic, sans-serif;\">에서 사용중인 서비스의</span><br><span style=\"color:#ffaf3c;font-family:malgun-gothic, sans-serif;\">보증증권 갱신 신청 </span><span style=\"font-weight: normal;font-size: 16px;line-height: 30px;font-family:malgun-gothic, sans-serif;\">되었습니다.</span>");
		sb.append("										</td>");
		sb.append("									</tr>");
		sb.append("								</table>");
		sb.append("							</td>");
		sb.append("						</tr>");
		sb.append("						<tr>");
		sb.append("							<td>");
		sb.append("								<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									<tr>");
		sb.append("										<td style=\"letter-spacing: -0.5px;padding:40px 30px;background: #fff\">");
		sb.append("											<table width=\"524\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("												<tr>");
		sb.append("													<td style=\"letter-spacing: -0.5px;padding: 30px;background: #fff;border: 8px solid #eee;\">");
		sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;border-bottom: 1px solid #eee;\">");
		sb.append("															<tr>");
		sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 15px;line-height: 24px;font-family:malgun-gothic, sans-serif; padding-bottom: 16px;\">");
		sb.append("																	만료일");
		sb.append("																</td>");
		sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#ff7800; font-weight: bold;font-size: 20px;line-height: 24px;font-family:malgun-gothic, sans-serif;padding-bottom: 16px;vertical-align: middle;\">");
		sb.append("																	"+DateUtil.formatDate(map.getStrNull("to_dt")));
		sb.append("																</td>");
		sb.append("															</tr>");
		sb.append("														</table>");
		sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("															<tr>");
		sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 13px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;padding-top: 16px;\">");
		sb.append("																	보증보험증권 가입금액");
		sb.append("																</td>");
		sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;vertical-align: middle;padding-top: 16px;\">");
		sb.append("																	"+StringUtil.formatNumber(map.getStrNull("insurance_amt"))+"<span style=\"font-size: 14px;padding-left: 2px;\">원</span>");
		sb.append("																</td>");
		sb.append("															</tr>");
		sb.append("														</table>");
		
		//승인한도
		if(map.getStrNull("limit_cl").equals("01")){
			sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
			sb.append("															<tr>");
			sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 13px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;\">");
			sb.append("																	이노페이PG 승인한도");
			sb.append("																</td>");
			sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;vertical-align: middle;\">");
			sb.append("																	"+StringUtil.formatNumber(map.getStrNull("limit_amt"))+"<span style=\"font-size: 14px;padding-left: 2px;\">원</span>");
			sb.append("																</td>");
			sb.append("															</tr>");
			sb.append("														</table>");
		}
		
		//정산한도
		if(map.getStrNull("limit_cl").equals("02")){
			sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
			sb.append("															<tr>");
			sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 13px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;\">");
			sb.append("																	이노페이PG 정산한도");
			sb.append("																</td>");
			sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;vertical-align: middle;\">");
			sb.append("																	"+StringUtil.formatNumber(map.getStrNull("limit_amt"))+"<span style=\"font-size: 14px;padding-left: 2px;\">원</span>");
			sb.append("																</td>");
			sb.append("															</tr>");
			sb.append("														</table>");
		}
		
		sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("															<tr>");
		sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 13px;line-height: 20px;font-family:malgun-gothic, sans-serif;\">");
		sb.append("																	보증보험증권 유효기간");
		sb.append("																</td>");
		sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 20px;font-family:malgun-gothic, sans-serif;vertical-align: middle;\">");
		sb.append("																	"+DateUtil.formatDate(map.getStrNull("fr_dt"))+" ~ "+DateUtil.formatDate(map.getStrNull("to_dt")));
		sb.append("																</td>");
		sb.append("															</tr>");
		sb.append("														</table>	");
		sb.append("													</td>");
		sb.append("												</tr>");
		sb.append("											</table>");
		sb.append("											<table width=\"540\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\" margin: 0;padding: 0;border-spacing: 0; border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									        	<tbody>");
		sb.append("									          		<tr>");
		sb.append("														<td colspan=\"2\" height=\"15\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 15px;padding-top: 40px; padding-bottom:8px; font-family:malgun-gothic, sans-serif;\">");
		sb.append("														결제서비스 사용 현황");
		sb.append("														</td>");
		sb.append("													</tr>");
		sb.append("													<tr>");
		sb.append("														<td colspan=\"2\" style=\"letter-spacing: -0.5px;color:#709ce6; font-weight: bold;font-size: 12px;line-height: 18px;padding-bottom:20px;padding-top:0px; font-family:malgun-gothic, sans-serif;\">");
		sb.append("														미가입 서비스를 클릭하시면 서비스 정보를 확인할 수 있습니다.<br>서비스 가입은 고객센터로 문의 해주시기 바랍니다.");
		sb.append("														</td>");
		sb.append("													</tr>");
		sb.append("													<tr>");
		sb.append("														<td colspan=\"2\" height=\"15\" width=\"540\" style=\"letter-spacing: -0.5px;color:#666; font-weight: bold;font-size: 13px;line-height: 15px;padding:6px;font-family:malgun-gothic, sans-serif;text-align: center;background-color: #f4f4f4;vertical-align: middle;height: 15px;\">");
		sb.append("														신용카드 결제 서비스");
		sb.append("														</td>");
		sb.append("													</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;border-right: 1px solid #efefed\">");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon1.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("card_keyin_yn").equals("y")){ sb.append(used_sb.toString()); }else{ sb.append(notused_sb.toString()); }
		
		sb.append("											              								상담원 수기결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">상담원이 고객의 카드정보를 불러 받아 수기로 카드정보를 입력하여 결제하는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;\" >");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\" >");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon2.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("card_ars_yn").equals("y")){ sb.append(used_sb.toString()); }else{ sb.append(notused_sb.toString()); }
		
		sb.append("											              								ARS 안심결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">고객에게 가상ARS를 발송하여 고객이 전화 연결하여 결제하는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;border-right: 1px solid #efefed;border-top: 1px solid #efefed\">");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("																			<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon3.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("sms_keyin_yn").equals("y")){ sb.append(used_sb.toString()); }else{ sb.append(notused_sb.toString()); }
		
		sb.append("											              								SMS 수기결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">고객에게 결제링크(URL)를 발송하고 고객이 접속하여 카드정보를 직접 입력하여 결제하는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;border-top: 1px solid #efefed\" >");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\" >");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon3.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("sms_auth_yn").equals("y")){ sb.append(used_sb.toString()); }else{ sb.append(notused_sb.toString()); }
		
		sb.append("											              								SMS 인증결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">고객에게 결제링크(URL)를 발송하고 고객이 접속하여 본인인증 후 결제하는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td colspan=\"2\" style=\"padding: 20px 16px 20px 16px;border-top: 1px solid #efefed\">");
		sb.append("									           				<table width=\"508\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon4.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"458\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("card_auth_yn").equals("y")){
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 40px;height: 20px\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"410\" style=\"width:410px;margin: 0;padding: 0;text-align: left;color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}else{
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 60px;height: 20px\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"390\" style=\"width:390px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}

		sb.append("											              								ISP / 안심클릭 인증결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">온라인 쇼핑몰 등에서 신용카드 결제 시 카드사별 본인인증 후<br>결제를 진행하는 온라인 표준 결제서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									          		<tr>");
		sb.append("														<td colspan=\"2\" height=\"15\" width=\"540\" style=\"letter-spacing: -0.5px;color:#666; font-weight: bold;font-size: 13px;line-height: 15px;padding:6px;font-family:malgun-gothic, sans-serif;text-align: center;background-color: #f4f4f4;vertical-align: middle;height: 15px;\">");
		sb.append("														기타 서비스");
		sb.append("														</td>");
		sb.append("													</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;border-right: 1px solid #efefed\">");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon5.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("accnt_yn").equals("y")){
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 40px;height: 20px\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"138\" style=\"width:138px;margin: 0;padding: 0;text-align: left;color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}else{
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 60px;height: 20px\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"118\" style=\"width:118px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}
		
		sb.append("											              								계좌이체 서비스");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">구매자가 입력한 은행 계좌(통장)에서 상품대금을 실시간으로 출금하는 결제 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;\" >");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\" >");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon6.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("vbank_yn").equals("y")){
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 40px;height: 20px;\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"138\" style=\"width:138px;margin: 0;padding: 0;text-align: left;color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}else{
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 60px;height: 20px;\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"118\" style=\"width:118px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}
		
		sb.append("											              								가상계좌 서비스");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">1회용 가상계좌번호를 발급 받아 해당 계좌로 입금 시 실시간으로 입금확인 및 수납처리 되는 결제 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td colspan=\"2\" style=\"padding: 20px 16px 20px 16px;border-top: 1px solid #efefed;border-bottom: 1px solid #efefed\" >");
		sb.append("									           				<table width=\"508\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon7.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"458\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");
		
		if(map.getStrNull("recpt_yn").equals("y")){
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 40px;height: 20px;\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"410\" style=\"width:410px;margin: 0;padding: 0;text-align: left;color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}else{
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 60px;height: 20px;\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"390\" style=\"width:390px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}

		sb.append("											              								현금 영수증");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">고객이 현금으로 결제시 현금영수증 발급장치로 현금 영수증을 발급하고<br>결제내역은 국세청에 통보 되는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									         	</tbody>");
		sb.append("									        </table>");
		sb.append("										</td>");
		sb.append("									</tr>");
		sb.append("								</table>");
		sb.append("							</td>");
		sb.append("						</tr>");
		sb.append("						<!-- //footer -->");
		sb.append("						<tr>");
		sb.append("							<td bgcolor=\"f6f6f6\">");
		sb.append("								<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" align=\"center\" style=\"padding:0; margin: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									<tr>");
		sb.append("										<td width=\"600\" style=\"padding: 20px 30px;\">");
		sb.append("											<div style=\"margin: 0px; line-height: 1.5; font-family:malgun-gothic, sans-serif; font-size: 11px; color: #707070; text-align: left; \">");
		sb.append("												본 메일은 결제서비스 제공사인 <strong>INNOPAY</strong>에서 자동 발송되는 것이며, 서비스 내용 확인 외의 어떠한 용도로도 사용되어질 수 없습니다.");
		sb.append("											</div>");
		sb.append("										</td>");
		sb.append("									</tr>");
		sb.append("									<tr>");
		sb.append("										<td width=\"600\" style=\"padding: 20px 30px; border-top: 1px solid #e8e8e8\" >");
		sb.append("											<table width=\"540\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"padding:0; margin: 0;border-spacing: 0;border-collapse: collapse;vertical-align: top;\">");
		sb.append("												<tr>");
		sb.append("													<td colrow=\"4\" width=\"118\" valign=\"top\">");
		sb.append("														<div style=\"padding:0; margin: 0 auto; text-align: center;width: 118px;height: 36px;\">");
		sb.append("															<a href=\"http://web.innopay.co.kr/\" target=\"_blank\" title=\"INNOPAY 홈페이지 이동\" style=\"width: 118px;height: 36px;padding:0; margin: 0; text-align: center;display: inline-block\">");
		sb.append("																<img src=\"https://admin.innopay.co.kr/mer/img/mail_logo_footer.png\" alt=\"innopay\" width=\"118\" height=\"36\" border=\"0\" align=\"center\" style=\"display: block; margin: 0 auto; text-align: center\">");
		sb.append("																<!-- 개발후 이미지 Url변경 필요 -->");
		sb.append("															</a>");
		sb.append("														</div>");
		sb.append("													</td>");
		sb.append("													<td style=\"padding-left: 24px;\">");
		sb.append("														<div style=\"padding:0; margin: 0; line-height: 1.4; font-family:malgun-gothic, sans-serif; font-size: 11px; text-align: left; color: #999999;\">");
		sb.append("															<span style=\"font-family:malgun-gothic, sans-serif;\">085-88 서울시 금천구 가산디지털2로 53 804(가산동, 한라시그마밸리)</span>");
		sb.append("														</div>");
		sb.append("													");
		sb.append("														<div style=\"padding:0; margin: 0; line-height: 1.4; font-family:malgun-gothic, sans-serif; font-size: 11px; text-align: left; color: #999999; \">");
		sb.append("															<span style=\"font-family:malgun-gothic, sans-serif;padding-right: 10px;\">사업자등록번호&nbsp;:&nbsp;119-86-46658</span><span>대표&nbsp;:&nbsp;황인철</span>");
		sb.append("														</div>");
		sb.append("													");
		sb.append("														<div style=\"padding:0; margin: 0; line-height: 1.4; font-family:malgun-gothic, sans-serif; font-size: 11px; color: #999999; \">");
		sb.append("															<span style=\"font-family:malgun-gothic, sans-serif;padding:0; margin: 0;padding-right: 10px;\">T&nbsp;:&nbsp;1688&nbsp;1250&nbsp;</span>");
		sb.append("															<span style=\"font-family:malgun-gothic, sans-serif;padding:0; margin: 0;padding-right: 10px;\">F&nbsp;:&nbsp;02&nbsp;6443&nbsp;4489</span>");
		sb.append("															<span style=\"font-family:malgun-gothic, sans-serif;padding:0; margin: 0;\">e-mail&nbsp;:&nbsp;<a href=\"mailto:sales@infinisoft.co.kr\" title=\"메일 보내기\" style=\"font-family:malgun-gothic, sans-serif;color: #999999;\">sales@infinisoft.co.kr</a></span>");
		sb.append("														</div>");
		sb.append("														<div style=\"padding:0; margin: 0; line-height: 1.4; font-family:malgun-gothic, sans-serif; font-size: 11px; text-align: left; color: #999999; \">");
		sb.append("															<span style=\"font-family:malgun-gothic, sans-serif;\">Copyright © 2017 INFINISOFT. Co. Ltd. All rights reserved.</span> ");
		sb.append("														</div>");
		sb.append("													</td>");
		sb.append("												</tr>");
		sb.append("											</table>");
		sb.append("										</td>			");
		sb.append("									</tr>");
		sb.append("								</table>");
		sb.append("							</td>");
		sb.append("						</tr>");
		sb.append("					</table>");
		sb.append("					<!-- //contents -->");
		sb.append("			</td>");
		sb.append("		</tr>");
		sb.append("	</table>");
		sb.append("</div>");
		sb.append("</body>");
		sb.append("</html>");
		
		return sb;
		
	}
	
	//영업팀 발송 메일
	public StringBuffer getTemplate02(DataModel map){

		StringBuffer used_sb = new StringBuffer();
		used_sb.append("<td style=\"margin: 0;padding: 0;text-align: left;\">");
		used_sb.append("<span style=\"width: 40px;height: 20px\">");
		used_sb.append("<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
		used_sb.append("</span>");
		used_sb.append("</td>");
		used_sb.append("<td width=\"138\" style=\"width:138px;margin: 0;padding: 0;text-align: left; color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		
		StringBuffer notused_sb = new StringBuffer();
		notused_sb.append("<td style=\"margin: 0;padding: 0;text-align: left;\">");
		notused_sb.append("<span style=\"width: 60px;height: 20px;\">");
		notused_sb.append("<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
		notused_sb.append("</span>");
		notused_sb.append("</td>");
		notused_sb.append("<td width=\"118\" style=\"width:118px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"ko\" xml:lang=\"ko\">");
		sb.append("<head>");
		sb.append("<meta name=\"viewport\" content=\"width=device-width\" />");
		sb.append("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\" />");
		sb.append("<meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\" />");
		sb.append("<meta name=\"format-detection\" content=\"telephone=no\" />");
		sb.append("<style type=\"text/css\">");
		sb.append("a:link {text-decoration: none; color: #666;}");
		sb.append("a:visited {text-decoration: none; color: #666;}");
		sb.append("a:active {text-decoration: none; color: #666;}");
		sb.append("a:hover {text-decoration: none; color: #666; opacity: 0.7;}");
		sb.append("</style>");
		sb.append("</head>");
		sb.append("<body width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" border=\"0\" style=\"letter-spacing: -0.5px;margin:0;padding:0;-webkit-text-size-adjust: 100%;\">");
		sb.append("<div style=\"letter-spacing: -0.5px;width: 600px; margin: 0px auto;\">");
		sb.append("	<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  align=\"center\" bgcolor=\"ffffff\"  style=\"letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;border: 1px solid #eee;\" >");
		sb.append("		<!-- center -->");
		sb.append("		<tr>");
		sb.append("			<td style=\"letter-spacing: -0.5px;padding:0; margin:0;\">");
		sb.append("					<!-- contents -->");
		sb.append("					<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("						<tr>");
		sb.append("							<td>");
		sb.append("								<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									<tr>");
		sb.append("										<td height=\"12\" bgcolor=\"ffffff\"></td>");
		sb.append("									</tr>");
		sb.append("									<tr>");
		sb.append("										<td style=\"letter-spacing: -0.5px;padding-left:30px;text-align: left;\">");
		sb.append("											<span style=\"width: 187px;height: 26px;\">");
		sb.append("												<img src=\"https://admin.innopay.co.kr/mer/img/innopay_logo3.png\" width=\"174\" height=\"26\" alt=\"이노페이 전자결제서비스\" border=\"0\">");
		sb.append("											</span>");
		sb.append("										</td>");
		sb.append("										<td style=\"letter-spacing: -0.5px;padding-right:30px;text-align: right; font-size: 14px; font-weight: normal; color:#1e5dd2;font-family:malgun-gothic, sans-serif;\">");
		sb.append("											보증증권 갱신 안내");
		sb.append("										</td>");
		sb.append("									</tr>");
		sb.append("									<tr>");
		sb.append("										<td height=\"12\" bgcolor=\"ffffff\"></td>");
		sb.append("									</tr>");
		sb.append("								</table>");
		sb.append("							</td>");
		sb.append("						</tr>");
		sb.append("						<tr>");
		sb.append("							<td>");
		sb.append("								<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.4px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									<tr>");
		sb.append("										<td width=\"600\" style=\"letter-spacing: -1px;background-color: #1a54c1; color:#dfe4f3; font-weight: bold;font-size: 20px;line-height: 30px;padding:40px 30px;font-family:malgun-gothic, sans-serif;\">");
		sb.append("											<span style=\"color:#ffaf3c;font-family:malgun-gothic, sans-serif;\">"+map.getStrNull("co_nm")+"</span><br><span style=\"font-weight: normal;font-size: 16px;line-height: 30px;font-family:malgun-gothic, sans-serif;\"> 가맹점이 사용중인 서비스의</span> 보증증권 갱신<span style=\"font-weight: normal;font-size: 16px;line-height: 30px;font-family:malgun-gothic, sans-serif;\">을 요청했습니다.</span>");
		sb.append("											<div style=\"font-weight: normal;font-size: 14px;line-height: 30px;font-family:malgun-gothic, sans-serif;padding-top: 10px;color: #fff\">전화 : "+map.getStrNull("tel_no")+" &nbsp 메일 : <a href=\"mailto:"+map.getStrNull("email")+"\" title=\"메일 보내기\" style=\"font-family:malgun-gothic, sans-serif;color: #fff;\">"+map.getStrNull("email")+"</a></div>");
		sb.append("										</td>");
		sb.append("									</tr>");
		sb.append("								</table>");
		sb.append("							</td>");
		sb.append("						</tr>");
		sb.append("						<tr>");
		sb.append("							<td>");
		sb.append("								<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									<tr>");
		sb.append("										<td style=\"letter-spacing: -0.5px;padding:40px 30px;background: #fff\">");
		sb.append("											<table width=\"524\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("												<tr>");
		sb.append("													<td style=\"letter-spacing: -0.5px;padding: 30px;background: #fff;border: 8px solid #eee;\">");
		sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;border-bottom: 1px solid #eee;\">");
		sb.append("															<tr>");
		sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 15px;line-height: 24px;font-family:malgun-gothic, sans-serif; padding-bottom: 16px;\">");
		sb.append("																	만료일");
		sb.append("																</td>");
		sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#ff7800; font-weight: bold;font-size: 20px;line-height: 24px;font-family:malgun-gothic, sans-serif;padding-bottom: 16px;vertical-align: middle;\">");
		sb.append("																	"+DateUtil.formatDate(map.getStrNull("to_dt")));
		sb.append("																</td>");
		sb.append("															</tr>");
		sb.append("														</table>");
		sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("															<tr>");
		sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 13px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;padding-top: 16px;\">");
		sb.append("																	보증보험증권 가입금액");
		sb.append("																</td>");
		sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;vertical-align: middle;padding-top: 16px;\">");
		sb.append("																	"+StringUtil.formatNumber(map.getStrNull("insurance_amt"))+"<span style=\"font-size: 14px;padding-left: 2px;\">원</span>");
		sb.append("																</td>");
		sb.append("															</tr>");
		sb.append("														</table>");
		
		//승인한도
		if(map.getStrNull("limit_cl").equals("01")){
			sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
			sb.append("															<tr>");
			sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 13px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;\">");
			sb.append("																	이노페이PG 승인한도");
			sb.append("																</td>");
			sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;vertical-align: middle;\">");
			sb.append("																	"+StringUtil.formatNumber(map.getStrNull("limit_amt"))+"<span style=\"font-size: 14px;padding-left: 2px;\">원</span>");
			sb.append("																</td>");
			sb.append("															</tr>");
			sb.append("														</table>");
		}
		
		//정산한도
		if(map.getStrNull("limit_cl").equals("02")){
			sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
			sb.append("															<tr>");
			sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 13px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;\">");
			sb.append("																	이노페이PG 정산한도");
			sb.append("																</td>");
			sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;vertical-align: middle;\">");
			sb.append("																	"+StringUtil.formatNumber(map.getStrNull("limit_amt"))+"<span style=\"font-size: 14px;padding-left: 2px;\">원</span>");
			sb.append("																</td>");
			sb.append("															</tr>");
			sb.append("														</table>");
		}
		
		sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("															<tr>");
		sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 13px;line-height: 20px;font-family:malgun-gothic, sans-serif;\">");
		sb.append("																	보증보험증권 유효기간");
		sb.append("																</td>");
		sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 20px;font-family:malgun-gothic, sans-serif;vertical-align: middle;\">");
		sb.append("																	"+DateUtil.formatDate(map.getStrNull("fr_dt"))+" ~ "+DateUtil.formatDate(map.getStrNull("to_dt")));
		sb.append("																</td>");
		sb.append("															</tr>");
		sb.append("														</table>	");
		sb.append("													</td>");
		sb.append("												</tr>");
		sb.append("											</table>");
		sb.append("											<table width=\"540\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\" margin: 0;padding: 0;border-spacing: 0; border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									        	<tbody>");
		sb.append("									          		<tr>");
		sb.append("														<td colspan=\"2\" height=\"15\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 15px;padding-top: 40px; padding-bottom:8px; font-family:malgun-gothic, sans-serif;\">");
		sb.append("														결제서비스 사용 현황");
		sb.append("														</td>");
		sb.append("													</tr>");
		sb.append("													<tr>");
		sb.append("														<td colspan=\"2\" style=\"letter-spacing: -0.5px;color:#709ce6; font-weight: bold;font-size: 12px;line-height: 18px;padding-bottom:20px;padding-top:0px; font-family:malgun-gothic, sans-serif;\">");
		//sb.append("														미가입 서비스를 클릭하시면 서비스 정보를 확인할 수 있습니다.<br>서비스 가입은 고객센터로 문의 해주시기 바랍니다.");
		sb.append("															서비스 가입은 고객센터로 문의 해주시기 바랍니다.");
		sb.append("														</td>");
		sb.append("													</tr>");
		sb.append("													<tr>");
		sb.append("														<td colspan=\"2\" height=\"15\" width=\"540\" style=\"letter-spacing: -0.5px;color:#666; font-weight: bold;font-size: 13px;line-height: 15px;padding:6px;font-family:malgun-gothic, sans-serif;text-align: center;background-color: #f4f4f4;vertical-align: middle;height: 15px;\">");
		sb.append("														신용카드 결제 서비스");
		sb.append("														</td>");
		sb.append("													</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;border-right: 1px solid #efefed\">");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon1.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("card_keyin_yn").equals("y")){ sb.append(used_sb.toString()); }else{ sb.append(notused_sb.toString()); }
		
		sb.append("											              								상담원 수기결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">상담원이 고객의 카드정보를 불러 받아 수기로 카드정보를 입력하여 결제하는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;\" >");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\" >");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon2.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("card_ars_yn").equals("y")){ sb.append(used_sb.toString()); }else{ sb.append(notused_sb.toString()); }
		
		sb.append("											              								ARS 안심결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">고객에게 가상ARS를 발송하여 고객이 전화 연결하여 결제하는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;border-right: 1px solid #efefed;border-top: 1px solid #efefed\">");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("																			<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon3.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("sms_keyin_yn").equals("y")){ sb.append(used_sb.toString()); }else{ sb.append(notused_sb.toString()); }
		
		sb.append("											              								SMS 수기결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">고객에게 결제링크(URL)를 발송하고 고객이 접속하여 카드정보를 직접 입력하여 결제하는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;border-top: 1px solid #efefed\" >");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\" >");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon3.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("sms_auth_yn").equals("y")){ sb.append(used_sb.toString()); }else{ sb.append(notused_sb.toString()); }
		
		sb.append("											              								SMS 인증결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">고객에게 결제링크(URL)를 발송하고 고객이 접속하여 본인인증 후 결제하는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td colspan=\"2\" style=\"padding: 20px 16px 20px 16px;border-top: 1px solid #efefed\">");
		sb.append("									           				<table width=\"508\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon4.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"458\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("card_auth_yn").equals("y")){
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 40px;height: 20px\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"410\" style=\"width:410px;margin: 0;padding: 0;text-align: left;color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}else{
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 60px;height: 20px\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"390\" style=\"width:390px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}

		sb.append("											              								ISP / 안심클릭 인증결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">온라인 쇼핑몰 등에서 신용카드 결제 시 카드사별 본인인증 후<br>결제를 진행하는 온라인 표준 결제서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									          		<tr>");
		sb.append("														<td colspan=\"2\" height=\"15\" width=\"540\" style=\"letter-spacing: -0.5px;color:#666; font-weight: bold;font-size: 13px;line-height: 15px;padding:6px;font-family:malgun-gothic, sans-serif;text-align: center;background-color: #f4f4f4;vertical-align: middle;height: 15px;\">");
		sb.append("														기타 서비스");
		sb.append("														</td>");
		sb.append("													</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;border-right: 1px solid #efefed\">");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon5.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("accnt_yn").equals("y")){
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 40px;height: 20px\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"138\" style=\"width:138px;margin: 0;padding: 0;text-align: left;color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}else{
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 60px;height: 20px\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"118\" style=\"width:118px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}
		
		sb.append("											              								계좌이체 서비스");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">구매자가 입력한 은행 계좌(통장)에서 상품대금을 실시간으로 출금하는 결제 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;\" >");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\" >");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon6.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("vbank_yn").equals("y")){
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 40px;height: 20px;\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"138\" style=\"width:138px;margin: 0;padding: 0;text-align: left;color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}else{
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 60px;height: 20px;\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"118\" style=\"width:118px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}
		
		sb.append("											              								가상계좌 서비스");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">1회용 가상계좌번호를 발급 받아 해당 계좌로 입금 시 실시간으로 입금확인 및 수납처리 되는 결제 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td colspan=\"2\" style=\"padding: 20px 16px 20px 16px;border-top: 1px solid #efefed;border-bottom: 1px solid #efefed\" >");
		sb.append("									           				<table width=\"508\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon7.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"458\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");
		
		if(map.getStrNull("recpt_yn").equals("y")){
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 40px;height: 20px;\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"410\" style=\"width:410px;margin: 0;padding: 0;text-align: left;color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}else{
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 60px;height: 20px;\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"390\" style=\"width:390px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}

		sb.append("											              								현금 영수증");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">고객이 현금으로 결제시 현금영수증 발급장치로 현금 영수증을 발급하고<br>결제내역은 국세청에 통보 되는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									         	</tbody>");
		sb.append("									        </table>");
		sb.append("										</td>");
		sb.append("									</tr>");
		sb.append("								</table>");
		sb.append("							</td>");
		sb.append("						</tr>");
		sb.append("						<!-- //footer -->");
		sb.append("						<tr>");
		sb.append("							<td>");
		sb.append("								<table  width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"letter-spacing: -0.4px;border-spacing: 0;border-collapse: collapse;margin-top: 20px;\">");
		sb.append("									<tr>");
		sb.append("										<td width=\"300\" style=\"text-align: center;vertical-align: middle;height: 60px;\">");
		sb.append("											<a href=\"mailto:"+map.getStrNull("email")+"\" style=\"display: inline-block;width: 300px;height: 60px;\">");
		sb.append("												<img src=\"https://admin.innopay.co.kr/mer/img/btn_mail.png\" alt=\"메일 보내기\" width=\"300\" height=\"60\">");
		sb.append("											</a>");
		sb.append("										</td>");
		sb.append("										<td width=\"300\" style=\"text-align: center;background-color: #1a54c1;vertical-align: middle;height: 56px;\">");
		sb.append("											<td width=\"300\" style=\"text-align: center;vertical-align: middle;height: 60px;\">");
		sb.append("											<a href=\"tel:"+map.getStrNull("tel_no")+"\" style=\"display: inline-block;width: 300px;height: 60px;\">");
		sb.append("												<img src=\"https://admin.innopay.co.kr/mer/img/btn_call.png\" alt=\"전화 걸기\" width=\"300\" height=\"60\">");
		sb.append("											</a>");
		sb.append("										</td>");
		sb.append("										</td>");
		sb.append("									</tr>");
		sb.append("								</table>");
		sb.append("							</td>");
		sb.append("						</tr>");
		sb.append("					</table>");
		sb.append("					<!-- //contents -->");
		sb.append("			</td>");
		sb.append("		</tr>");
		sb.append("	</table>");
		sb.append("</div>");
		sb.append("</body>");
		sb.append("</html>");
		
		return sb;
		
	}
	
	//영업팀 발송 메일
	public StringBuffer getTemplate03(DataModel map){

		StringBuffer used_sb = new StringBuffer();
		used_sb.append("<td style=\"margin: 0;padding: 0;text-align: left;\">");
		used_sb.append("<span style=\"width: 40px;height: 20px\">");
		used_sb.append("<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
		used_sb.append("</span>");
		used_sb.append("</td>");
		used_sb.append("<td width=\"138\" style=\"width:138px;margin: 0;padding: 0;text-align: left; color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		
		StringBuffer notused_sb = new StringBuffer();
		notused_sb.append("<td style=\"margin: 0;padding: 0;text-align: left;\">");
		notused_sb.append("<span style=\"width: 60px;height: 20px;\">");
		notused_sb.append("<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
		notused_sb.append("</span>");
		notused_sb.append("</td>");
		notused_sb.append("<td width=\"118\" style=\"width:118px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"ko\" xml:lang=\"ko\">");
		sb.append("<head>");
		sb.append("<meta name=\"viewport\" content=\"width=device-width\" />");
		sb.append("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\" />");
		sb.append("<meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\" />");
		sb.append("<meta name=\"format-detection\" content=\"telephone=no\" />");
		sb.append("<style type=\"text/css\">");
		sb.append("a:link {text-decoration: none; color: #666;}");
		sb.append("a:visited {text-decoration: none; color: #666;}");
		sb.append("a:active {text-decoration: none; color: #666;}");
		sb.append("a:hover {text-decoration: none; color: #666; opacity: 0.7;}");
		sb.append("</style>");
		sb.append("</head>");
		sb.append("<body width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" border=\"0\" style=\"letter-spacing: -0.5px;margin:0;padding:0;-webkit-text-size-adjust: 100%;\">");
		sb.append("<div style=\"letter-spacing: -0.5px;width: 600px; margin: 0px auto;\">");
		sb.append("	<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  align=\"center\" bgcolor=\"ffffff\"  style=\"letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;border: 1px solid #eee;\" >");
		sb.append("		<!-- center -->");
		sb.append("		<tr>");
		sb.append("			<td style=\"letter-spacing: -0.5px;padding:0; margin:0;\">");
		sb.append("					<!-- contents -->");
		sb.append("					<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("						<tr>");
		sb.append("							<td>");
		sb.append("								<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									<tr>");
		sb.append("										<td height=\"12\" bgcolor=\"ffffff\"></td>");
		sb.append("									</tr>");
		sb.append("									<tr>");
		sb.append("										<td style=\"letter-spacing: -0.5px;padding-left:30px;text-align: left;\">");
		sb.append("											<span style=\"width: 187px;height: 26px;\">");
		sb.append("												<img src=\"https://admin.innopay.co.kr/mer/img/innopay_logo3.png\" width=\"174\" height=\"26\" alt=\"이노페이 전자결제서비스\" border=\"0\">");
		sb.append("											</span>");
		sb.append("										</td>");
		sb.append("										<td style=\"letter-spacing: -0.5px;padding-right:30px;text-align: right; font-size: 14px; font-weight: normal; color:#1e5dd2;font-family:malgun-gothic, sans-serif;\">");
		sb.append("											보증증권 갱신 안내");
		sb.append("										</td>");
		sb.append("									</tr>");
		sb.append("									<tr>");
		sb.append("										<td height=\"12\" bgcolor=\"ffffff\"></td>");
		sb.append("									</tr>");
		sb.append("								</table>");
		sb.append("							</td>");
		sb.append("						</tr>");
		sb.append("						<tr>");
		sb.append("							<td>");
		sb.append("								<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.4px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									<tr>");
		sb.append("										<td width=\"600\" style=\"letter-spacing: -1px;background-color: #1a54c1; color:#dfe4f3; font-weight: bold;font-size: 20px;line-height: 30px;padding:40px 30px;font-family:malgun-gothic, sans-serif;\">");
		sb.append("											<span style=\"color:#ffaf3c;font-family:malgun-gothic, sans-serif;\">"+map.getStrNull("co_nm")+"</span><br><span style=\"font-weight: normal;font-size: 16px;line-height: 30px;font-family:malgun-gothic, sans-serif;\"> 가맹점이 사용중인 서비스의</span> 보증증권 갱신<span style=\"font-weight: normal;font-size: 16px;line-height: 30px;font-family:malgun-gothic, sans-serif;\">을 요청했습니다.</span>");
		sb.append("											<div style=\"font-weight: normal;font-size: 14px;line-height: 30px;font-family:malgun-gothic, sans-serif;padding-top: 10px;color: #fff\">MID : "+map.getStrNull("mid")+" &nbsp 아이디 : "+map.getStrNull("user_id")+"</div>");
		sb.append("										</td>");
		sb.append("									</tr>");
		sb.append("								</table>");
		sb.append("							</td>");
		sb.append("						</tr>");
		sb.append("						<tr>");
		sb.append("							<td>");
		sb.append("								<table width=\"600\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									<tr>");
		sb.append("										<td style=\"letter-spacing: -0.5px;padding:40px 30px;background: #fff\">");
		sb.append("											<table width=\"524\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("												<tr>");
		sb.append("													<td style=\"letter-spacing: -0.5px;padding: 30px;background: #fff;border: 8px solid #eee;\">");
		sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;border-bottom: 1px solid #eee;\">");
		sb.append("															<tr>");
		sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 15px;line-height: 24px;font-family:malgun-gothic, sans-serif; padding-bottom: 16px;\">");
		sb.append("																	만료일");
		sb.append("																</td>");
		sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#ff7800; font-weight: bold;font-size: 20px;line-height: 24px;font-family:malgun-gothic, sans-serif;padding-bottom: 16px;vertical-align: middle;\">");
		sb.append("																	"+DateUtil.formatDate(map.getStrNull("to_dt")));
		sb.append("																</td>");
		sb.append("															</tr>");
		sb.append("														</table>");
		sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("															<tr>");
		sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 13px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;padding-top: 16px;\">");
		sb.append("																	보증보험증권 가입금액");
		sb.append("																</td>");
		sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;vertical-align: middle;padding-top: 16px;\">");
		sb.append("																	"+StringUtil.formatNumber(map.getStrNull("insurance_amt"))+"<span style=\"font-size: 14px;padding-left: 2px;\">원</span>");
		sb.append("																</td>");
		sb.append("															</tr>");
		sb.append("														</table>");
		
		//승인한도
		if(map.getStrNull("limit_cl").equals("01")){
			sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
			sb.append("															<tr>");
			sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 13px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;\">");
			sb.append("																	이노페이PG 승인한도");
			sb.append("																</td>");
			sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;vertical-align: middle;\">");
			sb.append("																	"+StringUtil.formatNumber(map.getStrNull("limit_amt"))+"<span style=\"font-size: 14px;padding-left: 2px;\">원</span>");
			sb.append("																</td>");
			sb.append("															</tr>");
			sb.append("														</table>");
		}
		
		//정산한도
		if(map.getStrNull("limit_cl").equals("02")){
			sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
			sb.append("															<tr>");
			sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 13px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;\">");
			sb.append("																	이노페이PG 정산한도");
			sb.append("																</td>");
			sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 20px;font-family:malgun-gothic, sans-serif;padding-bottom: 4px;vertical-align: middle;\">");
			sb.append("																	"+StringUtil.formatNumber(map.getStrNull("limit_amt"))+"<span style=\"font-size: 14px;padding-left: 2px;\">원</span>");
			sb.append("																</td>");
			sb.append("															</tr>");
			sb.append("														</table>");
		}
		
		sb.append("														<table width=\"464\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;letter-spacing: -0.5px;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("															<tr>");
		sb.append("																<td width=\"150\" style=\"letter-spacing: -0.5px;color:#666; font-weight: normal;font-size: 13px;line-height: 20px;font-family:malgun-gothic, sans-serif;\">");
		sb.append("																	보증보험증권 유효기간");
		sb.append("																</td>");
		sb.append("																<td  width=\"314\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 20px;font-family:malgun-gothic, sans-serif;vertical-align: middle;\">");
		sb.append("																	"+DateUtil.formatDate(map.getStrNull("fr_dt"))+" ~ "+DateUtil.formatDate(map.getStrNull("to_dt")));
		sb.append("																</td>");
		sb.append("															</tr>");
		sb.append("														</table>	");
		sb.append("													</td>");
		sb.append("												</tr>");
		sb.append("											</table>");
		sb.append("											<table width=\"540\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\" margin: 0;padding: 0;border-spacing: 0; border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									        	<tbody>");
		sb.append("									          		<tr>");
		sb.append("														<td colspan=\"2\" height=\"15\" style=\"letter-spacing: -0.5px;color:#222; font-weight: bold;font-size: 15px;line-height: 15px;padding-top: 40px; padding-bottom:8px; font-family:malgun-gothic, sans-serif;\">");
		sb.append("														결제서비스 사용 현황");
		sb.append("														</td>");
		sb.append("													</tr>");
		sb.append("													<tr>");
		sb.append("														<td colspan=\"2\" style=\"letter-spacing: -0.5px;color:#709ce6; font-weight: bold;font-size: 12px;line-height: 18px;padding-bottom:20px;padding-top:0px; font-family:malgun-gothic, sans-serif;\">");
		//sb.append("														미가입 서비스를 클릭하시면 서비스 정보를 확인할 수 있습니다.<br>서비스 가입은 고객센터로 문의 해주시기 바랍니다.");
		sb.append("															서비스 가입은 고객센터로 문의 해주시기 바랍니다.");
		sb.append("														</td>");
		sb.append("													</tr>");
		sb.append("													<tr>");
		sb.append("														<td colspan=\"2\" height=\"15\" width=\"540\" style=\"letter-spacing: -0.5px;color:#666; font-weight: bold;font-size: 13px;line-height: 15px;padding:6px;font-family:malgun-gothic, sans-serif;text-align: center;background-color: #f4f4f4;vertical-align: middle;height: 15px;\">");
		sb.append("														신용카드 결제 서비스");
		sb.append("														</td>");
		sb.append("													</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;border-right: 1px solid #efefed\">");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon1.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("card_keyin_yn").equals("y")){ sb.append(used_sb.toString()); }else{ sb.append(notused_sb.toString()); }
		
		sb.append("											              								상담원 수기결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">상담원이 고객의 카드정보를 불러 받아 수기로 카드정보를 입력하여 결제하는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;\" >");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\" >");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon2.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("card_ars_yn").equals("y")){ sb.append(used_sb.toString()); }else{ sb.append(notused_sb.toString()); }
		
		sb.append("											              								ARS 안심결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">고객에게 가상ARS를 발송하여 고객이 전화 연결하여 결제하는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;border-right: 1px solid #efefed;border-top: 1px solid #efefed\">");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("																			<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon3.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("sms_keyin_yn").equals("y")){ sb.append(used_sb.toString()); }else{ sb.append(notused_sb.toString()); }
		
		sb.append("											              								SMS 수기결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">고객에게 결제링크(URL)를 발송하고 고객이 접속하여 카드정보를 직접 입력하여 결제하는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;border-top: 1px solid #efefed\" >");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\" >");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon3.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("sms_auth_yn").equals("y")){ sb.append(used_sb.toString()); }else{ sb.append(notused_sb.toString()); }
		
		sb.append("											              								SMS 인증결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">고객에게 결제링크(URL)를 발송하고 고객이 접속하여 본인인증 후 결제하는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td colspan=\"2\" style=\"padding: 20px 16px 20px 16px;border-top: 1px solid #efefed\">");
		sb.append("									           				<table width=\"508\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon4.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"458\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("card_auth_yn").equals("y")){
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 40px;height: 20px\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"410\" style=\"width:410px;margin: 0;padding: 0;text-align: left;color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}else{
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 60px;height: 20px\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"390\" style=\"width:390px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}

		sb.append("											              								ISP / 안심클릭 인증결제");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">온라인 쇼핑몰 등에서 신용카드 결제 시 카드사별 본인인증 후<br>결제를 진행하는 온라인 표준 결제서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									          		<tr>");
		sb.append("														<td colspan=\"2\" height=\"15\" width=\"540\" style=\"letter-spacing: -0.5px;color:#666; font-weight: bold;font-size: 13px;line-height: 15px;padding:6px;font-family:malgun-gothic, sans-serif;text-align: center;background-color: #f4f4f4;vertical-align: middle;height: 15px;\">");
		sb.append("														기타 서비스");
		sb.append("														</td>");
		sb.append("													</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;border-right: 1px solid #efefed\">");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon5.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("accnt_yn").equals("y")){
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 40px;height: 20px\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"138\" style=\"width:138px;margin: 0;padding: 0;text-align: left;color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}else{
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 60px;height: 20px\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"118\" style=\"width:118px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}
		
		sb.append("											              								계좌이체 서비스");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">구매자가 입력한 은행 계좌(통장)에서 상품대금을 실시간으로 출금하는 결제 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									           			<td width=\"270\" style=\"padding: 20px 16px 20px 16px;\" >");
		sb.append("									           				<table width=\"237\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\" >");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon6.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"187\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");

		if(map.getStrNull("vbank_yn").equals("y")){
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 40px;height: 20px;\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"138\" style=\"width:138px;margin: 0;padding: 0;text-align: left;color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}else{
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 60px;height: 20px;\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"118\" style=\"width:118px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}
		
		sb.append("											              								가상계좌 서비스");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">1회용 가상계좌번호를 발급 받아 해당 계좌로 입금 시 실시간으로 입금확인 및 수납처리 되는 결제 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									          		<tr>");
		sb.append("									           			<td colspan=\"2\" style=\"padding: 20px 16px 20px 16px;border-top: 1px solid #efefed;border-bottom: 1px solid #efefed\" >");
		sb.append("									           				<table width=\"508\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("									           					<tbody>");
		sb.append("									             					<tr>");
		sb.append("									              						<td width=\"50\" style=\"margin: 0;padding: 0;vertical-align: top;text-align: left;\">");
		sb.append("									              							<span style=\"width: 36px;height: 36px;\">");
		sb.append("									              								<img src=\"https://admin.innopay.co.kr/mer/img/email_icon7.png\" width=\"36\" height=\"36\" border=\"0\">");
		sb.append("									              							</span>");
		sb.append("									              						</td>");
		sb.append("									              						<td style=\"vertical-align: top;\">");
		sb.append("										              						<table width=\"458\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"  style=\"text-align: left;margin: 0;padding: 0;border-spacing: 0;border-collapse: collapse;\">");
		sb.append("										              							<tr>");
		
		if(map.getStrNull("recpt_yn").equals("y")){
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 40px;height: 20px;\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_used.png\" width=\"40\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"410\" style=\"width:410px;margin: 0;padding: 0;text-align: left;color: #222;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}else{
			sb.append("										              								<td style=\"margin: 0;padding: 0;text-align: left;\">");
			sb.append("											              								<span style=\"width: 60px;height: 20px;\">");
			sb.append("											              									<img src=\"https://admin.innopay.co.kr/mer/img/tag_notused.png\" width=\"60\" height=\"20\" border=\"0\">");
			sb.append("											              								</span>");
			sb.append("											              							</td>");
			sb.append("											              							<td width=\"390\" style=\"width:390px;margin: 0;padding: 0;text-align: left;color: #888;font-family:malgun-gothic, sans-serif;font-size: 13px;line-height: 15px;font-weight: bold;letter-spacing: -0.5px;\">");
		}

		sb.append("											              								현금 영수증");
		sb.append("											              							</td>	");
		sb.append("											              						</tr>");
		sb.append("																				<tr>");
		sb.append("											              							<td colspan=\"2\" style=\"margin: 0;padding: 0;color: #888;word-break: keep-all;padding-top: 6px;font-family:malgun-gothic, sans-serif;font-size: 11px; line-height: 1.4;letter-spacing: -0.5px;\">고객이 현금으로 결제시 현금영수증 발급장치로 현금 영수증을 발급하고<br>결제내역은 국세청에 통보 되는 서비스</td>");
		sb.append("											              						</tr>");
		sb.append("										              						</table>");
		sb.append("									              						</td>");
		sb.append("									             					</tr>");
		sb.append("									            				</tbody>");
		sb.append("									           				</table>");
		sb.append("									           			</td>");
		sb.append("									          		</tr>");
		sb.append("									         	</tbody>");
		sb.append("									        </table>");
		sb.append("										</td>");
		sb.append("									</tr>");
		sb.append("								</table>");
		sb.append("							</td>");
		sb.append("						</tr>");
		sb.append("					</table>");
		sb.append("					<!-- //contents -->");
		sb.append("			</td>");
		sb.append("		</tr>");
		sb.append("	</table>");
		sb.append("</div>");
		sb.append("</body>");
		sb.append("</html>");
		
		return sb;
		
	}
	
}
