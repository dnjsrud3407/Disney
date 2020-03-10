<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.Message"%>
<%@page import="mailtest.GoogleAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String receiver = request.getParameter("receiver");
String sender = "disney@disney.com";
String subject = "Disney 회원가입을 축하합니다";
String content = "Disney 회원가입을 축하합니다. 앞으로 많은 이용 부탁드립니다.";

response.setContentType("text/html;charset=UTF-8");

try {
    Properties properties = System.getProperties();
    properties.put("mail.smtp.starttls.enable","true");
    properties.put("mail.smtp.host","smtp.gmail.com");
    properties.put("mail.smtp.auth","true");
    properties.put("mail.smtp.port","587");
    Authenticator auth = new GoogleAuthentication();
    Session s = Session.getDefaultInstance(properties, auth);
    Message message = new MimeMessage(s);
    Address sender_address = new InternetAddress(sender);
    Address receiver_address = new InternetAddress(receiver);
    message.setHeader("content-type", "text/html;charset=UTF-8");
    message.setFrom(sender_address);
    message.addRecipient(Message.RecipientType.TO, receiver_address);
    message.setSubject(subject);
    message.setContent(content, "text/html;charset=UTF-8");
    message.setSentDate(new java.util.Date());
    Transport.send(message);
    %>
    <script>
    	alert('메일이 전송되었습니다');
    	location.href="../main/main.jsp";
    </script>
    <%
} catch (Exception e) {
    out.println("에러발생입니다");
    e.printStackTrace();
}

%>