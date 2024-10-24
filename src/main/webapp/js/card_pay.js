/**
 *  카드결제관련 스크립트
**/

/********************************************
 * Common
 * 
 */
//DIV display 변경

function changeDivDisplay(divObjId, displayVal) {
	$('#'+divObjId).attr('style','display:'+displayVal);
    //eval("document.getElementById(\"" + divObjId + "\").style.display = \"" + displayVal + "\"");
};
// 약관동의 체크
function checkTerms(){
	if(!$("#terms1").is(":checked")||!$("#terms2").is(":checked")||!$("#terms3").is(":checked")){
		alert("이용약관에 동의해 주세요.");
		return false;
	}
	return true;
};
//할부초기화 function
function removeItem() {
    //var items = $("#CardQuota");
    var items = document.tranMgr.CardQuota;
    items.options.length = 0;
};
//결제 과정 결제 버튼 중복 방지 function true: 숨김, false : 표시
function disableItems(arg) {
    if(arg) changeDivDisplay("btn_wrap", "none");
    else changeDivDisplay("btn_wrap", "block");	
};
// common.js 내 함수가 실행이 안되어 임시로 추가함
var install_notice_on = function(){
    $(".install_notice").fadeIn(500);
    $('body').css("overflow","hidden");
    
  
};

var install_notice_off = function(){
    $(".install_notice").css("display","none");
    $('body').css("overflow","auto");
};

var install_mpi_notice_on = function(){
    $(".install_mpi_notice").fadeIn(500);
    $('body').css("overflow","hidden");
    
   
};

var install_nhpage_on= function(){
	 var IFRAME=document.getElementById('IFRAME');
	 var dummy=document.getElementById('dummy');
	 dummy.innerHTML="<IFRAME id='Xframe' name='Xframe' style='display:none' src='./ilk/dummy.jsp'></IFRAME>";
	    IFRAME.innerHTML="<iframe name='kbframe2' id='kbframe2' onload='javascript:resizeFrame();' src='' marginwidth='0' marginheight='0' frameBorder=0 width='400' scrolling=no height='400'></iframe>";
    var kb=document.getElementById('kbframe2');
    kb.style.visibility="visible";
   
};
var install_sh_on= function(){
	 var IFRAME=document.getElementById('IFRAME');
	 var dummy=document.getElementById('dummy');
	 dummy.innerHTML="<IFRAME id='Xframe' name='Xframe' style='display:none' src='./ilk/dummy.jsp'></IFRAME>";
	    IFRAME.innerHTML="<iframe name='sh' id='sh' src='' marginwidth='0' marginheight='0' frameBorder=0 width='400' scrolling=no height='400'></iframe>";
	var s=document.getElementById('sh');
    s.style.visibility="visible";
   
};
var install_sh_off= function(){
	 var kb=document.getElementById('Xframe');
	 var IFRAME=document.getElementById('IFRAME');
	 var dummy=document.getElementById('dummy');
	var sh=document.getElementById('sh');
	  sh.style.visibility="hidden";
	  IFRAME.removeChild(sh);
	    dummy.removeChild(kb);
};
var install_nhpage_off = function(){
	 var dummy=document.getElementById('dummy');
	 var IFRAME=document.getElementById('IFRAME');
	  var kb=document.getElementById('kbframe2');
	  var i = document.getElementById('Xframe');
	  kb.style.visibility="hidden";
	  IFRAME.removeChild(kb);
	    dummy.removeChild(i);  
};
var install_lottepage_on = function(){
	  var IFRAME=document.getElementById('IFRAME');
		 var dummy=document.getElementById('dummy');
		 dummy.innerHTML="<iframe id='SPS' name='SPS' style='display:none' src='./ilk/dummy.jsp'></iframe>";
	    IFRAME.innerHTML="<iframe id='SPSFRAME' name='SPSFRAME' src='' marginwidth='0'width='600'height='400' marginheight='0' frameBorder=0 scrolling=no ></iframe>";
	    var lot=document.getElementById('SPSFRAME');
	    lot.style.visibility="visible";
  
};
var install_lottepage_off = function(){
	 var dummy=document.getElementById('dummy');
	 var IFRAME=document.getElementById('IFRAME');
	 var i = document.getElementById('SPS');	    
	 var lot= document.getElementById('SPSFRAME');
	  
	    IFRAME.removeChild(lot);
	    dummy.removeChild(i);
  
  
};
var install_hanapage_on= function(){
	 var IFRAME=document.getElementById('IFRAME');
	 var dummy=document.getElementById('dummy');
	 dummy.innerHTML="<IFRAME id='ILKFRAME' name='ILKFRAME' style='display:none' src='./ilk/dummy.jsp'></IFRAME>";
	    IFRAME.innerHTML="<iframe name='HANAFRAME' id='HANAFRAME' src='' marginwidth='0' marginheight='0' frameBorder=0 width='600' scrolling=no height='500' resizable=yes></iframe>";
    document.getElementById('HANAFRAME').style.visibility="visible";
   
};
var install_hanapage_off = function(){
	 var dummy=document.getElementById('dummy');
	 var IFRAME=document.getElementById('IFRAME');
    var hana= document.getElementById('HANAFRAME');
   hana.style.visibility="hidden";
  
    var i = document.getElementById('ILKFRAME');
    IFRAME.appendChild(hana);
   dummy.appendChild(i);
    disableItems(false);
};
var install_mpi_notice_off = function(){
    $(".install_mpi_notice").css("display","none");
    $('body').css("overflow","auto");
   
};

