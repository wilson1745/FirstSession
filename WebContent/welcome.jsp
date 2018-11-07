<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.sessionTest.jsp.Person"%>
<jsp:directive.page import="java.text.SimpleDateFormat" />
<jsp:directive.page import="java.text.DateFormat" />
<jsp:directive.page import="java.util.Date" />
<%!DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");%>
<%
	if (session.getAttribute("person") == null) {
		response.sendRedirect("session.jsp");
		return;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>歡迎您, ${ person.name }</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
	<div align="center" style="margin: 10px;">
		<fieldset>
			<legend>歡迎您${ person.name }</legend>
			<table>
				<tr>
					<td>您的姓名：</td>
					<td>${ person.name }</td>
				</tr>
				<tr>
					<td>登錄時間：</td>
					<td>${ loginTime }</td>
				</tr>
				<tr>
					<td>您的年齡：</td>
					<td>${ person.age }</td>
				</tr>
				<tr>
					<td>您的生日：</td>
					<td>${ person.birthday }</td>
				</tr>
				<tr>
					<td></td>
					<td><input type="button" value=" 重新登錄 "
						onclick="location='session.jsp';" class="button"></td>
				</tr>
			</table>
		</fieldset>
	</div>

</body>
</html>

