<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// update.jsp에서 입력한 값 가져오기 
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
MemberBean mb = new MemberBean();
mb.setId(id);
mb.setPass(request.getParameter("pass"));
mb.setName(request.getParameter("name"));
mb.setEmail(request.getParameter("email"));
mb.setAddress_postcode(request.getParameter("address_postcode"));
mb.setAddress(request.getParameter("address"));
mb.setPhone(request.getParameter("phone"));
mb.setMobile(request.getParameter("mobile"));

MemberDAO mdao = new MemberDAO();
int check = mdao.updateMember(mb);
if(check == 1){
	%>
	<script>
		alert('회원정보가 수정되었습니다');
		location.href('update.jsp');
	</script>
	<%
} else if(check == 0) {
	System.out.println(request.getParameter("pass"));
	System.out.println(mb.getPass());
	%>
	<script>
		alert('비밀번호가 일치하지 않습니다');
		history.back();
	</script>
	<%
} else {
	%>
	<script>
		alert('아이디 없습니다');
		history.back();
	</script>
	<%
}
%>
