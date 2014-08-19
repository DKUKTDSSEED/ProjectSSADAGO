<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %>
    <%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="style.css" rel="stylesheet" type="text/css">
<title>Join SEED</title>
</head>
<body>
<h1>SEED</h1><hr>
<%
	request.setCharacterEncoding("utf8");
	Connection conn = null;
	String str, sql, id, passwd, email;
	ResultSet result;
	ResultSetMetaData metaData;
	PreparedStatement prepared;
	id = request.getParameter("join_id");
	passwd = request.getParameter("join_pw");
	email = request.getParameter("join_email");
	if(id == null || passwd == null || email == null)
	{
		out.println("회원 가입에 필요한 정보를 입력하지 않았습니다.<br>다시 시도해 주세요.");
	}
	else
	{
		try
		{
			Context initCtx = new InitialContext();	
			Context envCtx = (Context) initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource) envCtx.lookup("jdbc/test");
			conn = ds.getConnection();
			
			sql = "insert into account(id, passwd, email) values(?, ?, ?)";
			prepared = conn.prepareStatement(sql);
			prepared.setString(1, id);
			prepared.setString(2, passwd);
			prepared.setString(3, email);
			
			prepared.executeUpdate();
			out.println("SEED의 회원이 되신 것을 환영합니다 !<br><br>서비스를 이용하기 위해 다시 로그인해 주세요.");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			out.println("회원 가입 중 문제가 발생하였습니다.<br>문제 : " + e.getMessage() + "<br>다시 시도해 주세요.");
		}
		finally
		{
			if(conn != null)
			{
				try
				{
					conn.close();
				}
				catch(Exception e)
				{
					
				}
			}
		}
	}
%>
<br>
<form action="login.jsp">
<input type="submit" value="로그인 화면으로 돌아가기">
</form>
</body>
</html>