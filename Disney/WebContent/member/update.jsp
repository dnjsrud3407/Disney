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
<script type="text/javascript">
<!--주소찾기-->
function address_search(){
	window.open("addressForm.jsp", "w_test2",
    "width=600,height=300,left=200,top=200,resizable=no");
}
function check(){
	if(document.fr.pass.value == ""){
	  alert('패스워드를 입력하세요');
	  document.fr.pass.focus();
	  return false;
	 }
	if(document.fr.name.value == ""){
	  alert('이름을 입력하세요');
	  document.fr.name.focus();
	  return false;
	 }
	 if(document.fr.email.value == ""){
	     alert('이메일을 입력하세요');
	     document.fr.email.focus();
	     return false;
	 }
}
</script>
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
%>
<h1>Update Info</h1>
<!-- 폼 태그 제어하는 것도 해보기(비번 일치, 필수사항 적었는지 확인) -->
<form action="updatePro.jsp" id="join" method="post" name="fr" onsubmit="return check()">
	<fieldset>
	<legend>Basic Info</legend>
	<label>User ID</label>
	<input type="text" name="id" class="id" value="<%=id %>" readonly="readonly"><br>
	<label>Password 확인</label>
	<input type="password" name="pass"><br>
	<label>Name</label>
	<input type="text" name="name"><br>
	<label>E-Mail</label>
	<input type="email" name="email"><br>
	</fieldset>
	
	<fieldset>
	<legend>Optional</legend>
	<label>Address</label>
	<input type="text" name="address_postcode" placeholder="우편번호"><input type="button" value="search" class="dup" onclick="address_search()"><br>
	<input type="text" name="address" placeholder="주소" style="width: 500px;"><br>
	<label>Phone Number</label>
	<input type="text" name="phone"><br>
	<label>Mobile Phone Number</label>
	<input type="text" name="mobile"><br>
	</fieldset>
	<div class="clear"></div>
	<div id="buttons">
	<input type="submit" value="정보수정" class="submit">
	<a href="../main/main.jsp"><input type="button" value="메인으로" class="cancel"></a>
	</div>
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