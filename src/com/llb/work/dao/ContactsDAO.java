package com.llb.work.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.llb.util.DbManager;
import com.llb.work.dto.ContactsDTO;

public class ContactsDAO
{
	public static int insert(ContactsDTO dto) throws Exception{
		String sqlString="insert into t_contacts(code,name,content) values(?,?,?)";
		return DbManager.executeUpdate(sqlString,dto.getCode(),dto.getName(),dto.getContent());
	}
	public static int update(ContactsDTO dto) throws Exception{
		String sqlString="update t_contacts set code=?,name=?,content=? where id=?";
		return DbManager.executeUpdate(sqlString,dto.getCode(),dto.getName(),dto.getContent(),dto.getId());
	}
	
	public static int delete(int id) throws Exception{
		String sqlString="delete t_contacts  where id =?";
		return DbManager.executeUpdate(sqlString,id);
	}
	
	public static int delete(String[] ids) throws Exception
	{
		
		
		String condition="";
		for(int i=0;i<ids.length;i++)
		{
			if(i==0) condition=ids[i];
			else
				condition+=","+ids[i];
		}
		String sql="delete from t_contacts where id in("+condition+")";
		return DbManager.executeUpdate(sql);
		
		
		
	}
	
	public static ContactsDTO select(int id) throws Exception
	{
		String sqlString="select * from t_contacts where id=?";
		Connection cn=null;
		PreparedStatement preStmt=null;
		ResultSet rs=null;
		try
		{
			cn=DbManager.getConnection();
			preStmt=cn.prepareStatement(sqlString);
			preStmt.setInt(1, id);
			rs=preStmt.executeQuery();
			if(rs.next())
			{
				ContactsDTO contacts=new ContactsDTO();
				contacts.setId(id);
				contacts.setCode(rs.getString("code"));
				contacts.setName(rs.getString("name"));
				contacts.setContent(rs.getString("content"));
				return contacts;
			}else {
				return null;
			}
			
		} catch (Exception e)
		{
			// TODO: handle exception
		}finally{
			if(rs!=null) rs.close();
			if(preStmt!=null) preStmt.close();
			if(cn!=null) cn.close();
		}
		return null;
	}
	
	public static List<ContactsDTO> select(String filter) throws Exception
	{
		String sqlString="select * from t_contacts where 1=1 "+filter;
	
		ResultSet rs=null;
		List<ContactsDTO> list=new ArrayList<ContactsDTO>();
		try
		{
			
			rs=DbManager.executeQuery(sqlString);
			while(rs.next())
			{
				ContactsDTO contacts=new ContactsDTO();
				contacts.setId(rs.getInt("id"));
				contacts.setCode(rs.getString("code"));
				contacts.setName(rs.getString("name"));
				contacts.setContent(rs.getString("content"));
				list.add(contacts);
			}
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}finally{
			if(rs!=null) rs.close();
			
		}
		return list;
	}
	
	public static int getCount(String filterString) throws SQLException
	{
		String sqlString="select count(*) from t_contacts where 1=1 "+filterString;
		
		return DbManager.getCount(sqlString);
		
	}
	
	public static List<ContactsDTO> select(String filterString,int startRecord,int pageSize) throws Exception
	{
		
		String sqlString="select * from t_contacts where 1=1 "+filterString+ " limit ?,?";
		Connection cn=null;
		PreparedStatement preStmt=null;
		ResultSet rs=null;
		List<ContactsDTO> list=new ArrayList<ContactsDTO>();
		try
		{
			cn=DbManager.getConnection();
			preStmt=cn.prepareStatement(sqlString);
			DbManager.setParams(preStmt, startRecord,pageSize);
			rs=preStmt.executeQuery();
			while(rs.next())
			{
				ContactsDTO contacts=new ContactsDTO();
				contacts.setId(rs.getInt("id"));
				contacts.setCode(rs.getString("code"));
				contacts.setName(rs.getString("name"));
				contacts.setContent(rs.getString("content"));
				list.add(contacts);
			}
			
		} catch (Exception e)
		{
			e.printStackTrace();
		}finally{
			if(rs!=null) rs.close();
			if(preStmt!=null) preStmt.close();
			if(cn!=null) cn.close();
		}
		return list;
	}
	
}
