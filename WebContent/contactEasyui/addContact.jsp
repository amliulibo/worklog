<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	String action=(String)request.getAttribute("action");
	Integer id=(Integer)request.getAttribute("id");
	String name=(String)request.getAttribute("name");
	String code=(String)request.getAttribute("code");
	String content=(String)request.getAttribute("content");
	
	boolean isEdit= action!=null &&  action.equals("edit");
	
	String paramCode=request.getParameter("code");
	paramCode=paramCode==null?"":paramCode.trim();
%>


<html>
<head>

<title><%= isEdit?"修改":"新建" %></title>
<style type="text/css">
	body,td{font-size:12px;}
	.value{width:800px;}
	.content{width:800px;height:500px;}
</style>
</head>
<body>
	<form action="contactOperate.jsp" method="post">
	<input type="hidden" name="action" value=<%= isEdit?"save":"add" %> >
	<input type="hidden" name="id" value=<%= isEdit?id:""%> >
	
	<fieldset>
	<legend><%= isEdit?"修改联系人":"新建联系人" %></legend>
	<table align="left" width=100%>
		<tr>
			<td width=100px>行政区划编码</td>
			<td ><input class="value"  type="text" name="code" value= <%=isEdit? code:paramCode %>  ></td>
		</tr>
		<tr>
			<td>行政区划名称</td>
			<td><input class="value" type="text" name="name" value=<%= isEdit?name:"" %> ></td>
		</tr>
		<tr>
			<td>详细信息</td>
			<td><textarea name="content" class="content" ><%= isEdit?content:"" %></textarea></td>
		</tr>
		<tr>
		<td   align="center" colspan=2>
		<input type="submit" value="保存" >
		<input type="reset" value="重置">
	<!-- 	<a href="javascript:history.back(-1)">返回</a> -->
		<input type="button" onclick="javascript:history.back(-1);" value="返回">
		</td>
		</tr>
		
	</table>
	</fieldset>
</form>

</body>
</html>