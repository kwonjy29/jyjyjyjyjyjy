<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="dao" class="cloverbean.CloverDao" />
<%

   String check1[] = request.getParameterValues("checkbox");
   int check2[] = new int[check1.length];

   for(int i=0; i<check1.length; i++){
      check2[i] = Integer.parseInt(check1[i]);
      dao.deleteBoard(check2[i]);
   }
   
   response.sendRedirect("question_List.jsp");
   
%>