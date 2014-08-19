<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %>
    <%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
    <%! 
    Connection conn = null;
	String str, sql, id, passwd, target_id, target_pw;
	ResultSet result;
	ResultSetMetaData metaData;
	PreparedStatement prepared;
    boolean exists = false;
    boolean id_found = false;
    boolean problem_occur = false;
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
<%
	
	id = request.getParameter("login_id");
	passwd = request.getParameter("login_pw");
	if(id == null || passwd == null)
	{		
		out.println("로그인에 필요한 정보를 입력하지 않았습니다..<br>다시 시도해 주세요.");
		problem_occur = true;
	}
	else
	{
		try
		{
			Context initCtx = new InitialContext();	
			Context envCtx = (Context) initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource) envCtx.lookup("jdbc/test");
			conn = ds.getConnection();
			
			sql = "select id, passwd from account";
			prepared = conn.prepareStatement(sql);
			result = prepared.executeQuery();
			
			while(result.next())
			{
				target_id = result.getString("id");
				if(id.equals(target_id))
				{
					id_found = true;
					target_pw = result.getString("passwd");
					if(passwd.equalsIgnoreCase(target_pw))						
					{
						exists = true;
						session.setAttribute("logined_id", target_id);
						problem_occur = false;
						break;
					}
				}				
			}
			if(exists)
			{
				problem_occur = false;
			}
			else
			{
				if(id_found)
				{
					out.println("로그인에 실패하였습니다.<br>비밀번호를 확인하고 다시 시도해 보세요.");
				}
				else
				{
					out.println("로그인에 실패하였습니다.<br>ID를 확인하고 다시 시도해 보세요.");
				}
				problem_occur = true;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			out.println("로그인 중 문제가 발생하였습니다.<br>문제 : " + e.getMessage() + "<br>다시 시도해 주세요.");
			problem_occur = true;
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
<%
if(problem_occur)
{
	%>
		<form action="login.jsp">
		<input type="submit" value="로그인 화면으로 돌아가기">
		</form>
	<%
}
else if(exists)
{
	response.sendRedirect("mainpage.jsp");
}
%>
</body>
</html>