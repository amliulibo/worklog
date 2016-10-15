<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>login form</title>
</head>
<body>

<%
String projectRoot= this.getServletContext().getContextPath();
%>
<form name="user" action="<%=projectRoot %>/login.do" method="post">
	<spring:bind path="command.username">
	
	输入用户名：
	<input type="text" name="${ status.expression }" value="${status.value }"/>
	<br/>
	<font color="red"><b>${status.errorMessage }</b></font><br/>
	</spring:bind>
	<spring:bind path="command.password">
	输入密码：<input type="password" name="${status.expression}" value="${status.value }"/>
	<br>
		<font color="red"><b>${status.errorMessage }</b></font>
	</spring:bind>
	<spring:bind path="command.password2">
	确认密码：<input type="password" name="${status.expression}" value="${status.value }"/>
	<br>
		<font color="red"><b>${status.errorMessage }</b></font>
	</spring:bind>
	<input type="submit"  value="提交"/>
	
</form>

</body>
</html>