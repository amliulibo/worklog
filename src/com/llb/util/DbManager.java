package com.llb.util;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

import com.mysql.jdbc.Driver;


public class DbManager
{
	
	public static Connection getConnection() throws SQLException
	{	//获取默认数据库连接
		return getConnection("databaseWeb","root","");
	}
	
	public static Connection getConnection(String dbName, String userName,
			String password) throws SQLException
	{
		String urlString="jdbc:mysql://localhost:3306/"+dbName+"?useUnicode=true&characterEncoding=utf-8";
		DriverManager.registerDriver(new Driver());
		return DriverManager.getConnection(urlString, userName, password);
	}

	public static void setParams(PreparedStatement preStmt,Object... params) throws SQLException
	{
		if (params==null||params.length==0)
		{
			return;
		}
		for (int i = 1; i <= params.length; i++)
		{
			Object param=params[i-1];
			if (param==null)
			{
				preStmt.setNull(i, Types.NULL);
			}else if (param instanceof Integer)
			{
				preStmt.setInt(i, (Integer)param);
			}else if (param instanceof String)
			{
				preStmt.setString(i, (String)param);
			}else if(param instanceof Double)
			{
				preStmt.setDouble(i, (Double)param);
			}else if(param instanceof Long)
			{
				preStmt.setLong(i, (Long)param);
			}else if(param instanceof java.sql.Timestamp)
			{
				preStmt.setTimestamp(i, (java.sql.Timestamp)param);
			}else if(param instanceof Boolean)
			{
				preStmt.setBoolean(i, (Boolean)param);
			}else if(param instanceof Date)
			{
				preStmt.setDate(i, (Date)param);
			}
		}
		
	}

	public static int executeUpdate(String sql) throws SQLException
	{
		return executeUpdate(sql,new Object[]{});
	}
	
	public static ResultSet executeQuery(String sql) throws SQLException
	{
		Connection cn=null;
		Statement stmt=null;
		try
		{
			cn=getConnection();
			stmt=cn.createStatement();
			return stmt.executeQuery(sql);
			
		} finally
		{
			if(stmt!=null) stmt.close();
			if(cn!=null) cn.close();
		}
	}
	
	public static int executeUpdate(String sql,Object... params) throws SQLException
	{
		Connection cn=null;
		PreparedStatement preStmt=null;
		try
		{
			cn=getConnection();
			preStmt=cn.prepareStatement(sql);
			setParams(preStmt, params);
			return preStmt.executeUpdate();
			
		} finally
		{
			if(preStmt!=null) preStmt.close();
			if(cn!=null) cn.close();
		}
	}

	/*获取总数
	 * @param sql格式必须为select count(*) from ...
	 *@return 
	 *@throws SQLException
	 */
	public static int getCount(String sql) throws SQLException
	{
		Connection cn=null;
		Statement stmt=null;
		ResultSet rs=null;
		try
		{
			cn=getConnection();
			stmt=cn.createStatement();
			rs=stmt.executeQuery(sql);
			if (rs.next())
			{
				return rs.getInt(1);
			}else {
				return 0;
			}
			
		} finally
		{
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(cn!=null) cn.close();
		}
	}
	public static int getCountByTableName(String tableName) throws SQLException
	{
		String sql="select count(*) from "+tableName;
		return getCount(sql);
	}
}
