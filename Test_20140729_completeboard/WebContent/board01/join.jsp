<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %>
    <%
    request.setCharacterEncoding("UTF-8");
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="style.css" rel="stylesheet" type="text/css">
<title>Join SEED</title>
</head>
<body>
<h1>SEED</h1><hr>
<center>
<form action="joinComplete.jsp">
<table border=1>
	<tr>
		<td>ID</td>
		<td><input type="text" name="join_id" size="20"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="join_pw" size="15"></td>
	</tr>
	<tr>
		<td>E-Mail</td>
		<td><input type="text" name="join_email" size="15"></td>
	</tr>
	
	<tr>
		<td><input type="submit" value="회원 가입"><input type="reset" value="다시 작성하기"></td>
		<td><a href="login.jsp">[취소]</a></td>
	</tr>
</table>
</form>
</center>
</body>
</html>