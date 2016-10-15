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


//新建联系人
var setNewHref = function()
{

	$("#addNew").attr("href","addContact.jsp?code="+$("#code").val());
}

function check()
{
	return true;
}

//提交表单
function SubmitForm()
{
	document.getElementById('form1').submit();
}

//修改
function EditForm()
{
	var selID=getSelID();
	if (selID==0) {
		$.messager.alert('提示',"请选择一行");
		return;
	}
	var editAddr="contactOperate.jsp?action=edit&id="+selID;
	
	window.location.href=editAddr;
}
//删除
function DelData()
{
	var selID=getSelID();
	if (selID==0) {
		alert("请选择一行");
		return;
	}
	
	if(!confirm("确定删除选中行？")) 
		return;
	
	//var delAddr="contactOperate.jsp?action=del&id="+selID;
	alert("del");
	//window.location.href=delAddr;
}

//新建联系人
function GoAddForm()
{
	window.location.href="addContact.jsp?code="+$("#code").val();	
}

//清空过滤条件
function clearFilter()
{
	
	/* $("input[type='text']").each(function(){	
		$(this).textbox("clear");
		//this.value="";
		
	
	}); */ 
	
	$("#code").textbox('setValue',"");
	//$("#name").textbox('setValue',"");
	$("#name").textbox('clear');
	$("#content").textbox('setValue',"");
	/* $("input[type='text']").each(function (i) {
		this.clear();
		this.setText("");
	}) */
	
	
}

function getSelID()
{
	var row = $('#table1').datagrid('getSelected');	
	if (row) {
		return row.id;
	}
	return 0;
}



</script>




</head>
<body>


<form id="form1" action="contactList.jsp" method="post" onsubmit="return check()">


<table id="table1" class="easyui-datagrid" title="contact list" style="width:100%;height:400px"
	data-options="singleSelect:true,collapsible:true,rownumbers:true
	,footer:'#footer1',toolbar:'#filter1',pagination:true">
	<!-- ,url:'datagrid_data1.json',method:'get',toolbar:toolbar1 --> 
	
	<thead>
		<tr >
			<th data-options="field:'a',width:40,checkbox:true">选择</th>
			<th data-options="field:'id',width:40">ID</th>
			<th data-options="field:'code',width:100,align:'left'">区划编码</th>
			<th data-options="field:'name',width:100">区划名称</th>
			<th data-options="field:'content',width:600,align:'left'">详细信息</th>
			
			<!-- <th data-options="field:'c',width:60">操作</th> -->
			
		
		</tr>
	</thead>
	<div id="filter1" style="padding:2px 5px;">
	
		行政区划编码: <input id="code" name="code"  class="easyui-textbox" style="width:110px">
		行政区划名称: <input id="name" name="name"   class="easyui-textbox" style="width:110px">
		内容:  <input id="content" name="content"   class="easyui-textbox" style="width:210px">
		
		<a href="#" class="easyui-linkbutton" iconCls="icon-search"  onclick="queryData(0,99999);">查询</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-clear" onclick="clearFilter();">清空</a>
	</div>
	<div id="footer1" style="padding:2px 5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="GoAddForm();"></a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="false" onclick="EditForm();" ></a>

		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true"  onclick="DelData();" ></a>
	</div>
	
	


</table>




</form>



	<script>
	
	

	//设置分页控件 注意：一定要放到$(function(){里面才会生效
	$(function(){
		var pager = $('#table1').datagrid().datagrid('getPager');
		pager.pagination({ 
		     pageSize: 10,//每页显示的记录条数，默认为10 
		    pageList: [5,10,15],//可以设置每页记录条数的列表 
		    beforePageText: '第',//页数文本框前显示的汉字 
		    afterPageText: '页    共 {pages} 页', 
		    displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录' ,  
		    onSelectPage: function (pageNumber, pageSize) {
                queryData(pageNumber, pageSize);//分页查询
            }
		    /*
		    onBeforeRefresh:function(){
		        $(this).pagination('loading');
		        alert('before refresh');
		        $(this).pagination('loaded');
		    }   */
		}); 
	});
    
		var queryData = function(pageNumber, pageSize){
			var pageStartIndex=0;
			if (pageNumber!=0) {
				pageStartIndex=(pageNumber-1)*pageSize;
			}
			
			
			$.ajax({
				url: "<%=request.getContextPath() %>/ajaxtest",
				type: 'get',
                dataType:'json',
                data:"code="+$("#code").val()+"&name="+$("#name").val()+"&content="+$("#content").val()+"&pageSize="+pageSize+"&pageStart="+pageStartIndex,
				success: function(data){
					//$.messager.alert('警告',data);
					//$("#panel1").html(data);
					//$("#panel1").linkbutton({"text":data});//OK
					//$("#ID1").text(data);//OK
					
					//var data1 = $.parseJSON(data);   //如果dataType为text,则需要jQuery转换
					$("#table1").datagrid("loadData",data);
				}
                
			});
		}
		
	</script>
</body>
</html>