var install_danal_notice_on = function(){
    $(".install_danal_notice").fadeIn(500);
    $('body').css("overflow","hidden");
};

var install_danal_notice_off = function(){
    $(".install_danal_notice").css("display","none");
    $('body').css("overflow","auto");
};

var install_eximbay_notice_on = function(){
    $(".install_eximbay_notice").fadeIn(500);
    $('body').css("overflow","hidden");
};

var install_eximbay_notice_off = function(){
    $(".install_eximbay_notice").css("display","none");
    $('body').css("overflow","auto");
};

/////////////////////////////////////////////////////////////////////
//선택된 카드사에 가맹점 번호 출력 function 
function selectFnNo(objCardCd) {
	var rtn = null;
	for(var i=0;i<cardInfoArray.length;i++){
        var obj = null;
        var jsonObj = cardInfoArray[i];
        for(key in jsonObj){
            if(objCardCd==key){
                obj = cardInfoArray[i][key];
                rtn = obj.fnNo; // 123456789
                break;
            };
        }
        if(obj!=null) break;
        
    } // end for
	return rtn;
}
//////// PG 별 KVP_PGID 셋팅
//// PG 가 추가 되면 아래 케이스에 추가한다.
function getKVP_PGID(objCardCd){
	var pgcode = '01';
	var rtn = '';
	pgcode = getPGCode(objCardCd);
	if('22'==pgcode){
		rtn='A0029';
	}else{
		rtn='10903';
	}
	return rtn;
}

function getPGCode(objCardCd){
	var rtn = null;
	for(var i=0;i<cardInfoArray.length;i++){
        var obj = null;
        var jsonObj = cardInfoArray[i];
        for(key in jsonObj){
            if(objCardCd==key){
                obj = cardInfoArray[i][key];
                rtn = obj.pgCd; // PG코드
                break;
            };
        }
        if(obj!=null) break;
    } // end for
	return rtn;
}

function getPGLicenseKey(objCardCd){
	var rtn = null;
	for(var i=0;i<cardInfoArray.length;i++){
        var obj = null;
        var jsonObj = cardInfoArray[i];
        for(key in jsonObj){
            if(objCardCd==key){
                obj = cardInfoArray[i][key];
                rtn = obj.pgLicenseKey;
                break;
            };
        }
        if(obj!=null) break;
    } // end for
	return rtn;
}

