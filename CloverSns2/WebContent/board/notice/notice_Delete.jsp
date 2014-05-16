<%@page import="cloverbean.CloverDto"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="dao" class="cloverbean.CloverDao" />
<%

	int num = Integer.parseInt(request.getParameter("num"));

%>

<script>

	var del = confirm("정말 삭제하시겠습니까?");
	
	if(del == true){
		<%dao.deleteBoard(num);%>
		location.href="notice_List.jsp";
	}
	else{
		history.back();
	}

</script>
