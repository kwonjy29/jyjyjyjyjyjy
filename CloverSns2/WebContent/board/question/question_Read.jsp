<%@page import="cloverbean.CloverDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<html>
<head><title>JSPBoard</title>
<link href="question_style.css" rel="stylesheet" type="text/css">
</head>

<body>

<jsp:useBean id="dao" class="cloverbean.CloverDao" />
<%
	int boardUpNo = Integer.parseInt(request.getParameter("boardUpNo"));
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");

	CloverDto dto = dao.getBoard(boardUpNo);
	int UpNo = dto.getBoardUpNo();
	String title = dto.getTitle();
	String id = dto.getId();      
	String boardContent = dto.getBoardContent();
	String uploadDate = dto.getUploadDate();   
	int count = dto.getCount();
	int pos = dto.getPos();
	int depth = dto.getDepth();
	String pw = dto.getPw();
%>

<br><br>
<table align=center width=70% border=0 cellspacing=3 cellpadding=0>
 <tr>
  <td bgcolor=9CA2EE height=25 align=center class=m>글읽기</td>
 </tr>
 <tr>
  <td colspan=2>
   <table border=0 cellpadding=3 cellspacing=0 width=100%> 
    <tr> 
	 <td align=center bgcolor=#dddddd width=10%> 작 성 자 </td>
	 <td bgcolor=#ffffe8><%= id %></td>
	 <td align=center bgcolor=#dddddd width=10%> 작 성 일 </td>
	 <td bgcolor=#ffffe8><%= uploadDate %></td>
	</tr>
    <tr> 
     <td align=center bgcolor=#dddddd> 글 제 목 </td>
     <td bgcolor=#ffffe8 colspan=3><%= title %></td>
   </tr>
   <tr> 
    <td colspan=4><%= boardContent %></td>
   </tr>
   <tr>
    <td colspan=4 align=right>
     조회수 : <%= count %>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td align=center colspan=2> 
	<hr size=1>
	[ <a href="javascript:document.list.submit()">목 록</a> |
	<a href="question_Update.jsp?boardUpNo=<%=boardUpNo%>">수 정</a> |
	<a href="question_reply.jsp?boardUpNo=<%=boardUpNo%>">답 변</a> |
	<a href="question_Delete.jsp?boardUpNo=<%=boardUpNo%>">삭 제</a> ]<br>
  </td>
 </tr>
</table>
	<form name="list" method="post" action="question_List.jsp">
		<input type="hidden" name="keyField" value="<%= keyField %>" />
	 	<input type="hidden" name="keyWord" value="<%= keyWord %>" />
	</form>
</body>
</html>
