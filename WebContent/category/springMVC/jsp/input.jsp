<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>the second springMVC instance</title>
</head>
<body>

<%
String v1= this.getServletContext().getContextPath();
%>
<form name="helloWorld" action="<%=v1 %>/helloWorld.do" method="post">
	欢迎语
	<input type="text" name="msg" value=""/>
	<br>
	<input type="submit" name="method" value="insert"/>
	<br>
	<input type="submit" name="method" value="update"/>
	<br>
	<input type="submit" name="method" value="delete"/>
	
</form>

</body>
</html>