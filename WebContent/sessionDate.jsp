<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%> 

<%
	HttpSession session1 = request.getSession();
	session1.setAttribute("loginTime", new Date());
	
	out.println("登入時間：" + (Date)session.getAttribute("loginTime"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>

</body>
</html>