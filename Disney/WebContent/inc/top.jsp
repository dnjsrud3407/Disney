<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<%
	String id = (String)session.getAttribute("id");
	if(id == null){
%>		<div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div>
<%
	} else {
	%><div id="login"><%=id %>님 환영합니다 | <a href="../member/update.jsp">마이페이지</a>
	 | <a href="../member/logout.jsp">로그아웃</a></div>
	<%
	}
%>
<div class="clear"></div>

<!-- 로고들어가는 곳 -->
<div id="logo"><a href="../main/main.jsp"><img src="../images/disney_logo.png" width="250" alt="logo"></a></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../company/welcome.jsp">COMPANY</a></li>
	<li><a href="../center/notice.jsp">NOTICE</a></li>
	<li><a href="../gallery/gnotice.jsp">GALLERY</a></li>
	<li><a href="../contact/map.jsp">CONTACT US</a></li>
</ul>
</nav>
</header>