function getPGMid(objCardCd){
	var rtn = null;
	for(var i=0;i<cardInfoArray.length;i++){
        var obj = null;
        var jsonObj = cardInfoArray[i];
        for(key in jsonObj){
            if(objCardCd==key){
                obj = cardInfoArray[i][key];
                rtn = obj.pgMid;
                break;
            };
        }
        if(obj!=null) break;
    } // end for
	return rtn;
}
function paycoFrame_Width(){  //페이코 프레임 크기가 너무 큰 관계로 divpop 자체를 조정
  parent.$("#divpop").css('width','720px');
}


//카드사 선택에 따른 할부개월 셋팅 이벤트 처리를 위한 function
function goCheckCard() {
    
    var bankcode = $("#bankcode").val();
    var formNm = document.tranMgr;
    formNm.formBankCd.value = bankcode;
    var noInterestMn = '';
    var noIntMn = null;
    // AppCard Display
    // 04 삼성 06 신한 07 현대 08 롯데 12 농협
    if(bankcode=='04'||bankcode=='06'||bankcode=='07'||bankcode=='08'||bankcode=='12'){
    	$("#appCardDiv").show();
    }else{
    	$("#appCardDiv").hide();
    }

    for(var i=0;i<cardInfoArray.length;i++){
    	var obj = null;
        var jsonObj = cardInfoArray[i];
        for(key in jsonObj){
            if(bankcode==key){
                obj = cardInfoArray[i][key];
                noInterestMn = obj.instMn; // 02:03
                // ISP 무이자할부 셋팅 BC,KB 카드사추가시 VP 카드코드 확인...
                if("01"==bankcode){ // BC
                	m_pgcd = obj.pgCd;
                	kvp_noint_inf = "0100-"+getKvpNointStr(noInterestMn);
                }else if("02"==bankcode){ // KB
                    kvp_noint_inf = "0204-"+getKvpNointStr(noInterestMn);
                    m_pgcd = obj.pgCd;
                }
                setKvpNointInf(kvp_noint_inf);
                break;
            };
        }
        if(obj!=null) break;
    } // end for
    removeItem();
    if(noInterestMn!=null&&noInterestMn!=''){
    	noIntMn = noInterestMn.split(":");
    	
        for(var j=0;j<quotabase.length;j++){
            var obj = quotabase[j];
            for(key in obj){
                var chk = false;
               	for(var i=0;i<noIntMn.length;i++){
               	    if(noIntMn[i]==key){
               	    	$("#CardQuota").append("<option style='color:#ff8400' value='"+key+"'>"+quotabase[j][key]+"(무이자)</option>");
                        chk = true;
                    };
                }
               	if(!chk) $("#CardQuota").append("<option value='"+key+"'>"+quotabase[j][key]+"</option>");
            };
        }; // end for	
    }else{
    	for(var j=0;j<quotabase.length;j++){
            var obj = quotabase[j];
            for(key in obj){
                $("#CardQuota").append("<option value='"+key+"'>"+quotabase[j][key]+"</option>");
            };
        };
    };
} // end goCheckCard()

