package mobile;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.text.*;

import javax.servlet.http.HttpServletRequest;

/**
 * 1. class 명			: DataModel.java <br>
 * 2. class 개요		: java.util.HashMap을 활용한 DataModel <br>
 * 3. 관련 테이블		: <br>
 * 4. 관련 class		: <br>
 * 5. 관련 JSP			: <br>
 * 6. 작성자/작성일자	: 김택규/2009.01.19<br>
 * 7. 수정자/수정일자	: <br>
 * 8. 변경내역			: <br>
 */
public class DataModel extends HashMap<Object,Object> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1760170910872537431L;

	public DataModel(){
		super();
	}

	@SuppressWarnings("rawtypes")
	public DataModel(Map map){
		super();

		Iterator it = map.keySet().iterator();
		while(it.hasNext()){
			String key = it.next().toString();
			String[] v = (String[])map.get(key);
			this.put(key, v[0]);
		}
	}

	@SuppressWarnings("rawtypes")
	public DataModel(HttpServletRequest request){
		super();

		Enumeration em = request.getParameterNames();
		while(em.hasMoreElements())
		{
			String key = em.nextElement().toString();
			this.put(key, request.getParameter(key));
		}
	}

	/**
	 * get 방식의 경우 인코딩을 맞추어야 한다.
	 * @param map
	 * @param String	post, get 구분
	 */
	@SuppressWarnings("rawtypes")
	public DataModel(Map map, String methodType){
		super();

		Iterator it = map.keySet().iterator();
		while(it.hasNext()){
			String key = it.next().toString();
			String[] v = (String[])map.get(key);
			String pVal	= v[0];
			if("post".equals(methodType.toLowerCase())){
				//				try {
				//					pVal	= CharsetDetector.urlDecodeSafely(pVal);
				//				} catch (UnsupportedEncodingException e) {
				//					//log.debug(e.getMessage());
				//				}
			}
			this.put(key, pVal);
		}
	}

	/**
	 * 맵 데이터 세팅
	 * @param map
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void setData(Map map) {
		Iterator<String> it = map.keySet().iterator();
		while(it.hasNext()) {
			String key = it.next().toString();
			String v = String.valueOf(map.get(key));
			this.put(key, v);
		}
	}

	private final String DATE_DELIM = "/";
	private final String TIME_DELIM = ":";

	/**
	 * String 객체중 Null 객체를 ""로 바꿔서 데이터를 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param colValue 라벨값
	 */
	public void putStrNull(String colLabel, String colValue){
		colValue = (colValue != null) ? colValue.trim() : "";		

		super.put(colLabel, colValue);
	}
	
	/**
	 * null이 아닐 경우 trim 처리. null이면 null을 그대로 넣는다.
	 * @param colLabel
	 * @param colValue
	 */
	public void putStrTrim(String colLabel, String colValue) {
		colValue = (colValue != null) ? colValue.trim() : null;		

		super.put(colLabel, colValue);
	}

	/**
	 * SString객체중에서 데이터가 없는 Null객체를 &nbsp;로 바꿔서 데이터 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param colValue 라벨값
	 */
	public void putForHtml(String colLabel, String colValue){
		colValue = (colValue != null) ? colValue.trim() : "&nbsp;";
		super.put(colLabel, colValue);
	}

	/**
	 * int type의 숫자를 Integer Object type으로 바꿔서 데이터를 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param colValue 라벨값
	 */
	public void putNumber(String colLabel, int colValue){
		super.put(colLabel, new Integer(colValue));
	}

	/**
	 * long type의 숫자를 Long Object type으로 바꿔서 데이터를 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param colValue 라벨값
	 */
	public void putNumber(String colLabel, long colValue){
		super.put(colLabel, new Long(colValue));
	}

	/**
	 * float type의 숫자를 Float Object type으로 바꿔서 데이터를 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param colValue 라벨값
	 */
	public void putNumber(String colLabel, float colValue){
		super.put(colLabel, new Float(colValue));
	}

	/**
	 * double type의 숫자를 Double Object type으로 바꿔서 데이터를 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param colValue 라벨값
	 */
	public void putNumber(String colLabel, double colValue){
		super.put(colLabel, new Double(colValue));
	}

	/**
	 * int type의 숫자를 콤마를 넣어서 데이터를 String 형태로 바꿔서 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param colValue 라벨값
	 */
	public void putFormattedNumber(String colLabel, int colValue){
		super.put(colLabel, getNumberFormat(colValue));
	}

	/**
	 * long type의 숫자를 콤마를 넣어서 데이터를 String 형태로 바꿔서 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param colValue 라벨값
	 */
	public void putFormattedNumber(String colLabel, long colValue){
		super.put(colLabel, getNumberFormat(colValue));
	}

	/**
	 * float type의 숫자를 콤마를 넣어서 데이터를 String 형태로 바꿔서 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param colValue 라벨값
	 */
	public void putFormattedNumber(String colLabel, float colValue){
		super.put(colLabel, getNumberFormat(colValue));
	}

	/**
	 * double type의 숫자를 콤마를 넣어서 데이터를 String 형태로 바꿔서 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param colValue 라벨값
	 */
	public void putFormattedNumber(String colLabel, double colValue){
		super.put(colLabel, getNumberFormat(colValue));
	}

	/**
	 * Formatted String에서 숫자를 제외하고 데이터를 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param colValue 라벨값
	 */
	public void putUnFormatedNumber(String colLabel, String colValue){
		if(colValue.length() < 1) super.put(colLabel, null);
		else super.put(colLabel, colValue.replaceAll("[^0-9]", ""));
	}

	/**
	 * Formatted String에서 숫자와 부호(-)를 제외하고 데이터를 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param colValue 라벨값
	 */
	public void putUnFormatedSignedNumber(String colLabel, String colValue){
		if(colValue.length() < 1) super.put(colLabel, null);
		else {
			if("-".equals(colValue.substring(0,1))) {
				colValue = colValue.replaceAll("[^0-9]", "");
				colValue = "-" + colValue;
				super.put(colLabel, colValue);
			}
			else super.put(colLabel, colValue.replaceAll("[^0-9]", ""));
		}    	 
	}

	/**
	 * 숫자를 콤마를 넣어서 데이터를 String 형태로 바꿔서 저장한다.
	 *
	 * @param colLabel 라벨명
	 */
	public String getFormattedNumber(String colLabel){
		Object obj = super.get(colLabel);
		if(obj instanceof Integer)
			return getNumberFormat(((Integer)obj).intValue());
		else if(obj instanceof Long)
			return getNumberFormat(((Long)obj).longValue());
		else if(obj instanceof Float)
			return getNumberFormat(((Float)obj).floatValue());
		else if(obj instanceof Double)
			return getNumberFormat(((Double)obj).doubleValue());
		else
			return "&nbsp;";
	}

	/**
	 * 일자와 시간 필드에 있는 날짜와 시간을 조합해서 상세 시간 데이터를 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param date 날짜
	 * @param time 시간
	 */
	public void putDetailDateForHtml(String colLabel, String date, String time){
		String detailDate = getDetailDate(date, time);
		detailDate = (detailDate == null || (detailDate.trim()).equals("")) ? "&nbsp;" : detailDate.trim() ;
		super.put(colLabel, detailDate);
	}

	/**
	 * 일자를 화면에 뷰할 수 있도록 포맷을 맞춰서 데이터를 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param date 날짜
	 */
	public void putDate(String colLabel, String date){
		date = getYyyymmdd(date);
		date = (date != null) ? date.trim() : "&nbsp;";
		super.put(colLabel, date);
	}

	/**
	 * 시간을 화면에 뷰할 수 있도록 포맷을 맞춰서 데이터를 저장한다.
	 *
	 * @param colLabel 라벨명
	 * @param time 시간
	 */
	public void putTime(String colLabel, String time){
		time = getHhmmssType(time);
		time = (time != null) ? time.trim() : "&nbsp;";
		super.put(colLabel, time);
	}

	//==============================================================
	// Hashtable에서 get메쏘드를 호출시에 Object를 Return하던 것을 
	// String타입으로 Casting해서 값을 Return한다.
	// 값이 null or empty String인 경우는 "&nbsp;"를 반환한다.
	// Type이 String 계열이 아닌 경우는 해당 Obj의 toString()값을 
	// Return 한다.
	//==============================================================

	/**
	 * String타입으로 Casting해서 값을 Return한다 null ==>""
	 *
	 * @param key	Key값
	 * @return 변환된 값
	 */
	public String getStrNull(String key){
		Object obj = super.get(key);
		if(obj == null) return "";
		else if(obj instanceof String) {
			if("null".equals(obj)) return "";
			else return ((String)obj).toString();
		}
		else return obj.toString();
	}

	/**
	 * String타입으로 Casting해서 값을 Return한다 null ==> "&nbsp;"
	 *
	 * @param key	Key값
	 * @return 변환된 값
	 */
	public String getStr(String key){
		Object obj = super.get(key);
		if(obj == null) return "&nbsp;";
		else if(obj instanceof String){
			if("null".equals(obj) || obj.equals(""))
				return "&nbsp;";
			else
				return ((String)obj).toString();
		}
		else return obj.toString();
	}

	/**
	 * String타입으로 Casting해서 값을 Return한다 null ==> "&nbsp;"
	 *
	 * @param key	Key값
	 * @return	변환된 값
	 */
	public String getStrWithNbsp(String key){
		String str = getStr(key);

		if(str == null)
			return "&nbsp;";
		else
			return str;
	}

	/**
	 * 일자 데이터를 특정 포맷으로 바꾼다.
	 *
	 * @param dateKey	Key값
	 * @return 변환된 값
	 */
	public String getFormattedDate(String dateKey){
		String date = (String)super.get(dateKey);

		if(date == null) return " ";

		if(date.length() == 8) return getYyyymmdd(date); // yyyy/mm/dd 형태
		else if(date.length() == 6) return getYyyymm(date); // yyyy/mm 형태
		else if(date.length() == 1) return getWeek(date); // 요일형태
		else return date;
	}

	/**
	 * 시간 데이터를 특정 포맷으로 바꾼다.
	 * @param timeKey Key값
	 * @return 변환된 값
	 */
	public String getFormattedTime(String timeKey){
		return getHhmmssType((String)super.get(timeKey));
	}

	/**
	 * 일자에 대한 상세 데이터를 담는다.
	 *
	 * @param dateKey	Date값
	 * @param timeKey	Time값
	 * @return 변환된 값
	 */
	public String getFormattedDetailDate(String dateKey, String timeKey){
		return getDetailDate((String)super.get(dateKey), (String)super.get(dateKey));
	}

	/**
	 * numberKey에 해당하는 Data를 int로 바꾸어 리턴한다. 
	 *
	 * @param numberKey	numberKey값
	 * @return 변환된 값
	 */
	public int getIntNumber(String numberKey){
		Object obj = super.get(numberKey);

		if(obj == null || obj.equals("")){
			return 0;
		}else{
			return (Integer.parseInt(super.get(numberKey).toString()));
		}
	}

	/**
	 * numberKey에 해당하는 Data를 long로 바꾸어 리턴한다. 
	 *
	 * @param numberKey	numberKey값
	 * @return 변환된 값
	 */
	public long getLongNumber(String numberKey){
		Object obj = super.get(numberKey);

		if(obj == null){
			return 0L;
		}else{
			return (Long.parseLong(super.get(numberKey).toString()));
		}
	}

	/**
	 * numberKey에 해당하는 Data를 float로 바꾸어 리턴한다. 
	 *
	 * @param numberKey	numberKey값
	 * @return 변환된 값
	 */
	public float getFloatNumber(String numberKey){
		Object obj = super.get(numberKey);
		if(obj == null){
			return 0.0F;
		}else{
			if(obj instanceof Float){
				return (Float.parseFloat(super.get(numberKey).toString()));
			}else{
				return 0.0f;
			}
		}
	}

	/**
	 * numberKey에 해당하는 Data를 double로 바꾸어 리턴한다. 
	 *
	 * @param numberKey	numberKey값
	 * @return 변환된 값
	 */
	public double getDoubleNumber(String numberKey){
		Object obj = super.get(numberKey);

		if(obj == null){
			return 0.0;
		}else{
			return (Double.parseDouble(super.get(numberKey).toString()));
		}
	}

	/**
	 * 일자 데이터를 특정 포맷으로 바꾼다.
	 *
	 * @param date	date값
	 * @return 변환된 값
	 */
	public String getYyyymmdd(String date){

		if (date == null || date.equals("") || date.equals("&nbsp;")) return "";

		if(date.length() != 8) return date;

		date = date.substring(0, 4) + DATE_DELIM + date.substring(4, 6) + DATE_DELIM + date.substring(6, 8);
		return date;
	}

	public String getYyyymm(String date){

		if (date == null || date.equals("") || date.equals("&nbsp;")) return "";

		if(date.length() != 6) return date;

		date = date.substring(0, 4) + DATE_DELIM + date.substring(4, 6);
		return date;
	}	

	public String getWeek(String date){

		if (date == null || date.equals("") || date.equals("&nbsp;")) return "";

		if(date.length() != 1) return date;

		if("1".equals(date)) return "일";
		else if("2".equals(date)) return "월";
		else if("3".equals(date)) return "화";
		else if("4".equals(date)) return "수";
		else if("5".equals(date)) return "목";
		else if("6".equals(date)) return "금";
		else if("7".equals(date)) return "토";
		else return date;      

	}	

	/**
	 * 시간 데이터를 특정 포맷으로 바꾼다.
	 *
	 * @param time	time값
	 * @return 변환된 값
	 */
	protected String getHhmmssType(String time){

		if (time == null || time.equals("") || time.equals("&nbsp;")) return "";

		if (time.length() != 6) return time;

		time = time.substring(0, 2) + TIME_DELIM + time.substring(2, 4) + TIME_DELIM + time.substring(4, 6);
		return time;
	}

	/**
	 * 일자에 대한 상세 데이터를 담는다.
	 *
	 * @param date	date값
	 * @param time	time값
	 * @return 변환된 값
	 */
	public String getDetailDate(String date, String time){
		date = (date != null) ? date.trim() : "";
		time = (time != null) ? time.trim() : "";
		return (getYyyymmdd(date) + " " + getHhmmssType(time)).trim();
	}

	/**
	 * 받아들인 값을 일자구분자로 잘라내는 메쏘드 호출한다.
	 *
	 * @param dateColLabel	date값
	 * @return 변환된 값
	 */
	public String getDate(String dateColLabel){
		String date = (String)super.get(dateColLabel);
		if(date == null || date.equals(""))
			return "&nbsp;";
		else
			return (getYyyymmdd(date));
	}

	/**
	 * int숫자값을 콤마를 첨가한다.
	 *
	 * @param intNum	값
	 * @return 변환된 값
	 */
	public String getNumberFormat(int intNum){
		DecimalFormat currency = new DecimalFormat("###,###,##0");
		return (intNum == 0) ? "0" : currency.format(intNum);
	}

	/**
	 *  long숫자값을 콤마를 첨가한다.
	 *
	 * @param longNum	값
	 * @return 변환된 값
	 */
	public String getNumberFormat(long longNum){
		DecimalFormat currency = new DecimalFormat("###,###,##0");
		return (longNum == 0L) ? "0" : currency.format(longNum);
	}

	/**
	 *  float숫자값을 콤마를 첨가한다.
	 *
	 * @param floatNum	값
	 * @return 변환된 값
	 */
	public String getNumberFormat(float floatNum){
		DecimalFormat currency = new DecimalFormat("###,###,##0.0#");
		return (floatNum == 0.0F) ? "0" : currency.format(floatNum);
	}

	/**
	 *  double숫자값을 콤마를 첨가한다.
	 *
	 * @param doubleNum	값
	 * @return 변환된 값
	 */
	public String getNumberFormat(double doubleNum){
		DecimalFormat currency = new DecimalFormat("###,###,##0.0#");
		return (doubleNum == 0.0D) ? "0" : currency.format(doubleNum);
	}

	public String fitForView(String originStr, int tdWidth){
		int byteCntOfStr = originStr.getBytes().length;

		if(tdWidth < byteCntOfStr * 9){
			originStr = originStr + " ";
		}
		return originStr;
	}

	/**
	 *  value 값을 Trim 처리하며 공백 시 &nbsp;를 리턴한다.
	 *
	 * @param value	값
	 * @return 변환된 값
	 */
	public String useNbsp(String value){
		value = (value != null) ? value.trim() : "";
		return (value.equals("")) ? "&nbsp;" : value;
	}

	/**
	 *  사용자로부터 값을 받아들일때 먼저 선택하거나 Input한 값인지 아닌지를 판단한다. 선택되지 않았다면 모두 all로 셋팅한다.
	 *
	 * @param key	값
	 * @return 변환된 값
	 */
	public String getParam(String key){
		Object obj = super.get(key);
		if(obj == null){
			return "all";
		}else{
			if(obj instanceof String)
				return (((String)obj).equals("")) ? "all" : (String)obj;
			else
				return "all";
		}
	}

	/**
	 *  해당 데이터가 현 자료스트럭쳐에 없는 경우 nullValue로 채워서 꺼낸다.
	 *
	 * @param key	값
	 * @param nullValue	공백시 리턴될 값
	 * @return 변환된 값
	 */
	public String getParam2(String key, String nullValue){
		Object obj = super.get(key);
		if(obj == null){
			return nullValue;
		}else{
			if(obj instanceof String)
				return (((String)obj).equals("")) ? nullValue : (String)obj;
			else
				return nullValue;
		}
	}

	/**
	 *  10자리 숫자로 되어있는 사업자 등록 번호를 포맷에 맞추어 리턴한다.
	 *
	 * @param key	값
	 * @return 변환된 값
	 */
	public String getConoFormat(String key) {
		String co_no = "";
		String value = getStr(key);
		if(value.length() >= 10) {
			co_no = value.substring(0,3)+"-"+value.substring(3, 5)+"-"+value.substring(5, 10);
		}
		else {
			co_no = "   -  -     ";
		}
		return co_no;
	}
	
	/**
   * retValue
   *
   **/
  public String retValue(String output,String Value)
  {
    boolean result=false;
    int cmdIndex=0;
    int valIndex=0;
    int endIndex=0;
    String temp = new String();
    cmdIndex = output.indexOf(Value);

    if(cmdIndex != -1)
    {
      valIndex = output.indexOf( '=', cmdIndex );
      endIndex = output.indexOf( '\n', valIndex );
    } 

    if( cmdIndex != -1 )
    {
      if(valIndex != -1 )
      {
        if(endIndex != -1)
          temp = output.substring( valIndex + 1, endIndex  );
        else
          temp = output.substring( valIndex + 1);
          temp = temp.trim();
        return temp;                              
      }
      else
      {
        return "";
      } 
    }
    return "";
  }
} //end class
