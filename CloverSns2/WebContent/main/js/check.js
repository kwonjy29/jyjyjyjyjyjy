//null���� �ִ��� ������ �˻�
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
 * ���̵� �˻� ����, ����,_�� ����ϴ� ���� �˻�
 */

function isId(obj) {
	var data = obj.value;

	if (data.length == 0)
		return false;

	data = data.toUpperCase();

	for (var i = 0; i < data.length; i++) {
		if (!((data.charAt(i) >= "A" && data.charAt(i) <= "Z") || // �� ���ڸ� �̴�
																// ��
		(data.charAt(i) >= "0" && data.charAt(i) <= "9") || data.charAt(i) == "_")) {
			return false; // �߸��� ���� �˻�
		}
	}

	return true;
}
/*
 * �̸��� �˻� @, .���ִ��� �˻�
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
 * �н������ �н����� Ȯ�� �˻�
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
 * �н������� ���̴� �ݵ�� 4���� �̻����� �Ѵ�.
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
 * �н������ ���ڿ� ���� ȥ���ؼ� �����!
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