//카드사 선택에 따른 할부개월 셋팅 이벤트 처리를 위한 function
function goCheckCard2(bankCode, bankName, etc) {
    var bankcode = bankCode;
    var bankname = bankName;
    var etc = etc;
    var formNm = document.tranMgr;
    formNm.formBankCd.value = bankcode;
    var noInterestMn = '';
    var noIntMn = null;
    // AppCard Display
    // 04 삼성 06 신한 07 현대 08 롯데 12 농협
    if(bankcode=='04'||bankcode=='06'||bankcode=='07'||bankcode=='08'||bankcode=='12'){
    	$("#appCardDiv").show();
    }else{
    	$("#appCardDiv").hide();
    }

    for(var i=0;i<cardInfoArray.length;i++){
    	var obj = null;
        var jsonObj = cardInfoArray[i];
        for(key in jsonObj){
            if(bankcode==key){
                obj = cardInfoArray[i][key];
                noInterestMn = obj.instMn; // 02:03
                // ISP 무이자할부 셋팅 BC,KB 카드사추가시 VP 카드코드 확인...
                if("01"==bankcode){ // BC
                	m_pgcd = obj.pgCd;
                	kvp_noint_inf = "0100-"+getKvpNointStr(noInterestMn);
                }else if("02"==bankcode){ // KB
                    kvp_noint_inf = "0204-"+getKvpNointStr(noInterestMn);
                    m_pgcd = obj.pgCd;
                }
                setKvpNointInf(kvp_noint_inf);
                break;
            };
        }
        if(obj!=null) break;
    } // end for
    removeItem();
    if(noInterestMn!=null&&noInterestMn!=''){
    	noIntMn = noInterestMn.split(":");
    	
        for(var j=0;j<quotabase.length;j++){
            var obj = quotabase[j];
            for(key in obj){
                var chk = false;
               	for(var i=0;i<noIntMn.length;i++){
               	    if(noIntMn[i]==key){
               	    	$("#CardQuota").append("<option style='color:#ff8400' value='"+key+"'>"+quotabase[j][key]+"(무이자)</option>");
                        chk = true;
                    };
                }
               	if(!chk) $("#CardQuota").append("<option value='"+key+"'>"+quotabase[j][key]+"</option>");
            };
        }; // end for	
    }else{
    	for(var j=0;j<quotabase.length;j++){
            var obj = quotabase[j];
            for(key in obj){
                $("#CardQuota").append("<option value='"+key+"'>"+quotabase[j][key]+"</option>");
            };
        };
    };
    if (etc == "etc") {
    	document.getElementById('etcCard1').setAttribute('value', bankcode);
    	document.getElementById("etcCard1").setAttribute('onclick', 'javascript:goCheckCard2(\'' + bankcode + '\', \'' + bankName + '\', \'\');');
    	document.getElementById("etcCard1").innerHTML = '<p class="card' + bankcode.replace(/(^0+)/, "") + '">' + bankname + '</p>';
    	document.getElementById('etcCard2').setAttribute('onclick', 'cardFrameOn()');
	    document.getElementById("etcCard2").innerHTML = '<p class="card_more">기타카드</p>';
	    $(".float_wrap").css("display","none");
	    $('body').css("overflow","auto");
	    $('.payment_input .card_list a').removeClass('on');
	    $('#etcCard1').addClass('on');
    } else {
    	$('.card_list2 a').removeClass('on');
    }
    document.getElementById('CardQuota').focus();
     
    
} // end goCheckCard2()

function exit()
{
	install_mpi_notice_off();
	if(document.getElementById('kbframe2'))
	install_nhpage_off();
	if(document.getElementById('HANAFRAME'))
	install_hanapage_off();
	if(document.getElementById('SPSFRAME'))
	install_lottepage_off();
	if(document.getElementById('sh'))
	install_sh_off();
	   
	btn_off();
	disableItems(false);
	
}

function btn_off()
{
	 var btn=document.getElementById('bt');
     btn.style.display="none";
     btn.style.marginTop="0px";
	}
function btn_on(cardName)
{  
	var btn=document.getElementById('bt');
	btn.style.display="block";	
	if(cardName == 'NONGHYUPCARD'||cardName == 'HYUNDAICARD' || cardName == 'SHINHANCARD'  )
		{
		
		
		if(cardName == 'NONGHYUPCARD')
			{btn.style.left="550px";}
		if(cardName == 'SHINHANCARD')
			{btn.style.left="550px";}
		if(cardName == 'HYUNDAICARD')
			{btn.style.left="550px";}
		
				}
	else if(cardName=='LOTTECARD')
		{
		btn.style.left="624px";
		
		}
	else if(cardName=="SAMSUNGCARD")
		{
		btn.style.left="550px";
		}
	else{
		btn.style.left="640px";
	}

	}
