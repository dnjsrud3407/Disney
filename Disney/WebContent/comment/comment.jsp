<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

CommentBean cb = new CommentBean();
// gallery 번호
cb.setNum(Integer.parseInt(request.getParameter("num")));
cb.setId((String)session.getAttribute("id"));
cb.setContent(request.getParameter("content"));

CommentDAO cdao = new CommentDAO();
int num = cdao.insertComment(cb);

response.sendRedirect("../gallery/gcontent.jsp?num=" + num + "#cmtForm");
%>