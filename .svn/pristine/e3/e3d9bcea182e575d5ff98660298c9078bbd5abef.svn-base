<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.io.*, java.lang.*, java.util.*, java.math.*, mobile.DataModel, service.SupportIssue, kr.co.infinisoft.pg.common.*"%>
<%
    String tid = request.getParameter("TID");
        
    SupportIssue si = new SupportIssue();

    // tb_rcpt_trans 정보
        List lstRcpt = si.getCashReceiptDetail(tid);
        if (lstRcpt.size() <= 0) { // TID가 없으면 alert창 띄우고 강제 종료
            out.println("<script>alert('현금영수증 거래가 아닙니다');history.back();window.close();</script>"); 
            return;
        }
        ArrayList aLstRcpt = (ArrayList)lstRcpt;
        DataModel cmap = (DataModel)aLstRcpt.get(0);
        String mid = cmap.getStr("mid");
        
        // tb_merchant 정보
        List lstMer = si.getMIDInfo(mid);
        if (lstMer.size() <= 0) { // MID가 없으면 alert창 띄우고 강제 종료
            out.println("<script>alert('현금영수증 거래가 아닙니다');history.back();window.close();</script>"); 
            return;
        }
        ArrayList aLstMer = (ArrayList)lstMer;
        DataModel mmap = (DataModel)aLstMer.get(0);
        
        String strDisplay = "";
                
        if("0".equals(cmap.getStr("state_cd"))) {
          strDisplay = "none";
        } else {
          strDisplay = "block";
        }
%>
<!DOCTYPE HTML>
<!--[if IE 7]> <html class="no-js lt-ie10 lt-ie9 lt-ie8 ie7" lang="ko-KR"> <![endif]-->
<!--[if IE 8]> <html class="no-js lt-ie10 lt-ie9 ie8" lang="ko-KR"> <![endif]-->
<!--[if !IE]><!--><html class="no-js" lang="ko-KR"><!--<![endif]-->
<head>
<title><%=CommonConstants.PG_NM %></title>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0, user-scalable=no">
<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<link rel="stylesheet" href="../css/style_1.css" >
<!-- 160520 프린트 추가 -->
<link rel="stylesheet" href="../css/print.css" media="print">

</head>
<body>
<!-- *** #wrapper -->
<div id="wrapper">
    <header id="header">
        <h1>
            <a href="<%=CommonConstants.HOMEPAGE %>" title="<%=CommonConstants.PG_NM %> 홈페이지 이동" target="_blank"><img src="../images/new/receipt/logo.png" width="94" height="26" alt="<%=CommonConstants.PG_NM%>"></a>
        </h1>
    </header>

    <!-- contents -->
    <article id="contents">
        <!-- 배경이미지 -->
        <div class="bg_receipt">
            <span class="bg_l">
                <img src="../images/new/receipt/bg_circle.png" alt="배경">
            </span>
            <span class="bg_r">
                <img src="../images/new/receipt/bg_circle.png" alt="배경">
            </span>
        </div>

        <!-- content -->
        <div class="content">
            <h2><span>*</span>현금영수증 전표</h2>
            <form  method="GET" class="frm_select_link" target="_self">
            <fieldset>
                <legend></legend>
                <!-- 전표선택 -->
                <!-- 160526 모바일단 대응 작업으로 인해 추가수정됨 -->
                <div class="select_box_wrap">
                    <select name="" class="select_box" >
                    <% if("0".equals(cmap.getStr("state_cd"))) { %>
                          <option value='0' selected>승인전표</option>
                    <% } else { %>
                          <option value='0'>승인전표</option>
                          <option value='1' selected>취소전표</option>
                    <% } %>
                    </select>
                </div>
                <!-- t_box_1 -->
                <section class="t_box_1 t_box">
                    <ul class="receipt_info">
                        <li class="ri b_title">
                            <h3>결제 정보</h3>
                        </li>
                    </ul>

                    <ul class="receipt_info">
                        <li class="ri">
                                <ul class="">
                                    <li>용도</li>
                                    <li><%=cmap.getStr("req_flg_nm") %></li>
                                </ul>
                        </li>

                        <li class="ri">
                            <ul>
                                <li>발급일시</li>
                                <li><%= cmap.getFormattedDate("reg_dt") %> <%= cmap.getFormattedTime("reg_tm") %></li>
                            </ul>
                        </li>
                    </ul>

                    <ul class="receipt_info">
                        <li class="ri">
                            <ul>
                                <li>신분확인</li>
                                <li><%= cmap.getStr("identity") %></li>
                            </ul>
                        </li>

                        <li class="ri">
                            <ul>
                                <li>발급취소일시</li>
                                <li><%= cmap.getFormattedDate("cc_dt") %>&nbsp;<%= cmap.getFormattedTime("cc_tm") %></li>
                            </ul>
                        </li>
                    </ul>

                    <ul class="receipt_info">
                        <li class="ri">
                            <ul>
                                <li>상품명</li>
                                <li><%= cmap.getStr("goods_nm") %></li>
                            </ul>
                        </li>

                        <li class="ri">
                            <ul>
                                <li>결제수단</li>
                                <li><%=cmap.getStr("org_svc_nm") %></li>
                            </ul>
                        </li>
                    </ul>

                    <ul class="receipt_info ">
                        <li class="ri">
                            <ul>
                                <li>현금영수증 사업자</li>
                                <li>(주) <%=CommonConstants.PG_NM %></li>
                            </ul>
                        </li>

                        <li class="ri">
                            <ul>
                                <li>승인번호</li>
                                <li><%= cmap.getStr("app_no") %></li>
                            </ul>
                        </li>
                    </ul>

                </section>
                <!-- //t_box_1 -->

                <!-- t_box_2 -->
                <section class="t_box_2 t_box">
                    <!-- t_box_l -->
                    <div class="t_box_l">
                    
                        <ul class="receipt_info">
                            <li class="ri b_title">
                                <h3>현금영수증 가맹점 정보</h3>
                            </li>

                            <li class="ri">
                                <ul>
                                    <li>가맹점명</li>
                                    <li><%= mmap.getStr("co_nm") %></li>
                                </ul>
                            </li>

                            <li class="ri">
                                <ul>
                                    <li>사업자번호</li>
                                    <li><%= mmap.getConoFormat("co_no") %></li>
                                </ul>
                            </li>

                            <li class="ri">
                                <ul>
                                    <li>대표자명</li>
                                    <li><%= mmap.getStr("boss_nm") %></li>
                                </ul>
                            </li>

                            <li class="ri ri_end">
                                <ul>
                                    <li>연락처</li>
                                    <li><%= mmap.getStr("tel_no") %></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <!-- //t_box_l -->

                    <!-- t_box_r -->
                    <div class="t_box_r">
                        <ul class="receipt_info">
                            <li class="ri b_title">
                                <h3>이용금액</h3>
                            </li>
                        </ul>
