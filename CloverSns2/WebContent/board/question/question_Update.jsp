<%@page import="cloverbean.CloverDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="dao" class="cloverbean.CloverDao" />
<%
	int num = Integer.parseInt(request.getParameter("boardUpNo"));

	CloverDto dto = dao.getBoard(num);
%>
<html>
<head> <title>JSPBoard</title>
<link href="question_style.css" rel="stylesheet" type="text/css">
<script>
	function check() {
	   if (document.form.pw.value == "") {
		 alert("수정을 위해 패스워드를 입력하세요.");
	     form.pw.focus();
		 return false;
		 }
	   
	  <%--  
	   var pw1 = "<%= dto.getPass() %>";
	   var pw2 = document.form.pass.value;
	   
	   if(pw1 != pw2){
		   alert("패스워드가 맞지 않습니다.");
		   return false;
	   } 
	  --%>
	  // 여기서 검사하면 패스워드 다 노출됨. 보안상의 문제로 서버에서 검사하기로 함.!
	   document.form.submit();
	}
</script>
</head>
<body>
<center>
<br><br>
<table width=460 cellspacing=0 cellpadding=3>
  <tr>
   <td bgcolor=#FF9018  height=21 align=center class=m>수정하기</td>
  </tr>
</table>


<form name="form" method="post" action="question_UpdateProc.jsp" >
<input type="hidden" name="boardUpNo" value="<%= dto.getBoardUpNo() %>" />
<table width=70% cellspacing=0 cellpadding=7>
 <tr>
  <td align=center>
   <table border=0>
    <tr>
     <td width=20%>성 명</td>
     <td width=80%>
	  <input type="text" name="id" size="30" maxlength="20" value="<%= dto.getId() %>">
	 </td>
	</tr>
	<tr>
     <td width=20%>제 목</td>
     <td width=80%>
	  <input type="text" name="title" size="50" maxlength="50" value="<%= dto.getTitle() %>">
	 </td>
    <tr>
     <td width=20%>내 용</td>
     <td width=80%>
	  <textarea name="boardContent" rows="10" cols="50"><%= dto.getBoardContent() %></textarea>
	 </td>
    </tr>
	<tr>
     <td width=20%>비밀 번호</td> 
     <td width=80%><input type="password" name="pw" size="15" maxlength="15">
      수정시에는 비밀번호가 필요합니다.</td>
    </tr>
	<tr>
     <td colspan=2 height=5><hr size=1></td>
    </tr>
	<tr>
     <td colspan=2>
	  <input type="Button" value="수정완료" onClick="check()">
      <input type="reset" value="다시수정"> 
      <input type="button" value="뒤로" onClick="history.back()">
	 </td>
    </tr> 
   </table>
  </td>
 </tr>
</table>
</form> 
</center>
</body>
</html>
