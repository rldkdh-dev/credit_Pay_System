<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="org.apache.commons.lang.StringUtils,java.util.HashMap" %>
<%!
public static String getXMpiMsg(String code){
    String rtn = "";
    HashMap<String,String> map = new HashMap<String,String>();
    
    map.put("0000", "응답 성공");
    map.put("A001", "세션 만료 (세션 생성 실패)");
    map.put("A002", "비정상적인 접근");
    map.put("A003", "인증 취소");
    map.put("A004", "인증 취소");
    map.put("A005", "보안프로그램 미설치로 인증취소");
    map.put("A006", "보안프로그램 실행 오류로 인증실패");
    map.put("A007", "인증취소");
    map.put("AP01", "인증취소");
    map.put("AP02", "인증취소");
    map.put("AP03", "인증취소");
    map.put("AV01", "인증취소");
    map.put("AV02", "인증취소");
    map.put("AV03", "인증취소");
    map.put("AV04", "인증취소");
    map.put("AV05", "인증취소");
    map.put("AV06", "인증취소");
    map.put("AV07", "인증취소");
    map.put("AV08", "인증취소");
    map.put("AV09", "인증취소");
    map.put("AV10", "인증취소");
    map.put("AV11", "인증취소");
    map.put("AV12", "인증취소");
    map.put("AV13", "인증취소");
    map.put("AV14", "인증취소");
    map.put("AV15", "인증취소");
    map.put("AV16", "인증취소");
    map.put("AV17", "인증취소");
    map.put("AV18", "인증취소");
    map.put("AV19", "인증취소");
    map.put("AV20", "인증취소");
    map.put("AV21", "인증취소");
    map.put("AV22", "인증취소");
    map.put("AV23", "인증취소");
    map.put("AV24", "인증취소");
    map.put("AV25", "인증취소");
    map.put("AV26", "인증취소");
    map.put("AV27", "인증취소");
    map.put("D001", "메시지 복호화를 위해 비대칭키를 초기화하는데 실패");
    map.put("D002", "세션키를 Base64 decode하는데 실패");
    map.put("D003", "암호화된 세션키를 복호화하는데 실패");
    map.put("D004", "메시지 복호화를 위해 대칭키 초기화하는데 실패");
    map.put("D005", "암호화된 메시지를 Base64 decode하는데 실패");
    map.put("D006", "암호화된 메시지 복호화에 실패");
    map.put("D007", "받은 전자서명문을 형식 변환 실패");
    map.put("D008", "전자서명문을 검증을 위한 서명객체를 초기화 실패");
    map.put("D009", "전자서명문 검증을 위해 원문 메시지를 업데이트 하는데 실패");
    map.put("D010", "전자서명문을 검증하는데 오류가 발생");
    map.put("D011", "전자서명 검증  실패");
    map.put("D012", "인증서 정책을 검증하기 위해 초기화하는데 오류가 발생");
    map.put("D013", "허용되지 않는 정책의 인증서");
    map.put("D014", "인증서 유효성 검증 실패");
    map.put("E001", "전자서명용 인증서를 읽는데 오류가 발생");
    map.put("E002", "세션키 생성 및 초기화에 실패");
    map.put("E003", "원문메시지 암호화에 실패");
    map.put("E004", "세션키를 암호용 공개키 획득 실패");
    map.put("E005", "RSA 암호화 객체 초기화에 실패");
    map.put("E006", "세션키 암호화 실패");
    map.put("E007", "전자서명 초기화 실패");
    map.put("E008", "전자서명 실패");
    map.put("E009", "전자서명 종료 실패");
    map.put("S999", "카드사 시스템 오류");
    map.put("S001", "카드사 시스템 오류");
    map.put("S002", "카드사 시스템 오류");
    map.put("S003", "카드사 시스템 오류");
    map.put("S004", "카드사 시스템 오류");
    map.put("S005", "카드사 처리 지연으로 다시 시도 요망");
    map.put("2101", "인증요청 파라메타값 확인 요망");
    map.put("2102", "인증요청시간 정보 확인 요망");
    map.put("2103", "인증요청 제한 시간 초과");
    map.put("2104", "일반쇼핑몰, PG 구분 정보 확인 요망");
    map.put("2105", "쇼핑몰 혹은 PG의 사업자등록번호 확인 요망");
    map.put("2106", "XMPI Merchant ID 확인 요망");
    map.put("2107", "인증결과 수신 페이지 URL 정보 확인 요망");
    map.put("2108", "XID 정보 확인 요망");
    map.put("2109", "카드사명 확인 요망");
    map.put("2110", "하위몰의 사업자번호 정보 확인 요망");
    map.put("2111", "금액 정보 확인 요망");
    map.put("2112", "통화코드 확인 요망");
    map.put("2113", "인증창에 출력되는 쇼핑몰명 정보 확인 요망");
    map.put("2114", "테스트용 XMPI인 경우 테스트 정보 확인 요망");
    map.put("2115", "하위몰 사업자번호 확인 요망");
    map.put("2116", "사업자번호 정보 확인 요망");
    map.put("2141", "모바일 서비스 지원 대상 단말 아님");
    map.put("0004", "성공");
    map.put("A008", "내부오류로 인증 실패 응답");
    map.put("A999", "인증 창 닫음");
    map.put("F001", "인증 취소");
    map.put("F002", "인증 취소");
    map.put("F999", "비정상 접근으로 인증 실패 응답");
    map.put("A010", "인증 취소");
    map.put("A011", "인증 취소");
    map.put("A012", "인증 취소");
    map.put("A013", "인증 취소");
    map.put("A014", "인증취소");
    map.put("A015", "인증취소");
    map.put("A016", "인증취소");
    map.put("A017", "인증취소");
    map.put("A018", "인증취소");
    map.put("A019", "인증취소");
    map.put("A020", "인증취소");
    map.put("A021", "인증취소");
    map.put("2120", "30만원이상은 거래불가합니다");
    map.put("2121", "해당기기는 서비스 불가합니다");
    map.put("2122", "스마트폰에서 공인인증서 결제는 거래불가합니다");
    map.put("2342", "인증 오류 횟수 초과로 인증 실패");
    map.put("2343", "인증 시간 초과로 인증 실패");
    map.put("2345", "해당쇼핑몰은 네이버페이로 인증이 불가");
    map.put("3001", "안심클릭 가입 또는 패스워드 변경 시 오류횟수 초과로 서비스 이용 불가");

    rtn = map.get(code);
    if(StringUtils.isEmpty(rtn)){
        rtn = "기타오류";
    }
    return rtn;
}
%>