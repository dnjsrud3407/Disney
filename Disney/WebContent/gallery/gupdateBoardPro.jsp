<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.Gallery_BoardDAO"%>
<%@page import="board.Gallery_BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String uploadPath = request.getRealPath("/upload");
int maxSize = 5*1024*1024;
MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

int num = Integer.parseInt(multi.getParameter("num"));

Gallery_BoardBean bb = new Gallery_BoardBean();
bb.setNum(num);
bb.setSubject(multi.getParameter("subject"));
bb.setContent(multi.getParameter("content"));
String file = multi.getFilesystemName("file");
String old_file = multi.getParameter("old_file");

if(file != null){
	bb.setFile(file);
} else {
	bb.setFile(old_file);
}


Gallery_BoardDAO bdao = new Gallery_BoardDAO();
bdao.updateForm(bb);

response.sendRedirect("gcontent.jsp?num=" + num);
%>