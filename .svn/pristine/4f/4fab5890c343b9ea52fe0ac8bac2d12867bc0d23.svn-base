<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.io.*, java.lang.*, java.util.*, mobile.DataModel, service.SupportIssue, kr.co.infinisoft.pg.common.*"%>
<%@ page import="util.CommonUtil, util.CardUtil, service.*" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%
    String tid = request.getParameter("TID");

	boolean hideTopBar = MMSUtil.isNullOrEmpty(request.getParameter("hideTopBar")) ? false : "true".equalsIgnoreCase(request.getParameter("hideTopBar"));
	boolean hideButton  = MMSUtil.isNullOrEmpty(request.getParameter("hideButton")) ? false : "true".equalsIgnoreCase(request.getParameter("hideButton"));
	
	SupportIssue si = new SupportIssue();

    // tb_card_trans 정보
    List lstTrans = si.getCardTransBuyAgree(tid);
    ArrayList aLstTrans = (ArrayList)lstTrans;
    DataModel tmap = (DataModel)aLstTrans.get(0);
    
    String mid = tmap.getStr("mid");
    String arsOrderKey = "";
    // tb_merchant 정보
    List lstMer = si.getMIDInfo(mid);
    ArrayList aLstMer = (ArrayList)lstMer;
    DataModel mmap = (DataModel)aLstMer.get(0);
    
    String strTotAmt = tmap.getStr("goods_amt");
    String strVat = "";
    String strAmt = "";
    String strNoVat = "";
    String strVatYN  = mmap.getStr("vat_mark");
    int vacLen = 0;
    
    if("0".equals(strVatYN)) {
		strAmt = "" + Math.round(tmap.getDoubleNumber("goods_amt")/11*10);
      
	    if(tmap.getStrNull("compound_yn").equalsIgnoreCase("Y")){
	    	
	    	long temp = tmap.getLongNumber("goods_tax_amt");
			
			long tax = tmap.getLongNumber("goods_tax_amt") - Math.round(tmap.getLongNumber("goods_tax_amt")/1.1);
		
			long amount = temp + tmap.getLongNumber("goods_duty_free");
		
			strAmt = String.valueOf(amount-tax);
      		strVat = String.valueOf(tax);
      		
      	}else{
      		strAmt = "" + Math.round(tmap.getDoubleNumber("goods_amt")/11*10);
            strVat = "" + (tmap.getLongNumber("goods_amt") - Long.parseLong(strAmt));
      	}
	    
	    if(mmap.getStrNull("shop_vat_yn").equalsIgnoreCase("N")){
	    	strAmt = "" + tmap.getStr("goods_amt");
	    	strVat = "0";
	    	strTotAmt = "" + tmap.getStr("goods_amt");
	    }
      
      	strNoVat = "0";
      	
    }else if("1".equals(strVatYN)) {
        strVat = "0";
        strAmt = "0";
        strNoVat = strTotAmt;
    }       
%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <link rel="stylesheet" type="text/css" href="../css/jquery.mCustomScrollbar.css" />
        <link rel="stylesheet" type="text/css" href="../css/common_.css" />
        <link href='../css/font.css' rel='stylesheet' type='text/css'>
        <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
		<script type="text/javascript">
			function googleTranslateElementInit() {
			  new google.translate.TranslateElement({pageLanguage: 'ko', includedLanguages: 'ar,de,en,es,fr,hi,ja,mn,ms,ru,th,tr,vi,zh-CN', layout: google.translate.TranslateElement.InlineLayout.SIMPLE, autoDisplay: false}, 'google_translate_element');
			}
			
			function popup(){
				var tid = '<%=tid%>';
	            var url="https://pg.innopay.co.kr/ipay/issue/CardIssue.jsp?TID=" + tid +"&svcCd=01";
	            var option="width=500, height=950, top=0"
	            window.open(url, "", option);
	        };
	        /* $(document).ready(function(){

				jQuery.fn.center = function(){
			    var p_width = this.width();
			    var p_height = this.height();
			    this.css("top", ($(window).height() / 2 ) - ( p_height / 2));
			    this.css("left", ($(window).width() / 2 ) - ( p_width / 2));
			    return this;
			    };
	
			    $('.l_popup').center();
			    $(window).resize(function() {
			      $('.l_popup').center();
			    });
			    $('.l_popup_c').click(function(){
			    	$('.l_popup').css('display','none');
			    });

		    
			}); */
		</script>        
        <script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="../js/jquery.mCustomScrollbar.js"></script>
        <script type="text/javascript" src="../js/common.js"></script>
        <title>INNOPAY 전자결제서비스</title>
    </head>
    <body>
    	<section class="l_popup">
			<section class="header">
				상품 구매 동의서
			</section>
			<section class="con">
				<section class="complete_info">
					<ul class="top_info">
						<li>
							<div class="info_title">상품명</div>
							<div><%= tmap.getStr("goods_name") %></div>
						</li>
						<li class="price_li">
							<div class="info_title">결제금액</div>
							<div class="price"><%=CommonUtil.setComma(strTotAmt) %><span>원</span></div>
						</li>
					</ul>
					<ul>
						<li>
							<div class="info_title">판매자상호명</div>
							<div><%= mmap.getStr("co_nm") %></div>
						</li>
						<li>
							<div class="info_title">판매자연락처</div>
							<div><%= mmap.getStr("tel_no") %></div>
						</li>
						<li>
							<div class="info_title">판매자주소</div>
							<div><%= mmap.getStr("addr_no1") %> <%= mmap.getStr("addr_no2") %></div>
						</li>
						<li>
							<div class="info_title" style="vertical-align: top; width:100%; display: block;margin-bottom: 4px;">상품설명</div>
							<div class="red" style="width:100%; display: block;"><%= CommonUtil.nl2br(tmap.getStr("goods_desc")) %></div>
						</li>
						<div class="agree">
							<div class="checked"></div>
							<label for="agree">위 상품설명을 확인 하였으며, 위 상품구매에 동의 합니다.</label>
						</div>
						<li>
							<div class="info_title">서명</div>
							<div><img src="data:image/jpeg;base64, <%=tmap.getStr("sign_image") %>" alt="서명" width="auto" height="50px"></div>
						</li>
					</ul>
				</section>
				<section class="btn_wrap_multi">
					<div>
						<a class="btn_d_gray btn" href="javascript:popup()">영수증 보기</a>
						<a class="btn_blue btn l_popup_c" href="#" onclick="window.close();">확인</a>
					</div>
				</section>
			</section>
		</section>
    </body>
</html> 