<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.Gallery_BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.Gallery_BoardDAO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/content.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

</script>g
<![endif]-->
<style type="text/css">
.pnt {
 cursor: pointer;
}
</style>
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center" style="margin-top: 20px; margin-left:9px; height: 179px; width: 953px;
background-image: url('../images/banner_3.png');"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="gnotice.jsp">Gallery</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<%
// num 값 가져오기
int num = 0;
try{
	num = Integer.parseInt(request.getParameter("num"));
} catch (NumberFormatException e){
	response.sendRedirect("gnotice.jsp");
}

Gallery_BoardDAO bdao = new Gallery_BoardDAO();
String id = (String)session.getAttribute("id");
// 조회수 1증가 시키기
bdao.updateReadCount(num);
// num 에 해당하는 게시판 글 가져오기 getBoard(num)
Gallery_BoardBean bb = bdao.getBoard(num);

%>
<script>
function contentDelete(){
	//confirm('정말로 삭제하시겠습니까?');
 	var confirmMsg = confirm("정말로 삭제하시겠습니까?");
	if(confirmMsg){
		location.href='gdeleteBoard.jsp?num=<%=num%>';	
	}
}
function commentDelete(c_num){
	//confirm('정말로 삭제하시겠습니까?');
 	var confirmMsg = confirm("정말로 삭제하시겠습니까?");
	if(confirmMsg){
		location.href='../comment/delete.jsp?c_num=' + c_num + '&num=<%=num%>';	
	}
}
</script>
<!-- 게시판 -->
<article>
<h1>Gallery</h1>
<div id="table_search">
<input type="button" value="글목록" class="btn" onclick="location.href='gnotice.jsp'">
</div>
<%
// 로그인을 했고 
if(id != null){
	// 글쓴이와 동일인이면
	if(id.equals(bb.getId())){
%>
<div id="table_search">
<input type="button" value="수정하기" class="btn" onclick="location.href='gupdateBoardForm.jsp?num=<%=num%>'">
<input type="button" value="삭제하기" class="btn" onclick="contentDelete()">
</div>	
<%
	}
}
%>
<table id="notice">
	<tr><td class="bcolor">글번호</td><td><%=bb.getNum() %></td>
		<td class="bcolor">조회수</td><td><%=bb.getReadcount() %></td>
		<td class="bcolor">작성자</td><td><%=bb.getId() %></td>
		<td class="bcolor">작성일</td><td><%=bdao.compareDate(bb) %></td></tr>
	<tr><td class="bcolor">글제목</td><td colspan="7"><%=bb.getSubject() %></td></tr>
	<tr>
		<td class="bcolor">첨부파일</td>
		<td colspan="7"><%if(bb.getFile() != null){ %>
						<a href="file_down.jsp?file_name=<%=bb.getFile() %>"><%=bb.getFile() %></a><%} %></td></tr>
	<tr>
		<td class="bcolor">글내용</td>
		<td colspan="7" style="width: 500px; height: 300px;" class="tcontent">
			<%if(bb.getFile() != null){ %><img src="../upload/<%=bb.getFile() %>" width="500px"><%} %><br>
			<%=bb.getContent() %></td>
	</tr>
</table>
<div class="clear"></div>
<div id="page_control">
</div>
</article>
<article>
<form id="cmtForm" action="../comment/comment.jsp">
	<h4>댓글 쓰기</h4>
	<input type="hidden" name="num" value="<%=num%>"> 
	 <%if(id == null) {
		 %>
		 <a href="../member/login.jsp?num=<%=num%>" style="cursor:pointer">
		 	<textarea name="content" rows="4" cols="80" readonly="readonly">댓글을 작성하려면 로그인 해주세요. 클릭시 로그인 페이지로 이동합니다.</textarea>
		 </a>
		 <%
	 }else {%>
		<textarea name="content" rows="4" cols="80"></textarea>
	<%}%>
	<input type="submit" value="등록" style="float: right">
</form>
<br><br>
<%
//한 화면에 보여줄 글 개수 15개 설정
int pageSize = 5;
//페이지 번호 가져와서 변수에 저장
String pageNum = request.getParameter("pageNum");
//페이지 번호가 없으면 1로 설정
if(pageNum == null){
 pageNum = "1";
}
//페이지 번호 => 정수형으로 변경
int currentPage = Integer.parseInt(pageNum);
//한페이지에서 시작하는 행 번호 구하기
//1페이지면 1-10 / 2페이지면 11-20
int startRow = 1;
CommentDAO cdao = new CommentDAO();
// 댓글 수 가져오기
List list = null;
int count = cdao.getCommentCount(num);
int size = currentPage * pageSize;

if(count != 0){
	list = cdao.getCommentList(num, startRow, size);
}
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
%>
<%
if(list != null){
	for(int i = 0; i < list.size(); i++){
		CommentBean cb = (CommentBean)list.get(i);
%>
<table id="comment">
	<tr><th><%=cb.getId() %></th>
	<%if(id != null){
		if(id.equals(cb.getId())){ %>
	    <td><a style=" color:#333; text-decoration: none;"
	     href="../comment/updateForm.jsp?c_num=<%=cb.getC_num()%>&num=<%=num%>#cmtForm">수정</a>&nbsp;&nbsp;
	    <a style="color:#333; text-decoration: none; cursor:pointer;"  onclick="commentDelete(<%=cb.getC_num()%>)">삭제</a></td></tr>
	<%}
	} %>
	<tr><td><small><%=sdf.format(cb.getDate()) %></small></td></tr>
	<tr><td colspan="7"><%=cb.getContent() %></td></tr>
</table>
<hr>
<%
	}
}
if(size < count){
%>
<div><a href="gcontent.jsp?num=<%=num %>&pageNum=<%=currentPage+1%>#cmtForm">더보기</a></div>
<%} %>
<div><a class="top" href="gcontent.jsp?num=<%=num %>&pageNum=<%=currentPage%>#">top</a></div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>