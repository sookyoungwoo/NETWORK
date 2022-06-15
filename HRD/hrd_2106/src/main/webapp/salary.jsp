<%@page import="DBPKG.Util"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>salary</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<jsp:include page="header.jsp"/>

<section>
<h2 ><b>회원매출조회</b></h2><br>

<form name="frm">
	<table>
		<tr>
			<td>회원번호</td>
			<td>회원성명</td>
			<td>고객등급</td>
			<td>매출</td>
		</tr>
<%
request.setCharacterEncoding("UTF-8");
Connection conn = null;
Statement stmt = null;
String grade = "";
try {
	conn=Util.getConnection();//디비 연결
  	stmt=conn.createStatement();//sql 실행하기 위한 변수
	String sql = "select member.custno, member.custname, member.grade, sum(money.price) as price " +
				"from member_tbl_02 member, money_tbl_02 money " +
				"where member.custno = money.custno " + //머니와 멤버에서 고객번호가 같다면
				"group by member.custno, member.custname, member.grade " +
				"order by sum(money.price) desc";
	ResultSet rs = stmt.executeQuery(sql);
	
	while(rs.next()) {
		grade = rs.getString("grade");
		switch(grade) {
		case "A":
			grade = "VIP";
			break;
		case "B":
			grade = "일반";
			break;
		case "C":
			grade = "직원";
			break;
		}
%>
		<tr>
			<td><%=rs.getString("custno") %></td>
			<td><%=rs.getString("custname") %></td>
			<td><%=grade %></td>
			<td><%=rs.getString("price") %></td>
		</tr>
<%
	}
} catch(Exception e) {
	e.printStackTrace(); 
}
%>
	</table>
</form>

</section>

<jsp:include page="footer.jsp"/>
</body>
</html>