<%@page import="cloverbean.CloverDto"%>
<%@page import="cloverbean.CloverDao"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=euc-kr" %>
<HTML>
<link href="notice_style.css" rel="stylesheet" type="text/css">
<script>
	function check(){
		if(document.search.keyWord.value == ""){
			alert("검색어 없음.");
			document.search.keyWord.focus();
			return;
		}
		document.search.submit();
	}
	
	function list(){
		document.list.action="notice_List.jsp";
		document.list.submit();
	}
	
	function read(param){
		document.read.num.value=param;
		document.read.submit();
	}
</script>
<BODY>

<center>
<h2>공지사항</h2>

<jsp:useBean id="dao" class="cloverbean.CloverDao" />

<%!
	public String getParam(HttpServletRequest req, String pName){
		if(req.getParameter("keyWord") != null){
			return req.getParameter("keyWord");
		}
		else{
			return "";
		}
			
	}

	// 페이징에 필요한 변수를 선언부에 선언
	int totalRecord = 0;		// 전체 글의 갯수
	int numPerPage = 15;			// 한 페이지당 보여질 글의 갯수
	int pagePerBlock = 5;		// 한 블럭당 보여질 페이지 수
	int totalPage = 0;			// 전체 페이지 수
	int totalBlock = 0;			// 전체 블럭 수
	int nowPage = 0;			// 현재 페이지 번호
	int nowBlock = 0;			// 현재 블럭 번호
	int beginPerPage = 0;		// 한 페이지당 시작 번호 (페이지당 시작 번호부터 시작해서 몇개의 글을 뿌릴것인지 정할 수 있다.)
%>

<%
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	if(keyField == null){
		keyField = "";
	}
	
	if(request.getParameter("reload") != null){
		if(request.getParameter("reload").equals("true")){
			keyWord="";
		}
	}
	
	if(keyWord==null){
		keyWord="";
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
	
	beginPerPage = numPerPage * nowPage;
	
	totalBlock = (int)(Math.ceil((double)totalPage/pagePerBlock));
	
%>

<table align=center border=0 width=80%>
<tr>
	<td align=left><b>전체 페이지 수</b> &nbsp; <%= totalPage %> &nbsp;&nbsp;&nbsp; <b>전체 게시물 수</b> &nbsp; <%= totalRecord %>
		<font color=red>   </font>
	</td>
</tr>
</table>

<table align=center width=80% border=0 cellspacing=0 cellpadding=3>
	<tr>
		<td align=center colspan=2>
			<table border=0 width=100% cellpadding=2 cellspacing=0>
				<tr align=center bgcolor=#D0D0D0 height=120%>
					<td> 번호 </td>
					<td> 제목 </td>
					<td> 날짜 </td>
					<td> 조회수 </td>
				</tr>
	
		</td>
	</tr>
	
<%
	if(list.isEmpty()){
%>
	<b>등록된 글이 없습니다.</b>
<%		
	}
	else{
		for(int i=beginPerPage; i<(beginPerPage + numPerPage); i++){
			if(i == totalRecord){
				break;
			}
			
			CloverDto dto = (CloverDto)list.get(i);
			
%>

	<tr align="center">
		
		<td><%= dto.getBoardUpNo() %></td>
		<td><a href="javascript:read('<%=dto.getBoardUpNo()%>')"><%= dto.getTitle() %></a></td>
		<td><%= dto.getUploadDate() %></td>
		<td><%=dto.getCount() %></td>
	</tr>
	
<%
		}
	}
%>
	</table>
<tr>
	<td></td>
</tr>

	<tr>
		<td align="left">Go to Page&nbsp;
		<% if(nowBlock > 0){ %>
			<a href="notice_List.jsp?nowBlock=<%=nowBlock-1%>&nowPage=<%=pagePerBlock*(nowBlock-1)%>">
			이전<%=pagePerBlock%>개</a>
			&nbsp;&nbsp;:::
		<% }
				for(int i=0; i<pagePerBlock; i++){
					if((nowBlock*pagePerBlock) + i == totalPage){
						break;
					}
			%>
					<a href="notice_List.jsp?nowBlock=<%=nowBlock%>&nowPage=<%=(nowBlock*pagePerBlock) + i%>">
					<%= (nowBlock*pagePerBlock) + i + 1 %></a>&nbsp;
			<%		 
				}
			%>
			<% if(totalBlock > nowBlock+1){ %>
				&nbsp;&nbsp;:::
				<a href="notice_List.jsp?nowBlock=<%=nowBlock+1%>&nowPage=<%=pagePerBlock*(nowBlock+1)%>">
				다음<%=pagePerBlock%>개</a></td>
			<% } %>
		<form method="post" action="/CloverSns/sns.action" name="sns">
		<input type="hidden" name="com"  />
		<td align="right">
			<a href="notice_Post.jsp">[글쓰기]</a>
			<a href="javascript:list()">[처음으로]</a>
		</td>
		</form>
	</tr>
	</table>
	
	<BR>
	<form action="notice_List.jsp" name="search" method="post">
	<table border=0 width=527 align=center cellpadding=4 cellspacing=0>
	<tr>
		<td align=center valign=bottom>
			<select name="keyField" size="1">
				<option value="subject"	<%if(keyField.equals("subject")){%>	selected <%}%>> 제목 </option>
				<option value="content" <%if(keyField.equals("content")){%>	selected <%}%>> 내용 </option>
			</select>

			<input type="text" size="16" name="keyWord" value='<%= getParam(request, "keyWord") %>'>
			<input type="button" value="찾기" onClick="check()">
			<input type="hidden" name="page" value= "0">
		</td>
	</tr>
	</table>
</form>

<form name="list" method="post" >
	<input type="hidden" name="reload" value="true" />
</form>

<form name="read" method="post" action="notice_Read.jsp">
	<input type="hidden" name="num" />
	<input type="hidden" name="keyField" value="<%= keyField %>" />
	<input type="hidden" name="keyWord" value="<%= keyWord %>" />
</form>
</center>

</BODY>
</HTML>