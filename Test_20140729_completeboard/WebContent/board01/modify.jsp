<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %>
    <%@ page import="board.Board" %>
    <%
    
    if(session.getAttribute("logined_id") == null)
    {
    	session.invalidate();
    	response.sendRedirect("login.jsp");
    }
    
    %>
     <jsp:useBean id="controller" class="board.BoardControl" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="style.css" rel="stylesheet" type="text/css">
<title>SEED</title>
</head>
<body>
<h1>SEED</h1>
<hr>
<%
	Board getBoard = controller.getOneWithRefreshed(Long.parseLong(request.getParameter("mod_num")));
	String subject, content;
	long num = getBoard.getNum();
	subject = getBoard.getSubjects();
	content = getBoard.getContent();

%>
<form action="mainpage.jsp"><input type="submit" value="취소"></form><br>
<form action="modifyPro.jsp">
<input type="hidden" name="mod_num" value="<%= num %>">
<table>
	<tr>
		<td>제목 : <input type="text" name="mod_subject" size="20" value="<%= subject%>"></td>
	</tr>
	<tr>
		<td>내용</td>
	</tr>
	<tr>
		<td rowspan="5">
		<textarea rows="30" cols="100" name="mod_content">
		<%= content %>
		</textarea>
		</td>
	</tr>
	<tr></tr>
	<tr></tr>
	<tr></tr>
	<tr></tr>
</table>
<br>
<input type="submit" value="등록"><input type="reset" value="다시 작성">
</form>
<form action="mainpage.jsp"><input type="submit" value="취소"></form>
</body>
</html>