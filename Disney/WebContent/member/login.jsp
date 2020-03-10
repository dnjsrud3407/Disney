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
function check(){
 // id 상자 비어있으면 제어
 if(document.fr.id.value == ""){
  alert('id를 입력하세요');
  document.fr.id.focus();
  return false;
 }
 if(document.fr.pass.value == ""){
 alert('패스워드를 입력하세요');
 document.fr.pass.focus();
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
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Login</h1>
<%
String getNum = request.getParameter("num");
%>
<form action="loginPro.jsp" id="join" method="post" name="fr" onsubmit="return check()">
	<fieldset>
	<%if(getNum != null){%>
	<input type="hidden" name="num" value="<%=getNum%>">
	<%}%>
	<legend>Login Info</legend>
	<label>User ID</label>
	<input type="text" name="id"><br>
	<label>Password</label>
	<input type="password" name="pass"><br>
	</fieldset>
	<div class="clear"></div>
	<div id="buttons">
	<input type="submit" value="로그인" class="submit">
	<input type="button" value="회원가입" class="cancel" onclick="location.href='join.jsp'">
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