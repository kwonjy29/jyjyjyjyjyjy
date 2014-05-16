<%@page import="cloverbean.CloverDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<html>
<head><title>JSPBoard</title>
<link href="notice_style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function fnDelete(param){
		var del = confirm("정말 삭제하시겠습니까?");
		
		if(del == true){
			document.del.num.value = param;
			document.del.submit();
		}
		else{
			return;
		}
	}
</script>
</head>

<body>

<jsp:useBean id="dao" class="cloverbean.CloverDao" />

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");

	CloverDto dto = dao.getBoard(num);
	
	String id = dto.getId();
	String title = dto.getTitle();
	String content = dto.getBoardContent().replace("\n", "<br/>");
	int count = dto.getCount();
	String uploaddate = dto.getUploadDate();
	
%>

<br><br>
<table align=center width=70% border=0 cellspacing=3 cellpadding=0>
 <tr>
  <td bgcolor=9CA2EE height=25 align=center class=m><%= title %></td>
 </tr>
 <tr>
  <td colspan=2>
   <table border=0 cellpadding=3 cellspacing=0 width=100%> 

    <tr>
		 <td align=center bgcolor=#dddddd width=10%> 등록날짜 </td>
		 <td bgcolor=#ffffe8><%= uploaddate %></td>
	</tr>

   <tr> 
    <td colspan=4><%= content %></td>
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
	<a href="notice_Update.jsp?num=<%=num%>">수 정</a> |
	<a href="notice_Delete.jsp?num=<%=num%>">삭 제</a> ]<br>
  </td>
 </tr>
</table>

<form name="list" method="post" action="notice_List.jsp">
	<input type="hidden" name="keyField" value="<%= keyField %>" />
	<input type="hidden" name="keyWord" value="<%= keyWord %>" />
</form>

</body>
</html>
