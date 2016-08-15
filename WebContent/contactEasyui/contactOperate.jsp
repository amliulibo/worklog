<%@page import="java.util.List"%>
<%@page import="com.llb.work.dto.ContactsDTO"%>
<%@page import="com.llb.work.dao.ContactsDAO"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%!
public String forSQL(String sql){
	return sql.replace("'", "\\'");
}
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% 
request.setCharacterEncoding("UTF-8");
String id=request.getParameter("id");
String name=request.getParameter("name");
String code=request.getParameter("code");
String content=request.getParameter("content");

String action=request.getParameter("action");

if(action.equals("add"))
{
	String sql="";
	int rowCnt=0;
	List <ContactsDTO> list=ContactsDAO.select(sql);
	if(list.size()>0)
	{
		out.print("已经存在，是否修改");
	}else
	{
	
		ContactsDTO dto=new ContactsDTO();
		dto.setCode(code);
		dto.setName(name);
		dto.setContent(content);
		rowCnt=ContactsDAO.insert(dto);
	}
	
	
	out.println("<html><style>body{font-size:12px;line-height:25px;}</style><body>");
	out.println(rowCnt+"条记录添加");
	out.println("<a href='contactList.jsp'>返回人员列表</a>");
	out.println("<a href='addContact.jsp'>继续添加</a>");
	
			
}else if(action.equals("del"))
{
	String[] ids=request.getParameterValues("id");
	if(ids==null || ids.length==0)
	{
		out.println("没有选中行");
		return;
	}
	
	int rowCnt=ContactsDAO.delete(ids);
	
	out.println("<html><style>body{font-size:12px;line-height:25px;}</style><body>");
	out.println(rowCnt+"条记录删除");
	out.println("<a href='contactList.jsp'>返回人员列表</a>");

			

}
else if(action.equals("edit"))
{
	ContactsDTO dto= ContactsDAO.select(Integer.parseInt(id));

	try
	{
		
			request.setAttribute("id",dto.getId());
			request.setAttribute("name",  dto.getName());
			request.setAttribute("code", dto.getCode());
			request.setAttribute("content", dto.getContent());
			request.setAttribute("action", action);
			
			
			request.getRequestDispatcher("addContact.jsp").forward(request, response);//转到修改页面
		
		
	}catch(Exception e)
	{
		
		e.printStackTrace();
	}

			
		
}else if(action.equals("save"))
{
	ContactsDTO dto=new ContactsDTO();
	dto.setId(Integer.parseInt(id) );
	dto.setCode(code);
	dto.setName(name);
	dto.setContent(content);
	int rowCnt=ContactsDAO.update(dto);
	
	out.println("<html><style>body{font-size:12px;line-height:25px;}</style><body>");
	out.println(rowCnt+"条记录修改");
	out.println("<a href='contactList.jsp'>返回人员列表</a>");
		
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>contactOperate.jsp</title>
</head>
<body>

</body>
</html>