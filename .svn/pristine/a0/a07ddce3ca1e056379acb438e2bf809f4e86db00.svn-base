<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="format-detection" content="telephone=no" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <title>주소검색</title>
        <style type="text/css">
        <!--body {
            margin-left: 0px;
            margin-top: 0px;
            margin-right: 0px;
            margin-bottom: 0px;
            font-size: 1em;
        }
        
        html {
            font-size: 62.5%;
        }
        @media (max-width: 300px) { 
            html { font-size: 70%; }
        } 
        
        @media (min-width: 500px) { 
            html { font-size: 80%; } 
        } 
        
        @media (min-width: 700px) { 
            html { font-size: 120%; } 
        } 
        
        @media (min-width: 1200px) { 
            html { font-size: 200%; } 
        }
        -->
        </style>
     <script src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	 <script src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
     <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
	 <script type="text/javascript">
	 
	 window.addEventListener("message", onReceivedPostMessage, false);
	  function onReceivedPostMessage(event){
	    //..ex deconstruct event into action & params
	    var action = event.data.action;
	    var params = event.data.params;
	    console.log("onReceivedPostMessage "+event);
	  }
	  
	 $(document).ready(function(){
		 execDaumPostcode();
	 });
	 
	 	var element_layer = document.getElementById("layer");
	 	function closeDaumPostcode() {
	        // iframe을 넣은 element를 안보이게 한다.
	        element_layer.style.display = 'none';
	    }
	 	
	    function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수
	                
	                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;
	                 // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                 	// 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    fullAddr = data.jibunAddress;
	                }
	                
	                
	              
					if (window.SearchAddressDialog) {
						// Call Android interface
						console.log(data.zonecode + fullAddr);
						window.SearchAddressDialog.setMessage(data.zonecode, fullAddr);//안드로이드 브릿지
					} else if (window.webkit
							&& window.webkit.messageHandlers
							&& window.webkit.messageHandlers.callBackHandler) {
											// Call iOS interface
											var postData = {
												/* postcode : data.postcode,
												zonecode : data.zonecode, */
												postcode : data.zonecode,
												zonecode : data.zonecode,
												addr : fullAddr
											};
											console.log("window.webkit.messageHandlers.callBackHandler.postMessage : \n "	+ postData.toString());
											window.webkit.messageHandlers.callBackHandler.postMessage(postData);//IOS인터페이스
					} else {
						opener.returnAddr(data.postcode, fullAddr, data.zonecode);
						self.close();
					}
					},
					width : '100%',
					heigth : '100%'
					}).embed(element_layer);
	        }
		</script>
    </head>
    <body>
		<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
			<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
		</div>
    </body>
</html>