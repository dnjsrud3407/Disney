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
// num 값 가져오기
int num = 0;
try{
	num = Integer.parseInt(request.getParameter("num"));
} catch (NumberFormatException e){
	response.sendRedirect("notice.jsp");
}

BoardDAO bdao = new BoardDAO();
String id = (String)session.getAttribute("id");
// 조회수 1증가 시키기
bdao.updateReadCount(num);
// num 에 해당하는 게시판 글 가져오기 getBoard(num)
BoardBean bb = bdao.getBoard(num);

%>
<script>
function confirmDelete(){
	//confirm('정말로 삭제하시겠습니까?');
 	var confirmMsg = confirm("정말로 삭제하시겠습니까?");
	if(confirmMsg){
		location.href='deleteBoard.jsp?num=<%=num%>';	
	}
}
</script>
<!-- 게시판 -->
<article>
<h1>Notice</h1>
<div id="table_search">
<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp'">
</div>
<%
// 로그인을 했고 
if(id != null){
	// 글쓴이와 동일인이면
	if(id.equals(bb.getId())){
%>
<div id="table_search">
<input type="button" value="수정하기" class="btn" onclick="location.href='updateBoardForm.jsp?num=<%=num%>'">
<input type="button" value="삭제하기" class="btn" onclick="confirmDelete()">
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
	<tr><td class="bcolor">글내용</td><td colspan="7" class="tcontent" style="width: 500px; height: 300px;"><%=bb.getContent() %></td></tr>
</table>

<div class="clear"></div>
<div id="page_control">
</div>
<div><a class="top" href="#">top</a></div>
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