//카드코드 체크 함수
function contains(_ispArray, _bankCd){
    var flg = false;
    for(var i = 0 ; i < _ispArray.length ; i++){
        if(_ispArray[i] == _bankCd){
        flg = true;
           break;
        };        
    }
    return flg;
}
// 포인트결제 연동 팝업
var sObj = null;
function pointPopupView(bankCd){    
    var left = (screen.Width - 400)/2;
    var top = (screen.Height - 230)/2;
    var settings ='toolbar=no,status=no,menubar=no,scrollbars=no,resizable=no,height=370px,width=450px'+',left='+left+',top='+top;
    var url = "pointPopup.jsp?bankCd="+bankCd;
    sObj = window.open(url, "카드 포인트 안내", settings);
    if(sObj == null) sObj = '0';
};
//카드코드가 파라미터로 넘어오는 경우 셋팅 함수
function setBankCd(cardcode){
    var _frm = document.tranMgr;
    if(cardcode!=null && cardcode!=''){
        _frm.bankcode.value = cardcode;
        _frm.bankcode.disabled = true;
        goCheckCard();
    };
};
//인증 등 처리후 실제 결제 처리를 위한 function
function goPayment() {

    var formNm = document.tranMgr;
    formNm.action = "payConfirm_card.jsp";    
    formNm.submit();    
}
//결제 과정 취소 function 
function goCancel() {
	if(opener && opener!=this){
		window.close();	
	}else{
		history.back(-1);
	}
    return false;
}
/********************************************
 * ISP 관련 스크립트
 */
//ISP 무이자할부 정보 생성
//02:03 >> 2:3
function getKvpNointStr(instmn){
	var instStr ='';
	var rtn ='';
	instStr = instmn.split(":");
	for(var i=0;i<instStr.length;i++){
		if(i==0) rtn = rtn + parseInt(instStr[i]);
		else rtn = rtn +":"+ parseInt(instStr[i]);
	}
	return rtn;
}
function setKvpNointInf(str){
	document.pay.KVP_NOINT_INF.value = str;
	document.appForm.noint_inf.value = str;
}
//ISP 결제창 할부개월수 셋팅용
function setKVP_QUOTA(){
	var _fm = document.tranMgr;
	var _frm = document.pay;
	_frm.KVP_QUOTA.value = _fm.CardQuota.value; 
}
function VP_Ret_Pay(ret) {
	var formNm = document.getElementById("tranMgr");
    if(ret){
        formNm.action = "payConfirm_card.jsp";
        formNm.KVP_PGID.value           = document.pay.KVP_PGID.value;
        formNm.KVP_GOODNAME.value       = document.pay.KVP_GOODNAME.value;
        formNm.KVP_PRICE.value          = document.pay.KVP_PRICE.value;
        formNm.KVP_CURRENCY.value       = document.pay.KVP_CURRENCY.value;
        formNm.KVP_NOINT_INF.value      = document.pay.KVP_NOINT_INF.value;
        formNm.KVP_QUOTA_INF.value      = document.pay.KVP_QUOTA_INF.value;
        formNm.KVP_IMGURL.value         = document.pay.KVP_IMGURL.value;
        formNm.KVP_NOINT.value          = document.pay.KVP_NOINT.value;
        formNm.KVP_QUOTA.value          = document.pay.KVP_QUOTA.value;
        formNm.KVP_CARDCODE.value       = document.pay.KVP_CARDCODE.value;
        formNm.KVP_CONAME.value         = document.pay.KVP_CONAME.value;
        formNm.KVP_SESSIONKEY.value     = document.pay.KVP_SESSIONKEY.value;
        formNm.KVP_ENCDATA.value        = document.pay.KVP_ENCDATA.value;
        formNm.KVP_RESERVED1.value      = document.pay.KVP_RESERVED1.value;
        formNm.KVP_RESERVED2.value      = document.pay.KVP_RESERVED2.value;
        formNm.KVP_RESERVED3.value      = document.pay.KVP_RESERVED3.value;
        formNm.submit();
        //document.getElementById('submit_ISP').click();
        return true;
    }else{
         alert("ISP 카드 인증에 실패하였습니다.");
         install_notice_off();
         disableItems(false);
         return false;
    };
}
/**************************
 * KB AppCard 관련 스크립트
 **************************/
