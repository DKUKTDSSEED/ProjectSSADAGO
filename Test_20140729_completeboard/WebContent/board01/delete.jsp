
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="board.Board" %>
    <%@ page session="true" %>
     <jsp:useBean id="controller" class="board.BoardControl" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="style.css" rel="stylesheet" type="text/css">
<title>SEED</title>
</head>
<body>
<%
	String getNum = request.getParameter("del_num");
	long num = Long.parseLong(getNum);
	Board target = controller.getOneWithRefreshed(num);
	if(target != null)
		controller.delete(target);
	else
		response.sendRedirect("error_cannotfindboard.jsp");
	
	
%>
<br>
글이 삭제되었습니다.<br>
<form action="mainpage.jsp">
<input type="submit" value="돌아가기">
</form>
</body>
</html>