<%@page import="com.llb.work.dao.ContactsDAO" %>
<%@page import="com.llb.work.dto.ContactsDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.llb.util.Pagination"%>
<%@page import="com.llb.util.DbManager"%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="java.sql.DriverManager"%>

<%@ page language="java" contentType="text/html; charset=UTF-8 " pageEncoding="UTF-8"   %>
<jsp:directive.page import="java.sql.SQLException"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>联系人信息</title>
	<link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css">
<script type="text/javascript" src="../js/jquery.min.js" ></script>
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
<script type="text/javascript">
var setNewHref = function()
{

	$("#addNew").attr("href","addContact.jsp?code="+$("#code").val());
}

function check()
{
	return true;
}

function GoAddForm()
{
	window.location.href="addContact.jsp?code="+$("#code").val();	
}

function clearFilter()
{
	var str1="";
	$("input[type='text']").each(function(){	
		$(this).val("");
		//str1+=$(this).val();
	
	});
	//alert(str1);
}

</script>
</head>
<body>

<%
	final int pageSize=10;
	int pageNum=1,pageCount=1,recordCount=0;
	
	try{
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}catch(Exception e){}
	
	
	try{
		request.setCharacterEncoding("UTF-8");
		String whereClause="";
		
		String codeSearch= request.getParameter("code");
		
		
		String nameSearch=request.getParameter("name");
		
		
		String contentSearch=request.getParameter("content");
		//out.println(contentSearch);
		if(codeSearch!=null && codeSearch.trim().length()!=0){
			
			
			whereClause+=" and code like '%"+codeSearch+"%'";
		}
		if(nameSearch!=null && nameSearch.trim().length()!=0){
			
			//nameSearch=new String(nameSearch.getBytes("iso-8859-1"),"utf-8").trim();
			whereClause+=" and name like '%"+nameSearch+"%'";
		}
		if(contentSearch!=null && contentSearch.trim().length()!=0){
			//contentSearch=new String(contentSearch.getBytes("iso-8859-1"),"GBK").trim();
			out.println(contentSearch);
			whereClause+=" and content like '%"+contentSearch+"%'";
			
		}

		
		
		recordCount=ContactsDAO.getCount(whereClause);
		pageCount=(recordCount+pageSize-1)/pageSize;//计算总页数
		int startRecord=(pageNum-1)*pageSize;
		List<ContactsDTO> list=ContactsDAO.select(whereClause,startRecord,pageSize);
		
		
	
%>


<form name="form1" action="contactList.jsp" method="post" onsubmit="return check()">


<div class="easyui-panel" title="查询条件" style="width:100%">

	<table>
	<tr>
		<td style="text-align:right;">行政区划编码</td>
		<td style="text-align:left;">
			<input type="text" name="code"  id="code" value="${param.code}" >
		</td>

		<td class="label">行政区划名称</td>
		<td class="value"><input type="text" name="name" value="${param.name}"  ></td>
	
	
		<td class="label">内容</td>
		<td class="value"><input type="text" name="content" value="${param.content}"></td>
	
		<td >
			<!-- <input type="submit" value="查询" > 
			<input type="button" value="清空" onclick="clearFilter();"> -->
			<a href="javascript:form1.submit();" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px">查询</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="clearFilter()">清空</a>
		</td>
	</tr>
	</table>

</div>


<br>

<table bgcolor="#CCCCCC" cellspacing=1 cellpadding=5 width=100%>
<tr bgcolor=#DDDDDD>
	<th width=20px>选择</th>
	<th>#num</th>
	<th style="display:none;">ID</th>
	<th width=100px>区划编码</th>
	<th width=150px>区划名称</th>
	<th width=70%>详细信息</th>
	
	<th width=100px>操作</th>
</tr>
<%
//遍历结果集
int row=0;
for(ContactsDTO dto:list){
	

	int id=dto.getId();
	String code=dto.getCode();
	String name=dto.getName();
	String content=dto.getContent();
	
	
	out.println("<tr bgcolor=#FFFFFF>");
	out.println("	<td><input type=checkbox name=id value="+id+"></td>");
	out.println("	<td>"+ ++row +"</td>");
	out.println("	<td style='display:none;'>"+id+"</td>");
	out.println("	<td>"+code+"</td>");
	out.println("	<td>"+name+"</td>");
	out.println("	<td>"+content+"</td>");
	out.println("	<td>");
	out.println("	<a href='contactOperate.jsp?action=edit&id="+id+"'>修改</a>");
	out.println("	<a href='contactOperate.jsp?action=del&id="+id+"' onclick='return confirm(\"确定删除该记录?"
			+"\")'>删除</a>");
	
	out.println("	</td>");
	out.println("		</tr>");
}
%>
</table>

<table width="100%">
<tr width="100%">
	<td width="60%" text-align ="left">

		<input type="button"  value="新建联系人" onclick="GoAddForm()">
	</td>
	<td width="40%" align="right"> <!-- 输出上一页、下一页等 -->
	<%= Pagination.getPagination(pageNum, pageCount, recordCount, request.getRequestURI()) %>
	</td>
</tr>
</table>
<br>

<div class="easyui-panel">
		<div class="easyui-pagination" data-options="total:<%=recordCount %>"></div>
	</div>

</form>

<%
	}
	catch(SQLException e)
	{
		out.println("发生了异常："+e.getMessage());
		e.printStackTrace();
	}
	finally
	{
		
		
	}
%>

<table class="easyui-datagrid" title="Basic DataGrid" style="width:700px;height:250px"
			data-options="singleSelect:true,collapsible:true,url:'datagrid_data1.json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'itemid',width:80">Item ID</th>
				<th data-options="field:'productid',width:100">Product</th>
				<th data-options="field:'listprice',width:80,align:'right'">List Price</th>
				<th data-options="field:'unitcost',width:80,align:'right'">Unit Cost</th>
				<th data-options="field:'attr1',width:250">Attribute</th>
				<th data-options="field:'status',width:60,align:'center'">Status</th>
			</tr>
		</thead>
</table>

</body>
</html>