//결제창에서 ISP 결제 선택 시 호출
function goISP() {
    doACPAY2_Cancel();
    install_notice_on();
    document.pay.KVP_CARDCOMPANY.value = "0204";
    MakePayMessage(document.pay);
}
function goISP_WOORI() {
exit();

    document.pay.KVP_CARDCOMPANY.value = "0170";
    MakePayMessage(document.pay);
}
// 사용자가 결제창을 닫았을 경우 호출
function onACPAYCancel() {
    doACPAY2_Cancel();
    disableItems(false);
    setTimeout(function(){
        alert('결제가 취소 되었습니다.');
    }, 300);
    install_notice_off();
   
}
//결제(승인) 결과 호출
function onACPAYResult(resultCode) {
    doACPAY2_Cancel();
    disableItems(false);
    setTimeout(function(){
        if('0000' == resultCode) {
            var appPayFm = document.tranMgr;
            appPayFm.action="payConfirm_card.jsp";
            appPayFm.submit();
        } else {
        	
            alert('결제에 실패하였습니다. (' + resultCode + ')');
        }
    }, 300);
}
function onACPAYError(code) {
	doACPAY2_Cancel();
    disableItems(false);
    install_notice_off();
	setTimeout(function(){
		switch(code) {
			case 1001: alert('팝업 차단 설정 해제 후 다시 결제를 해 주십시오.(1001)'); 		break;	// 팝업 차단 설정이 되어 있는 경우
			case 2001: alert('인증 데이터 처리에 실패 하였습니다. 다시 시도해 주십시오.(2001)'); break;	// 인증 데이터 암호화 실패
			case 2002: alert('인증 데이터 처리에 실패 하였습니다. 다시 시도해 주십시오.(2002)'); break;	// 인증 데이터 암호화 실패
			case 3001: alert('거래키 발급에 실패하였습니다. 다시 시도해 주십시오.(3001)'); 	break;	// 거래키 발급 실패
			case 3002: alert('인증 데이터 처리에 실패하였습니다. 다시 시도해 주십시오.(3002)'); 	break;	// 인증 데이터 복호화 실패
			case 9101: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9101)'); 	break;	// 결제 코드 발급 실패 - 시스템 오류
			case 9102: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9102)'); 	break;	// 결제 코드 발급 실패 - acpKey 복호화 오류
			case 9103: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9103)'); 	break;	// 결제 코드 발급 실패 - acpKey 타임아웃
			case 9104: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9104)'); 	break;	// 결제 코드 발급 실패 - acpReq 복호화 오류
			case 9105: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9105)'); 	break;	// 결제 코드 발급 실패 - Hash mac 불일치
			case 9106: alert('결제 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9106)'); 	break;	// 결제 코드 발급 실패 - acpReq json 형식 오류
			case 9199: alert('거래 코드 발급에 실패하였습니다. 다시 시도해 주십시오.(9199)'); 	break;	// 거래 코드 발급 실패 - 시스템 오류
			case 9201: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9201)'); 	break;	// 거래키 요청 실패 - 시스템 오류
			case 9202: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9202)'); 	break;	// 거래키 요청 실패 - 유효하지 않은 pollingToken (pollingToken 복호화 오류) 
			case 9203: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9203)'); 	break;	// 거래키 요청 실패 - 유효하지 않은 pollingToken (pollingToken 타임아웃)
			case 9204: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9204)'); 	break;	// 거래키 요청 실패 - 해당 결제코드가 유효하지 않습니다. (결제코드가 존재하지 않음)
			case 9205: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9205)'); 	break;	// 거래키 요청 실패 - 유효하지 않은 pollingToken (결제코드 불일치)
			case 9206: alert('결제 인증 시간이 만료되었습니다. 다시 시도해 주십시오.(9206)'); 	break;	// 거래키 요청 실패 - 해당 결제코드의 거래시간이 만료 (결제코드 타임아웃)
			case 9207: alert('이미 결제된 코드입니다. 다시 시도해 주십시오.(9207)'); 		break;	// 거래키 요청 실패 - 해당 결제코드는 처리완료 되었습니다. (이미 결제 완료 처리됨)
			case 9299: alert('거래키 요청에 실패하였습니다. 다시 시도해 주십시오.(9299)'); 	break;	// 거래키 요청 실패 - 시스템 오류
			default: alert('결제 도중 오류가 발생하였습니다. 다시 시도해 주십시오.('+code+')');	break;	// 기타 오류
		}
	}, 300);
}
/*******************************************
 * XMPI 관련 스크립트
 */
