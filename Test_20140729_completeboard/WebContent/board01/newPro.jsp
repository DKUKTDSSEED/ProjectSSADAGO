<%@page import="board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.oreilly.servlet.MultipartRequest" %>
    <%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
    <%@ page import="java.util.Enumeration" %>
    <%@ page import="java.io.*;" %>
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
	Board newBoard = new Board();
	String subject = request.getParameter("new_subject");
	String content = request.getParameter("new_content");
	out.println("제목 : " + subject + "<br>");
	out.println("내용<hr>" + content + "<hr>");
	newBoard.setSubjects(subject);
	newBoard.setContent(content);
	newBoard.setWriter((String)session.getAttribute("logined_id"));
	//out.println("<script>alert(\"" + request.getParameter("new_content") + "\")</script>");
	try
	{
		controller.insert(newBoard);
		out.println("글을 등록하였습니다.<br><form action=\"mainpage.jsp\"><input type=\"submit\" value=\"확인\"></form>");
	}
	catch(Exception e)
	{
		e.printStackTrace();
		out.println("글을 등록하지 못했습니다.<br><form action=\"new.jsp\"><input type=\"submit\" value=\"뒤로 가기\"></form>");
	}
	
	try
	{
		String uploadPath = request.getRealPath("upload");
		int size = 10 * 1024 * 1024;
		
		MultipartRequest multi
		 = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		String file1 = (String) files.nextElement();
		String filename1 = multi.getFilesystemName(file1);
		String origfilename1 = multi.getOriginalFileName(file1);
		
	
		String savePath = "upload";
		ServletContext context = getServletContext();
		String sDownloadPath = context.getRealPath("upload");
		String sFilePath = sDownloadPath + "\\" + filename1;
		
		byte[] b = new byte[4096];
		File oFile = new File(sFilePath);
		
		FileInputStream in = null;
		ServletOutputStream out2 = null;
		try
		{
			in = new FileInputStream(sFilePath);
			String sMimeType = getServletContext().getMimeType(sFilePath);
			System.out.println("sMimeType : " + sMimeType);
			
			if(sMimeType == null)
			{
				sMimeType = "application/octet-stream";
			}
			response.setContentType(sMimeType);
			
			String sEncoding = new String(filename1.getBytes("UTF-8"), "8859_1");
			response.setHeader("Content-Disposition", "attachment; filename = " + sEncoding);

			out2 = response.getOutputStream();
			int numRead;
			
			while((numRead = in.read(b, 0, b.length)) != -1)
			{
				out2.write(b, 0, numRead);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				out2.flush();
			}
			catch(Exception e)
			{
				
			}
			try
			{
				out2.close();
			}
			catch(Exception e)
			{
				
			}
			in.close();
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
</body>
</html>