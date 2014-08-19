<%@page import="board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %>
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

<%
	long num = Long.parseLong(request.getParameter("remove_reply_num").trim());
	long board_num = Long.parseLong(request.getParameter("remove_board_num").trim());
	try
	{
		controller.deleteReply(num);
		out.println("삭제되었습니다.<br>");
	}
	catch(Exception e)
	{
		out.println("삭제에 실패하였습니다.<br>문제 : " + e.getMessage() + "<br>");
	}
%>
<form action="show.jsp" method="post">
<input type="hidden" value="<%= board_num %>" name="view_num">
<input type="submit" value="돌아가기">
</form>
</body>
</html>