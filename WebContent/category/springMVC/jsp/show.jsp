<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Iutf-8">
<title>the second springMVC instance</title>
</head>
<%
String srt=(String)request.getAttribute("helloWorld");
%>
<body>
	<form name="helloWorld" action="/helloWorld.do" method="post">
		你输入的欢迎语是"<%= srt %>"
	</form>
</body>
</html>