<%
          String strTotAmt = cmap.getStr("goods_amt");
          String strVat = cmap.getStr("goods_vat");
          String strAmt = cmap.getStr("supply_amt");
          String strSvs = cmap.getStr("svs_amt");
          String strNoVat = "0";
          String strVatYN  = mmap.getStr("vat_mark");
          int vacLen = 0;
          int supamt = 0;
          
          if(strAmt != null && strSvs != null) {
              supamt = Integer.parseInt(strAmt) + Integer.parseInt(strSvs);
          }
          else if(strSvs == null) {
              supamt = Integer.parseInt(strAmt);
          }
          else if(strAmt == null) {
              supamt = Integer.parseInt(strSvs);
          }
          
          if("1".equals(strVatYN)) {
                strVat = "0";
                strAmt = "0";
                strNoVat = strTotAmt;
          }    
          String strSupAmt = String.valueOf(supamt);
          
                                                      
          for(int i = 1; i < 11; i++) {
              if(i > strTotAmt.length()) strTotAmt = " " + strTotAmt;
              if(i > strVat.length()) strVat = " " + strVat;  
              if(i > strAmt.length()) strAmt = " " + strAmt;  
              if(i > strNoVat.length()) strNoVat = " " + strNoVat;
          }                   
                    
%>
                        
                        <!-- table -->
                        <ul>
                            <li>
                                <table>
                                    <colgroup>
                                        <col width="59"/>
                                        <col />
                                        <col />
                                        <col />
                                        <col />
                                        <col />
                                        <col />
                                        <col />
                                        <col />
                                        <col />
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th>과세금액</th>
                                            <td><%= strAmt.charAt(0)%></td>
                                            <td><%= strAmt.charAt(1)%></td>
                                            <td><%= strAmt.charAt(2)%></td>
                                            <td><%= strAmt.charAt(3)%></td>
                                            <td><%= strAmt.charAt(4)%></td>
                                            <td><%= strAmt.charAt(5)%></td>
                                            <td><%= strAmt.charAt(6)%></td>
                                            <td><%= strAmt.charAt(7)%></td>
                                            <td><%= strAmt.charAt(8)%></td>
                                            <td><%= strAmt.charAt(9)%></td>
                                        </tr>
                                        <tr>
                                            <th>부가세</th>
                                            <td><%= strVat.charAt(0)%></td>
                                            <td><%= strVat.charAt(1)%></td>
                                            <td><%= strVat.charAt(2)%></td>
                                            <td><%= strVat.charAt(3)%></td>
                                            <td><%= strVat.charAt(4)%></td>
                                            <td><%= strVat.charAt(5)%></td>
                                            <td><%= strVat.charAt(6)%></td>
                                            <td><%= strVat.charAt(7)%></td>
                                            <td><%= strVat.charAt(8)%></td>
                                            <td><%= strVat.charAt(9)%></td>
                                        </tr>

                                        <tr>
                                            <th>면세금액</th>
                                            <td><%= strNoVat.charAt(0)%></td>
                                            <td><%= strNoVat.charAt(1)%></td>
                                            <td><%= strNoVat.charAt(2)%></td>
                                            <td><%= strNoVat.charAt(3)%></td>
                                            <td><%= strNoVat.charAt(4)%></td>
                                            <td><%= strNoVat.charAt(5)%></td>
                                            <td><%= strNoVat.charAt(6)%></td>
                                            <td><%= strNoVat.charAt(7)%></td>
                                            <td><%= strNoVat.charAt(8)%></td>
                                            <td><%= strNoVat.charAt(9)%></td>
                                        </tr>

                                        <tr class="ri_end">
                                            <th>합계</th>
                                            <td><%= strTotAmt.charAt(0)%></td>
                                            <td><%= strTotAmt.charAt(1)%></td>
                                            <td><%= strTotAmt.charAt(2)%></td>
                                            <td><%= strTotAmt.charAt(3)%></td>
                                            <td><%= strTotAmt.charAt(4)%></td>
                                            <td><%= strTotAmt.charAt(5)%></td>
                                            <td><%= strTotAmt.charAt(6)%></td>
                                            <td><%= strTotAmt.charAt(7)%></td>
                                            <td><%= strTotAmt.charAt(8)%></td>
                                            <td><%= strTotAmt.charAt(9)%></td>
                                        </tr>
                                    </tbody>
                                </table>

                            </li>
                        </ul>
                        <!-- //table -->
                    </div>
                    <!-- //t_box_r -->

                    <!-- 취소 마크 mark_cancle -->
                    <div id="apDiv2" class="mark_cancle" style="display:<%=strDisplay%>">
                        <img src="../images/new/receipt/mark_cancle.png" alt="취소" width="144" height="110" >
                    </div>
                    <!-- //mark_cancle -->
                    
                </section>
                <!-- //t_box_2 -->

                <section class="t_box_3 t_box t_line">
                    <ul class="receipt_info">
                        <li class="ri ri_a">
                            <ul>
                                <li>주소</li>
                                <li>(<%= mmap.getStr("post_no") %>) <%= mmap.getStr("addr_no1") %>&nbsp;<%= mmap.getStr("addr_no2") %></li>
                            </ul>
                        </li>
                    </ul>
                </section>
                
                <section>
                    <p class="txt_info txt_no_line">
                        <span>- 본 영수증은 국세청 현금영수증 홈페이지(http://현금영수증.kr)에서 조회가 가능합니다. </span>
                        <span>- 본 영수증은 조세특례제한법 제124조 3 및 동법 시행령 제121조의 3 규정에 의거, 연말정산 시 소득공제 혜택 부여의 목적으로 발행됩니다.</span>
                        <span>- 현금거래 완료건에 대한 국세청의 검증 소요기간은 2일이며 결제하신 다음날 검증이 완료된 현금영수증을 발급받을 수 있습니다. </span>
                    </p>
                </section>
                <!-- 버튼 -->
                    <div class="btn_cn btn_cn_pos">
                        <p>
                            <a href="javascript:close();" class="btn_cancle" ><strong>닫기</strong></a>
                            <a href="javascript:print();" class="btn_next" ><strong>인쇄</strong></a>
                        </p>
                    </div>


            </fieldset>
            </form>
        </div>
        <!-- //content -->
    </article>
    <!-- //contents -->
</div>
<!-- //*** #wrapper -->

<script src="../js/jquery-1.9.1.js"></script>
<!-- selectbox -->
<script src="../js/lib/SelectBox.js" ></script>
<script type="text/javascript">
// 160525 모바일단 대응 작업으로 인해 추가수정됨
$(".frm_select_link").each(function() {
    var $form = $(this);
    var sb = new SelectBox({
        selectbox: $form.find("select"),
        changeCallback: function(val) {
        	if(val == '0') {
                document.getElementById("apDiv2").style.display = "none";
            } else {
                document.getElementById("apDiv2").style.display = "block";
            }
        }
    });
});
</script>

</body>
</html>