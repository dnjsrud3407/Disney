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
function winopen(){
 // id 상자 비어있으면 제어
 if(document.fr.id.value == ""){
  alert('id를 입력하세요');
  document.fr.id.focus();
  return false;
 }
 var id = document.fr.id.value;
  window.open("dup_checkForm.jsp?wid=" + id,"w_test",
     "width=600,height=300,left=200,top=200,resizable=no");
}
<!--주소찾기-->
function address_search(){
 window.open("addressForm.jsp", "w_test2",
    "width=600,height=300,left=200,top=200,resizable=no");
}

function check(){
  if(document.fr.isduplicate.value != 1){
  alert('아이디 중복확인을 해주세요');
  document.fr.idButton.focus();
  return false;
 }
 if(document.fr.pass.value == "" || document.fr.pass2.value == ""){
  alert('패스워드를 입력하세요');
  document.fr.pass.focus();
  return false;
 }
 if(document.fr.pass.value != document.fr.pass2.value){
  alert('패스워드가 일치하지 않습니다');
  document.fr.pass.focus();
  return false;
 }
 if(document.fr.name.value == ""){
  alert('이름을 입력하세요');
  document.fr.name.focus();
  return false;
 }
 if(document.fr.email.value == "" || document.fr.email2.value == ""){
     alert('이메일을 입력하세요');
     document.fr.email.focus();
     return false;
 }
 if(document.fr.email.value != document.fr.email2.value){
     alert('이메일이 일치하지 않습니다');
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
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Join Us</h1>
<!-- 폼 태그 제어하는 것도 해보기(비번 일치, 필수사항 적었는지 확인) -->
<form action="joinPro.jsp" id="join" method="post" name="fr" onsubmit="return check()">
 <fieldset>
 <legend>Basic Info</legend>
 <label>User ID</label>
 <input type="text" name="id" class="id" required="required">
 <input type="hidden" name="isduplicate"> 
 <input type="button" value="dup. check" name="idButton" class="dup" onclick="winopen()"><br>
 <label>Password</label>
 <input type="password" name="pass"><br>
 <label>Retype Password</label>
 <input type="password" name="pass2"><br>
 <label>Name</label>
 <input type="text" name="name"><br>
 <label>E-Mail</label>
 <input type="email" name="email"><br>
 <label>Retype E-Mail</label>
 <input type="email" name="email2"><br>
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
 <input type="submit" value="회원가입" class="submit">
 <input type="button" value="Cancel" class="cancel">
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