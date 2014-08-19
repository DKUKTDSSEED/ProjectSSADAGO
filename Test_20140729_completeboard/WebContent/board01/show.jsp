<%@page import="java.util.StringTokenizer"%>
<%@page import="sun.util.locale.StringTokenIterator"%>
<%@page import="board.Board"%>
<%@page import="board.Reply"%>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page session="true" %>
    <%!
    Board getBoard;
    %>
    <%
    request.setCharacterEncoding("UTF-8");
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
<form action="mainpage.jsp"><input type="submit" value="목록"></form>
<br>

<center>
<table border="1">
<tr>
<td>
<%
	
	String getNum = request.getParameter("view_num");
	getBoard = controller.getOneWithRefreshed(Long.parseLong(getNum));
	if(getBoard != null)
		out.println("제목 : " + getBoard.getSubjects());
	else
		response.sendRedirect("error_cannotfindboard.jsp");
	
	controller.increaseCount(getBoard);
%>
</td>
</tr>
<tr>
<td rowspan="10">
<textarea readonly="readonly" rows="20" cols="50">
<%
	
	String getLines = getBoard.getContent();
	out.println(getLines);
	

%>
</textarea>
</td>
</tr>
<tr>
<td></td>
</tr>
</table>
</center>
<br>
<form action="modify.jsp" method="post">
<%
	out.println("<input type=\"hidden\" name=\"mod_num\"  value=" + request.getParameter("view_num") + ">");
	
	if(((String)session.getAttribute("logined_id")).equals(getBoard.getWriter()))
	{
		out.println("<input type=\"submit\" value=\"수정\">");
	}
%>
</form>
<form action="delete.jsp" method="post">
<%
	out.println("<input type=\"hidden\" name=\"del_num\"  value=" + request.getParameter("view_num") + ">");
	
	if(((String)session.getAttribute("logined_id")).equals(getBoard.getWriter()))
	{
		out.println("<input type=\"submit\" value=\"삭제\">");
	}
%>
</form>
<form action="mainpage.jsp"><input type="submit" value="목록"></form>
<hr>
<center>
<table border="1">
<tr>
	<td colspan="4">
		<form action="reply.jsp" method="POST">
			<input type="hidden" name="reply_board_num" value="<%= getBoard.getNum()%>">
			<input type="hidden" name="reply_writer" value="<%= session.getAttribute("logined_id") %>">
			<input type="text" name="reply_content" size="30">
			<input type="submit" value="입력">
		</form>
	</td>
</tr>
<%
	List<Reply> replyList = controller.getReplyWithRefresh(getBoard);
	if(replyList != null)
	{
		for(Reply r : replyList)
		{
	out.println("<tr><td>");
	out.println(String.valueOf(r.getNum()));
	out.println("</td><td width=\"400\">");
	out.println(r.getContent());
	out.println("</td><td>");
	out.println(r.getWriter());
	out.println("</td><td width=\"30\">");
	if(r.getWriter().equals(session.getAttribute("logined_id")))
	{
		out.println("<form action=\"removereply.jsp\">");
		out.println("<input type=\"hidden\" name=\"remove_reply_num\" value=\" " + r.getNum() + " \">");
		out.println("<input type=\"hidden\" name=\"remove_board_num\" value=\" " + r.getBoard_num() + " \">");
		out.println("<input type=\"submit\" value=\"X\">");
		out.println("</form>");
	}
	out.println("</td></tr>");
		}
	}
%>
</table>
</center>
</body>
</html>