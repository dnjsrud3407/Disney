<%@page import="board.Gallery_BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int num = Integer.parseInt(request.getParameter("num"));
Gallery_BoardDAO bdao = new Gallery_BoardDAO();
bdao.deleteForm(num);
response.sendRedirect("gnotice.jsp");
%>