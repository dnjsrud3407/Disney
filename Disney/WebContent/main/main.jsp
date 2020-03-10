<%@page import="board.Gallery_BoardBean"%>
<%@page import="board.Gallery_BoardDAO"%>
<%@page import="board.File_BoardBean"%>
<%@page import="board.File_BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>

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

 </script>
 <![endif]--> 


</head>
<body>
<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/disney2.png"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->

<!-- 메인 콘텐츠 들어가는 곳 -->
<%
int count = 0;
int pageSize = 8;
int startRow = 1;
List list = null;
// gallery 게시글
Gallery_BoardDAO g_bdao = new Gallery_BoardDAO();
count = g_bdao.getBoardCount();
if(count != 0){
	list = g_bdao.getBoardList(startRow, pageSize);
}
%>
<article id="front">
	<div id="solution">
		<div id="hosting" class="autoplay">
			<%
			if(list != null){
				for(int i = 0; i < list.size(); i++){
					Gallery_BoardBean bb = (Gallery_BoardBean)list.get(i);
					%>
					<div id="img">
						<a href="../gallery/gcontent.jsp?num=<%=bb.getNum()%>">
							<img alt="" src="../upload/<%=bb.getFile() %>" height="148px">
						</a>
					</div>
					<%
				}
			}
			%>
			<div id="img_icon">
				<a href="../gallery/gcontent.jsp">
				<img alt="" src="../images/next.png" height="30px">
				</a>
			</div>
		</div>
	</div>
	<div class="clear"></div>
<div style="margin-left: 30px;">
<%
// file 게시글
pageSize = 5;
File_BoardDAO f_bdao = new File_BoardDAO();
count = f_bdao.getBoardCount();
if(count != 0){
	list = f_bdao.getBoardList(startRow, pageSize);
}
%>
	<div id="news_notice">
	<h3 class="brown">File &amp; Notice</h3>
	<table>
<%
if(list != null){
	for(int i = 0; i < list.size(); i++){
		File_BoardBean bb = (File_BoardBean)list.get(i);	
%>	
	<tr><td class="contxt"><a href="../center/fcontent.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject() %></a></td>
	    <td><%=f_bdao.compareDate(bb) %></td></tr>
<%} 
}%>		
	</table>
	</div>
<%
// notice 게시글
BoardDAO bdao = new BoardDAO();
count = bdao.getBoardCount();
pageSize = 5;
startRow = 1;
if(count != 0){
	list = bdao.getBoardList(startRow, pageSize);
}
%>
	<div id="news_notice">
	<h3 class="brown">News &amp; Notice</h3>
	<table>
<%
if(list != null){
	for(int i = 0; i < list.size(); i++){
		BoardBean bb = (BoardBean)list.get(i);	
%>	
	<tr><td class="contxt"><a href="../center/content.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject() %></a></td>
	    <td><%=bdao.compareDate(bb) %></td></tr>
<%} 
}%>		
	</table>
	</div>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="slick/slick.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$('.autoplay').slick({
	  slidesToShow: 3,
	  slidesToScroll: 1,
	  autoplay: true,
	  autoplaySpeed: 2000,
	});
});
</script>
</body>
</html>