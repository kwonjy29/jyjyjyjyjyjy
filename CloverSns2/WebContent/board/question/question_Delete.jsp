<%@page import="cloverbean.CloverDto"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="dao" class="cloverbean.CloverDao" />
<%
	int boardUpNo = Integer.parseInt(request.getParameter("boardUpNo"));
	String pass1 = request.getParameter("pw");
	CloverDto dto = dao.getBoard(boardUpNo);
	
	if(pass1 != null){
		if(pass1.equals(dto.getPw())){
			dao.deleteBoard(boardUpNo);
			response.sendRedirect("question_List.jsp");
		}
		else{
%>
			<script>
				alert("�н����尡 Ʋ���ϴ�.");
				history.back();
			</script>
<%
		}
	}
%>

<html>
<head><title>JSPBoard</title>
<link href="question_style.css" rel="stylesheet" type="text/css">
<script>
	function check() {
		if (document.form.pw.value == "") {
		alert("�н����带 �Է��ϼ���.");
		form.pw.focus();
		return false;
		}
		document.form.submit();
	}
</script>
</head>
<body>
<center>
<br><br>
<table width=50% cellspacing=0 cellpadding=3>
 <tr>
  <td bgcolor=#dddddd height=21 align=center>
      ������� ��й�ȣ�� �Է��� �ּ���.</td>
 </tr>
</table>
<table width=70% cellspacing=0 cellpadding=2>
<form name=form method=post action="question_Delete.jsp" >
<input type="hidden" name="boardUpNo" value="<%= boardUpNo %>" />
 <tr>
  <td align=center>
   <table align=center border=0 width=91%>
    <tr> 
     <td align=center>  
	  <input type=password name="pw" size=17 maxlength=15>
	 </td> 
    </tr>
    <tr>
     <td><hr size=1 color=#eeeeee></td>
    </tr>
    <tr>
     <td align=center>
	  <input type=button value="�����Ϸ�" onClick="check()"> 
      <input type=reset value="�ٽþ���"> 
      <input type=button value="�ڷ�" onClick="history.back()">
	 </td>
    </tr> 
   </table>
  </td>
 </tr>
</form> 
</table>
</center>
</body>
</html>
