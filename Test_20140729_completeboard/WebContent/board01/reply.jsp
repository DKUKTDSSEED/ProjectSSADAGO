<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="board.Reply" %>
    <%@ page import="board.Board" %>
    <%@ page session="true" %>
    <%
    
    request.setCharacterEncoding("UTF-8");
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
	String writer, content;
	long board_num;
	
	writer = request.getParameter("reply_writer");
	board_num = Long.parseLong(request.getParameter("reply_board_num"));
	content = request.getParameter("reply_content");
	Reply reply = new Reply();
	reply.setWriter(writer);
	reply.setBoard_num(board_num);
	reply.setContent(content);
	
	
	
	try
	{
		controller.insert(reply);
		
		out.println("글을 등록하였습니다.<br><form action=\"show.jsp\">" 
		+ "<input type=\"hidden\" name=\"view_num\" value=\""+ String.valueOf(board_num) + "\">"
		+ "<input type=\"submit\" value=\"확인\"></form>");
	}
	catch(Exception e)
	{
		e.printStackTrace();
		out.println("글을 등록하지 못했습니다.<br>문제 : " + e.getMessage() + "<br><form action=\"show.jsp\">" 
				+ "<input type=\"hidden\" name=\"view_num\" value=\""+ String.valueOf(board_num) + "\">"
				+ "<input type=\"submit\" value=\"확인\"></form>");
	}

%>

</body>
</html>