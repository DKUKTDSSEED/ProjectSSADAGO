<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %>
    <%
    
    request.setCharacterEncoding("UTF-8");
    if(session.getAttribute("logined_id") == null)
    {
    	session.invalidate();
    	response.sendRedirect("login.jsp");
    }
    
    %>
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
<form action="mainpage.jsp"><input type="submit" value="취소"></form><br>
<form action="newPro.jsp" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<td>제목 : <input type="text" name="new_subject" size="20"></td>
	</tr>
	<tr>
		<td>내용</td>
	</tr>
	<tr>
		<td rowspan="5">
		<textarea rows="30" cols="100" name="new_content"></textarea>
		</td>
	</tr>
	<tr></tr>
	<tr></tr>
	<tr></tr>
	<tr></tr>
</table>
<br>
<table border="1">
<tr>
	<td>
	
	<input type="checkbox" name="upload_use" value="파일 첨부"> 
	<input type="file" name="upload_file">
	</td>
</tr>
</table>
<hr>
<input type="submit" value="등록"><input type="reset" value="다시 작성">
</form>
<form action="mainpage.jsp"><input type="submit" value="취소"></form>
</body>
</html>