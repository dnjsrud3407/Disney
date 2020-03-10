<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="board.File_BoardDAO"%>
<%@page import="board.File_BoardBean"%>
<%@page import="org.apache.tomcat.util.http.fileupload.UploadContext"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
// WebContent 밑에 upload파일 만들기
// cos.jar 프로그램 설치
String uploadPath = request.getRealPath("/upload");
int maxSize = 10*1024*1024;
MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

File_BoardBean bb = new File_BoardBean();
bb.setId(id);
bb.setSubject(multi.getParameter("subject"));
bb.setContent(multi.getParameter("content"));
String file = multi.getFilesystemName("file");
if(file != null){
	bb.setFile(file);
} else {
	String old_file = multi.getParameter("old_file");
	bb.setFile(old_file);
}
int readcount = 0;
bb.setReadcount(readcount);
File_BoardDAO bdao = new File_BoardDAO();

int num = bdao.insertBoard(bb);
response.sendRedirect("fcontent.jsp?num=" + num);
%>