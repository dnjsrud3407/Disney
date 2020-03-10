<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 파라미터 값 가져오기
String id = (String)session.getAttribute("id");
String pass = request.getParameter("pass");

// memberDAO mdao 객체 생성
MemberDAO mdao = new MemberDAO();
// int check = id와 pass 일치 여부 확인(맞으면 1, 비밀번호 틀리면 0, 아이디 없으면 -1)
int check = 0;
// check = mdao.userCheck(id, pass) 메서드 생성
check = mdao.userCheck(id, pass);

// check == 1 이면 main 이동
if(check == 1){		// 일치하면 session값 생성
	response.sendRedirect("show_info.jsp");
} else if(check == 0){
	%>
	<script type="text/javascript">
		alert('비밀번호 틀림');
		history.back();
	</script>
	<%
} else {	// 아이디 없는 경우
	%>
	<script type="text/javascript">
		alert('아이디 불일치');
		history.back();
	</script>
	<%
}
%>