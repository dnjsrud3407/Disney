<%@page import="board.File_BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int num = Integer.parseInt(request.getParameter("num"));
File_BoardDAO bdao = new File_BoardDAO();
bdao.deleteForm(num);
response.sendRedirect("fnotice.jsp");
%>