<%@ page contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" />

<title>�䳢Ǯ ȸ������</title>

</head>
<script type="text/javascript">

	function isNull(){
		
		var filter = document.memberAdd.pw.value.search(/[^0-9a-zA-Z]/g);
		var fil = document.memberAdd.name.value.search(/[^a-zA-Z]/g);
		
		
		
		if(document.memberAdd.id.value==""){
			alert("���̵� �Է� ���ּ���.");
			document.memberAdd.id.focus();
		
			return;
		}
		else if(document.memberAdd.id.value.length < 7){
			alert("���̵�� 7�� �̻� �Է����ּ���.");
			document.memberAdd.id.focus();
			
			return;
		}
		
		
		
		if(document.memberAdd.pw.value==""){
			alert("��й�ȣ�� �Է� ���ּ���..");
			document.memberAdd.pw.focus();
			return;
		}
		else if(document.memberAdd.pw.value.length < 8){
			alert("��й�ȣ�� 8���̻� �Է��ϼ���");
			return;
		}
		else if(document.memberAdd.pw.value.length >= 8){
			if(document.memberAdd.pw.value != document.memberAdd.pwCheck.value){
				alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
				document.memberAdd.pw.focus();
				
				return;
			}
		}
		
		
		
		if(filter > -1){
			alert("��й�ȣ�� ���ڿ� �������ո� �����մϴ�.");
			return;
		}
		else{
			
			var chk_num = pw.value.search(/[0-9]/g); 
			var chk_eng = pw.value.search(/[a-z]/ig); 

			if(chk_num < 0 || chk_eng < 0){ 
				alert("��й�ȣ�� ���ڿ� �������ո� �����մϴ�.");
				return;
			}
		}

		
		
		if(document.memberAdd.name.value==""){
			alert("�̸��� �Է� ���ּ���..");
			document.memberAdd.name.focus();
			
			return;
        }
		/*
		if(fil > -1){
			alert("�̸��� ���ڸ� �Է� �����մϴ�.");
			return;
		}
		else{
			var chk_name = name.value.search()
		}
	*/
        
		//�������
		
		if(document.memberAdd.email.value==""){
			
			alert("�̸����� �Է� ���ּ���..");
			document.memberAdd.email.focus();
			
			return;
		}
		
		
		else{
			if(document.memberAdd.email.value.indexOf('@')<0){
				alert("E-Mail ������ ���� �ʽ��ϴ�.");
				return;
			}
			
			if(document.memberAdd.email.value.indexOf('.')<0){
				alert("E-Mail ������ ���� �ʽ��ϴ�.");
				return;
			}
			
		}
		
		
		var gender = document.memberAdd.gender;

		if(gender[0].checked == false && gender[1].checked == false ){
			alert("������ ���� ���ּ���.");
				
			return;
		}
		
		document.memberAdd.submit();

	}
	
</script>
<body>

	<div style="text-align: left; margin-top: 100px; margin-left: 450px; width: 300px; float: left;">
	<h1>ȸ�� ����</h1>
	
	<form method="post" name="memberAdd" action="/CloverSns/member.action" >
		<input type="hidden" name="command" value="MEMCONFIRM" />
		���̵� : <input type="text" name="id" size="10" /><br/><br/>
		��� ��ȣ : <input type="password" name="pw" /><br/><br/>
		��� ��ȣ Ȯ�� : <input type="password" name="pwCheck" /><br/><br/>
		�̸� : <input type="text" name="name" /><br/><br/>
		
		������� :
		<select name="year">
			<%	for(int i=2014; i>=1900; i--){ %>
		       <option value="<%=i %>"><%=i %></option>
		       <%} %>
		</select>��&nbsp;
		
		<select name="month">
		    <%for(int i=1; i<=12; i++){ %>
		       <option value="<%=i %>"><%=i %></option>
		       <%} %>
		</select>��&nbsp;
		     
		<select name="day">
		    <%for(int i=1; i<=31; i++){ %>
		       <option value="<%=i %>"><%=i %></option>
		       <%} %>
		</select>��<br/><br/>
		
		�̸��� : <input type="text" name="email" /><br/><br/>
		���� : <input type="radio" name="gender" value="��" />��
				<input type="radio" name="gender" value="��" />��<br/><br/>
			<input type="button" value="ȸ�� ����" onclick= "isNull()" />&nbsp;&nbsp;
			<input type="reset" value="���" />
	</form>
	</div>

</body>
</html>