<%@page import="cloverbean.CloverDto"%>
<%@page import="cloverbean.CloverDao"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="dao" class="cloverbean.CloverDao" />
<jsp:useBean id="dto" class="cloverbean.CloverDto" />
<jsp:setProperty property="*" name="dto" />

<%
	int num = Integer.parseInt(request.getParameter("boardUpNo"));

CloverDto parent = dao.getBoard(num);
	dao.replyUpdatePos(parent);
	
	dto.setPos(parent.getPos());
	dto.setDepth(parent.getDepth());
	dao.replyBoard(dto);
	
	
	response.sendRedirect("question_List.jsp");
%>