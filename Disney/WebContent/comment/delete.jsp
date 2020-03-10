<%@page import="comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	int c_num = Integer.parseInt(request.getParameter("c_num"));
	CommentDAO cdao = new CommentDAO();
	cdao.deleteComment(c_num,num);
	response.sendRedirect("../gallery/gcontent.jsp?num=" + num + "#cmtForm");
%>
