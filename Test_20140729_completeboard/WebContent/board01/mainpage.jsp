<%@page import="board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List" %>
    <%@ page session="true" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="style.css" rel="stylesheet" type="text/css">
<title>SEED</title>
</head>
<body>
<h1>SEED</h1><hr>
<jsp:useBean id="controller" class="board.BoardControl" scope="session"/>
<center>
<table border=1>
<tr>
	<td>No.</td>
	<td>제목</td>
	<td>글쓴이</td>
	<td>조회 수</td>
	<td>등록일</td>
</tr>
<%
	request.setCharacterEncoding("UTF-8");
	List<Board> gets = controller.selectAll();
	for(Board b : gets)
	{
		out.println("<tr>");
		out.println("<td>");
		out.println(b.getNum());
		out.println("</td>");
		out.println("<td width=\"400\">");
		/*
		out.println("<form action=\"show.jsp\" method=\"post\"><input type=\"hidden\" name=\"view_num\" value=\"" + b.getNum() + "\"> " 
		+ " <input type=\"submit\" value=\"" + b.getSubjects() + "\"></form>");
		
		*/
		out.println("<a href=\"show.jsp?" + "view_num=" + b.getNum() + "\">" + b.getSubjects() + "</a>");
		out.println("</td>");
		out.println("<td>");
		out.println(b.getWriter());
		out.println("</td>");
		out.println("<td>");
		out.println(b.getReadcount());
		out.println("</td>");
		out.println("<td>");
		if(b.getReg_date() != null)
			out.println(b.getReg_date().toString());
		out.println("</td>");
		out.println("</tr>");
		
	}

%>
</table>
</center>
<br>
<form action="new.jsp"><input type="submit" value="글 쓰기"></form>
<form action="logout.jsp"><input type="submit" value="로그아웃"></form>
</body>
</html>