package mobile;

import java.text.SimpleDateFormat;
import java.util.*;

public class DateUtil {
	
	private DateUtil() {}
	
	private static class NetUtilHolder {
		final static DateUtil util = new DateUtil();
	}
	
	public static DateUtil getInstance() {
		return NetUtilHolder.util;
	}
	
	/**
	 * yyyy/mm/dd
	 * @param cal
	 * @return
	 */
	public static String convertStr(Calendar cal) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		String returnDate = dateFormat.format(cal.getTime());
		
		return returnDate; 
	}
	
	public static String formatDate(String date) {
		if(date.length() == 8) {
			return date.substring(0, 4) + "." + date.substring(4, 6) + "." + date.substring(6, 8);
		}
		else if(date.length() == 6) {
			return date.substring(0, 4) + "." + date.substring(4, 6);
		}
		else {
			return date;
		}
		
	}
	
	public static String formatTime(String time) {
		if(time.length() < 6) {
			return time;
		}
		
		return time.substring(0, 2) + ":" + time.substring(2, 4) + ":" + time.substring(4, 6);
	}
	
	/**
	 * 현재날짜를 구한다. ( yyyymmdd )
	 * @return
	 */
	public static String getCurrentDate() {
		java.util.Date date = new java.util.Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

		return dateFormat.format(date);
	}
	
}
