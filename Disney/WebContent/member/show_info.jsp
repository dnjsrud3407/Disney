<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
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

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_center" style="margin-top: 20px; margin-left:9px; height: 179px; width: 953px;
background-image: url('../images/banner_3.png');"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<jsp:include page="../inc/sub_menu_member.jsp"></jsp:include>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<%
String id = (String)session.getAttribute("id");
MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);
%>
<h1>Show Info</h1>
<!-- 폼 태그 제어하는 것도 해보기(비번 일치, 필수사항 적었는지 확인) -->
<form id="join" method="post">
	<fieldset>
	<legend>Basic Info</legend>
	<label>User ID</label>
	<input type="text" name="id" class="id" value="<%=mb.getId() %>" readonly="readonly"><br>
	<label>Password</label>
	<input type="text" name="pass" value="<%=mb.getPass() %>" readonly="readonly"><br>
	<label>Name</label>
	<input type="text" name="name" value="<%=mb.getName() %>" readonly="readonly"><br>
	<label>E-Mail</label>
	<input type="email" name="email" value="<%=mb.getEmail() %>" readonly="readonly"><br>
	</fieldset>
	
	<fieldset>
	<legend>Optional</legend>
	<label>Address</label>
	<input type="text" name="address_postcode" value="<%=mb.getAddress_postcode() %>" placeholder="우편번호">
	<input type="text" name="address" value="<%=mb.getAddress() %>" readonly="readonly" style="width: 460px;"><br>
	<label>Phone Number</label>
	<input type="text" name="phone" value="<%=mb.getPhone() %>" readonly="readonly"><br>
	<label>Mobile Phone Number</label>
	<input type="text" name="mobile" value="<%=mb.getMobile() %>" readonly="readonly"><br>
	</fieldset>
	<div class="clear"></div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>