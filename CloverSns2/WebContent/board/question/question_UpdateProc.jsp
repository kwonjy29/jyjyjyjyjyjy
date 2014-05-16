<%@page import="cloverbean.CloverDao"%>
<%@page import="cloverbean.CloverDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	int num = Integer.parseInt(request.getParameter("boardUpNo"));
	
	String pass1 = request.getParameter("pw");
	CloverDao dao = new CloverDao();
	CloverDto dto = dao.getBoard(num);
	
	if(pass1.equals(dto.getPw())){
		CloverDto dto2 = new CloverDto();
		dto2.setId(request.getParameter("id"));
		dto2.setTitle(request.getParameter("title"));
		dto2.setBoardContent(request.getParameter("boardContent"));
		dto2.setBoardUpNo(num);
		
		dao.updateBoard(dto2);
		response.sendRedirect("question_List.jsp");
	}
	else{
%>
	<script>
		alert("패스워드가 맞지 않습니다.");
		history.back();
	</script>
<%
	}
%>