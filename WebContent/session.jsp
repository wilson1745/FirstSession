<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.sessionTest.jsp.Person"%>
<jsp:directive.page import="java.text.SimpleDateFormat" />
<jsp:directive.page import="java.text.DateFormat" />
<jsp:directive.page import="java.util.Date" />
<%!DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");%>
<%
	response.setCharacterEncoding("UTF-8");

	Person[] persons = { 
			new Person("Liu Jinghua", "password1", 34, dateFormat.parse("1982-01-01")), 
			new Person("Hello Kitty", "hellokitty", 23, dateFormat.parse("1984-02-25")), 
			new Person("Garfield", "garfield_pass", 23, dateFormat.parse("1994-09-12")), 
			};

	String message = "";

	if (request.getMethod().equals("POST")) {

		for (Person person : persons) {
			// 如果 用戶名正確 且 密碼正確
			if (person.getName().equalsIgnoreCase(request.getParameter("username")) && person.getPassword().equals(request.getParameter("password"))) {

				// 登錄成功, 設置將使用者的資訊以及登錄時間保存到 Session
				session.setAttribute("person", person);
				session.setAttribute("loginTime", new Date());

				response.sendRedirect(request.getContextPath() + "/welcome.jsp");
				return;

			}
		}

		// 登錄失敗
		message = "用戶名密碼不匹配，登錄失敗。";
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>請先登錄</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
	<div align="center" style="margin: 10px;">
		<fieldset>
			<legend>登錄</legend>
			<form action="session.jsp" method="post">
				<table>
					<%
						if (!message.equals("")) {
					%>
					<tr>
						<td></td>
						<td><span><img src="images/errorstate.gif"></span> <span
							style="color: red;"><%=message%></span></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td>帳號：</td>
						<td><input type="text" name="username" style="width: 200px;">
						</td>
					</tr>
					<tr>
						<td>密碼：</td>
						<td><input type="password" name="password"
							style="width: 200px;"></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" value=" 登  錄 " class="button">
						</td>
					</tr>
				</table>
			</form>
		</fieldset>
	</div>

	Hello Kitty, hellokitty

</body>
</html>

