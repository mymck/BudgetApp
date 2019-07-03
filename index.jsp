<%@page import = "java.io.*,java.util.*,Budget.*" %>
<html>
<head>
<script src="jquery-3.3.1.min.js"></script>
<script src="cookies.js"></script>
<script>
//Using javascript we make ajax calls using jquery to retrieve the user's information from the server.
checkCookie();
var username = getCookie("username");
var c20 = 1;
var c20l = c20;//number of charges left, full by default;
var c10 = 3;
var c10l = c10;
var monday,friday;

function countChargesUsed(values) {
	var result = 0;
	for (var i=0;i<values.length;i++) {
		
		if (values[i] > 0) {
			result++;
		}
	}
	return result;
}

function processResult(data) {
	//seems necessary for tags and whitespace
	data = data.trim();
	var result = data.split("^");
	monday = Number(result[0]);
	friday = Number(result[1]);
	c20 = Number(result[2]);
	c10 = Number(result[3]);
	var c20values = result.slice(4,4+c20);
	var c10values = result.slice(4+c20);
	
	$("#note_20").html(c20-countChargesUsed(c20values));
	$("#note_10").html(c10-countChargesUsed(c10values));	
}
//different payloads for different methods. Uses a switch to decide the payload then makes an ajax call
function charge(user, update) {
	var payload;
	switch (update) {
		case "update": {
			payload = {user:user, update:1};
		}break;
		case "c20": {
			payload = {user:user, c20:1};
		}break;
		case "c10": {
			payload = {user:user, c10:1};
		}break;
		default: {
			payload = {user:user};
		}break;
	}
	$.get("charge.jsp",payload,processResult);
}
//retrieve user information, separate from the charge function as makes a call to a different file.
function login(user) {
	var payload = {user:user,c20:c20,c10:c10};
	$.get("user.jsp",payload,processResult);
}
</script>
<link href="style.css" rel="stylesheet" type="text/css"/>
</head>

<body>
<!--
server side pages
-build a user/check user exists (user.jsp) for login and user check
-check if date/charges needs reset (charge.jsp?update=1) on login and user check
-use a charge (charge.jsp)
--><center>
<div id="welcome">
<center>
	Hungry <span id="user"></span><span id="logout">(not me)</span>?
</center>
</div>
<div id='cont_20'>
<center>
	<span id='desc_20'>$20 meals available:</span>
	<span id='note_20'></span>
</center>
</div>
<br>
<div id='cont_10'>
<center>
	<span id='desc_10'>$10 meals available:</span>
	<span id='note_10'></span>
</center>
</div>
</center>
<script>
//Rather than a document.ready function I prefer to put code that runs on load within the body of the webpage.
//Mostly used for even handling
$("#user").html(username);
login(username);
charge(username,"update");
$("#cont_20").click(function() {
	charge(username,"c20");
});
$("#cont_10").click(function() {
	charge(username,"c10");
});
$("#logout").click(function() {
	if (window.confirm("logout?")) {
		deleteCookie("username");
		location.reload();
	}	
});
</script>
</body>
</html>