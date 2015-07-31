<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>データベース連携</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<div class="main">
	<h1>計算書一覧</h1>
	<div class="contents">
		<table style="margin-left: auto; margint-right: auto;">
			<tr>
				<th style="width: 50px">番号</th>
				<th style="width: 200px">日付</th>
				<th style="width: 300px">顧客名</th>
				<th style="width: 50px">操作</th>
			</tr>
			<%
			    SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
			    String mConnStr = "jbdc:mysql/localhost/";
			    String url = "jdbc:mysql://localhost/dsample";
			    String user = "root";
			    String password = "fumiumi7";
			    Class.forName("com.mysql.jdbc.Driver").newInstance();
			    Connection con = DriverManager.getConnection(url, user, password);
			    Statement stmt = con.createStatement();
			    String sql = "select * from tinvoice";
			    ResultSet result = stmt.executeQuery(sql);
			    while (result.next()) {
			%><tr>
				<td><%=result.getInt("cId")%></td>
				<td><%=format.format(new Date(result.getLong("cDate")))%></td>
				<td><%=result.getString("cClientName")%></td>
				<td><a href="DbView.jsp?pId=<%=result.getInt("cId")%>">詳細</a></td>
			</tr>
			<%}
				result.close();
				stmt.close();
				con.close();
			 %><tr>
				<td colspan="4"><input type="button" value="新規" onclick="location.href='DbEdit.jsp?pId=0'"></td>
			</tr>
			</table>
			</div>
			</div>
</body>
</html>