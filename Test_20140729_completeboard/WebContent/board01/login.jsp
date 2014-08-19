<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %>
    
    <% 
    session.setMaxInactiveInterval(1800);
    request.setCharacterEncoding("UTF-8");
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="style.css" rel="stylesheet" type="text/css">
<title>SEED</title>
</head>
<body>
<h1>SEED</h1><hr>

<center>
<form action="loginComplete.jsp" method="post">
<table border=1>
	<tr>
		<td>ID</td>
		<td><input type="text" name="login_id" size="20"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="login_pw" size="20" ></td>
	</tr>
	<tr>
		<td><input type="submit" value="로그인"></td>
		<td><a href="join.jsp">[회원 가입]</a></td>
	</tr>
</table>
</form>
</center>
</body>
</html>