<%@page import="cloverbean.CloverDto"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="dao" class="cloverbean.CloverDao" />
<%

	int num = Integer.parseInt(request.getParameter("num"));

%>

<script>

	var del = confirm("���� �����Ͻðڽ��ϱ�?");
	
	if(del == true){
		<%dao.deleteBoard(num);%>
		location.href="notice_List.jsp";
	}
	else{
		history.back();
	}

</script>
