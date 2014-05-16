//null값이 있는지 없는지 검사
function isNull(obj, msg) {
	if (obj.value == "") {
		alert(msg);
		obj.focus();
		return true;
	} else {
		return false;
	}
}

/*
 * 아이디 검사 문자, 숫자,_를 허용하는 값을 검사
 */

function isId(obj) {
	var data = obj.value;

	if (data.length == 0)
		return false;

	data = data.toUpperCase();

	for (var i = 0; i < data.length; i++) {
		if (!((data.charAt(i) >= "A" && data.charAt(i) <= "Z") || // 한 글자만 뽑는
																// 것
		(data.charAt(i) >= "0" && data.charAt(i) <= "9") || data.charAt(i) == "_")) {
			return false; // 잘못된 문자 검색
		}
	}

	return true;
}
/*
 * 이메일 검사 @, .이있는지 검사
 */
function isEmail(obj) {
	var data = obj.value;

	if (data == "") {
		return false;
	}

	var i = data.indexOf("@");
	if (i < 0) {
		return false;
	}

	var i = data.indexOf(".");
	if (i < 0) {
		return false;
	}

	return true;
}

/*
 * 패스워드와 패스워드 확인 검사
 */
function isSame(obj1, obj2) {
	var val1 = obj1.value;
	var val2 = obj2.value;

	if (val1.length == 0 || val2.length == 0) {
		return false;
	}

	if (val1 == val2) {
		return true;
	}

	return false;
}

/*
 * 패스워드의 길이는 반드시 4글자 이상으로 한다.
 */
function isShort(obj1, obj2) {
	var val1 = obj1.value;
	var val2 = obj2.value;
	
	

	if (val1.length >= 4 || val2.length >= 4) {
		return true;
	}

	return false;
}

/*
 * 패스워드는 문자와 숫자 혼용해서 만들기!
 */

function isAlphaNum(obj1) {
	var val1 = obj1.value;

	v1 = val1.toUpperCase();

	for(var i=0; i<val1.length; i++){
		if(!(v1.charAt(i) >= "A" && v1.charAt(i) <= "Z")) 
				
		for(var j=0; j<val1.length; j++){
		if(!(v1.charAt(j) >= "0" && v1.charAt(j) <= "9"))
			{
			return true;
		}
		}
	}
	return false;
}