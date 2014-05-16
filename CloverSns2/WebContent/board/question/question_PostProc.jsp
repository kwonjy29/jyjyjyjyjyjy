<%@ page contentType="text/html; charset=EUC-KR"%>

<jsp:useBean id="dao" class="cloverbean.CloverDao" />
<jsp:useBean id="dto" class="cloverbean.CloverDto" />
<jsp:setProperty property="*" name="dto" />
<%
	request.setCharacterEncoding("euc-kr");
	
	// setter 메서드 12개를 호출하던가
	dao.insertQuestion(dto);
	response.sendRedirect("question_List.jsp");
%>