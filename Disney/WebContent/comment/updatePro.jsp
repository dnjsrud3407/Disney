<%@page import="comment.CommentBean"%>
<%@page import="comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int num = Integer.parseInt(request.getParameter("num"));
int c_num = Integer.parseInt(request.getParameter("c_num"));
String content = request.getParameter("content");
CommentDAO cdao = new CommentDAO();
CommentBean cb = new CommentBean();
cb.setC_num(c_num);
cb.setContent(content);

cdao.updateComment(cb);
response.sendRedirect("../gallery/gcontent.jsp?num=" + num + "#cmtForm");
%>