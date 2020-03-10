<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/dup_check.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function idselect(){
	/*
	 * dup_checkForm 에서 찾은 아이디를 -> join.jsp(opener페이지)의 id상자안에 저장!
	 * dup_checkForm 의 창닫기 
	 */
	 opener.document.fr.id.value = document.wfr.wid.value;
	 opener.document.fr.isduplicate.value = 1;
	 window.close();
}
</script>
</head>
<body style="overflow-x:hidden;">
<%
String id = request.getParameter("wid");
MemberDAO mdao = new MemberDAO();
int check = mdao.idCheck(id);
%>
<div id="wrap">
<article style="margin-left: 30px;">
	<form action="dup_checkForm.jsp" name="wfr" id="join" method="post">
		<fieldset>
		<legend>Basic Info</legend>
		<label>User ID</label>
		<input type="text" name="wid" class="id" value="<%=id%>">
		<input type="submit" value="중복체크" class="submit"><br>
		<%if(check == 1){
			out.println("아이디 중복입니다.");
		} else if(check == -1){	// 아이디 없으면 check == -1; 
			out.println("사용가능한 아이디입니다.");
			// 아이디 사용가능할 때만 버튼 보이게
			%>
			<input type="button" value="아이디선택" onclick="idselect()">
			<%
		} %>
		</fieldset>
	</form>
</article>
</div>
</body>
</html>