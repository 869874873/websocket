<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Java API for WebSocket (JSR-356)</title>
</head>
<body>
	<script type="text/javascript"
		src="http://cdn.bootcss.com/jquery/3.1.0/jquery.min.js"></script>
	<script type="text/javascript"
		src="http://cdn.bootcss.com/sockjs-client/1.1.1/sockjs.js"></script>
	<script type="text/javascript">
		var websocket = null;
		if ('WebSocket' in window) {
			//Websocket的连接  
			websocket = new WebSocket(
					"ws://" + window.location.host + "<%= request.getContextPath() %>/ws");//WebSocket对应的地址  
		} else if ('MozWebSocket' in window) {
			//Websocket的连接  
			websocket = new MozWebSocket(
					"ws://" + window.location.host + "<%= request.getContextPath() %>/ws");//SockJS对应的地址  
		} else {
			//SockJS的连接  
			websocket = new SockJS(
					"http://localhost:8080/websocket/sockjs/socketServer.do"); //SockJS对应的地址  
		}
		websocket.onopen = onOpen;
		websocket.onmessage = onMessage;
		websocket.onerror = onError;
		websocket.onclose = onClose;
		var str = "";
		function onOpen(openEvt) {
			//alert(openEvt.Data);  
		}

		function onMessage(evt) {
			var showMsg = document.getElementById('showMsg');
			showMsg.scrollTop = showMsg.scrollHeight;
			str += evt.data;
			document.getElementById("showMsg").value = str;
			//alert(evt.data);
		}
		function onError() {
		}
		function onClose() {
		}

		function doSend() {
			if (websocket.readyState == websocket.OPEN) {
				var msg = document.getElementById("inputMsg").value;
				websocket.send(msg);//调用后台handleTextMessage方法  
				document.getElementById("inputMsg").value = "";
			} else {
				alert("连接失败!");
			}
		}

		window.close = function() {
			websocket.onclose();
		}
	</script>
	<textarea rows="3" cols="100" id="showMsg" name="showMsg" style = "height: 200px;overflow-y: scroll;" readonly="readonly"></textarea>
	<br />
	请输入：
	<textarea rows="3" cols="100" id="inputMsg" name="inputMsg"></textarea>
	<button onclick="doSend();">发送</button>
</body>
</html