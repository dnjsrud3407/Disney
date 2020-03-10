<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
BoardDAO bdao = new BoardDAO();
request.setCharacterEncoding("utf-8");
// 세션(id)값 가져오기
String id = (String)session.getAttribute("id");

String subject = request.getParameter("subject");
String content = request.getParameter("content");

// BoardBean bb 객체 생성
BoardBean bb = new BoardBean();
bb.setId(id);
bb.setSubject(subject);
bb.setContent(content);

int num = bdao.insertBoard(bb);

response.sendRedirect("content.jsp?num=" + num);
%>