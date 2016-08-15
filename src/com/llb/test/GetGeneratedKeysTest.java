package com.llb.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.Driver;

public class GetGeneratedKeysTest
{
public static void main(String[] args) throws SQLException
{
	new Driver();//×¢²áÇý¶¯
	Connection cn=null;
	Statement stmt=null;
	ResultSet rs=null;
	try
	{
		cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/databaseWeb?characterEncoding=UTF-8","root","");
		stmt=cn.createStatement();
		stmt.executeUpdate("insert into tb_person(name,enblish_name,age,sex,birthday,description)"+
						"values('Name','English name','17','ÄÐ',current_date(),'')");
		rs=stmt.getGeneratedKeys();
		rs.next();
		System.out.println("id:"+rs.getInt(1));//output the value of column 1
		
		
		
	} finally
	{
		if (rs!=null)
		{
			rs.close();
		}
		if(stmt!=null) stmt.close();
		if(cn!=null) cn.close();
	}
}
}