var cpt_val = false;  // 레이어 캡쳐 여부
var cpt_layer = null; // 캡쳐된 레이어 객체
var esX, esY;         // 시작 이벤트 위치
var zIdx    = 100;    // 시작 z-index 값
// IE 구분
var is_ie = (navigator.userAgent.indexOf("MSIE") != -1) ? true :false;
//XMPI 인증 시작 function
function doXansim () { 
	
    var form = document.XansimForm;
   
    form.action = './xansim/hagent01.jsp';
    form.submit();
    return true;
}

// MPI => 카드사로 부터 인증 오류 메시지 수신시 호출되는 함수입니다.
function setErrorResult() {
	
	exit();
	  disableItems(false);
	 
    X_ANSIM_FRAME.location="iframe.jsp";
}
//MPI => 카드사로 부터 인증 결과 수신시 호출되는 함수입니다.
//-------------------------------------------------
//2008.08.01 신한은행 제휴코드  
//-------------------------------------------------
function setCertResult(xid, eci, cavv, cardno,joinCode,hs_useamt_sh) {
  //ansimItems(false);
	
	exit();
	disableItems(false);
  var formNm = document.tranMgr;
  formNm.xid.value = xid;
  formNm.eci.value = eci;
  formNm.cavv.value = cavv;
  formNm.cardno.value = cardno;
  formNm.joinCode.value = joinCode;
  formNm.hs_useamt_sh.value = hs_useamt_sh;
  if(hs_useamt_sh!=undefined && hs_useamt_sh != "null" && hs_useamt_sh!=''){
      formNm.CardPoint.value = '2';
  } 
  goPayment();    // 결제요청
}
//XMPI 응답 처리 function
function setCertResult2(xid, eci, cavv, cardno, joincode) {
    var form = document.tranMgr;
    form.xid.value = xid;
    form.eci.value = eci;
    form.cavv.value = cavv;
    form.cardno.value = cardno;
    form.joinCode.value = joincode;
    goPayment();
}
//xmpi 이벤트 처리 function
function returnPaymentPage() {
    disableItems(false);
    X_ANSIM_FRAME.location.href="xansim/iframe.jsp";
}
//마우스 다운 이벤트시 레이어 캡쳐
function capture(obj_id, evt) {
    var evt = evt ? evt : event;
    evt = evt||event;
    cpt_layer = document.getElementById(obj_id);
    zIdx++;
    cpt_layer.style.zIndex = zIdx;
    cpt_val = true;
    if(document.body && document.body.setCapture) {
        // body 화면 고정(IE전용)
       document.body.setCapture();
    }
    if(is_ie) {
        esX = evt.offsetX;
        esY = evt.offsetY;
    } else {
        esX = evt.clientX - (cpt_layer.offsetLeft ? cpt_layer.offsetLeft : 0);
        esY = evt.clientY - (cpt_layer.offsetTop  ? cpt_layer.offsetTop  : 0) ;
    }
    evt.cancelBubble = true;
    return false;
}
//마우스 드래그시 레이어 이동
function drag_layer(evt) {
	var evt = evt ? evt : event;
	if(cpt_val == true) {
		if(cpt_layer != null) {
			evt.cancelBubble = true;
			return false;
	   };
	};
}
//드래그가 끝났을때 캡쳐한 레이어 놓기
function release() {
	cpt_val = false;
	cpt_layer = null;
	if (document.body && document.body.releaseCapture) {
	   // body화면 고정풀기(IE전용)
	   document.body.releaseCapture();
	}
}
//레이어창 닫기
function close_layer(obj_id) {
	cpt_layer = document.getElementById(obj_id);
	cpt_layer.style.display = "none";
	
	exit();
	disableItems(false);
	var form = document.XansimForm;
	form.target = 'kbframe2';
	form.action = './xansim/iframe.jsp';
	form.submit();
}
/*********************************
 * Rocomo MPI 관련 스크립트(롯데)
 *********************************/
