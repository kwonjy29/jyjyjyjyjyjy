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
			alert("검색어를 입력하세요.");
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

<h2>문의 게시판</h2>
<jsp:useBean id="dao" class="cloverbean.CloverDao" />
<%!
	public String getParam(HttpServletRequest req, String pName){
		if(req.getParameter("keyWord") != null){
			return req.getParameter("keyWord");
		}
		else
			return "";
	}
	// paging에 필요한 변수
	int totalRecord = 0; // 전체 글의 갯수
	int numPerPage = 5; // 한 페이지당 보여질 글의 갯수
	int pagePerBlock = 3; // 한 블럭당 페이지 수
	int totalPage = 0; // 전체 페이지 수
	int totalBlock = 0; // 전체 블럭 수
	int nowPage = 0; // 현재 페이지 번호
	int nowBlock = 0; // 현재 블럭 번호
	int beginPerPage = 0; // 페이지당 시작 번호
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
				<td width="10%"> 번호 </td>
				<td widht="40%"> 제목 </td>
				<td width="20%"> 이름 </td>
				<td width="20%"> 날짜 </td>
				<td width="10%"> 조회수 </td>
			</tr>		
			
			<% if(list.isEmpty()){ %>
					<b>등록된 글이 없습니다.</b>
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
			이전<%=pagePerBlock%>개</a>
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
				다음<%=pagePerBlock%>개</a></td>
			<% } %>
		
		<td align="right">
			<a href="question_Post.jsp">[글쓰기]</a>
			<a href="javascript:list()">[처음으로]</a>
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
				<option value="id" /> 이름
				<option value="title" /> 제목
				<option value="boardContent" /> 내용
			</select>


			<input type="text" size="16" name="keyWord" value='<%= getParam(request, "keyWord") %>' />
			<input type="button" value="찾기" onClick="check()" />
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
