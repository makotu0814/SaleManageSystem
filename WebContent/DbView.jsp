<%@page import="jspdf.sample.AppException"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.NumberFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>データベース連携</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<div class="main">
		<h1>決算書・詳細</h1>
		<div class="contents">
			<%
			    String mConnStr = "jbdc:mysql/localhost/";
			    String url = "jdbc:mysql://localhost/dsample";
			    String user = "root";
			    String password = "fumiumi7";
			    Class.forName("com.mysql.jdbc.Driver").newInstance();
			    Connection mConn = DriverManager.getConnection(url, user, password);
			    String mSql = "select * from tinvoice where cid = ?";
			    PreparedStatement mPstmt = mConn.prepareStatement(mSql);
			    int mId = Integer.parseInt(request.getParameter("pId"));
			    mPstmt.setInt(1, mId);
			    ResultSet mRs = mPstmt.executeQuery();
			    if (!mRs.next()) {
			        mRs.close();
			        mPstmt.close();
			        throw new AppException("該当するレコードがありません");
			    }
			    String mClientName = mRs.getString("cClientName");
			    Date mDate = new Date(mRs.getLong("cDate"));
			    String mMemo = mRs.getString("cMemo");
			    int mEditSeq = mRs.getInt("cEditSeq");

			    int MAX_LINE = 5;
			    String[] mItems = new String[MAX_LINE];
			    int[] mPriceS = new int[MAX_LINE];
			    int[] mQtyS = new int[MAX_LINE];

			    mSql = "select * from tinvoiceitem where cInvoiceId=? order by cId";
			    mPstmt = mConn.prepareStatement(mSql);
			    mPstmt.setInt(1, mId);
			    mRs = mPstmt.executeQuery();

			    int i = 0;
			    while (mRs.next()) {
			        mItems[i] = mRs.getString("cDescription");
			        mPriceS[i] = mRs.getInt("cPrice");
			        mQtyS[i] = mRs.getInt("cQty");
			        i++;
			    }
			    mRs.close();
			    mPstmt.close();
			    mConn.close();
			    SimpleDateFormat mDf = new SimpleDateFormat("yyyy/MM/dd");
			    NumberFormat mNf = NumberFormat.getInstance();
			%>
			<table style="margin-left: auto; margin-right: auto;">
				<tr>
					<th style="width: 200px">番号</th>
					<th style="width: 300px"><%=mId%></th>
				</tr>
				<tr>
					<th>顧客名</th>
					<td><%=mClientName%></td>
				</tr>
				<tr>
					<th>日付</th>
					<td><%=mDf.format(mDate)%></td>
				</tr>
			</table>
			<table style="margin-left: auto; margin-right: auto;">
				<tr>
					<th style="width: 200px">品名</th>
					<th style="width: 100px">単価</th>
					<th style="width: 100px">数量</th>
					<th style="width: 100px">金額</th>
				</tr>
				<%
				    int mTotal = 0;
				    for (i = 0; i < MAX_LINE; i++) {
				%>
				<tr style="height: 20px;">
					<td><%=mItems[i] != null ? mItems[i] : ""%></td>
					<td style="text-align: right"><%=mPriceS[i] != 0 ? mNf.format(mPriceS[i]) : ""%></td>
					<td style="text-align: right"><%=mQtyS[i] != 0 ? mNf.format(mQtyS[i]) : ""%></td>
					<%
					    int bAmount = mPriceS[i] * mQtyS[i];
					        mTotal += bAmount;
					%>
					<td style="text-align: right;"><%=bAmount != 0 ? mNf.format(bAmount) : ""%></td>
				</tr>
				<%
				    }
				%>
				<tr>
					<th colspan="3">合計</th>
					<td style="text-align: right;"><%=mNf.format(mTotal)%></td>
				</tr>
				<tr>
					<th>備考</th>
					<td colspan="3"><%=mMemo%></td>
				</tr>
			</table>
			<div style="width: 500px; margin-left: auto; margin-right: auto;">
				<input type="button" value="編集"
					onclick="location.href='DbEdit.jsp?pId=<%=mId%>'">
				<%
				    if (mId != 0) {
				%>
				<input type="button" value="削除" onclick="funcDelete()">
				<%
				    }
				%>
				<input type="button" value="印刷"
					onclick="location.href='DbPrint.jsp?pId=<%=mId%>'">
				<input
					type="button" value="一覧"
					onclick="location.href='DbList.jsp'">
			</div>
			<script type="text/javascript">
				function funcDelete() {
					if (confirm("削除します。よろしいですか？")) {
						location.href = "DbDelete.jsp?pId=<%=mId%>&pEditSeq=<%=mEditSeq%>";
					}
				}
			
			</script>
		</div>
	</div>
</body>
</html>