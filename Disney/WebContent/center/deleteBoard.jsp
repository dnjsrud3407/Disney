<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int num = Integer.parseInt(request.getParameter("num"));
BoardDAO bdao = new BoardDAO();
bdao.deleteForm(num);
response.sendRedirect("notice.jsp");
%>