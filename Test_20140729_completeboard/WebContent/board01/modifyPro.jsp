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
<%
	Board getBoard = controller.getOneWithRefreshed(Long.parseLong(request.getParameter("mod_num")));
	request.setCharacterEncoding("UTF-8");
	getBoard.setSubjects(request.getParameter("mod_subject"));
	getBoard.setContent(request.getParameter("mod_content"));
	
	try
	{
		controller.update(getBoard);
		out.println("글을 등록하였습니다.<br><form action=\"mainpage.jsp\"><input type=\"submit\" value=\"확인\"></form>");
	}
	catch(Exception e)
	{
		e.printStackTrace();
		out.println("글을 등록하지 못했습니다.<br><form action=\"new.jsp\"><input type=\"submit\" value=\"뒤로 가기\"></form>");
	}
%>
</body>
</html>