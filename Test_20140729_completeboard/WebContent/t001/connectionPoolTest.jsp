<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	Connection conn = null;
	String str, sql;
	ResultSet result;
	ResultSetMetaData metaData;
	PreparedStatement prepared;
	try
	{
		Context initCtx = new InitialContext();	
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/test");
		conn = ds.getConnection();
		
		out.println("제대로 연결되었습니다<br>");
		sql = "select * from member";
		prepared = conn.prepareStatement(sql);
		result = prepared.executeQuery();
		metaData = result.getMetaData();
		
		out.println("<table border=1>");
		while(result.next())
		{
			out.println("<tr>");
			for(int i=0; i<metaData.getColumnCount(); i++)
			{
				out.println("<td>");
				out.println(result.getString(metaData.getColumnName(i+1)));
				out.println("</td>");
			}
			out.println("</tr>");
		}
		out.println("</table>");
	}
	catch(Exception e)
	{
		e.printStackTrace();
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


%>

</body>
</html>