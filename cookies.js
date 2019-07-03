//Used to store the user information to avoid logging in all the time
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}
//general getCookie function but used to retrieve username
function getCookie(cname) { //cname = cookie name
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}
//check if the only cookie we care about exists, if it does not then prompt for user input
function checkCookie() {
    var user = getCookie("username");
    if (user == "") {
        user = prompt("Please enter your username:", "");
        if (user != "" && user != null) {
            setCookie("username", replaceChar(user), 7);
        }
    }
}
//When we need to 'sign out'
function deleteCookie(cname) {
	var d = new Date();
	d.setTime(d.getTime() - (1000));
	var expires = "expires="+d.toUTCString();
	document.cookie = cname + "=default;" + expires + ";path=/";
}
//remove invalid characters from user input
function replaceChar(string) {
	var result = string.replace(/["'()|\W]/g,"");
	return result;	
}