<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* { padding: 0; margin: 0; }
*, ::after, ::before { box-sizing: border-box; }

body {
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	font-size: 14px;
	color: #222;
}

a { color: #222; text-decoration: none; cursor: pointer; }
a:active, a:hover { color: #f28011; text-decoration: underline; }

/* form-control */
.btn {
	color: #333;
	border: 1px solid #999;
	background-color: #fff;
	padding: 5px 10px;
	border-radius: 4px;
	font-weight: 500;
	cursor:pointer;
	font-size: 14px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.btn:active, .btn:focus, .btn:hover {
	background-color: #f8f9fa;
	color:#333;
}
.btn[disabled], fieldset[disabled] .btn {
	pointer-events: none;
	cursor: not-allowed;
	filter: alpha(opacity=65);
	-webkit-box-shadow: none;
	box-shadow: none;
	opacity: .65;
}

.form-control {
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	padding: 5px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.form-control[readonly] { background-color:#f8f9fa; }

textarea.form-control { height: 170px; resize : none; }

.form-select {
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	padding: 4px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.form-select[readonly] { background-color:#f8f9fa; }

textarea:focus, input:focus { outline: none; }
input[type=checkbox], input[type=radio] { vertical-align: middle; }

/* table */
.table { width: 100%; border-spacing: 0; border-collapse: collapse; }
.table th, .table td { padding-top: 10px; padding-bottom: 10px; }

.table-border thead > tr { border-top: 2px solid #212529; border-bottom: 1px solid #ced4da; }
.table-border tbody > tr { border-bottom: 1px solid #ced4da; }
.table-border tfoot > tr { border-bottom: 1px solid #ced4da; }

/* 기타 */
.p-5 { padding: 5px 5px 5px 5px; }
.mt-15 { margin-top: 15px; }

.row { display: flex; gap:10px; }
.col-2 { flex: 2; }
.col-1 { flex: 1; }
.border { border: 1px solid #ccc; }
.p-text { padding-top: 7px; padding-bottom: 7px; font-weight: 600; }

/* container */
.container { margin: 30px auto; width: 1000px; }

.body-container {
	max-width: 800px;
}

.body-title {
    color: #424951;
    padding-top: 35px;
    padding-bottom: 7px;
    margin: 0 0 25px 0;
    border-bottom: 2px solid #e0f0fe;
}
.body-title h3 {
    font-size: 24px;
    min-width: 300px;
    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
    color: #023b6d;
    font-weight: 700;
    padding-bottom: 10px;
    display: inline-block;
    margin: 0 0 -7px 0;
    border-bottom: 3px solid #002e5b;
}
.body-main {
	display: block;
	padding-bottom: 15px;
}

/* chatting */
.chat-msg-container { display: flex; flex-direction:column; height: 310px; overflow-y: scroll; }
.chat-connection-list { height: 355px; overflow-y: scroll; }
.chat-connection-list span { display: block; cursor: pointer; margin-bottom: 3px; }
.chat-connection-list span:hover { color: #0d6efd }

.row input[type=text] { width: 100%; } 

.user-left {
	color: #0d6efd;
	font-weight: 700;
	font-size: 10px;
	margin-left: 3px;
	margin-bottom: 1px;
}

.chat-info, .msg-left, .msg-right {
	max-width: 350px;
	line-height: 1.5;
	font-size: 13px;
    padding: 0.35em 0.65em;
    border: 1px solid #ccc;
    color: #333;
    white-space: pre-wrap;
    vertical-align: baseline;
    border-radius: 0.25rem;
}
.chat-info {
    background: #f8f9fa;
    color: #333;
    margin-right: auto;
    margin-left: 3px;
    margin-bottom: 5px;
}
.msg-left {
    margin-right: auto;
    margin-left: 8px;
    margin-bottom: 5px;
}
.msg-right {
	margin-left: auto;
    margin-right: 3px;
    margin-bottom: 5px;
}
</style>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.5.2/css/all.css">

<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<script type="text/javascript">
$(function(){
	/*
	var memberIdx = "${sessionScope.member.memberIdx}";
	var roomName = "${sessionScope.member.roomName}";
	var userName = "${sessionScope.member.nickName}";
	if(! memberIdx ) {
		location.href="${pageContext.request.contextPath}/member/login";
		return;
	}
	*/
	var memberIdx = "";
	var roomName = "";
	var userName = "";

	var socket = null;
	
	// -------------------------------------------
	$(".btnDisConnect").prop("disabled", true);
	
	$(".btnConnect").click(function(){
		roomName = $(".roomName").val().trim();
		memberIdx = $(".memberIdx").val().trim();
		userName = $(".nickName").val().trim();
		if( ! roomName || ! memberIdx || ! userName ) {
			alert("방이름/회원번호/닉네임은 필수 입니다.");
			return false;
		}
		
		connect();
			
		$(this).prop("disabled", true);
		$(".btnDisConnect").prop("disabled", false);
	});

	$(".btnDisConnect").click(function(){
		roomName = "";
		memberIdx = "";
		userName = "";
		socket = null;
		
		$(this).prop("disabled", true);
		$(".btnConnect").prop("disabled", false);
	});
	
	
	// -------------------------------------------
	// connect();
	
	function connect() {
		let host = "${wsURL}/" + roomName;
		
		if ('WebSocket' in window) {
			socket = new WebSocket(host);
	    } else if ('MozWebSocket' in window) {
	    	socket = new MozWebSocket(host);
	    } else {
	    	writeToScreen("<div class='chat-info'>브라우저의 버전이 낮아 채팅이 불가능 합니다.</div>");
	        return;
	    }
		
		socket.onopen = function(evt) { onOpen(evt) };
		socket.onmessage = function(evt) { onMessage(evt) };
		socket.onclose = function(evt) { onClose(evt) };
		socket.onerror = function(evt) { onError(evt) };		
	}
	
	function onOpen(evt) {
		writeToScreen("<div class='msg-right'>채팅방에 입장했습니다.</div>");
		
	    // 서버 접속이 성공 하면 아이디와 이름을 JSON으로 서버에 전송
	    let obj = {};
	    obj.type = "connect";
	    obj.uid = memberIdx;
	    obj.nickName = userName;
	    
	    let jsonStr = JSON.stringify(obj);  // JSON.stringify() : 자바스크립트 값을 JSON 문자열로 변환
	    socket.send(jsonStr);
	    
	    // 채팅입력창에 메시지를 입력하기 위해 #chatMsg에 keydown 이벤트 등록
	    $("#chatMsg").on("keydown",function(evt) {
	    	// 엔터키가 눌린 경우, 서버로 메시지를 전송한다.
			let key = evt.key || evt.keyCode;
	        if (key === "Enter" || key === 13) {
	            sendMessage();
	        }
	    });		
	}
	
	function onMessage(evt) {
    	// console.log(evt.data);
    	
    	// 전송 받은 문자열을 JSON으로 변환
    	let data = JSON.parse(evt.data); // JSON 파싱
    	let cmd = data.type;
    	
    	if( cmd === "userList" ) { // 처음 접속할 때 접속자 리스트를 받는다.
    		let users = data.users;
    		for(let i = 0; i < users.length; i++) {
    			let uid = users[i][0];
    			let nickName = users[i][1];
    			
    			let out = "<span id='user-"+uid+"' data-uid='"+uid+"'><i class='fa-solid fa-circle-user'></i> "+nickName+"</span>";
        		$(".chat-connection-list").append(out);
    		}
    	
    	} else if( cmd === "userConnect" ) { // 다른 유저가 접속 한 경우
    		let uid = data.uid;
    		let nickName = data.nickName;
    		
    		let out = "<div class='chat-info'>"+nickName+"님이 입장하였습니다.</div>";
    		writeToScreen(out);
    		
    		out = "<span id='user-"+uid+"' data-uid='"+uid+"'><i class='fa-solid fa-circle-user'></i> "+nickName+"<span>";
    		$(".chat-connection-list").append(out);
    		
    	} else if( cmd === "userDisconnect" ) { // 유저가 접속을 해제한 경우
    		let uid = data.uid;
    		let nickName = data.nickName;
    		
    		let out = "<div class='chat-info'>"+nickName+"님이 나갔습니다.</div>";
    		writeToScreen(out);
    		
    		$("#user-"+uid).remove();
    		
    	} else if(cmd === "message") { // 메시지를 받은 경우
    		let uid = data.uid;
    		let nickName = data.nickName;
    		let msg = data.chatMsg;
    		
    		let out = "<div class='user-left'>" + nickName + "</div>";
    		out += "<div class='msg-left'>" + msg + "</div>";
    		writeToScreen(out);
    		
    	}
    	
	}

	function onClose(evt) {
		$("#chatMsg").off("keydown");
       	writeToScreen("<div class='chat-info'>Info: WebSocket closed.</div>");
	}

	function onError(evt) {
		writeToScreen("<div class='chat-info'>Info: WebSocket error.</div>");
	}
	
	// 채팅 메시지 전송
	function sendMessage() {
	    var msg = $("#chatMsg").val().trim();
	    if(! msg ) {
	    	$("#chatMsg").focus();
	    	return;
	    }
	    
	    let obj = {};
        obj.type = "message";
        obj.chatMsg = msg;
        
        let jsonStr = JSON.stringify(obj);
        socket.send(jsonStr);

        $("#chatMsg").val("");
        
        writeToScreen("<div class='msg-right'>" + msg +"<div>");
	}	
});


// 채팅 메시지를 출력하기 위한 함수
function writeToScreen(message) {
    const $msgContainer = $(".chat-msg-container");
    $msgContainer.append(message);

    // 스크롤을 최상단에 있도록 설정함
    $msgContainer.scrollTop($msgContainer.prop("scrollHeight"));
}
</script>
</head>
<body>

<div class="container">
	<div class="body-container">
		<div class="body-title">
			<h3><i class="fa-regular fa-message"></i> 채팅 <small>chatting</small> </h3>
		</div>
		
		<div class="body-main">
			<div class="row">
				<div class="col-2">
					<p class="p-text"><i class="fa-solid fa-angles-right"></i> 채팅 메시지</p>
					<div class="border p-5 chat-msg-container"></div>
					<div class="mt-15">
						<input type="text" id="chatMsg" class="form-control" 
							placeholder="채팅 메시지를 입력 하세요...">
					</div>
				</div>
				<div class="col-1">
					<p class="p-text"><i class="fa-solid fa-angles-right"></i> 접속자 리스트</p>
					<div class="border p-5 chat-connection-list"></div>
				</div>
			</div>
		</div>
		
		<div style="padding: 10px;">
			<div>
				<span style="display: inline-block; width: 150px; font-weight: 500; text-align: left;">방이름</span>
				<span style="display: inline-block; width: 150px; font-weight: 500; text-align: left;">회원번호</span>
				<span style="display: inline-block; width: 150px; font-weight: 500; text-align: left;">닉네임</span>
			</div>
			<div>
				<input type="text" class="form-control roomName"  style="width: 150px;" placeholder="방이름">
				<input type="text" class="form-control memberIdx" style="width: 150px;" placeholder="회원번호">
				<input type="text" class="form-control nickName"  style="width: 150px;" placeholder="닉네임">
				<button type="button" class="btn btnConnect">접속</button>
				<button type="button" class="btn btnDisConnect">해제</button>
			</div>
		</div>
		
	</div>

</div>

</body>
</html>