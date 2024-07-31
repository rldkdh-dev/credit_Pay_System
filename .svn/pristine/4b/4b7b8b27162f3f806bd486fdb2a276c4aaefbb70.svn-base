/**
 **	index_card 관련 스크립트 함수
 **/

/*********************
 * COMMON
 *********************/
// 카드코드 체크 함수
function contains(_ispArray, _bankCd){
    var flg = false;
    for(var i = 0 ; i < _ispArray.length ; i++){
        if(_ispArray[i] == _bankCd){
        flg = true;
           break;
        }           
    }
    return flg;
}

// 카드코드가 파라미터로 넘어오는 경우 셋팅 함수
function setBankCd(cardcode){
	var _frm = document.tranMgr;
	if(cardcode!=null && cardcode!=''){
		_frm.bankcode.value = cardcode;
		_frm.bankcode.disabled = true;
		goCheckCard();
	}
	
}

// 카드포인트 안내 팝업
var sObj = null;
function pointPopupView(bankCd){	
	var left = (screen.Width - 400)/2;
	var top = (screen.Height - 230)/2;
	var settings ='toolbar=no;status=no;menubar=no;scrollbars=no;resizable=no;dialogHeight=370px;dialogWidth=450px'+';left='+left+';top='+top;
	var url = "pointPopup.jsp?bankCd="+bankCd;
	//sObj = window.showModalDialog(url, "카드 포인트 안내", settings);
	sObj = window.open(url, 'PointPopup', settings);
	if(sObj == null) sObj = '0';
}	

// 인증결제수단 (ISP, 안심클릭) 브라우져 체크 function
// 브라우져 체크 안함 2016.02.03
function browCheck(){
	//alert(navigator.appName);
	//alert(navigator.userAgent);
	if (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) {
		return true;
	}else if(navigator.appName ==  'Microsoft Internet Explorer' && navigator.userAgent.search('Trident') != -1) { // 인터넷 익스플로러 
		return true;
	}else if(navigator.appName ==  'Netscape' && navigator.userAgent.search('Chrome') != -1) { // 크롬
        return true;
	}else{
		return true;
	}
	
}

//인증 등 처리후 실제 결제 처리를 위한 function
function goPayment() {
	var formNm = document.tranMgr;
	formNm.action = "payConfirm_card.jsp";			
	formNm.submit();
}

/******************************
 * 폴라리스 XMPI 관련 스크립트
 ******************************/
var cpt_val = false;  // 레이어 캡쳐 여부
var cpt_layer = null; // 캡쳐된 레이어 객체
var esX, esY;         // 시작 이벤트 위치
var zIdx    = 100;    // 시작 z-index 값
// IE 구분
var is_ie = (navigator.userAgent.indexOf("MSIE") != -1) ? true :false;

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
	   }
	}
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
	disableItems(false);
	var form = document.XansimForm;
	form.target = 'X_ANSIM_FRAME';
	form.action = './xansim/iframe.jsp';
	form.submit();
}

// XMPI 인증 시작 function
// 2016.02 Host 연동 방식으로 변경 Hans
// function doXansim (purchaseAmt,currency,cardName,orderNo,orderUserId,orderSubBizNo,orderMallName,orderEtc1,orderEtc2,orderGoods) {
function doXansim () {
	var form = document.XansimForm;

	/* form.order_amount.value = purchaseAmt;
	form.order_currency.value = currency;
	form.order_cardname.value = cardName;
	form.order_no.value = orderNo;
	form.order_userid.value = orderUserId;
	form.order_business.value = orderSubBizNo;
	form.order_mname.value = orderMallName;
	form.order_etc1.value = orderEtc1;
	form.order_etc2.value = orderEtc2;
	form.order_goods.value = orderGoods; */

	form.action = './xansim/hagent01.jsp';
	form.submit();
	return true;
}

/****************************************
 * ILK MPI 관련 스크립트(하나,외환,씨티) 
 ****************************************/


/*********************************
 * Rocomo MPI 관련 스크립트(롯데)
 *********************************/
//2016.02.02 by.sbs
// SMPI 인증 시작 function
function dosps (purchaseAmt, currency,cardName, orderNo,orderUserId, orderSubBizNo,	orderMallName, orderEtc1, orderEtc2) {
	var form = document.spsForm;
	form.order_amount.value = purchaseAmt;
	form.order_currency.value = currency;
	form.order_cardname.value = cardName;
	form.order_no.value = orderNo;
	form.order_userid.value = orderUserId;
	form.order_business.value = orderSubBizNo;
	form.order_mname.value = orderMallName;
	
	form.apvl_chain_no_lt.value = '1248702232';
	//form.apvl_seller_id_lt.value = '2068511698';
	
	//form.apvl_chain_no_lt.value = document.mallForm.apvl_chain_no_lt.value; 	//가맹점번호?
	//form.apvl_seller_id_lt.value = document.mallForm.apvl_seller_id_lt.value;	//사업자번호?
	//form.MBRNO.value = document.mallForm.order_userid.value;					//가맹점고객번호
	//form.REGNO.value = document.mallForm.REGNO.value;							//가맹점ID
	//form.IOS_RETURN_APP.value = document.mallForm.IOS_RETURN_APP.value;	
	
	form.action = './rocomo/SMPIAgent01.jsp';
	form.submit();
	return true;
}

/*********************
 * ISP 관련 스크립트
 *********************/
//ISP 결제창 할부개월수 셋팅용
function setKVP_QUOTA(){
	var _fm = document.tranMgr;
	var _frm = document.pay;
	_frm.KVP_QUOTA.value = _fm.CardQuota.value; 
}

//ISP 크롬브라우져 결제용 스크립트
function VP_Ret_Pay(ret) {
	//var formNm = document.tranMgr;
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
        //formNm.submit();
        document.getElementById('submit_ISP').click();
        return true;
    }else{
         alert("ISP 카드 인증에 실패하였습니다.");
         ispItems(false);
         return false;
    }
}

/**************************
 * KB AppCard 관련 스크립트
 **************************/
//결제 도중 오류 발생 시 호출
function onACPAYError(code) {
	doACPAY2_Cancel();
	
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
