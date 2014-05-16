<%@ page contentType="text/html; charset=EUC-KR"%>
<% request.setCharacterEncoding("euc-kr"); %>

<jsp:useBean id="dao" class="cloverbean.CloverDao" />
<jsp:useBean id="dto" class="cloverbean.CloverDto" />
<jsp:setProperty property="*" name="dto" />

<%
	int num = Integer.parseInt(request.getParameter("num"));
	dto = dao.getBoard(num);
%>