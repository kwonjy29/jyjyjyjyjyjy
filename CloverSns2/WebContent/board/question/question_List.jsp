<%@page import="java.math.RoundingMode"%>
<%@page import="cloverbean.CloverDto"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=euc-kr" %>
<%request.setCharacterEncoding("euc-kr");%>
<HTML>
<link href="question_style.css" rel="stylesheet" type="text/css">
<script>
	function check(){
		if(document.search.keyWord.value == ""){
			alert("�˻�� �Է��ϼ���.");
			document.search.keyWord.focus();
			return;
		}
		document.search.submit();
	}

	function list(){
		document.list.action="question_List.jsp";
		document.list.submit();
	}
	
	function read(param){
		document.read.boardUpNo.value=param;
		document.read.submit();
	}
</script>
<center>
<BODY>

<h2>���� �Խ���</h2>
<jsp:useBean id="dao" class="cloverbean.CloverDao" />
<%!
	public String getParam(HttpServletRequest req, String pName){
		if(req.getParameter("keyWord") != null){
			return req.getParameter("keyWord");
		}
		else
			return "";
	}
	// paging�� �ʿ��� ����
	int totalRecord = 0; // ��ü ���� ����
	int numPerPage = 5; // �� �������� ������ ���� ����
	int pagePerBlock = 3; // �� ���� ������ ��
	int totalPage = 0; // ��ü ������ ��
	int totalBlock = 0; // ��ü �� ��
	int nowPage = 0; // ���� ������ ��ȣ
	int nowBlock = 0; // ���� �� ��ȣ
	int beginPerPage = 0; // �������� ���� ��ȣ
%>

<%
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");

	if(keyField == null)
		keyField = "name";
	
	if(request.getParameter("reload") != null){
		if(request.getParameter("reload").equals("true")){
			keyWord = "";
		}
	}

	Vector list = dao.getBoardList(keyField, keyWord);
	
	totalRecord = list.size();
	totalPage = (int)(Math.ceil((double)totalRecord/numPerPage));
	
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	if(request.getParameter("nowBlock") != null){
		nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	}
	
	beginPerPage = nowPage * numPerPage;
	totalBlock = (int)(Math.ceil((double)totalPage/pagePerBlock));

%>
<table align=center border=0 width=80%>
<tr>
	<td align=left>Total :  <%=list.size()%> Articles(
		<font color=red>  <%= nowPage+1 %> / <%= totalPage %> Pages </font>)
	</td>
</tr>
</table>

<form method="post" action="question_selectDeleteproc.jsp" name="select" />
<table align=center width=80% border=0 cellspacing=0 cellpadding=3>
<tr>
	<td align=center colspan=2>
		<table border=0 width=100% cellpadding=2 cellspacing=0>
			<tr align=center bgcolor=#D0D0D0 height=120%>
				<td width="10%"> ��ȣ </td>
				<td widht="40%"> ���� </td>
				<td width="20%"> �̸� </td>
				<td width="20%"> ��¥ </td>
				<td width="10%"> ��ȸ�� </td>
			</tr>		
			
			<% if(list.isEmpty()){ %>
					<b>��ϵ� ���� �����ϴ�.</b>
			<%
				}
				else{
					for(int i=beginPerPage; i<beginPerPage+numPerPage; i++){
						if(i == totalRecord){
							break;
						}
						CloverDto dto = (CloverDto)list.get(i);
			%>
			
			<tr align="center">
				<td><%=dto.getBoardUpNo()%></td>
				<td align="left"><%=dao.useDepth(dto.getDepth())%>
				<% if(dto.getDepth() > 0){ %>
						<img alt="" src="../image/re.gif">
				<% } %><a href="javascript:read('<%= dto.getBoardUpNo() %>')"><%= dto.getTitle() %></td>
				<td><%=dto.getId() %></td>
				<td><%=dto.getUploadDate()%></td>
				<td><%=dto.getCount()%></td>
			</tr>
			
			<%
					}
				}
			%>
			
		</table>
	</td>
</tr>
<tr><td></td></tr>
<tr>
		<td align="left">Go to Page&nbsp;
		<% if(nowBlock > 0){ %>
			<a href="question_List.jsp?nowBlock=<%=nowBlock-1%>&nowPage=<%=pagePerBlock*(nowBlock-1)%>">
			����<%=pagePerBlock%>��</a>
			&nbsp;&nbsp;:::
		<% }
				for(int i=0; i<pagePerBlock; i++){
					if((nowBlock*pagePerBlock) + i == totalPage){
						break;
					}
			%>
					<a href="question_List.jsp?nowBlock=<%=nowBlock%>&nowPage=<%=(nowBlock*pagePerBlock) + i%>">
					<%= (nowBlock*pagePerBlock) + i + 1 %></a>&nbsp;
			<%		 
				}
			%>
			<% if(totalBlock > nowBlock+1){ %>
				&nbsp;&nbsp;:::
				<a href="question_List.jsp?nowBlock=<%=nowBlock+1%>&nowPage=<%=pagePerBlock*(nowBlock+1)%>">
				����<%=pagePerBlock%>��</a></td>
			<% } %>
		
		<td align="right">
			<a href="question_Post.jsp">[�۾���]</a>
			<a href="javascript:list()">[ó������]</a>
		</td>
	</tr>
</table>
</form>
<BR>
<form action="question_List.jsp" name="search" method="post">
	<table border=0 width=527 align=center cellpadding=4 cellspacing=0>
	<tr>
		<td align=center valign=bottom>
			<select name="keyField" size="1">
				<option value="id" /> �̸�
				<option value="title" /> ����
				<option value="boardContent" /> ����
			</select>


			<input type="text" size="16" name="keyWord" value='<%= getParam(request, "keyWord") %>' />
			<input type="button" value="ã��" onClick="check()" />
			<input type="hidden" name="page" value= "0" />
		</td>
	</tr>
	</table>
</form>
<form name="list" method="post">
	<input type="hidden" name="reload" value="true" />
</form>

<form name="read" method="post" action="question_Read.jsp">
	 <input type="hidden" name="boardUpNo" />
	 <input type="hidden" name="keyField" value="<%= keyField %>" />
	 <input type="hidden" name="keyWord" value="<%= keyWord %>" />
</form>	

</center>
</BODY>
</HTML>
