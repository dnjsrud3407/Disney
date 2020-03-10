<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
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
<jsp:include page="../inc/sub_menu_center.jsp"></jsp:include>
<!-- 왼쪽메뉴 -->
<%
request.setCharacterEncoding("utf-8");
// search 파라미터 가져오기
String search = request.getParameter("search"); 
BoardDAO bdao = new BoardDAO();

// 검색어에 해당되는 글 개수 가져오기
int count  = bdao.getBoardCount(search);
// 한 화면에 보여줄 글 개수 15개 설정
int pageSize = 10;
// 페이지 번호 가져와서 변수에 저장
String pageNum = request.getParameter("pageNum");
// 페이지 번호가 없으면 1로 설정
if(pageNum == null){
	pageNum = "1";
}
// 페이지 번호 => 정수형으로 변경
int currentPage = Integer.parseInt(pageNum);
// 한페이지에서 시작하는 행 번호 구하기
// 1페이지면 1-10 / 2페이지면 11-20
int startRow = (currentPage-1)*pageSize+1;
// 게시판에 글이 있으면
List list = null;
if(count != 0){
// 리턴할형 List getBoardList(시작하는 행번호, 글개수, 검색어)
	list = bdao.getBoardList(startRow, pageSize, search);
}
// 날짜 모양 설정 => 문자열 출력
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd"); 
%>
<!-- 게시판 -->
<article>
<h1>Notice</h1>
<table id="notice">
	<tr><th class="tno">No.</th>
	    <th class="ttitle">Title</th>
	    <th class="twrite">Writer</th>
	    <th class="tdate">Date</th>
	    <th class="tread">Read</th>
	</tr>
<%
for(int i = 0; i < list.size(); i++){
	BoardBean bb = (BoardBean)list.get(i);
%>	
	<!-- 행전체에 하이퍼링크가 걸려있다 -->
	<tr onclick="location.href='content.jsp?num=<%=bb.getNum()%>'">
		<td><%=bb.getNum() %></td><td class="left"><%=bb.getSubject() %></td>
	    <td><%=bb.getId() %></td><td width="80px;"><%=bdao.compareDate(bb) %><td><%=bb.getReadcount() %></td>
	</tr>
<%
}
%>
</table>
<%
// 로그인해야지 글쓰기 버튼 생김
if(session.getAttribute("id") != null){
%>
<div id="table_search">
<input type="button" value="글쓰기" class="btn" onclick="location.href='writeBoardForm.jsp'">
</div>
<%
}
%>
<div id="table_search">
<form action="noticeSearch.jsp" method="post">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>
<div class="clear"></div>
<%
//전체 페이지 개수 구하기
//전체 글 개수 50개, 한 화면에 보여줄 글 개수 10개 -> 총 5페이지
//전체 글 개수 59개, 한 화면에 보여줄 글 개수 10개 -> 총 6페이지 (10으로 나눠서 나머지가 있느냐)
int pageCount = count / pageSize + (count % pageSize == 0? 0 : 1);
int pageBlock = 2;
//한 화면에 보여줄 시작페이지 구하기 - 1~10이라면 1 / 11~20이라면 11
//현제 페이지 번호가 1~10 이고 pageBlock이 10 일 경우 시작페이지 => 1
//현제 페이지 번호가 11~20 이고 pageBlock이 10 일 경우 시작페이지 => 11
int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
int endPage = startPage + pageBlock - 1;
if(endPage > pageCount){
	endPage = pageCount;
}
%>
<div id="page_control">
<%
if(startPage > pageBlock){
%>
<a href="noticeSearch.jsp?pageNum=<%=startPage - pageBlock%>&search=<%=search%>">Prev</a>
<%
}
for(int i = startPage; i <= endPage; i++){
%>
<a href="noticeSearch.jsp?pageNum=<%=i%>&search=<%=search%>"><%=i %></a>
<%	
}
if(endPage < pageCount){
%>
<a href="noticeSearch.jsp?pageNum=<%=startPage + pageBlock%>&search=<%=search%>">Next</a>
<%	
}
%>
</div>
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