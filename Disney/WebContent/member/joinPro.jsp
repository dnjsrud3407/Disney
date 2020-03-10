
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 한글처리
request.setCharacterEncoding("utf-8");
// request에 저장된 파라미터 가져와서 변수에 저장
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String email = request.getParameter("email");
String address_postcode = request.getParameter("address_postcode");
String address = request.getParameter("address");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");

// 데이터 저장해서 전달

// 패키지 member / 파일이름 memberBean
// memberBean내에 멤버변수 정의 set / get
// memberBean 객체 mb 생성
MemberBean mb = new MemberBean();
// mb에 파라미터 값 저장
mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setEmail(email);
mb.setAddress_postcode(address_postcode);
mb.setAddress(address);
mb.setPhone(phone);
mb.setMobile(mobile);

// 디비작업
// 패키지 member / 파일이름 memberDAO
// 디비연결 getConnection() 메서드 만들기
// insertMember(mb) 메서드 만들기
// memberDAO mdao 객체 생성
MemberDAO mdao = new MemberDAO();
// insertMember(mb) 메서드 호출
mdao.insertMember(mb);

// login.jsp 이동
%>
<form action="../contact/mailSendProByAdmin.jsp" method="post" name="fr">
<input type="hidden" name="receiver" value="<%=email%>">
</form>
<script>
	document.fr.submit();
</script>