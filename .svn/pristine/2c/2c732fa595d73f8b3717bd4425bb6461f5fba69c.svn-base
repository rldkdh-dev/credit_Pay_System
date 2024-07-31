<%@page contentType="text/html; charset=UTF-8"%><%
    //-------------------------------------------------------------------------
    // (4) result.jsp : 결제 인증 후 결제 결과를 전달합니다
    //-------------------------------------------------------------------------
    request.setCharacterEncoding("UTF-8");
        
    String resultData = request.getParameter("resultData");
    String resultFlag = request.getParameter("resultFlag");
    String errorCode = request.getParameter("errorCode");
    String accpresURL = request.getParameter("accpresURL");
/**    
    String script = "<script>";
    
    if ("goISP".equals(resultFlag)) {           // ISP결제 선택 시
        script += "window.parent.goISP();";
        
    } else if ("error".equals(resultFlag)) {    // 오류 발생 시
        script += "window.parent.onACPAYError(" + errorCode + ");";
    
    } else if ("payOK".equals(resultFlag)) {    // 결제 성공 시
        script += "var body = document.createElement('body');";
        script += "var form = body.appendChild(document.createElement('form'));";
        script += "form.action = '" + accpresURL + "';";
        script += "form.method = 'POST';";
        script += "var input_accres = form.appendChild(document.createElement('input'));";
        script += "input_accres.type = 'hidden';";
        script += "input_accres.name = 'accres';";
        script += "input_accres.value = '" + resultData + "';";
        script += "form.appendChild(input_accres);";
        script += "form.submit();";
    } else {                                    // 예외처리
        script += "window.parent.onACPAYError(9999);";
    }
    
    script += "</script>";
    
    out.print(script);
**/    
%>
<script type="text/javascript">
//<![CDATA[
    window.onload = function() {    //페이지 로드 완료 후 실행이 필요합니다.
        switch('<%=resultFlag%>') {
        case 'goISP':
            window.parent.goISP();
            break;
        case 'error':
            window.parent.onACPAYError('<%=errorCode%>');
            break;
        case 'payOK':
            var form = document.body.appendChild(document.createElement('form'));   //현재 문서에 form 연결후 submit이 필요합니다.
            form.action = '<%=accpresURL%>';
            form.method = 'POST';

            var input_accres = form.appendChild(document.createElement("input"));
            input_accres.type = 'hidden';
            input_accres.name = 'accres';
            input_accres.value = '<%=resultData%>';
            
            form.appendChild(input_accres);
            form.submit();
            break;
        default:
            window.parent.onACPAYError(9999);
            break;
        }
    };
//]]>
</script>