function dosps (purchaseAmt, currency,cardName, orderNo,orderUserId, orderSubBizNo,	orderMallName, orderEtc1, orderEtc2, chain_code) {
	var form = document.spsForm;
	form.order_amount.value = purchaseAmt;
	form.order_currency.value = currency;
	form.order_cardname.value = cardName;
	form.order_no.value = orderNo;
	form.order_userid.value = orderUserId;
	form.order_business.value = orderSubBizNo;
	form.order_mname.value = orderMallName;
	
	form.apvl_chain_no_lt.value = '1248702232';
	btn_on(cardName);
	//form.apvl_chain_no_lt.value = document.mallForm.apvl_chain_no_lt.value; 	//가맹점번호?
	//form.apvl_seller_id_lt.value = document.mallForm.apvl_seller_id_lt.value;	//사업자번호?
	//form.MBRNO.value = document.mallForm.order_userid.value;					//가맹점고객번호
	//form.REGNO.value = document.mallForm.REGNO.value;							//가맹점ID
	//form.IOS_RETURN_APP.value = document.mallForm.IOS_RETURN_APP.value;	
	
	if(chain_code=='3'){
		form.PAY.value='APC';
	}else{
		form.PAY.value='SPS';
	}
	
	form.action = './rocomo/SMPIAgent01.jsp';
	form.submit();
	return true;
}


//ILK => 실제 결제페이지로 넘겨주는 form에 xid, eci, cavv, cardno를 세팅한다.
function paramSet(xid, eci, cavv, realPan, ss_useyn, savekind, ss_useyn_ke,proceed) {

    if(proceed  == true){
         var frm2 = document.tranMgr;
        
        frm2.xid.value = xid;
        frm2.eci.value = eci;
        frm2.cavv.value = cavv;
        frm2.cardno.value = realPan;
    
        frm2.ss_useyn.value = ss_useyn;
        frm2.savekind.value = savekind;
        frm2.ss_useyn_ke.value = ss_useyn_ke;
        if(!(ss_useyn_ke == "null")){
            frm2.CardPoint.value = '2';
        }   
        
        if(savekind == '41'){
            frm2.CardQuota.value = "41";
        }else if(savekind == '40'){
            frm2.CardQuota.value = 40+parseInt(formNm.CardQuota.value);
        }       
        goPayment(); 
    }else{
        //ansimItems(false);
    	exit();
    	disableItems(false);
    };
    
}

// ILK => 결제 진행여부 결정(return 페이지에서 사용)
function proceed(arg) {
    if(arg == true) { 
        goPayment(); 
    } else { 
    	exit();
        disableItems(false);  
    }
};

var PopOption;
var interval;
var popup_r;

function danalPay(){
	PopOption = 'width=700,height=465,status=no,dependent=no,scrollbars=no,resizable=no';
	popup_r = window.open('', 'DANAL', PopOption);
	document.tranMgr.target="DANAL";
	document.tranMgr.method="post";
	document.tranMgr.action="../danal/cardAuth.jsp"; 
	//parent.document.getElementById("SPSDIV").style.display = "";
	document.tranMgr.submit();
	
	if (PopOption == null) {
        alert("팝업차단을 해제하신 후 결제를 하시기 바랍니다.");
        //install_danal_notice_off();
        install_notice_off();
        install_mpi_notice_off();
        install_nhpage_off();
        disableItems(false);
    }
	
	interval = setInterval("danalPayClose()",1000);
	
}

function danalPayClose(){
    if (popup_r.closed){
    	clearInterval(interval);
        //alert("결제창을 닫으셨습니다.");
        disableItems(false);
        //install_danal_notice_off();
        install_notice_off();
        install_mpi_notice_off();
    }
}

function eximbayPayClose(){
    if (popup_r.closed){
    	clearInterval(interval);
        alert("결제창을 닫으셨습니다.");
        disableItems(false);
        install_eximbay_notice_off();
    }
}
