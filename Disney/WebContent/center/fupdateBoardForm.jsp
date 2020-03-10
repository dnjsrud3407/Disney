<%@page import="java.util.List"%>
<%@page import="board.File_BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.File_BoardDAO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/write_subpage.css" rel="stylesheet" type="text/css">
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
<script type="text/javascript">
function check(){
	if(document.fr.subject.value == ""){
		alert('글 제목을 입력하세요');
		return;
	}
	if(document.fr.content.value == ""){
		alert('글 내용을 입력하세요');
		return;
	}
	document.fr.submit();
}
</script>
</head>
<body>
<%
if(session.getAttribute("id") == null){
	response.sendRedirect("notice.jsp");
}
int num = Integer.parseInt(request.getParameter("num"));
File_BoardDAO bdao = new File_BoardDAO();
File_BoardBean bb = bdao.getBoard(num);
%>
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
<article>
<h1>File Update</h1>
<form action="fupdateBoardPro.jsp" method="post" name="fr" enctype="multipart/form-data">
 <table id="notice">
 <input type="hidden" name="num" value="<%=num%>">
  <tr>
   <th id="n_no">Subject</th>
   <td><input type="text" name="subject" value="<%=bb.getSubject() %>" style="width: 500px;"></td>
  </tr>
  <tr>
  	<th id="n_no">File</th>
   <td>
   	<input type="file" name="file" style="width: 500px;">
    <input type="hidden" name="old_file" value="<%=bb.getFile() %>">
   </td>
  </tr>
  <tr>
   <th id="n_no">Content</th>
   <td><textarea name="content" style="width: 500px; height: 300px;"><%=bb.getContent() %></textarea></td>
  </tr>
 </table>
 <div id="table_search">
 <input type="button" value="작성하기" class="btn" onclick="check()">
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