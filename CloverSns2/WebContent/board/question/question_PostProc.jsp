<%@ page contentType="text/html; charset=EUC-KR"%>

<jsp:useBean id="dao" class="cloverbean.CloverDao" />
<jsp:useBean id="dto" class="cloverbean.CloverDto" />
<jsp:setProperty property="*" name="dto" />
<%
	request.setCharacterEncoding("euc-kr");
	
	// setter �޼��� 12���� ȣ���ϴ���
	dao.insertQuestion(dto);
	response.sendRedirect("question_List.jsp");
%>