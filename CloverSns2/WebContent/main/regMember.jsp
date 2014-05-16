<%@ page contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />

<title>토끼풀 회원가입</title>

</head>
<script type="text/javascript">

	function isNull(){
		
		var filter = document.memberAdd.pw.value.search(/[^0-9a-zA-Z]/g);
		var fil = document.memberAdd.name.value.search(/[^a-zA-Z]/g);
		
		
		
		if(document.memberAdd.id.value==""){
			alert("아이디를 입력 해주세요.");
			document.memberAdd.id.focus();
		
			return;
		}
		else if(document.memberAdd.id.value.length < 7){
			alert("아이디는 7자 이상 입력해주세요.");
			document.memberAdd.id.focus();
			
			return;
		}
		
		
		
		if(document.memberAdd.pw.value==""){
			alert("비밀번호를 입력 해주세요..");
			document.memberAdd.pw.focus();
			return;
		}
		else if(document.memberAdd.pw.value.length < 8){
			alert("비밀번호는 8자이상 입력하세요");
			return;
		}
		else if(document.memberAdd.pw.value.length >= 8){
			if(document.memberAdd.pw.value != document.memberAdd.pwCheck.value){
				alert("비밀번호가 일치하지 않습니다.");
				document.memberAdd.pw.focus();
				
				return;
			}
		}
		
		
		
		if(filter > -1){
			alert("비밀번호는 문자와 숫자조합만 가능합니다.");
			return;
		}
		else{
			
			var chk_num = pw.value.search(/[0-9]/g); 
			var chk_eng = pw.value.search(/[a-z]/ig); 

			if(chk_num < 0 || chk_eng < 0){ 
				alert("비밀번호는 문자와 숫자조합만 가능합니다.");
				return;
			}
		}

		
		
		if(document.memberAdd.name.value==""){
			alert("이름을 입력 해주세요..");
			document.memberAdd.name.focus();
			
			return;
        }
		/*
		if(fil > -1){
			alert("이름은 문자만 입력 가능합니다.");
			return;
		}
		else{
			var chk_name = name.value.search()
		}
	*/
        
		//생년월일
		
		if(document.memberAdd.email.value==""){
			
			alert("이메일을 입력 해주세요..");
			document.memberAdd.email.focus();
			
			return;
		}
		
		
		else{
			if(document.memberAdd.email.value.indexOf('@')<0){
				alert("E-Mail 형식이 맞지 않습니다.");
				return;
			}
			
			if(document.memberAdd.email.value.indexOf('.')<0){
				alert("E-Mail 형식이 맞지 않습니다.");
				return;
			}
			
		}
		
		
		var gender = document.memberAdd.gender;

		if(gender[0].checked == false && gender[1].checked == false ){
			alert("성별을 선택 해주세요.");
				
			return;
		}
		
		document.memberAdd.submit();

	}
	
</script>
<body>

	<div style="text-align: left; margin-top: 100px; margin-left: 450px; width: 300px; float: left;">
	<h1>회원 가입</h1>
	
	<form method="post" name="memberAdd" action="/CloverSns/member.action" >
		<input type="hidden" name="command" value="MEMCONFIRM" />
		아이디 : <input type="text" name="id" size="10" /><br/><br/>
		비밀 번호 : <input type="password" name="pw" /><br/><br/>
		비밀 번호 확인 : <input type="password" name="pwCheck" /><br/><br/>
		이름 : <input type="text" name="name" /><br/><br/>
		
		생년월일 :
		<select name="year">
			<%	for(int i=2014; i>=1900; i--){ %>
		       <option value="<%=i %>"><%=i %></option>
		       <%} %>
		</select>년&nbsp;
		
		<select name="month">
		    <%for(int i=1; i<=12; i++){ %>
		       <option value="<%=i %>"><%=i %></option>
		       <%} %>
		</select>월&nbsp;
		     
		<select name="day">
		    <%for(int i=1; i<=31; i++){ %>
		       <option value="<%=i %>"><%=i %></option>
		       <%} %>
		</select>일<br/><br/>
		
		이메일 : <input type="text" name="email" /><br/><br/>
		성별 : <input type="radio" name="gender" value="남" />남
				<input type="radio" name="gender" value="여" />여<br/><br/>
			<input type="button" value="회원 가입" onclick= "isNull()" />&nbsp;&nbsp;
			<input type="reset" value="취소" />
	</form>
	</div>

</body>
</html>